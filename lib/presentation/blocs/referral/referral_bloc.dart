import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/referral.dart';
import '../../../domain/repositories/referral_repository.dart';

part 'referral_event.dart';
part 'referral_state.dart';
part 'referral_bloc.freezed.dart';

@injectable
class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  final ReferralRepository _referralRepository;
  StreamSubscription? _referralsSubscription;

  ReferralBloc(this._referralRepository) : super(const ReferralState()) {
    on<_LoadStats>(_onLoadStats);
    on<_LoadReferrals>(_onLoadReferrals);
    on<_WatchReferrals>(_onWatchReferrals);
    on<_ReferralsUpdated>(_onReferralsUpdated);
    on<_ApplyCode>(_onApplyCode);
    on<_ShareReferral>(_onShareReferral);
    on<_CopyCode>(_onCopyCode);
    on<_ValidateCode>(_onValidateCode);
    on<_LoadLeaderboard>(_onLoadLeaderboard);
    on<_ClearError>(_onClearError);
    on<_ClearSuccess>(_onClearSuccess);
  }

  Future<void> _onLoadStats(
    _LoadStats event,
    Emitter<ReferralState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _referralRepository.getReferralStats();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (stats) => emit(state.copyWith(
        isLoading: false,
        stats: stats,
      )),
    );
  }

  Future<void> _onLoadReferrals(
    _LoadReferrals event,
    Emitter<ReferralState> emit,
  ) async {
    emit(state.copyWith(isLoadingReferrals: true));

    final result = await _referralRepository.getReferrals(
      status: event.status,
      limit: event.limit,
      startAfter: event.startAfter,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingReferrals: false,
        errorMessage: failure.displayMessage,
      )),
      (referrals) {
        final allReferrals = event.startAfter != null
            ? [...state.referrals, ...referrals]
            : referrals;
        emit(state.copyWith(
          isLoadingReferrals: false,
          referrals: allReferrals,
          hasMoreReferrals: referrals.length >= (event.limit ?? 20),
        ));
      },
    );
  }

  Future<void> _onWatchReferrals(
    _WatchReferrals event,
    Emitter<ReferralState> emit,
  ) async {
    await _referralsSubscription?.cancel();
    _referralsSubscription = _referralRepository.watchReferrals().listen(
      (result) {
        result.fold(
          (failure) {},
          (referrals) => add(ReferralEvent.referralsUpdated(referrals)),
        );
      },
    );
  }

  void _onReferralsUpdated(
    _ReferralsUpdated event,
    Emitter<ReferralState> emit,
  ) {
    emit(state.copyWith(referrals: event.referrals));
  }

  Future<void> _onApplyCode(
    _ApplyCode event,
    Emitter<ReferralState> emit,
  ) async {
    emit(state.copyWith(isApplying: true));

    final result = await _referralRepository.applyReferralCode(event.code);
    result.fold(
      (failure) => emit(state.copyWith(
        isApplying: false,
        errorMessage: failure.displayMessage,
      )),
      (referral) => emit(state.copyWith(
        isApplying: false,
        appliedReferral: referral,
        successMessage: 'Referral code applied! You earned ${referral.refereeReward} tokens!',
      )),
    );
  }

  Future<void> _onShareReferral(
    _ShareReferral event,
    Emitter<ReferralState> emit,
  ) async {
    emit(state.copyWith(isSharing: true));

    final result = await _referralRepository.shareReferral(
      platform: event.platform,
      customMessage: event.customMessage,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSharing: false,
        errorMessage: failure.displayMessage,
      )),
      (shared) => emit(state.copyWith(
        isSharing: false,
        successMessage: shared ? 'Referral shared successfully!' : null,
      )),
    );
  }

  Future<void> _onCopyCode(
    _CopyCode event,
    Emitter<ReferralState> emit,
  ) async {
    // The actual clipboard copy is done in the UI
    emit(state.copyWith(successMessage: 'Referral code copied!'));
  }

  Future<void> _onValidateCode(
    _ValidateCode event,
    Emitter<ReferralState> emit,
  ) async {
    emit(state.copyWith(isValidating: true, isCodeValid: null));

    final result = await _referralRepository.isValidReferralCode(event.code);
    result.fold(
      (failure) => emit(state.copyWith(
        isValidating: false,
        isCodeValid: false,
      )),
      (isValid) => emit(state.copyWith(
        isValidating: false,
        isCodeValid: isValid,
      )),
    );
  }

  Future<void> _onLoadLeaderboard(
    _LoadLeaderboard event,
    Emitter<ReferralState> emit,
  ) async {
    emit(state.copyWith(isLoadingLeaderboard: true));

    final result =
        await _referralRepository.getReferralLeaderboard(limit: event.limit);
    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingLeaderboard: false,
        errorMessage: failure.displayMessage,
      )),
      (leaderboard) => emit(state.copyWith(
        isLoadingLeaderboard: false,
        leaderboard: leaderboard,
      )),
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<ReferralState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  void _onClearSuccess(
    _ClearSuccess event,
    Emitter<ReferralState> emit,
  ) {
    emit(state.copyWith(successMessage: null));
  }

  @override
  Future<void> close() {
    _referralsSubscription?.cancel();
    return super.close();
  }
}
