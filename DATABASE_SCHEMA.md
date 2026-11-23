# NyumbaLink: Database Schema

**Version:** 0.2 (DRAFT PROPOSAL, pending founder approval)
**Derived from:** Constitution Art. 7, 8, 17; SOFTWARE_REQUIREMENTS v0.3
**Implementation status:** Nothing here exists. No Supabase project has been created and no migration written. DDL is illustrative and becomes a version-controlled migration in Phase 2 after approval (Art. 7.4).

Items marked **[confirm]** depend on an unanswered question (Q numbers refer to SOFTWARE_REQUIREMENTS section 7).

## 1. What changed from v0.1

- `enquiries` removed: contact now happens by phone outside the platform (D9).
- `payments` and `fee_tiers` added for the pay-to-view model (D8).
- Exact coordinates moved to `property_locations`, and landlord phone is no longer readable through `profiles` by other users. Row Level Security works on whole rows, so anything a tenant must not see before paying has to live in a table or function the tenant cannot read freely.
- `property_images` gains a blurred version.

## 2. Entities

| Table | Purpose |
|---|---|
| `profiles` | One row per tenant or landlord, including phone number |
| `properties` | Listing facts that are visible before payment |
| `property_locations` | Exact coordinates, visible only after payment |
| `property_images` | Photos: a blurred version for everyone, the full version after payment |
| `favourites` | Tenant-saved listings |
| `fee_tiers` | Fee by rent band, so prices are data and not hardcoded |
| `payments` | Every M-PESA payment attempt and result; a paid row is the unlock |
| `reports` | Suspicious-listing and paid-listing reports |
| `notifications` | In-app notifications |
| `admin_users` | Admin accounts, separate from `profiles` (D5) |
| `account_restrictions` | Admin-applied restrictions |
| `moderation_log` | Record of admin actions, including refunds |

## 3. Types

```sql
create type user_role as enum ('tenant', 'landlord');            -- no 'admin', by design
create type listing_status as enum
  ('submitted', 'pending', 'approved', 'rejected', 'suspended', 'occupied');   -- Art. 17
create type verification_status as enum ('unverified', 'verified');
create type payment_status as enum
  ('initiated', 'pending', 'paid', 'failed', 'cancelled', 'timed_out', 'refunded');
create type report_status as enum ('open', 'investigating', 'resolved', 'dismissed');
```

## 4. Tables (draft DDL)

```sql
create table profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  role        user_role not null,                 -- set once at signup, immutable
  full_name   text not null,
  phone       text not null check (phone ~ '^\+254[17][0-9]{8}$'),   -- confirm format rules
  created_at  timestamptz not null default now()
);                                                 -- email and its verification live in auth.users

create table properties (
  id                  uuid primary key default gen_random_uuid(),
  landlord_id         uuid not null references profiles(id),
  title               text not null,
  description         text not null,
  category            text not null,              -- [confirm] categories
  price_kes           numeric(12,2) not null check (price_kes >= 0),
  currency            char(3) not null default 'KES',
  bedrooms            smallint check (bedrooms >= 0),
  bathrooms           smallint check (bathrooms >= 0),
  area_name           text not null,              -- searchable, visible before payment
  status              listing_status not null default 'submitted',
  verification_status verification_status not null default 'unverified',
  verified_at         timestamptz,
  deleted_at          timestamptz,                -- soft delete [confirm Q8]
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);
create index on properties (status, area_name) where deleted_at is null;
create index on properties (price_kes) where deleted_at is null;
create index on properties (landlord_id);

create table property_locations (                 -- hidden until paid
  property_id uuid primary key references properties(id) on delete cascade,
  latitude    double precision not null check (latitude between -90 and 90),
  longitude   double precision not null check (longitude between -180 and 180)
);

create table property_images (
  id            uuid primary key default gen_random_uuid(),
  property_id   uuid not null references properties(id) on delete cascade,
  full_path     text not null,                    -- full photo: protected
  blurred_path  text not null,                    -- small blurred copy: shown before payment
  sort_order    smallint not null default 0,
  created_at    timestamptz not null default now()
);                                                 -- [confirm] max photos per listing (suggest 8)

create table favourites (
  tenant_id    uuid not null references profiles(id) on delete cascade,
  property_id  uuid not null references properties(id) on delete cascade,
  created_at   timestamptz not null default now(),
  primary key (tenant_id, property_id)
);

create table fee_tiers (                           -- changed by the founder via migration or admin RPC
  id          smallint primary key,
  rent_from   numeric(12,2) not null,            -- exclusive lower bound
  rent_to     numeric(12,2),                     -- inclusive upper bound; null = no cap
  fee_kes     numeric(12,2) not null check (fee_kes > 0)
);
-- Seed per D8, with the gap flagged [Q1]:
--   0 to 3000       -> 200
--   3000 to 5000    -> 500
--   5000 and above  -> 600   (ASSUMES the 5,001 to 6,000 gap is covered; confirm)

create table payments (
  id                   uuid primary key default gen_random_uuid(),
  tenant_id            uuid not null references profiles(id),
  property_id          uuid not null references properties(id),
  amount_kes           numeric(12,2) not null check (amount_kes > 0),   -- computed on the server
  phone                text not null,            -- number the prompt was sent to
  status               payment_status not null default 'initiated',
  merchant_request_id  text,
  checkout_request_id  text unique,              -- M-PESA's identifier; callbacks are matched on it
  mpesa_receipt        text unique,              -- set when paid
  result_code          text,
  result_desc          text,
  created_at           timestamptz not null default now(),
  paid_at              timestamptz,
  refunded_at          timestamptz,
  refunded_by          uuid references admin_users(user_id)
);
create unique index one_paid_unlock on payments (tenant_id, property_id) where status = 'paid';
create unique index one_open_attempt on payments (tenant_id, property_id)
  where status in ('initiated', 'pending');       -- no repeated prompts while one is in progress

create table reports (
  id           uuid primary key default gen_random_uuid(),
  property_id  uuid not null references properties(id),
  reporter_id  uuid not null references profiles(id),
  payment_id   uuid references payments(id),     -- set when reporting a paid listing (refund requests)
  reason       text not null,
  details      text,
  status       report_status not null default 'open',
  handled_by   uuid references admin_users(user_id),
  created_at   timestamptz not null default now(),
  resolved_at  timestamptz,
  unique (property_id, reporter_id)
);

create table notifications (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references profiles(id) on delete cascade,
  type        text not null,                     -- see SOFTWARE_REQUIREMENTS FR-NOTIF-01 [Q13]
  payload     jsonb not null default '{}',
  read_at     timestamptz,
  created_at  timestamptz not null default now()
);

create table admin_users (
  user_id     uuid primary key references auth.users(id) on delete cascade,
  created_at  timestamptz not null default now()
);

create table account_restrictions (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references profiles(id),
  reason      text not null,
  imposed_by  uuid not null references admin_users(user_id),
  imposed_at  timestamptz not null default now(),
  lifted_at   timestamptz
);

create table moderation_log (
  id          uuid primary key default gen_random_uuid(),
  admin_id    uuid not null references admin_users(user_id),
  action      text not null,                      -- approve, reject, suspend, verify, restrict, refund, ...
  property_id uuid references properties(id),
  report_id   uuid references reports(id),
  payment_id  uuid references payments(id),
  user_id     uuid references profiles(id),
  note        text,
  created_at  timestamptz not null default now()
);
```

