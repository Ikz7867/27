# Provisional architecture blueprint (Gate 1)

The original `SPEC.docx` is unavailable. This design maps the pack-derived `docs/requirements.csv`; all schema and contracts below are drafts, unexecuted and subject to reconciliation before Phase 2.

## Fifteen-line architecture summary

1. One PHP 8.3, MySQL 8 application serves five areas: front end, admin, merchant, affiliate and member.
2. Composer autoloads `PriceComp\` from `src/`; server-rendered PHP templates produce responsive pages.
3. The HTTP front controller dispatches through a centrally owned route registry.
4. Authentication establishes a principal and role; every protected route checks its required capability.
5. Merchant and affiliate queries are scoped by their own tenant ID, including indirect IDs.
6. Form writes require CSRF protection; output is escaped and database writes use prepared statements.
7. Catalog stores canonical products and source offers separately from account-specific price/link terms.
8. One source connector serves all its permitted country programs through `network_regions` profiles.
9. Credentials remain encrypted ciphertext plus key reference in `source_accounts`.
10. Feed imports upsert canonical `(network_region_id, external_id)` and then account-specific terms.
11. Travel uses contextual live search, not catalog feed import.
12. Travel results enter cache only when written provider permission and a bounded TTL are configured.
13. Retail and travel click-throughs create one click event before external redirect.
14. Monetary events use integer minor units and explicit ISO currency; hosted checkout handles payments.
15. CLI cron processes imports, allowed crawls, alerts, cache expiry and search-index synchronization.

## Module and requirement map

| Module | Requirements | Boundary |
|---|---|---|
| Platform, installation, shared config | 001–003, 006–008, 035–037 | HTTP kernel, settings, countries, currencies, i18n, feature flags, install/ops documentation |
| Identity and panels | 004–005, 009–010, 022–023, 027 | Authentication, RBAC, tenant scoping, admin/merchant/affiliate/member areas |
| Catalog and feeds | 011–016, 030–031 | Product, merchant, offer, source regions/accounts, parser/import jobs |
| SEO and discovery | 017–018, 025–028 | Server templates, content URLs, search, engagement, reports |
| Payments and ledger | 019–021, 034 | Hosted checkout, verified webhooks, click/charge/commission ledger |
| Crawler and plugins | 024, 029 | Bounded crawler and named cart exporters only after SPEC recovery |
| Live travel | 032–033 | Contextual query, provider-permitted cache, attributed click redirect |

The ranges cover every current register ID; coverage here is architectural allocation, not implemented or source-spec verified functionality.

Canonical offer identity requires a verified source ID scope. If a provider's external IDs are account-local, the connector must namespace the canonical external ID with a stable account scope before upserting `(network_region_id, external_id)`. Test two accounts with colliding raw IDs; never silently assume region-wide uniqueness. Account-dependent offer terms remain separate even when canonical IDs are shared.

## Request flow

`HTTP → router → authentication/capability and tenant check → CSRF/input validation → service → repository/connector → escaped template or redirect`. Login and public search have IP and account throttles. Connector requests use approved destination hosts, DNS/IP checks on every redirect, short timeouts, response-size caps and source-specific rate budgets. External response data is validated before persistence or rendering. Source and merchant URLs are normalized and checked again at redirect time. Webhooks first verify provider signature over raw bytes, then atomically claim the provider event ID, then update payment and ledger state; duplicate or ambiguous attempts do not create charges.

`product_offers` keeps the required unique `(network_region_id, external_id)` identity. `product_offer_accounts` holds price, outbound URL and freshness per source account, so one tenant's feed cannot overwrite another's terms. Reads filter by immutable `source_accounts.tenant_merchant_id`; a retail click references the selected account-offer and copies account/tenant IDs for audit. Live clicks also carry account/tenant IDs and only hashed offer/search references. A click records the displayed price/currency separately from the charge basis and the selected policy key/version. No rate or charge is invented when rules are unknown. Each actual merchant charge or affiliate commission is a separate ledger entry with its own amount, currency, basis, exact rational rate when applicable, and policy version. Entries and clicks are append-only after commit; corrections use reversal entries.

A non-cacheable live result reaches click-through with a short-lived authenticated redirect token containing only the approved target and offer reference; the redirect handler checks token expiry, provider access and destination host before writing the click and redirecting. It persists no provider payload. Cache rows have no click/ledger foreign keys and may expire independently. Provider-specific token lifetime and audit retention must be confirmed before activation. Exact rates and billing triggers await the source spec.

## CLI jobs, cache and search

CLI commands will use database-backed leases and idempotent job keys. Planned jobs: feed import/reconciliation; licensed catalog refresh; provider-permitted crawler; price-alert evaluation with consent/unsubscribe enforcement; email/newsletter dispatch; search index update; cache expiry and event retention. A job is installed only with its module after Gate 1.

Catalog cache keys include source, region, account and query version; TTL is the stricter of provider terms and local freshness policy. Live travel keys additionally include vertical, locations, dates, travellers, locale and currency. The default live-cache policy is **deny** (`cache_allowed=0`, TTL 0) until explicit provider permission is recorded; no speculative shared or persistent result cache. Expired live offers cannot be redirected without provider-required refresh. Search index contains public, enabled retail products and non-sensitive searchable fields; MySQL remains the source of truth. Manticore is the preferred Sphinx-compatible adapter once an environment check confirms compatibility; fallback SQL search can support installation, with a documented capability limit.

Region currency/locale fields are defaults, not universal restrictions. A request may use another value only when that profile's verified allowed-currency/locale list includes it; an unknown list permits only the default. The live connector must reject a response priced in a different currency from the request unless a separately reviewed conversion layer converts it with an explicit rate and timestamp. Provider capability and user display currency are never inferred from country alone.

Contract errors follow one rule: invalid caller input fails validation before entry; unavailable/unauthorized provider access and malformed provider responses throw typed integration failures (to be finalized with the application exception hierarchy after Gate 1). No connector silently returns an empty success for an unsupported region or method.

## Open design decisions

Exact provider access, cache/display terms, country union, payment gateways, cart targets, travel verticals beyond confirmed paths, billing formulas and tax source-location semantics remain Gate 1 decisions. `attraction` is a research proposal and is disabled pending approval; the schema uses a vertical key so no unapproved value is implied active. No provider is represented as operational by this blueprint. See `docs/research/*` and `docs/spec_defects.md`.
