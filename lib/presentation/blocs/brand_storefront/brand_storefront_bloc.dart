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
  }

  Future<void> _onLoadStorefront(
    _LoadStorefront event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _buyRepository.getBrandStorefront(event.id);
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (storefront) {
        emit(state.copyWith(
          isLoading: false,
          storefront: storefront,
        ));
        // Auto-load products and reviews
        add(BrandStorefrontEvent.loadProducts(storefront.brandId));
        add(BrandStorefrontEvent.loadReviews(storefront.brandId));
      },
    );
  }

  Future<void> _onLoadProducts(
    _LoadProducts event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    emit(state.copyWith(isLoadingProducts: true));

    final result = await _buyRepository.getBrandProducts(event.brandId);
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
    emit(state.copyWith(
      isSubmittingReview: true,
      reviewSubmitSuccess: false,
      errorMessage: null,
    ));

    final result = await _buyRepository.submitBrandReview(
      brandId: event.brandId,
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
        // Reload reviews to reflect the new submission
        add(BrandStorefrontEvent.loadReviews(event.brandId));
      },
    );
  }

  Future<void> _onClaimCoupon(
    _ClaimCoupon event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    if (state.isClaimingCoupon) return;
    if (state.claimedCouponIds.contains(event.couponId)) return;

    emit(state.copyWith(isClaimingCoupon: true, errorMessage: null));

    final result = await _buyRepository.claimStorefrontCoupon(
      storefrontId: event.storefrontId,
      couponId: event.couponId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isClaimingCoupon: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isClaimingCoupon: false,
        claimedCouponIds: {...state.claimedCouponIds, event.couponId},
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

  Future<void> _onToggleFollow(
    _ToggleFollow event,
    Emitter<BrandStorefrontState> emit,
  ) async {
    // Optimistic UI: toggle immediately
    emit(state.copyWith(isFollowing: !state.isFollowing));

    final result = await _buyRepository.toggleBrandFollow(event.brandId);

    result.fold(
      (failure) {
        // Revert on failure
        emit(state.copyWith(
          isFollowing: !state.isFollowing,
          errorMessage: failure.displayMessage,
        ));
      },
      (isFollowing) => emit(state.copyWith(isFollowing: isFollowing)),
    );
  }
}
