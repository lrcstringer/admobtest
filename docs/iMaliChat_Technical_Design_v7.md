# iMaliChat Technical Design Document

**Version 7.0 — January 2026**

*Complete Architecture & Implementation Specification*

*Integrating: Clean Architecture, Firebase Cloud Functions, Firestore Security Rules, UI/UX Design, and Fraud Prevention*

*Flutter + Firebase + G-PAY Integration*

---

## Table of Contents

- [PART I: Architecture Overview](#part-i-architecture-overview)
- [PART II: Core Layer](#part-ii-core-layer)
- [PART III: Domain Layer](#part-iii-domain-layer)
- [PART IV: Data Layer](#part-iv-data-layer)
- [PART V: Presentation Layer](#part-v-presentation-layer)
- [PART VI: Firebase Cloud Functions](#part-vi-firebase-cloud-functions)
- [PART VII: Firestore Security Rules](#part-vii-firestore-security-rules)
- [PART VIII: UI/UX Design System](#part-viii-uiux-design-system)
- [PART IX: Fraud Prevention System](#part-ix-fraud-prevention-system)
- [PART X: Testing Strategy & Appendices](#part-x-testing-strategy--appendices)

---

# PART I: ARCHITECTURE OVERVIEW

## 1. Clean Architecture Principles

The application follows Uncle Bob's Clean Architecture with strict dependency rules ensuring maintainability, testability, and separation of concerns.

### 1.1 Layer Dependency Rules

- Dependencies point INWARD only — outer layers depend on inner layers
- Domain layer has ZERO dependencies on frameworks or external services
- Data layer implements repository interfaces defined in the Domain
- Presentation layer depends on Domain use cases, NEVER on Data sources directly
- Core layer provides shared utilities available to all layers

### 1.2 Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │   BLoCs     │  │   Pages     │  │       Widgets           │  │
│  │   Cubits    │  │   Screens   │  │    UI Components        │  │
│  └──────┬──────┘  └─────────────┘  └─────────────────────────┘  │
│         │ depends on                                             │
├─────────┼───────────────────────────────────────────────────────┤
│         ▼               DOMAIN LAYER                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │  Use Cases  │  │  Entities   │  │  Repository Interfaces  │  │
│  │             │  │Value Objects│  │       (Abstract)        │  │
│  └──────┬──────┘  └─────────────┘  └────────────┬────────────┘  │
│         │                          implemented by│               │
├─────────┼───────────────────────────────────────┼───────────────┤
│         │               DATA LAYER              ▼               │
│  ┌──────┴──────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │ Repository  │  │    DTOs     │  │      Data Sources       │  │
│  │   Impls     │  │   Mappers   │  │   Remote  │   Local     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│                         CORE LAYER                               │
│   DI Setup │ Error Handling │ Network Info │ Constants │ Utils  │
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| Mobile App | Flutter 3.x + Dart | Cross-platform iOS/Android |
| State Management | BLoC + Freezed | Predictable state, code generation |
| Local Database | Drift (SQLite) | Offline-first data persistence |
| Backend | Firebase Cloud Functions | Serverless business logic |
| Database | Firestore | Real-time NoSQL document store |
| Analytics | BigQuery + GA4 | Event analytics and reporting |
| Push Notifications | FCM | User engagement |
| Video Hosting | Cloudflare Stream | Ad video delivery |
| Payments | G-PAY API | Wallet infrastructure |
| Device Security | Play Integrity API | Anti-fraud device checks |

### 1.4 Data Ownership Model

> **CRITICAL ARCHITECTURE CLARIFICATION:** iMaliChat is the primary data owner. G-PAY provides payment infrastructure only.

| Data Domain | Source of Truth | Notes |
|-------------|-----------------|-------|
| User profiles, preferences | iMaliChat Firestore | We own all user data |
| Engagements, videos, surveys | iMaliChat Firestore | Core business logic |
| Gamification (scores, streaks, pots) | iMaliChat Firestore | G-PAY has no concept of this |
| Referrals, fraud flags | iMaliChat Firestore | Our business rules |
| Chat threads/cards | iMaliChat Firestore | P2P money chat |
| Wallet balance | G-PAY API | G-PAY is authoritative |
| Transaction ledger | G-PAY API | Immutable payment history |
| Cash-out/off-ramp status | G-PAY API | Payment processing |

### 1.5 Package Structure

```
packages/
├── core/           # Shared utilities (no dependencies)
│   ├── constants/  # App constants
│   ├── di/         # Dependency injection
│   ├── errors/     # Error handling
│   ├── network/    # Network utilities
│   └── utils/      # Helpers
├── domain/         # Business logic (depends on: core)
│   ├── entities/   # 19 entities
│   ├── value_objects/  # 4 value objects
│   ├── enums/      # 8 enums
│   ├── repositories/   # 10 repository interfaces
│   └── usecases/   # 29 use cases
├── data/           # Data access (depends on: domain, core)
│   ├── repositories/   # Repository implementations
│   ├── datasources/    # Remote & Local data sources
│   ├── models/     # DTOs
│   └── mappers/    # Entity <-> DTO mappers
└── ui_kit/         # Shared UI (depends on: core)
    ├── theme/      # Colors, typography
    └── widgets/    # Reusable components
```

---

# PART II: CORE LAYER

## 2. Core Layer - Constants & Configuration

The Core layer provides shared utilities and constants used across all other layers. It has zero dependencies on other application layers.

### 2.1 Application Constants

```dart
// packages/core/lib/constants/app_constants.dart
abstract class AppConstants {
  // Token Economics
  static const double tokenValueZar = 0.01;
  static const int rewardStdTokens = 5;
  static const int rewardBonusTokens = 10;
  static const double bonusShare = 0.20;

  // Reward Splits
  static const double splitUser = 0.90;
  static const double splitDailyPot = 0.05;
  static const double splitWeeklyPot = 0.05;

  // Caps & Limits
  static const int dailyEarnCap = 30;
  static const int cashoutMinTokens = 500;
  static const int chatSendDailyCapTokens = 50000;
  static const int chatRequestMaxTokens = 20000;

  // Eligibility
  static const int newUserPotLockHours = 48;
  static const int firstCashoutEligibilityDays = 7;
  static const int firstCashoutHoldHours = 48;

  // Streaks (score multipliers)
  static const Map<int, double> streakMultipliers = {
    3: 1.20,   // +20% at 3 days
    7: 1.35,   // +35% at 7 days
    14: 1.50,  // +50% at 14 days
  };

  // Pot Distributions
  static const List<double> dailyPotSplits = [0.40, 0.25, 0.20, 0.10, 0.05];
  static const int weeklyPotTopN = 10;

  // Referrals
  static const int refStarterTokens = 10;
  static const int refMilestoneTokens = 40;
  static const int refMilestoneActions = 25;
  static const int refMilestoneDays = 14;
  static const double refAssistScorePercent = 0.20;
  static const int refAssistScoreDailyCap = 8;

  // Pot Close Times (SAST = UTC+2)
  static const int dailyPotCloseHour = 20; // 8pm SAST
  static const int weeklyPotCloseDay = 7;  // Sunday
}
```

### 2.2 System Constants Table

| Constant | Default | Notes |
|----------|---------|-------|
| TOKEN_VALUE_ZAR | R0.01 | 1 token = R0.01 |
| REWARD_STD_TOKENS | 5 | Standard earn message |
| REWARD_BONUS_TOKENS | 10 | Bonus earn message (every 5th) |
| BONUS_SHARE | 20% | Share of messages that are bonus |
| WATCH_THRESHOLD | Full video / 3s image | Unlock survey at threshold |
| DAILY_EARN_CAP_TOTAL | 30 | Max completions per day |
| SPLIT_USER/DAILY/WEEKLY | 90/5/5 | Reward distribution |
| DAILY_POT_CLOSE | 19:59:59 SAST | Daily pot closes 8pm |
| WEEKLY_POT_CLOSE | Sun 19:59:59 SAST | Weekly pot closes Sunday 8pm |
| NEW_USER_POT_LOCK | 48h | Pot ineligibility for new users |
| FIRST_CASHOUT_ELIGIBILITY | 7 days | Minimum days before cashout |
| CASHOUT_MIN_TOKENS | 500 | R5.00 minimum cashout |
| STREAK_MULTIPLIERS | +20%/+35%/+50% | @3d/@7d/@14d (score only) |
| REF_STARTER | 10+10 tokens | Referrer + friend bonus |
| REF_MILESTONE | 40 tokens | At 25 actions in 14 days |
| CHAT_SEND_DAILY_CAP | 50,000 tokens | R500/day send limit |

### 2.3 Error Handling

```dart
// packages/core/lib/errors/failures.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  // Network
  const factory Failure.network({String? message}) = NetworkFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.noInternet() = NoInternetFailure;
  
  // Auth
  const factory Failure.unauthenticated() = UnauthenticatedFailure;
  const factory Failure.invalidOtp() = InvalidOtpFailure;
  const factory Failure.otpExpired() = OtpExpiredFailure;
  const factory Failure.tooManyAttempts() = TooManyAttemptsFailure;
  
  // Business Logic
  const factory Failure.dailyCapReached() = DailyCapReachedFailure;
  const factory Failure.insufficientBalance() = InsufficientBalanceFailure;
  const factory Failure.cashoutNotEligible() = CashoutNotEligibleFailure;
  const factory Failure.potNotEligible() = PotNotEligibleFailure;
  const factory Failure.userSuspended() = UserSuspendedFailure;
  
  // Validation
  const factory Failure.invalidPhone() = InvalidPhoneFailure;
  const factory Failure.invalidUsername() = InvalidUsernameFailure;
  const factory Failure.invalidAmount() = InvalidAmountFailure;
  
  // Server
  const factory Failure.serverError({String? code, String? message}) = ServerFailure;
  const factory Failure.unknown({String? message}) = UnknownFailure;
}
```

### 2.4 Dependency Injection Setup

```dart
// packages/core/lib/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

// packages/core/lib/di/modules/firebase_module.dart
@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  
  @lazySingleton
  FirebaseAuth get auth => FirebaseAuth.instance;
  
  @lazySingleton
  FirebaseFunctions get functions => FirebaseFunctions.instance;
  
  @lazySingleton
  FirebaseMessaging get messaging => FirebaseMessaging.instance;
}
```

---

# PART III: DOMAIN LAYER

## 3. Domain Layer - Entities, Repositories, Use Cases

The Domain layer contains the business logic and is completely independent of any frameworks, databases, or UI. It defines WHAT the application does.

### 3.1 Package Structure

```
packages/domain/lib/
├── domain.dart           # Barrel export
├── entities/             # 19 entities
│   ├── user.dart
│   ├── user_profile.dart
│   ├── wallet.dart
│   ├── transaction.dart
│   ├── video.dart
│   ├── survey.dart
│   ├── engagement.dart
│   ├── earn_thread.dart
│   ├── earn_message.dart
│   ├── chat_thread.dart
│   ├── chat_card.dart
│   ├── user_score.dart
│   ├── pot_pool.dart
│   ├── pot_distribution.dart
│   ├── referral.dart
│   ├── cashout.dart
│   ├── purchase.dart
│   ├── provider.dart
│   └── campaign.dart
├── value_objects/        # 4 value objects
│   ├── phone_number.dart
│   ├── token_amount.dart
│   ├── username.dart
│   └── engagement_evidence.dart
├── enums/                # 8 enums
│   ├── user_status.dart
│   ├── transaction_type.dart
│   ├── engagement_status.dart
│   ├── chat_card_type.dart
│   ├── chat_card_status.dart
│   ├── pot_type.dart
│   ├── cashout_status.dart
│   └── sync_status.dart
├── repositories/         # 10 repository interfaces
│   ├── auth_repository.dart
│   ├── user_repository.dart
│   ├── wallet_repository.dart
│   ├── engagement_repository.dart
│   ├── earn_inbox_repository.dart
│   ├── chat_repository.dart
│   ├── gamification_repository.dart
│   ├── referral_repository.dart
│   ├── purchase_repository.dart
│   └── campaign_repository.dart
└── usecases/             # 29 use cases
    ├── auth/
    ├── earn/
    ├── wallet/
    ├── chat/
    ├── gamification/
    ├── referrals/
    ├── buy/
    └── admin/
```

### 3.2 Core Entities

#### 3.2.1 User Entity

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required PhoneNumber phoneNumber,
    required UserStatus status,
    required bool isPotEligible,
    required DateTime createdAt,
    DateTime? potEligibleAt,
    String? currentVisitorId,
    UserProfile? profile,
    ConsentRecord? consent,
    DeviceInfo? deviceInfo,
    int? riskScore,
  }) = _User;
  
  const User._();
  
  bool get isVerified => status == UserStatus.active;
  bool get canEarn => isVerified && profile != null;
  bool get canCashout {
    final daysSinceSignup = DateTime.now().difference(createdAt).inDays;
    return daysSinceSignup >= AppConstants.firstCashoutEligibilityDays;
  }
  bool get isPotEligibleNow {
    if (!isPotEligible) return false;
    if (potEligibleAt == null) return false;
    return DateTime.now().isAfter(potEligibleAt!);
  }
}
```

#### 3.2.2 Wallet Entity

```dart
@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String id,
    required String userId,
    required TokenAmount balance,
    required TokenAmount lifetimeEarned,
    required TokenAmount lifetimeWithdrawn,
    required int version,
    required DateTime updatedAt,
  }) = _Wallet;
  
  const Wallet._();
  
  bool get canCashout => balance >= TokenAmount(AppConstants.cashoutMinTokens);
  int get tokensToNextCashout => max(0, AppConstants.cashoutMinTokens - balance.value);
  double get balanceZar => balance.value * AppConstants.tokenValueZar;
}
```

#### 3.2.3 Engagement Entity

```dart
@freezed
class Engagement with _$Engagement {
  const factory Engagement({
    required String id,
    required String userId,
    required String visitorId,
    required String videoId,
    required EngagementStatus status,
    required DateTime startedAt,
    DateTime? videoCompletedAt,
    DateTime? surveyCompletedAt,
    int? watchDurationMs,
    double? attentionScore,
    Map<String, String>? surveyAnswers,
    TokenAmount? tokensEarned,
    double? scoreEarned,
    EngagementEvidence? evidence,
    SyncStatus? syncStatus,
  }) = _Engagement;
  
  const Engagement._();
  
  bool get isRewarded => status == EngagementStatus.rewarded;
  bool get canSubmitSurvey => status == EngagementStatus.videoCompleted;
}
```

#### 3.2.4 ChatCard Entity (Money Chat)

```dart
@freezed
class ChatCard with _$ChatCard {
  const factory ChatCard({
    required String id,
    required String threadId,
    required ChatCardType type,
    required ChatCardStatus status,
    required String senderId,
    required String recipientId,
    required TokenAmount amount,
    required DateTime createdAt,
    DateTime? dueDate,
    DateTime? paidAt,
    String? transactionId,
    bool? reminderSent,
  }) = _ChatCard;
  
  const ChatCard._();
  
  bool get isPending => status == ChatCardStatus.pending;
  bool get canPay => type == ChatCardType.request && status == ChatCardStatus.pending;
  bool get isExpired => dueDate != null && DateTime.now().isAfter(dueDate!) && status == ChatCardStatus.pending;
}
```

#### 3.2.5 UserScore Entity (Gamification)

```dart
@freezed
class UserScore with _$UserScore {
  const factory UserScore({
    required String userId,
    required int dailyScore,
    required int weeklyScore,
    required int dailyCompletions,
    required int weeklyCompletions,
    required int streakDays,
    required int dailyRank,
    required int weeklyRank,
    required String? lastActiveDate,
    required DateTime updatedAt,
  }) = _UserScore;
  
  const UserScore._();
  
  double get streakMultiplier {
    if (streakDays >= 14) return AppConstants.streakMultipliers[14]!;
    if (streakDays >= 7) return AppConstants.streakMultipliers[7]!;
    if (streakDays >= 3) return AppConstants.streakMultipliers[3]!;
    return 1.0;
  }
}
```

### 3.3 Value Objects

```dart
// PhoneNumber Value Object
@freezed
class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber(String value) = _PhoneNumber;
  const PhoneNumber._();
  
  static Either<Failure, PhoneNumber> create(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^0-9+]'), '');
    if (cleaned.length < 10 || cleaned.length > 15) {
      return left(const Failure.invalidPhone());
    }
    final normalized = cleaned.startsWith('0') 
        ? '+27${cleaned.substring(1)}' 
        : cleaned;
    return right(PhoneNumber(normalized));
  }
  
  String get displayFormat {
    // +27821234567 -> 082 123 4567
    if (value.startsWith('+27') && value.length == 12) {
      return '0${value.substring(3, 5)} ${value.substring(5, 8)} ${value.substring(8)}';
    }
    return value;
  }
}

// TokenAmount Value Object
@freezed
class TokenAmount with _$TokenAmount {
  const factory TokenAmount(int value) = _TokenAmount;
  const TokenAmount._();
  
  double get asZar => value * AppConstants.tokenValueZar;
  String get displayZar => 'R${asZar.toStringAsFixed(2)}';
  String get displayTokens => '$value tokens';
  
  TokenAmount operator +(TokenAmount other) => TokenAmount(value + other.value);
  TokenAmount operator -(TokenAmount other) => TokenAmount(value - other.value);
  bool operator >=(TokenAmount other) => value >= other.value;
}
```

### 3.4 Enums

```dart
enum UserStatus { pending, active, suspended, banned }

enum TransactionType {
  earn, potWin, p2pSend, p2pReceive, cashout, 
  refund, referral, purchase, adjustment, reversal
}

enum EngagementStatus {
  started, videoCompleted, surveyCompleted, rewarded, failed, expired, reversed
}

enum ChatCardType { send, request }
enum ChatCardStatus { pending, paid, declined, expired, cancelled }
enum PotType { daily, weekly }
enum CashoutStatus { pending, held, processing, completed, failed, reversed }
enum SyncStatus { pending, synced, failed }
```

### 3.5 Repository Interfaces

```dart
// AuthRepository
abstract class AuthRepository {
  Future<Either<Failure, Unit>> requestOtp(PhoneNumber phone);
  Future<Either<Failure, User>> verifyOtp(PhoneNumber phone, String code);
  Future<Either<Failure, User?>> getCurrentUser();
  Stream<User?> get authStateChanges;
  Future<Either<Failure, Unit>> signOut();
}

// WalletRepository
abstract class WalletRepository {
  Future<Either<Failure, Wallet>> getWallet();
  Stream<Wallet> watchWallet();
  Future<Either<Failure, List<Transaction>>> getTransactions({
    int limit = 20, DateTime? before, TransactionType? type
  });
  Future<Either<Failure, Cashout>> requestCashout({
    required TokenAmount amount,
    required CashoutMethod method,
    required Map<String, dynamic> destination
  });
}

// EngagementRepository
abstract class EngagementRepository {
  Future<Either<Failure, Engagement>> startEngagement(String videoId);
  Future<Either<Failure, EngagementResult>> submitSurvey(
    String engagementId, 
    Map<String, String> answers, 
    EngagementEvidence evidence
  );
  Future<Either<Failure, int>> getDailyCompletionCount();
}

// ChatRepository (Money Chat)
abstract class ChatRepository {
  Stream<List<ChatThread>> watchThreads();
  Stream<List<ChatCard>> watchCards(String threadId);
  Future<Either<Failure, ChatCard>> sendTokens({
    required PhoneNumber recipient,
    required TokenAmount amount
  });
  Future<Either<Failure, ChatCard>> createRequest({
    required PhoneNumber recipient,
    required TokenAmount amount,
    DateTime? dueDate
  });
  Future<Either<Failure, ChatCard>> payRequest(String cardId);
  Future<Either<Failure, ChatCard>> declineRequest(String cardId);
}

// GamificationRepository
abstract class GamificationRepository {
  Stream<UserScore> watchScore();
  Stream<PotPool> watchDailyPot();
  Stream<PotPool> watchWeeklyPot();
  Future<Either<Failure, List<LeaderboardEntry>>> getLeaderboard(PotType type);
}
```

### 3.6 Use Cases Catalog

| Category | Use Case | Description |
|----------|----------|-------------|
| Auth | RequestOtpUseCase | Send OTP to phone number |
| Auth | VerifyOtpUseCase | Verify OTP and create/login user |
| Auth | GetCurrentUserUseCase | Get authenticated user |
| Auth | SignOutUseCase | Sign out current user |
| Earn | GetEarnInboxUseCase | Get list of earn threads |
| Earn | StartEngagementUseCase | Start watching a video |
| Earn | SubmitSurveyUseCase | Submit survey answers and claim reward |
| Earn | GetDailyProgressUseCase | Get completions today vs cap |
| Wallet | GetWalletUseCase | Get current wallet balance |
| Wallet | WatchWalletUseCase | Stream wallet changes |
| Wallet | GetTransactionsUseCase | Get transaction history |
| Wallet | RequestCashoutUseCase | Initiate cashout |
| Chat | GetChatThreadsUseCase | Get money chat threads |
| Chat | SendTokensUseCase | Send tokens to another user |
| Chat | CreateRequestUseCase | Request tokens from another user |
| Chat | PayRequestUseCase | Pay a token request |
| Chat | DeclineRequestUseCase | Decline a token request |
| Gamification | GetUserScoreUseCase | Get user's gamification score |
| Gamification | GetLeaderboardUseCase | Get pot leaderboard |
| Gamification | WatchPotsUseCase | Stream pot totals |
| Referrals | GetReferralLinkUseCase | Generate referral link |
| Referrals | GetReferralsUseCase | Get list of referred users |
| Referrals | InviteContactsUseCase | Send WhatsApp invites |
| Buy | GetProvidersUseCase | Get airtime/electricity providers |
| Buy | PurchaseAirtimeUseCase | Buy airtime/data |
| Buy | PurchaseElectricityUseCase | Buy prepaid electricity |
| Profile | UpdateProfileUseCase | Update user profile |
| Profile | UpdateSettingsUseCase | Update notification settings |
| Admin | GetFraudQueueUseCase | Get pending fraud reviews |

---

# PART IV: DATA LAYER

## 4. Data Layer - Implementations & Data Sources

The Data layer implements the repository interfaces defined in the Domain layer. It handles all data access, persistence, and external service communication.

### 4.1 Package Structure

```
packages/data/lib/
├── data.dart             # Barrel export
├── repositories/         # Repository implementations
│   ├── auth_repository_impl.dart
│   ├── wallet_repository_impl.dart
│   ├── engagement_repository_impl.dart
│   ├── chat_repository_impl.dart
│   ├── gamification_repository_impl.dart
│   └── ...
├── datasources/
│   ├── remote/           # Firebase, Cloud Functions
│   │   ├── firebase_auth_source.dart
│   │   ├── firestore_source.dart
│   │   └── functions_source.dart
│   └── local/            # Drift SQLite
│       ├── drift_database.dart
│       └── tables/
├── models/               # DTOs
│   ├── user_dto.dart
│   ├── wallet_dto.dart
│   ├── engagement_dto.dart
│   └── ...
└── mappers/              # Entity <-> DTO
    ├── user_mapper.dart
    ├── wallet_mapper.dart
    └── ...
```

### 4.2 Repository Implementation Example

```dart
// EngagementRepositoryImpl
@LazySingleton(as: EngagementRepository)
class EngagementRepositoryImpl implements EngagementRepository {
  final FirestoreSource _firestore;
  final FunctionsSource _functions;
  final DriftDatabase _local;
  final NetworkInfo _networkInfo;
  
  EngagementRepositoryImpl(
    this._firestore,
    this._functions,
    this._local,
    this._networkInfo,
  );
  
  @override
  Future<Either<Failure, Engagement>> startEngagement(String videoId) async {
    try {
      final userId = _firestore.currentUserId;
      if (userId == null) return left(const Failure.unauthenticated());
      
      // Check daily cap locally first
      final todayCount = await _local.getEngagementCountToday(userId);
      if (todayCount >= AppConstants.dailyEarnCap) {
        return left(const Failure.dailyCapReached());
      }
      
      // Create engagement document
      final engagementRef = _firestore.engagements.doc();
      final engagement = EngagementDto(
        id: engagementRef.id,
        userId: userId,
        videoId: videoId,
        status: EngagementStatus.started.name,
        startedAt: DateTime.now(),
      );
      
      await engagementRef.set(engagement.toJson());
      
      // Store locally for offline tracking
      await _local.insertEngagement(engagement.toLocal());
      
      return right(EngagementMapper.toEntity(engagement));
    } catch (e) {
      return left(Failure.serverError(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, EngagementResult>> submitSurvey(
    String engagementId,
    Map<String, String> answers,
    EngagementEvidence evidence,
  ) async {
    try {
      // Call Cloud Function for atomic processing
      final result = await _functions.call<Map<String, dynamic>>(
        'processEngagement',
        data: {
          'engagementId': engagementId,
          'surveyAnswers': answers,
          'evidence': evidence.toJson(),
        },
      );
      
      return right(EngagementResult.fromJson(result));
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'resource-exhausted') {
        return left(const Failure.dailyCapReached());
      }
      return left(Failure.serverError(code: e.code, message: e.message));
    } catch (e) {
      return left(Failure.serverError(message: e.toString()));
    }
  }
}
```

### 4.3 Local Database (Drift)

```dart
// packages/data/lib/datasources/local/drift_database.dart
@DriftDatabase(tables: [
  LocalUsers,
  LocalWallets,
  LocalEngagements,
  LocalChatCards,
  LocalUserScores,
  PendingSyncs,
])
class DriftDatabase extends _$DriftDatabase {
  DriftDatabase(QueryExecutor e) : super(e);
  
  @override
  int get schemaVersion => 1;
  
  // Engagement queries
  Future<int> getEngagementCountToday(String userId) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final query = selectOnly(localEngagements)
      ..addColumns([localEngagements.id.count()])
      ..where(localEngagements.userId.equals(userId))
      ..where(localEngagements.startedAt.like('$today%'));
    return (await query.getSingle()).read(localEngagements.id.count()) ?? 0;
  }
  
  Future<void> insertEngagement(LocalEngagementsCompanion engagement) {
    return into(localEngagements).insert(engagement);
  }
  
  // Sync queue
  Future<List<PendingSync>> getPendingSyncs() {
    return (select(pendingSyncs)
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
    ).get();
  }
}
```

### 4.4 Sync Manager

```dart
// packages/data/lib/sync/sync_manager.dart
@singleton
class SyncManager {
  final DriftDatabase _local;
  final FirestoreSource _remote;
  final NetworkInfo _networkInfo;
  Timer? _syncTimer;
  
  SyncManager(this._local, this._remote, this._networkInfo);
  
  void startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => syncPendingChanges(),
    );
  }
  
  Future<void> syncPendingChanges() async {
    if (!await _networkInfo.isConnected) return;
    
    final pending = await _local.getPendingSyncs();
    for (final item in pending) {
      try {
        switch (item.type) {
          case 'engagement':
            await _syncEngagement(item);
            break;
          case 'profile':
            await _syncProfile(item);
            break;
        }
        await _local.deletePendingSync(item.id);
      } catch (e) {
        // Retry on next sync
        await _local.incrementSyncRetry(item.id);
      }
    }
  }
}
```

---

# PART V: PRESENTATION LAYER

## 5. Presentation Layer - BLoC, Navigation, Screens

The Presentation layer handles all UI concerns including state management, navigation, and widget composition.

### 5.1 State Management with BLoC

```dart
// lib/features/earn/bloc/earn_bloc.dart
@injectable
class EarnBloc extends Bloc<EarnEvent, EarnState> {
  final GetEarnInboxUseCase _getEarnInbox;
  final StartEngagementUseCase _startEngagement;
  final SubmitSurveyUseCase _submitSurvey;
  final GetDailyProgressUseCase _getDailyProgress;
  
  EarnBloc(
    this._getEarnInbox,
    this._startEngagement,
    this._submitSurvey,
    this._getDailyProgress,
  ) : super(const EarnState.initial()) {
    on<EarnLoadRequested>(_onLoadRequested);
    on<EarnVideoStarted>(_onVideoStarted);
    on<EarnSurveySubmitted>(_onSurveySubmitted);
    on<EarnRefreshRequested>(_onRefreshRequested);
  }
  
  Future<void> _onLoadRequested(
    EarnLoadRequested event,
    Emitter<EarnState> emit,
  ) async {
    emit(const EarnState.loading());
    
    final results = await Future.wait([
      _getEarnInbox(),
      _getDailyProgress(),
    ]);
    
    final inboxResult = results[0] as Either<Failure, List<EarnThread>>;
    final progressResult = results[1] as Either<Failure, DailyProgress>;
    
    if (inboxResult.isRight() && progressResult.isRight()) {
      emit(EarnState.loaded(
        threads: inboxResult.getOrElse(() => []),
        progress: progressResult.getOrElse(() => DailyProgress.empty()),
      ));
    } else {
      emit(EarnState.error(
        inboxResult.fold((f) => f.message, (_) => null) ??
        progressResult.fold((f) => f.message, (_) => null) ??
        'Unknown error',
      ));
    }
  }
  
  Future<void> _onSurveySubmitted(
    EarnSurveySubmitted event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isSubmitting: true),
      orElse: () => state,
    ));
    
    final result = await _submitSurvey(
      engagementId: event.engagementId,
      answers: event.answers,
      evidence: event.evidence,
    );
    
    result.fold(
      (failure) => emit(state.maybeMap(
        loaded: (s) => s.copyWith(isSubmitting: false, error: failure.message),
        orElse: () => state,
      )),
      (engagementResult) {
        emit(state.maybeMap(
          loaded: (s) => s.copyWith(
            isSubmitting: false,
            lastReward: engagementResult,
            progress: s.progress.copyWith(
              completionsToday: s.progress.completionsToday + 1,
            ),
          ),
          orElse: () => state,
        ));
        add(const EarnRefreshRequested());
      },
    );
  }
}
```

### 5.2 State Classes (Freezed)

```dart
// lib/features/earn/bloc/earn_state.dart
@freezed
class EarnState with _$EarnState {
  const factory EarnState.initial() = _Initial;
  const factory EarnState.loading() = _Loading;
  const factory EarnState.loaded({
    required List<EarnThread> threads,
    required DailyProgress progress,
    @Default(false) bool isSubmitting,
    EngagementResult? lastReward,
    String? error,
  }) = _Loaded;
  const factory EarnState.error(String message) = _Error;
}

