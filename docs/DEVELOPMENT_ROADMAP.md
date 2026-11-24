# NyumbaLink: Development Roadmap

**Version:** 0.1 (DRAFT)
**Source of phases:** PROJECT_CONSTITUTION.md Article 13.

## Phase status

| Phase | Status |
|---|---|
| 0 Project initialization | Documents are drafts. Formal exit approval has **not** been given. The founder allowed Phase 1 to proceed on the drafts (D13). Open questions must be settled before Phase 2. |
| 1 Interface design | **In progress** (founder-authorised start). Step 1A written, not verified. |
| 2 to 7 | Planned |

## Phase 1 steps

Prototype only: sample data, no backend, no third-party packages (ADR-012). Exit: founder approves the prototype.

| Step | Scope | Status |
|---|---|---|
| 1A Foundation | pubspec with dependency placeholders, theme tokens, shared widgets, models, sample data, validators, design gallery, tests | Written. **Not verified**: the Flutter SDK was unavailable in the authoring environment. |
| 1B Entry and auth | Welcome and role choice, sign up, sign in, email verification, password recovery | Planned |
| 1C Tenant | Home, search and filter, property details (locked and unlocked), payment states, favourites, report, notifications, payment history | Planned |
| 1D Landlord | Dashboard, create and edit listing, status management, profile | Planned |
| 1E Admin (separate web app) | `lib/main_admin.dart`: review queue, listing review including the blur settings (D16), reports, payments and refunds | Planned |

## Verification protocol

A step is complete only when, on a machine with Flutter installed, `dart format`, `flutter analyze` and `flutter test` pass and the screens have been run (Art. 14.1). Until then it is reported as written and unverified.

## Pending founder decisions

- Branding: palette, logo, credit-line wording.
- Android application ID (permanent once the app is published).
- Q1 to Q15 in SOFTWARE_REQUIREMENTS.md. They must be settled before Phase 2.
- Moving the real documents from the repository root into `docs/` (Art. 6.2, 12.4).
- Constitution amendment v1.1 (ARCHITECTURAL_DECISIONS, "Proposed constitutional amendments").
