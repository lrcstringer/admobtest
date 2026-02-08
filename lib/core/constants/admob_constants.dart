import 'dart:io';

/// AdMob configuration constants for iMaliChat
abstract class AdMobConstants {
  // App IDs
  static const String androidAppId = 'ca-app-pub-9331591670168644~8585460504';
  static const String iosAppId = 'ca-app-pub-9331591670168644~8585460504';

  // Publisher ID
  static const String publisherId = 'pub-9331591670168644';

  // Ad Unit IDs - Production
  static const String rewardedAdUnitIdAndroid =
      'ca-app-pub-9331591670168644/3138828175';
  static const String rewardedAdUnitIdIos =
      'ca-app-pub-9331591670168644/3138828175';

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
  static const Duration adShowTimeout = Duration(seconds: 60);

  // Retry Configuration
  static const int maxLoadRetries = 5;
  static const Duration initialRetryDelay = Duration(seconds: 2);
  /// Max manual retry rounds the user gets before "unavailable" (no more retry)
  static const int maxManualRetryRounds = 1;

  // System Thread Configuration
  static const String systemThreadClientId = 'system_admob';
  static const String systemThreadClientName = 'iMali Rewards';
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