@freezed
class EarnEvent with _$EarnEvent {
  const factory EarnEvent.loadRequested() = EarnLoadRequested;
  const factory EarnEvent.videoStarted(String videoId) = EarnVideoStarted;
  const factory EarnEvent.surveySubmitted({
    required String engagementId,
    required Map<String, String> answers,
    required EngagementEvidence evidence,
  }) = EarnSurveySubmitted;
  const factory EarnEvent.refreshRequested() = EarnRefreshRequested;
}
```

### 5.3 Navigation (GoRouter)

```dart
// lib/navigation/app_router.dart
final appRouter = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    final isLoggedIn = authState.maybeMap(
      authenticated: (_) => true,
      orElse: () => false,
    );
    final isOnboarding = state.matchedLocation.startsWith('/onboarding');
    final isAuthFlow = state.matchedLocation.startsWith('/auth');
    
    if (!isLoggedIn && !isAuthFlow && !isOnboarding) {
      return '/onboarding';
    }
    if (isLoggedIn && (isAuthFlow || isOnboarding)) {
      return '/home';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(
      path: '/auth',
      routes: [
        GoRoute(path: 'phone', builder: (_, __) => const PhoneEntryScreen()),
        GoRoute(path: 'otp', builder: (_, __) => const OtpVerificationScreen()),
        GoRoute(path: 'profile', builder: (_, __) => const ProfileSetupScreen()),
      ],
    ),
    ShellRoute(
      builder: (_, __, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/earn', builder: (_, __) => const EarnScreen()),
        GoRoute(path: '/wallet', builder: (_, __) => const WalletScreen()),
        GoRoute(path: '/chat', builder: (_, __) => const ChatScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      ],
    ),
  ],
);
```

### 5.4 Screen Catalog

| Screen | Route | BLoC | Key Features |
|--------|-------|------|--------------|
| Splash | /splash | AuthBloc | Auto-login check, branding |
| Onboarding | /onboarding | - | Feature carousel, Get Started CTA |
| Phone Entry | /auth/phone | AuthBloc | Phone input, validation, Request OTP |
| OTP Verification | /auth/otp | AuthBloc | 6-digit code, resend timer |
| Profile Setup | /auth/profile | ProfileBloc | Name, username, gender, DOB, photo |
| Home | /home | HomeBloc | Balance, pots, streak, quick actions |
| Earn | /earn | EarnBloc | Thread inbox, daily progress, ad playback |
| Wallet | /wallet | WalletBloc | Balance, transactions, cashout, buy |
| Chat | /chat | ChatBloc | Thread list, send/request cards |
| Profile | /profile | ProfileBloc | Stats, settings, referrals, logout |

---

# PART VI: FIREBASE CLOUD FUNCTIONS

## 6. Firebase Cloud Functions - Complete Implementation

This section contains the complete, production-ready Firebase Cloud Functions implementation. All business logic that requires server-side execution runs here.

### 6.1 Project Configuration

```json
// functions/package.json
{
  "name": "imalichat-functions",
  "version": "1.0.0",
  "description": "iMaliChat Cloud Functions",
  "main": "lib/index.js",
  "engines": { "node": "18" },
  "dependencies": {
    "firebase-admin": "^11.11.0",
    "firebase-functions": "^4.5.0",
    "uuid": "^9.0.0",
    "crypto": "^1.0.1"
  }
}
```

### 6.2 Function Exports

```typescript
// functions/src/index.ts
import * as admin from 'firebase-admin';
admin.initializeApp();

