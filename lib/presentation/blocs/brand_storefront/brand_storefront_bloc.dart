import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/brand_product.dart';
import '../../../domain/entities/brand_review.dart';
import '../../../domain/entities/brand_storefront.dart';
import '../../../domain/repositories/buy_repository.dart';

part 'brand_storefront_event.dart';
part 'brand_storefront_state.dart';
part 'brand_storefront_bloc.freezed.dart';

@injectable
class BrandStorefrontBloc
    extends Bloc<BrandStorefrontEvent, BrandStorefrontState> {
  final BuyRepository _buyRepository;

  BrandStorefrontBloc(this._buyRepository)
      : super(const BrandStorefrontState()) {
    on<_LoadStorefront>(_onLoadStorefront);
    on<_LoadProducts>(_onLoadProducts);
    on<_LoadReviews>(_onLoadReviews);
    on<_SubmitReview>(_onSubmitReview);
    on<_ClaimCoupon>(_onClaimCoupon);
    on<_RecordView>(_onRecordView);
    on<_ToggleFollow>(_onToggleFollow);
    on<_ResetReviewState>(_onResetReviewState);
  }

  Future<void> _onLoadStorefront(
    _LoadStorefront event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      eligibleReviewOrderId: event.orderId,
    ));

    final result = await _buyRepository.getBrandStorefront(event.id);

    final storefront = result.fold<BrandStorefront?>(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
        return null;
      },
      (storefront) {
        emit(state.copyWith(
          isLoading: false,
          storefront: storefront,
        ));
        // Auto-load products and reviews via events
        add(BrandStorefrontEvent.loadProducts(storefront.id));
        add(BrandStorefrontEvent.loadReviews(storefront.brandId));
        return storefront;
      },
    );

    // Hydrate claimed coupons and follow status after fold completes
    if (storefront != null) {
      final claimedResult =
          await _buyRepository.getClaimedCouponIds(event.id);
      claimedResult.fold(
        (_) {}, // Non-critical — keep empty set
        (ids) => emit(state.copyWith(claimedCouponIds: ids)),
      );

      // Hydrate follow status (including followedAt) from server
      final followResult =
          await _buyRepository.getFollowStatus(storefront.brandId);
      followResult.fold(
        (_) {}, // Non-critical — default false
        (status) => emit(state.copyWith(
          isFollowing: status.isFollowing,
          followedAt: status.followedAt,
        )),
      );
    }
  }

  Future<void> _onLoadProducts(
    _LoadProducts event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    emit(state.copyWith(isLoadingProducts: true));

    final result = await _buyRepository.getBrandProducts(event.storefrontId);
    result.fold(
      (_) => emit(state.copyWith(isLoadingProducts: false)),
      (products) => emit(state.copyWith(
        isLoadingProducts: false,
        products: products,
      )),
    );
  }

  Future<void> _onLoadReviews(
    _LoadReviews event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    emit(state.copyWith(isLoadingReviews: true));

    final result = await _buyRepository.getBrandReviews(event.brandId);
    result.fold(
      (_) => emit(state.copyWith(isLoadingReviews: false)),
      (reviews) => emit(state.copyWith(
        isLoadingReviews: false,
        reviews: reviews,
      )),
    );
  }

  Future<void> _onSubmitReview(
    _SubmitReview event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    if (state.isSubmittingReview) return;

    // Prevent double-submit within the same session
    if (state.reviewSubmitSuccess) {
      emit(state.copyWith(
        errorMessage: 'You have already submitted a review',
      ));
      return;
    }

    // Validate all 3 rating dimensions are explicitly set (not default 0)
    final hasAllRatings = event.qualityRating >= 1 &&
        event.valueRating >= 1 &&
        event.serviceRating >= 1;
    if (!hasAllRatings) {
      emit(state.copyWith(
        isSubmittingReview: false,
        errorMessage: 'Please rate all three categories before submitting',
      ));
      return;
    }

    // Validate ratings are within 1-5 range
    if (event.qualityRating > 5 ||
        event.valueRating > 5 ||
        event.serviceRating > 5) {
      emit(state.copyWith(
        isSubmittingReview: false,
        errorMessage: 'All ratings must be between 1 and 5',
      ));
      return;
    }

    emit(state.copyWith(
      isSubmittingReview: true,
      reviewSubmitSuccess: false,
      errorMessage: null,
    ));

    final result = await _buyRepository.submitBrandReview(
      brandId: event.brandId,
      orderId: event.orderId,
      qualityRating: event.qualityRating,
      valueRating: event.valueRating,
      serviceRating: event.serviceRating,
      comment: event.comment,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSubmittingReview: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isSubmittingReview: false,
          reviewSubmitSuccess: true,
        ));
        // Reload reviews and storefront to reflect the new submission
        add(BrandStorefrontEvent.loadReviews(event.brandId));
        if (state.storefront != null) {
          add(BrandStorefrontEvent.loadStorefront(state.storefront!.id));
        }
      },
    );
  }

  Future<void> _onClaimCoupon(
    _ClaimCoupon event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    if (state.isClaimingCoupon) return;
    if (state.claimedCouponIds.contains(event.couponId)) return;

    // Optimistic: add coupon ID immediately to prevent double-claim on rapid taps
    emit(state.copyWith(
      isClaimingCoupon: true,
      errorMessage: null,
      claimedCouponIds: {...state.claimedCouponIds, event.couponId},
    ));

    final result = await _buyRepository.claimStorefrontCoupon(
      storefrontId: event.storefrontId,
      couponId: event.couponId,
      couponCode: event.couponCode,
    );

    result.fold(
      (failure) {
        // Revert optimistic add on failure
        final reverted = Set<String>.from(state.claimedCouponIds)
          ..remove(event.couponId);
        emit(state.copyWith(
          isClaimingCoupon: false,
          claimedCouponIds: reverted,
          errorMessage: failure.displayMessage,
        ));
      },
      (couponCode) => emit(state.copyWith(
        isClaimingCoupon: false,
        lastClaimedCouponCode: couponCode,
      )),
    );
  }

  Future<void> _onRecordView(
    _RecordView event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    // Fire-and-forget — no state changes needed
    await _buyRepository.recordStorefrontView(event.storefrontId);
  }

  void _onResetReviewState(
    _ResetReviewState event,
    Emitter<BrandStorefrontState> emit,
  ) {
    emit(state.copyWith(reviewSubmitSuccess: false));
  }

  Future<void> _onToggleFollow(
    _ToggleFollow event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    if (state.isTogglingFollow) return;

    // Save original state for revert
    final originalIsFollowing = state.isFollowing;
    final originalFollowedAt = state.followedAt;

    // Optimistic UI: toggle immediately
    emit(state.copyWith(
      isFollowing: !originalIsFollowing,
      // Clear followedAt when unfollowing, set to now when following
      followedAt: originalIsFollowing ? null : DateTime.now(),
      isTogglingFollow: true,
    ));

    final result = await _buyRepository.toggleBrandFollow(event.brandId);

    result.fold(
      (failure) {
        // Revert on failure — restore original followedAt
        emit(state.copyWith(
          isFollowing: originalIsFollowing,
          followedAt: originalFollowedAt,
          isTogglingFollow: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (isFollowing) => emit(state.copyWith(
        isFollowing: isFollowing,
        // If now following, keep the optimistic timestamp; if unfollowed, clear it
        followedAt: isFollowing ? (originalFollowedAt ?? state.followedAt) : null,
        isTogglingFollow: false,
      )),
    );
  }
}
