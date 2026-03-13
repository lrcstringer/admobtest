import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/brand_product.dart';
import 'package:imalichat/domain/entities/brand_review.dart';
import 'package:imalichat/domain/entities/brand_storefront.dart';
import 'package:imalichat/domain/repositories/buy_repository.dart';
import 'package:imalichat/presentation/blocs/brand_storefront/brand_storefront_bloc.dart';

class MockBuyRepository extends Mock implements BuyRepository {}

void main() {
  late MockBuyRepository mockRepo;

  setUp(() {
    mockRepo = MockBuyRepository();
  });

  BrandStorefrontBloc buildBloc() => BrandStorefrontBloc(mockRepo);

  final testStorefront = BrandStorefront(
    id: 'sf1',
    brandId: 'b1',
    brandName: 'Test Brand',
  );

  final testProducts = <BrandProduct>[
    BrandProduct(
      id: 'p1',
      brandId: 'b1',
      name: 'Product 1',
      priceZar: 10.0,
      priceTokens: 1000,
      fulfilmentType: FulfilmentType.digital,
      createdAt: DateTime(2026, 1, 1),
    ),
  ];

  final testReviews = <BrandReview>[
    BrandReview(
      id: 'r1',
      brandId: 'b1',
      userId: 'u1',
      userName: 'Test User',
      orderId: 'o1',
      qualityRating: 4,
      valueRating: 4,
      serviceRating: 4,
      overallRating: 4.0,
      createdAt: DateTime(2026, 1, 1),
    ),
  ];

  /// Helper: stubs all calls made by LoadStorefront's success path.
  void stubLoadStorefrontSuccess() {
    when(() => mockRepo.getBrandStorefront(any()))
        .thenAnswer((_) async => Right(testStorefront));
    when(() => mockRepo.getClaimedCouponIds(any()))
        .thenAnswer((_) async => const Right(<String>{}));
    when(() => mockRepo.getFollowStatus(any()))
        .thenAnswer((_) async => const Right(
              (isFollowing: false, followedAt: null),
            ));
    when(() => mockRepo.getBrandProducts(any()))
        .thenAnswer((_) async => const Right([]));
    when(() => mockRepo.getBrandReviews(any()))
        .thenAnswer((_) async => const Right([]));
  }

  group('BrandStorefrontBloc', () {
    // ---------------------------------------------------------------
    // Initial state
    // ---------------------------------------------------------------
    test('initial state has correct defaults', () {
      final bloc = buildBloc();
      final s = bloc.state;
      expect(s.isLoading, false);
      expect(s.storefront, isNull);
      expect(s.products, isEmpty);
      expect(s.reviews, isEmpty);
      expect(s.isLoadingProducts, false);
      expect(s.isLoadingReviews, false);
      expect(s.isSubmittingReview, false);
      expect(s.reviewSubmitSuccess, false);
      expect(s.isClaimingCoupon, false);
      expect(s.claimedCouponIds, isEmpty);
      expect(s.lastClaimedCouponCode, isNull);
      expect(s.isFollowing, false);
      expect(s.followedAt, isNull);
      expect(s.isTogglingFollow, false);
      expect(s.errorMessage, isNull);
      expect(s.eligibleReviewOrderId, isNull);
      bloc.close();
    });

    // ---------------------------------------------------------------
    // LoadStorefront
    // ---------------------------------------------------------------
    group('LoadStorefront', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits loading then loaded, auto-loads products/reviews/coupons/follow',
        build: () {
          stubLoadStorefrontSuccess();
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadStorefront('sf1')),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // 1) loading
          isA<BrandStorefrontState>()
              .having((s) => s.isLoading, 'isLoading', true),
          // 2) storefront loaded
          isA<BrandStorefrontState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.storefront, 'storefront', testStorefront),
          // 3-6) claimed coupons, follow status, products, reviews
          isA<BrandStorefrontState>(),
          isA<BrandStorefrontState>(),
          isA<BrandStorefrontState>(),
          isA<BrandStorefrontState>(),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'stores eligibleReviewOrderId when orderId is provided',
        build: () {
          stubLoadStorefrontSuccess();
          return buildBloc();
        },
        act: (bloc) => bloc.add(
          const BrandStorefrontEvent.loadStorefront('sf1', orderId: 'order99'),
        ),
        wait: const Duration(milliseconds: 100),
        verify: (bloc) {
          expect(bloc.state.eligibleReviewOrderId, 'order99');
        },
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits error when getBrandStorefront fails',
        build: () {
          when(() => mockRepo.getBrandStorefront(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadStorefront('sf1')),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'tolerates getClaimedCouponIds failure (non-critical)',
        build: () {
          when(() => mockRepo.getBrandStorefront(any()))
              .thenAnswer((_) async => Right(testStorefront));
          when(() => mockRepo.getClaimedCouponIds(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          when(() => mockRepo.getFollowStatus(any()))
              .thenAnswer((_) async => const Right(
                    (isFollowing: false, followedAt: null),
                  ));
          when(() => mockRepo.getBrandProducts(any()))
              .thenAnswer((_) async => const Right([]));
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadStorefront('sf1')),
        wait: const Duration(milliseconds: 100),
        verify: (bloc) {
          // Storefront still loaded despite coupon fetch failure
          expect(bloc.state.storefront, testStorefront);
          expect(bloc.state.claimedCouponIds, isEmpty);
        },
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'tolerates getFollowStatus failure (non-critical)',
        build: () {
          when(() => mockRepo.getBrandStorefront(any()))
              .thenAnswer((_) async => Right(testStorefront));
          when(() => mockRepo.getClaimedCouponIds(any()))
              .thenAnswer((_) async => const Right(<String>{}));
          when(() => mockRepo.getFollowStatus(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          when(() => mockRepo.getBrandProducts(any()))
              .thenAnswer((_) async => const Right([]));
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadStorefront('sf1')),
        wait: const Duration(milliseconds: 100),
        verify: (bloc) {
          expect(bloc.state.storefront, testStorefront);
          expect(bloc.state.isFollowing, false);
        },
      );
    });

    // ---------------------------------------------------------------
    // LoadProducts
    // ---------------------------------------------------------------
    group('LoadProducts', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits loading then products on success',
        build: () {
          when(() => mockRepo.getBrandProducts(any()))
              .thenAnswer((_) async => Right(testProducts));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadProducts('b1')),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingProducts, 'isLoadingProducts', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingProducts, 'isLoadingProducts', false)
              .having((s) => s.products, 'products', testProducts),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits loading then stops loading on failure (no products set)',
        build: () {
          when(() => mockRepo.getBrandProducts(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadProducts('b1')),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingProducts, 'isLoadingProducts', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingProducts, 'isLoadingProducts', false)
              .having((s) => s.products, 'products', isEmpty),
        ],
      );
    });

    // ---------------------------------------------------------------
    // LoadReviews
    // ---------------------------------------------------------------
    group('LoadReviews', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits loading then reviews on success',
        build: () {
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => Right(testReviews));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadReviews('b1')),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', false)
              .having((s) => s.reviews, 'reviews', testReviews),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits loading then stops loading on failure (no reviews set)',
        build: () {
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.loadReviews('b1')),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', false)
              .having((s) => s.reviews, 'reviews', isEmpty),
        ],
      );
    });

    // ---------------------------------------------------------------
    // SubmitReview
    // ---------------------------------------------------------------
    group('SubmitReview', () {
      const validReview = BrandStorefrontEvent.submitReview(
        brandId: 'b1',
        orderId: 'order1',
        qualityRating: 4,
        valueRating: 5,
        serviceRating: 3,
        comment: 'Great!',
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'double-submit guard: no-op when isSubmittingReview is true',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(isSubmittingReview: true),
        act: (bloc) => bloc.add(validReview),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'prevents re-submit after prior success',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(reviewSubmitSuccess: true),
        act: (bloc) => bloc.add(validReview),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('already')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'validation error when qualityRating < 1',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 0,
          valueRating: 5,
          serviceRating: 3,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('rate all three')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'validation error when valueRating < 1',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 3,
          valueRating: 0,
          serviceRating: 3,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('rate all three')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'validation error when serviceRating < 1',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 3,
          valueRating: 4,
          serviceRating: 0,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('rate all three')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'validation error when qualityRating > 5',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 6,
          valueRating: 3,
          serviceRating: 3,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('between 1 and 5')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'validation error when valueRating > 5',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 3,
          valueRating: 7,
          serviceRating: 3,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('between 1 and 5')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'validation error when serviceRating > 5',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 3,
          valueRating: 3,
          serviceRating: 10,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('between 1 and 5')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'success path: submits, sets reviewSubmitSuccess, triggers reload',
        build: () {
          when(() => mockRepo.submitBrandReview(
                brandId: any(named: 'brandId'),
                orderId: any(named: 'orderId'),
                qualityRating: any(named: 'qualityRating'),
                valueRating: any(named: 'valueRating'),
                serviceRating: any(named: 'serviceRating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Right(null));
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(validReview),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // submitting
          isA<BrandStorefrontState>()
              .having(
                  (s) => s.isSubmittingReview, 'isSubmittingReview', true)
              .having(
                  (s) => s.reviewSubmitSuccess, 'reviewSubmitSuccess', false)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          // success
          isA<BrandStorefrontState>()
              .having(
                  (s) => s.isSubmittingReview, 'isSubmittingReview', false)
              .having(
                  (s) => s.reviewSubmitSuccess, 'reviewSubmitSuccess', true),
          // auto-reload reviews triggers loadReviews states
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', false),
        ],
        verify: (bloc) {
          verify(() => mockRepo.submitBrandReview(
                brandId: 'b1',
                orderId: 'order1',
                qualityRating: 4,
                valueRating: 5,
                serviceRating: 3,
                comment: 'Great!',
              )).called(1);
        },
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'success path with storefront loaded triggers loadStorefront reload',
        build: () {
          when(() => mockRepo.submitBrandReview(
                brandId: any(named: 'brandId'),
                orderId: any(named: 'orderId'),
                qualityRating: any(named: 'qualityRating'),
                valueRating: any(named: 'valueRating'),
                serviceRating: any(named: 'serviceRating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Right(null));
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          stubLoadStorefrontSuccess();
          return buildBloc();
        },
        seed: () => BrandStorefrontState(storefront: testStorefront),
        act: (bloc) => bloc.add(validReview),
        wait: const Duration(milliseconds: 200),
        verify: (bloc) {
          // loadStorefront was called as a reload
          verify(() => mockRepo.getBrandStorefront('sf1')).called(1);
        },
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'failure path: sets error message, clears isSubmittingReview',
        build: () {
          when(() => mockRepo.submitBrandReview(
                brandId: any(named: 'brandId'),
                orderId: any(named: 'orderId'),
                qualityRating: any(named: 'qualityRating'),
                valueRating: any(named: 'valueRating'),
                serviceRating: any(named: 'serviceRating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(validReview),
        expect: () => [
          isA<BrandStorefrontState>()
              .having(
                  (s) => s.isSubmittingReview, 'isSubmittingReview', true),
          isA<BrandStorefrontState>()
              .having(
                  (s) => s.isSubmittingReview, 'isSubmittingReview', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'comment is optional (null allowed)',
        build: () {
          when(() => mockRepo.submitBrandReview(
                brandId: any(named: 'brandId'),
                orderId: any(named: 'orderId'),
                qualityRating: any(named: 'qualityRating'),
                valueRating: any(named: 'valueRating'),
                serviceRating: any(named: 'serviceRating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Right(null));
          when(() => mockRepo.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 3,
          valueRating: 3,
          serviceRating: 3,
        )),
        wait: const Duration(milliseconds: 100),
        verify: (bloc) {
          verify(() => mockRepo.submitBrandReview(
                brandId: 'b1',
                orderId: 'order1',
                qualityRating: 3,
                valueRating: 3,
                serviceRating: 3,
                comment: null,
              )).called(1);
        },
      );
    });

    // ---------------------------------------------------------------
    // ClaimCoupon
    // ---------------------------------------------------------------
    group('ClaimCoupon', () {
      const claimEvent = BrandStorefrontEvent.claimCoupon(
        storefrontId: 'sf1',
        couponId: 'c1',
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'double-submit guard: no-op when isClaimingCoupon is true',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(isClaimingCoupon: true),
        act: (bloc) => bloc.add(claimEvent),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'no-op when coupon already claimed',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(claimedCouponIds: {'c1'}),
        act: (bloc) => bloc.add(claimEvent),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'success: optimistic add, then sets lastClaimedCouponCode',
        build: () {
          when(() => mockRepo.claimStorefrontCoupon(
                storefrontId: any(named: 'storefrontId'),
                couponId: any(named: 'couponId'),
                couponCode: any(named: 'couponCode'),
              )).thenAnswer((_) async => const Right('CODE123'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(claimEvent),
        expect: () => [
          // Optimistic: coupon ID added immediately
          isA<BrandStorefrontState>()
              .having((s) => s.isClaimingCoupon, 'isClaimingCoupon', true)
              .having((s) => s.claimedCouponIds, 'claimedCouponIds',
                  contains('c1'))
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          // Success: code returned
          isA<BrandStorefrontState>()
              .having((s) => s.isClaimingCoupon, 'isClaimingCoupon', false)
              .having((s) => s.lastClaimedCouponCode, 'lastClaimedCouponCode',
                  'CODE123')
              .having((s) => s.claimedCouponIds, 'claimedCouponIds',
                  contains('c1')),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'failure: optimistic add then revert, sets error',
        build: () {
          when(() => mockRepo.claimStorefrontCoupon(
                storefrontId: any(named: 'storefrontId'),
                couponId: any(named: 'couponId'),
                couponCode: any(named: 'couponCode'),
              )).thenAnswer(
              (_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(claimEvent),
        expect: () => [
          // Optimistic: coupon added
          isA<BrandStorefrontState>()
              .having((s) => s.isClaimingCoupon, 'isClaimingCoupon', true)
              .having((s) => s.claimedCouponIds, 'claimedCouponIds',
                  contains('c1')),
          // Reverted: coupon removed, error set
          isA<BrandStorefrontState>()
              .having((s) => s.isClaimingCoupon, 'isClaimingCoupon', false)
              .having((s) => s.claimedCouponIds, 'claimedCouponIds',
                  isNot(contains('c1')))
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'failure revert preserves other claimed coupon IDs',
        build: () {
          when(() => mockRepo.claimStorefrontCoupon(
                storefrontId: any(named: 'storefrontId'),
                couponId: any(named: 'couponId'),
                couponCode: any(named: 'couponCode'),
              )).thenAnswer(
              (_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => const BrandStorefrontState(
          claimedCouponIds: {'existing1', 'existing2'},
        ),
        act: (bloc) => bloc.add(claimEvent),
        verify: (bloc) {
          // After revert, the original coupon IDs are still there
          expect(bloc.state.claimedCouponIds, contains('existing1'));
          expect(bloc.state.claimedCouponIds, contains('existing2'));
          expect(bloc.state.claimedCouponIds, isNot(contains('c1')));
        },
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'passes couponCode to repository when provided',
        build: () {
          when(() => mockRepo.claimStorefrontCoupon(
                storefrontId: any(named: 'storefrontId'),
                couponId: any(named: 'couponId'),
                couponCode: any(named: 'couponCode'),
              )).thenAnswer((_) async => const Right('CODE123'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.claimCoupon(
          storefrontId: 'sf1',
          couponId: 'c1',
          couponCode: 'PROMO',
        )),
        verify: (_) {
          verify(() => mockRepo.claimStorefrontCoupon(
                storefrontId: 'sf1',
                couponId: 'c1',
                couponCode: 'PROMO',
              )).called(1);
        },
      );
    });

    // ---------------------------------------------------------------
    // RecordView
    // ---------------------------------------------------------------
    group('RecordView', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'fire-and-forget: calls repository, emits no state changes',
        build: () {
          when(() => mockRepo.recordStorefrontView(any()))
              .thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.recordView('sf1')),
        expect: () => [],
        verify: (_) {
          verify(() => mockRepo.recordStorefrontView('sf1')).called(1);
        },
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'fire-and-forget: emits no state changes even on failure',
        build: () {
          when(() => mockRepo.recordStorefrontView(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.recordView('sf1')),
        expect: () => [],
      );
    });

    // ---------------------------------------------------------------
    // ToggleFollow
    // ---------------------------------------------------------------
    group('ToggleFollow', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'guard: no-op when isTogglingFollow is true',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(isTogglingFollow: true),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.toggleFollow('b1')),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'success: follow (false -> true), sets isFollowing from server',
        build: () {
          when(() => mockRepo.toggleBrandFollow(any()))
              .thenAnswer((_) async => const Right(true));
          return buildBloc();
        },
        seed: () => const BrandStorefrontState(isFollowing: false),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.toggleFollow('b1')),
        expect: () => [
          // Optimistic: toggled to true, isTogglingFollow true
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', true)
              .having((s) => s.isTogglingFollow, 'isTogglingFollow', true)
              .having((s) => s.followedAt, 'followedAt', isNotNull),
          // Server confirms: isFollowing true, isTogglingFollow false
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', true)
              .having((s) => s.isTogglingFollow, 'isTogglingFollow', false),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'success: unfollow (true -> false), clears followedAt',
        build: () {
          when(() => mockRepo.toggleBrandFollow(any()))
              .thenAnswer((_) async => const Right(false));
          return buildBloc();
        },
        seed: () => BrandStorefrontState(
          isFollowing: true,
          followedAt: DateTime(2026, 1, 1),
        ),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.toggleFollow('b1')),
        expect: () => [
          // Optimistic: toggled to false, followedAt cleared
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', false)
              .having((s) => s.isTogglingFollow, 'isTogglingFollow', true)
              .having((s) => s.followedAt, 'followedAt', isNull),
          // Server confirms: false
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', false)
              .having((s) => s.isTogglingFollow, 'isTogglingFollow', false)
              .having((s) => s.followedAt, 'followedAt', isNull),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'failure: optimistic toggle reverted, error set',
        build: () {
          when(() => mockRepo.toggleBrandFollow(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => const BrandStorefrontState(isFollowing: false),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.toggleFollow('b1')),
        expect: () => [
          // Optimistic: toggled to true
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', true),
          // Revert: back to false, error set
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', false)
              .having((s) => s.isTogglingFollow, 'isTogglingFollow', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'failure revert restores original followedAt',
        build: () {
          when(() => mockRepo.toggleBrandFollow(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => BrandStorefrontState(
          isFollowing: true,
          followedAt: DateTime(2026, 1, 15),
        ),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.toggleFollow('b1')),
        verify: (bloc) {
          // After revert, original followedAt is restored
          expect(bloc.state.isFollowing, true);
          expect(bloc.state.followedAt, DateTime(2026, 1, 15));
          expect(bloc.state.isTogglingFollow, false);
        },
      );
    });

    // ---------------------------------------------------------------
    // ResetReviewState
    // ---------------------------------------------------------------
    group('ResetReviewState', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'clears reviewSubmitSuccess',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(reviewSubmitSuccess: true),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.resetReviewState()),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.reviewSubmitSuccess, 'reviewSubmitSuccess',
                  false),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'no-op state change when reviewSubmitSuccess is already false',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(reviewSubmitSuccess: false),
        act: (bloc) =>
            bloc.add(const BrandStorefrontEvent.resetReviewState()),
        // Freezed copyWith with same value still emits (bloc_test dedupes
        // identical states via ==), so this should emit nothing because the
        // state is equal to the seed.
        expect: () => [],
      );
    });
  });
}
