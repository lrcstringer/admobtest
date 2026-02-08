import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/admob_constants.dart';
import '../../core/security/session_lock_service.dart';

/// Result of showing a rewarded ad
class AdRewardResult {
  final bool success;
  final String? transactionId;
  final int? rewardAmount;
  final String? rewardType;
  final String? errorMessage;

  /// AdMob response ID — uniquely identifies the ad impression (useful for debugging with Google)
  final String? responseId;

  const AdRewardResult({
    required this.success,
    this.transactionId,
    this.rewardAmount,
    this.rewardType,
    this.errorMessage,
    this.responseId,
  });

  factory AdRewardResult.success({
    required String transactionId,
    required int rewardAmount,
    required String rewardType,
    String? responseId,
  }) {
    return AdRewardResult(
      success: true,
      transactionId: transactionId,
      rewardAmount: rewardAmount,
      rewardType: rewardType,
      responseId: responseId,
    );
  }

  factory AdRewardResult.failure(String errorMessage) {
    return AdRewardResult(
      success: false,
      errorMessage: errorMessage,
    );
  }
}

/// Service for managing Google AdMob Rewarded Video Ads
@lazySingleton
class AdMobService {
  RewardedAd? _rewardedAd;
  bool _isLoading = false;
  int _loadRetryCount = 0;
  final bool _useTestAds;
  final SessionLockService _sessionLockService;

  /// Callback for when ad loading state changes
  final ValueNotifier<bool> isAdReady = ValueNotifier(false);

  /// Callback for when ad is loading
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Current retry attempt number (1-based, 0 when not loading)
  final ValueNotifier<int> currentAttempt = ValueNotifier(0);

  /// Creates AdMobService. Uses test ads in debug mode by default.
  @factoryMethod
  AdMobService(this._sessionLockService) : _useTestAds = kDebugMode;

  /// Constructor for testing - allows overriding test ads setting
  @visibleForTesting
  AdMobService.withTestAds(this._sessionLockService, {bool useTestAds = true})
      : _useTestAds = useTestAds;

  String get _adUnitId => _useTestAds
      ? AdMobConstants.testRewardedAdUnitId
      : AdMobConstants.rewardedAdUnitId;

