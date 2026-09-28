# Price comparison platform

Planning a PHP/MySQL platform for retail price comparison and live travel search.

## Current status

Pre-implementation research and architecture review based on the supplied Astra Orchestra prompt pack. The referenced `SPEC.docx` / `web_features_final.docx` has not yet been supplied, so requirements coverage is provisional. No working application or production integrations are claimed.

Project deliverables belong under `pricecomp/`. The prompt pack requires a Gate 1 owner review before foundation and feature implementation.

- [Provisional Gate 1 review](pricecomp/docs/review-gate-1.md)
- [Orchestrator and subagent roster](pricecomp/docs/orchestration.md)
- [Requirements register](pricecomp/docs/requirements.csv)
- [Provider research](pricecomp/docs/networks.csv)
- [Architecture blueprint](pricecomp/docs/architecture/overview.md)
- [Implementation plan](pricecomp/tasks/plan.md)

The draft PHP contracts and SQL schema are design artifacts. PHP, Composer and MySQL were not available in the preparation environment; no application test suite or database migration was executed. The blueprint requires review and reconciliation with the original specification before implementation.
