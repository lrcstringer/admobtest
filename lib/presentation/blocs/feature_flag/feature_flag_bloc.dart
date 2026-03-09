import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/feature_flag.dart';
import '../../../domain/repositories/feature_flag_repository.dart';

part 'feature_flag_event.dart';
part 'feature_flag_state.dart';
part 'feature_flag_bloc.freezed.dart';

@injectable
class FeatureFlagBloc extends Bloc<FeatureFlagEvent, FeatureFlagState> {
  final FeatureFlagRepository _featureFlagRepository;

  FeatureFlagBloc(this._featureFlagRepository)
      : super(const FeatureFlagState()) {
    on<_LoadFeatureFlags>(_onLoadFeatureFlags);
    on<_CheckFeature>(_onCheckFeature);
  }

  Future<void> _onLoadFeatureFlags(
    _LoadFeatureFlags event,
    Emitter<FeatureFlagState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _featureFlagRepository.getFeatureFlags();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (flags) {
        final flagMap = <String, FeatureFlag>{};
        for (final flag in flags) {
          flagMap[flag.featureKey] = flag;
        }
        emit(state.copyWith(
          isLoading: false,
          flags: flags,
          flagMap: flagMap,
          errorMessage: null,
        ));
      },
    );
  }

  Future<void> _onCheckFeature(
    _CheckFeature event,
    Emitter<FeatureFlagState> emit,
  ) async {
    final result = await _featureFlagRepository.isFeatureEnabled(
      event.featureKey,
      communityId: event.communityId,
    );
    result.fold(
      (_) {}, // Silently fail — treat as disabled
      (isEnabled) {
        final updated = Map<String, bool>.from(state.featureChecks);
        final key = event.communityId != null
            ? '${event.featureKey}:${event.communityId}'
            : event.featureKey;
        updated[key] = isEnabled;
        emit(state.copyWith(featureChecks: updated));
      },
    );
  }

  /// Convenience method to check if a feature is enabled
  bool isEnabled(String featureKey, {String? communityId}) {
    final key = communityId != null
        ? '$featureKey:$communityId'
        : featureKey;
    return state.featureChecks[key] ?? false;
  }
}
