# Changelog

All meaningful changes to NyumbaLink are recorded here.

## [Unreleased]

### Added
- `docs/PRODUCT_REQUIREMENTS.md` v0.1 draft, derived from the constitution; open questions flagged for the founder.
- `docs/SOFTWARE_REQUIREMENTS.md` v0.1 draft, derived from the constitution; open questions flagged for the founder.
- `README.md` with current project status.

### Added (drafts)
- `docs/DATABASE_SCHEMA.md` v0.1 proposal: entities, draft DDL, RLS matrix, storage policy.
- `docs/SYSTEM_ARCHITECTURE.md` v0.1 proposal: components, layers, flows, security, repository layout.
- ADR-006 in `docs/ARCHITECTURAL_DECISIONS.md`.

### Changed
- `docs/SOFTWARE_REQUIREMENTS.md` v0.2: recorded founder decisions D1 to D6 (role choice on first screen, landlord accounts, map pins from phone location, landlord edit/delete, separate admin section, English only); added new open questions.
- `docs/PRODUCT_REQUIREMENTS.md` v0.2: aligned MVP features with the same decisions; closed the language question.

### Notes
- Phase 0 in progress. No application code, database or backend exists yet.
- Drafts are not approved requirements until the founder signs them off.

## Draft updates: payments round
- `docs/SOFTWARE_REQUIREMENTS.md` v0.3: recorded D7 to D11 (accounts for all with email and phone; pay-to-view fee bands; blurred listings; free map; in-app notifications); added PAY requirements and a costs section; flagged the 5,001 to 6,000 fee gap.
- `docs/DATABASE_SCHEMA.md` v0.2: dropped `enquiries`; added `payments`, `fee_tiers`, `property_locations`; blurred and full photo paths; contact-reveal function.
- `docs/SYSTEM_ARCHITECTURE.md` v0.2: Edge Functions for M-PESA, payment flow, map choice with findings.
- `docs/ARCHITECTURAL_DECISIONS.md`: ADR-007 to ADR-010 and a list of proposed constitutional amendments.
- `docs/PRODUCT_REQUIREMENTS.md` v0.3: business model recorded.

## [0.0.1]

### Added
- `PROJECT_CONSTITUTION.md` v1.0.
