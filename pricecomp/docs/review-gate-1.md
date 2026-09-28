# Gate 1 review packet — provisional

This is a provisional review packet assembled on 2026-09-28 from the supplied prompt pack, official-source research and a draft architecture. It is not a final Gate 1 completion claim: the original SPEC.docx is absent and provider access/country research has unresolved gaps. Requirements counts describe the pack-derived register only. No application or connector is implemented.

## Requirements register counts

| Area | Must | Should | Total |
|---|---:|---:|---:|
| Admin | 4 | 2 | 6 |
| Affiliate | 1 | 0 | 1 |
| Crawler | 0 | 1 | 1 |
| Feeds | 6 | 0 | 6 |
| Front end | 4 | 1 | 5 |
| Member | 0 | 1 | 1 |
| Merchant | 2 | 0 | 2 |
| Payments | 3 | 0 | 3 |
| Platform | 8 | 1 | 9 |
| Plugins | 0 | 1 | 1 |
| SEO | 0 | 2 | 2 |
| **Total** | **28** | **9** | **37** |

| Provisional priority | Count |
|---|---:|
| Must | 28 |
| Should | 9 |

Counts should be regenerated after recovering and reconciling the source document.

## Current proposed build order

1. Recover and inspect SPEC.docx; reconcile requirements, duplicate bullets, panel scope, gateways and carts.
2. Complete official-source research of affiliate networks, marketplaces/comparison sources and travel providers, including access and regional rules.
3. Reconcile the final register and service inventory; architect the module/schema/interfaces and path ownership.
4. Stop at Gate 1 for owner review.
5. After approval: foundation (auth/RBAC, i18n, currencies/countries/tax/settings), then catalog/feed/SEO, payment and account panels/crawler, retail/member/reporting surfaces, verified connectors, then confirmed travel verticals and plugins.
6. Verify through integration/e2e checks, security review, traceability audit and clean installation; document remaining deferrals.

## Research references and limits

The consolidated [source inventory](networks.csv) contains 41 named source candidates, not 41 usable APIs. The raw research has 44 rows: it additionally records Booking attractions as a capability of Booking Demand, and two unnamed parking/cruise proposals. Those three are excluded from the connector count.

| Group | Named candidates | Evidence and limitations |
|---|---:|---|
| Affiliate networks | 28 | Homepage brand inventory; direct feed/API or format evidence researched for 11; remaining direct API details and current regional programs unresolved. |
| Marketplaces/comparison | 8 | Four documented interfaces (Amazon, eBay, Kelkoo, SHOP.COM); Shopello, Shopping.com, Shopzilla and Nextag unverified. |
| Travel | 5 | Four documented provider APIs (Expedia Rapid, Booking Demand, Skyscanner, Amadeus); direct Hotels.com API unverified. Access is conditional and affiliate commercial models differ. |
| **Total** | **41** | **Nine below the approximate 50 target; no padding and no operational integrations claimed.** |

Integration families are streaming feed downloads, request-based catalog APIs (including GraphQL/SOAP), and contextual live search. One connector serves a source's countries through profiles; endpoint/token region, program or tracking ID, language, currency and provider rules vary. Do not infer a uniform API or granted access from a source's retail presence.

The [verified region inventory](regions.csv) contains 22 documented Amazon marketplace profiles: AE, AU, BE, BR, CA, DE, EG, ES, FR, GB, IE, IN, IT, JP, MX, NL, PL, SA, SE, SG, TR, US. GB normalizes Amazon's UK label. This is a documented subset, not the final union or an assertion of account approval. Historical Datafeedr examples and dynamic travel contexts remain in research files and are excluded from the count. The pack's expected 27-country union remains unverified.

Evidence and detailed limits:

- [Datafeedr homepage](https://www.datafeedr.com/) names 28 network brands while also claiming 40 networks; these figures are not reconciled to currently active publisher programs.
- [Datafeedr API documentation](https://datafeedr.github.io/datafeedr-api-docs/) documents its API surface, but sample data is not a current service inventory.
- [Amazon Creators API marketplace reference](https://affiliate-program.amazon.com/creatorsapi/docs/en-us/concepts/common-request-headers-and-parameters) documents the 22 marketplace profiles and marketplace-specific tracking tags.
- [Booking.com Demand API](https://developers.booking.com/demand/docs/open-api/3.2/demand-api) and [Skyscanner partner API overview](https://developers.skyscanner.net/docs/intro) describe candidate live travel APIs with access conditions.
- [Expedia Group Rapid lodging](https://developers.expediagroup.com/rapid/lodging) is a contracted lodging integration; direct Hotels.com access and package flight combinations remain unverified.

Gateway and shopping-cart names/status cannot be established without SPEC.docx. The current notes report some marketplace APIs as unverified, provider approval requirements for travel, and incomplete country matrices. No final “about 50 APIs” or 27-country claim is made here.

The pack mentions Google Checkout as potentially obsolete; its status has not been verified in this pass and it is not selected for implementation. See [affiliate findings](research/affiliate-findings.md) and [market/travel findings](research/market-travel-findings.md) for per-source evidence and unknowns. Provider ownership, pagination, rate limits and retention/display rules are not fully researched for every row; each connector must resolve these before it can be called working.

## Architecture and decisions

Read the [15-line architecture summary](architecture/overview.md), [path ownership](architecture/ownership.md), [feature flags](architecture/feature_flags.md), and [decision log](decisions.md). Contracts and SQL are draft design artifacts, not tested application components. Principal decisions: five areas; one connector per source; country profiles as data; live travel separate from imported retail catalogs; hosted payments only; integer money with explicit currency; no live-result caching until permission is documented; optional travel stays disabled until confirmed.

First connector selection remains conditional: AWIN is a candidate, but its claimed country count is not verified as the largest. Select the source with the largest evidenced usable country-program set once credentials and coverage are established, then prove at least two regions before adding more connectors.

## Proposed “other” travel vertical

Propose activities/attractions as an optional candidate for owner confirmation, subject to provider access and official policy research. Airport parking and cruises remain unverified proposals. No “other” vertical is approved or included in a final count.

## Open Gate 1 items

- Recover SPEC.docx and reconcile all exact requirements and source locations.
- Resolve outstanding provider access, country matrices, pagination/rate limits and reuse/display rules; reconcile the draft blueprint with the source spec.
- Confirm optional travel verticals and review the complete build order and architecture before authorizing implementation.
