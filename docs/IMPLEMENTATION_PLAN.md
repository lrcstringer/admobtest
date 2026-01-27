# iMaliChat Flutter Implementation Plan

**Version:** 1.0
**Date:** January 2026
**Architecture:** Clean Architecture (Uncle Bob)
**Platform:** Flutter 3.x + Firebase + G-PAY

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Architecture Foundation](#2-architecture-foundation)
3. [Phase 1: Project Setup & Core Infrastructure](#phase-1-project-setup--core-infrastructure)
4. [Phase 2: Authentication & Onboarding](#phase-2-authentication--onboarding)
5. [Phase 3: Home & Navigation](#phase-3-home--navigation)
6. [Phase 4: Earn System](#phase-4-earn-system)
7. [Phase 5: Wallet & Transactions](#phase-5-wallet--transactions)
8. [Phase 6: Money Chat (P2P)](#phase-6-money-chat-p2p)
9. [Phase 7: Gamification (Pots & Leaderboards)](#phase-7-gamification-pots--leaderboards)
10. [Phase 8: Referrals](#phase-8-referrals)
11. [Phase 9: Buy Services (Airtime/Electricity)](#phase-9-buy-services-airtimeelectricity)
12. [Phase 10: Profile & Settings](#phase-10-profile--settings)
13. [Phase 11: Firebase Cloud Functions](#phase-11-firebase-cloud-functions)
14. [Phase 12: Security & Fraud Prevention](#phase-12-security--fraud-prevention)
15. [Phase 13: Testing & Quality Assurance](#phase-13-testing--quality-assurance)
16. [Phase 14: Polish & Launch Preparation](#phase-14-polish--launch-preparation)

---

## 1. Project Overview

### 1.1 Application Summary

iMaliChat is a gamified mobile wallet application that rewards users for their attention. Users earn tokens by watching short ads and completing surveys, then use those tokens to:
- Build wallet balances
- Climb daily/weekly leaderboards and win prize pots
- Send/receive value with friends (Money Chat)
- Purchase airtime and electricity

### 1.2 Key Business Rules

| Rule | Value |
|------|-------|
| Token Value | 1 token = R0.01 ZAR |
| Standard Reward | 5 tokens per completion |
| Bonus Reward | 10 tokens (every 5th completion) |
| Split | 90% user / 5% daily pot / 5% weekly pot |
| Daily Earn Cap | 30 completions |
| Cashout Minimum | 500 tokens (R5.00) |
| First Cashout Eligibility | 7 days after signup |
| New User Pot Lock | 48 hours |
| Streak Multipliers | +20% @ 3d, +35% @ 7d, +50% @ 14d (score only) |

### 1.3 Data Ownership

| Domain | Owner | Notes |
|--------|-------|-------|
| User profiles, preferences | iMaliChat (Firestore) | We own all user data |
| Engagements, videos, surveys | iMaliChat (Firestore) | Core business logic |
| Gamification (scores, streaks, pots) | iMaliChat (Firestore) | G-PAY has no concept of this |
| Referrals, fraud flags | iMaliChat (Firestore) | Our business rules |
| Chat threads/cards | iMaliChat (Firestore) | P2P money chat |
| Wallet balance | G-PAY API | G-PAY is authoritative |
| Transaction ledger | G-PAY API | Immutable payment history |

---

## 2. Architecture Foundation

### 2.1 Clean Architecture Layers

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

### 2.2 Dependency Rules (CRITICAL)

1. **Dependencies point INWARD only** - outer layers depend on inner layers
2. **Domain layer has ZERO dependencies** on frameworks or external services
3. **Data layer implements** repository interfaces defined in Domain
4. **Presentation layer depends on** Domain use cases, NEVER on Data sources
5. **Core layer provides** shared utilities available to all layers

### 2.3 Project Structure

```
lib/
├── main.dart
├── app.dart
├── injection_container.dart
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── api_constants.dart
│   │   └── ui_constants.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart
│   ├── usecases/
│   │   └── usecase.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── validators.dart
│   │   └── formatters.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       └── app_typography.dart
│
├── domain/
│   ├── entities/
│   │   ├── user.dart
│   │   ├── user_profile.dart
│   │   ├── wallet.dart
│   │   ├── transaction.dart
│   │   ├── engagement.dart
│   │   ├── earn_thread.dart
│   │   ├── earn_message.dart
│   │   ├── video.dart
│   │   ├── survey.dart
│   │   ├── chat_thread.dart
│   │   ├── chat_card.dart
│   │   ├── user_score.dart
│   │   ├── pot_pool.dart
│   │   ├── pot_distribution.dart
│   │   ├── referral.dart
│   │   ├── cashout.dart
│   │   ├── purchase.dart
│   │   ├── provider.dart
│   │   └── campaign.dart
│   ├── value_objects/
│   │   ├── phone_number.dart
│   │   ├── token_amount.dart
│   │   ├── username.dart
│   │   └── engagement_evidence.dart
│   ├── enums/
│   │   ├── user_status.dart
│   │   ├── transaction_type.dart
│   │   ├── engagement_status.dart
│   │   ├── chat_card_type.dart
│   │   ├── chat_card_status.dart
│   │   ├── pot_type.dart
│   │   ├── cashout_status.dart
│   │   └── sync_status.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── user_repository.dart
│   │   ├── wallet_repository.dart
│   │   ├── engagement_repository.dart
│   │   ├── earn_inbox_repository.dart
│   │   ├── chat_repository.dart
│   │   ├── gamification_repository.dart
│   │   ├── referral_repository.dart
│   │   ├── purchase_repository.dart
│   │   └── campaign_repository.dart
│   └── usecases/
│       ├── auth/
│       ├── earn/
│       ├── wallet/
│       ├── chat/
│       ├── gamification/
│       ├── referrals/
│       ├── buy/
│       └── profile/
│
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── wallet_model.dart
│   │   ├── transaction_model.dart
│   │   ├── engagement_model.dart
│   │   ├── earn_thread_model.dart
│   │   ├── chat_thread_model.dart
│   │   ├── chat_card_model.dart
│   │   ├── user_score_model.dart
│   │   ├── pot_pool_model.dart
│   │   ├── referral_model.dart
│   │   └── purchase_model.dart
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── firebase_auth_source.dart
│   │   │   ├── firestore_source.dart
│   │   │   ├── functions_source.dart
│   │   │   └── gpay_api_source.dart
│   │   └── local/
│   │       ├── drift_database.dart
│   │       ├── tables/
│   │       └── daos/
│   ├── repositories/
│   │   ├── auth_repository_impl.dart
│   │   ├── user_repository_impl.dart
│   │   ├── wallet_repository_impl.dart
│   │   ├── engagement_repository_impl.dart
│   │   ├── earn_inbox_repository_impl.dart
│   │   ├── chat_repository_impl.dart
│   │   ├── gamification_repository_impl.dart
│   │   ├── referral_repository_impl.dart
│   │   └── purchase_repository_impl.dart
│   └── mappers/
│       ├── user_mapper.dart
│       ├── wallet_mapper.dart
│       └── ...
│
└── presentation/
    ├── common/
    │   ├── widgets/
    │   │   ├── app_button.dart
    │   │   ├── app_card.dart
    │   │   ├── app_text_field.dart
    │   │   ├── loading_indicator.dart
    │   │   ├── error_widget.dart
    │   │   └── ...
    │   └── animations/
    │       ├── reward_animation.dart
    │       └── page_transitions.dart
    ├── navigation/
    │   ├── app_router.dart
    │   └── routes.dart
    ├── features/
    │   ├── auth/
    │   │   ├── bloc/
    │   │   ├── pages/
    │   │   └── widgets/
    │   ├── onboarding/
    │   ├── home/
    │   ├── earn/
    │   ├── wallet/
    │   ├── chat/
    │   ├── pots/
    │   ├── referrals/
    │   ├── buy/
    │   └── profile/
    └── shell/
        ├── main_shell.dart
        └── bottom_nav.dart
```

### 2.4 Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| Mobile App | Flutter 3.x + Dart | Cross-platform iOS/Android |
| State Management | flutter_bloc + freezed | Predictable state, code generation |
| Local Database | drift (SQLite) | Offline-first data persistence |
| DI | get_it + injectable | Dependency injection |
| Routing | go_router | Declarative navigation |
| Backend | Firebase Cloud Functions | Serverless business logic |
| Database | Cloud Firestore | Real-time NoSQL document store |
| Auth | Firebase Auth | Phone OTP authentication |
| Push | Firebase Cloud Messaging | User engagement |
| Video | Cloudflare Stream | Ad video delivery |
| Payments | G-PAY API | Wallet infrastructure |
| Security | Play Integrity API | Anti-fraud device checks |

---

## Phase 1: Project Setup & Core Infrastructure

### Duration: Week 1

### 1.1 Flutter Project Initialization

#### Task 1.1.1: Create Flutter Project
```bash
flutter create --org com.imalichat --project-name imalichat .
```

#### Task 1.1.2: Configure pubspec.yaml

```yaml
name: imalichat
description: iMaliChat - Earn rewards for your attention
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2

  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

  # Dependency Injection
  get_it: ^7.6.4
  injectable: ^2.3.2

  # Navigation
  go_router: ^12.1.1

  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  cloud_functions: ^4.6.0
  firebase_messaging: ^14.7.9
  firebase_analytics: ^10.7.4
  firebase_app_check: ^0.2.1+8

  # Local Database
  drift: ^2.14.1
  sqlite3_flutter_libs: ^0.5.18
  path_provider: ^2.1.1
  path: ^1.8.3

  # Networking
  dio: ^5.4.0
  connectivity_plus: ^5.0.2

  # Utilities
  dartz: ^0.10.1
  equatable: ^2.0.5
  intl: ^0.18.1
  uuid: ^4.2.2

  # UI
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  lottie: ^2.7.0
  video_player: ^2.8.2

  # Forms & Validation
  reactive_forms: ^16.1.1

  # Secure Storage
  flutter_secure_storage: ^9.0.0

  # Contacts
  flutter_contacts: ^1.1.7+1

  # Share
  share_plus: ^7.2.1
  url_launcher: ^6.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1

  # Code Generation
  build_runner: ^2.4.8
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  injectable_generator: ^2.4.1
  drift_dev: ^2.14.1

  # Testing
  bloc_test: ^9.1.5
  mocktail: ^1.0.1

  # Golden Tests
  golden_toolkit: ^0.15.0

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/

  fonts:
    - family: Outfit
      fonts:
        - asset: assets/fonts/Outfit-Regular.ttf
        - asset: assets/fonts/Outfit-Medium.ttf
          weight: 500
        - asset: assets/fonts/Outfit-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Outfit-Bold.ttf
          weight: 700
```

#### Task 1.1.3: Create Directory Structure
Create all directories as specified in section 2.3.

### 1.2 Core Layer Implementation

#### Task 1.2.1: App Constants
**File:** `lib/core/constants/app_constants.dart`

```dart
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
    3: 1.20,
    7: 1.35,
    14: 1.50,
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
  static const int dailyPotCloseHour = 20;
  static const int weeklyPotCloseDay = 7; // Sunday
}
```

#### Task 1.2.2: Error Handling with Freezed
**File:** `lib/core/error/failures.dart`

```dart
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

extension FailureX on Failure {
  String get displayMessage => when(
    network: (message) => message ?? 'Network error occurred',
    timeout: () => 'Request timed out',
    noInternet: () => 'No internet connection',
    unauthenticated: () => 'Please sign in to continue',
    invalidOtp: () => 'Invalid verification code',
    otpExpired: () => 'Verification code expired',
    tooManyAttempts: () => 'Too many attempts. Try again later',
    dailyCapReached: () => 'Daily earning limit reached',
    insufficientBalance: () => 'Insufficient balance',
    cashoutNotEligible: () => 'Not eligible for cashout yet',
    potNotEligible: () => 'Not eligible for pot participation',
    userSuspended: () => 'Account suspended',
    invalidPhone: () => 'Invalid phone number',
    invalidUsername: () => 'Invalid username',
    invalidAmount: () => 'Invalid amount',
    serverError: (code, message) => message ?? 'Server error occurred',
    unknown: (message) => message ?? 'An unexpected error occurred',
  );
}
```

#### Task 1.2.3: Use Case Base Class
**File:** `lib/core/usecases/usecase.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
```

#### Task 1.2.4: Network Info
**File:** `lib/core/network/network_info.dart`

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return connectivity.onConnectivityChanged
        .map((result) => result != ConnectivityResult.none);
  }
}
```

### 1.3 Theme & Design System

#### Task 1.3.1: App Colors
**File:** `lib/core/theme/app_colors.dart`

```dart
import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFFFF338A);       // Pink
  static const Color primaryLight = Color(0xFFFF6AAB);
  static const Color primaryDark = Color(0xFFCC2A6E);

  // Secondary (Accent)
  static const Color secondary = Color(0xFFFFC107);     // Yellow/Gold
  static const Color secondaryLight = Color(0xFFFFD54F);
  static const Color secondaryDark = Color(0xFFFFA000);

  // Background
  static const Color background = Color(0xFF0B1929);    // Navy
  static const Color backgroundLight = Color(0xFF0F2744);
  static const Color card = Color(0xFF132D4A);
  static const Color cardLight = Color(0xFF1A3A5C);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF97316);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Borders & Dividers
  static const Color border = Color(0x1AFFFFFF);        // white/10
  static const Color borderLight = Color(0x0DFFFFFF);   // white/5

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFF6B9D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0B2A55), Color(0xFF05152A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dailyPotGradient = LinearGradient(
    colors: [Color(0x33FFC107), Color(0x1AFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient weeklyPotGradient = LinearGradient(
    colors: [Color(0x33A855F7), Color(0x1AEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

#### Task 1.3.2: App Typography
**File:** `lib/core/theme/app_typography.dart`

```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTypography {
  static const String fontFamily = 'Outfit';

  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
    height: 1.4,
  );

  // Special
  static const TextStyle balance = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}
```

#### Task 1.3.3: App Theme
**File:** `lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

abstract class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppTypography.fontFamily,

    // Colors
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.card,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: AppTypography.h2,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),

    // Cards
    cardTheme: CardTheme(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTypography.button,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTypography.button,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTypography.button,
      ),
    ),

    // Input
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textMuted,
      ),
      labelStyle: AppTypography.label,
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.card,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.borderLight,
      thickness: 1,
    ),

    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );
}
```

### 1.4 Dependency Injection Setup

#### Task 1.4.1: GetIt Configuration
**File:** `lib/injection_container.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseAuth get auth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFunctions get functions => FirebaseFunctions.instance;
}

@module
abstract class ExternalModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
```

### 1.5 Firebase Configuration

#### Task 1.5.1: Firebase Project Setup
1. Create Firebase project in Firebase Console
2. Enable Authentication (Phone provider)
3. Create Firestore database
4. Enable Cloud Functions
5. Enable App Check

#### Task 1.5.2: FlutterFire CLI Configuration
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

#### Task 1.5.3: Main Entry Point
**File:** `lib/main.dart`

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure dependencies
  await configureDependencies();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const IMaliChatApp());
}
```

---

## Phase 2: Authentication & Onboarding

### Duration: Week 2

### 2.1 Domain Layer - Auth

#### Task 2.1.1: User Entity
**File:** `lib/domain/entities/user.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/phone_number.dart';
import '../enums/user_status.dart';
import 'user_profile.dart';

part 'user.freezed.dart';

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
    int? riskScore,
  }) = _User;

  const User._();

  bool get isVerified => status == UserStatus.active;

  bool get canEarn => isVerified && profile != null;

  bool get canCashout {
    final daysSinceSignup = DateTime.now().difference(createdAt).inDays;
    return daysSinceSignup >= 7; // AppConstants.firstCashoutEligibilityDays
  }

  bool get isPotEligibleNow {
    if (!isPotEligible) return false;
    if (potEligibleAt == null) return false;
    return DateTime.now().isAfter(potEligibleAt!);
  }
}
```

#### Task 2.1.2: Phone Number Value Object
**File:** `lib/domain/value_objects/phone_number.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/error/failures.dart';

part 'phone_number.freezed.dart';

@freezed
class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber(String value) = _PhoneNumber;
  const PhoneNumber._();

  static Either<Failure, PhoneNumber> create(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleaned.length < 10 || cleaned.length > 15) {
      return left(const Failure.invalidPhone());
    }

    // Normalize to E.164 format for South Africa
    String normalized;
    if (cleaned.startsWith('0')) {
      normalized = '+27${cleaned.substring(1)}';
    } else if (cleaned.startsWith('27')) {
      normalized = '+$cleaned';
    } else if (cleaned.startsWith('+27')) {
      normalized = cleaned;
    } else {
      return left(const Failure.invalidPhone());
    }

    // Validate length for SA numbers
    if (normalized.length != 12) {
      return left(const Failure.invalidPhone());
    }

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
```

#### Task 2.1.3: Auth Repository Interface
**File:** `lib/domain/repositories/auth_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../value_objects/phone_number.dart';

abstract class AuthRepository {
  /// Request OTP for phone number verification
  Future<Either<Failure, String>> requestOtp(PhoneNumber phone);

  /// Verify OTP code and sign in/up user
  Future<Either<Failure, User>> verifyOtp({
    required String verificationId,
    required String code,
  });

  /// Get current authenticated user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Stream of auth state changes
  Stream<User?> get authStateChanges;

  /// Sign out current user
  Future<Either<Failure, Unit>> signOut();

  /// Check if user exists by phone
  Future<Either<Failure, bool>> userExistsByPhone(PhoneNumber phone);
}
```

#### Task 2.1.4: Auth Use Cases
**File:** `lib/domain/usecases/auth/request_otp.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth_repository.dart';
import '../../value_objects/phone_number.dart';

@injectable
class RequestOtpUseCase implements UseCase<String, RequestOtpParams> {
  final AuthRepository repository;

  RequestOtpUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(RequestOtpParams params) {
    return repository.requestOtp(params.phoneNumber);
  }
}

class RequestOtpParams {
  final PhoneNumber phoneNumber;

  const RequestOtpParams({required this.phoneNumber});
}
```

**File:** `lib/domain/usecases/auth/verify_otp.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

@injectable
class VerifyOtpUseCase implements UseCase<User, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(VerifyOtpParams params) {
    return repository.verifyOtp(
      verificationId: params.verificationId,
      code: params.code,
    );
  }
}

class VerifyOtpParams {
  final String verificationId;
  final String code;

  const VerifyOtpParams({
    required this.verificationId,
    required this.code,
  });
}
```

### 2.2 Data Layer - Auth

#### Task 2.2.1: User Model
**File:** `lib/data/models/user_model.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String phoneNumber,
    required String status,
    required bool isPotEligible,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? potEligibleAt,
    String? currentVisitorId,
    String? displayName,
    String? username,
    String? avatarUrl,
    String? gender,
    @TimestampConverter() DateTime? dateOfBirth,
    String? province,
    int? riskScore,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({...data, 'id': doc.id});
  }
}

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    return DateTime.parse(json as String);
  }

  @override
  dynamic toJson(DateTime object) => Timestamp.fromDate(object);
}
```

#### Task 2.2.2: User Mapper
**File:** `lib/data/mappers/user_mapper.dart`

```dart
import '../../domain/entities/user.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/enums/user_status.dart';
import '../../domain/value_objects/phone_number.dart';
import '../models/user_model.dart';

class UserMapper {
  static User toEntity(UserModel model) {
    return User(
      id: model.id,
      phoneNumber: PhoneNumber(model.phoneNumber),
      status: UserStatus.values.firstWhere(
        (e) => e.name == model.status,
        orElse: () => UserStatus.pending,
      ),
      isPotEligible: model.isPotEligible,
      createdAt: model.createdAt,
      potEligibleAt: model.potEligibleAt,
      currentVisitorId: model.currentVisitorId,
      riskScore: model.riskScore,
      profile: model.displayName != null
          ? UserProfile(
              displayName: model.displayName!,
              username: model.username,
              avatarUrl: model.avatarUrl,
              gender: model.gender,
              dateOfBirth: model.dateOfBirth,
              province: model.province,
            )
          : null,
    );
  }

  static UserModel toModel(User entity) {
    return UserModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber.value,
      status: entity.status.name,
      isPotEligible: entity.isPotEligible,
      createdAt: entity.createdAt,
      potEligibleAt: entity.potEligibleAt,
      currentVisitorId: entity.currentVisitorId,
      displayName: entity.profile?.displayName,
      username: entity.profile?.username,
      avatarUrl: entity.profile?.avatarUrl,
      gender: entity.profile?.gender,
      dateOfBirth: entity.profile?.dateOfBirth,
      province: entity.profile?.province,
      riskScore: entity.riskScore,
    );
  }
}
```

#### Task 2.2.3: Firebase Auth Data Source
**File:** `lib/data/datasources/remote/firebase_auth_source.dart`

```dart
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';

abstract class FirebaseAuthSource {
  Future<String> requestOtp(String phoneNumber);
  Future<fb.User> verifyOtp(String verificationId, String code);
  fb.User? get currentUser;
  Stream<fb.User?> get authStateChanges;
  Future<void> signOut();
}

@LazySingleton(as: FirebaseAuthSource)
class FirebaseAuthSourceImpl implements FirebaseAuthSource {
  final fb.FirebaseAuth _auth;
  String? _verificationId;

  FirebaseAuthSourceImpl(this._auth);

  @override
  Future<String> requestOtp(String phoneNumber) async {
    final completer = Completer<String>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        // Auto-verification (Android only)
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        if (exception.code == 'too-many-requests') {
          completer.completeError(TooManyRequestsException());
        } else {
          completer.completeError(AuthException(exception.message));
        }
      },
      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
    );

    return completer.future;
  }

  @override
  Future<fb.User> verifyOtp(String verificationId, String code) async {
    try {
      final credential = fb.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      final result = await _auth.signInWithCredential(credential);

      if (result.user == null) {
        throw AuthException('Verification failed');
      }

      return result.user!;
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        throw InvalidOtpException();
      }
      if (e.code == 'session-expired') {
        throw OtpExpiredException();
      }
      throw AuthException(e.message);
    }
  }

  @override
  fb.User? get currentUser => _auth.currentUser;

  @override
  Stream<fb.User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<void> signOut() => _auth.signOut();
}
```

#### Task 2.2.4: Auth Repository Implementation
**File:** `lib/data/repositories/auth_repository_impl.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/value_objects/phone_number.dart';
import '../datasources/remote/firebase_auth_source.dart';
import '../datasources/remote/firestore_source.dart';
import '../mappers/user_mapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthSource _authSource;
  final FirestoreSource _firestoreSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._authSource,
    this._firestoreSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, String>> requestOtp(PhoneNumber phone) async {
    if (!await _networkInfo.isConnected) {
      return left(const Failure.noInternet());
    }

    try {
      final verificationId = await _authSource.requestOtp(phone.value);
      return right(verificationId);
    } on TooManyRequestsException {
      return left(const Failure.tooManyAttempts());
    } on AuthException catch (e) {
      return left(Failure.serverError(message: e.message));
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String verificationId,
    required String code,
  }) async {
    if (!await _networkInfo.isConnected) {
      return left(const Failure.noInternet());
    }

    try {
      final firebaseUser = await _authSource.verifyOtp(verificationId, code);

      // Check if user exists in Firestore
      var userModel = await _firestoreSource.getUser(firebaseUser.uid);

      if (userModel == null) {
        // Create new user
        userModel = await _firestoreSource.createUser(
          userId: firebaseUser.uid,
          phoneNumber: firebaseUser.phoneNumber!,
        );
      }

      return right(UserMapper.toEntity(userModel));
    } on InvalidOtpException {
      return left(const Failure.invalidOtp());
    } on OtpExpiredException {
      return left(const Failure.otpExpired());
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final firebaseUser = _authSource.currentUser;
      if (firebaseUser == null) {
        return right(null);
      }

      final userModel = await _firestoreSource.getUser(firebaseUser.uid);
      if (userModel == null) {
        return right(null);
      }

      return right(UserMapper.toEntity(userModel));
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return _authSource.authStateChanges.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      final userModel = await _firestoreSource.getUser(firebaseUser.uid);
      if (userModel == null) return null;

      return UserMapper.toEntity(userModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _authSource.signOut();
      return right(unit);
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> userExistsByPhone(PhoneNumber phone) async {
    try {
      final exists = await _firestoreSource.userExistsByPhone(phone.value);
      return right(exists);
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }
}
```

### 2.3 Presentation Layer - Auth

#### Task 2.3.1: Auth BLoC
**File:** `lib/presentation/features/auth/bloc/auth_bloc.dart`

```dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/auth/get_current_user.dart';
import '../../../../domain/usecases/auth/request_otp.dart';
import '../../../../domain/usecases/auth/sign_out.dart';
import '../../../../domain/usecases/auth/verify_otp.dart';
import '../../../../domain/value_objects/phone_number.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RequestOtpUseCase _requestOtp;
  final VerifyOtpUseCase _verifyOtp;
  final GetCurrentUserUseCase _getCurrentUser;
  final SignOutUseCase _signOut;

  AuthBloc(
    this._requestOtp,
    this._verifyOtp,
    this._getCurrentUser,
    this._signOut,
  ) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthOtpVerified>(_onOtpVerified);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _getCurrentUser(const NoParams());

    result.fold(
      (failure) => emit(AuthState.unauthenticated(failure.displayMessage)),
      (user) {
        if (user != null) {
          if (user.profile != null) {
            emit(AuthState.authenticated(user));
          } else {
            emit(AuthState.profileRequired(user));
          }
        } else {
          emit(const AuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> _onOtpRequested(
    AuthOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final phoneResult = PhoneNumber.create(event.phoneNumber);

    await phoneResult.fold(
      (failure) async => emit(AuthState.error(failure.displayMessage)),
      (phone) async {
        final result = await _requestOtp(RequestOtpParams(phoneNumber: phone));

        result.fold(
          (failure) => emit(AuthState.error(failure.displayMessage)),
          (verificationId) => emit(AuthState.otpSent(
            verificationId: verificationId,
            phoneNumber: phone,
          )),
        );
      },
    );
  }

  Future<void> _onOtpVerified(
    AuthOtpVerified event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _verifyOtp(VerifyOtpParams(
      verificationId: event.verificationId,
      code: event.code,
    ));

    result.fold(
      (failure) => emit(AuthState.error(failure.displayMessage)),
      (user) {
        if (user.profile != null) {
          emit(AuthState.authenticated(user));
        } else {
          emit(AuthState.profileRequired(user));
        }
      },
    );
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOut(const NoParams());
    emit(const AuthState.unauthenticated());
  }
}
```

**File:** `lib/presentation/features/auth/bloc/auth_event.dart`

```dart
part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkRequested() = AuthCheckRequested;
  const factory AuthEvent.otpRequested(String phoneNumber) = AuthOtpRequested;
  const factory AuthEvent.otpVerified({
    required String verificationId,
    required String code,
  }) = AuthOtpVerified;
  const factory AuthEvent.signOutRequested() = AuthSignOutRequested;
}
```

**File:** `lib/presentation/features/auth/bloc/auth_state.dart`

```dart
part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.otpSent({
    required String verificationId,
    required PhoneNumber phoneNumber,
  }) = _OtpSent;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.profileRequired(User user) = _ProfileRequired;
  const factory AuthState.unauthenticated([String? message]) = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}
```

### 2.4 Auth Screens

#### Task 2.4.1: Onboarding Screen
**File:** `lib/presentation/features/onboarding/pages/onboarding_page.dart`

**UI Requirements:**
- Full-screen hero image with wave pattern (navy/pink/yellow gradient)
- iMaliChat logo (left-aligned, with glow effect)
- Hero text: "Turn your attention into earning power." (gradient text on "attention")
- Subtitle: "Join the community where your time pays off. Literally."
- Value proposition checklist with checkmark icons:
  - "Watch short ads to earn tokens"
  - "Answer quick surveys for cash"
  - "Join daily prize pots & win big"
- "Get Started" primary button (full-width, pink, shadow glow)
- "Already have an account? Log in" text button

#### Task 2.4.2: Phone Entry Screen
**File:** `lib/presentation/features/auth/pages/phone_entry_page.dart`

**UI Requirements:**
- Back button (top-left)
- Logo in circular container (centered)
- Title: "Enter your phone number"
- Subtitle: "We'll send you a verification code"
- Phone input card:
  - Country flag icon (+27)
  - Divider
  - Phone number input field
  - Validation feedback
- "Send Code" primary button (disabled until valid)
- Terms text at bottom

#### Task 2.4.3: OTP Verification Screen
**File:** `lib/presentation/features/auth/pages/otp_verification_page.dart`

**UI Requirements:**
- Back button
- Title: "Enter verification code"
- Subtitle: "We sent a code to {phone number}"
- 6-digit OTP input (individual boxes with focus animation)
- Auto-submit on 6 digits
- Countdown timer for resend (60 seconds)
- "Resend Code" button (disabled during countdown)
- Loading state during verification

#### Task 2.4.4: Profile Setup Screen
**File:** `lib/presentation/features/auth/pages/profile_setup_page.dart`

**UI Requirements:**
- Title: "Create Profile"
- Subtitle: "Tell us a bit about yourself to start earning."
- Photo upload (circular, with camera icon overlay, dashed border)
- Form fields:
  - First Name + Surname (2-column grid)
  - Username (with @ prefix, max 20 chars, no spaces hint)
  - Location dropdown (provinces)
  - Date of Birth (3 dropdowns: Day/Month/Year)
  - Gender (4 options: Female, Male, Non-binary, Prefer not to say)
- "Complete Profile" button (full-width, pink)
- Scroll support for smaller screens

---

## Phase 3: Home & Navigation

### Duration: Week 3

### 3.1 Navigation Shell

#### Task 3.1.1: Bottom Navigation
**File:** `lib/presentation/shell/bottom_nav.dart`

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
    _NavItem(icon: Icons.workspace_premium, label: 'Earn', route: '/earn'),
    _NavItem(icon: Icons.chat_bubble_rounded, label: 'Chat', route: '/chat'),
    _NavItem(icon: Icons.account_balance_wallet, label: 'Wallets', route: '/wallets'),
    _NavItem(icon: Icons.shopping_cart_rounded, label: 'Buy', route: '/buy'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card.withOpacity(0.95),
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = index == currentIndex;

              return _NavButton(
                icon: item.icon,
                label: item.label,
                isActive: isActive,
                onTap: () => context.go(item.route),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isActive ? AppColors.primary : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Task 3.1.2: Main Shell with GoRouter
**File:** `lib/presentation/shell/main_shell.dart`

```dart
import 'package:flutter/material.dart';
import 'bottom_nav.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainShell({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNav(currentIndex: currentIndex),
    );
  }
}
```

#### Task 3.1.3: App Router Configuration
**File:** `lib/presentation/navigation/app_router.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/otp_verification_page.dart';
import '../features/auth/pages/phone_entry_page.dart';
import '../features/auth/pages/profile_setup_page.dart';
import '../features/buy/pages/buy_home_page.dart';
import '../features/chat/pages/chat_list_page.dart';
import '../features/earn/pages/earn_inbox_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/onboarding/pages/onboarding_page.dart';
import '../features/profile/pages/profile_page.dart';
import '../features/wallet/pages/wallets_page.dart';
import '../shell/main_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = authBloc.state;
      final isLoggedIn = authState.maybeMap(
        authenticated: (_) => true,
        orElse: () => false,
      );
      final needsProfile = authState.maybeMap(
        profileRequired: (_) => true,
        orElse: () => false,
      );

      final isOnboarding = state.matchedLocation == '/onboarding';
      final isAuthFlow = state.matchedLocation.startsWith('/auth');
      final isSplash = state.matchedLocation == '/splash';

      if (isSplash) return null;

      if (needsProfile && !state.matchedLocation.contains('profile-setup')) {
        return '/auth/profile-setup';
      }

      if (!isLoggedIn && !isAuthFlow && !isOnboarding) {
        return '/onboarding';
      }

      if (isLoggedIn && (isAuthFlow || isOnboarding)) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const PhoneEntryPage(),
        routes: [
          GoRoute(
            path: 'phone',
            builder: (context, state) => const PhoneEntryPage(),
          ),
          GoRoute(
            path: 'otp',
            builder: (context, state) => const OtpVerificationPage(),
          ),
          GoRoute(
            path: 'profile-setup',
            builder: (context, state) => const ProfileSetupPage(),
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final index = _getNavIndex(state.matchedLocation);
          return MainShell(currentIndex: index, child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: '/earn',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EarnInboxPage(),
            ),
            routes: [
              GoRoute(
                path: ':threadId',
                builder: (context, state) => EarnThreadPage(
                  threadId: state.pathParameters['threadId']!,
                ),
              ),
              GoRoute(
                path: 'detail/:id',
                builder: (context, state) => EarnDetailPage(
                  opportunityId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/chat',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChatListPage(),
            ),
            routes: [
              GoRoute(
                path: ':contactId',
                builder: (context, state) => ChatThreadPage(
                  contactId: state.pathParameters['contactId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/wallets',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WalletsPage(),
            ),
            routes: [
              GoRoute(
                path: ':walletId',
                builder: (context, state) => WalletDetailPage(
                  walletId: state.pathParameters['walletId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/buy',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BuyHomePage(),
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/pots',
            builder: (context, state) => const PotsPage(),
          ),
          GoRoute(
            path: '/leaderboard',
            builder: (context, state) => const LeaderboardPage(),
          ),
        ],
      ),
    ],
  );
}

int _getNavIndex(String location) {
  if (location.startsWith('/home')) return 0;
  if (location.startsWith('/earn')) return 1;
  if (location.startsWith('/chat')) return 2;
  if (location.startsWith('/wallets')) return 3;
  if (location.startsWith('/buy')) return 4;
  return 0;
}
```

### 3.2 Home Screen

#### Task 3.2.1: Home BLoC
**File:** `lib/presentation/features/home/bloc/home_bloc.dart`

**State:**
```dart
@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required String userName,
    required String greeting,
    required int totalTokens,
    required int streak,
    required int? dailyRank,
    required PotInfo dailyPot,
    required PotInfo weeklyPot,
  }) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}

@freezed
class PotInfo with _$PotInfo {
  const factory PotInfo({
    required double amount,
    required DateTime closesAt,
  }) = _PotInfo;
}
```

#### Task 3.2.2: Home Page UI
**File:** `lib/presentation/features/home/pages/home_page.dart`

**UI Requirements:**
1. **Header Section:**
   - Greeting text ("Good morning,") + username
   - Streak badge (orange pill with flame icon)
   - Daily rank if available
   - Profile avatar (right side, tappable, circular with + badge)

2. **Wallet Card:**
   - Gradient background (navy to darker navy)
   - Decorative blur circles (pink/blue)
   - "Total Token Balance" label
   - Large balance number (32px bold)
   - "Earn Now" primary button (full-width)

3. **Pot Cards (2-column grid):**
   - Daily Pot card:
     - Orange gradient top border
     - "DAILY" label (uppercase, orange)
     - Pot amount in Rand
     - Countdown timer
     - User rank display
     - Chevron icon for navigation
   - Weekly Pot card:
     - Purple gradient top border
     - "WEEKLY" label (uppercase, purple)
     - Same structure as daily

4. **Referral Banner:**
   - Full-width button with user icon
   - "Invite friends & Earn" text

5. **How it works link:**
   - Text button centered at bottom

---

## Phase 4: Earn System

### Duration: Week 4-5

### 4.1 Domain Layer - Earn

#### Task 4.1.1: Earn Entities

**File:** `lib/domain/entities/earn_thread.dart`
```dart
@freezed
class EarnThread with _$EarnThread {
  const factory EarnThread({
    required String id,
    required String brandId,
    required String brandName,
    String? avatarColor,
    String? avatarImage,
    required bool isPinned,
    required bool isActive,
    required int availableOpportunities,
    required DateTime createdAt,
  }) = _EarnThread;
}
```

**File:** `lib/domain/entities/engagement.dart`
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

**File:** `lib/domain/entities/earn_opportunity.dart`
```dart
@freezed
class EarnOpportunity with _$EarnOpportunity {
  const factory EarnOpportunity({
    required String id,
    required String threadId,
    required String title,
    String? description,
    required int tokenReward,
    required String mediaType, // 'video', 'image', 'text'
    required String mediaUrl,
    required List<SurveyQuestion> questions,
    required int durationSeconds,
    DateTime? expiresAt,
    required bool isActive,
  }) = _EarnOpportunity;
}

@freezed
class SurveyQuestion with _$SurveyQuestion {
  const factory SurveyQuestion({
    required String id,
    required String text,
    required List<String> options,
    required int orderIndex,
  }) = _SurveyQuestion;
}
```

#### Task 4.1.2: Engagement Repository Interface
**File:** `lib/domain/repositories/engagement_repository.dart`

```dart
abstract class EngagementRepository {
  Future<Either<Failure, Engagement>> startEngagement(String opportunityId);

  Future<Either<Failure, EngagementResult>> submitSurvey({
    required String engagementId,
    required Map<String, String> answers,
    required EngagementEvidence evidence,
  });

  Future<Either<Failure, int>> getDailyCompletionCount();

  Future<Either<Failure, List<Engagement>>> getRecentEngagements({int limit = 20});
}

@freezed
class EngagementResult with _$EngagementResult {
  const factory EngagementResult({
    required int tokensEarned,
    required double scoreEarned,
    required int newBalance,
    required bool isBonus,
    required int streakDays,
  }) = _EngagementResult;
}
```

#### Task 4.1.3: Earn Use Cases

```dart
// GetEarnInboxUseCase - Get all earn threads
// StartEngagementUseCase - Start watching a video
// SubmitSurveyUseCase - Submit survey and claim reward
// GetDailyProgressUseCase - Get completions today vs cap
```

### 4.2 Presentation Layer - Earn

#### Task 4.2.1: Earn Inbox Page
**UI Requirements:**
1. **Header:**
   - Title: "Earn Chats"
   - Active threads badge (e.g., "3 Active Threads")
   - Subtitle: "Chat with brands, complete tasks, earn money."
   - "Invite friends & Earn" button

2. **Thread List:**
   - Each thread row:
     - Brand avatar (circular, with image or initial + color)
     - Active indicator (green dot)
     - Brand name (bold)
     - "Tap to view earning opportunities" subtitle
     - "Active" badge (yellow/green)
     - Pin icon if pinned
     - Chevron for navigation
   - Staggered animation on load

#### Task 4.2.2: Earn Thread Page
**UI Requirements:**
1. **Header:**
   - Back button
   - Brand avatar
   - Brand name
   - "Active Session" status with pulse indicator

2. **Chat Area:**
   - Date separator ("Today, {date}")
   - System message (welcome text, centered pill)
   - Earn message cards (left-aligned):
     - Brand avatar (small)
     - EarnMessageCard component

3. **EarnMessageCard Widget:**
   - Title
   - Description
   - Reward badge (yellow, with crown icon)
   - Duration badge
   - Type badge (Survey/Video)
   - Expiry countdown
   - Action button (pink)
   - Completed/Expired states

#### Task 4.2.3: Earn Detail Page (3-Step Flow)
**Step 1: Media View**
- Media content (video player, image, or text block)
- Progress bar / countdown timer (3 seconds for images/text, video duration for video)
- "Content Unlocked!" confirmation
- "Continue to Questions" button (disabled until unlocked)

**Step 2: Survey**
- Question counter ("Question 1 of 3")
- Reward per question badge
- Question text (large)
- Option buttons (selectable, with checkmark on selection)
- "Submit Answer" button
- Reward animation on each answer

**Step 3: Complete**
- Large success icon (green circle with checkmark)
- "Nice Work!" heading
- Token amount earned (large, yellow, with glow)
- "Tokens" label
- New balance card
- "Back to Earn Offers" button
- "Go Home" text button

#### Task 4.2.4: Reward Animation Widget
**File:** `lib/presentation/common/animations/reward_animation.dart`

- Confetti/coins animation
- Token count floating up
- Triggered on survey answer submission

---

## Phase 5: Wallet & Transactions

### Duration: Week 6

### 5.1 Domain Layer - Wallet

#### Task 5.1.1: Wallet Entity
```dart
@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String id,
    required String userId,
    required String name,
    required WalletType type, // main, brand
    required TokenAmount balance,
    required TokenAmount lifetimeEarned,
    required TokenAmount lifetimeWithdrawn,
    required bool canWithdraw,
    String? brandId,
    String? color,
    required int version,
    required DateTime updatedAt,
  }) = _Wallet;

  const Wallet._();

  bool get canCashout => balance >= TokenAmount(500);
  double get balanceZar => balance.value * 0.01;
}
```

#### Task 5.1.2: Transaction Entity
```dart
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String walletId,
    required TransactionType type,
    required TokenAmount amount,
    required TokenAmount balanceAfter,
    required DateTime createdAt,
    String? description,
    String? counterpartyId,
    String? counterpartyName,
    Map<String, dynamic>? metadata,
  }) = _Transaction;
}