## 5. Rules enforced in the database

1. **Role assignment.** The first-screen choice is passed at signup. A trigger creates the `profiles` row and accepts only `tenant` or `landlord`. A trigger rejects later role changes.
2. **Admins are separate.** Admins exist only in `admin_users`, have no `profiles` row, and use dedicated accounts. Clients cannot read or write `admin_users`.
3. **`is_admin()`** is a `security definer` function checking `admin_users`. The admin section needs no service-role key (Art. 8.4).
4. **Email gate.** Creating a listing and starting a payment require a verified email (`auth.users.email_confirmed_at`).
5. **Fee calculation.** `fee_for_rent(price)` reads `fee_tiers` and returns the fee. If no tier matches (the Q1 gap), it raises an error and no payment starts. It never defaults to a price.
6. **Payments are written only by the server.** Clients cannot insert or update `payments`. Edge Functions do this with a server-side key kept in function secrets. Tenants can read their own rows.
7. **Contact reveal.** `get_contact(property_id)` is a `security definer` function. It returns the landlord's phone only when the caller is an admin, the listing's owner, or a tenant with a `paid` row for that listing. Landlord phone numbers are not readable through `profiles` by other users.
8. **Landlord edits [confirm Q7].** A trigger moves an `approved` listing to `pending` when price, location or photos change.
9. **Landlords cannot set** `status` to `approved` or `suspended`, or touch `verification_status`. They can set `occupied` and `deleted_at`.
10. **Phone numbers in text.** A check rejects Kenyan-style phone numbers in `title` and `description` (best effort, FR-LIST-08).
11. **`updated_at`** is maintained by a trigger.
12. **Moderation and refund actions** go through RPC functions that change the row and write `moderation_log` in one transaction.

## 6. Row Level Security (draft policy matrix)

RLS is enabled on every table. "Own" means the row belongs to `auth.uid()`. "Paid" means the tenant has a `paid` payment for that listing.

| Table | Tenant | Landlord | Admin |
|---|---|---|---|
| `properties` | read approved, not deleted | read/insert/update own; read approved | read all; status via RPC |
| `property_locations` | read only if paid | read/write own | read all |
| `property_images` | read `blurred_path`; `full_path` only if paid (see storage) | write own | read all |
| `profiles` | read/update own | read/update own | read all |
| `favourites` | full control of own | none | none |
| `fee_tiers` | read | read | read |
| `payments` | read own; no writes | none | read all; refunds via RPC |
| `reports` | insert; read own | none | read all; update |
| `notifications` | read/update own | read/update own | none |
| `admin_users`, `account_restrictions`, `moderation_log` | none | none | read; writes via RPC |

Anonymous (not signed in) users read nothing: accounts are required (D7).

Because column-level hiding is not what RLS does, the `properties` columns visible to tenants (title, description, price, area, bedrooms and so on) are the "visible before payment" set. Moving a field from visible to hidden means moving it to a protected table [Q2].

## 7. Storage

Private bucket `property-images`. Landlords write only under `{landlord_id}/{property_id}/`.
- Blurred copies: readable by signed-in users for approved listings.
- Full photos: readable by the owner, admins, and tenants with a `paid` row for that listing, through a storage policy that checks `payments`.
- Photos are compressed and a blurred copy is made on the device before upload (Art. 9.3, 16). A landlord device could upload a clear image as the "blurred" copy, so admin review includes checking that blurred copies are blurred.

## 8. Account deletion and records (Art. 8.5)

Payment, report and moderation records are financial and evidentiary records. Foreign keys deliberately do not cascade from `profiles` to `properties`, `payments` or `reports`. What is erased, anonymised or retained, and for how long, must be defined with legal advice before commercial launch.
