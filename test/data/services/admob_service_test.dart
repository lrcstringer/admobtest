import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/data/services/admob_service.dart';

// Mock classes
class MockRewardedAd extends Mock implements RewardedAd {}

class FakeAdRequest extends Fake implements AdRequest {}

class FakeRewardedAdLoadCallback extends Fake
    implements RewardedAdLoadCallback {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdRewardResult', () {
    test('success factory creates successful result', () {
      final result = AdRewardResult.success(
        transactionId: 'txn_123',
        rewardAmount: 5,
        rewardType: 'tokens',
      );

      expect(result.success, isTrue);
      expect(result.transactionId, 'txn_123');
      expect(result.rewardAmount, 5);
      expect(result.rewardType, 'tokens');
      expect(result.errorMessage, isNull);
    });

    test('failure factory creates failed result', () {
      final result = AdRewardResult.failure('Ad failed to load');

      expect(result.success, isFalse);
      expect(result.errorMessage, 'Ad failed to load');
      expect(result.transactionId, isNull);
      expect(result.rewardAmount, isNull);
      expect(result.rewardType, isNull);
    });

    test('constructor allows custom values', () {
      const result = AdRewardResult(
        success: true,
        transactionId: 'custom_txn',
        rewardAmount: 10,
        rewardType: 'coins',
        errorMessage: null,
      );

      expect(result.success, isTrue);
      expect(result.transactionId, 'custom_txn');
      expect(result.rewardAmount, 10);
      expect(result.rewardType, 'coins');
    });
  });

  group('AdMobService', () {
    late AdMobService adMobService;

    setUp(() {
      adMobService = AdMobService.withTestAds();
    });

    tearDown(() {
      adMobService.dispose();
    });

    test('initializes with correct default state', () {
      expect(adMobService.hasAdReady, isFalse);
      expect(adMobService.isAdReady.value, isFalse);
      expect(adMobService.isLoading.value, isFalse);
    });

    test('isAdReady ValueNotifier updates correctly', () {
      final values = <bool>[];
      adMobService.isAdReady.addListener(() {
        values.add(adMobService.isAdReady.value);
      });

      // Simulate state changes (would normally happen from ad callbacks)
      adMobService.isAdReady.value = true;
      adMobService.isAdReady.value = false;

      expect(values, [true, false]);
    });

    test('isLoading ValueNotifier updates correctly', () {
      final values = <bool>[];
      adMobService.isLoading.addListener(() {
        values.add(adMobService.isLoading.value);
      });

      adMobService.isLoading.value = true;
      adMobService.isLoading.value = false;

      expect(values, [true, false]);
    });

    test('dispose cleans up ValueNotifiers', () {
      final service = AdMobService.withTestAds();
      service.dispose();

      // After dispose, adding listeners should throw
      expect(
        () => service.isAdReady.addListener(() {}),
        throwsA(isA<FlutterError>()),
      );
      expect(
        () => service.isLoading.addListener(() {}),
        throwsA(isA<FlutterError>()),
      );
    });

    test('hasAdReady returns false when no ad is loaded', () {
      expect(adMobService.hasAdReady, isFalse);
    });

    group('showAd', () {
      test('returns failure when no ad is loaded', () async {
        final result = await adMobService.showAd(userId: 'user123');

        expect(result.success, isFalse);
        expect(result.errorMessage, 'No ad loaded');
      });
    });

    group('loadAd', () {
      test('returns false when already loading', () async {
        // Start first load
        final firstLoadFuture = adMobService.loadAd();

        // Second load should return false immediately
        final secondLoadResult = await adMobService.loadAd();

        expect(secondLoadResult, isFalse);

        // Clean up first load (it will timeout or fail)
        await firstLoadFuture.timeout(
          const Duration(milliseconds: 100),
          onTimeout: () => false,
        );
      });
    });
  });

  group('AdRewardResult equality', () {
    test('two success results with same values are logically equivalent', () {
      final result1 = AdRewardResult.success(
        transactionId: 'txn_1',
        rewardAmount: 5,
        rewardType: 'tokens',
      );

      final result2 = AdRewardResult.success(
        transactionId: 'txn_1',
        rewardAmount: 5,
        rewardType: 'tokens',
      );

      expect(result1.success, result2.success);
      expect(result1.transactionId, result2.transactionId);
      expect(result1.rewardAmount, result2.rewardAmount);
      expect(result1.rewardType, result2.rewardType);
    });

    test('failure results with different messages are distinguishable', () {
      final result1 = AdRewardResult.failure('Error 1');
      final result2 = AdRewardResult.failure('Error 2');

      expect(result1.errorMessage, isNot(result2.errorMessage));
    });
  });
}