enum TransactionType {
  earn,
  potWin,
  p2pSend,
  p2pReceive,
  cashout,
  refund,
  referral,
  purchase,
  adjustment,
  reversal,
}
```

### 5.2 Presentation Layer - Wallet

#### Task 5.2.1: Wallets List Page
**UI Requirements:**
1. **Header:**
   - Title: "My Wallets"
   - "Total Portfolio Value" label
   - Total balance in Rand (large)
   - "History" button (with clock icon)

2. **Wallet Cards:**
   - Colored left border accent
   - Wallet icon (iMali logo for main, shopping bag for brand)
   - Wallet name
   - Description
   - Token balance (large) + ZAR equivalent
   - Shield icon if can withdraw
   - Arrow icon for navigation

#### Task 5.2.2: Wallet Detail Page
**UI Requirements:**
1. **Header:**
   - Back button
   - Wallet name

2. **Balance Card:**
   - Gradient top border
   - Large wallet icon
   - Balance in Rand (large)
   - Token count

3. **Action Buttons (2-column):**
   - "Send" button (white background)
   - "Withdraw" button (disabled if not main wallet)

4. **Wallet Details Section:**
   - Type (Main/Brand)
   - Description
   - Withdrawal Status (Available/Restricted)

#### Task 5.2.3: Transaction History Page
**UI Requirements:**
- Transaction list:
  - Icon by type (color-coded)
  - Description
  - Amount (+/- with color)
  - Timestamp
  - "BONUS" label for bonus transactions
- Empty state if no transactions
- Pull-to-refresh
- Pagination

---

## Phase 6: Money Chat (P2P)

### Duration: Week 7

### 6.1 Domain Layer - Chat

#### Task 6.1.1: Chat Entities
```dart
@freezed
class ChatThread with _$ChatThread {
  const factory ChatThread({
    required String id,
    required List<String> participants,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? lastMessage,
    int? unreadCount,
  }) = _ChatThread;
}

