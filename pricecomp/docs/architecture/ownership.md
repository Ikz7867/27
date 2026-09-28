# Phase ownership and migration allocation

Only the orchestrator/architect edits shared contracts, `composer.json`, route registry, application config, language master, and migration index. Builders own disjoint directories and propose contract/schema changes back to that owner. Do not infer a working feature from a migration draft.

| Owner | Source paths after Gate 1 | SQL numbers | Scope |
|---|---|---:|---|
| Architect | `src/Contracts/`, `src/Http/Router/`, `config/`, `composer.json`, `docs/architecture/` | 0000–0099 | Shared boundaries and registries |
| Secure builder: identity | `src/Auth/`, `src/Http/Admin/Auth/` | 0100–0199 | Users, sessions, permissions, login defense |
| Catalog builder | `src/Catalog/`, catalog templates | 0200–0299 | Merchants, products, categories, offers presentation |
| Feed builder | `src/Feeds/` | 0300–0399 | Streaming import, mappings, run/error records |
| Secure builder: money | `src/Payments/`, `src/Ledger/` | 0400–0499 | Hosted checkout, webhooks, charges/commissions |
| Panel builders | `src/Http/Merchant/`, `src/Http/Affiliate/`, `src/Http/Member/` | 0500–0599 | Tenant-scoped panels and member data |
| Front end, SEO, reports | `src/Http/Frontend/`, `src/Seo/`, `src/Reports/` | 0600–0699 | Discovery, presentation, SEO, reporting |
| Travel builder | `src/Travel/` | 0700–0799 | Live search, allowed cache and click flow |
| Connector builders | `src/Connectors/<Source>/` | 0800–0899 | One provider per directory; region profiles in data |
| Crawler/plugins/notification | `src/Crawler/`, `src/Cart/`, `src/Notification/` | 0900–0999 | Approved crawl, cart export, alerts/email |

Draft `0001_core.sql` contains only shared source/region/account/offer entities and minimal referenced catalog identities. Draft `0002_live_ledger.sql` contains common travel search and click/ledger identities; both are in the architect range and may be split/replaced after source-spec reconciliation. Builders must use later ranges for additive migrations; never rewrite an applied migration.

`tests/integration/` and `tests/e2e/` belong to the test writer after features exist. `docs/requirements.csv`, research inventories and decisions belong to the orchestrator/analyst. No agent should edit another owner's files in parallel. The route/config/language registries have one merge owner to prevent hidden coupling.
