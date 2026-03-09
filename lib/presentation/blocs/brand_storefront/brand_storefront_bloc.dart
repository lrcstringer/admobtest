import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
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
      (storefront) => emit(state.copyWith(
        isLoading: false,
        storefront: storefront,
      )),
    );
  }
}
