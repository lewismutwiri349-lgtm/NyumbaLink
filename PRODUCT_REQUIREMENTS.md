# NyumbaLink: Product Requirements

**Version:** 0.3 (DRAFT, pending founder approval)
**Derived from:** PROJECT_CONSTITUTION.md v1.0 (Preamble, Articles 1, 3, 5, 17)
**Implementation status:** Nothing described here is built yet. Everything is **Planned**.

## 1. Concept

NyumbaLink is a mobile app that connects people searching for rental accommodation with landlords and authorized agents, starting in Kwa Vonza and Kitui town, Kenya. It is intended as a scalable business, not a demo.

**Mission:** make finding and advertising rental accommodation simpler, more accessible and more reliable through a centralized mobile application.

## 2. Problems addressed

1. House hunting requires unnecessary physical movement.
2. Reliable rental information is hard to find.
3. Landlords lack a central place to advertise vacancies.
4. Fake, misleading or duplicate listings erode trust (Art. 17).

*Evidence for these problems (interviews, surveys, local observations) has not been provided. See open question P1.*

## 3. Users

| User | Goal |
|---|---|
| House hunter | Find a suitable rental without wasting travel |
| Landlord / authorized agent | Advertise available properties and receive enquiries |
| Administrator | Keep listings trustworthy |

## 4. MVP features

All features map to the numbered requirements in SOFTWARE_REQUIREMENTS.md.

- First screen offers Tenant or Landlord; landlords must create an account
- Browse, search by location, filter by price, view photos, details and map pin
- Favourites
- Pay by M-PESA to unlock the landlord's number, then call outside the platform
- Landlord listing management: create, edit, delete, photo upload, map pin from phone location, occupied/unavailable status
- Report suspicious listings
- Admin approval, rejection and suspension of listings; handling of reports and complaints, in a separate admin section outside the app
- In-app notifications

## 5. Explicitly out of MVP (Constitution 5.3, as amended by decision)

AI recommendations, automated rent collection, valuation, mortgage services, agent commission systems, ownership transfers, automated legal agreements. (Tenant payments to view contact details are now in scope by founder decision.)

## 6. Market constraints (Constitution 1.3)

Mobile-first Android, variable connectivity, limited data budgets, KES, Kenyan phone formats, local rental terminology.

## 7. Open questions (founder decision required)

- **P1.** What evidence supports the problem statements above, and who has been spoken to?
- **P2.** Resolved: see section 8.
- **P3.** What does a successful pilot look like (listings count, active users, unlocks per listing) so that Phase 7 has measurable exit criteria?
- **P4.** How will the first listings be sourced (founder onboarding landlords directly, or open signup)?

## 8. Business model (decided)

Tenants pay by M-PESA to unlock a landlord's phone number; landlords pay nothing. Fees by rent: KES 200 for 3,000 and below; KES 500 above 3,000 up to 5,000; KES 600 above 6,000 (the 5,001 to 6,000 band is unresolved). This replaces the earlier open question P2 and brings tenant payments into the MVP.

Product risks to manage: tenants paying for stale or fake listings, refunds, and landlords or tenants bypassing the paywall by sharing numbers in text or photos.

## 9. Founder decisions recorded

- The first screen offers Tenant or Landlord.
- Landlords must create an account.
- Property locations are map pins set from the phone's location.
- Landlords can edit or delete their own listings.
- Admin accounts are separate from user accounts; administration is a separate section outside the app.
- Interface language is English only.
- Accounts are required for everyone, with email (verification) and phone number (payment prompt).
- Tenants pay per rental to see the landlord's number; listings are blurred until payment; contact happens by phone outside the platform.
- Free map option; in-app notifications only.
