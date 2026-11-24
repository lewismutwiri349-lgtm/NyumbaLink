# NyumbaLink: UI/UX Guidelines

**Version:** 0.1 (DRAFT, pending founder approval)
**Derived from:** PROJECT_CONSTITUTION.md v1.0 (Art. 9), SOFTWARE_REQUIREMENTS v0.4
**Implementation status:** Phase 1, step 1A is written but **not yet verified** (see DEVELOPMENT_ROADMAP). Everything else is **Planned**.

## 1. Brand

| Item | Value | Status |
|---|---|---|
| Product name | NyumbaLink (never altered, Art. 1.1) | Approved |
| Parent company | LGC'S GROUP. NyumbaLink is its subsidiary (D15) | Founder decision |
| Credit line | "A subsidiary of LGC'S GROUP" | Wording to be confirmed |
| Logo | None yet. A text wordmark is used until the founder supplies one | Awaiting founder |
| Language | English only (D6) | Founder decision |
| Currency | KES, whole shillings in the prototype | Art. 1.3 |

## 2. Provisional palette

Awaiting founder approval of the branding. All values live in `lib/core/theme/app_colors.dart` and nowhere else (Art. 9.4).

| Role | Hex | Use | Contrast |
|---|---|---|---|
| Primary (teal) | `#0F766E` | Main actions, wordmark | 5.47:1 with white text |
| Accent (amber) | `#F59E0B` | Pay and unlock actions only | 8.31:1 with `#0F172A` text |
| Text primary | `#0F172A` | Body text | 17.06:1 on background |
| Text secondary | `#475569` | Supporting text | 7.24:1 on background |
| Success | `#15803D` | Confirmations | 5.02:1 on white |
| Error | `#B91C1C` | Errors | 6.47:1 on white |
| Background / surface / border | `#F8FAFC` / `#FFFFFF` / `#E2E8F0` | Screens, cards, outlines | n/a |

Contrast ratios were computed with the WCAG formula. All text pairs are above 4.5:1. Amber is never used with white text.

## 3. Rules

1. Use shared tokens and widgets (`core/theme`, `core/widgets`). No colours, spacing or button styles inlined in screens.
2. Controls are at least 48 dp high. Inputs have visible labels, not placeholder-only labels.
3. Every screen that loads data has a loading, an empty and an error state with retry (`state_views.dart`).
4. Error messages are plain English and expose no technical detail (Art. 10.3).
5. Money is shown as `KES 3,500`. Phone numbers are Kenyan mobile numbers, entered in local or international form.
6. The amber accent button is reserved for pay and unlock actions.
7. The main app has exactly two registration choices, Tenant and Landlord (D1, D14). It contains no administrator sign-in, screen, route or code.
8. A verification badge appears only when a real verification process has been completed. Approval alone is never shown as "inspected" (Art. 17).

## 3a. What a tenant sees before payment

- The landlord's phone number is always hidden until payment is confirmed (D9).
- **An administrator decides** whether a listing's photos are blurred and whether its exact location is hidden until payment (D16, ADR-011). Landlords cannot change this.
- Until an administrator decides, both are withheld.
- Price, area, category, bedrooms and bathrooms stay visible (assumption, Q15).
- In the prototype the blur is only a visual effect on placeholder shapes. It protects nothing. In the real system the server withholds the data itself (NFR-SEC-05), and the UI only reflects that.

## 4. Prototype conventions

- All data is invented sample data in `lib/shared/data/`. Fees shown are provisional (Q1).
- No screen in Phase 1 talks to a backend, a payment service or the phone's location.
- The temporary design gallery (`features/prototype`) is removed once the real screens exist.

## 5. Planned screens (Phase 1)

Welcome and role choice, sign up, sign in, email verification, password recovery, home, search and filter, property details (locked and unlocked), payment states, favourites, report, notifications, payment history, landlord dashboard, listing form, landlord profile. The administration screens are a separate web application (ADR-002).
