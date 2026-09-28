-- Gate 1 draft only. UNEXECUTED; reconcile with recovered SPEC before applying.
-- MySQL 8 / InnoDB / utf8mb4. All money uses integer minor units and ISO currency.
CREATE TABLE countries (
    code CHAR(2) CHARACTER SET ascii COLLATE ascii_bin PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    tax_rate_basis_points INT UNSIGNED NULL,
    CHECK (tax_rate_basis_points IS NULL OR tax_rate_basis_points <= 1000000)
) ENGINE=InnoDB;

CREATE TABLE merchants (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=InnoDB;

CREATE TABLE products (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    slug VARCHAR(191) NOT NULL UNIQUE,
    enabled BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=InnoDB;

CREATE TABLE networks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_key VARCHAR(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL UNIQUE,
    display_name VARCHAR(255) NOT NULL,
    source_family ENUM('affiliate_network','marketplace','retailer','comparison','travel') NOT NULL,
    connector_kind ENUM('catalog','live_search','both') NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    terms_reference_url VARCHAR(2048) NULL,
    reviewed_at DATETIME(6) NULL
) ENGINE=InnoDB;

CREATE TABLE network_regions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    network_id BIGINT UNSIGNED NOT NULL,
    country_code CHAR(2) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    program_key VARCHAR(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    external_network_id VARCHAR(191) NULL,
    default_currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    default_locale VARCHAR(35) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    allowed_currency_codes_json JSON NULL,
    allowed_locales_json JSON NULL,
    endpoint_url VARCHAR(2048) NULL,
    parameters_json JSON NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    catalog_ttl_seconds INT UNSIGNED NOT NULL DEFAULT 0,
    live_cache_allowed BOOLEAN NOT NULL DEFAULT FALSE,
    live_cache_ttl_seconds INT UNSIGNED NOT NULL DEFAULT 0,
    cache_permission_reference VARCHAR(2048) NULL,
    attribution_rule_json JSON NULL,
    display_rule_json JSON NULL,
    UNIQUE KEY uq_network_region (network_id, country_code, program_key),
    UNIQUE KEY uq_region_network_pair (id, network_id),
    KEY idx_region_country (country_code),
    CONSTRAINT fk_region_network FOREIGN KEY (network_id) REFERENCES networks(id),
    CONSTRAINT fk_region_country FOREIGN KEY (country_code) REFERENCES countries(code),
    CHECK (live_cache_allowed = FALSE OR (live_cache_ttl_seconds > 0 AND cache_permission_reference IS NOT NULL))
) ENGINE=InnoDB;

CREATE TABLE source_accounts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    network_id BIGINT UNSIGNED NOT NULL,
    network_region_id BIGINT UNSIGNED NULL,
    account_key VARCHAR(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    tenant_merchant_id BIGINT UNSIGNED NULL,
    credential_ciphertext VARBINARY(8192) NOT NULL,
    credential_key_reference VARCHAR(255) NOT NULL,
    credential_algorithm VARCHAR(50) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    rotated_at DATETIME(6) NULL,
    UNIQUE KEY uq_source_account (network_id, account_key),
    KEY idx_account_region (network_region_id),
    CONSTRAINT fk_account_network FOREIGN KEY (network_id) REFERENCES networks(id),
    CONSTRAINT fk_account_region_network FOREIGN KEY (network_region_id, network_id) REFERENCES network_regions(id, network_id),
    CONSTRAINT fk_account_merchant FOREIGN KEY (tenant_merchant_id) REFERENCES merchants(id)
) ENGINE=InnoDB;

CREATE TABLE product_offers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    network_region_id BIGINT UNSIGNED NOT NULL,
    external_id VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    product_id BIGINT UNSIGNED NULL,
    merchant_id BIGINT UNSIGNED NULL,
    title VARCHAR(500) NOT NULL,
    UNIQUE KEY uq_region_external_offer (network_region_id, external_id),
    KEY idx_offer_product (product_id),
    KEY idx_offer_merchant (merchant_id),
    CONSTRAINT fk_offer_region FOREIGN KEY (network_region_id) REFERENCES network_regions(id),
    CONSTRAINT fk_offer_product FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_offer_merchant FOREIGN KEY (merchant_id) REFERENCES merchants(id)
) ENGINE=InnoDB;

-- A source's external ID stays canonical while account-specific terms stay separate.
CREATE TABLE product_offer_accounts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_offer_id BIGINT UNSIGNED NOT NULL,
    source_account_id BIGINT UNSIGNED NOT NULL,
    outbound_url VARCHAR(2048) NOT NULL,
    price_minor BIGINT UNSIGNED NOT NULL,
    currency_code CHAR(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    availability VARCHAR(50) NULL,
    observed_at DATETIME(6) NOT NULL,
    expires_at DATETIME(6) NULL,
    source_payload_hash BINARY(32) NULL,
    UNIQUE KEY uq_offer_account (product_offer_id, source_account_id),
    UNIQUE KEY uq_account_offer_identity (id, source_account_id),
    KEY idx_offer_account_price (product_offer_id, price_minor),
    CONSTRAINT fk_account_offer_offer FOREIGN KEY (product_offer_id) REFERENCES product_offers(id),
    CONSTRAINT fk_account_offer_account FOREIGN KEY (source_account_id) REFERENCES source_accounts(id)
) ENGINE=InnoDB;

-- Application must enforce account/offer same-network and allowed-region membership,
-- permitted currency/locale, endpoint allowlists and tenant ownership transactionally.