@freezed
class ChatCard with _$ChatCard {
  const factory ChatCard({
    required String id,
    required String threadId,
    required ChatCardType type, // send, request
    required ChatCardStatus status, // pending, paid, declined, expired, cancelled
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
  bool get isExpired => dueDate != null &&
      DateTime.now().isAfter(dueDate!) &&
      status == ChatCardStatus.pending;
}

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String name,
    required String phoneNumber,
    required String initials,
    required bool isOnImaliChat,
    required bool blocked,
    String? userId,
  }) = _Contact;
}
```

#### Task 6.1.2: Chat Repository Interface
```dart
abstract class ChatRepository {
  Stream<List<ChatThread>> watchThreads();
  Stream<List<ChatCard>> watchCards(String threadId);

  Future<Either<Failure, ChatCard>> sendTokens({
    required String recipientId,
    required TokenAmount amount,
  });

  Future<Either<Failure, ChatCard>> createRequest({
    required String recipientId,
    required TokenAmount amount,
    DateTime? dueDate,
  });

  Future<Either<Failure, ChatCard>> payRequest(String cardId);
  Future<Either<Failure, ChatCard>> declineRequest(String cardId);

  Future<Either<Failure, List<Contact>>> getContacts();
  Future<Either<Failure, Unit>> syncContacts(List<Map<String, String>> contacts);
  Future<Either<Failure, Unit>> blockContact(String contactId);
  Future<Either<Failure, Unit>> unblockContact(String contactId);
}
```

### 6.2 Presentation Layer - Chat

#### Task 6.2.1: Chat List Page
**UI Requirements:**
1. **Header:**
   - Title: "Money Chat"
   - Tabs: "Chats" | "People"

2. **Chats Tab:**
   - Search bar
   - Thread list:
     - Avatar with initials
     - Contact name (bold if unread)
     - Last action summary
     - Date
     - Unread badge (yellow)
     - Blocked indicator if blocked
   - Empty state with "Start a new chat" CTA
   - Floating "Send / Request Money" button

3. **People Tab:**
   - Search bar
   - Filter badges: All | On iMaliChat | Invite
   - "Invite Many" button
   - Contact list:
     - Avatar
     - Name + phone
     - "iMali" badge if on app
     - "Invite" button if not on app
   - Selection mode for bulk invites
   - "Invite {n} via WhatsApp" sticky button when selecting

#### Task 6.2.2: Chat Thread Page
**UI Requirements:**
1. **Header:**
   - Back button
   - Contact avatar
   - Contact name
   - Status ("On iMaliChat" / "Invite pending")
   - More menu (Report, Block/Unblock)

2. **Chat Area:**
   - Blocked banner if blocked
   - "Not on iMaliChat" invite card if not registered
   - Money entries (styled as chat bubbles):
     - Sent: Pink bubble (right-aligned)
     - Received: Dark card bubble (left-aligned)
     - Amount (large)
     - "Requesting" prefix for requests
     - Note if provided
     - Status badge (Completed/Pending/Declined)

3. **Footer:**
   - Two buttons: "Request" (outline) | "Send" (pink)

#### Task 6.2.3: Send Money Flow
1. **Amount Entry:**
   - "Send to {contact}" header
   - Amount input (large, centered)
   - Token/ZAR toggle
   - Wallet balance display
   - "Continue" button

2. **Confirmation:**
   - Summary card
   - "Confirm Send" button

#### Task 6.2.4: Request Money Flow
1. **Amount Entry:**
   - "Request from {contact}" header
   - Amount input
   - Optional due date picker
   - "Request" button

---

## Phase 7: Gamification (Pots & Leaderboards)

### Duration: Week 8

### 7.1 Domain Layer - Gamification

#### Task 7.1.1: Gamification Entities
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
    String? lastActiveDate,
    required DateTime updatedAt,
  }) = _UserScore;

  const UserScore._();

  double get streakMultiplier {
    if (streakDays >= 14) return 1.50;
    if (streakDays >= 7) return 1.35;
    if (streakDays >= 3) return 1.20;
    return 1.0;
  }
}

@freezed
class PotPool with _$PotPool {
  const factory PotPool({
    required String id,
    required PotType type, // daily, weekly
    required TokenAmount totalTokens,
    required DateTime closesAt,
    required String status, // open, closed, distributed
    int? roundingBuffer,
  }) = _PotPool;
}

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required int rank,
    required String username,
    required String initials,
    required int score,
    required bool isCurrentUser,
  }) = _LeaderboardEntry;
}
```

