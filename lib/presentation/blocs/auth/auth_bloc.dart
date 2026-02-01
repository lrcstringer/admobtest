import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/security/device_binding_service.dart';
import '../../../core/services/biometric_login_service.dart';
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
  final DeviceBindingService _deviceBindingService;
  final BiometricLoginService _biometricLoginService;
  StreamSubscription<User?>? _authStateSubscription;
  Timer? _resendTimer;

  AuthBloc(
    this._authRepository,
    this._userRepository,
    this._deviceBindingService,
    this._biometricLoginService,
  ) : super(const AuthState()) {
    on<_CheckAuthStatus>(_onCheckAuthStatus);
    on<_SendOtp>(_onSendOtp);
    on<_VerifyOtp>(_onVerifyOtp);
    on<_ResendOtp>(_onResendOtp);
    on<_SignOut>(_onSignOut);
    on<_DeleteAccount>(_onDeleteAccount);
    on<_AcceptTerms>(_onAcceptTerms);
    on<_CompleteOnboarding>(_onCompleteOnboarding);
    on<_BindDevice>(_onBindDevice);
    on<_LockSession>(_onLockSession);
    on<_UnlockSession>(_onUnlockSession);
    on<_ForceReauth>(_onForceReauth);
    on<_AuthenticateWithPushToken>(_onAuthenticateWithPushToken);

    // Listen to auth state changes
    _authStateSubscription = _authRepository.authStateChanges.listen(
      (user) {
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
      },
      onError: (error) {
        debugPrint('Auth state stream error: $error');
        // On stream error, mark as unauthenticated so the app doesn't hang
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          isLoading: false,
        ));
      },
    );
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

        // Record successful auth for inactivity tracking
        _biometricLoginService.recordSuccessfulAuth();

        // Trigger non-blocking device binding after successful OTP
        add(const AuthEvent.bindDevice());
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

  Future<void> _onBindDevice(
    _BindDevice event,
    Emitter<AuthState> emit,
  ) async {
    final userId = state.user?.id;
    if (userId == null) return;

    final result = await _deviceBindingService.bindCurrentDevice(userId);

    result.fold(
      (failure) {
        // Device binding failure is non-blocking — log and continue
        debugPrint('========================================');
        debugPrint('DEVICE BINDING FAILED: ${failure.displayMessage}');
        debugPrint('Failure type: ${failure.runtimeType}');
        debugPrint('========================================');
        emit(state.copyWith(isDeviceBound: false));
      },
      (device) {
        debugPrint('========================================');
        debugPrint('DEVICE BINDING SUCCESS: ${device.deviceId}');
        debugPrint('========================================');
        emit(state.copyWith(
          isDeviceBound: true,
          deviceId: device.deviceId,
        ));
      },
    );
  }

  Future<void> _onAuthenticateWithPushToken(
    _AuthenticateWithPushToken event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));

    final result =
        await _authRepository.signInWithCustomToken(event.customToken);

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
          ));
        } else {
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            isLoading: false,
          ));
        }

        // Record successful auth for inactivity tracking
        _biometricLoginService.recordSuccessfulAuth();

        // Trigger non-blocking device binding
        add(const AuthEvent.bindDevice());
      },
    );
  }

  Future<void> _onLockSession(
    _LockSession event,
    Emitter<AuthState> emit,
  ) async {
    // Only lock if currently authenticated
    if (state.status == AuthStatus.authenticated) {
      emit(state.copyWith(status: AuthStatus.sessionLocked));
    }
  }

  Future<void> _onUnlockSession(
    _UnlockSession event,
    Emitter<AuthState> emit,
  ) async {
    // Restore authenticated status after successful unlock
    if (state.status == AuthStatus.sessionLocked) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    }
  }

  Future<void> _onForceReauth(
    _ForceReauth event,
    Emitter<AuthState> emit,
  ) async {
    // Clear session and force full OTP re-authentication
    await _deviceBindingService.clearBinding();
    await _authRepository.signOut();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  Future<void> _onSignOut(
    _SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // NOTE: Do NOT clear device binding on sign-out.
    // The device binding (keypair + Firestore record) must persist
    // so that push-based login can work on subsequent sign-ins.
    // Only _onForceReauth and _onDeleteAccount clear the binding.

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
    emit(state.copyWith(isLoading: true, errorMessage: null));

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
    if (state.user == null) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Persist hasCompletedOnboarding to Firestore
    final result = await _userRepository.completeOnboarding();

    if (result.isLeft()) {
      final failure = result.fold((f) => f, (_) => null)!;
      emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      ));
      return;
    }

    // Re-fetch user from Firestore to get all latest profile data
    final userResult = await _authRepository.getCurrentUser();
    final freshUser = userResult.fold(
      (_) => state.user!.copyWith(hasCompletedOnboarding: true),
      (user) => user ?? state.user!.copyWith(hasCompletedOnboarding: true),
    );

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: freshUser,
      isLoading: false,
    ));
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    _resendTimer?.cancel();
    return super.close();
  }
}
