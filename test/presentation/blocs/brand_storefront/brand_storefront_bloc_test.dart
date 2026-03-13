import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/brand_storefront.dart';
import 'package:imalichat/domain/repositories/buy_repository.dart';
import 'package:imalichat/presentation/blocs/brand_storefront/brand_storefront_bloc.dart';

class MockBuyRepository extends Mock implements BuyRepository {}

void main() {
  late MockBuyRepository mockBuyRepository;

  setUp(() {
    mockBuyRepository = MockBuyRepository();
  });

  BrandStorefrontBloc buildBloc() => BrandStorefrontBloc(mockBuyRepository);

  final testStorefront = BrandStorefront(
    id: 'sf1',
    brandId: 'b1',
    brandName: 'Test Brand',
  );

  group('BrandStorefrontBloc', () {
    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.storefront, isNull);
      expect(bloc.state.products, isEmpty);
      expect(bloc.state.reviews, isEmpty);
      expect(bloc.state.isFollowing, false);
      bloc.close();
    });

    group('LoadStorefront', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits [loading, loaded] and auto-loads products/reviews on success',
        build: () {
          when(() => mockBuyRepository.getBrandStorefront(any()))
              .thenAnswer((_) async => Right(testStorefront));
          when(() => mockBuyRepository.getClaimedCouponIds(any()))
              .thenAnswer((_) async => const Right(<String>{}));
          when(() => mockBuyRepository.getFollowStatus(any()))
              .thenAnswer((_) async => const Right(
                    (isFollowing: false, followedAt: null),
                  ));
          when(() => mockBuyRepository.getBrandProducts(any()))
              .thenAnswer((_) async => const Right([]));
          when(() => mockBuyRepository.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.loadStorefront('sf1')),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<BrandStorefrontState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.storefront, 'storefront', isNotNull),
          // Follow-up states from auto-loaded products, reviews, claimed coupons, follow status
          isA<BrandStorefrontState>(),
          isA<BrandStorefrontState>(),
          isA<BrandStorefrontState>(),
          isA<BrandStorefrontState>(),
        ],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits error when load fails',
        build: () {
          when(() => mockBuyRepository.getBrandStorefront(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.loadStorefront('sf1')),
        expect: () => [
          isA<BrandStorefrontState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadProducts', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits products when loaded successfully',
        build: () {
          when(() => mockBuyRepository.getBrandProducts(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.loadProducts('b1')),
        expect: () => [
          isA<BrandStorefrontState>().having((s) => s.isLoadingProducts, 'isLoadingProducts', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingProducts, 'isLoadingProducts', false)
              .having((s) => s.products, 'products', isEmpty),
        ],
      );
    });

    group('LoadReviews', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'emits reviews when loaded successfully',
        build: () {
          when(() => mockBuyRepository.getBrandReviews(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.loadReviews('b1')),
        expect: () => [
          isA<BrandStorefrontState>().having((s) => s.isLoadingReviews, 'isLoadingReviews', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isLoadingReviews, 'isLoadingReviews', false)
              .having((s) => s.reviews, 'reviews', isEmpty),
        ],
      );
    });

    group('SubmitReview', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'double-submit guard prevents concurrent submissions',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(isSubmittingReview: true),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 5,
          valueRating: 5,
          serviceRating: 5,
        )),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'prevents re-submit after success',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(reviewSubmitSuccess: true),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.submitReview(
          brandId: 'b1',
          orderId: 'order1',
          qualityRating: 5,
          valueRating: 5,
          serviceRating: 5,
        )),
        expect: () => [
          isA<BrandStorefrontState>()
              .having((s) => s.errorMessage, 'errorMessage', contains('already')),
        ],
      );
    });

    group('ClaimCoupon', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'double-submit guard prevents concurrent claims',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(isClaimingCoupon: true),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.claimCoupon(
          storefrontId: 'sf1',
          couponId: 'c1',
        )),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'prevents claiming already claimed coupon',
        build: () => buildBloc(),
        seed: () => const BrandStorefrontState(claimedCouponIds: {'c1'}),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.claimCoupon(
          storefrontId: 'sf1',
          couponId: 'c1',
        )),
        expect: () => [],
      );

      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'claims coupon successfully',
        build: () {
          when(() => mockBuyRepository.claimStorefrontCoupon(
            storefrontId: any(named: 'storefrontId'),
            couponId: any(named: 'couponId'),
          )).thenAnswer((_) async => const Right('code123'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BrandStorefrontEvent.claimCoupon(
          storefrontId: 'sf1',
          couponId: 'c1',
        )),
        expect: () => [
          isA<BrandStorefrontState>().having((s) => s.isClaimingCoupon, 'isClaimingCoupon', true),
          isA<BrandStorefrontState>()
              .having((s) => s.isClaimingCoupon, 'isClaimingCoupon', false)
              .having((s) => s.claimedCouponIds, 'claimedCouponIds', contains('c1')),
        ],
      );
    });

    group('ToggleFollow', () {
      blocTest<BrandStorefrontBloc, BrandStorefrontState>(
        'optimistically toggles and reverts on failure',
        build: () {
          when(() => mockBuyRepository.toggleBrandFollow(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => const BrandStorefrontState(isFollowing: false),
        act: (bloc) => bloc.add(const BrandStorefrontEvent.toggleFollow('b1')),
        expect: () => [
          // Optimistic toggle to true
          isA<BrandStorefrontState>().having((s) => s.isFollowing, 'isFollowing', true),
          // Revert on failure
          isA<BrandStorefrontState>()
              .having((s) => s.isFollowing, 'isFollowing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });
  });
}
