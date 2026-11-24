# NyumbaLink: Software Requirements

**Version:** 0.4 (DRAFT; Phase 1 interface work proceeds on this draft by founder decision D13)
**Derived from:** PROJECT_CONSTITUTION.md v1.0 plus founder decisions D1 to D11 and D13 to D16 (no D12 is recorded)
**Implementation status:** Nothing below is implemented. Every requirement is **Planned**.

Requirements not stated in the constitution or by the founder are not invented here. They appear under *Open questions* (section 7).

## 1. Scope

Native Android app (Flutter/Dart) backed by Supabase (PostgreSQL, Auth, Storage, Edge Functions) for rental discovery in Kwa Vonza and Kitui, Kenya. Tenants pay a fee by M-PESA to see a landlord's contact. Administration is a separate section outside the app.

**Scope change:** Constitution 5.3 excludes "integrated financial transactions" from the MVP unless explicitly authorised. D8 is that authorisation. A constitutional amendment must record it (see ARCHITECTURAL_DECISIONS, "Proposed amendments").

## 2. Founder decisions recorded

| ID | Decision |
|---|---|
| D1 | The first screen offers two options: **Tenant** or **Landlord**. |
| D2 | Landlords must create their own account. |
| D3 | Property location is set with a map pin, using the phone's location. |
| D4 | Landlords can edit or delete their listings at their own discretion. |
| D5 | Admin accounts are separate from user accounts. Administration is a separate section, not part of the in-app experience. |
| D6 | The interface language is English only. |
| D7 | Accounts are required for everyone. Sign-up collects an email and a phone number. Email is for verification. The phone number is used to prompt payment. |
| D8 | Tenants pay to view a rental: KES 200 for rent of 3,000 and below; KES 500 for rent above 3,000 up to 5,000; KES 600 for rent above 6,000. Landlords pay nothing. (Rent from 5,001 to 6,000 is not covered: Q1.) |
| D9 | Available rentals are blurred for tenants until payment. After payment the landlord's number appears, and the tenant calls the landlord outside the platform. |
| D10 | The map must be a free option. Selection delegated to Claude: see SYSTEM_ARCHITECTURE section 6. |
| D11 | Notifications are in-app only. |
| D13 | Phase 1 (interface design) proceeds on the draft documents, without waiting for formal Phase 0 approval. Open questions must still be settled before Phase 2. |
| D14 | Administration is a separate application from the main app, for security. The main app offers only Tenant and Landlord registration and contains no admin sign-in, screens, routes or code. |
| D15 | NyumbaLink is a subsidiary of the parent company LGC'S GROUP. |
| D16 | An administrator decides what is blurred or hidden until payment, photos or location. The landlord does not decide this. |

## 3. Roles

| Role | Description |
|---|---|
| Tenant (house hunter) | Searches for rentals and pays to unlock a landlord's contact. |
| Landlord / authorized agent | Advertises and manages own listings. Pays nothing. |
| Administrator | Moderates content, accounts and payment disputes. Uses the separate admin section only. Never created or selectable through the app. |

## 4. Functional requirements (all MVP, all Planned)

### AUTH: Entry, authentication and user management
- FR-AUTH-01: The first screen shows Tenant and Landlord (D1). There is no Admin option. The main app offers only tenant and landlord registration (D14).
- FR-AUTH-02: Everyone, tenants included, creates an account to use the app (D2, D7).
- FR-AUTH-03: Sign-up requires an email and a Kenyan phone number. The email is verified (D7). The phone number is not verified by SMS code (avoids SMS cost). Ownership of the number is proven by completing an M-PESA payment prompt on it. *(Q6)*
- FR-AUTH-04: Sign in, sign out, password recovery, session management (Supabase Auth).
- FR-AUTH-05: Registration offers only tenant and landlord. Admin rights can never be obtained through the app.
- FR-AUTH-06: Landlords can manage their profile.
- FR-AUTH-07: A landlord must agree, at sign-up and before submitting a listing, that their phone number will be shown to tenants who have paid. *(Q12)*

