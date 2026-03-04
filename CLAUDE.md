# CLAUDE.md — iMaliChat Project Instructions

## Project Overview
iMaliChat is a Flutter mobile app with a Firebase (TypeScript) backend. It has a **separate admin web portal** sharing the same codebase. The app uses a client-funded token economy where brands pay users tokens for completing engagement tasks, with a double-entry ledger system.

## Architecture

### Flutter (Clean Architecture)
```
lib/
├── core/          # DI (Injectable/GetIt), security, theme, utils, constants
├── domain/        # Entities (Freezed), repository interfaces, enums, value objects
├── data/          # Models, datasources (Firestore + Cloud Functions), repository impls, mappers
├── presentation/  # BLoCs (Freezed events/states), screens, widgets, GoRouter, shell layouts
│   └── admin/     # Separate admin portal (own router, shell, screens)
├── main.dart      # Consumer app entry point
└── main_admin.dart # Admin portal entry point
```

### Cloud Functions (TypeScript)
```
functions/src/
├── index.ts           # Exports, scheduled jobs, ledger init
├── adminAccounts.ts   # Client CRUD + requireAdmin helper
├── earnAdmin.ts       # Thread/opportunity CRUD
├── engagement.ts      # Engagement lifecycle + scoring
├── wallet.ts          # Balance, transfers, sub-accounts
├── ledger/            # Double-entry bookkeeping system
└── ...
```

## Critical Commands

### Code Generation (run after ANY model/entity/DI change)
```bash
dart run build_runner build --delete-conflicting-outputs
```
This generates `.freezed.dart`, `.g.dart`, and `injection.config.dart` files. **Always run this after modifying Freezed classes, entities, models, or Injectable registrations.**

### Cloud Functions
```bash
cd functions && npm run build    # Compile TypeScript
cd functions && npm test         # Run Jest tests
firebase deploy --only functions # Deploy (ask user first!)
```

### Flutter
```bash
flutter analyze --fatal-infos    # Lint check
flutter test                     # Run unit tests
flutter build web --target lib/main_admin.dart -o build/admin  # Build admin portal
```

## Patterns & Conventions

### BLoC + Freezed (ALWAYS follow this pattern)
- Events: `@freezed class FooEvent with _$FooEvent { const factory FooEvent.doSomething() = _DoSomething; }`
- States: `@freezed class FooState with _$FooState { const factory FooState({...defaults...}) = _FooState; }`
- BLoCs are `@injectable` and registered via GetIt
- Use `on<EventType>` handlers, emit new states via `.copyWith()`
- Prefer one-shot Future calls over stream subscriptions for data fetching

### Dependency Injection
- All BLoCs, repositories, datasources marked `@injectable`
- Repository interfaces in `domain/repositories/`, implementations in `data/repositories/`
- Third-party registrations in `core/di/register_module.dart`
- After adding/removing an injectable class, run `build_runner`

### Routing (GoRouter)
- Consumer app: `lib/presentation/router/app_router.dart` — five-tab `StatefulShellRoute.indexedStack`
- Admin portal: `lib/presentation/admin/router/admin_router.dart` — role-based guards + sidebar shell
- Use GoRouter for ALL navigation. Do NOT use `Navigator.push()`.

### Entity / Model Separation
- **Entities** (`domain/entities/`): Freezed immutable, no JSON annotations, business logic only
- **Models** (`data/models/`): Extend or mirror entities, include `@JsonSerializable`, handle Firestore serialization
- **Mappers** (`data/mappers/`): Convert between entities and models
- When adding a field to an entity, also update the corresponding model, mapper, and any relevant datasource

### Firestore Conventions
- Soft-delete: always set BOTH `isDeleted: true` AND `isActive: false`
- Use `isAlive()` helper — Firestore `.exists` returns true for soft-deleted docs
- Collection names: camelCase (`earnThreads`, `earnOpportunities`, `engagements`)

### Cloud Functions Conventions
- Callable functions use `functions.https.onCall`
- Admin functions must call `requireAdmin(context)` at the top
- Ledger operations must be idempotent (use idempotency keys)
- Token math: 100 tokens = R1 ZAR; split is 90/5/5 (user/dailyPot/weeklyPot)

### Three-Level Earn Hierarchy
```
Client (Brand Partner)
 └── EarnThread (campaign row in inbox)
      └── EarnOpportunity (individual task)
           └── Engagement (user's attempt lifecycle)
```

## Files You Must Update Together
When modifying domain entities or data flow, these files often need coordinated changes:
- `domain/entities/` + `data/models/` + `data/mappers/` (entity fields)
- `domain/repositories/` + `data/repositories/` + `data/datasources/` (new methods)
- `presentation/blocs/` (new events/states for new features)
- `functions/src/` (backend counterpart for new Cloud Functions)

## Security Rules
- NEVER commit `.env`, `google-services.json`, `GoogleService-Info.plist`, `key.properties`, or `*.keystore` files
- NEVER commit Firebase service account keys or API keys
- The app uses RASP (freeRASP), device binding, biometric auth, and session locks
- Admin portal has role-based access: `superAdmin`, `financeAdmin`, `campaignAdmin`, `platformAdmin`, `auditor`

## Testing
- BLoC tests use `bloc_test` package with `blocTest<Bloc, State>()` helper
- Mocking with `mocktail` (not mockito)
- Test files mirror source structure in `test/`

## Ledger System
- Double-entry bookkeeping in `functions/src/ledger/`
- Every debit has a corresponding credit — never create one-sided entries
- System accounts: `CBOOK_BUS`, `CBOOK_TRUST`, `DAILY_POT`, `WEEKLY_POT`, `ENGAGEMENT_ESCROW`
- `getOrCreateBrandSubAccount` already exists in `ledger/index.ts` — don't duplicate it
- Budget pre-check at `startEngagement` prevents poor UX

## Code Quality Criteria (MANDATORY)
All code written or modified must satisfy ALL of the following:
1. **Clean Architecture compliance** — respect layer boundaries (domain → data → presentation), no layer violations
2. **Coding best practices** — SOLID principles, DRY, meaningful naming, small focused functions
3. **Fully deterministic** — no undefined behavior, no reliance on execution order unless explicitly sequenced; where true determinism is impossible (e.g., network calls, concurrency), make behavior as deterministic as possible with clear fallback/retry semantics
4. **No race conditions** — use proper synchronization (Completers, mutexes, sequential awaits); verify that concurrent access to shared state is safe; two-phase startup patterns where initialization order matters
5. **Edge case coverage** — identify all edge cases (null values, empty collections, network failures, partial data, timeout, re-entrant calls) and either eliminate them or handle them explicitly

Always check code against these five criteria before considering a task complete.

## Do NOT
- Create new top-level TypeScript files for admin functions — extend `adminAccounts.ts` or `earnAdmin.ts`
- Use `Navigator.push()` — use GoRouter everywhere
- Use stream subscriptions for earn data — use one-shot Future calls
- Skip running `build_runner` after Freezed/Injectable changes
- **NEVER run `firebase deploy` (any variant) without explicit user approval first** — always ask and wait for confirmation before deploying anything to Firebase
- Push code (`git push`) without asking first
- Add unused imports, dead code, or speculative abstractions
