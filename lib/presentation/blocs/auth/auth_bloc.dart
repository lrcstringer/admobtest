import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/security/device_binding_service.dart';
import '../../../core/services/biometric_login_service.dart';
import '../../../core/services/fcm_challenge_handler.dart';
import '../../../core/services/key_management_service.dart';
import '../../../core/services/message_sync_service.dart';
import '../../../core/services/offline_action_queue.dart';
import '../../../core/services/signal_protocol_service.dart';
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
  final FcmChallengeHandler _fcmChallengeHandler;
  final KeyManagementService _keyManagementService;
  final SignalProtocolService _signalProtocolService;
  final MessageSyncService _messageSyncService;
  final OfflineActionQueue _offlineActionQueue;
  StreamSubscription<User?>? _authStateSubscription;
  Timer? _resendTimer;
  bool _e2eeInitInProgress = false;

  AuthBloc(
    this._authRepository,
    this._userRepository,
    this._deviceBindingService,
    this._biometricLoginService,
    this._fcmChallengeHandler,
    this._keyManagementService,
    this._signalProtocolService,
    this._messageSyncService,
    this._offlineActionQueue,
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
    on<_RequestPushLogin>(_onRequestPushLogin);
    on<_ClearPushLoginState>(_onClearPushLoginState);

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
            // Fire-and-forget E2EE key initialization
            _initializeE2EEKeys();
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
    // Only show loading status during initial auth checks (startup/splash).
    // If already authenticated, skip the loading transition to avoid the
    // router redirecting the user to splash and back.
    final alreadyAuthenticated =
        state.status == AuthStatus.authenticated ||
        state.status == AuthStatus.onboardingRequired;
    if (!alreadyAuthenticated) {
      emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    }

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (failure) {
        if (alreadyAuthenticated) {
          // A transient failure refreshing user data must NOT kick out an
          // already-authenticated user. Keep the current auth state.
          debugPrint('checkAuthStatus: getCurrentUser failed while already '
              'authenticated, keeping current state: ${failure.displayMessage}');
          return;
        }
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          isLoading: false,
        ));
      },
      (user) {
        if (user == null) {
          if (alreadyAuthenticated) {
            // Same guard: null user during a refresh should not sign out.
            debugPrint('checkAuthStatus: getCurrentUser returned null while '
                'already authenticated, keeping current state');
            return;
          }
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
          // Fire-and-forget E2EE key initialization
          _initializeE2EEKeys();
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
    // Stop message sync and offline queue before re-authentication
    _messageSyncService.stopSync();
    _offlineActionQueue.stopListening();
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

    // Stop message sync and offline queue before signing out
    _messageSyncService.stopSync();
    _offlineActionQueue.stopListening();

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
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Stop message sync and offline queue before account deletion
    _messageSyncService.stopSync();
    _offlineActionQueue.stopListening();

    // Capture userId before deletion (needed for keystore cleanup)
    final userId = state.user?.id;

    final result = await _authRepository.deleteAccount();

    // Note: Don't use result.fold() with async callbacks - fold doesn't await them!
    if (result.isLeft()) {
      final failure = result.fold((f) => f, (_) => null)!;
      emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      ));
      return;
    }

    // Success - clear all local data.
    // Wrap in try-catch so a cleanup failure never blocks the
    // unauthenticated transition (leaving the dialog stuck).
    try {
      await _deviceBindingService.clearBinding();
      await _biometricLoginService.clearCachedDisplayName();
      await _biometricLoginService.clearLastAuthTime();
      await _authRepository.clearLocalCache();
      if (userId != null) {
        await _deviceBindingService.deleteKeypair(userId);
      }
    } catch (e) {
      debugPrint('Post-deletion cleanup error (non-fatal): $e');
    }

    emit(const AuthState(status: AuthStatus.unauthenticated));
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

    // Fire-and-forget E2EE key initialization after onboarding
    _initializeE2EEKeys();
  }

  Future<void> _onRequestPushLogin(
    _RequestPushLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      isPushLoginLoading: true,
      phoneNumber: event.phoneNumber,
      errorMessage: null,
      pushLoginChallengeId: null,
      hasTrustedDevice: false,
    ));

    // Skip push login if requested
    if (event.skipPushLogin) {
      debugPrint('========================================');
      debugPrint('PUSH LOGIN: Skipped (skipPushLogin=true)');
      debugPrint('========================================');
      emit(state.copyWith(isPushLoginLoading: false));
      // Fall back to OTP
      add(AuthEvent.sendOtp(phoneNumber: event.phoneNumber));
      return;
    }

    debugPrint('========================================');
    debugPrint('PUSH LOGIN: Attempting for ${event.phoneNumber}');
    debugPrint('========================================');

    final result = await _fcmChallengeHandler.requestLogin(event.phoneNumber);

    debugPrint('========================================');
    debugPrint('PUSH LOGIN RESULT: hasTrustedDevice=${result.hasTrustedDevice}, challengeId=${result.challengeId}');
    debugPrint('========================================');

    if (result.hasTrustedDevice && result.challengeId != null) {
      // Push login available - emit state with challengeId
      emit(state.copyWith(
        isPushLoginLoading: false,
        pushLoginChallengeId: result.challengeId,
        hasTrustedDevice: true,
      ));
      return;
    }

    // No trusted device - fall back to OTP
    debugPrint('PUSH LOGIN: Falling back to SMS OTP');
    emit(state.copyWith(
      isPushLoginLoading: false,
      hasTrustedDevice: false,
    ));
    add(AuthEvent.sendOtp(phoneNumber: event.phoneNumber));
  }

  Future<void> _onClearPushLoginState(
    _ClearPushLoginState event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      isPushLoginLoading: false,
      pushLoginChallengeId: null,
      hasTrustedDevice: false,
    ));
  }

  // =========================================================================
  // E2EE KEY INITIALIZATION
  // =========================================================================

  /// Generate and upload E2EE keys if not already present.
  /// Fire-and-forget — E2EE failures are non-fatal.
  Future<void> _initializeE2EEKeys() async {
    if (_e2eeInitInProgress) return;
    _e2eeInitInProgress = true;
    try {
      // One-time migration: reset sessions corrupted by legacy
      // peerX3dhEphemeralKey bug (all messages showed "Cannot decrypt")
      await _signalProtocolService.migrateResetCorruptedSessions();

      final existing = await _keyManagementService.loadPrivateKeys();
      if (existing != null) {
        debugPrint('E2EE INIT: Loaded existing keys — '
            '${existing.oneTimePreKeys.length} local OTKs, '
            'identity=${existing.identityKeyPair.split("|")[1].substring(0, 8)}…');
        // Verify Firestore bundle matches local keys (catches failed uploads)
        await _keyManagementService.ensureBundleUploaded(existing);
        // Replenish OTKs if running low
        await _keyManagementService.replenishOneTimePreKeysIfNeeded();
      } else {
        debugPrint('E2EE INIT: No existing keys — generating fresh bundle');
        // First time — generate full key bundle
        final bundle = await _keyManagementService.generateKeyBundle();
        await _keyManagementService.storePrivateKeys(bundle);
        await _keyManagementService.uploadKeyBundle(bundle);
        debugPrint('E2EE INIT: Fresh bundle uploaded — '
            '${bundle.oneTimePreKeys.length} OTKs, '
            'identity=${bundle.identityKeyPair.split("|")[1].substring(0, 8)}…');
        // Log first 8 chars of each OTK public key so we can correlate
        // with what the sender receives from fetchKeyBundle
        for (var i = 0; i < bundle.oneTimePreKeys.length; i++) {
          final pub = bundle.oneTimePreKeys[i].split('|')[1];
          debugPrint('E2EE INIT: OTK[$i] = ${pub.substring(0, 12)}…');
        }
      }
    } catch (e) {
      debugPrint('E2EE key init FAILED (non-fatal): $e');
    } finally {
      _e2eeInitInProgress = false;
    }

    // CRITICAL: Always start sync — even if key init fails, sync must
    // run so messages can be received and queued for later decryption.
    _messageSyncService.startSync();
    _offlineActionQueue.startListening();
  }

  @override
  Future<void> close() {
    _messageSyncService.stopSync();
    _offlineActionQueue.stopListening();
    _authStateSubscription?.cancel();
    _resendTimer?.cancel();
    return super.close();
  }
}
