-- Gate 1 draft only. UNEXECUTED; no billing rules are assumed here.
CREATE TABLE travel_searches (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    search_hash BINARY(32) NOT NULL,
    vertical_key VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    network_region_id BIGINT UNSIGNED NOT NULL,
    source_account_id BIGINT UNSIGNED NOT NULL,
    context_json JSON NOT NULL,
    -- Context: dates, locations, traveller counts/ages, locale, currency;
    -- never traveller names, contact details or payment credentials.
    requested_at DATETIME(6) NOT NULL,
    CONSTRAINT fk_search_region FOREIGN KEY (network_region_id) REFERENCES network_regions(id),
    CONSTRAINT fk_search_account FOREIGN KEY (source_account_id) REFERENCES source_accounts(id),
    KEY idx_search_hash_time (search_hash, requested_at)
) ENGINE=InnoDB;

CREATE TABLE live_offer_cache (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    travel_search_id BIGINT UNSIGNED NOT NULL,
    network_region_id BIGINT UNSIGNED NOT NULL,
    external_id VARCHAR(191) NOT NULL,
    offer_json JSON NOT NULL,
    outbound_url VARCHAR(2048) NOT NULL,
    amount_minor BIGINT UNSIGNED NOT NULL,
    currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    observed_at DATETIME(6) NOT NULL,
    expires_at DATETIME(6) NOT NULL,
    UNIQUE KEY uq_search_live_offer (travel_search_id, external_id),
    KEY idx_live_expiry (expires_at),
    CONSTRAINT fk_live_search FOREIGN KEY (travel_search_id) REFERENCES travel_searches(id),
    CONSTRAINT fk_live_region FOREIGN KEY (network_region_id) REFERENCES network_regions(id),
    CHECK (expires_at > observed_at)
) ENGINE=InnoDB;

CREATE TABLE click_events (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    event_key VARCHAR(191) CHARACTER SET ascii COLLATE ascii_bin NOT NULL UNIQUE,
    retail_account_offer_id BIGINT UNSIGNED NULL,
    source_account_id BIGINT UNSIGNED NOT NULL,
    tenant_merchant_id BIGINT UNSIGNED NULL,
    travel_search_hash BINARY(32) NULL,
    live_offer_ref_hash BINARY(32) NULL,
    merchant_id BIGINT UNSIGNED NULL,
    affiliate_id BIGINT UNSIGNED NULL,
    network_region_id BIGINT UNSIGNED NOT NULL,
    clicked_at DATETIME(6) NOT NULL,
    displayed_price_minor BIGINT UNSIGNED NOT NULL,
    displayed_currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    charge_basis_minor BIGINT UNSIGNED NULL,
    charge_basis_currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NULL,
    charge_policy_key VARCHAR(100) NULL,
    charge_policy_version VARCHAR(50) NULL,
    attribution_json JSON NULL,
    CONSTRAINT fk_click_retail_account FOREIGN KEY (retail_account_offer_id, source_account_id) REFERENCES product_offer_accounts(id, source_account_id),
    CONSTRAINT fk_click_source_account FOREIGN KEY (source_account_id) REFERENCES source_accounts(id),
    CONSTRAINT fk_click_tenant FOREIGN KEY (tenant_merchant_id) REFERENCES merchants(id),
    CONSTRAINT fk_click_merchant FOREIGN KEY (merchant_id) REFERENCES merchants(id),
    CONSTRAINT fk_click_region FOREIGN KEY (network_region_id) REFERENCES network_regions(id),
    CHECK ((retail_account_offer_id IS NOT NULL) + (live_offer_ref_hash IS NOT NULL) = 1),
    CHECK (live_offer_ref_hash IS NULL OR travel_search_hash IS NOT NULL),
    CHECK (retail_account_offer_id IS NULL OR travel_search_hash IS NULL),
    CHECK ((charge_basis_minor IS NULL) = (charge_basis_currency_code IS NULL)),
    CHECK ((charge_policy_key IS NULL) = (charge_policy_version IS NULL)),
    KEY idx_click_merchant_time (merchant_id, clicked_at)
) ENGINE=InnoDB;

CREATE TABLE money_ledger (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    business_key VARCHAR(191) CHARACTER SET ascii COLLATE ascii_bin NOT NULL UNIQUE,
    click_event_id BIGINT UNSIGNED NULL,
    merchant_id BIGINT UNSIGNED NULL,
    affiliate_id BIGINT UNSIGNED NULL,
    entry_type ENUM('click_charge','subscription','package','affiliate_commission','refund','adjustment') NOT NULL,
    amount_minor BIGINT NOT NULL,
    currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    basis_minor BIGINT UNSIGNED NULL,
    basis_currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NULL,
    rate_numerator BIGINT UNSIGNED NULL,
    rate_denominator BIGINT UNSIGNED NULL,
    policy_key VARCHAR(100) NULL,
    policy_version VARCHAR(50) NULL,
    state ENUM('pending','approved','posted','reversed') NOT NULL,
    occurred_at DATETIME(6) NOT NULL,
    approved_at DATETIME(6) NULL,
    metadata_json JSON NULL,
    CONSTRAINT fk_ledger_click FOREIGN KEY (click_event_id) REFERENCES click_events(id),
    CONSTRAINT fk_ledger_merchant FOREIGN KEY (merchant_id) REFERENCES merchants(id),
    CHECK ((basis_minor IS NULL) = (basis_currency_code IS NULL)),
    CHECK ((rate_numerator IS NULL) = (rate_denominator IS NULL)),
    CHECK (rate_denominator IS NULL OR rate_denominator > 0),
    CHECK ((policy_key IS NULL) = (policy_version IS NULL)),
    KEY idx_ledger_merchant_time (merchant_id, occurred_at),
    KEY idx_ledger_affiliate_time (affiliate_id, occurred_at)
) ENGINE=InnoDB;

-- `affiliate_id` awaits identity schema; add an FK in the secure identity range.
-- Insert clicks before redirect; ledger writes use unique intent-derived business keys.
-- Do not create live_offer_cache rows unless explicit provider permission is recorded.
-- A live click stores only hashes of the search and provider offer reference; no cache FK
-- or provider result payload is retained. Optional cache rows can expire independently.
-- The selected retail account-offer, source account and owning tenant are snapshotted on
-- click. Keep source-account tenant ownership immutable; authorize merchant reads by tenant.
-- Displayed price is distinct from charge basis; posted charge/commission amounts and
-- exact rate/policy snapshots live in money_ledger. Null means no rule was configured.
