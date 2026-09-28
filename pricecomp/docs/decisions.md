# Provisional decisions

These decisions are grounded in the supplied Astra Orchestra prompt pack. Where the original SPEC.docx is needed to validate detail, that uncertainty remains open.

| Decision | Basis in pack | Status |
|---|---|---|
| Treat the product as one PHP/MySQL application with five areas: front end, admin, merchant, affiliate and member. | Master prompt defaults and “Known spec problems” explicitly correct the source’s “four panels” wording. | Owner clarification; provisional until source review |
| Use PHP 8.3, MySQL 8, Composer, PSR-4, PHP templates, no SPA, table-less responsive markup, Manticore/Sphinx search, CLI cron and PHPUnit as working defaults. | Master prompt “Defaults”; Manticore is preferred if drop-in compatible. | Defaults; confirm against source and environment |
| Keep merchant area and front-end reports behind feature flags. | Master prompt “Defaults”. | Explicit |
| Model source integrations as one connector per provider/source and country-region profiles as data/configuration. | Connector scope and owner clarifications; architect section. | Explicit |
| Keep retail/catalog connectors distinct from live-search connectors for travel. Travel searches include date, traveller and location context and use brief caching governed by provider rules. | Connector scope, architect section and “Known spec problems”. | Explicit; per-provider rules require research |
| Cover three source families: affiliate networks; direct marketplace/retailer/comparison APIs; travel APIs. Report verified count instead of forcing the count to 50. | Connector scope and “Known spec problems”. | Explicit; inventory unverified |
| Treat the 27-country union as an expectation to investigate, not as a confirmed list. | Connector scope calls out inferred Germany/Romania flags and possible extra coverage. | Open pending research |
| Require hosted checkout flows; never store card data. Store money as integer minor units with an explicit currency; verify payment notifications by signature. | “Known spec problems” and secure_builder role. | Explicit pack security requirements |
| Apply consent and unsubscribe handling to geo and price-alert email features. | “Known spec problems”. | Explicit; detailed consent rules open |
| Do not assume obsolete or named services are active. Verify service status and access before planning a working connector. | “Known spec problems” and service_researcher role. | Explicit |
| Exclude vendor marketing statements from owner requirements. | “Known spec problems”. | Explicit |
| Do not invent gateway or shopping-cart names, source requirements, countries, travel verticals, or exact panel behavior absent from provided material. | The pack directs research on gateway/cart names from SPEC, but SPEC is missing; “other” verticals require owner confirmation. | Required limitation |

## Open decisions for Gate 1

- Recover the original SPEC.docx to validate exact requirements, source locations, duplicate semantics, and intended priorities.
- Research the complete payment gateway and shopping-cart list after reading the source. The pack flags Google Checkout as potentially obsolete but supplies no complete gateway/cart list.
- Confirm researched source inventory, source-country union and whether it lands near the expected 50 APIs / 27 countries.
- Confirm which proposed “other” travel verticals to include.
- Confirm research findings and architecture before authorizing Phase 2 implementation.
