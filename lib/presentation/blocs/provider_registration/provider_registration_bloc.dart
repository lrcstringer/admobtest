import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/enums/marketplace_category.dart';
import '../../../domain/repositories/marketplace_repository.dart';

part 'provider_registration_bloc.freezed.dart';
part 'provider_registration_event.dart';
part 'provider_registration_state.dart';

/// Locally provided BLoC for the 3-step provider registration flow.
/// Not registered in app.dart — created via BlocProvider at screen level.
@injectable
class ProviderRegistrationBloc
    extends Bloc<ProviderRegistrationEvent, ProviderRegistrationState> {
  final MarketplaceRepository _repository;

  ProviderRegistrationBloc(this._repository)
      : super(const ProviderRegistrationState()) {
    on<_UpdateName>(_onUpdateName);
    on<_UpdateBio>(_onUpdateBio);
    on<_UpdateServices>(_onUpdateServices);
    on<_UpdateCategory>(_onUpdateCategory);
    on<_SetPhoto>(_onSetPhoto);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_Submit>(_onSubmit);
  }

  void _onUpdateName(_UpdateName event, Emitter<ProviderRegistrationState> emit) {
    emit(state.copyWith(displayName: event.name, errorMessage: null));
  }

  void _onUpdateBio(_UpdateBio event, Emitter<ProviderRegistrationState> emit) {
    emit(state.copyWith(bio: event.bio, errorMessage: null));
  }

  void _onUpdateServices(
    _UpdateServices event,
    Emitter<ProviderRegistrationState> emit,
  ) {
    emit(state.copyWith(servicesDescription: event.services, errorMessage: null));
  }

  void _onUpdateCategory(
    _UpdateCategory event,
    Emitter<ProviderRegistrationState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category, errorMessage: null));
  }

  void _onSetPhoto(_SetPhoto event, Emitter<ProviderRegistrationState> emit) {
    emit(state.copyWith(photoPath: event.photoPath, errorMessage: null));
  }

  void _onNextStep(_NextStep event, Emitter<ProviderRegistrationState> emit) {
    // Validate current step before advancing
    switch (state.currentStep) {
      case 0:
        if (state.displayName.trim().isEmpty) {
          emit(state.copyWith(errorMessage: 'Please enter your display name'));
          return;
        }
        if (state.bio.trim().isEmpty) {
          emit(state.copyWith(errorMessage: 'Please enter a short bio'));
          return;
        }
        break;
      case 1:
        if (state.selectedCategory == null) {
          emit(state.copyWith(errorMessage: 'Please select a category'));
          return;
        }
        if (state.servicesDescription.trim().isEmpty) {
          emit(state.copyWith(
            errorMessage: 'Please describe the services you offer',
          ));
          return;
        }
        break;
    }

    if (state.currentStep < 2) {
      emit(state.copyWith(
        currentStep: state.currentStep + 1,
        errorMessage: null,
      ));
    }
  }

  void _onPreviousStep(
    _PreviousStep event,
    Emitter<ProviderRegistrationState> emit,
  ) {
    if (state.currentStep > 0) {
      emit(state.copyWith(
        currentStep: state.currentStep - 1,
        errorMessage: null,
      ));
    }
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<ProviderRegistrationState> emit,
  ) async {
    // Double-submit guard — prevent duplicate registrations
    if (state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final result = await _repository.registerProvider(
      displayName: state.displayName.trim(),
      bio: state.bio.trim(),
      servicesDescription: state.servicesDescription.trim(),
      photoUrl: state.photoPath,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isSubmitting: false,
        isComplete: true,
        successMessage: 'Registration submitted — pending approval',
      )),
    );
  }
}