  /// Load a rewarded ad
  Future<bool> loadAd() async {
    if (_isLoading) {
      debugPrint('AdMobService: Already loading an ad');
      return false;
    }

    if (_rewardedAd != null) {
      debugPrint('AdMobService: Ad already loaded');
      return true;
    }

    _isLoading = true;
    isLoading.value = true;

    final completer = Completer<bool>();

    try {
      await RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('AdMobService: Ad loaded successfully');
            _rewardedAd = ad;
            _isLoading = false;
            _loadRetryCount = 0;
            isLoading.value = false;
            isAdReady.value = true;
            if (!completer.isCompleted) {
              completer.complete(true);
            }
          },
          onAdFailedToLoad: (error) {
            debugPrint(
                'AdMobService: Ad failed to load: ${error.code} - ${error.message}');
            _isLoading = false;
            isLoading.value = false;
            isAdReady.value = false;
            if (!completer.isCompleted) {
              completer.complete(false);
            }
          },
        ),
      );

      // Add timeout
      return await completer.future.timeout(
        AdMobConstants.adLoadTimeout,
        onTimeout: () {
          debugPrint('AdMobService: Ad load timed out');
          _isLoading = false;
          isLoading.value = false;
          return false;
        },
      );
    } catch (e) {
      debugPrint('AdMobService: Error loading ad: $e');
      _isLoading = false;
      isLoading.value = false;
      return false;
    }
  }

  /// Load ad with exponential backoff retry logic
  Future<bool> loadAdWithRetry() async {
    _loadRetryCount = 0;
    while (_loadRetryCount < AdMobConstants.maxLoadRetries) {
      currentAttempt.value = _loadRetryCount + 1;
      final success = await loadAd();
      if (success) {
        currentAttempt.value = 0;
        return true;
      }
      _loadRetryCount++;
      if (_loadRetryCount < AdMobConstants.maxLoadRetries) {
        // Exponential backoff: 2s, 4s, 8s, 16s
        final delay = AdMobConstants.initialRetryDelay * (1 << (_loadRetryCount - 1));
        debugPrint(
            'AdMobService: Retrying ad load ($_loadRetryCount/${AdMobConstants.maxLoadRetries}) after ${delay.inSeconds}s');
        await Future.delayed(delay);
      }
    }
    debugPrint('AdMobService: All ${AdMobConstants.maxLoadRetries} retry attempts failed');
    currentAttempt.value = 0;
    _loadRetryCount = 0;
    return false;
  }

  /// Show the loaded rewarded ad
  /// Returns AdRewardResult with transaction ID if successful
  /// [engagementId] is included in SSV custom_data for server-side verification
  Future<AdRewardResult> showAd({
    required String userId,
    String? engagementId,
  }) async {
    if (_rewardedAd == null) {
      return AdRewardResult.failure('No ad loaded');
    }

    // Configure SSV custom_data so AdMob sends it to our server callback
    // Backend parses format: "{userId}_{engagementId}"
    final customData =
        engagementId != null ? '${userId}_$engagementId' : userId;
    _rewardedAd!.setServerSideOptions(
      ServerSideVerificationOptions(customData: customData),
    );
    debugPrint('AdMobService: SSV custom data set: $customData');

    // Capture response ID before showing (available after load)
    final responseId = _rewardedAd!.responseInfo?.responseId;
    debugPrint('AdMobService: Ad response ID: $responseId');

    final completer = Completer<AdRewardResult>();
    String? transactionId;
    bool adCompleted = false;

    // Suppress session lock while the ad overlay is visible
    _sessionLockService.suppressLock();

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        debugPrint('AdMobService: Ad showed full screen content');
      },
      onAdImpression: (ad) {
        debugPrint('AdMobService: Ad impression recorded');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('AdMobService: Ad dismissed');
        _sessionLockService.unsuppressLock();
        ad.dispose();
        _rewardedAd = null;
        isAdReady.value = false;

        if (!completer.isCompleted) {
          if (adCompleted && transactionId != null) {
            completer.complete(AdRewardResult.success(
              // ignore: unnecessary_non_null_assertion
              transactionId: transactionId!,
              rewardAmount: AdMobConstants.adVideoTokenReward,
              rewardType: 'tokens',
              responseId: responseId,
            ));
          } else {
            completer.complete(AdRewardResult.failure('Ad was not completed'));
          }
        }

        // Pre-load next ad
        loadAdWithRetry();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint(
            'AdMobService: Ad failed to show: ${error.code} - ${error.message}');
        _sessionLockService.unsuppressLock();
        ad.dispose();
        _rewardedAd = null;
        isAdReady.value = false;

        if (!completer.isCompleted) {
          completer.complete(
              AdRewardResult.failure('Ad failed to show: ${error.message}'));
        }

        // Try to load next ad
        loadAdWithRetry();
      },
    );

    try {
      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          debugPrint(
              'AdMobService: User earned reward: ${reward.amount} ${reward.type}');
          adCompleted = true;
          // Generate a transaction ID matching SSV custom_data format
          transactionId =
              '${userId}_${DateTime.now().millisecondsSinceEpoch}';
          debugPrint('AdMobService: Transaction ID: $transactionId');
        },
      );
    } catch (e) {
      debugPrint('AdMobService: Error showing ad: $e');
      if (!completer.isCompleted) {
        completer.complete(AdRewardResult.failure('Error showing ad: $e'));
      }
    }

    return completer.future.timeout(
      AdMobConstants.adShowTimeout,
      onTimeout: () {
        debugPrint('AdMobService: Ad show timed out');
        return AdRewardResult.failure('Ad show timed out');
      },
    );
  }

  /// Check if an ad is ready to show
  bool get hasAdReady => _rewardedAd != null;

  /// Dispose of resources
  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    isAdReady.dispose();
    isLoading.dispose();
    currentAttempt.dispose();
  }
}
