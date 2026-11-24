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

## Phase 1 round: step 1A (foundation), written and NOT yet verified

### Added
- `pubspec.yaml` (no third-party packages; commented dependency placeholders, ADR-012) and `analysis_options.yaml`.
- `lib/` foundation: theme tokens, shared widgets (button, text field, loading/empty/error views, wordmark), models (user role, listing status, paywall policy, listing), sample data, Kenyan phone and KES formatting, email and phone validators, temporary design gallery.
- `test/`: unit tests for formatters, validators and fee bands; widget smoke tests.
- `docs/UI_UX_GUIDELINES.md` v0.1 and `docs/DEVELOPMENT_ROADMAP.md` v0.1.

### Changed
- `SOFTWARE_REQUIREMENTS.md` v0.4 and `PRODUCT_REQUIREMENTS.md` v0.4: recorded D13 to D16 (proceed on drafts; admin is a separate app; subsidiary of LGC'S GROUP; admin decides what is blurred), FR-ADM-09, NFR-SEC-06 and new question Q15; Q2 resolved; FR-DISC-03 reworded. The header previously cited D12, which was never recorded.
- `ARCHITECTURAL_DECISIONS.md`: ADR-002 update, ADR-011, ADR-012.
- `SYSTEM_ARCHITECTURE.md`: admin section status.
- `.gitignore`: keep `pubspec.lock` under version control; ignore `.env` files.

### Notes
- Not verified: the Flutter SDK was unavailable where this was written. Syntax was parsed and the formatting and validation logic was cross-checked, but `flutter analyze` and `flutter test` have not been run.
- `android/` and `web/` are generated locally with `flutter create` (see README).

## Draft updates: payments round
- `docs/SOFTWARE_REQUIREMENTS.md` v0.3: recorded D7 to D11 (accounts for all with email and phone; pay-to-view fee bands; blurred listings; free map; in-app notifications); added PAY requirements and a costs section; flagged the 5,001 to 6,000 fee gap.
- `docs/DATABASE_SCHEMA.md` v0.2: dropped `enquiries`; added `payments`, `fee_tiers`, `property_locations`; blurred and full photo paths; contact-reveal function.
- `docs/SYSTEM_ARCHITECTURE.md` v0.2: Edge Functions for M-PESA, payment flow, map choice with findings.
- `docs/ARCHITECTURAL_DECISIONS.md`: ADR-007 to ADR-010 and a list of proposed constitutional amendments.
- `docs/PRODUCT_REQUIREMENTS.md` v0.3: business model recorded.

## [0.0.1]

### Added
- `PROJECT_CONSTITUTION.md` v1.0.
