# Affiliate network research

**Verification date:** 2026-09-28. Read-only research of official Datafeedr and network documentation.

## Count and coverage finding

Datafeedr's current public homepage enumerates 28 named affiliate network brands (rows in `networks-affiliate.csv`) while also claiming “40 affiliate networks.” These are different claims: the 28 brands are directly visible as named homepage entries; 40 is Datafeedr's own broader marketing total and is not independently reconciled. The `/networks` page describes a full merchant directory, but its network/merchant rows did not appear in the readable page response; thus individual currently available programs and the actual live network count remain unverified without its interactive directory/account. The public API documentation demonstrates authenticated `/networks` and product endpoints, and says network objects identify supported record type as products or coupons. Its response is illustrative and includes legacy Zanox entries; it is not a live catalog response. This research does not claim all 28 have active Datafeedr feeds today.

Datafeedr documents one catalog-style API using account `aid` and `akey`; that is Datafeedr access, not proof of each named network's direct API. Country-specific active coverage cannot be established from the public directory in this pass. `regions-affiliate.csv` captures only country-labelled sample records from Datafeedr's API reference; it marks the example-only and legacy entries so they are not mistaken for a current country union. Do not treat the 27-country list in the prompt as verified.

## Network-specific findings

- **AWIN:** Publisher access to advertiser feeds is through its platform/Create-a-Feed. Enhanced Google-format feeds can be retrieved using a publisher bearer token and are returned as JSON Lines; the documented API does not support legacy feeds. Availability depends on advertiser feed and partnership. Examples such as `en_GB` are feed locales, not proof of active country programs. The claimed 22 markets was not verified.
- **CJ:** Current publisher Product Feed API is GraphQL, supports filters including country and serviceable area, and uses personal access bearer tokens. Search/API support does not grant a publisher access to every advertiser's products; relationship and advertiser participation remain relevant.
- **Rakuten Advertising:** Product Search API is available to logged-in publishers with an API bearer token, returns XML, and has a documented 100 calls/minute limit. Product Catalog is a distinct bulk feed capability and requires approval. Country-by-country coverage was not established.
- **Tradedoubler:** Publisher Products API is REST, with JSON, XML, and CSV options; publisher account, site, token, and advertiser connection are required. Product feeds expose currency/language and program metadata; network-published knowledge page says feeds refresh every 24 hours. Its example of UK/SE programs is not a current complete country list.
- **Impact:** Partner documentation confirms catalogs can be retrieved in platform, FTP, or API. Catalogs require joining the brand; API access must be enabled, and each brand must upload a catalog. This is a per-brand access dependency, not a universal catalog.
- **Other listed names:** The homepage verifies that Datafeedr names these brands, but direct API access, auth, product formats, current markets, and program-level availability are not established here. Refer to the CSV's notes rather than treating homepage inclusion as live access.

## Limits and open facts

- No current merchant cache-age/refresh guarantees were verified for Datafeedr. Do not promise a freshness SLA based on its “up-to-date” marketing statement.
- Network rate limits, source-specific API credentials, per-country program counts, data reuse/display rules, and actual publisher approval requirements remain unverified except where stated above.
- Datafeedr API example response has `network_count: 173`; this is a documentation example and should not be treated as current. The homepage's 40 marketing figure and the 28 named logo entries are also not independently reconciled to merchant records.
- No claim that network APIs are uniform across countries. Build one logical connector per source with country/program profiles only after verifying each source's current per-market contracts, data shapes, currencies, locales, and attribution rules.

## Official sources