// Auth Functions
export { onUserCreate } from './auth/onUserCreate';

// Engagement Functions
export { processEngagement } from './engagement/processEngagement';
export { startEngagement } from './engagement/startEngagement';

// Wallet Functions
export { requestCashout } from './wallet/requestCashout';
export { processCashout } from './wallet/processCashout';

// Chat (P2P) Functions
export { sendTokens } from './chat/sendTokens';
export { createRequest } from './chat/createRequest';
export { payRequest } from './chat/payRequest';
export { declineRequest } from './chat/declineRequest';

// Gamification Functions
export { closeDailyPot } from './gamification/closeDailyPot';
export { closeWeeklyPot } from './gamification/closeWeeklyPot';
export { updateStreak } from './gamification/updateStreak';

// Referral Functions
export { processStarterBonus } from './referrals/processStarterBonus';
export { checkMilestones } from './referrals/checkMilestones';

// Purchase Functions
export { processPurchase } from './purchases/processPurchase';

// Admin Functions
export { adjustBalance } from './admin/adjustBalance';
export { suspendUser } from './admin/suspendUser';

// Fraud Prevention Functions
export { validateSurveyQuality } from './fraud/validateSurveyQuality';
export { reverseReward } from './fraud/reverseReward';
export { updateUserRiskScore } from './fraud/updateUserRiskScore';
export { dailyCollusionScan } from './fraud/dailyCollusionScan';
export { validateReferral } from './fraud/validateReferral';
export { analyzeLogin } from './fraud/analyzeLogin';
export { verifyCaptcha } from './fraud/verifyCaptcha';
```

### 6.3 Constants Configuration

```typescript
// functions/src/config/constants.ts
export const Constants = {
  // Token Economics
  TOKEN_VALUE_ZAR: 0.01,
  REWARD_STD_TOKENS: 5,
  REWARD_BONUS_TOKENS: 10,
  BONUS_SHARE: 0.20,

  // Splits
  SPLIT_USER: 0.90,
  SPLIT_DAILY_POT: 0.05,
  SPLIT_WEEKLY_POT: 0.05,

  // Caps & Limits
  DAILY_EARN_CAP: 30,
  CASHOUT_MIN_TOKENS: 500,
  CHAT_SEND_DAILY_CAP_TOKENS: 50000,
  CHAT_REQUEST_MAX_TOKENS: 20000,

  // Eligibility (hours/days)
  NEW_USER_POT_LOCK_HOURS: 48,
  FIRST_CASHOUT_ELIGIBILITY_DAYS: 7,
  FIRST_CASHOUT_HOLD_HOURS: 48,

  // Streaks
  STREAK_MULTIPLIERS: {
    3: 1.20,
    7: 1.35,
    14: 1.50,
  } as Record<number, number>,

  // Pot Distributions
  DAILY_POT_SPLITS: [0.40, 0.25, 0.20, 0.10, 0.05],
  WEEKLY_POT_TOP_N: 10,

  // Referrals
  REF_STARTER_TOKENS: 10,
  REF_MILESTONE_TOKENS: 40,
  REF_MILESTONE_ACTIONS: 25,
  REF_MILESTONE_DAYS: 14,
  REF_ASSIST_SCORE_PERCENT: 0.20,
  REF_ASSIST_SCORE_DAILY_CAP: 8,

  // Pot Close Times (SAST = UTC+2)
  DAILY_POT_CLOSE_HOUR: 20,
  WEEKLY_POT_CLOSE_DAY: 0, // Sunday
};
```

### 6.4 TypeScript Interfaces

```typescript
// functions/src/types/index.ts
export interface User {
  id: string;
  phoneNumber: string;
  displayName?: string;
  username?: string;
  status: 'pending' | 'active' | 'suspended' | 'banned';
  isPotEligible: boolean;
  potEligibleAt?: FirebaseFirestore.Timestamp;
  currentVisitorId?: string;
  riskScore?: number;
  createdAt: FirebaseFirestore.Timestamp;
  updatedAt: FirebaseFirestore.Timestamp;
}

