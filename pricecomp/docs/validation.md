# Provisional blueprint validation

Date: 2026-09-28. This records checks of planning artifacts, not an application test run.

- Python `csv.reader` checked every CSV row against its header width. Quoting defects found in the initial requirements and marketplace CSVs were corrected.
- Requirements: 37 unique IDs, 28 provisional Musts and 9 provisional Shoulds. Original SPEC traceability is unresolved.
- Consolidated inventory: 41 named candidate sources. Duplicate Booking attractions capability and unnamed parking/cruise proposals are excluded from the connector count.
- Consolidated regions: 22 documented Amazon marketplace profiles. Historical examples and dynamic context placeholders are excluded.
- Composer JSON parses. Draft PHP declarations are checked for filename/namespace consistency; SQL table references receive static inspection.
- Independent Sol review found three design issues and confirmed the revised draft addresses them: per-account offer terms now have separate rows; clicks and ledger records capture distinct price/charge snapshots; profiles distinguish defaults from verified permitted currency/locale values.
- Connector prerequisite: confirm whether provider external IDs are region-wide. If they are account-scoped, namespace the canonical external ID with a stable account scope before persistence; verify this with fixtures from at least two accounts. This remains an implementation acceptance check, not a verified provider property.

PHP, Composer and MySQL were unavailable. No PHP lint, PHPUnit suite, database migration, browser journey, clean install, live API request or production security audit has passed. Those checks remain required after Gate 1 and implementation. The SQL files are explicitly unexecuted drafts.