### 7.2 Presentation Layer - Gamification

#### Task 7.2.1: Pots Page
**UI Requirements:**
1. **Header:**
   - Back button
   - Title: "Prize Pots"

2. **How it works card:**
   - Crown icon
   - "How it works" title
   - Explanation text

3. **Pot Cards:**
   - Daily Pot card (orange gradient):
     - Badge: "Daily Pot"
     - Amount (large, white)
     - "Ends in {time}" with clock icon
     - User stats card:
       - Your Rank
       - Your Score (with flame icon)
       - Progress bar
       - "Currently Winning!" or "Reach Top 100 to win"
     - "View Leaderboard" button

   - Weekly Pot card (purple gradient):
     - Same structure as daily

#### Task 7.2.2: Leaderboard Page
**UI Requirements:**
1. **Header:**
   - Back button
   - Title: "Leaderboard"
   - Tabs: "Daily Pot" | "Weekly Pot"

2. **Info Banner:**
   - Trophy icon
   - "Top 100 win a share of the pot!"
   - Hint text

3. **Leaderboard List:**
   - Rank entries:
     - Rank number (gold background for top 3)
     - Avatar with initials
     - Username
     - "You" badge if current user
     - Crown icon for #1
     - Score with flame icon
   - Current user highlighted (yellow tint)

