# NyumbaLink

Rental property discovery app for Kwa Vonza and Kitui, Kenya. Native Android app built with Flutter and Dart, backed by Supabase.

## Status

**Phase 1: Interface design (in progress).** This is a clickable prototype with sample data. There is no backend, no payment and nothing is deployed.

| Item | State |
|---|---|
| Project constitution | Done (v1.0) |
| Requirements, architecture, schema | Draft v0.4 / v0.2. Phase 1 proceeds on the drafts (D13) |
| Step 1A foundation (theme, shared widgets, models, sample data, tests) | Written, **not yet verified** |
| Steps 1B to 1E (auth, tenant, landlord, admin web app) | Planned |
| Supabase project and schema | Not created |

NyumbaLink is a subsidiary of LGC'S GROUP.

## Running the prototype locally

`android/` and `web/` are not in the repository yet. Commit first, so you can review anything the next command changes, then:

```
flutter create --project-name nyumbalink --org com.lgcsgroup --platforms=android,web .
flutter pub get
dart format .
flutter analyze
flutter test
flutter run
```

`com.lgcsgroup` is a placeholder for the Android application ID prefix. Confirm it before any release.

## Where to start

1. Read [PROJECT_CONSTITUTION.md](PROJECT_CONSTITUTION.md). It is the highest authority.
2. Read the documents in `docs/`.
3. Check [CHANGELOG.md](CHANGELOG.md) for recent changes.

## Approved stack

Flutter, Dart, Supabase (PostgreSQL, Auth, Storage), GitHub, Figma, Android Studio. Google Maps is subject to approval.
