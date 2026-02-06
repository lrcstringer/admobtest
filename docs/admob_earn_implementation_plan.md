# AdMob Rewarded Video Earn Opportunity - Complete Implementation Plan

## Executive Summary

This document details the complete implementation of a Google AdMob rewarded video earn opportunity within the iMaliChat app. Users will watch a Google AdMob rewarded video advertisement, then answer a single question to earn 5 tokens.

### Key Details

| Configuration | Value |
|---------------|-------|
| App Name | iMaliChat |
| AdMob App ID | `ca-app-pub-9331591670168644~8585460504` |
| Publisher ID | `pub-9331591670168644` |
| Rewarded Ad Unit ID | `ca-app-pub-9331591670168644/1108724925` |
| Token Reward | 5 tokens (= R0.05) |
| Test Ad Unit (Android) | `ca-app-pub-3940256099942544/5224354917` |
| Test Ad Unit (iOS) | `ca-app-pub-3940256099942544/1712485313` |

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Phase 1: Flutter SDK Setup](#phase-1-flutter-sdk-setup)
3. [Phase 2: Domain Layer Extensions](#phase-2-domain-layer-extensions)
4. [Phase 3: Data Layer Updates](#phase-3-data-layer-updates)
5. [Phase 4: AdMob Service Implementation](#phase-4-admob-service-implementation)
6. [Phase 5: Presentation Layer Updates](#phase-5-presentation-layer-updates)
7. [Phase 6: Backend (Cloud Functions) Updates](#phase-6-backend-cloud-functions-updates)
8. [Phase 7: Firestore Data & Security](#phase-7-firestore-data--security)
9. [Phase 8: Testing](#phase-8-testing)
10. [Phase 9: Deployment & Go-Live](#phase-9-deployment--go-live)
11. [Appendix: Complete Code Listings](#appendix-complete-code-listings)

---

## 1. Architecture Overview

### 1.1 User Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           USER JOURNEY                                       │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Earn Screen │───▶│ Thread List  │───▶│  Tap Pinned  │───▶│ Opportunity  │
│   (Home)     │    │ (Daily W&E   │    │   Thread     │    │   Detail     │
│              │    │  at top)     │    │              │    │              │
└──────────────┘    └──────────────┘    └──────────────┘    └──────┬───────┘
                                                                    │
                    ┌───────────────────────────────────────────────┘
                    ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│    Start     │───▶│  Load AdMob  │───▶│  Show Video  │───▶│   Ad Watch   │
│  Engagement  │    │  Rewarded Ad │    │     Ad       │    │  Completed   │
│  (Backend)   │    │              │    │              │    │  (Callback)  │
└──────────────┘    └──────────────┘    └──────────────┘    └──────┬───────┘
                                                                    │
                    ┌───────────────────────────────────────────────┘
                    ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   Question   │───▶│    Submit    │───▶│   Process    │───▶│   Success!   │
│   Unlocked   │    │    Answer    │    │  Engagement  │    │  +5 Tokens   │
│              │    │              │    │  (Backend)   │    │              │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
```

### 1.2 System Components

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              FLUTTER APP                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│  Presentation Layer                                                          │
│  ├── EarnBloc (extended with ad events)                                     │
│  ├── AdMobService (new)                                                     │
│  ├── EarnInteractionScreen (modified)                                       │
│  └── AdMobVideoWidget (new)                                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│  Domain Layer                                                                │
│  ├── EarnOpportunity (extended: adUnitId, earningType.adVideo)             │
│  ├── Engagement (extended: adWatched, adTransactionId)                      │
│  └── EngagementEvidence (extended: adTransactionId)                         │
├─────────────────────────────────────────────────────────────────────────────┤
│  Data Layer                                                                  │
│  ├── EarnOpportunityModel (extended)                                        │
│  ├── EngagementModel (extended)                                             │
│  └── EarnRemoteDatasource (no changes needed)                               │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           FIREBASE BACKEND                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│  Cloud Functions                                                             │
│  ├── startEngagement (no changes)                                           │
│  ├── processEngagement (add adVideo validation)                             │
│  └── admobSSVCallback (new, optional)                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│  Firestore Collections                                                       │
│  ├── earnThreads/system_admob_daily (new document)                          │
│  └── earnOpportunities/system_admob_daily_opp (new document)                │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           GOOGLE ADMOB                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│  ├── App ID: ca-app-pub-9331591670168644~8585460504                         │
│  ├── Rewarded Ad Unit: ca-app-pub-9331591670168644/1108724925               │
│  └── SSV Callback URL (optional): https://[project].cloudfunctions.net/... │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.3 State Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         ENGAGEMENT STATE MACHINE                             │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌─────────┐
                              │  IDLE   │
                              └────┬────┘
                                   │ startEngagement()
                                   ▼
                              ┌─────────┐
                              │STARTING │
                              └────┬────┘
                                   │ engagement created
                                   ▼
                    ┌──────────────────────────────┐
                    │       AD_LOADING             │  ◄── NEW STATE
                    │  (Loading AdMob rewarded ad) │
                    └──────────────┬───────────────┘
                                   │ ad loaded
                                   ▼
                    ┌──────────────────────────────┐
                    │       AD_READY               │  ◄── NEW STATE
                    │  (Ready to show ad)          │
                    └──────────────┬───────────────┘
                                   │ user taps "Watch Video"
                                   ▼
                    ┌──────────────────────────────┐
                    │       WATCHING               │
                    │  (AdMob fullscreen showing)  │
                    └──────────────┬───────────────┘
                                   │
                    ┌──────────────┴───────────────┐
                    │                              │
           ad dismissed early              onUserEarnedReward
                    │                              │
                    ▼                              ▼
              ┌──────────┐              ┌──────────────────┐
              │ ABANDONED│              │    SURVEYING     │  ◄── Question unlocked
              └──────────┘              │  (Show question) │
                                        └────────┬─────────┘
                                                 │ submit answer
                                                 ▼
                                        ┌──────────────────┐
                                        │   SUBMITTING     │
                                        └────────┬─────────┘
                                                 │
                                   ┌─────────────┴─────────────┐
                                   │                           │
                              success                     failure
                                   │                           │
                                   ▼                           ▼
                            ┌───────────┐               ┌──────────┐
                            │ COMPLETED │               │  FAILED  │
                            │ +5 tokens │               └──────────┘
                            └───────────┘
```

---

## Phase 1: Flutter SDK Setup

### 1.1 Add Dependency

**File:** `pubspec.yaml`

**Location:** Root of project

**Change:** Add google_mobile_ads to dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  # ... existing dependencies ...

  # AdMob SDK for rewarded video ads
  google_mobile_ads: ^7.0.0
```

**Action:** Run `flutter pub get` after adding

---

### 1.2 Android Configuration

#### 1.2.1 AndroidManifest.xml

**File:** `android/app/src/main/AndroidManifest.xml`

**Change:** Add AdMob App ID metadata inside `<application>` tag

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="iMaliChat"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <!-- EXISTING CONTENT -->

        <!-- ADD THIS: Google AdMob App ID -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-9331591670168644~8585460504"/>

        <!-- EXISTING CONTENT CONTINUES -->

    </application>
</manifest>
```

#### 1.2.2 build.gradle (App Level)

**File:** `android/app/build.gradle`

**Change:** Verify minSdkVersion is 21+ (should already be set)

```gradle
android {
    defaultConfig {
        minSdkVersion 21  // Must be 21 or higher for AdMob
        // ... rest of config
    }
}
```

#### 1.2.3 build.gradle (Project Level)

**File:** `android/build.gradle`

**Change:** Ensure Google repository is included (usually already present)

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

---

### 1.3 iOS Configuration

#### 1.3.1 Info.plist

**File:** `ios/Runner/Info.plist`

**Change:** Add AdMob App ID and SKAdNetwork identifiers

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- EXISTING CONTENT -->

    <!-- ADD THIS: Google AdMob App ID -->
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-9331591670168644~8585460504</string>

    <!-- ADD THIS: SKAdNetwork identifiers for ad attribution -->
    <key>SKAdNetworkItems</key>
    <array>
        <!-- Google's SKAdNetwork identifier -->
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>cstr6suwn9.skadnetwork</string>
        </dict>
        <!-- Additional networks - add more as needed -->
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4fzdc2evr5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4pfyvq9l8r.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>2fnua5tdw4.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ydx93a7ass.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>5a6flpkh64.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>p78axxw29g.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>v72qych5uu.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ludvb6z3bs.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>cp8zw746q7.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3sh42y64q3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>c6k4g5qg8m.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>s39g8k73mm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3qy4746246.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>f38h382jlk.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>hs6bdukanm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>v4nxqhlyqp.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>wzmmz9fp6w.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>yclnxrl5pm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>t38b2kh725.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>7ug5zh24hu.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>gta9lk7p23.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>vutu7akeur.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>y5ghdn5j9k.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>n6fk4nfna4.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>v9wttpbfk9.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>n38lu8286q.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>47vhws6wlr.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>kbd757ywx3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>9t245vhmpl.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>eh6m2bh4zr.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>a2p9lx4jpn.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>22mmun2rn5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4468km3ulz.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>2u9pt9hc89.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>8s468mfl3y.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>klf5c3l5u5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ppxm28t8ap.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ecpz2srf59.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>uw77j35x4d.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>pwa73g5rt2.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>mlmmfzh3r3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>578prtvx9j.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4dzt52r2t5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>e5fvkxwrpn.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>8c4e2ghe7u.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>zq492l623r.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3rd42ekr43.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3qcr597p9d.skadnetwork</string>
        </dict>
    </array>

    <!-- EXISTING CONTENT CONTINUES -->
</dict>
</plist>
```

#### 1.3.2 Podfile

**File:** `ios/Podfile`

**Change:** Ensure iOS deployment target is 13.0+

```ruby
platform :ios, '13.0'

# ... rest of Podfile
```

**Action:** Run `cd ios && pod install` after changes

---

### 1.4 Initialize SDK in main.dart

**File:** `lib/main.dart`

**Change:** Add MobileAds initialization before runApp

```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (existing)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ADD THIS: Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  // ... rest of initialization
  runApp(const MyApp());
}
```

---

## Phase 2: Domain Layer Extensions

### 2.1 Update EarningType Enum

**File:** `lib/domain/entities/earn_opportunity.dart`

**Change:** Add `adVideo` to EarningType enum

```dart
/// Earning type for opportunity classification
enum EarningType {
  survey,
  video,
  trivia,
  rating,
  poll,
  adVideo,  // NEW: Google AdMob rewarded video
}
```

### 2.2 Update MediaType Enum

**File:** `lib/domain/entities/earn_opportunity.dart`

**Change:** Add `adMob` to MediaType enum

```dart
/// Media type for earn opportunity
enum MediaType {
  video,
  image,
  text,
  adMob,  // NEW: Google AdMob media
}
```

### 2.3 Extend EarnOpportunity Entity

**File:** `lib/domain/entities/earn_opportunity.dart`

**Change:** Add adUnitId field and helper getter

```dart
@freezed
class EarnOpportunity with _$EarnOpportunity {
  const factory EarnOpportunity({
    required String id,
    required String threadId,
    required String title,
    String? description,
    // Earning configuration
    required EarningType earningType,
    required int tokenReward,
    @Default(1) int streakPoints,
    required MediaType mediaType,
    String? mediaUrl,
    required List<SurveyQuestion> questions,
    required int durationSeconds,
    DateTime? expiresAt,
    required bool isActive,
    // Denormalized client info
    String? clientId,
    String? clientName,
    String? clientAvatarColor,
    // Legacy campaign reference
    String? campaignId,
    // Targeting
    TargetingCriteria? targeting,
    // Bonus reward configuration
    @Default(false) bool bonusReward,
    @Default(1.0) double bonusRewardMultiplier,
    BonusIntervalType? bonusIntervalType,
    int? bonusIntervalX,
    // User engagement status (populated by getEligibleOpportunities)
    String? userEngagementStatus,
    String? userEngagementId,
    // NEW: AdMob configuration
    String? adUnitId,  // AdMob ad unit ID for adVideo type
    @Default(3) int dailyLimitPerUser,  // Max completions per user per day
  }) = _EarnOpportunity;

  const EarnOpportunity._();

  factory EarnOpportunity.fromJson(Map<String, dynamic> json) =>
      _$EarnOpportunityFromJson(json);

  // ... existing getters ...

  /// NEW: Check if this is an AdMob video opportunity
  bool get isAdMobOpportunity => earningType == EarningType.adVideo;

  /// NEW: Check if ad unit ID is configured
  bool get hasAdUnitId => adUnitId != null && adUnitId!.isNotEmpty;
}
```

### 2.4 Extend Engagement Entity

**File:** `lib/domain/entities/engagement.dart`

**Change:** Add ad tracking fields

```dart
@freezed
class Engagement with _$Engagement {
  const factory Engagement({
    required String id,
    required String oddienceCampaignId,
    required String oddienceCampaignId,  // Legacy typo preserved
    required String userId,
    required String earnOpportunityId,
    required String threadId,
    required String clientId,
    required EngagementStatus status,
    required DateTime? startedAt,
    DateTime? completedAt,
    required int watchDurationSeconds,
    required int requiredDurationSeconds,
    int? tokensEarned,
    required List<EngagementAnswer> answers,
    String? failureReason,
    required int attemptNumber,
    required DateTime createdAt,
    // NEW: AdMob tracking fields
    @Default(false) bool adWatched,  // True when ad was fully watched
    String? adTransactionId,  // AdMob transaction ID for SSV verification
    DateTime? adCompletedAt,  // Timestamp when ad completed
  }) = _Engagement;

  const Engagement._();

  factory Engagement.fromJson(Map<String, dynamic> json) =>
      _$EngagementFromJson(json);

  // ... existing getters ...

  /// NEW: Check if ad was watched (for adVideo type)
  bool get hasWatchedAd => adWatched == true;
}
```

### 2.5 Extend EngagementEvidence Value Object

**File:** `lib/domain/value_objects/engagement_evidence.dart`

**Change:** Add adTransactionId field

```dart
@freezed
class EngagementEvidence with _$EngagementEvidence {
  const factory EngagementEvidence({
    required String deviceFingerprint,
    required int watchDurationMs,
    required bool videoSeeked,
    required bool screenVisible,
    required bool appInForeground,
    required List<int> surveyResponseTimesMs,
    DateTime? videoStartedAt,
    DateTime? surveySubmittedAt,
    // NEW: AdMob verification
    String? adTransactionId,  // For server-side verification
    bool? adFullyWatched,  // Client-side flag
  }) = _EngagementEvidence;

  factory EngagementEvidence.fromJson(Map<String, dynamic> json) =>
      _$EngagementEvidenceFromJson(json);
}
```

### 2.6 Extend EarnThread Entity (Optional)

**File:** `lib/domain/entities/earn_thread.dart`

**Change:** Add isSystemThread flag

```dart
@freezed
class EarnThread with _$EarnThread {
  const factory EarnThread({
    required String id,
    required String clientId,
    required String clientName,
    required String title,
    String? description,
    required bool isActive,
    required bool isPinned,
    required bool isFeatured,
    required int availableOpportunities,
    required int completedOpportunities,
    @Default(0) int completedUniqueUsers,
    required DateTime createdAt,
    // Scheduling
    DateTime? activeFrom,
    DateTime? activeTo,
    // Targeting
    TargetingCriteria? targeting,
    // UI customization
    String? avatarColor,
    String? iconUrl,
    // NEW: System thread flag
    @Default(false) bool isSystemThread,  // True for iMaliChat-owned threads
  }) = _EarnThread;

  // ... rest of class
}
```

### 2.7 Run Code Generation

**Action:** After all entity changes, regenerate Freezed files

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Phase 3: Data Layer Updates

### 3.1 Update EarnOpportunityModel

**File:** `lib/data/models/earn_opportunity_model.dart`

**Change:** Add adUnitId and dailyLimitPerUser parsing

```dart
@freezed
class EarnOpportunityModel with _$EarnOpportunityModel {
  const factory EarnOpportunityModel({
    required String id,
    required String threadId,
    required String title,
    String? description,
    required String earningType,
    required int tokenReward,
    @Default(1) int streakPoints,
    required String mediaType,
    String? mediaUrl,
    required List<SurveyQuestionModel> questions,
    required int durationSeconds,
    DateTime? expiresAt,
    required bool isActive,
    String? clientId,
    String? clientName,
    String? clientAvatarColor,
    String? campaignId,
    Map<String, dynamic>? targeting,
    @Default(false) bool bonusReward,
    @Default(1.0) double bonusRewardMultiplier,
    String? bonusIntervalType,
    int? bonusIntervalX,
    String? userEngagementStatus,
    String? userEngagementId,
    // NEW
    String? adUnitId,
    @Default(3) int dailyLimitPerUser,
  }) = _EarnOpportunityModel;

  factory EarnOpportunityModel.fromJson(Map<String, dynamic> json) =>
      _$EarnOpportunityModelFromJson(json);

  const EarnOpportunityModel._();

  /// Convert to domain entity
  EarnOpportunity toEntity() => EarnOpportunity(
        id: id,
        threadId: threadId,
        title: title,
        description: description,
        earningType: _parseEarningType(earningType),
        tokenReward: tokenReward,
        streakPoints: streakPoints,
        mediaType: _parseMediaType(mediaType),
        mediaUrl: mediaUrl,
        questions: questions.map((q) => q.toEntity()).toList(),
        durationSeconds: durationSeconds,
        expiresAt: expiresAt,
        isActive: isActive,
        clientId: clientId,
        clientName: clientName,
        clientAvatarColor: clientAvatarColor,
        campaignId: campaignId,
        targeting: targeting != null
            ? TargetingCriteria.fromJson(targeting!)
            : null,
        bonusReward: bonusReward,
        bonusRewardMultiplier: bonusRewardMultiplier,
        bonusIntervalType: _parseBonusIntervalType(bonusIntervalType),
        bonusIntervalX: bonusIntervalX,
        userEngagementStatus: userEngagementStatus,
        userEngagementId: userEngagementId,
        // NEW
        adUnitId: adUnitId,
        dailyLimitPerUser: dailyLimitPerUser,
      );

  static EarningType _parseEarningType(String type) {
    switch (type) {
      case 'survey':
        return EarningType.survey;
      case 'video':
        return EarningType.video;
      case 'trivia':
        return EarningType.trivia;
      case 'rating':
        return EarningType.rating;
      case 'poll':
        return EarningType.poll;
      case 'adVideo':  // NEW
        return EarningType.adVideo;
      default:
        return EarningType.video;
    }
  }

  static MediaType _parseMediaType(String type) {
    switch (type) {
      case 'video':
        return MediaType.video;
      case 'image':
        return MediaType.image;
      case 'text':
        return MediaType.text;
      case 'adMob':  // NEW
        return MediaType.adMob;
      default:
        return MediaType.video;
    }
  }

  // ... rest of parsing methods
}
```

### 3.2 Update EngagementModel

**File:** `lib/data/models/engagement_model.dart`

**Change:** Add ad tracking fields

```dart
@freezed
class EngagementModel with _$EngagementModel {
  const factory EngagementModel({
    required String id,
    required String oddienceCampaignId,
    required String userId,
    required String earnOpportunityId,
    required String threadId,
    required String clientId,
    required String status,
    DateTime? startedAt,
    DateTime? completedAt,
    required int watchDurationSeconds,
    required int requiredDurationSeconds,
    int? tokensEarned,
    required List<EngagementAnswerModel> answers,
    String? failureReason,
    required int attemptNumber,
    required DateTime createdAt,
    // NEW
    @Default(false) bool adWatched,
    String? adTransactionId,
    DateTime? adCompletedAt,
  }) = _EngagementModel;

  factory EngagementModel.fromJson(Map<String, dynamic> json) =>
      _$EngagementModelFromJson(json);

  const EngagementModel._();

  Engagement toEntity() => Engagement(
        id: id,
        oddienceCampaignId: oddienceCampaignId,
        userId: userId,
        earnOpportunityId: earnOpportunityId,
        threadId: threadId,
        clientId: clientId,
        status: _parseStatus(status),
        startedAt: startedAt,
        completedAt: completedAt,
        watchDurationSeconds: watchDurationSeconds,
        requiredDurationSeconds: requiredDurationSeconds,
        tokensEarned: tokensEarned,
        answers: answers.map((a) => a.toEntity()).toList(),
        failureReason: failureReason,
        attemptNumber: attemptNumber,
        createdAt: createdAt,
        // NEW
        adWatched: adWatched,
        adTransactionId: adTransactionId,
        adCompletedAt: adCompletedAt,
      );

  // ... rest of class
}
```

### 3.3 Run Code Generation

**Action:** Regenerate model files

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Phase 4: AdMob Service Implementation

### 4.1 Create AdMob Constants

**File:** `lib/core/constants/admob_constants.dart` (NEW)

```dart
import 'dart:io';

/// AdMob configuration constants
class AdMobConstants {
  AdMobConstants._();

  /// Production Ad Unit IDs
  static const String _prodRewardedAdUnitAndroid =
      'ca-app-pub-9331591670168644/1108724925';
  static const String _prodRewardedAdUnitIos =
      'ca-app-pub-9331591670168644/1108724925';

  /// Test Ad Unit IDs (use during development)
  static const String _testRewardedAdUnitAndroid =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _testRewardedAdUnitIos =
      'ca-app-pub-3940256099942544/1712485313';

  /// Whether to use test ads (set to false for production)
  static const bool useTestAds = true; // TODO: Set to false before release

  /// Get the appropriate rewarded ad unit ID for the current platform
  static String get rewardedAdUnitId {
    if (useTestAds) {
      return Platform.isAndroid
          ? _testRewardedAdUnitAndroid
          : _testRewardedAdUnitIos;
    }
    return Platform.isAndroid
        ? _prodRewardedAdUnitAndroid
        : _prodRewardedAdUnitIos;
  }

  /// Default rewarded ad unit (can be overridden per opportunity)
  static String getAdUnitId(String? opportunityAdUnitId) {
    if (opportunityAdUnitId != null && opportunityAdUnitId.isNotEmpty) {
      // Use opportunity-specific ad unit if provided
      return useTestAds ? rewardedAdUnitId : opportunityAdUnitId;
    }
    return rewardedAdUnitId;
  }
}
```

### 4.2 Create AdMob Service

**File:** `lib/data/services/admob_service.dart` (NEW)

```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/admob_constants.dart';

/// Result of attempting to watch an ad
enum AdWatchResult {
  /// User watched the full ad and earned reward
  rewarded,
  /// User dismissed the ad early without earning reward
  dismissed,
  /// Ad failed to show due to error
  failed,
  /// No ad was loaded to show
  notLoaded,
  /// Ad is still loading
  loading,
}

/// Service for managing Google AdMob rewarded video ads
@lazySingleton
class AdMobService {
  RewardedAd? _rewardedAd;
  bool _isLoading = false;
  String? _currentAdUnitId;
  String? _customData;

  /// Whether an ad is currently loaded and ready to show
  bool get isAdLoaded => _rewardedAd != null;

  /// Whether an ad is currently loading
  bool get isLoading => _isLoading;

  /// Load a rewarded ad
  ///
  /// [adUnitId] - Optional specific ad unit ID (defaults to configured unit)
  /// [customData] - Custom data for server-side verification (e.g., engagementId)
  ///
  /// Returns true if ad loaded successfully, false otherwise
  Future<bool> loadRewardedAd({
    String? adUnitId,
    String? customData,
  }) async {
    // Don't load if already loading
    if (_isLoading) {
      debugPrint('AdMobService: Ad is already loading');
      return false;
    }

    // Dispose any existing ad
    _rewardedAd?.dispose();
    _rewardedAd = null;

    _isLoading = true;
    _currentAdUnitId = AdMobConstants.getAdUnitId(adUnitId);
    _customData = customData;

    final completer = Completer<bool>();

    debugPrint('AdMobService: Loading rewarded ad from $_currentAdUnitId');

    await RewardedAd.load(
      adUnitId: _currentAdUnitId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('AdMobService: Rewarded ad loaded successfully');
          _rewardedAd = ad;
          _isLoading = false;

          // Set server-side verification options if custom data provided
          if (_customData != null && _customData!.isNotEmpty) {
            ad.setServerSideOptions(
              ServerSideVerificationOptions(
                customData: _customData,
              ),
            );
            debugPrint('AdMobService: SSV custom data set: $_customData');
          }

          completer.complete(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('AdMobService: Rewarded ad failed to load: $error');
          _rewardedAd = null;
          _isLoading = false;
          completer.complete(false);
        },
      ),
    );

    return completer.future;
  }

  /// Show the loaded rewarded ad
  ///
  /// Returns [AdWatchResult] indicating the outcome:
  /// - [AdWatchResult.rewarded] - User watched full ad
  /// - [AdWatchResult.dismissed] - User closed ad early
  /// - [AdWatchResult.failed] - Ad failed to show
  /// - [AdWatchResult.notLoaded] - No ad was loaded
  /// - [AdWatchResult.loading] - Ad is still loading
  Future<AdWatchResult> showRewardedAd() async {
    if (_isLoading) {
      debugPrint('AdMobService: Cannot show ad - still loading');
      return AdWatchResult.loading;
    }

    if (_rewardedAd == null) {
      debugPrint('AdMobService: Cannot show ad - no ad loaded');
      return AdWatchResult.notLoaded;
    }

    final completer = Completer<AdWatchResult>();
    bool userEarnedReward = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        debugPrint('AdMobService: Ad showed fullscreen content');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('AdMobService: Ad dismissed by user');
        ad.dispose();
        _rewardedAd = null;

        // Complete with appropriate result
        if (!completer.isCompleted) {
          completer.complete(
            userEarnedReward ? AdWatchResult.rewarded : AdWatchResult.dismissed,
          );
        }
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('AdMobService: Ad failed to show: $error');
        ad.dispose();
        _rewardedAd = null;

        if (!completer.isCompleted) {
          completer.complete(AdWatchResult.failed);
        }
      },
      onAdClicked: (RewardedAd ad) {
        debugPrint('AdMobService: Ad clicked');
      },
      onAdImpression: (RewardedAd ad) {
        debugPrint('AdMobService: Ad impression recorded');
      },
    );

    // Show the ad and listen for reward
    await _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint(
          'AdMobService: User earned reward: ${reward.amount} ${reward.type}',
        );
        userEarnedReward = true;
      },
    );

    return completer.future;
  }

  /// Preload an ad for later use
  ///
  /// Call this proactively to have an ad ready when user navigates to
  /// an AdMob opportunity. Use [customData] to set the engagement ID
  /// after the engagement is created.
  Future<void> preloadAd({String? adUnitId}) async {
    if (!isAdLoaded && !_isLoading) {
      await loadRewardedAd(adUnitId: adUnitId);
    }
  }

  /// Update the custom data (SSV) for the currently loaded ad
  ///
  /// Call this after creating an engagement to set the engagement ID
  /// for server-side verification.
  void updateCustomData(String customData) {
    if (_rewardedAd != null) {
      _rewardedAd!.setServerSideOptions(
        ServerSideVerificationOptions(customData: customData),
      );
      _customData = customData;
      debugPrint('AdMobService: Updated SSV custom data: $customData');
    }
  }

  /// Dispose the current ad and clean up resources
  void disposeAd() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isLoading = false;
    _currentAdUnitId = null;
    _customData = null;
  }

  /// Dispose the service (call on app shutdown)
  void dispose() {
    disposeAd();
  }
}
```

### 4.3 Register AdMobService with Injectable

**File:** `lib/core/di/injection.dart`

**Change:** Ensure AdMobService is registered (Injectable should auto-register with @lazySingleton)

If using manual registration, add:

```dart
// In configureInjection or similar
getIt.registerLazySingleton<AdMobService>(() => AdMobService());
```

### 4.4 Run Code Generation for DI

**Action:** Regenerate injectable files

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Phase 5: Presentation Layer Updates

### 5.1 Extend EarnEvent

**File:** `lib/presentation/blocs/earn/earn_event.dart`

**Change:** Add ad-related events

```dart
part of 'earn_bloc.dart';

@freezed
class EarnEvent with _$EarnEvent {
  // ... existing events ...

  // NEW: AdMob events

  /// Load an AdMob rewarded ad for the selected opportunity
  const factory EarnEvent.loadAd({
    required String adUnitId,
    String? engagementId,  // For SSV custom data
  }) = _LoadAd;

  /// Show the loaded AdMob rewarded ad
  const factory EarnEvent.watchAd() = _WatchAd;

  /// Ad was successfully watched and reward earned
  const factory EarnEvent.adCompleted({
    String? transactionId,
  }) = _AdCompleted;

  /// Ad was dismissed early without earning reward
  const factory EarnEvent.adDismissed() = _AdDismissed;

  /// Ad failed to load or show
  const factory EarnEvent.adFailed({
    required String reason,
  }) = _AdFailed;
}
```

### 5.2 Extend EarnState

**File:** `lib/presentation/blocs/earn/earn_state.dart`

**Change:** Add ad-related state fields

```dart
part of 'earn_bloc.dart';

enum EarnStatus {
  initial,
  loading,
  loaded,
  error,
}

enum EngagementPhase {
  idle,
  starting,
  adLoading,   // NEW: Loading AdMob ad
  adReady,     // NEW: Ad loaded, ready to show
  watching,
  surveying,
  submitting,
  completed,
  failed,
  abandoned,
}

@freezed
class EarnState with _$EarnState {
  const factory EarnState({
    @Default(EarnStatus.initial) EarnStatus status,
    @Default([]) List<EarnThread> threads,
    EarnThread? selectedThread,
    @Default(EarnStatus.initial) EarnStatus opportunitiesStatus,
    @Default([]) List<EarnOpportunity> opportunities,
    EarnOpportunity? selectedOpportunity,
    Engagement? currentEngagement,
    @Default(EngagementPhase.idle) EngagementPhase engagementPhase,
    @Default([]) List<Engagement> history,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool hasMoreHistory,
    DateTime? lastHistoryTimestamp,
    String? errorMessage,
    @Default(0) int totalAvailableOpportunities,
    // Daily completion limit
    @Default(0) int dailyCompletions,
    @Default(30) int dailyEarnCap,
    @Default(false) bool dailyLimitReached,
    // NEW: AdMob state
    @Default(false) bool isAdLoaded,
    @Default(false) bool isAdLoading,
    String? adTransactionId,  // Transaction ID from watched ad
    String? adError,  // Ad-specific error message
  }) = _EarnState;

  const EarnState._();

  /// Check if currently in an active engagement
  bool get hasActiveEngagement =>
      currentEngagement != null &&
      (engagementPhase == EngagementPhase.watching ||
          engagementPhase == EngagementPhase.surveying ||
          engagementPhase == EngagementPhase.adLoading ||
          engagementPhase == EngagementPhase.adReady);

  /// NEW: Check if ready to show ad
  bool get canShowAd => isAdLoaded && !isAdLoading;

  /// NEW: Check if this is an AdMob opportunity
  bool get isAdMobOpportunity =>
      selectedOpportunity?.isAdMobOpportunity ?? false;

  // ... existing computed properties ...
}
```

### 5.3 Update EarnBloc

**File:** `lib/presentation/blocs/earn/earn_bloc.dart`

**Change:** Add handlers for ad events and inject AdMobService

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/services/admob_service.dart';
import '../../../domain/entities/earn_opportunity.dart';
import '../../../domain/entities/earn_thread.dart';
import '../../../domain/entities/engagement.dart';
import '../../../domain/enums/engagement_status.dart';
import '../../../domain/repositories/earn_repository.dart';
import '../../../domain/value_objects/engagement_evidence.dart';

part 'earn_bloc.freezed.dart';
part 'earn_event.dart';
part 'earn_state.dart';

@injectable
class EarnBloc extends Bloc<EarnEvent, EarnState> {
  final EarnRepository _earnRepository;
  final AdMobService _adMobService;  // NEW

  EarnBloc(
    this._earnRepository,
    this._adMobService,  // NEW: Inject AdMobService
  ) : super(const EarnState()) {
    // ... existing event handlers ...

    // NEW: AdMob event handlers
    on<_LoadAd>(_onLoadAd);
    on<_WatchAd>(_onWatchAd);
    on<_AdCompleted>(_onAdCompleted);
    on<_AdDismissed>(_onAdDismissed);
    on<_AdFailed>(_onAdFailed);
  }

  // ... existing handlers ...

  /// Modified: Handle start engagement for AdMob opportunities
  Future<void> _onStartEngagement(
    _StartEngagement event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(
      engagementPhase: EngagementPhase.starting,
      errorMessage: null,
      adError: null,
    ));

    final result = await _earnRepository.startEngagement(
      opportunityId: event.opportunityId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        engagementPhase: EngagementPhase.failed,
        errorMessage: failure.message,
      )),
      (engagement) {
        // Check if this is an AdMob opportunity
        final opportunity = state.selectedOpportunity;
        if (opportunity?.isAdMobOpportunity == true) {
          // Start loading ad instead of going to watching phase
          emit(state.copyWith(
            currentEngagement: engagement,
            engagementPhase: EngagementPhase.adLoading,
            isAdLoading: true,
          ));

          // Trigger ad load with engagement ID for SSV
          add(EarnEvent.loadAd(
            adUnitId: opportunity!.adUnitId ?? '',
            engagementId: engagement.id,
          ));
        } else {
          // Normal flow - go to watching phase
          emit(state.copyWith(
            currentEngagement: engagement,
            engagementPhase: EngagementPhase.watching,
          ));
        }
      },
    );
  }

  /// NEW: Handle load ad event
  Future<void> _onLoadAd(
    _LoadAd event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(
      isAdLoading: true,
      adError: null,
    ));

    final success = await _adMobService.loadRewardedAd(
      adUnitId: event.adUnitId.isNotEmpty ? event.adUnitId : null,
      customData: event.engagementId,
    );

    if (success) {
      emit(state.copyWith(
        isAdLoaded: true,
        isAdLoading: false,
        engagementPhase: EngagementPhase.adReady,
      ));
    } else {
      emit(state.copyWith(
        isAdLoaded: false,
        isAdLoading: false,
        engagementPhase: EngagementPhase.failed,
        adError: 'Failed to load video ad. Please try again.',
      ));
    }
  }

  /// NEW: Handle watch ad event
  Future<void> _onWatchAd(
    _WatchAd event,
    Emitter<EarnState> emit,
  ) async {
    if (!state.isAdLoaded) {
      emit(state.copyWith(
        adError: 'No ad available. Please wait.',
      ));
      return;
    }

    emit(state.copyWith(
      engagementPhase: EngagementPhase.watching,
    ));

    final result = await _adMobService.showRewardedAd();

    switch (result) {
      case AdWatchResult.rewarded:
        // Ad was fully watched - handled by _onAdCompleted
        add(const EarnEvent.adCompleted());
        break;
      case AdWatchResult.dismissed:
        add(const EarnEvent.adDismissed());
        break;
      case AdWatchResult.failed:
        add(const EarnEvent.adFailed(reason: 'Failed to show video'));
        break;
      case AdWatchResult.notLoaded:
        add(const EarnEvent.adFailed(reason: 'Video not loaded'));
        break;
      case AdWatchResult.loading:
        add(const EarnEvent.adFailed(reason: 'Video still loading'));
        break;
    }
  }

  /// NEW: Handle ad completed event
  Future<void> _onAdCompleted(
    _AdCompleted event,
    Emitter<EarnState> emit,
  ) async {
    // Ad was watched successfully - unlock the question
    emit(state.copyWith(
      engagementPhase: EngagementPhase.surveying,
      isAdLoaded: false,
      adTransactionId: event.transactionId,
      currentEngagement: state.currentEngagement?.copyWith(
        adWatched: true,
        adCompletedAt: DateTime.now(),
        adTransactionId: event.transactionId,
      ),
    ));

    // Update engagement on backend to record ad was watched
    if (state.currentEngagement != null) {
      await _earnRepository.updateEngagementProgress(
        engagementId: state.currentEngagement!.id,
        watchDurationSeconds: state.selectedOpportunity?.durationSeconds ?? 30,
      );
    }
  }

  /// NEW: Handle ad dismissed event
  Future<void> _onAdDismissed(
    _AdDismissed event,
    Emitter<EarnState> emit,
  ) async {
    // User closed ad early without reward
    emit(state.copyWith(
      engagementPhase: EngagementPhase.abandoned,
      isAdLoaded: false,
      adError: 'Video was not completed. Please watch the full video to earn tokens.',
    ));

    // Abandon the engagement on backend
    if (state.currentEngagement != null) {
      await _earnRepository.abandonEngagement(state.currentEngagement!.id);
    }
  }

  /// NEW: Handle ad failed event
  Future<void> _onAdFailed(
    _AdFailed event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(
      engagementPhase: EngagementPhase.failed,
      isAdLoaded: false,
      isAdLoading: false,
      adError: event.reason,
    ));
  }

  /// Modified: Reset should also clear ad state
  Future<void> _onResetEngagement(
    _ResetEngagement event,
    Emitter<EarnState> emit,
  ) async {
    _adMobService.disposeAd();  // NEW: Dispose any loaded ad

    emit(state.copyWith(
      currentEngagement: null,
      engagementPhase: EngagementPhase.idle,
      errorMessage: null,
      // NEW: Clear ad state
      isAdLoaded: false,
      isAdLoading: false,
      adTransactionId: null,
      adError: null,
    ));
  }

  @override
  Future<void> close() {
    _adMobService.disposeAd();  // NEW: Clean up on bloc close
    return super.close();
  }
}
```

### 5.4 Update earn_bloc.freezed.dart

**Action:** Regenerate after event/state changes

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5.5 Create AdMob Video Widget

**File:** `lib/presentation/widgets/earn/admob_video_widget.dart` (NEW)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/earn/earn_bloc.dart';

/// Widget for displaying AdMob video ad interaction
class AdMobVideoWidget extends StatelessWidget {
  final VoidCallback? onWatchPressed;

  const AdMobVideoWidget({
    super.key,
    this.onWatchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EarnBloc, EarnState>(
      buildWhen: (previous, current) =>
          previous.engagementPhase != current.engagementPhase ||
          previous.isAdLoaded != current.isAdLoaded ||
          previous.isAdLoading != current.isAdLoading ||
          previous.adError != current.adError,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(state),
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              _getTitle(state),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              _getDescription(state),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Action button
            if (state.engagementPhase == EngagementPhase.adLoading)
              const CircularProgressIndicator()
            else if (state.engagementPhase == EngagementPhase.adReady)
              _buildWatchButton(context, state)
            else if (state.adError != null)
              _buildRetryButton(context),

            // Error message
            if (state.adError != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.adError!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildWatchButton(BuildContext context, EarnState state) {
    return FilledButton.icon(
      onPressed: () {
        if (onWatchPressed != null) {
          onWatchPressed!();
        } else {
          context.read<EarnBloc>().add(const EarnEvent.watchAd());
        }
      },
      icon: const Icon(Icons.play_circle_filled),
      label: const Text('Watch Video'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        final state = context.read<EarnBloc>().state;
        if (state.selectedOpportunity != null) {
          context.read<EarnBloc>().add(
                EarnEvent.loadAd(
                  adUnitId: state.selectedOpportunity!.adUnitId ?? '',
                  engagementId: state.currentEngagement?.id,
                ),
              );
        }
      },
      icon: const Icon(Icons.refresh),
      label: const Text('Try Again'),
    );
  }

  IconData _getIcon(EarnState state) {
    switch (state.engagementPhase) {
      case EngagementPhase.adLoading:
        return Icons.hourglass_top;
      case EngagementPhase.adReady:
        return Icons.play_circle_outline;
      case EngagementPhase.watching:
        return Icons.videocam;
      default:
        return Icons.video_library;
    }
  }

  String _getTitle(EarnState state) {
    switch (state.engagementPhase) {
      case EngagementPhase.adLoading:
        return 'Loading Video...';
      case EngagementPhase.adReady:
        return 'Video Ready!';
      case EngagementPhase.watching:
        return 'Watching...';
      default:
        return 'Watch & Earn';
    }
  }

  String _getDescription(EarnState state) {
    switch (state.engagementPhase) {
      case EngagementPhase.adLoading:
        return 'Please wait while we prepare your video';
      case EngagementPhase.adReady:
        return 'Tap the button below to watch a short video and unlock your question';
      case EngagementPhase.watching:
        return 'Please watch the entire video to earn your reward';
      default:
        return 'Watch a video to unlock the question';
    }
  }
}
```

### 5.6 Update Earn Interaction Screen

**File:** `lib/presentation/screens/earn/earn_interaction_screen.dart`

**Change:** Add AdMob video handling to the interaction flow

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/earn/earn_bloc.dart';
import '../../widgets/earn/admob_video_widget.dart';
// ... other imports ...

class EarnInteractionScreen extends StatefulWidget {
  final String opportunityId;

  const EarnInteractionScreen({
    super.key,
    required this.opportunityId,
  });

  @override
  State<EarnInteractionScreen> createState() => _EarnInteractionScreenState();
}

class _EarnInteractionScreenState extends State<EarnInteractionScreen> {
  @override
  void initState() {
    super.initState();
    // Start the engagement when screen loads
    context.read<EarnBloc>().add(
          EarnEvent.startEngagement(opportunityId: widget.opportunityId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarnBloc, EarnState>(
      listenWhen: (previous, current) =>
          previous.engagementPhase != current.engagementPhase,
      listener: (context, state) {
        // Handle navigation on completion/failure
        if (state.engagementPhase == EngagementPhase.completed) {
          _showSuccessDialog(context, state);
        } else if (state.engagementPhase == EngagementPhase.failed) {
          _showErrorSnackbar(context, state.errorMessage ?? state.adError);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.selectedOpportunity?.title ?? 'Earn'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _handleBack(context, state),
            ),
          ),
          body: SafeArea(
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, EarnState state) {
    final opportunity = state.selectedOpportunity;

    if (opportunity == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Check if this is an AdMob opportunity
    if (opportunity.isAdMobOpportunity) {
      return _buildAdMobFlow(context, state);
    }

    // Regular video/survey flow
    return _buildRegularFlow(context, state);
  }

  /// NEW: Build AdMob opportunity flow
  Widget _buildAdMobFlow(BuildContext context, EarnState state) {
    switch (state.engagementPhase) {
      case EngagementPhase.starting:
      case EngagementPhase.adLoading:
      case EngagementPhase.adReady:
      case EngagementPhase.watching:
        // Show ad loading/ready/watching UI
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: AdMobVideoWidget(
            onWatchPressed: () {
              context.read<EarnBloc>().add(const EarnEvent.watchAd());
            },
          ),
        );

      case EngagementPhase.surveying:
        // Ad was watched - show the single question
        return _buildQuestionView(context, state);

      case EngagementPhase.submitting:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Submitting your answer...'),
            ],
          ),
        );

      case EngagementPhase.completed:
        return _buildCompletedView(context, state);

      case EngagementPhase.failed:
      case EngagementPhase.abandoned:
        return _buildErrorView(context, state);

      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  /// Build the question view (shown after ad is watched)
  Widget _buildQuestionView(BuildContext context, EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final questions = opportunity.questions;

    if (questions.isEmpty) {
      // No question - auto-complete
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _submitWithoutQuestion(context, state);
      });
      return const Center(child: CircularProgressIndicator());
    }

    final question = questions.first;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Success indicator
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Video completed! Answer the question below to earn your tokens.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Question
          Text(
            question.text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),

          // Options
          ...question.options.map((option) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  onPressed: () => _submitAnswer(context, state, question.id, option),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(option),
                ),
              )),

          const Spacer(),

          // Token reward reminder
          Center(
            child: Text(
              'Earn ${opportunity.tokenReward} tokens',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitAnswer(
    BuildContext context,
    EarnState state,
    String questionId,
    String selectedOption,
  ) {
    final engagement = state.currentEngagement;
    if (engagement == null) return;

    final answer = EngagementAnswer(
      questionId: questionId,
      selectedOption: selectedOption,
      answeredAt: DateTime.now(),
    );

    final evidence = EngagementEvidence(
      deviceFingerprint: 'device_${DateTime.now().millisecondsSinceEpoch}',
      watchDurationMs: (state.selectedOpportunity?.durationSeconds ?? 30) * 1000,
      videoSeeked: false,
      screenVisible: true,
      appInForeground: true,
      surveyResponseTimesMs: const [2000],
      videoStartedAt: engagement.startedAt,
      surveySubmittedAt: DateTime.now(),
      adTransactionId: state.adTransactionId,
      adFullyWatched: true,
    );

    context.read<EarnBloc>().add(
          EarnEvent.submitSurvey(
            engagementId: engagement.id,
            answers: [answer],
            evidence: evidence,
          ),
        );
  }

  void _submitWithoutQuestion(BuildContext context, EarnState state) {
    final engagement = state.currentEngagement;
    if (engagement == null) return;

    final evidence = EngagementEvidence(
      deviceFingerprint: 'device_${DateTime.now().millisecondsSinceEpoch}',
      watchDurationMs: (state.selectedOpportunity?.durationSeconds ?? 30) * 1000,
      videoSeeked: false,
      screenVisible: true,
      appInForeground: true,
      surveyResponseTimesMs: const [],
      videoStartedAt: engagement.startedAt,
      surveySubmittedAt: DateTime.now(),
      adTransactionId: state.adTransactionId,
      adFullyWatched: true,
    );

    context.read<EarnBloc>().add(
          EarnEvent.submitSurvey(
            engagementId: engagement.id,
            answers: const [],
            evidence: evidence,
          ),
        );
  }

  // ... existing helper methods for regular flow, success dialog, etc. ...

  Widget _buildRegularFlow(BuildContext context, EarnState state) {
    // Existing video/survey flow implementation
    // ... keep existing implementation ...
  }

  Widget _buildCompletedView(BuildContext context, EarnState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 24),
          Text(
            'Congratulations!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '+${state.currentEngagement?.tokensEarned ?? state.selectedOpportunity?.tokenReward ?? 0} tokens earned',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, EarnState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 80),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage ?? state.adError ?? 'Please try again',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBack(BuildContext context, EarnState state) {
    if (state.hasActiveEngagement) {
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Abandon Engagement?'),
          content: const Text(
            'You will not earn any tokens if you leave now.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Stay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (state.currentEngagement != null) {
                  context.read<EarnBloc>().add(
                        EarnEvent.abandonEngagement(state.currentEngagement!.id),
                      );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Leave'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showSuccessDialog(BuildContext context, EarnState state) {
    // Already handled in UI, just pop after delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _showErrorSnackbar(BuildContext context, String? message) {
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
```

---

## Phase 6: Backend (Cloud Functions) Updates

### 6.1 Create Migration Script

**File:** `functions/src/migrations/createAdMobThread.ts` (NEW)

```typescript
import * as admin from 'firebase-admin';

/**
 * Migration: Create the system AdMob Daily Watch & Earn thread and opportunity.
 *
 * This creates a permanent, pinned thread that shows at the top of the earn
 * thread inbox. Users watch an AdMob rewarded video, then answer one question
 * to earn tokens.
 *
 * Run this migration once during deployment:
 * - Via Firebase console Functions shell
 * - Or as a one-time HTTPS function call
 */
export async function createAdMobThread(): Promise<void> {
  const db = admin.firestore();
  const batch = db.batch();

  const threadId = 'system_admob_daily';
  const opportunityId = 'system_admob_daily_opp';

  // Check if already exists
  const existingThread = await db.collection('earnThreads').doc(threadId).get();
  if (existingThread.exists) {
    console.log('AdMob thread already exists, skipping creation');
    return;
  }

  const now = admin.firestore.FieldValue.serverTimestamp();

  // Create the permanent thread
  const threadRef = db.collection('earnThreads').doc(threadId);
  batch.set(threadRef, {
    id: threadId,
    clientId: 'system',
    clientName: 'iMaliChat',
    title: 'Daily Watch & Earn',
    description: 'Watch a short video and answer a question to earn tokens!',
    isActive: true,
    isPinned: true,        // Always at top of list
    isFeatured: true,      // Highlighted in UI
    isSystemThread: true,  // Marks as system-owned (not a brand)
    availableOpportunities: 1,
    completedOpportunities: 0,
    completedUniqueUsers: 0,
    // No targeting - available to all users
    targeting: null,
    // No expiry - permanent thread
    activeFrom: null,
    activeTo: null,
    // UI customization
    avatarColor: '#4CAF50',  // Green for iMaliChat
    iconUrl: null,
    createdAt: now,
    updatedAt: now,
  });

  // Create the AdMob opportunity
  const opportunityRef = db.collection('earnOpportunities').doc(opportunityId);
  batch.set(opportunityRef, {
    id: opportunityId,
    threadId: threadId,
    clientId: 'system',
    clientName: 'iMaliChat',
    title: 'Watch & Answer',
    description: 'Watch a short video, then answer one question to earn 5 tokens',
    // Earning configuration
    earningType: 'adVideo',  // NEW type for AdMob
    mediaType: 'adMob',      // NEW type for AdMob
    tokenReward: 5,          // 5 tokens = R0.05
    streakPoints: 1,
    durationSeconds: 30,     // Approximate video duration
    // AdMob configuration
    adUnitId: 'ca-app-pub-9331591670168644/1108724925',
    dailyLimitPerUser: 3,    // Max 3 watches per user per day
    // Single question to answer after watching
    questions: [{
      id: 'q1',
      text: 'Did you find this video interesting?',
      options: [
        'Yes, very interesting',
        'Somewhat interesting',
        'Not really',
        'Not at all',
      ],
      orderIndex: 0,
      isAttentionCheck: false,
      correctAnswer: null,  // No correct answer - just feedback
    }],
    // No targeting - available to all users
    targeting: null,
    // No expiry
    expiresAt: null,
    isActive: true,
    // No bonus rewards for AdMob opportunity
    bonusReward: false,
    bonusRewardMultiplier: 1.0,
    bonusIntervalType: null,
    bonusIntervalX: null,
    createdAt: now,
    updatedAt: now,
  });

  await batch.commit();
  console.log('AdMob thread and opportunity created successfully');
}

// Export as callable function for one-time execution
import * as functions from 'firebase-functions';

export const runCreateAdMobThread = functions.https.onRequest(async (req, res) => {
  // Verify admin authorization (implement your auth check)
  // const authHeader = req.headers.authorization;
  // if (!isAdmin(authHeader)) {
  //   res.status(403).send('Unauthorized');
  //   return;
  // }

  try {
    await createAdMobThread();
    res.status(200).send('AdMob thread created successfully');
  } catch (error) {
    console.error('Failed to create AdMob thread:', error);
    res.status(500).send(`Error: ${error}`);
  }
});
```

### 6.2 Update engagement.ts - Add adVideo Validation

**File:** `functions/src/engagement.ts`

**Change:** Add validation for adVideo earning type in processEngagement

```typescript
// In processEngagement function, after fetching opportunity data:

// Validate adVideo requirements
if (opportunity.earningType === 'adVideo') {
  // For adVideo type, we require either:
  // 1. adWatched flag set to true on engagement
  // 2. OR adTransactionId in evidence for SSV verification

  const engagementData = engagementSnap.data();
  const adWatched = engagementData?.adWatched === true;
  const hasTransactionId = evidence?.adTransactionId != null;
  const adFullyWatched = evidence?.adFullyWatched === true;

  if (!adWatched && !hasTransactionId && !adFullyWatched) {
    throw new HttpsError(
      'failed-precondition',
      'Video ad was not completed. Please watch the full video.'
    );
  }

  // Optional: Verify SSV callback was received (if using server-side verification)
  // const ssvVerified = await verifyAdMobSSV(evidence.adTransactionId, engagementId);
  // if (!ssvVerified) {
  //   throw new HttpsError('failed-precondition', 'Ad verification failed');
  // }

  logger.info('AdVideo validation passed', {
    engagementId,
    adWatched,
    hasTransactionId,
    adFullyWatched,
  });
}

// Continue with normal processing...
```

### 6.3 Update updateEngagementProgress - Support adWatched

**File:** `functions/src/engagement.ts`

**Change:** Allow setting adWatched and adCompletedAt fields

```typescript
// In updateEngagementProgress function:

interface UpdateProgressData {
  engagementId: string;
  watchDurationSeconds?: number;
  status?: string;
  progress?: number;
  // NEW: AdMob fields
  adWatched?: boolean;
  adCompletedAt?: admin.firestore.Timestamp;
  adTransactionId?: string;
}

// In the update logic:
const updateData: Record<string, any> = {
  updatedAt: admin.firestore.FieldValue.serverTimestamp(),
};

if (data.watchDurationSeconds !== undefined) {
  updateData.watchDurationSeconds = data.watchDurationSeconds;
}

if (data.status !== undefined) {
  updateData.status = data.status;
}

if (data.progress !== undefined) {
  updateData.progress = data.progress;
}

// NEW: Handle adWatched updates
if (data.adWatched !== undefined) {
  updateData.adWatched = data.adWatched;
  updateData.adCompletedAt = admin.firestore.FieldValue.serverTimestamp();
}

if (data.adTransactionId !== undefined) {
  updateData.adTransactionId = data.adTransactionId;
}

await engagementRef.update(updateData);
```

### 6.4 Create AdMob SSV Callback Endpoint (Optional)

**File:** `functions/src/admobSSV.ts` (NEW)

```typescript
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as crypto from 'crypto';
import fetch from 'node-fetch';

const logger = functions.logger;

// Cache for AdMob public keys
let admobPublicKeys: Map<number, string> | null = null;
let keysLastFetched: number = 0;
const KEYS_CACHE_DURATION = 24 * 60 * 60 * 1000; // 24 hours

/**
 * Fetch AdMob public keys for signature verification
 */
async function getAdMobPublicKeys(): Promise<Map<number, string>> {
  const now = Date.now();

  if (admobPublicKeys && (now - keysLastFetched) < KEYS_CACHE_DURATION) {
    return admobPublicKeys;
  }

  const response = await fetch(
    'https://www.gstatic.com/admob/reward/verifier-keys.json'
  );

  if (!response.ok) {
    throw new Error('Failed to fetch AdMob public keys');
  }

  const data = await response.json() as {
    keys: Array<{ keyId: number; pem: string; base64: string }>;
  };

  admobPublicKeys = new Map();
  for (const key of data.keys) {
    admobPublicKeys.set(key.keyId, key.pem || key.base64);
  }

  keysLastFetched = now;
  return admobPublicKeys;
}

/**
 * Verify the signature of an AdMob SSV callback
 */
async function verifySignature(
  queryString: string,
  signature: string,
  keyId: number
): Promise<boolean> {
  try {
    const keys = await getAdMobPublicKeys();
    const publicKey = keys.get(keyId);

    if (!publicKey) {
      logger.warn('Unknown key ID in SSV callback', { keyId });
      return false;
    }

    // The message to verify is the query string up to (but not including) signature
    const signatureIndex = queryString.indexOf('&signature=');
    const message = queryString.substring(0, signatureIndex);

    // Decode the signature (base64 URL-safe)
    const signatureBuffer = Buffer.from(
      signature.replace(/-/g, '+').replace(/_/g, '/'),
      'base64'
    );

    // Verify using ECDSA with SHA-256
    const verifier = crypto.createVerify('SHA256');
    verifier.update(message);

    return verifier.verify(publicKey, signatureBuffer);
  } catch (error) {
    logger.error('Signature verification failed', { error });
    return false;
  }
}

/**
 * AdMob Server-Side Verification (SSV) callback endpoint
 *
 * Google AdMob calls this URL when a user earns a reward from watching
 * a rewarded video ad. This provides fraud protection beyond client-side
 * validation.
 *
 * Callback URL format:
 * https://[project].cloudfunctions.net/admobSSVCallback?
 *   ad_network=...&
 *   ad_unit=...&
 *   custom_data=ENGAGEMENT_ID&
 *   reward_amount=...&
 *   reward_item=...&
 *   timestamp=...&
 *   transaction_id=...&
 *   signature=...&
 *   key_id=...
 */
export const admobSSVCallback = functions.https.onRequest(async (req, res) => {
  try {
    const {
      ad_network,
      ad_unit,
      custom_data,  // This is the engagementId
      reward_amount,
      reward_item,
      timestamp,
      transaction_id,
      signature,
      key_id,
    } = req.query;

    logger.info('Received AdMob SSV callback', {
      ad_unit,
      custom_data,
      transaction_id,
      timestamp,
    });

    // Validate required parameters
    if (!signature || !key_id || !custom_data) {
      logger.warn('Missing required SSV parameters');
      res.status(400).send('Missing required parameters');
      return;
    }

    // Verify signature (optional but recommended)
    const queryString = req.url?.split('?')[1] || '';
    const isValid = await verifySignature(
      queryString,
      signature as string,
      parseInt(key_id as string, 10)
    );

    if (!isValid) {
      logger.warn('Invalid SSV signature', { custom_data, transaction_id });
      // Still process but log for monitoring
      // In production, you might want to reject invalid signatures
    }

    // Mark engagement as ad-verified
    const engagementId = custom_data as string;
    const db = admin.firestore();

    const engagementRef = db.collection('engagements').doc(engagementId);
    const engagementSnap = await engagementRef.get();

    if (!engagementSnap.exists) {
      logger.warn('Engagement not found for SSV callback', { engagementId });
      res.status(404).send('Engagement not found');
      return;
    }

    await engagementRef.update({
      adVerified: true,
      adTransactionId: transaction_id,
      adVerifiedAt: admin.firestore.FieldValue.serverTimestamp(),
      adNetwork: ad_network,
      adRewardAmount: reward_amount,
      adRewardItem: reward_item,
    });

    logger.info('AdMob SSV verification recorded', {
      engagementId,
      transaction_id,
      isSignatureValid: isValid,
    });

    res.status(200).send('OK');
  } catch (error) {
    logger.error('AdMob SSV callback error', { error });
    res.status(500).send('Internal error');
  }
});
```

### 6.5 Export New Functions

**File:** `functions/src/index.ts`

**Change:** Export the new migration and SSV functions

```typescript
// ... existing exports ...

// AdMob
export { runCreateAdMobThread, admobSSVCallback } from './admobSSV';
// Or if in separate file:
// export { runCreateAdMobThread } from './migrations/createAdMobThread';
// export { admobSSVCallback } from './admobSSV';
```

### 6.6 Update Constants for AdVideo Type

**File:** `functions/src/constants/targeting.ts`

**Change:** Add 'adVideo' to valid earning types

```typescript
export const VALID_EARNING_TYPES = [
  'survey',
  'video',
  'trivia',
  'rating',
  'poll',
  'adVideo',  // NEW
] as const;

export type EarningType = typeof VALID_EARNING_TYPES[number];

export function validateEarningType(type: string): type is EarningType {
  return VALID_EARNING_TYPES.includes(type as EarningType);
}
```

---

## Phase 7: Firestore Data & Security

### 7.1 Firestore Security Rules Update

**File:** `firestore.rules`

**Change:** Add rules for system threads if needed

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // ... existing rules ...

    // Earn Threads - system threads are read-only
    match /earnThreads/{threadId} {
      allow read: if request.auth != null;
      allow write: if false; // Only admin SDK can write

      // System threads cannot be modified by users
      // allow update: if resource.data.isSystemThread != true;
    }

    // Earn Opportunities - system opportunities are read-only
    match /earnOpportunities/{opportunityId} {
      allow read: if request.auth != null;
      allow write: if false; // Only admin SDK can write
    }

    // ... rest of rules ...
  }
}
```

### 7.2 Firestore Indexes

**File:** `firestore.indexes.json`

**Change:** Add indexes for adVideo queries if needed

```json
{
  "indexes": [
    // ... existing indexes ...

    // Index for querying user's daily AdMob completions
    {
      "collectionGroup": "engagements",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "threadId", "order": "ASCENDING" },
        { "fieldPath": "completedAt", "order": "DESCENDING" }
      ]
    }
  ],
  "fieldOverrides": []
}
```

### 7.3 Deploy Firestore Rules and Indexes

**Action:** Deploy updated rules and indexes

```bash
firebase deploy --only firestore:rules,firestore:indexes
```

---

## Phase 8: Testing

### 8.1 Unit Tests for AdMobService

**File:** `test/data/services/admob_service_test.dart` (NEW)

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/data/services/admob_service.dart';

// Note: AdMob ads are difficult to unit test due to native platform code.
// These tests verify the service logic, not actual ad loading.

void main() {
  group('AdMobService', () {
    late AdMobService service;

    setUp(() {
      service = AdMobService();
    });

    tearDown(() {
      service.dispose();
    });

    test('initial state has no ad loaded', () {
      expect(service.isAdLoaded, isFalse);
      expect(service.isLoading, isFalse);
    });

    test('showRewardedAd returns notLoaded when no ad is loaded', () async {
      final result = await service.showRewardedAd();
      expect(result, equals(AdWatchResult.notLoaded));
    });

    test('disposeAd clears state', () {
      service.disposeAd();
      expect(service.isAdLoaded, isFalse);
      expect(service.isLoading, isFalse);
    });
  });
}
```

### 8.2 Bloc Tests for AdMob Events

**File:** `test/presentation/blocs/earn_bloc_admob_test.dart` (NEW)

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/services/admob_service.dart';
import 'package:imalichat/domain/entities/earn_opportunity.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';

class MockEarnRepository extends Mock implements EarnRepository {}
class MockAdMobService extends Mock implements AdMobService {}

void main() {
  late EarnBloc bloc;
  late MockEarnRepository mockRepository;
  late MockAdMobService mockAdMobService;

  final testAdMobOpportunity = EarnOpportunity(
    id: 'admob_opp',
    threadId: 'system_admob_daily',
    title: 'Watch & Answer',
    earningType: EarningType.adVideo,
    tokenReward: 5,
    mediaType: MediaType.adMob,
    questions: const [],
    durationSeconds: 30,
    isActive: true,
    adUnitId: 'ca-app-pub-test/123',
  );

  final testEngagement = Engagement(
    id: 'eng_1',
    oddienceCampaignId: 'camp_1',
    userId: 'user_1',
    earnOpportunityId: 'admob_opp',
    threadId: 'system_admob_daily',
    clientId: 'system',
    status: EngagementStatus.started,
    startedAt: DateTime.now(),
    watchDurationSeconds: 0,
    requiredDurationSeconds: 30,
    answers: const [],
    attemptNumber: 1,
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockRepository = MockEarnRepository();
    mockAdMobService = MockAdMobService();
    bloc = EarnBloc(mockRepository, mockAdMobService);
  });

  tearDown(() {
    bloc.close();
  });

  group('AdMob Events', () {
    blocTest<EarnBloc, EarnState>(
      'LoadAd success transitions to adReady phase',
      build: () {
        when(() => mockAdMobService.loadRewardedAd(
          adUnitId: any(named: 'adUnitId'),
          customData: any(named: 'customData'),
        )).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const EarnEvent.loadAd(
        adUnitId: 'ca-app-pub-test/123',
        engagementId: 'eng_1',
      )),
      expect: () => [
        isA<EarnState>().having((s) => s.isAdLoading, 'isAdLoading', true),
        isA<EarnState>()
            .having((s) => s.isAdLoaded, 'isAdLoaded', true)
            .having((s) => s.isAdLoading, 'isAdLoading', false)
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.adReady),
      ],
    );

    blocTest<EarnBloc, EarnState>(
      'LoadAd failure transitions to failed phase',
      build: () {
        when(() => mockAdMobService.loadRewardedAd(
          adUnitId: any(named: 'adUnitId'),
          customData: any(named: 'customData'),
        )).thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const EarnEvent.loadAd(
        adUnitId: 'ca-app-pub-test/123',
      )),
      expect: () => [
        isA<EarnState>().having((s) => s.isAdLoading, 'isAdLoading', true),
        isA<EarnState>()
            .having((s) => s.isAdLoaded, 'isAdLoaded', false)
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.failed)
            .having((s) => s.adError, 'adError', isNotNull),
      ],
    );

    blocTest<EarnBloc, EarnState>(
      'WatchAd with rewarded result transitions to surveying',
      build: () {
        when(() => mockAdMobService.showRewardedAd())
            .thenAnswer((_) async => AdWatchResult.rewarded);
        when(() => mockRepository.updateEngagementProgress(
          engagementId: any(named: 'engagementId'),
          watchDurationSeconds: any(named: 'watchDurationSeconds'),
        )).thenAnswer((_) async => Right(testEngagement));
        return bloc;
      },
      seed: () => EarnState(
        isAdLoaded: true,
        currentEngagement: testEngagement,
        selectedOpportunity: testAdMobOpportunity,
      ),
      act: (bloc) => bloc.add(const EarnEvent.watchAd()),
      expect: () => [
        isA<EarnState>()
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.watching),
        // AdCompleted event will be added
        isA<EarnState>()
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.surveying)
            .having((s) => s.isAdLoaded, 'isAdLoaded', false),
      ],
    );

    blocTest<EarnBloc, EarnState>(
      'WatchAd dismissed transitions to abandoned',
      build: () {
        when(() => mockAdMobService.showRewardedAd())
            .thenAnswer((_) async => AdWatchResult.dismissed);
        when(() => mockRepository.abandonEngagement(any()))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      seed: () => EarnState(
        isAdLoaded: true,
        currentEngagement: testEngagement,
      ),
      act: (bloc) => bloc.add(const EarnEvent.watchAd()),
      expect: () => [
        isA<EarnState>()
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.watching),
        isA<EarnState>()
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.abandoned),
      ],
    );

    blocTest<EarnBloc, EarnState>(
      'StartEngagement with adVideo opportunity loads ad',
      build: () {
        when(() => mockRepository.startEngagement(
          opportunityId: any(named: 'opportunityId'),
        )).thenAnswer((_) async => Right(testEngagement));
        when(() => mockAdMobService.loadRewardedAd(
          adUnitId: any(named: 'adUnitId'),
          customData: any(named: 'customData'),
        )).thenAnswer((_) async => true);
        return bloc;
      },
      seed: () => EarnState(selectedOpportunity: testAdMobOpportunity),
      act: (bloc) => bloc.add(const EarnEvent.startEngagement(
        opportunityId: 'admob_opp',
      )),
      expect: () => [
        isA<EarnState>()
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.starting),
        isA<EarnState>()
            .having((s) => s.engagementPhase, 'phase', EngagementPhase.adLoading)
            .having((s) => s.currentEngagement, 'engagement', isNotNull),
        // LoadAd events follow...
      ],
    );
  });
}
```

### 8.3 Integration Test Updates

**File:** `integration_test/mocks/test_fixtures.dart`

**Change:** Add AdMob fixtures

```dart
/// AdMob thread
static EarnThread get adMobThread => EarnThread(
  id: 'system_admob_daily',
  clientId: 'system',
  clientName: 'iMaliChat',
  title: 'Daily Watch & Earn',
  description: 'Watch a short video and answer a question to earn tokens!',
  isActive: true,
  isPinned: true,
  isFeatured: true,
  availableOpportunities: 1,
  completedOpportunities: 0,
  completedUniqueUsers: 1000,
  isSystemThread: true,
  createdAt: DateTime.now().subtract(const Duration(days: 30)),
);

