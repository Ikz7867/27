# Provisional specification defects and gaps

The original SPEC.docx is missing from the supplied workspace and prompt pack. This register was derived only from 1-astra_orchestra_prompt_pack-1-.md; it does not claim to have read the original specification. The criteria and priorities are provisional interpretations of the pack, not source-spec quotations. Recover and review the original document before implementation approval.

## Confirmed input defects or inconsistencies in the pack

- Four versus five areas: the pack records that the source spec says “four panels” but describes five and even duplicates section numbering. The owner correction says to build five areas: front end, admin, merchant, affiliate and member. Treat five as the current instruction; verify details against the source when available.
- Duplicate/empty bullets: pack reports empty or duplicated bullets covering newsletter unsubscribe, affiliate password change, tag creator and category mapping. They cannot be reconstructed faithfully. Consolidate only confirmed semantics and inspect the source before treating missing details as requirements.
- Source/API count: “about 50 APIs” and “27 countries” are not established counts. The pack itself says the network counts disagree, named lists are partial, some entries may be unavailable, the Datafeedr network table could not be read, and the 27-country total includes an inference from unlabeled flags. Do not pad counts; research and report verified totals and country union.
- Retail-only source material versus travel scope: source-spec content is described as retail feeds, while owner clarification adds travel live search. Travel providers, access, caching, attribution, and “other” verticals require research and a user decision for proposed extra verticals.
- Potentially obsolete services: Google Checkout, Nextag, Zanox/AffiliateWindow and Linkshare are examples flagged for current-status verification. Do not assume they are active.
- Mixed requirement and marketing language: vendor claims about custom programming are not owner requirements; classify as non-requirement unless source context establishes otherwise.

## Missing information that blocks a faithful source-spec register

- Original SPEC.docx, its exact requirements, source locations, and intended priorities.
- Names and requirements for payment gateways and shopping carts. The pack asks researchers to identify those “named in SPEC” but does not name them. This register intentionally invents no names.
- Precise behavior for member/merchant/affiliate panels, billing rules, tax application, language requirements, crawler targets, report metrics, feed mappings, and tag creation.
- Approved “other” travel verticals and verified provider list, coverage and country program data.

All IDs and acceptance criteria in requirements.csv are provisional pack-derived statements. Reconcile against the original document before Gate 1 approval/build authorization.
