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
  int _loadGeneration = 0; // Incremented per load attempt to discard stale callbacks
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
  AdMobService(this._sessionLockService) : _useTestAds = false;

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
      return false;
    }

    if (_rewardedAd != null) {
      isAdReady.value = true; // Ensure state is consistent
      return true;
    }

    _isLoading = true;
    isLoading.value = true;

    // Capture generation so stale callbacks from timed-out loads are discarded
    final gen = ++_loadGeneration;
    final completer = Completer<bool>();

    try {
      await RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            if (gen != _loadGeneration) {
              // Stale callback from a previous timed-out load — dispose and ignore
              ad.dispose();
              return;
            }
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
            if (gen != _loadGeneration) {
              // Stale callback — ignore (don't reset isAdReady)
              return;
            }
            _isLoading = false;
            isLoading.value = false;
            // Only reset isAdReady if no ad is actually loaded
            if (_rewardedAd == null) {
              isAdReady.value = false;
            }
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
          _isLoading = false;
          isLoading.value = false;
          // Don't reset isAdReady — the callback may still fire and succeed
          return false;
        },
      );
    } catch (_) {
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
      // If a previous load succeeded while we were retrying, honour it
      if (_rewardedAd != null) {
        currentAttempt.value = 0;
        isAdReady.value = true;
        return true;
      }
      _loadRetryCount++;
      if (_loadRetryCount < AdMobConstants.maxLoadRetries) {
        // Exponential backoff: 2s, 4s, 8s, 16s
        final delay = AdMobConstants.initialRetryDelay * (1 << (_loadRetryCount - 1));
        // Keep isLoading true during the delay so the UI shows spinner
        isLoading.value = true;
        await Future.delayed(delay);
      }
    }
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

    // Capture response ID before showing (available after load)
    final responseId = _rewardedAd!.responseInfo?.responseId;

    final completer = Completer<AdRewardResult>();
    String? transactionId;
    bool adCompleted = false;

    // Suppress session lock while the ad overlay is visible
    _sessionLockService.suppressLock();

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {},
      onAdImpression: (_) {},
      onAdDismissedFullScreenContent: (ad) {
        _sessionLockService.unsuppressLock();
        ad.dispose();
        _rewardedAd = null;
        isAdReady.value = false;

        if (!completer.isCompleted) {
          if (adCompleted && transactionId != null) {
            completer.complete(AdRewardResult.success(
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
          adCompleted = true;
          // Generate a transaction ID matching SSV custom_data format
          transactionId =
              '${userId}_${DateTime.now().millisecondsSinceEpoch}';
        },
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(AdRewardResult.failure('Error showing ad: $e'));
      }
    }

    // Wait for dismiss callback, but don't let it hang forever.
    // The completer is resolved by onAdDismissedFullScreenContent or
    // onAdFailedToShowFullScreenContent. The timeout only fires if the
    // ad overlay stays visible for too long (e.g. interactive/playable
    // ads). When timeout fires, we do NOT return failure immediately —
    // we wait for the user to actually dismiss the ad so the overlay
    // is properly cleaned up. We just mark that a timeout occurred.
    return completer.future.timeout(
      AdMobConstants.adShowTimeout,
      onTimeout: () {
        // Don't return failure here. Instead, let the dismiss callback
        // handle it. The ad overlay is still on screen and the user
        // will eventually tap the close/back button which triggers
        // onAdDismissedFullScreenContent → completer.complete().
        //
        // If ad was already completed (reward earned) but user is just
        // slow to close, we should still treat it as success.
        if (adCompleted && transactionId != null) {
          return AdRewardResult.success(
            transactionId: transactionId!,
            rewardAmount: AdMobConstants.adVideoTokenReward,
            rewardType: 'tokens',
            responseId: responseId,
          );
        }
        // Reward not yet earned after timeout — fail gracefully.
        // Clean up the ad so the user isn't stuck.
        _sessionLockService.unsuppressLock();
        _rewardedAd?.dispose();
        _rewardedAd = null;
        isAdReady.value = false;
        loadAdWithRetry();
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