### LIST: Listing management (landlord)
- FR-LIST-01: Create a listing: title, description, category, rental price (KES), bedrooms, bathrooms, area name.
- FR-LIST-02: Set the exact location with a map pin placed using the phone's location, adjustable before saving (D3).
- FR-LIST-03: Upload photographs. The app also produces a blurred low-resolution version of each photo for pre-payment display.
- FR-LIST-04: Edit own listings (D4). *(re-review: Q7)*
- FR-LIST-05: Delete own listings (D4). *(soft vs hard: Q8)*
- FR-LIST-06: Mark a property occupied or unavailable. Landlords are reminded to keep availability current, because tenants pay to see listings.
- FR-LIST-07: View and manage only own listings (RLS, not only the UI).
- FR-LIST-08: Free-text fields (title, description) must not contain phone numbers, as best-effort prevention of bypassing the paywall. Admin review also checks photos and text.

### DISC: Discovery (tenant)
- FR-DISC-01: Browse available (approved, not deleted) properties.
- FR-DISC-02: Search by area name; filter by rental price.
- FR-DISC-03: Before payment, the landlord's number is always hidden. Whether photos are blurred and whether the exact map location is hidden is decided by an administrator (D16). Whatever is withheld is enforced by the server and not only by the UI. *(granularity of the admin's choice: Q15)*
- FR-DISC-04: After payment the tenant sees full photos, the exact map pin and the landlord's number, with a call button. The call happens outside the platform.

### PAY: Paying to view a rental (M-PESA)
- FR-PAY-01: The fee is calculated on the server from the listing's current price and a fee table (D8). The client cannot set or change the amount.
- FR-PAY-02: The tenant confirms the phone number and starts payment. The server sends an M-PESA payment prompt (STK Push) to that number. *(Q6)*
- FR-PAY-03: A listing is unlocked only after the server has confirmed the payment with M-PESA. A screen message or a client claim never unlocks anything.
- FR-PAY-04: Payment handling is idempotent: a repeated or late callback cannot charge twice or unlock twice, and a tenant cannot be prompted repeatedly for the same listing while a payment is in progress.
- FR-PAY-05: Failed, cancelled and timed-out payments are shown clearly, with a way to retry.
- FR-PAY-06: A tenant can see their payment history and previously unlocked listings. *(duration of access: Q3)*
- FR-PAY-07: A tenant can report a paid listing (number unreachable, already taken, misleading). *(refunds: Q4)*
- FR-PAY-08: Admins can view payments and handle refund requests.
- FR-PAY-09: Payment credentials and M-PESA secrets exist only on the server, never in the app (Art. 8.4).

### FAV: Favourites
- FR-FAV-01: Save, remove and view favourite properties.

### REP: Reporting (in app)
- FR-REP-01: Tenants can report suspicious listings.

### NOTIF: Notifications (in-app only, D11)
- FR-NOTIF-01: In-app notification list with unread state. Proposed events: listing approved, rejected or suspended (landlord); someone unlocked your contact (landlord); payment confirmed (tenant); report or refund outcome (reporter). *(Q13)*

### ADM: Administration (separate section, D5)
- FR-ADM-01: Admins sign in through the separate admin section only, using admin accounts kept apart from user accounts. The main app contains no admin sign-in, screens, routes or code (D14).
- FR-ADM-02: Admin accounts are created through a trusted, controlled process. *(Q9)*
- FR-ADM-03: Review new and changed listings; approve or reject.
- FR-ADM-04: Suspend suspicious listings.
- FR-ADM-05: Manage reports, investigate complaints, apply account restrictions.
- FR-ADM-06: Monitor platform activity, including payments.
- FR-ADM-07: A verification badge is awarded only through an actual verification process. Approval alone is never shown as "physically inspected".
- FR-ADM-08: Build and hosting of the admin section. *(Q10)*
- FR-ADM-09: When reviewing a listing, an administrator decides whether its photos are blurred and whether its exact location is hidden until payment (D16). Until an administrator decides, both are withheld. *(Q15)*

### Removed from the constitution's list
- In-app enquiries to landlords (Art. 5.1, module 6 "Landlord communication", entity `enquiries`): replaced by D9, where contact happens by phone outside the platform. Needs an amendment.

### Listing status lifecycle (Art. 17)
Statuses: submitted, pending, approved, rejected, suspended, occupied. Transitions are not yet defined.

## 5. Non-functional requirements