- Datafeedr homepage and its 28 named brands / 40-network claim: https://www.datafeedr.com/
- Dynamic supported networks and merchants directory (readable response contains headings but no merchant rows): https://www.datafeedr.com/networks
- Datafeedr API docs (auth, networks endpoint/sample, products and Partnerize-specific endpoint): https://datafeedr.github.io/datafeedr-api-docs/
- AWIN enhanced publisher feed endpoint/auth/JSONL/usage limits: https://help.awin.com/apidocs/retail-publisher-productapidocumentation-1
- AWIN publisher feed access and partnership/feed availability: https://success.awin.com/articles/en_US/Knowledge/Product-Data-Feed-FAQ
- CJ publisher API index: https://developers.cj.com/
- CJ authentication: https://developers.cj.com/authentication/overview
- Rakuten Product Search API: https://developers.rakutenadvertising.com/guides/product_search
- Rakuten Product Catalog approval distinction: https://pubhelp.rakutenadvertising.com/hc/en-us/articles/10623933503373-Product-Links
- Tradedoubler publisher Products API: https://dev.tradedoubler.com/products/publisher/
- Tradedoubler product feed refresh article: https://knowledge.tradedoubler.com/grow-knowledge/how-do-product-feeds-update
- Impact partner catalog/API eligibility: https://help.impact.com/partner/what-would-you-like-to-learn-about/platform-features/marketing-content/product-marketplace-and-catalogs/download-product-catalogs-as-a-partner

## Additional official API and feed checks (2026-09-28)

- **2Performant — feed and API existence verified; current coverage unverified.** Its official support docs explain affiliate API sign-in and returned session token headers. Its terms describe optional advertiser-uploaded product feeds and affiliate downloads in CSV/XML. Product-store/feed API method documentation is hosted on its legacy PBworks developer site; detailed current product query/auth parameters were not confirmed. Sources: https://support.2performant.com/hc/en-us/articles/4408717932690-cashback-documentation ; https://2performant.pbworks.com/w/page/26210954/Feeds%20API%20Methods ; https://2performant.com/terms-conditions/.
- **ADCELL — CSV specification verified; publisher API unverified.** Its official advertiser specification supports CSV files intended for shopping and price-comparison publishers and documents fields such as title, price, currency, deeplink, image, and category. This does not establish an API or prove that any particular publisher can access a feed. Source: https://www.adcell.de/publicurl/csv_product_specifications_en.pdf.
- **Admitad — advertiser-provided feeds verified; catalog API unverified.** Official help says program feeds may be offered in separate languages/categories/price bands, using YML, CSV, or other formats; publisher-facing help says feed refreshes occur every six hours. A general publisher API with OAuth 2.0 exists, but its current public method index did not expose a product-catalog endpoint in this review. Source: https://support.admitad.ru/article/ru/206.html ; https://developers.mitgo.com/hc/en-us/articles/34481290690834-Introduction ; https://developers.mitgo.com/hc/en-us/categories/34481291136402-Admitad-API-for-Publishers.
- **Adtraction — product-feed API v3 verified.** Official current docs specify an account token sent as `X-Token`, JSON API responses, market-specific program lookup (ISO country code), XML or CSV feed downloads, and approved program/channel access. Help says feed refresh is typically daily but varies by brand. API v2 feed endpoints are deprecated. No complete current country-program inventory was found. Sources: https://apidocs.adtraction.net/nextgen/ ; https://help.adtraction.com/en/articles/13398866-product-feeds-via-adtraction.
- **AvantLink — affiliate ProductSearch verified.** Official docs state affiliate access, an `affiliate_id` request parameter, no authentication requirement for that module, XML/tab-delimited/RSS output examples, and limits of 3,600 requests/hour and 15,000/day. Market coverage was not enumerated. Source: https://www.avantlink.com/api.php?help=1&module=ProductSearch.
- **TradeTracker — product-feed data in publisher API verified; technical details incomplete.** Official publisher help confirms account API can access product-feed data, uses SOAP web services, and API access is requested inside the account. The same source describes XML/CSV product feed files and says multi-country campaign setup is coordinated by account manager. Exact API methods/auth scheme and current country programs were not publicly established here. Source: https://tradetracker.com/us/knowledge-centre/gdpr/.

No active country-program rows were added for these six networks: available country references described query fields, sample entries, or account workflows, rather than a verifiable current program roster.
