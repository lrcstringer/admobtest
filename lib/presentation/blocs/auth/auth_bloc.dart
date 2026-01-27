import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/user_repository.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<User?>? _authStateSubscription;
  Timer? _resendTimer;

  AuthBloc(this._authRepository, this._userRepository)
      : super(const AuthState()) {
    on<_CheckAuthStatus>(_onCheckAuthStatus);
    on<_SendOtp>(_onSendOtp);
    on<_VerifyOtp>(_onVerifyOtp);
    on<_ResendOtp>(_onResendOtp);
    on<_SignOut>(_onSignOut);
    on<_DeleteAccount>(_onDeleteAccount);
    on<_AcceptTerms>(_onAcceptTerms);
    on<_CompleteOnboarding>(_onCompleteOnboarding);

    // Listen to auth state changes
    _authStateSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        if (user.needsOnboarding) {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(
            status: AuthStatus.onboardingRequired,
            user: user,
            isLoading: false,
          ));
        } else {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            isLoading: false,
          ));
        }
      }
    });
  }

  Future<void> _onCheckAuthStatus(
    _CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          isLoading: false,
        ));
      },
      (user) {
        if (user == null) {
          emit(state.copyWith(
            status: AuthStatus.unauthenticated,
            isLoading: false,
          ));
        } else if (user.needsOnboarding) {
          emit(state.copyWith(
            status: AuthStatus.onboardingRequired,
            user: user,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            isLoading: false,
          ));
        }
      },
    );
  }

  Future<void> _onSendOtp(
    _SendOtp event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      isLoading: true,
      phoneNumber: event.phoneNumber,
      errorMessage: null,
    ));

    final result = await _authRepository.sendOtp(phoneNumber: event.phoneNumber);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (verificationId) {
        emit(state.copyWith(
          status: AuthStatus.otpSent,
          verificationId: verificationId,
          isLoading: false,
        ));
        _startResendCountdown(emit);
      },
    );
  }

  Future<void> _onVerifyOtp(
    _VerifyOtp event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await _authRepository.verifyOtp(
      verificationId: event.verificationId,
      otp: event.otp,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (user) {
        if (user.needsOnboarding) {
          emit(state.copyWith(
            status: AuthStatus.onboardingRequired,
            user: user,
            isLoading: false,
            verificationId: null,
          ));
        } else {
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            isLoading: false,
            verificationId: null,
          ));
        }
      },
    );
  }

  Future<void> _onResendOtp(
    _ResendOtp event,
    Emitter<AuthState> emit,
  ) async {
    if (state.resendCountdown > 0) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.sendOtp(phoneNumber: event.phoneNumber);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (verificationId) {
        emit(state.copyWith(
          verificationId: verificationId,
          isLoading: false,
        ));
        _startResendCountdown(emit);
      },
    );
  }

  void _startResendCountdown(Emitter<AuthState> emit) {
    _resendTimer?.cancel();
    // ignore: invalid_use_of_visible_for_testing_member
    this.emit(state.copyWith(resendCountdown: 60));

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendCountdown > 0) {
        // ignore: invalid_use_of_visible_for_testing_member
        this.emit(state.copyWith(resendCountdown: state.resendCountdown - 1));
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _onSignOut(
    _SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _authRepository.signOut();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> _onDeleteAccount(
    _DeleteAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _authRepository.deleteAccount();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> _onAcceptTerms(
    _AcceptTerms event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userRepository.acceptTerms();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        if (state.user != null) {
          final updatedUser = state.user!.copyWith(hasAcceptedTerms: true);
          if (updatedUser.hasCompletedOnboarding) {
            emit(state.copyWith(
              status: AuthStatus.authenticated,
              user: updatedUser,
              isLoading: false,
            ));
          } else {
            emit(state.copyWith(
              user: updatedUser,
              isLoading: false,
            ));
          }
        }
      },
    );
  }

  Future<void> _onCompleteOnboarding(
    _CompleteOnboarding event,
    Emitter<AuthState> emit,
  ) async {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(hasCompletedOnboarding: true);
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: updatedUser,
      ));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    _resendTimer?.cancel();
    return super.close();
  }
}