export interface Wallet {
  id: string;
  userId: string;
  balanceTokens: number;
  lifetimeEarned: number;
  lifetimeWithdrawn: number;
  version: number;
  lastTransactionAt?: FirebaseFirestore.Timestamp;
  updatedAt: FirebaseFirestore.Timestamp;
}

export interface Engagement {
  id: string;
  userId: string;
  visitorId: string;
  videoId: string;
  status: EngagementStatus;
  startedAt: FirebaseFirestore.Timestamp;
  videoCompletedAt?: FirebaseFirestore.Timestamp;
  surveyCompletedAt?: FirebaseFirestore.Timestamp;
  watchDurationMs?: number;
  attentionScore?: number;
  surveyAnswers?: Record<string, string>;
  tokensEarned?: number;
  scoreEarned?: number;
}

export interface UserScore {
  userId: string;
  dailyScore: number;
  weeklyScore: number;
  dailyCompletions: number;
  weeklyCompletions: number;
  streakDays: number;
  dailyRank: number;
  weeklyRank: number;
  lastActiveDate?: string;
  updatedAt: FirebaseFirestore.Timestamp;
}

export interface ChatCard {
  id: string;
  threadId: string;
  type: 'send' | 'request';
  status: 'pending' | 'paid' | 'declined' | 'expired' | 'cancelled';
  senderId: string;
  recipientId: string;
  amountTokens: number;
  dueDate?: FirebaseFirestore.Timestamp;
  paidAt?: FirebaseFirestore.Timestamp;
  transactionId?: string;
  createdAt: FirebaseFirestore.Timestamp;
}
```

### 6.5 processEngagement Function

```typescript
// functions/src/engagement/processEngagement.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Constants } from '../config/constants';

const db = admin.firestore();