4. **Sticky Footer:**
   - Your Rank display
   - "To Next Rank" points needed
   - "Earn More" button

---

## Phase 8: Referrals

### Duration: Week 9

### 8.1 Domain Layer - Referrals

#### Task 8.1.1: Referral Entity
```dart
@freezed
class Referral with _$Referral {
  const factory Referral({
    required String id,
    required String referrerId,
    String? referredUserId,
    required String referredPhoneNumber,
    required ReferralStatus status, // invited, joined
    required TokenAmount earningsReferrer,
    required TokenAmount earningsReferred,
    required int assistScore,
    required DateTime invitedAt,
    DateTime? joinedAt,
  }) = _Referral;
}
```

### 8.2 Presentation Layer - Referrals

#### Task 8.2.1: My Referrals Page
**UI Requirements:**
1. **Header:**
   - Back button
   - Title: "My Referrals"

2. **Summary Card:**
   - "Invite friends & earn" heading
   - Gift icon
   - Explanation text
   - Stats grid:
     - Total Earned (tokens)
     - Assist Score
   - Invited / Joined counts

3. **How referrals work button:**
   - Opens explainer modal

4. **Referral List:**
   - Contact entries:
     - Avatar with initials
     - Name + phone
     - Status badge (Joined/Invited)
   - Empty state if no referrals

