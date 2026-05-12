import 'dart:io';

/// AdMob configuration constants for iMaliChat
abstract class AdMobConstants {
  // App IDs
  static const String androidAppId = 'ca-app-pub-9331591670168644~6272229066';
  static const String iosAppId = 'ca-app-pub-9331591670168644~5554223975';

  // Publisher ID
  static const String publisherId = 'pub-9331591670168644';

  // Ad Unit IDs - Production
  static const String rewardedAdUnitIdAndroid =
      'ca-app-pub-9331591670168644/3138828175';
  static const String rewardedAdUnitIdIos =
      'ca-app-pub-9331591670168644/6264670416';

  // Ad Unit IDs - Test (for development)
  static const String testRewardedAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/5224354917';
  static const String testRewardedAdUnitIdIos =
      'ca-app-pub-3940256099942544/1712485313';

  /// Get the appropriate rewarded ad unit ID for the current platform
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return rewardedAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return rewardedAdUnitIdIos;
    }
    throw UnsupportedError('Platform not supported for AdMob');
  }

  /// Get test ad unit ID for development
  static String get testRewardedAdUnitId {
    if (Platform.isAndroid) {
      return testRewardedAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return testRewardedAdUnitIdIos;
    }
    throw UnsupportedError('Platform not supported for AdMob');
  }

  // Token Reward Configuration
  static const int adVideoTokenReward = 5;

  // Daily Limits
  static const int defaultDailyLimitPerUser = 3;

  // Timeouts
  static const Duration adLoadTimeout = Duration(seconds: 30);
  static const Duration adShowTimeout = Duration(seconds: 120);

  // Retry Configuration
  static const int maxLoadRetries = 5;
  static const Duration initialRetryDelay = Duration(seconds: 2);
  /// Max manual retry rounds the user gets before "unavailable" (no more retry)
  static const int maxManualRetryRounds = 1;

  /// Max consecutive show failures before treating ads as unavailable.
  /// Show failures are distinct from load failures — the SDK reports "loaded"
  /// but the ad won't play (e.g. no fill, expired creative, internal error).
  static const int maxConsecutiveShowFailures = 2;

  // System Thread Configuration
  static const String systemThreadClientId = 'imalichat';
  static const String systemThreadClientName = 'IMaliChat';
  static const String systemThreadTitle = 'Watch & Earn';
  static const String systemThreadDescription =
      'Watch short video ads to earn tokens instantly!';
  static const String systemThreadAvatarColor = '#4CAF50';

  // Opportunity Configuration
  static const String adOpportunityTitle = 'Watch Ad';
  static const String adOpportunityDescription =
      'Watch a short video ad and answer a question to earn tokens.';
  static const int adVideoDurationSeconds = 30;
}