| ID | Requirement | Source |
|---|---|---|
| NFR-SEC-01 | RLS enabled on all exposed tables; policies tested per role | Art. 8.3 |
| NFR-SEC-02 | No secrets in source; no service-role key or M-PESA secret in any client | Art. 8.4 |
| NFR-SEC-03 | Role-based authorization; no reliance on frontend-only checks | Art. 8.2 |
| NFR-SEC-04 | Admin privileges cannot be granted from the mobile app | Art. 5.1, D5 |
| NFR-SEC-05 | Paid content (the landlord number always; exact location and full photos where an administrator has withheld them) is not delivered to the device before payment is confirmed | D9, D16 |
| NFR-SEC-06 | The mobile app build contains no admin sign-in, screens, routes or code | D14 |
| NFR-PAY-01 | Every payment attempt and result is recorded and auditable | Art. 17 |
| NFR-PRV-01 | Data minimisation; Kenya Data Protection Act 2019 review before launch, now covering phone numbers and payment records | Art. 8.5 |
| NFR-PRV-02 | Location permission requested only when a landlord places a pin. Tenant location is not collected. | Art. 8.5, D3 |
| NFR-PERF-01 | Usable on ordinary Android devices; image compression, caching, loading states | Art. 9.3 |
| NFR-PERF-02 | Handles slow or interrupted connections, including a lost connection in the middle of payment | Art. 9.3 |
| NFR-UX-01 | Shared design system; English only | Art. 9.4, D6 |
| NFR-DATA-01 | Money stored in an exact numeric type; default currency KES; schema changes only via migrations | Art. 7 |
| NFR-COST-01 | Free or low-cost tooling; every recurring cost identified before use | Art. 16 |
| NFR-TEST-01 | Unit, widget, integration, database, auth, authorization and network-failure tests; payment tested end to end in the M-PESA sandbox before any live payment | Art. 14 |

## 6. Costs and external dependencies to approve (Art. 16)

- **M-PESA go-live** needs a registered business with a Paybill or Till number, company documents and a go-live request to Safaricom (per developer guides; to confirm with Safaricom).
- **Supabase free plan** pauses projects with low activity after 7 days, and Supabase advises a paid plan if people rely on the project. A paid plan is likely needed before the pilot.
- **Transaction fees** charged by M-PESA on collections reduce what NyumbaLink keeps from each payment. Current rates to be confirmed.
- **Email delivery** for verification emails may need a separate email provider at pilot volumes. To confirm.

## 7. Open questions (founder decision required)

**Blocking payments:**
- **Q1.** Fee gap. You gave 200 (3,000 and below), 500 (above 3,000 to 5,000), 600 (above 6,000). What is the fee for rent from 5,001 to 6,000? I assume the third band should start above 5,000, and that 600 applies to all rent above 5,000 with no upper cap. Please confirm.
- **Q2.** Resolved by D16: an administrator decides what is blurred or hidden before payment. Price, area, category, bedrooms and bathrooms stay visible (assumption, see Q15).
- **Q3.** Is the fee per listing, and is access permanent for that tenant? My assumption: pay once per listing, keep access to that listing.
- **Q4.** Refund and dispute policy when a tenant pays and the number is unreachable or the house is already taken. Refunds are the biggest trust risk of a pay-to-view model.
- **Q5.** Do you have, or plan to register, a business with a Paybill or Till number? Without one I can build and test only against the M-PESA sandbox.
- **Q6.** The M-PESA prompt can only go to a number registered on M-PESA. Must the account phone be the payer's M-PESA number, or can the tenant enter a different number at payment time? I recommend letting the tenant confirm or change it at payment.

**Carried over:**
- **Q7.** Edits to an approved listing: immediate (D4), or back to review when price, location or photos change? I recommend review for those three.
- **Q8.** Landlord delete: permanent erase or hide (soft delete)? I recommend hide.
- **Q9.** Admin accounts: created manually by you in the database?
- **Q10.** Admin section: Flutter Web in the same repository, hosted on a free static host? (ADR-002)

**Later:**
- **Q11.** Approval to move Supabase to a paid plan before the pilot.
- **Q12.** Which phone number is shown: the landlord's account number, or a number set per listing (agents managing several properties)? Wording of the landlord consent.
- **Q13.** Confirm the notification events in FR-NOTIF-01.
- **Q14.** Listing categories; verification-badge process; offline browsing; state-management package.
- **Q15.** Admin-controlled blurring (D16): is it set per listing or as one platform-wide rule? Can an administrator choose photos only, location only, or both? I assume per listing, independent choices, and both withheld until an administrator decides. Schema impact: DATABASE_SCHEMA needs per-listing fields at Phase 2.