/// AdMob opportunity
static EarnOpportunity get adMobOpportunity => EarnOpportunity(
  id: 'system_admob_daily_opp',
  threadId: 'system_admob_daily',
  clientId: 'system',
  clientName: 'iMaliChat',
  title: 'Watch & Answer',
  description: 'Watch a short video, then answer one question',
  earningType: EarningType.adVideo,
  mediaType: MediaType.adMob,
  tokenReward: 5,
  durationSeconds: 30,
  adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ad unit
  dailyLimitPerUser: 3,
  questions: const [
    SurveyQuestion(
      id: 'q1',
      text: 'Did you find this video interesting?',
      options: ['Yes, very interesting', 'Somewhat interesting', 'Not really', 'Not at all'],
      orderIndex: 0,
    ),
  ],
  isActive: true,
);
```

### 8.4 Backend Tests

**File:** `functions/src/__tests__/engagement.admob.test.ts` (NEW)

```typescript
import { describe, it, expect, beforeEach, jest } from '@jest/globals';
// ... imports ...

describe('Engagement - AdVideo Processing', () => {
  describe('processEngagement with adVideo type', () => {
    it('should accept engagement with adWatched=true', async () => {
      // Setup opportunity with earningType: 'adVideo'
      // Setup engagement with adWatched: true
      // Call processEngagement
      // Expect success
    });

    it('should accept engagement with adTransactionId in evidence', async () => {
      // Setup opportunity with earningType: 'adVideo'
      // Setup evidence with adTransactionId
      // Call processEngagement
      // Expect success
    });

    it('should reject engagement without ad watch confirmation', async () => {
      // Setup opportunity with earningType: 'adVideo'
      // Setup engagement with adWatched: false, no transactionId
      // Call processEngagement
      // Expect failed-precondition error
    });
  });
});
```

---

## Phase 9: Deployment & Go-Live

### 9.1 Pre-Deployment Checklist

- [ ] **AdMob Console Setup**
  - [ ] App registered in AdMob
  - [ ] Rewarded ad unit created
  - [ ] Test device configured
  - [ ] (Optional) SSV callback URL configured

- [ ] **Code Changes**
  - [ ] All Freezed/Injectable code generated
  - [ ] Flutter analyze passes with no errors
  - [ ] All unit tests pass
  - [ ] Integration tests pass

- [ ] **Configuration**
  - [ ] Test ad units used during development
  - [ ] Production ad units ready for release
  - [ ] `useTestAds` flag set correctly in `admob_constants.dart`

### 9.2 Deployment Steps

1. **Deploy Cloud Functions**
   ```bash
   cd functions
   npm run build
   firebase deploy --only functions
   ```

2. **Run Migration** (one-time)
   ```bash
   # Option 1: Via Firebase Functions shell
   firebase functions:shell
   > runCreateAdMobThread()

   # Option 2: Via HTTP request (if deployed)
   curl https://[region]-[project].cloudfunctions.net/runCreateAdMobThread
   ```

3. **Deploy Firestore Rules & Indexes**
   ```bash
   firebase deploy --only firestore:rules,firestore:indexes
   ```

4. **Build & Deploy Flutter App**
   ```bash
   # Android
   flutter build appbundle --release

   # iOS
   flutter build ipa --release
   ```

### 9.3 Post-Deployment Verification

1. **Verify System Thread Exists**
   - Check Firestore: `earnThreads/system_admob_daily`
   - Check Firestore: `earnOpportunities/system_admob_daily_opp`

2. **Test Ad Flow**
   - Launch app on test device
   - Navigate to Earn tab
   - Verify "Daily Watch & Earn" thread is pinned at top
   - Tap thread and start engagement
   - Verify ad loads and plays
   - Complete question and verify token reward

3. **Monitor**
   - Check Firebase Functions logs for errors
   - Check AdMob console for impressions/revenue
   - Monitor crash reports (Firebase Crashlytics)

### 9.4 Go-Live Checklist

- [ ] Switch `useTestAds` to `false` in `admob_constants.dart`
- [ ] Verify production ad unit ID is correct
- [ ] Test on physical device with production ads
- [ ] Submit app update to stores

---

## Appendix: Complete Code Listings

### A.1 File Summary

| File | Action | Description |
|------|--------|-------------|
| `pubspec.yaml` | MODIFY | Add google_mobile_ads dependency |
| `android/app/src/main/AndroidManifest.xml` | MODIFY | Add AdMob App ID |
| `ios/Runner/Info.plist` | MODIFY | Add AdMob App ID and SKAdNetwork |
| `lib/main.dart` | MODIFY | Initialize MobileAds SDK |
| `lib/core/constants/admob_constants.dart` | CREATE | AdMob configuration constants |
| `lib/data/services/admob_service.dart` | CREATE | AdMob rewarded ad service |
| `lib/domain/entities/earn_opportunity.dart` | MODIFY | Add adVideo enum, adUnitId field |
| `lib/domain/entities/engagement.dart` | MODIFY | Add ad tracking fields |
| `lib/domain/entities/earn_thread.dart` | MODIFY | Add isSystemThread field |
| `lib/domain/value_objects/engagement_evidence.dart` | MODIFY | Add adTransactionId field |
| `lib/data/models/earn_opportunity_model.dart` | MODIFY | Add adUnitId parsing |
| `lib/data/models/engagement_model.dart` | MODIFY | Add ad field parsing |
| `lib/presentation/blocs/earn/earn_event.dart` | MODIFY | Add ad events |
| `lib/presentation/blocs/earn/earn_state.dart` | MODIFY | Add ad state fields |
| `lib/presentation/blocs/earn/earn_bloc.dart` | MODIFY | Add ad event handlers |
| `lib/presentation/widgets/earn/admob_video_widget.dart` | CREATE | Ad video UI widget |
| `lib/presentation/screens/earn/earn_interaction_screen.dart` | MODIFY | Add AdMob flow |
| `functions/src/migrations/createAdMobThread.ts` | CREATE | Migration script |
| `functions/src/admobSSV.ts` | CREATE | SSV callback endpoint |
| `functions/src/engagement.ts` | MODIFY | Add adVideo validation |
| `functions/src/constants/targeting.ts` | MODIFY | Add adVideo to valid types |
| `functions/src/index.ts` | MODIFY | Export new functions |
| `firestore.rules` | MODIFY | Add system thread rules |
| `firestore.indexes.json` | MODIFY | Add required indexes |

### A.2 Estimated Implementation Time

| Phase | Estimated Time |
|-------|---------------|
| Phase 1: SDK Setup | 1-2 hours |
| Phase 2: Domain Layer | 1-2 hours |
| Phase 3: Data Layer | 1 hour |
| Phase 4: AdMob Service | 2-3 hours |
| Phase 5: Presentation Layer | 3-4 hours |
| Phase 6: Backend | 2-3 hours |
| Phase 7: Firestore | 30 minutes |
| Phase 8: Testing | 2-3 hours |
| Phase 9: Deployment | 1-2 hours |
| **Total** | **14-20 hours** |

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-06 | Claude | Initial comprehensive plan |

---

*End of Document*