5. **Sticky Footer:**
   - "Invite Friends" button (full-width, pink)

#### Task 8.2.2: Referral Explainer Modal
- Gift icon header
- Numbered steps:
  1. Invite contacts from iMaliChat
  2. Starter bonus on signup
  3. First-touch wins rule
  4. Assist score grows over time
- "Got it" button

---

## Phase 9: Buy Services (Airtime/Electricity)

### Duration: Week 10

### 9.1 Domain Layer - Purchases

#### Task 9.1.1: Purchase Entity
```dart
@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    required String id,
    required String userId,
    required String walletId,
    required PurchaseType type, // airtime, data, electricity
    String? provider,
    String? recipientNumber,
    String? meterNumber,
    required TokenAmount amount,
    required String status,
    String? token, // electricity token
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
  }) = _Purchase;
}

@freezed
class Provider with _$Provider {
  const factory Provider({
    required String id,
    required String name,
    required String logoUrl,
    required List<Product> products,
  }) = _Provider;
}

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required TokenAmount price,
    String? description,
  }) = _Product;
}
```

### 9.2 Presentation Layer - Buy

#### Task 9.2.1: Buy Home Page
**UI Requirements:**
1. **Header:**
   - Title: "Buy Services"
   - Subtitle: "Use your earnings for real-world value"
   - History button (clock icon)

