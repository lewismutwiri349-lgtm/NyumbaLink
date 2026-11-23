# NyumbaLink: Architectural Decisions

Records important technical decisions, their reasoning and consequences. Status values: **Founder decision** (stated by the founder), **Proposed** (awaiting founder approval).

## ADR-001: Role selection on the first screen
- **Status:** Founder decision
- **Decision:** The first screen offers Tenant or Landlord. Admin is never offered.
- **Consequences:** The role the user picks maps to a trusted server-side role. The client cannot assign or escalate roles; Supabase Auth plus RLS enforce this (Constitution 5.1, 8.2).

## ADR-002: Separate administration section
- **Status:** Founder decision (separation); **Proposed** (implementation)
- **Decision:** Admin accounts are separate from user accounts, and administration is a separate section outside the in-app experience.
- **Constitution impact:** Art. 5.1C, the `features/administration` folder in Art. 6.2 and the "Administrative screens" deliverable in Phase 1 assume admin screens inside the app. Under Art. 20 this needs a recorded amendment, which I will draft for approval and not apply silently.
- **Proposed implementation:** A Flutter Web admin app in the same repository with its own entry point, signing in with admin accounts held apart from user profiles and assigned manually. This keeps the approved stack (no new framework). Hosting would need a free static host, which must be approved under Art. 16. The mobile app contains no admin code or admin routes.
- **Alternatives:** Supabase Studio only (no moderation UI, not suitable for non-developer moderators); a separate non-Flutter web app (new framework, needs justification under 4.1).

## ADR-003: Property location as a map pin from the phone
- **Status:** Founder decision (pins from phone location); **Proposed** (map provider)
- **Decision:** A landlord sets a listing's location by placing a pin using the phone's location.
- **Consequences:** Requires the Android location permission, requested only at the point of placing a pin. Coordinates are stored with the property. The map provider (Google Maps or an OpenStreetMap-based option) is pending approval (SOFTWARE_REQUIREMENTS Q3).

## ADR-004: Landlord edit and delete
- **Status:** Founder decision (edit and delete at the landlord's discretion); **Proposed** (soft delete, re-review rules)
- **Open points:** See SOFTWARE_REQUIREMENTS Q4 and Q5.

## ADR-005: Interface language
- **Status:** Founder decision
- **Decision:** English only. No localisation framework is needed for the MVP.

## ADR-006: Authorization lives in the database
- **Status:** Proposed
- **Decision:** Roles and permissions are enforced by RLS and RPC functions in Postgres. Admin identity is a row in `admin_users`, checked by a `security definer` function. No custom backend server for the MVP.
- **Reasoning:** Satisfies Art. 8.2 to 8.4 (no frontend-only checks, no service-role key in any client) at no extra infrastructure cost.
- **Consequence:** Policies are security-critical code and need per-role tests (Art. 14). See DATABASE_SCHEMA.md.

## ADR-007: Tenants pay by M-PESA to unlock a landlord's contact
- **Status:** Founder decision (model and fee bands); **Proposed** (implementation)
- **Decision:** Tenants pay KES 200 / 500 / 600 by rent band via M-PESA Express (STK Push) to see a landlord's number. Landlords pay nothing. Fees live in a `fee_tiers` table. The server computes the amount; a paid `payments` row is the unlock.
- **Consequences:** Requires Edge Functions, a registered business with a Paybill or Till number, sandbox testing, a refund policy and Data Protection Act review. Paid content must be withheld by the server, not hidden by the app (NFR-SEC-05). The fee gap for rent of 5,001 to 6,000 must be settled (Q1).
- **Risks:** pay-before-seeing erodes trust if listings are stale or fake; a paid plan on Supabase is likely required; Safaricom may require a whitelisted server IP.

## ADR-008: Contact outside the platform replaces in-app enquiries
- **Status:** Founder decision
- **Decision:** After payment the tenant sees the landlord's phone number and calls outside the platform. The `enquiries` table and in-app messaging are dropped.
- **Consequences:** Landlord phone numbers become personal data shown to third parties, so landlord consent and a privacy notice are required. Numbers in free text and photos could bypass the paywall, so listing text is checked and admin review includes it.

## ADR-009: Free map via self-hosted OpenStreetMap data
- **Status:** Delegated to Claude; **Proposed**, pending approval of dependencies (Art. 4.1)
- **Decision:** flutter_map with vector tiles read from a self-hosted regional PMTiles file. Fallback: open the phone's installed maps app. See SYSTEM_ARCHITECTURE section 6 for what was ruled out and why.

## ADR-010: In-app notifications only
- **Status:** Founder decision
- **Decision:** Notifications are shown inside the app. No push service, so no Firebase (consistent with Art. 4.1).
- **Consequence:** A landlord learns of an unlock or an approval only when they open the app.

## Proposed constitutional amendments (Art. 20)

None of these has been applied. Each needs your explicit approval and a version bump (v1.1).

| Article | Change |
|---|---|
| 5.1C, 6.2, Phase 1 | Administration is a separate section outside the app (D5). |
| 5.3 | "Integrated financial transactions" moves into the MVP for tenant payments only (D8). Rent collection, other payments and landlord fees stay out. |
| 5.1, 5.2 (module 6), 7.2, Phase 5 | In-app enquiries and the `enquiries` entity are replaced by payment-gated phone contact (D9). |
| 7.2 | New entities: `payments`, `fee_tiers`, `property_locations`, `admin_users`, `account_restrictions`, `moderation_log`. |
| 4 | Edge Functions (inside Supabase) added for payments. Map and location dependencies added once approved. |
| 8.5 | Scope now includes phone numbers and payment records. |
