# Implementation plan: PHP/MySQL price comparison platform

## Overview

The supplied prompt pack defines a multi-area retail price-comparison application and adds provider integrations for travel live search. This plan stops at Gate 1: complete source recovery, requirements and service research, an architecture blueprint, and a reviewable approval package. No implementation is authorized before the owner reviews Gate 1.

## Working architecture constraints

Use pack-provided defaults: PHP 8.3, MySQL 8, Composer, PSR-4, server-rendered PHP templates, Manticore/Sphinx if drop-in compatible, CLI cron and PHPUnit. A single codebase serves front end, admin, merchant, affiliate and member areas. Keep catalog/feed connectors separate from travel/live-search connectors. Use one connector per source and regional configuration profiles. Hosted payments only; no card data stored. These are provisional until the missing original SPEC.docx is reviewed.

## Dependency-ordered work through Gate 1

### Task 1 — Recover and inspect source specification

**Description:** Obtain the original SPEC.docx and inspect it alongside this provisional register. The attachment is not present in the current inputs.

**Acceptance criteria:**
- [ ] Original document is available at pricecomp/SPEC.docx or an explicitly recorded source location.
- [ ] Every source requirement can be traced to a page, heading or bullet.
- [ ] Empty/duplicate bullets, intended payment gateways and shopping carts are transcribed or recorded as unresolved.

**Verification:** Confirm source file is readable and compare each extracted item with requirements.csv.
**Dependencies:** None.
**Scope:** S.

### Task 2 — Reconcile requirements and defects

**Description:** Update the register and defect log from the actual source, retaining unique IDs and separating owner clarifications from source requirements.

**Acceptance criteria:**
- [ ] IDs are unique and each requirement has area, explicit priority, source location and observable acceptance criteria.
- [ ] Duplicate requirements are merged with all source locations; empty bullets and typos are documented as defects.
- [ ] Priority rationale and any unresolved requirement are explicit; no vendor marketing is promoted to a requirement.

**Verification:** Parse requirements.csv and check unique IDs, required fields and priority values; manually trace source locations.
**Dependencies:** Task 1.
**Scope:** M.

### Task 3 — Research services and regional coverage

**Description:** Using official provider documentation, establish status/access for source families, named gateways/carts, supported countries, regional differences and travel caching/display rules. Do not pad the target count.

**Acceptance criteria:**
- [ ] Each source is marked verified or unverified with primary documentation links.
- [ ] Separate totals are available for networks, marketplaces/retail/comparison sources and travel providers.
- [ ] Country union and regional variance are evidence-backed; unknowns remain marked.
- [ ] No connector is planned as working where access is closed or rules are unavailable.

**Verification:** Review source URLs and reconcile counts; compare country list with the pack's provisional expectation of 27.
**Dependencies:** Task 1; source list may be refined by Task 2.
**Scope:** L, split by non-overlapping source batches if needed.

### Task 4 — Produce architecture blueprint

**Description:** Define modules, request flows, schema/migration ownership, interfaces, feature flags and boundaries against reconciled requirements and verified services.

**Acceptance criteria:**
- [ ] Blueprint describes modules, request flow, cron, caching, search-index approach and ownership.
- [ ] Schema includes source/network regions, source accounts, offers, retail/travel distinction and live-search cache/tracked clicks.
- [ ] Interfaces cover catalog source, live search, feed parser, payment gateway, cart export, crawler and notifier.
- [ ] Shared registries have a single owner and regional differences are configuration-first.

**Verification:** Trace every Must/Should requirement to a module or mark it unresolved/deferred; review security and data boundaries.
**Dependencies:** Tasks 2 and 3.
**Scope:** M/L.

### Gate 1 — Owner review; stop here

Present: requirement counts by area and priority; researched source families/counts/families/regional variance; country union; gateway/cart status; proposed build order; concise architecture summary; decisions on source defects; proposed extra travel verticals for confirmation. Wait for approval or edits before implementation.

## Post-approval phases (not authorized by this plan before Gate 1)

1. Foundation: authentication/RBAC, sessions, throttling and captcha; then i18n, currencies, countries/tax, settings and feature flags.
2. Catalog and feed engine, plus SEO, with schema/contracts established first.
3. Payments and merchant/affiliate areas, then crawler controls/scheduling.
4. Retail front end and member features; reports behind the reports flag.
5. Prove one connector with the broadest verified country coverage; then add verified sources in disjoint waves. Build travel verticals only after provider rules and “other” verticals are confirmed. Add tag/cart plugins from recovered SPEC names.
6. Run integration/e2e tests, security review and requirement audit; repair at most two rounds, document residual deferrals, then verify clean installation and write user guides.

## Risks and mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Missing original specification | Unknown requirements, source locations, payment/cart names and details | Recover before Gate 1; keep current register provisional |
| Provider access or rules prohibit integration | Unavailable or non-compliant connectors | Research official rules first; mark unavailable sources as stubs/deferred |
| Approximate API/country counts are wrong | Scope and schedule change | Report verified inventory and country union without padding |
| Shared interfaces or registries drift across modules | Integration rework | Architect owns shared contracts/registries and assigns disjoint paths |
| Travel prices become stale or violate provider rules | Incorrect offers or policy breach | Live search, source-specific short cache, attribution and access controls |

## Open questions

- Where is the missing original SPEC.docx?
- Which named “other” travel verticals should be included after research proposes candidates?
- Do verified providers yield roughly 50 sources and 27 countries, or should the target be revised?
- Which exact tax, commission, billing, cart export and panel behaviors does the source specify?