2. **Service Cards:**
   - Airtime & Data card (blue gradient):
     - Phone icon
     - "Instant" badge
     - Title + providers text
     - Arrow button

   - Electricity card (yellow gradient):
     - Lightning icon
     - "Prepaid" badge
     - Title + "Buy tokens for any meter"
     - Arrow button

#### Task 9.2.2: Airtime Purchase Flow
1. **Wallet Selection:**
   - Select wallet to pay from

2. **Provider Selection:**
   - Provider grid (Vodacom, MTN, Cell C, Telkom)

3. **Product Selection:**
   - Bundle/amount options
   - Recipient number input

4. **Confirmation:**
   - Summary + Confirm button

5. **Success:**
   - Checkmark animation
   - "Airtime Sent!" message
   - Details

#### Task 9.2.3: Electricity Purchase Flow
1. **Wallet Selection**
2. **Meter Number Entry:**
   - Meter number input
   - "Verify Meter" button
3. **Amount Selection:**
   - Preset amounts or custom
4. **Confirmation**
5. **Success:**
   - Token number display (copyable)
   - Unit details

---

## Phase 10: Profile & Settings

### Duration: Week 11

### 10.1 Profile Page
**UI Requirements:**
1. **Profile Header Card:**
   - Gradient background
   - Large avatar (initials or photo)
   - Full name
   - @username
   - Phone number (muted)
   - "Edit Profile" button

