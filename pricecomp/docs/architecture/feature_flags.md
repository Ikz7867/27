# Provisional feature controls

Flags default off for any integration requiring unavailable credentials, provider approval, or unverified terms. Flags are configuration values with an audit trail; no flag bypasses capability checks or provider terms.

| Key | Proposed default | Effect / gate |
|---|---|---|
| `MERCHANT_AREA_ENABLED` | off | Routes and navigation for merchant panel; still requires merchant capability and tenant match. |
| `FRONTEND_REPORTS_ENABLED` | off | Public-facing reporting views only; internal reporting permissions remain separate. |
| `APPLY_TAX_RATES_ON_SOURCE_LOCATION` | off | Pending exact tax semantics in SPEC; must not silently alter stored source prices. |
| `TRAVEL_LIVE_SEARCH_ENABLED` | off | Travel forms/results only for an approved provider and vertical. |
| `PROVIDER_RESULT_CACHE_ENABLED` | off | Additional per-provider written permission, expiry and TTL are mandatory. |
| `CRAWLER_ENABLED` | off | Requires approved target and robots, SSRF and rate-limit policy. |
| `PRICE_ALERTS_ENABLED` | off | Requires opt-in, unsubscribe, provider reuse permission and verified email sender. |
| `NEWSLETTER_ENABLED` | off | Requires consent and unsubscribe implementation. |
| `FACEBOOK_LOGIN_ENABLED` | off | Requires OAuth app registration and configured callback/secret. |
| `CART_EXPORT_ENABLED` | off | Requires cart targets from recovered SPEC and format validation. |
| `PAYMENTS_ENABLED` | off | Requires named gateway, hosted flow, signature verification and reconciled billing rules. |

Provider/region activation is separate data (`networks.enabled`, `network_regions.enabled`, `source_accounts.enabled`). A global flag never implies a provider is approved in every country.
