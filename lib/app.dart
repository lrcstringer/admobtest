import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/di/injection.dart';
import 'core/security/session_lock_service.dart';
import 'core/security/sim_change_detector.dart';
import 'core/services/fcm_challenge_handler.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/cashout/cashout_bloc.dart';
import 'presentation/blocs/chat/chat_bloc.dart';
import 'presentation/blocs/earn/earn_bloc.dart';
import 'presentation/blocs/pot/pot_bloc.dart';
import 'presentation/blocs/purchase/purchase_bloc.dart';
import 'presentation/blocs/referral/referral_bloc.dart';
import 'presentation/blocs/wallet/wallet_bloc.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_theme.dart';

/// Main application widget
class IMaliChatApp extends StatefulWidget {
  const IMaliChatApp({super.key});

  @override
  State<IMaliChatApp> createState() => _IMaliChatAppState();
}

class _IMaliChatAppState extends State<IMaliChatApp>
    with WidgetsBindingObserver {
  late final AuthBloc _authBloc;
  late final WalletBloc _walletBloc;
  late final EarnBloc _earnBloc;
  late final CashoutBloc _cashoutBloc;
  late final ChatBloc _chatBloc;
  late final PotBloc _potBloc;
  late final PurchaseBloc _purchaseBloc;
  late final ReferralBloc _referralBloc;
  late final AppRouter _appRouter;
  late final SessionLockService _sessionLockService;
  late final SimChangeDetector _simChangeDetector;
  late final FcmChallengeHandler _challengeHandler;

  StreamSubscription<Map<String, dynamic>>? _challengeSubscription;
  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _authBloc = getIt<AuthBloc>();
    _walletBloc = getIt<WalletBloc>();
    _earnBloc = getIt<EarnBloc>();
    _cashoutBloc = getIt<CashoutBloc>();
    _chatBloc = getIt<ChatBloc>();
    _potBloc = getIt<PotBloc>();
    _purchaseBloc = getIt<PurchaseBloc>();
    _referralBloc = getIt<ReferralBloc>();
    _sessionLockService = GetIt.instance<SessionLockService>();
    _simChangeDetector = GetIt.instance<SimChangeDetector>();
    _challengeHandler = GetIt.instance<FcmChallengeHandler>();
    _appRouter = AppRouter(authBloc: _authBloc);

    _setupChallengeNavigation();
    _setupUserIdPropagation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _challengeSubscription?.cancel();
    _authStateSubscription?.cancel();
    super.dispose();
  }

  /// Listen to the FCM challenge stream and navigate to the approval screen
  /// when an auth challenge push is received on this (trusted) device.
  void _setupChallengeNavigation() {
    // Foreground challenges
    _challengeSubscription =
        _challengeHandler.challengeStream.listen((data) {
      final challengeId = data['challengeId'] as String?;
      final nonce = data['nonce'] as String?;
      if (challengeId != null && nonce != null) {
        _appRouter.router.push('/auth/challenge-approval', extra: {
          'challengeId': challengeId,
          'nonce': nonce,
        });
      }
    });

    // App opened from a background notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final data = message.data;
      if (data['type'] == 'auth_challenge') {
        _appRouter.router.push('/auth/challenge-approval', extra: {
          'challengeId': data['challengeId'],
          'nonce': data['nonce'],
        });
      }
    });

    // App launched from terminated state via notification tap
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message.data['type'] == 'auth_challenge') {
        _appRouter.router.push('/auth/challenge-approval', extra: {
          'challengeId': message.data['challengeId'],
          'nonce': message.data['nonce'],
        });
      }
    });
  }

  /// Propagate the current user ID to security services that need it
  /// for audit logging.
  void _setupUserIdPropagation() {
    _authStateSubscription = _authBloc.stream.listen((state) {
      final userId = state.user?.id;
      _sessionLockService.setUserId(userId);
      _simChangeDetector.setUserId(userId);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _sessionLockService.onAppPaused();
      case AppLifecycleState.resumed:
        _handleAppResumed();
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _handleAppResumed() {
    // Only check session lock if user is authenticated
    if (_authBloc.state.status != AuthStatus.authenticated &&
        _authBloc.state.status != AuthStatus.sessionLocked) {
      return;
    }

    final result = _sessionLockService.onAppResumed();

    switch (result) {
      case SessionLockResult.noLockNeeded:
        break;
      case SessionLockResult.sessionLockRequired:
        _authBloc.add(const AuthEvent.lockSession());
      case SessionLockResult.fullReauthRequired:
        _authBloc.add(const AuthEvent.forceReauth());
    }

    // Check for SIM changes (non-blocking)
    _simChangeDetector.checkForSimChange();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<WalletBloc>.value(value: _walletBloc),
        BlocProvider<EarnBloc>.value(value: _earnBloc),
        BlocProvider<CashoutBloc>.value(value: _cashoutBloc),
        BlocProvider<ChatBloc>.value(value: _chatBloc),
        BlocProvider<PotBloc>.value(value: _potBloc),
        BlocProvider<PurchaseBloc>.value(value: _purchaseBloc),
        BlocProvider<ReferralBloc>.value(value: _referralBloc),
      ],
      child: MaterialApp.router(
        title: 'iMali',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
