import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/admob_constants.dart';

/// Result of showing a rewarded ad
class AdRewardResult {
  final bool success;
  final String? transactionId;
  final int? rewardAmount;
  final String? rewardType;
  final String? errorMessage;

  const AdRewardResult({
    required this.success,
    this.transactionId,
    this.rewardAmount,
    this.rewardType,
    this.errorMessage,
  });

  factory AdRewardResult.success({
    required String transactionId,
    required int rewardAmount,
    required String rewardType,
  }) {
    return AdRewardResult(
      success: true,
      transactionId: transactionId,
      rewardAmount: rewardAmount,
      rewardType: rewardType,
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

  /// Callback for when ad loading state changes
  final ValueNotifier<bool> isAdReady = ValueNotifier(false);

  /// Callback for when ad is loading
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  AdMobService({bool useTestAds = kDebugMode}) : _useTestAds = useTestAds;

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

  /// Load ad with retry logic
  Future<bool> loadAdWithRetry() async {
    while (_loadRetryCount < AdMobConstants.maxLoadRetries) {
      final success = await loadAd();
      if (success) {
        return true;
      }
      _loadRetryCount++;
      if (_loadRetryCount < AdMobConstants.maxLoadRetries) {
        debugPrint(
            'AdMobService: Retrying ad load ($_loadRetryCount/${AdMobConstants.maxLoadRetries})');
        await Future.delayed(AdMobConstants.retryDelay);
      }
    }
    debugPrint('AdMobService: All retry attempts failed');
    _loadRetryCount = 0;
    return false;
  }

  /// Show the loaded rewarded ad
  /// Returns AdRewardResult with transaction ID if successful
  Future<AdRewardResult> showAd({required String userId}) async {
    if (_rewardedAd == null) {
      return AdRewardResult.failure('No ad loaded');
    }

    final completer = Completer<AdRewardResult>();
    String? transactionId;
    bool adCompleted = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        debugPrint('AdMobService: Ad showed full screen content');
      },
      onAdImpression: (ad) {
        debugPrint('AdMobService: Ad impression recorded');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('AdMobService: Ad dismissed');
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
          // Generate a transaction ID for tracking (includes userId for SSV)
          transactionId =
              'admob_${userId}_${DateTime.now().millisecondsSinceEpoch}';
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
  }
}