2. **Stats Card:**
   - Wallet icon + balance
   - Streak count with trophy icon

3. **Menu Items:**
   - My Referrals (users icon, blue)
   - Settings (gear icon)
   - Help & Support (question mark icon)
   - Legal & Privacy (shield icon)
   - Log Out (red, logout icon)

### 10.2 Edit Profile Page
- Photo upload
- First name input
- Surname input
- Username input (with @ prefix)
- Location dropdown
- Date of birth selectors
- Gender selector
- "Save Changes" button

### 10.3 Settings Page
- Notification toggles
- App version display

---

## Phase 11: Firebase Cloud Functions

### Duration: Week 12

### 11.1 Function Categories

#### Authentication Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `onUserCreate` | Firestore onCreate (users) | Initialize wallet, score, set pot eligibility |

#### Engagement Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `startEngagement` | HTTPS Callable | Create engagement document, check daily cap |
| `processEngagement` | HTTPS Callable | Validate evidence, calculate rewards, update atomically |

#### Wallet Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `requestCashout` | HTTPS Callable | Initiate cashout, apply holds |
| `processCashout` | PubSub scheduled | Process pending cashouts via G-PAY |

#### Chat Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `sendTokens` | HTTPS Callable | P2P transfer with atomic balance updates |
| `createRequest` | HTTPS Callable | Create payment request card |
| `payRequest` | HTTPS Callable | Pay a pending request |
| `declineRequest` | HTTPS Callable | Decline a pending request |

#### Gamification Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `closeDailyPot` | PubSub schedule (18:00 UTC) | Calculate rankings, distribute winnings |
| `closeWeeklyPot` | PubSub schedule (Sun 18:00 UTC) | Calculate rankings, distribute winnings |
| `updateStreak` | Firestore onUpdate | Update streak on daily activity |

#### Referral Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `processStarterBonus` | Firestore onUpdate | Award referral starter bonus |
| `checkMilestones` | Firestore onUpdate | Check and award milestone bonuses |

#### Fraud Functions
| Function | Trigger | Purpose |
|----------|---------|---------|
| `validateSurveyQuality` | Firestore onCreate | Fraud check on survey responses |
| `dailyCollusionScan` | PubSub scheduled | Detect referral fraud patterns |
| `updateUserRiskScore` | Firestore onUpdate | Update risk score based on behavior |

### 11.2 Key Implementation Details

#### Idempotency Pattern
All financial operations use idempotency keys stored in `processedKeys` collection.

#### Atomic Transactions
Use Firestore transactions for all balance updates.

#### Error Codes
Standardized error codes for client handling.

---

## Phase 12: Security & Fraud Prevention

### Duration: Week 13

### 12.1 Device Integrity
- Integrate Play Integrity API
- Verify device/app integrity on sensitive operations

### 12.2 Behavioral Analysis
- Survey timing analysis
- Attention check questions
- Risk scoring system (0-100)

### 12.3 Referral Fraud Detection
- Same device detection
- IP clustering
- Circular referral detection

### 12.4 CAPTCHA Integration
- reCAPTCHA v3 for risk-based challenges
- Trigger on suspicious behavior

---

## Phase 13: Testing Strategy

### Duration: Week 14

### 13.1 Test Pyramid

| Level | Target | Coverage | Tools |
|-------|--------|----------|-------|
| Unit | Domain layer, utils | 90%+ | flutter_test, mocktail |
| Integration | Repository implementations | 80%+ | Firebase Emulator Suite |
| Widget | UI components | 70%+ | flutter_test, golden_toolkit |
| E2E | Critical user flows | Key paths | integration_test |

### 13.2 Critical Test Scenarios

**Earn Flow:**
- Video completion tracking
- Survey submission
- Daily cap enforcement
- Streak calculation
- Pot contribution

**Wallet:**
- Balance atomicity
- Transaction immutability
- Cashout eligibility

**Chat:**
- Send with sufficient/insufficient balance
- Request creation/expiry
- Daily send cap

**Pots:**
- Ranking calculation
- Tiebreaker logic
- Distribution accuracy

---

## Phase 14: Polish & Launch Preparation

### Duration: Week 15-16

### 14.1 Performance Optimization
- Image caching
- List virtualization
- Lazy loading

### 14.2 Error Handling
- Offline support
- Retry mechanisms
- User-friendly error messages

### 14.3 Analytics Integration
- Firebase Analytics events
- Crash reporting (Crashlytics)

### 14.4 App Store Preparation
- App icons
- Screenshots
- Store descriptions
- Privacy policy
- Terms of service

---

## Summary: Implementation Timeline

| Phase | Duration | Key Deliverables |
|-------|----------|------------------|
| 1 | Week 1 | Project setup, core infrastructure, theme |
| 2 | Week 2 | Authentication, onboarding flows |
| 3 | Week 3 | Navigation shell, home screen |
| 4 | Week 4-5 | Complete earn system |
| 5 | Week 6 | Wallet & transactions |
| 6 | Week 7 | Money Chat P2P |
| 7 | Week 8 | Pots & leaderboards |
| 8 | Week 9 | Referral system |
| 9 | Week 10 | Buy services |
| 10 | Week 11 | Profile & settings |
| 11 | Week 12 | Cloud Functions |
| 12 | Week 13 | Security & fraud |
| 13 | Week 14 | Testing |
| 14 | Week 15-16 | Polish & launch |

**Total Estimated Duration: 16 weeks**

---

## Appendix A: File Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Entities | `snake_case.dart` | `user.dart`, `wallet.dart` |
| BLoCs | `*_bloc.dart` | `auth_bloc.dart`, `home_bloc.dart` |
| Pages | `*_page.dart` | `home_page.dart`, `login_page.dart` |
| Widgets | `*_widget.dart` or descriptive | `balance_card.dart`, `pot_card.dart` |
| Repositories | `*_repository.dart` (interface), `*_repository_impl.dart` | `auth_repository.dart` |
| Models | `*_model.dart` | `user_model.dart` |
| Use Cases | Descriptive | `request_otp.dart`, `submit_survey.dart` |

## Appendix B: State Management Conventions

1. **One BLoC per feature/page** (not per widget)
2. **Events are imperative** (`AuthOtpRequested`, not `RequestOtp`)
3. **States are declarative** (`AuthState.loading()`, `AuthState.authenticated()`)
4. **Use freezed for all events and states**
5. **Emit loading state before async operations**
6. **Handle errors explicitly in states**

## Appendix C: Critical UI Constants

```dart
// Spacing
const double spacingXs = 4;
const double spacingSm = 8;
const double spacingMd = 16;
const double spacingLg = 24;
const double spacingXl = 32;

// Radius
const double radiusSm = 8;
const double radiusMd = 12;
const double radiusLg = 16;
const double radiusXl = 24;
const double radiusFull = 9999;

// Sizes
const double bottomNavHeight = 80;
const double buttonHeight = 48;
const double buttonHeightLg = 56;
const double avatarSm = 40;
const double avatarMd = 48;
const double avatarLg = 64;
const double avatarXl = 96;

// Animation Durations
const Duration animFast = Duration(milliseconds: 150);
const Duration animNormal = Duration(milliseconds: 300);
const Duration animSlow = Duration(milliseconds: 500);
```

---

**Document End**

*This implementation plan should be followed sequentially. Each phase builds upon the previous one. Ensure all Clean Architecture principles are maintained throughout development.*
