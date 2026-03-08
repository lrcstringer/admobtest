import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/local/app_database.dart';
import '../../../core/error/failures.dart';
import '../../../core/security/device_binding_service.dart';
import '../../../core/services/biometric_login_service.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/key_backup_service.dart';
import '../../../core/services/media_recovery_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/call_notification_service.dart';
import '../../../core/services/key_management_service.dart';
import '../../../core/services/community_sync_service.dart';
import '../../../core/services/message_sync_service.dart';
import '../../../core/services/offline_action_queue.dart';
import '../../../core/services/outgoing_message_queue.dart';
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
  final KeyManagementService _keyManagementService;
  final SignalProtocolService _signalProtocolService;
  final MessageSyncService _messageSyncService;
  final OfflineActionQueue _offlineActionQueue;
  final CommunitySyncService _communitySyncService;
  final OutgoingMessageQueue _outgoingMessageQueue;
  StreamSubscription<User?>? _authStateSubscription;
  Timer? _resendTimer;
  bool _e2eeInitInProgress = false;
  bool _keyRestoreFailed = false;

  AuthBloc(
    this._authRepository,
    this._userRepository,
    this._deviceBindingService,
    this._biometricLoginService,
    this._keyManagementService,
    this._signalProtocolService,
    this._messageSyncService,
    this._offlineActionQueue,
    this._communitySyncService,
    this._outgoingMessageQueue,
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
            // Clear message cache if a different user logged in (prevents
            // data leakage). Same user gets instant conversation list from
            // the preserved local DB cache.
            getIt<AppDatabase>()
                .clearMessageCacheIfUserChanged(user.id)
                .catchError((_) => false);
            // Start conversation/community list sync immediately so the
            // Chat and Communities tabs show data before E2EE keys are ready.
            _messageSyncService.startConversationListSync();
            _communitySyncService.startCommunityListSync();
            // Fire-and-forget E2EE key initialization
            _initializeE2EEKeys();
            // Fire-and-forget notification + VoIP token setup
            _initializeNotifications();
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
          // Start conversation list sync immediately so the Chat tab
          // shows conversations before E2EE keys are ready.
          _messageSyncService.startConversationListSync();
          // Fire-and-forget E2EE key initialization
          _initializeE2EEKeys();
          // Fire-and-forget notification + VoIP token setup
          _initializeNotifications();
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
    _communitySyncService.stopSync();
    _offlineActionQueue.stopListening();
    _outgoingMessageQueue.stopListening();
    // Clear E2EE sessions so a new device cannot decrypt old messages
    await _signalProtocolService.resetAllSessions();
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
    _communitySyncService.stopSync();
    _offlineActionQueue.stopListening();
    _outgoingMessageQueue.stopListening();
    // Clear E2EE sessions so a new user on this device starts fresh
    await _signalProtocolService.resetAllSessions();
    // Clear local DB so stale communities/messages don't persist across
    // sign-out/in (they'll be re-synced from Firestore on next login).
    await _authRepository.clearLocalCache();

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
    _communitySyncService.stopSync();
    _offlineActionQueue.stopListening();
    _outgoingMessageQueue.stopListening();

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

    // Start conversation list sync immediately so the Chat tab
    // shows conversations before E2EE keys are ready.
    _messageSyncService.startConversationListSync();
    // Fire-and-forget E2EE key initialization after onboarding
    _initializeE2EEKeys();
    // Fire-and-forget notification + VoIP token setup
    _initializeNotifications();
  }

  // =========================================================================
  // E2EE KEY INITIALIZATION
  // =========================================================================

  /// Generate and upload E2EE keys, retrying until the upload is confirmed.
  ///
  /// When local keys already exist (returning user), message sync starts
  /// IMMEDIATELY after loading them — decryption uses local keys and does
  /// not require the server bundle to be verified first. Server verification
  /// (ensureBundleUploaded) runs in the background and only affects future
  /// senders.
  ///
  /// When no local keys exist (fresh install), keys must be generated or
  /// restored before message sync can start.
  Future<void> _initializeE2EEKeys() async {
    if (_e2eeInitInProgress) return;
    _e2eeInitInProgress = true;

    var uploadConfirmed = false;
    try {
      // One-time migration: reset sessions corrupted by legacy
      // peerX3dhEphemeralKey bug (all messages showed "Cannot decrypt")
      await _signalProtocolService.migrateResetCorruptedSessions();

      final existing = await _keyManagementService.loadPrivateKeys();
      if (existing != null) {
        debugPrint('E2EE INIT: Loaded existing keys — '
            '${existing.oneTimePreKeys.length} local OTKs, '
            'identity=${existing.identityKeyPair.split("|")[1].substring(0, 8)}…');

        // Local keys are ready — start message sync IMMEDIATELY.
        // Decryption uses local keys; server verification only affects
        // future senders and can run in parallel.
        debugPrint('E2EE INIT: Local keys loaded — starting message sync now');
        await _startMessageAndQueueServices();
        // Initialize vault early so payloads are stored from the first message
        getIt<MediaRecoveryService>().initialize().catchError((e) {
          debugPrint('Media recovery init failed (early): $e');
          return false;
        });

        // Verify Firestore bundle matches local keys (catches failed uploads).
        // Retries indefinitely until confirmed or BLoC is disposed.
        await _uploadUntilConfirmed(
          () => _keyManagementService.ensureBundleUploaded(existing),
        );
        uploadConfirmed = true;
        // Replenish OTKs if running low
        await _keyManagementService.replenishOneTimePreKeysIfNeeded();
        // Rotate signed pre-key if due (every 7 days).
        // MUST await: if the CF uploads the new SPK to Firestore before the
        // local write completes, a sender could fetch the new SPK while the
        // receiver still has the old one locally — causing AES-GCM MAC failure.
        await _keyManagementService.rotateSignedPreKeyIfNeeded();
      } else {
        // No local keys — try automatic restore from server backup first
        debugPrint('E2EE INIT: No local keys — attempting auto-restore from backup');
        final backupService = getIt<KeyBackupService>();
        final restored = await backupService.autoRestore();
        if (restored) {
          debugPrint('E2EE INIT: Auto-restore SUCCESS — keys recovered from backup');
          final restoredBundle = await _keyManagementService.loadPrivateKeys();
          if (restoredBundle != null) {
            // Verify the Firestore bundle matches restored keys. autoRestore's
            // internal uploadKeyBundle has no retry logic — this catches any
            // upload failures and retries until confirmed, just like the
            // existing-keys and fresh-keys paths.
            await _uploadUntilConfirmed(
              () => _keyManagementService.ensureBundleUploaded(restoredBundle),
            );
            // Generate fresh OTKs (backup OTKs may have been consumed since backup)
            await _keyManagementService.replenishOneTimePreKeysIfNeeded();
            uploadConfirmed = true;
          }
          // NOTE: no retryUndecryptedMessages() needed here — local DB is empty on
          // fresh install. startSync() will decrypt messages with the restored keys.
        }

        if (!uploadConfirmed) {
          // No backup found or restore failed — generate fresh keys.
          // Wipe any sessions that survived reinstall via EncryptedSharedPreferences:
          // they were derived from identity/OTK material we no longer hold and
          // would send messages without a valid x3dhHeader, causing permanent
          // decryption failure for the peer.
          final restoreWasAttempted = !restored;
          debugPrint('E2EE INIT: ${restoreWasAttempted ? "Restore FAILED" : "No backup found"}'
              ' — clearing stale sessions and generating fresh bundle');
          await _signalProtocolService.clearAllSessions();
          final bundle = await _keyManagementService.generateKeyBundle();
          await _keyManagementService.storePrivateKeys(bundle);
          await _uploadUntilConfirmed(
            () => _keyManagementService.uploadKeyBundle(bundle),
          );
          uploadConfirmed = true;
          // Surface to UI so the user knows some messages may not decrypt
          if (restoreWasAttempted) {
            _keyRestoreFailed = true;
          }
          debugPrint('E2EE INIT: Fresh bundle uploaded — '
              '${bundle.oneTimePreKeys.length} OTKs, '
              'identity=${bundle.identityKeyPair.split("|")[1].substring(0, 8)}…');
        }
      }
    } catch (e) {
      debugPrint('E2EE key init error: $e');
    } finally {
      _e2eeInitInProgress = false;
    }

    if (uploadConfirmed) {
      debugPrint('E2EE INIT: Bundle upload confirmed — ensuring services started');
      // Idempotent — safe even if already started above for existing keys
      await _startMessageAndQueueServices();
      // Auto-backup keys to server (don't block startup)
      getIt<KeyBackupService>().autoBackup().catchError((e) {
        debugPrint('E2EE auto-backup failed: $e');
        return; // Swallow error — backup is best-effort
      });
      // Initialize payload recovery for E2EE message vault
      getIt<MediaRecoveryService>().initialize().catchError((e) {
        debugPrint('Media recovery init failed: $e');
        return false;
      });
      // Surface key restore failure to the UI (one-time snackbar)
      if (_keyRestoreFailed && !isClosed) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(keyRestoreFailed: true));
        _keyRestoreFailed = false;
      }
    } else {
      debugPrint('E2EE INIT: Bundle upload NOT confirmed — '
          'message sync will NOT start until keys are on the server');
    }
  }

  /// Initialize FCM notifications (token save + foreground listener) and
  /// VoIP token for incoming calls. Fire-and-forget — failures logged only.
  void _initializeNotifications() {
    getIt<NotificationService>().initialize().catchError((e) {
      debugPrint('NotificationService init failed: $e');
    });
    getIt<CallNotificationService>().saveVoipToken().catchError((e) {
      debugPrint('VoIP token save failed: $e');
    });
  }

  /// Start all message/queue services. Idempotent — safe to call multiple times.
  ///
  /// Purge must complete BEFORE message sync starts. If the Firestore stream
  /// emits before purge deletes the sentinel rows, the sync service sees
  /// "[Cannot decrypt]" rows in the local DB, skips them, and the messages
  /// never get retried with the restored keys.
  Future<void> _startMessageAndQueueServices() async {
    try {
      final count = await getIt<AppDatabase>().purgeUndecryptableMessages();
      if (count > 0) {
        debugPrint('E2EE INIT: Purged $count undecryptable messages — '
            'will retry from Firestore');
      }
    } catch (e) {
      debugPrint('E2EE INIT: Purge failed: $e');
    }
    _messageSyncService.startSync();
    _communitySyncService.startSync();
    _offlineActionQueue.startListening();
    _outgoingMessageQueue.startListening();
  }

  /// Retry an upload indefinitely with exponential backoff (capped at 30s).
  ///
  /// Stops only when the upload succeeds or the BLoC is disposed.
  /// Key bundle uploads are non-negotiable — without them on the server,
  /// every incoming encrypted message is permanently undecryptable.
  Future<void> _uploadUntilConfirmed(Future<void> Function() upload) async {
    const maxBackoff = Duration(seconds: 30);
    var backoff = const Duration(seconds: 1);
    var attempt = 0;

    while (!_disposed) {
      attempt++;
      try {
        await upload();
        if (attempt > 1) {
          debugPrint('E2EE INIT: Upload succeeded on attempt $attempt');
        }
        return; // confirmed
      } on FirebaseFunctionsException catch (e) {
        final isRetryable = e.code == 'unavailable' ||
            e.code == 'deadline-exceeded' ||
            e.code == 'unauthenticated';
        debugPrint('E2EE INIT: Upload attempt $attempt failed '
            '[CF code=${e.code}, retryable=$isRetryable] '
            '— retrying in ${backoff.inSeconds}s');
        if (!isRetryable) {
          // permission-denied (IAM) or internal (Firestore crash) won't
          // resolve by waiting — still retry but log prominently so the
          // developer knows to check server config.
          debugPrint('E2EE INIT: ⚠ NON-TRANSIENT error "${e.code}" — '
              'check Cloud Function IAM, App Check, and Firestore health');
        }
        await Future<void>.delayed(backoff);
        backoff = Duration(
          milliseconds: (backoff.inMilliseconds * 2)
              .clamp(0, maxBackoff.inMilliseconds),
        );
      } catch (e) {
        debugPrint('E2EE INIT: Upload attempt $attempt failed '
            '[non-CF: ${e.runtimeType}] $e '
            '— retrying in ${backoff.inSeconds}s');
        await Future<void>.delayed(backoff);
        backoff = Duration(
          milliseconds: (backoff.inMilliseconds * 2)
              .clamp(0, maxBackoff.inMilliseconds),
        );
      }
    }
    // BLoC was disposed while retrying
    throw StateError('E2EE INIT: BLoC disposed during upload retry');
  }

  bool _disposed = false;

  @override
  Future<void> close() {
    _disposed = true;
    _messageSyncService.stopSync();
    _communitySyncService.stopSync();
    _offlineActionQueue.stopListening();
    _outgoingMessageQueue.stopListening();
    _authStateSubscription?.cancel();
    _resendTimer?.cancel();
    return super.close();
  }
}
