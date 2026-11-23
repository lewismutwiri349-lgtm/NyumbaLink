# NyumbaLink Project Constitution: Summary

Summary of `PROJECT_CONSTITUTION.md` (v1.0) from the NyumbaLink.zip upload.

## What was in the zip

The zip has 14 markdown files, but only `PROJECT_CONSTITUTION.md` has any content (about 34 KB). The other 13 are 0 bytes:

- `README.md`
- `CHANGELOG.md`
- All 11 files in `docs/`: PRODUCT\_REQUIREMENTS, SOFTWARE\_REQUIREMENTS, SYSTEM\_ARCHITECTURE, DATABASE\_SCHEMA, API\_DOCUMENTATION, UI\_UX\_GUIDELINES, SECURITY\_POLICY, TESTING\_STRATEGY, DEVELOPMENT\_ROADMAP, ARCHITECTURAL\_DECISIONS, DEPLOYMENT\_GUIDE

## What the constitution says

## Product

NyumbaLink is an Android rental-discovery app for Kwa Vonza and Kitui, Kenya. It is mobile-first, defaults to KES and Kenyan phone formats, and has to cope with weak connectivity and small data budgets.

## Stack (Art. 4)

Flutter and Dart, with Supabase for Postgres, Auth and Storage. GitHub, Figma and Android Studio are the tools, and Google Maps is subject to approval. No WebView wrapper, and no swapping the stack without founder approval.

## Users and MVP (Art. 5)

There are three roles:

- **House hunters:** browse, search, filter, favourite, enquire and report listings.
- **Landlords and agents:** create and manage their own listings and receive enquiries.
- **Admins:** moderate listings and reports. The admin role is never self-selected at signup.

Out of MVP unless authorised: AI recommendations, rent collection, payments, valuation, mortgages, commissions and legal agreements.

## Architecture and data (Art. 6–7)

The project uses a feature-based `lib/` layout (`core/`, `features/`, `shared/`) with a `supabase/migrations` folder. The proposed tables are `profiles`, `properties`, `property_images`, `favourites`, `enquiries`, `reports` and `notifications`. Prices use exact numeric types, and all schema changes go through migrations.

## Security (Art. 8)

- Supabase Auth only.
- RLS on all exposed tables, tested per role.
- No secrets in code and no service-role key in the app.
- Data minimisation, with the Kenya Data Protection Act 2019 reviewed before launch.

## Listing integrity (Art. 17)

Listings move through these statuses: submitted, pending, approved, rejected, suspended and occupied. A verification badge needs a real verification process, and approval alone doesn't count as "inspected".

## AI operating rules (Art. 11, 19, 21)

Before any task, Claude reads the constitution and relevant docs and inspects the code. It then plans, implements only authorised scope, verifies, updates the docs and reports. It must not claim untested things work, expand the MVP, or add paid services without approval.

## Phases (Art. 13)

1. Phase 0: Init
2. Phase 1: UI design
3. Phase 2: Backend foundation
4. Phase 3: Property management
5. Phase 4: Discovery
6. Phase 5: Communication and admin
7. Phase 6: Testing and security
8. Phase 7: Pilot

## Observations

- The constitution makes the other docs required reading, but they're all empty. Under its own hierarchy (Art. 11.2), SOFTWARE\_REQUIREMENTS and DATABASE\_SCHEMA are what implementation should follow, so at the moment there's nothing below the constitution to build against.
- There's no `lib/`, `pubspec.yaml` or `supabase/` in the zip, so it's Phase 0 with no code yet.
- Art. 21 says missing essential docs must be reported, not guessed at. So the logical next step is to fill the docs, starting with PRODUCT\_REQUIREMENTS, SOFTWARE\_REQUIREMENTS and DATABASE\_SCHEMA.