export const processEngagement = functions.https.onCall(async (data, context) => {
  // 1. Verify authentication
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  
  // 2. Verify App Check
  if (!context.app) {
    throw new functions.https.HttpsError('failed-precondition', 'App Check failed');
  }
  
  const userId = context.auth.uid;
  const { engagementId, surveyAnswers, evidence } = data;
  
  // 3. Check idempotency
  const idempotencyKey = `eng_${engagementId}_reward`;
  const existingDoc = await db.collection('processedKeys').doc(idempotencyKey).get();
  if (existingDoc.exists) {
    return existingDoc.data()!.result;
  }
  
  // 4. Validate evidence
  if (evidence.actualWatchTimeMs < evidence.videoDurationMs * 0.9) {
    throw new functions.https.HttpsError('invalid-argument', 'Insufficient watch time');
  }
  
  // 5. Get user score and check daily cap
  const userScoreDoc = await db.collection('userScores').doc(userId).get();
  const userScore = userScoreDoc.data()!;
  
  if (userScore.dailyCompletions >= Constants.DAILY_EARN_CAP) {
    throw new functions.https.HttpsError('resource-exhausted', 'Daily cap reached');
  }
  
  // 6. Calculate rewards
  const isBonus = (userScore.dailyCompletions + 1) % 5 === 0;
  const baseTokens = isBonus ? Constants.REWARD_BONUS_TOKENS : Constants.REWARD_STD_TOKENS;
  const userTokens = Math.floor(baseTokens * Constants.SPLIT_USER);
  const dailyPotTokens = Math.floor(baseTokens * Constants.SPLIT_DAILY_POT);
  const weeklyPotTokens = baseTokens - userTokens - dailyPotTokens;
  
  // Calculate streak multiplier for score
  const streakMultiplier = getStreakMultiplier(userScore.streakDays);
  const scoreEarned = 1 * streakMultiplier;
  
  // 7. Execute atomic transaction
  const result = await db.runTransaction(async (transaction) => {
    const walletRef = db.collection('wallets').doc(userId);
    const walletDoc = await transaction.get(walletRef);
    const wallet = walletDoc.data()!;
    const newBalance = wallet.balanceTokens + userTokens;
    
    // Update wallet
    transaction.update(walletRef, {
      balanceTokens: newBalance,
      lifetimeEarned: admin.firestore.FieldValue.increment(userTokens),
      version: admin.firestore.FieldValue.increment(1),
      lastTransactionAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Create transaction record
    const txnRef = walletRef.collection('transactions').doc();
    transaction.set(txnRef, {
      id: txnRef.id,
      walletId: userId,
      type: 'earn',
      amountTokens: userTokens,
      balanceAfter: newBalance,
      idempotencyKey,
      engagementId,
      description: isBonus ? 'Bonus reward' : 'Earned from video',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Update user score
    const today = new Date().toISOString().split('T')[0];
    const newStreakDays = calculateNewStreak(userScore, today);
    
    transaction.update(db.collection('userScores').doc(userId), {
      dailyScore: admin.firestore.FieldValue.increment(scoreEarned),
      weeklyScore: admin.firestore.FieldValue.increment(scoreEarned),
      dailyCompletions: admin.firestore.FieldValue.increment(1),
      weeklyCompletions: admin.firestore.FieldValue.increment(1),
      streakDays: newStreakDays,
      lastActiveDate: today,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Update pots
    transaction.update(db.collection('potPools').doc('daily_current'), {
      totalTokens: admin.firestore.FieldValue.increment(dailyPotTokens),
    });
    transaction.update(db.collection('potPools').doc('weekly_current'), {
      totalTokens: admin.firestore.FieldValue.increment(weeklyPotTokens),
    });
    
    // Update engagement
    transaction.update(db.collection('engagements').doc(engagementId), {
      status: 'rewarded',
      surveyCompletedAt: admin.firestore.FieldValue.serverTimestamp(),
      surveyAnswers,
      tokensEarned: userTokens,
      scoreEarned,
    });
    
    return {
      tokensEarned: userTokens,
      scoreEarned,
      newBalance,
      isBonus,
      streakDays: newStreakDays,
    };
  });
  
  // 8. Save idempotency result
  await db.collection('processedKeys').doc(idempotencyKey).set({
    result,
    processedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  return result;
});

function getStreakMultiplier(streakDays: number): number {
  if (streakDays >= 14) return Constants.STREAK_MULTIPLIERS[14];
  if (streakDays >= 7) return Constants.STREAK_MULTIPLIERS[7];
  if (streakDays >= 3) return Constants.STREAK_MULTIPLIERS[3];
  return 1.0;
}

function calculateNewStreak(userScore: any, today: string): number {
  if (!userScore.lastActiveDate) return 1;
  
  const lastDate = new Date(userScore.lastActiveDate);
  const todayDate = new Date(today);
  const diffDays = Math.floor(
    (todayDate.getTime() - lastDate.getTime()) / (1000 * 60 * 60 * 24)
  );
  
  if (diffDays === 0) return userScore.streakDays;
  if (diffDays === 1) return userScore.streakDays + 1;
  return 1; // Streak broken
}
```

### 6.6 sendTokens Function (Money Chat)

```typescript
// functions/src/chat/sendTokens.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { v4 as uuidv4 } from 'uuid';
import { Constants } from '../config/constants';

const db = admin.firestore();

export const sendTokens = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  
  const senderId = context.auth.uid;
  const { recipientPhone, amountTokens, requestId } = data;
  
  // Validate amount
  if (amountTokens < 1) {
    throw new functions.https.HttpsError('invalid-argument', 'Minimum 1 token');
  }
  if (amountTokens > Constants.CHAT_SEND_DAILY_CAP_TOKENS) {
    throw new functions.https.HttpsError('invalid-argument', 'Exceeds daily limit');
  }
  
  // Find recipient
  const recipientQuery = await db.collection('users')
    .where('phoneNumber', '==', recipientPhone)
    .limit(1)
    .get();
  
  if (recipientQuery.empty) {
    throw new functions.https.HttpsError('not-found', 'Recipient not found');
  }
  
  const recipient = recipientQuery.docs[0];
  const recipientId = recipient.id;
  
  if (recipientId === senderId) {
    throw new functions.https.HttpsError('invalid-argument', 'Cannot send to yourself');
  }
  
  // Check idempotency
  const idempotencyKey = requestId || `send_${senderId}_${recipientId}_${Date.now()}`;
  const existingDoc = await db.collection('processedKeys').doc(idempotencyKey).get();
  if (existingDoc.exists) {
    return existingDoc.data()!.result;
  }
  
  // Execute atomic transaction
  const result = await db.runTransaction(async (transaction) => {
    // Get sender wallet
    const senderWalletRef = db.collection('wallets').doc(senderId);
    const senderWalletDoc = await transaction.get(senderWalletRef);
    const senderWallet = senderWalletDoc.data()!;
    
    if (senderWallet.balanceTokens < amountTokens) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'Insufficient balance'
      );
    }
    
    // Get or create chat thread
    const threadId = [senderId, recipientId].sort().join('_');
    const threadRef = db.collection('chatThreads').doc(threadId);
    const threadDoc = await transaction.get(threadRef);
    
    if (!threadDoc.exists) {
      transaction.set(threadRef, {
        id: threadId,
        participants: [senderId, recipientId],
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    
    // Create chat card
    const cardRef = threadRef.collection('cards').doc();
    const txnId = uuidv4();
    
    transaction.set(cardRef, {
      id: cardRef.id,
      threadId,
      type: 'send',
      status: 'paid',
      senderId,
      recipientId,
      amountTokens,
      transactionId: txnId,
      paidAt: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Update sender wallet
    const senderNewBalance = senderWallet.balanceTokens - amountTokens;
    transaction.update(senderWalletRef, {
      balanceTokens: senderNewBalance,
      version: admin.firestore.FieldValue.increment(1),
      lastTransactionAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Create sender transaction
    transaction.set(senderWalletRef.collection('transactions').doc(), {
      type: 'p2p_send',
      amountTokens: -amountTokens,
      balanceAfter: senderNewBalance,
      counterpartyId: recipientId,
      chatCardId: cardRef.id,
      idempotencyKey,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Update recipient wallet
    const recipientWalletRef = db.collection('wallets').doc(recipientId);
    const recipientWalletDoc = await transaction.get(recipientWalletRef);
    const recipientWallet = recipientWalletDoc.data()!;
    const recipientNewBalance = recipientWallet.balanceTokens + amountTokens;
    
    transaction.update(recipientWalletRef, {
      balanceTokens: recipientNewBalance,
      version: admin.firestore.FieldValue.increment(1),
      lastTransactionAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Create recipient transaction
    transaction.set(recipientWalletRef.collection('transactions').doc(), {
      type: 'p2p_receive',
      amountTokens,
      balanceAfter: recipientNewBalance,
      counterpartyId: senderId,
      chatCardId: cardRef.id,
      idempotencyKey,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    return {
      cardId: cardRef.id,
      amountTokens,
      newBalance: senderNewBalance,
    };
  });
  
  // Save idempotency
  await db.collection('processedKeys').doc(idempotencyKey).set({
    result,
    processedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  
  // Send notification to recipient
  // await sendNotification(recipientId, 'Money Received!', `You received ${amountTokens} tokens`);
  
  return result;
});
```

### 6.7 closeDailyPot Function

```typescript
// functions/src/gamification/closeDailyPot.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Constants } from '../config/constants';

const db = admin.firestore();

// Scheduled to run at 6pm UTC (8pm SAST)
export const closeDailyPot = functions.pubsub
  .schedule('0 18 * * *')
  .timeZone('UTC')
  .onRun(async (context) => {
    console.log('Starting daily pot close...');
    
    const potRef = db.collection('potPools').doc('daily_current');
    const potDoc = await potRef.get();
    
    if (!potDoc.exists) {
      console.log('No daily pot found');
      return;
    }
    
    const pot = potDoc.data()!;
    const totalTokens = pot.totalTokens + (pot.roundingBuffer || 0);
    
    if (totalTokens === 0) {
      console.log('Daily pot is empty');
      return;
    }
    
    // Get top 5 users by daily score with tiebreakers
    const leaderboardQuery = await db.collection('userScores')
      .where('dailyCompletions', '>', 0)
      .orderBy('dailyCompletions', 'desc')
      .orderBy('dailyScore', 'desc')
      .orderBy('streakDays', 'desc')
      .limit(5)
      .get();
    
    if (leaderboardQuery.empty) {
      console.log('No eligible users for daily pot');
      return;
    }
    
    const winners = leaderboardQuery.docs.map((doc, index) => ({
      userId: doc.id,
      rank: index + 1,
      score: doc.data().dailyScore,
      sharePercent: Constants.DAILY_POT_SPLITS[index] || 0,
    }));
    
    const batch = db.batch();
    const distributions: Array<{ userId: string; rank: number; tokensWon: number }> = [];
    
    for (const winner of winners) {
      const tokensWon = Math.floor(totalTokens * winner.sharePercent);
      
      if (tokensWon > 0) {
        distributions.push({ userId: winner.userId, rank: winner.rank, tokensWon });
        
        // Update wallet
        const walletRef = db.collection('wallets').doc(winner.userId);
        batch.update(walletRef, {
          balanceTokens: admin.firestore.FieldValue.increment(tokensWon),
          lifetimeEarned: admin.firestore.FieldValue.increment(tokensWon),
          version: admin.firestore.FieldValue.increment(1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        
        // Create transaction
        const txnRef = walletRef.collection('transactions').doc();
        batch.set(txnRef, {
          id: txnRef.id,
          type: 'pot_win',
          amountTokens: tokensWon,
          description: `Daily Pot #${winner.rank}`,
          metadata: { potType: 'daily', rank: winner.rank },
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    }
    
    // Archive pot
    const dateStr = new Date().toISOString().split('T')[0];
    const archiveRef = db.collection('potPools').doc(`daily_${dateStr}`);
    batch.set(archiveRef, {
      ...pot,
      status: 'closed',
      closedAt: admin.firestore.FieldValue.serverTimestamp(),
      distributions,
    });
    
    // Reset current pot
    batch.set(potRef, {
      id: 'daily_current',
      type: 'daily',
      totalTokens: 0,
      roundingBuffer: 0,
      status: 'open',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    // Reset daily scores for all users
    const allScores = await db.collection('userScores').get();
    for (const scoreDoc of allScores.docs) {
      batch.update(scoreDoc.ref, {
        dailyScore: 0,
        dailyCompletions: 0,
      });
    }
    
    await batch.commit();
    
    console.log(`Daily pot closed. Distributed ${totalTokens} tokens to ${distributions.length} winners.`);
  });
```

### 6.8 Function Catalog

| Function | Trigger | Purpose |
|----------|---------|---------|
| onUserCreate | Firestore onCreate | Initialize wallet, score, set pot eligibility |
| processEngagement | HTTPS Callable | Validate evidence, calculate rewards, update atomically |
| startEngagement | HTTPS Callable | Create engagement document, check daily cap |
| requestCashout | HTTPS Callable | Initiate cashout, apply holds if first-time |
| processCashout | PubSub scheduled | Process pending cashouts via G-PAY API |
| sendTokens | HTTPS Callable | P2P token transfer with atomic balance updates |
| createRequest | HTTPS Callable | Create payment request card |
| payRequest | HTTPS Callable | Pay a pending request |
| declineRequest | HTTPS Callable | Decline a pending request |
| closeDailyPot | PubSub schedule 18:00 UTC | Calculate rankings, distribute winnings |
| closeWeeklyPot | PubSub schedule Sun 18:00 UTC | Calculate rankings, distribute winnings |
| processStarterBonus | Firestore onUpdate | Award referral starter bonus |
| checkMilestones | Firestore onUpdate | Check and award milestone bonuses |
| processPurchase | HTTPS Callable | Process airtime/electricity purchase |
| validateSurveyQuality | Firestore onCreate | Fraud check on survey responses |
| dailyCollusionScan | PubSub scheduled | Detect referral fraud patterns |

---

# PART VII: FIRESTORE SECURITY RULES

## 7. Firestore Security Rules - Complete Ruleset

Complete security rules protecting all Firestore collections. These rules enforce authentication, authorization, and data integrity.

### 7.1 Rules Overview

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // ═══════════════════════════════════════════════════════════════
    // HELPER FUNCTIONS
    // ═══════════════════════════════════════════════════════════════
    
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return isAuthenticated() && request.auth.uid == userId;
    }
    
    function isAdmin() {
      return isAuthenticated() && 
             request.auth.token.admin == true;
    }
    
    function isOps() {
      return isAuthenticated() && 
             (request.auth.token.ops == true || request.auth.token.admin == true);
    }
    
    function isAdvertiser() {
      return isAuthenticated() && 
             request.auth.token.advertiser == true;
    }
    
    function isUnchanged(field) {
      return !(field in request.resource.data) || 
             request.resource.data[field] == resource.data[field];
    }
    
    function isValidPhone(phone) {
      return phone.matches('^\\+27[0-9]{9}$');
    }
    
    function isValidUsername(username) {
      return username.size() >= 3 && 
             username.size() <= 20 && 
             username.matches('^[a-zA-Z0-9_]+$');
    }
```

### 7.2 Users Collection Rules

```javascript
    // ═══════════════════════════════════════════════════════════════
    // USERS COLLECTION
    // ═══════════════════════════════════════════════════════════════
    match /users/{userId} {
      // Only owner can read their own profile
      allow read: if isOwner(userId);
      
      // Create: Only via Cloud Functions (onUserCreate trigger)
      allow create: if false;
      
      // Update: Owner can update limited fields only
      allow update: if isOwner(userId) && 
                       isUnchanged('phoneNumber') &&
                       isUnchanged('status') &&
                       isUnchanged('isPotEligible') &&
                       isUnchanged('potEligibleAt') &&
                       isUnchanged('riskScore') &&
                       isUnchanged('createdAt');
      
      // Delete: Never allowed
      allow delete: if false;
      
      // Subcollections
      match /devices/{deviceId} {
        allow read: if isOwner(userId);
        allow write: if false; // Cloud Functions only
      }
      
      match /consents/{consentId} {
        allow read: if isOwner(userId);
        allow create: if isOwner(userId);
        allow update, delete: if false;
      }
    }
```

### 7.3 Wallets Collection Rules

```javascript
    // ═══════════════════════════════════════════════════════════════
    // WALLETS COLLECTION - IMMUTABLE LEDGER
    // ═══════════════════════════════════════════════════════════════
    match /wallets/{walletId} {
      // Owner can read their wallet
      allow read: if isOwner(walletId);
      
      // ALL writes via Cloud Functions only (atomic transactions)
      allow create, update, delete: if false;
      
      // Transaction subcollection
      match /transactions/{txnId} {
        // Owner can read their transactions
        allow read: if isOwner(walletId);
        
        // Transactions are immutable, created by Cloud Functions only
        allow create, update, delete: if false;
      }
    }
```

### 7.4 Engagements Collection Rules

```javascript
    // ═══════════════════════════════════════════════════════════════
    // ENGAGEMENTS COLLECTION
    // ═══════════════════════════════════════════════════════════════
    match /engagements/{engagementId} {
      // Owner can read their engagements
      allow read: if isAuthenticated() && 
                     resource.data.userId == request.auth.uid;
      
      // Create: Authenticated user for their own engagement
      allow create: if isAuthenticated() && 
                       request.resource.data.userId == request.auth.uid &&
                       request.resource.data.status == 'started' &&
                       !('tokensEarned' in request.resource.data) &&
                       !('scoreEarned' in request.resource.data);
      
      // Update: Limited fields only, rewards set by Cloud Functions
      allow update: if isAuthenticated() && 
                       resource.data.userId == request.auth.uid &&
                       isUnchanged('userId') &&
                       isUnchanged('tokensEarned') &&
                       isUnchanged('scoreEarned');
      
      allow delete: if false;
    }
```

### 7.5 Chat Collections Rules

```javascript
    // ═══════════════════════════════════════════════════════════════
    // CHAT THREADS & CARDS (MONEY CHAT)
    // ═══════════════════════════════════════════════════════════════
    match /chatThreads/{threadId} {
      // Participants can read
      allow read: if isAuthenticated() && 
                     request.auth.uid in resource.data.participants;
      
      // Create: Authenticated user must be participant
      allow create: if isAuthenticated() && 
                       request.auth.uid in request.resource.data.participants;
      
      // Update: Only via Cloud Functions
      allow update, delete: if false;
      
      // Chat cards subcollection
      match /cards/{cardId} {
        // Participants can read
        allow read: if isAuthenticated() && 
                       request.auth.uid in get(/databases/$(database)/documents/chatThreads/$(threadId)).data.participants;
        
        // All card operations via Cloud Functions for atomic balance updates
        allow create, update, delete: if false;
      }
    }
```

### 7.6 Gamification Collections Rules

```javascript
    // ═══════════════════════════════════════════════════════════════
    // USER SCORES & POT POOLS
    // ═══════════════════════════════════════════════════════════════
    match /userScores/{userId} {
      // Owner can read their score
      allow read: if isOwner(userId);
      
      // All updates via Cloud Functions
      allow create, update, delete: if false;
    }
    
    match /potPools/{potId} {
      // All authenticated users can read pot totals
      allow read: if isAuthenticated();
      
      // All updates via Cloud Functions (scheduled jobs)
      allow create, update, delete: if false;
    }
    
    match /leaderboards/{type} {
      // All authenticated users can read leaderboards
      allow read: if isAuthenticated();
      allow write: if false;
    }
```

### 7.7 Admin Collections Rules

```javascript
    // ═══════════════════════════════════════════════════════════════
    // CASHOUTS
    // ═══════════════════════════════════════════════════════════════
    match /cashouts/{cashoutId} {
      // Owner can read their cashouts
      allow read: if isAuthenticated() && 
                     resource.data.userId == request.auth.uid;
      
      // Ops can read all for review
      allow read: if isOps();
      
      // Create via Cloud Functions only
      allow create: if false;
      
      // Ops can update status
      allow update: if isOps();
      
      allow delete: if false;
    }
    
    // ═══════════════════════════════════════════════════════════════
    // FRAUD FLAGS - HIDDEN FROM USERS
    // ═══════════════════════════════════════════════════════════════
    match /fraudFlags/{flagId} {
      // Users cannot see their fraud flags
      allow read: if isOps();
      allow write: if isOps();
    }
    
    // ═══════════════════════════════════════════════════════════════
    // AUDIT LOGS - IMMUTABLE
    // ═══════════════════════════════════════════════════════════════
    match /auditLogs/{logId} {
      allow read: if isAdmin();
      allow create: if isOps();
      allow update, delete: if false;
    }
    
    // ═══════════════════════════════════════════════════════════════
    // CAMPAIGNS (ADVERTISER PORTAL)
    // ═══════════════════════════════════════════════════════════════
    match /campaigns/{campaignId} {
      allow read: if isAuthenticated() && 
                     (resource.data.advertiserId == request.auth.uid || isOps());
      allow create: if isAdvertiser();
      allow update: if isAuthenticated() && 
                       resource.data.advertiserId == request.auth.uid &&
                       isUnchanged('advertiserId');
      allow delete: if false;
    }
    
    // ═══════════════════════════════════════════════════════════════
    // PROCESSED KEYS (IDEMPOTENCY)
    // ═══════════════════════════════════════════════════════════════
    match /processedKeys/{keyId} {
      allow read, write: if false; // Cloud Functions only
    }
  }
}
```

### 7.8 Security Rules Summary

| Collection | Read | Write | Notes |
|------------|------|-------|-------|
| /users/{userId} | Owner only | Limited fields | Profile updates allowed |
| /wallets/{id} | Owner only | NONE | All via Cloud Functions |
| /wallets/{id}/transactions | Owner only | NONE | Immutable ledger |
| /engagements | Owner only | Create + limited update | Cannot set rewards |
| /chatThreads | Participants | Create only | Cards via Functions |
| /userScores | Owner only | NONE | System managed |
| /potPools | All authenticated | NONE | System managed |
| /cashouts | Owner + Ops | Ops only | Status updates |
| /fraudFlags | Ops only | Ops only | Hidden from users |
| /campaigns | Advertiser owner | Limited | Advertiser portal |

---

# PART VIII: UI/UX DESIGN SYSTEM & WIREFRAMES

## 8. UI/UX Design System

Complete design specifications for the iMaliChat mobile application. The design system ensures visual consistency and optimal user experience across all screens.

### 8.1 Color Palette

| Color | Hex Value | Usage |
|-------|-----------|-------|
| Primary Blue | #1F4E79 | Headers, CTAs, navigation highlights |
| Secondary Blue | #2E75B6 | Secondary actions, links |
| Success Green | #10B981 | Positive amounts, success states, earnings |
| Warning Orange | #F97316 | Streaks, pending items, alerts |
| Error Red | #EF4444 | Errors, negative amounts, declines |
| Background | #F5F7FA | Screen backgrounds |
| Card White | #FFFFFF | Card backgrounds |
| Text Primary | #1F2937 | Primary text |
| Text Secondary | #6B7280 | Secondary text, captions |
| Border | #E5E7EB | Dividers, card borders |

### 8.2 Typography

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| H1 | 24px | Bold | Screen titles |
| H2 | 20px | Bold | Section headers |
| H3 | 18px | SemiBold | Card titles |
| Body | 16px | Regular | Primary content |
| Body Small | 14px | Regular | Secondary content |
| Caption | 12px | Regular | Timestamps, hints |
| Button | 16px | SemiBold | Button labels |
| Balance | 32px | Bold | Wallet balance display |

### 8.3 Spacing & Layout

- Base unit: 4px
- Standard spacing: 8px, 12px, 16px, 20px, 24px
- Card padding: 16px
- Screen margins: 16px horizontal
- Card border radius: 12px
- Button border radius: 12px
- Avatar sizes: 40px (small), 48px (medium), 64px (large)
- Bottom navigation height: 64px
- Status bar accommodation: SafeArea top padding

### 8.4 Components

#### 8.4.1 Buttons

| Type | Background | Text | Usage |
|------|------------|------|-------|
| Primary | #1F4E79 | White | Main actions (Earn, Cash Out, Confirm) |
| Secondary | #E5E7EB | #1F2937 | Secondary actions (Cancel, Later) |
| Success | #10B981 | White | Positive actions (Pay, Send) |
| Danger | #EF4444 | White | Destructive actions (Decline, Delete) |
| Ghost | Transparent | #1F4E79 | Tertiary actions, links |

#### 8.4.2 Cards

- Background: White with subtle shadow (0 2px 8px rgba(0,0,0,0.08))
- Border radius: 12px
- Padding: 16px
- Margin between cards: 12px

#### 8.4.3 Input Fields

- Height: 48px
- Border: 1px solid #E5E7EB
- Border radius: 8px
- Focus border: 2px solid #1F4E79
- Error border: 2px solid #EF4444
- Padding: 12px horizontal

### 8.5 Core Screens Specification

#### 8.5.1 Home Screen

The home screen is the primary dashboard showing wallet balance, gamification status, and quick actions.

- Header: Blue gradient (#1F4E79 to #0F3D5C), curved bottom edge
- Balance card: Frosted glass effect, prominent balance display (32px bold)
- Streak badge: Orange pill with flame icon and day count
- Cash-out progress: Green progress bar showing tokens to next cashout
- Pot cards: Side-by-side cards showing Daily Pot and Weekly Pot totals with user rank
- Quick actions: 4-column grid (Earn, Send, Airtime, Electricity)
- Referral banner: Purple-to-pink gradient at bottom

#### 8.5.2 Earn Inbox Screen

Thread-based inbox displaying available earn opportunities.

- Header: Daily earnings summary (e.g., '21/30 today, R1.26 earned')
- iMaliChat Daily thread: Pinned at top, blue gradient avatar, badge showing available videos
- Brand threads: Company logo, 'AD' badge, expiry countdown timer
- Thread row: Avatar, brand name, subtitle, right-aligned badge/timer
- Info card at bottom: Explains 30 videos per day limit

#### 8.5.3 Wallet Screen

Central financial hub for balance management and transactions.

- Balance header: Gradient background with large balance display
- Action buttons: Primary 'Cash Out', Secondary 'Send'
- Quick Buy grid: Airtime, Electricity, Vouchers cards
- Transaction list: Icon by type (green=earn, yellow=pot, blue=p2p), amount, timestamp
- Bonus transactions: Orange 'BONUS' label

#### 8.5.4 Chat Screen (Money Chat)

P2P money transfers - send and request tokens only, no text messaging.

> **⚠️ CRITICAL:** No free-form text input field (BRS 7.9 prohibition)

- Thread list: Contact name, last money action summary
- Pending badge: Orange badge for awaiting payment requests
- New chat FAB: Blue floating action button
- Thread view: Timeline of Send/Request cards with status
- Bottom actions: Two buttons only - 'Send' and 'Request'

#### 8.5.5 Profile Screen

User profile, stats, and settings management.

- Avatar header: Large profile photo with edit overlay
- Stats row: Total earned, streak days, rank
- Menu items: Edit Profile, My Referrals, Notifications, Privacy, Help, Sign Out
- Version footer: App version number

### 8.6 Screen Flow Diagrams

#### 8.6.1 Earn Flow

```
Home → Earn Tab → Select Thread → Video Player → Survey → Reward Confirmation
                                    ↓
                              (If at daily cap)
                                    ↓
                          Daily Cap Reached Modal
```

#### 8.6.2 Cash Out Flow

```
Wallet → Cash Out CTA → Amount Entry → Method Selection → Confirm → Processing → Success/Failure
```

#### 8.6.3 Money Chat Flow

```
Chat Tab → Thread List → Select Thread → Send/Request Buttons
                ↓
         New Chat FAB → Contact Search → Thread View
```

### 8.7 Wireframe Discrepancies (BRS vs UI)

> **⚠️ CRITICAL:** The following discrepancies between wireframes and BRS must be resolved:

| Issue | Severity | BRS Requirement | Wireframe Shows |
|-------|----------|-----------------|-----------------|
| Money Chat text input | **CRITICAL** | No free-form text (7.9) | "Type message..." field |
| Gender options | MEDIUM | 4 options (7.1) | Only Male/Female |
| Tier badges | MEDIUM | Removed from MVP | BRONZE/SILVER badges |
| Branding | INFO | iMaliChat | "Zawadi" branding |

---

# PART IX: FRAUD PREVENTION SYSTEM

## 9. Fraud Prevention System

Comprehensive fraud prevention covering all attack vectors. This system protects the economic integrity of iMaliChat while maintaining good user experience for legitimate users.

### 9.1 Threat Model

| Threat | Vector | Impact | Mitigation |
|--------|--------|--------|------------|
| Account farming | Multiple accounts per person | Drains pot pool | Device + SIM fingerprinting |
| Emulator abuse | Running app in emulator | Automated farming | Play Integrity API |
| Click farming | Rapid automated completions | Inflated earnings | Behavioral analysis |
| Referral fraud | Self-referrals, collusion | Free tokens | Device linking, IP clusters |
| Survey bot | Random/instant answers | Unearned rewards | Attention checks, timing |
| Rooted devices | Modified app behavior | Bypass security | Root detection |
| Location spoofing | Fake GPS locations | Regional targeting bypass | IP correlation |
| Multi-device | Same user, many devices | Multiply earnings | Cross-device linking |

### 9.2 5-Layer Security Architecture

#### Layer 1: Device Integrity

```typescript
// Play Integrity API verification
interface IntegrityVerdict {
  deviceRecognitionVerdict: 'MEETS_DEVICE_INTEGRITY' | 'MEETS_BASIC_INTEGRITY' | 'UNRECOGNIZED';
  appRecognitionVerdict: 'PLAY_RECOGNIZED' | 'UNRECOGNIZED_VERSION' | 'UNEVALUATED';
  accountVerdict: 'LICENSED' | 'UNLICENSED' | 'UNEVALUATED';
}

// Minimum requirements for earn eligibility
const INTEGRITY_REQUIREMENTS = {
  deviceIntegrity: ['MEETS_DEVICE_INTEGRITY', 'MEETS_BASIC_INTEGRITY'],
  appRecognition: ['PLAY_RECOGNIZED'],
  accountStatus: ['LICENSED'],
};
```

#### Layer 2: Account Verification

- Phone OTP verification with carrier validation
- Device fingerprint (visitorId) linking
- SIM change detection
- Maximum 2 accounts per device
- 48-hour pot eligibility lock for new accounts

#### Layer 3: Behavioral Analysis

```typescript
// Risk scoring based on behavior patterns
interface BehaviorSignals {
  avgSurveyTimeMs: number;        // Too fast = suspicious
  surveyVariance: number;         // Low variance = bot-like
  attentionCheckAccuracy: number; // Failed checks = bad actor
  sessionPatterns: string[];      // Unusual timing patterns
  completionRate: number;         // Near 100% = suspicious
  videoSkipAttempts: number;      // Excessive skipping
}

function calculateRiskScore(signals: BehaviorSignals): number {
  let score = 0;
  
  if (signals.avgSurveyTimeMs < 3000) score += 30;  // Too fast
  if (signals.surveyVariance < 0.2) score += 20;     // Bot-like
  if (signals.attentionCheckAccuracy < 0.7) score += 40; // Failing checks
  if (signals.completionRate > 0.95) score += 15;   // Suspiciously perfect
  if (signals.videoSkipAttempts > 10) score += 10;  // Trying to skip
  
  return Math.min(100, score);
}
```

#### Layer 4: Referral Fraud Detection

```typescript
// Collusion detection patterns
interface ReferralFraudSignals {
  sameDevice: boolean;           // Referee on referrer's device
  sameIP: boolean;               // Same IP address
  sameWifiCluster: boolean;      // Same WiFi network
  rapidActivation: boolean;      // Activation too fast after signup
  circularReferral: boolean;     // A->B->A pattern
}

// Daily collusion scan
async function dailyCollusionScan() {
  const suspiciousPatterns = await db.collection('referrals')
    .where('status', '==', 'active')
    .where('createdAt', '>', yesterday)
    .get();
  
  for (const ref of suspiciousPatterns.docs) {
    const referrer = await getUser(ref.data().referrerId);
    const referee = await getUser(ref.data().refereeId);
    
    const signals = {
      sameDevice: referrer.visitorId === referee.visitorId,
      sameIP: referrer.lastIP === referee.lastIP,
      sameWifiCluster: await checkWifiCluster(referrer, referee),
      rapidActivation: ref.data().activatedAt - ref.data().createdAt < 60000,
      circularReferral: await checkCircular(referrer.id, referee.id),
    };
    
    if (Object.values(signals).filter(Boolean).length >= 2) {
      await flagFraud(ref.id, 'referral_collusion', signals);
    }
  }
}
```

#### Layer 5: Manual Review Queue

- Auto-hold triggers at risk score >= 70
- Review dashboard for Ops team
- SLA: 24 hours for review
- Actions: Approve, Hold, Suspend, Ban
- Appeal process for false positives

### 9.3 Survey Quality Validation

```typescript
// Attention check implementation
interface AttentionCheck {
  type: 'instruction_following' | 'trick_question' | 'consistency_check';
  question: string;
  expectedAnswer: string;
}

const ATTENTION_CHECKS: AttentionCheck[] = [
  {
    type: 'instruction_following',
    question: 'To verify you are paying attention, please select "Strongly Agree"',
    expectedAnswer: 'strongly_agree',
  },
  {
    type: 'trick_question',
    question: 'How satisfied are you with our invisible product?',
    expectedAnswer: 'not_applicable', // Real users ask for clarification or select N/A
  },
  {
    type: 'consistency_check',
    // Same question asked twice with different wording
    // Should have consistent answers
  },
];

// Insert 1 attention check per ~10 surveys
function shouldInsertAttentionCheck(completionCount: number): boolean {
  return completionCount % 10 === 5; // Predictable but not obvious
}
```

### 9.4 Risk Thresholds

| Risk Score | Status | Action |
|------------|--------|--------|
| 0-30 | Green | Normal operation |
| 31-50 | Yellow | Increased monitoring, CAPTCHA on suspicious actions |
| 51-70 | Orange | Mandatory CAPTCHA, reduced daily cap, ops notification |
| 71-85 | Red | Auto-hold on earnings, manual review required |
| 86-100 | Critical | Account suspended, admin review required |

### 9.5 CAPTCHA Integration

| Trigger | CAPTCHA Type | Frequency |
|---------|--------------|-----------|
| First cashout | reCAPTCHA v3 | Once |
| Risk score 31-50 | reCAPTCHA v2 | Every 5th earn |
| Risk score 51-70 | reCAPTCHA v2 | Every earn |
| Failed attention check | reCAPTCHA v2 | Immediate |
| Unusual login location | reCAPTCHA v3 | Once |

### 9.6 Audit Trail

```typescript
// Cryptographic audit log entry
interface AuditLogEntry {
  id: string;
  timestamp: FirebaseFirestore.Timestamp;
  userId: string;
  action: string;
  data: Record<string, any>;
  previousHash: string;
  hash: string;  // SHA-256(timestamp + userId + action + data + previousHash)
  signature: string;  // Server-side signature for tamper evidence
}

// Daily verification
async function dailyAuditVerification() {
  const logs = await db.collection('auditLogs')
    .orderBy('timestamp')
    .get();
  
  let previousHash = 'GENESIS';
  let corrupted = [];
  
  for (const log of logs.docs) {
    const data = log.data();
    const expectedHash = computeHash(data, previousHash);
    
    if (data.hash !== expectedHash) {
      corrupted.push(log.id);
    }
    previousHash = data.hash;
  }
  
  if (corrupted.length > 0) {
    await alertSecurityTeam('Audit log corruption detected', corrupted);
  }
}
```

---

# PART X: TESTING STRATEGY & APPENDICES

## 10. Testing Strategy

Comprehensive testing approach ensuring quality across all layers of the application.

### 10.1 Test Pyramid

| Level | Target | Coverage | Tools |
|-------|--------|----------|-------|
| Unit | Domain layer, utils | 90%+ | Dart test, Mockito |
| Integration | Repository implementations | 80%+ | Firebase Emulator Suite |
| Widget | UI components | 70%+ | Flutter test, Golden tests |
| E2E | Critical user flows | Key paths | Patrol, integration_test |

### 10.2 Critical Test Scenarios

#### 10.2.1 Earn Flow Tests

- Video completion tracking accuracy
- Survey submission with all answer types
- Daily cap enforcement at 30 completions
- Streak calculation on consecutive days
- Pot contribution rounding
- Bonus video (every 5th) detection

#### 10.2.2 Wallet Tests

- Balance update atomicity
- Transaction immutability
- Cashout eligibility (7-day minimum)
- First cashout 48-hour hold
- Concurrent transaction handling

#### 10.2.3 Money Chat Tests

- Send with sufficient balance
- Send with insufficient balance (reject)
- Request creation and expiry
- Pay request atomic transfer
- Daily send cap enforcement

#### 10.2.4 Pot Distribution Tests

- Daily pot close at 8pm SAST
- Top 5 ranking calculation
- Tiebreaker logic (completions > streak > referrals > timestamp)
- 40/25/20/10/5 split accuracy
- Weekly pot pro-rata calculation

### 10.3 Load Testing

| Scenario | Target | Metric |
|----------|--------|--------|
| Concurrent earns | 1,000 users | < 500ms p95 latency |
| Pot close job | 100,000 users | < 5 min completion |
| Wallet reads | 10,000 rps | < 100ms p95 |
| Chat sends | 500 concurrent | Zero balance inconsistencies |

---

## APPENDIX A: BRS Coverage Matrix

Complete mapping of BRS Chapter 7 sections to technical implementation:

| BRS Section | Epic ID | Implementation Status |
|-------------|---------|----------------------|
| 7.1 Onboarding & Identity | IMC-ID | ✅ Complete |
| 7.2 Earn Loop | IMC-EARN | ✅ Complete |
| 7.3 Wallet & Transactions | IMC-WAL | ✅ Complete |
| 7.4 Gamification | IMC-GAME | ✅ Complete |
| 7.5 Referrals | IMC-REF | ✅ Complete |
| 7.6 Anti-Fraud & Fair-Play | IMC-FRAUD | ✅ Complete |
| 7.7 Notifications | IMC-NOTIF | ✅ Complete |
| 7.8 Admin & Reporting | IMC-ADMIN | ✅ Complete |
| 7.9 Money Chat | IMC-CHAT | ✅ Complete **(CRITICAL: No free text)** |
| 7.10 Home & Navigation | IMC-HOME | ✅ Complete |
| 7.11 Buy (Airtime/Electricity) | IMC-BUY | ✅ Complete |
| 7.12 Transaction History | IMC-HIST | ✅ Complete |
| 7.13 Direct Advertiser Portal | IMC-ADV | ✅ Complete |

---

## APPENDIX B: Glossary

| Term | Definition |
|------|------------|
| Token | iMaliChat value unit. 1 token = R0.01 |
| Engagement | Complete earn action: watch video + answer survey |
| Streak | Consecutive days of earning. Multiplies score, not tokens |
| Daily Pot | Pool of tokens distributed to top 5 users daily at 8pm SAST |
| Weekly Pot | Pool distributed to top 10 users weekly on Sunday 8pm SAST |
| Money Chat | P2P value transfer feature (no text messaging) |
| Chat Card | A Send or Request action in Money Chat |
| Cashout | Converting tokens to real value (airtime, vouchers, etc.) |
| Pot Eligibility | 48h lock for new users before they can win pots |
| G-PAY | External payment infrastructure for wallet operations |
| Risk Score | 0-100 fraud likelihood score based on behavior signals |
| Attention Check | Hidden survey questions to detect bot behavior |

---

## APPENDIX C: Open Items & Blockers

| Item | Priority | Status | Owner |
|------|----------|--------|-------|
| G-PAY API documentation | **CRITICAL** | Awaiting | G-PAY Team |
| Money Chat free-text wireframe fix | **CRITICAL** | Flagged | Design |
| Survey Service source (in-house vs 3rd party) | HIGH | Decision needed | Product |
| OTP vendor selection | HIGH | Evaluating | Engineering |
| Cloudflare Stream contract | MEDIUM | In progress | Ops |

---

*— END OF DOCUMENT —*
