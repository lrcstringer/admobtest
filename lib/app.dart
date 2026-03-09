import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/di/injection.dart';
import 'core/security/session_lock_service.dart';
import 'core/security/sim_change_detector.dart';
import 'core/services/call_notification_service.dart';
import 'core/services/deep_link_service.dart';
import 'core/services/notification_service.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/call/call_bloc.dart';
import 'presentation/blocs/cashout/cashout_bloc.dart';
import 'presentation/blocs/chat/chat_bloc.dart';
import 'presentation/blocs/community/community_bloc.dart';
import 'presentation/blocs/contact/contact_bloc.dart';
import 'presentation/blocs/conversation/conversation_bloc.dart';
import 'presentation/blocs/conversation_actions/conversation_actions_bloc.dart';
import 'presentation/blocs/user_search/user_search_bloc.dart';
import 'presentation/blocs/earn/earn_bloc.dart';
import 'presentation/blocs/earn_inbox/earn_inbox_bloc.dart';
import 'presentation/blocs/gift/gift_bloc.dart';
import 'presentation/blocs/pot/pot_bloc.dart';
import 'presentation/blocs/token_pool/token_pool_bloc.dart';
import 'presentation/blocs/buy_tab/buy_tab_bloc.dart';
import 'presentation/blocs/feature_flag/feature_flag_bloc.dart';
import 'presentation/blocs/marketplace/marketplace_bloc.dart';
import 'presentation/blocs/order/order_bloc.dart';
import 'presentation/blocs/group_buy/group_buy_bloc.dart';
import 'presentation/blocs/purchase/purchase_bloc.dart';
import 'presentation/blocs/referral/referral_bloc.dart';
import 'presentation/blocs/reward/reward_bloc.dart';
import 'presentation/blocs/wallet/wallet_bloc.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_colors.dart';
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
  late final ConversationBloc _conversationBloc;
  late final ConversationActionsBloc _conversationActionsBloc;
  late final UserSearchBloc _userSearchBloc;
  late final CommunityBloc _communityBloc;
  late final ContactBloc _contactBloc;
  late final PotBloc _potBloc;
  late final PurchaseBloc _purchaseBloc;
  late final ReferralBloc _referralBloc;
  late final RewardBloc _rewardBloc;
  late final EarnInboxBloc _earnInboxBloc;
  late final CallBloc _callBloc;
  late final GiftBloc _giftBloc;
  late final TokenPoolBloc _tokenPoolBloc;
  late final BuyTabBloc _buyTabBloc;
  late final FeatureFlagBloc _featureFlagBloc;
  late final MarketplaceBloc _marketplaceBloc;
  late final OrderBloc _orderBloc;
  late final GroupBuyBloc _groupBuyBloc;
  late final AppRouter _appRouter;
  late final SessionLockService _sessionLockService;
  late final SimChangeDetector _simChangeDetector;
  StreamSubscription<AuthState>? _authStateSubscription;
  StreamSubscription<Uri>? _appLinksSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _authBloc = getIt<AuthBloc>();
    _walletBloc = getIt<WalletBloc>();
    _earnBloc = getIt<EarnBloc>();
    _cashoutBloc = getIt<CashoutBloc>();
    _chatBloc = getIt<ChatBloc>();
    _conversationBloc = getIt<ConversationBloc>();
    _conversationActionsBloc = getIt<ConversationActionsBloc>();
    _userSearchBloc = getIt<UserSearchBloc>();
    _communityBloc = getIt<CommunityBloc>();
    _contactBloc = getIt<ContactBloc>();
    _potBloc = getIt<PotBloc>();
    _purchaseBloc = getIt<PurchaseBloc>();
    _referralBloc = getIt<ReferralBloc>();
    _rewardBloc = getIt<RewardBloc>();
    _earnInboxBloc = getIt<EarnInboxBloc>();
    _callBloc = getIt<CallBloc>();
    _giftBloc = getIt<GiftBloc>();
    _tokenPoolBloc = getIt<TokenPoolBloc>();
    _buyTabBloc = getIt<BuyTabBloc>();
    _featureFlagBloc = getIt<FeatureFlagBloc>();
    _marketplaceBloc = getIt<MarketplaceBloc>();
    _orderBloc = getIt<OrderBloc>();
    _groupBuyBloc = getIt<GroupBuyBloc>();
    _sessionLockService = GetIt.instance<SessionLockService>();
    _simChangeDetector = GetIt.instance<SimChangeDetector>();
    _appRouter = AppRouter(authBloc: _authBloc);

    // Wire up deep link handling
    getIt<DeepLinkService>().setRouter(_appRouter.router);
    _setupAppLinks();

    // Wire up call notification handling
    final callNotificationService = getIt<CallNotificationService>();
    callNotificationService.configure(
      router: _appRouter.router,
      callBloc: _callBloc,
    );
    getIt<NotificationService>()
        .setCallNotificationService(callNotificationService);

    _setupNotificationNavigation();
    _setupUserIdPropagation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authStateSubscription?.cancel();
    _appLinksSubscription?.cancel();
    _callBloc.close();
    super.dispose();
  }

  /// Listen for incoming deep links (app_links) and forward to DeepLinkService.
  void _setupAppLinks() {
    final appLinks = AppLinks();

    // Handle link that launched the app from terminated state
    appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        getIt<DeepLinkService>().handleDeepLink(uri.toString());
      }
    });

    // Handle links while app is running
    _appLinksSubscription = appLinks.uriLinkStream.listen((uri) {
      getIt<DeepLinkService>().handleDeepLink(uri.toString());
    });
  }

  /// Handle notification taps to navigate to the appropriate screen.
  void _setupNotificationNavigation() {
    // App opened from a background notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(message.data);
    });

    // App launched from terminated state via notification tap
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationTap(message.data);
      }
    });
  }

  /// Route notification taps to the appropriate screen.
  void _handleNotificationTap(Map<String, dynamic> data) {
    final type = data['type'];
    if (type == 'chat_message') {
      final conversationId = data['conversationId'];
      if (conversationId != null) {
        _appRouter.router.push('/chat/$conversationId');
      }
    } else if (type == 'invite_joined' || type == 'contact_accepted') {
      // Navigate to the messaging/contacts tab
      _appRouter.router.go('/home/messaging');
    }
  }

  /// Propagate the current user ID to security services that need it
  /// for audit logging, and prefetch earn data when authenticated.
  void _setupUserIdPropagation() {
    _authStateSubscription = _authBloc.stream.listen((state) {
      final userId = state.user?.id;
      _sessionLockService.setUserId(userId);
      _simChangeDetector.setUserId(userId);

      // Prefetch earn threads as soon as user is authenticated so the
      // Earn tab renders instantly instead of showing a loading spinner.
      if (state.status == AuthStatus.authenticated) {
        _earnBloc.add(const EarnEvent.loadThreads());
        _earnInboxBloc.add(const EarnInboxEvent.loadInbox());
      }
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
        // Clear notification tray — user is in the app now. The badge
        // notification is re-created with the correct unread count on
        // the next MainShell rebuild (via updateBadgeCount).
        NotificationService.clearDeliveredNotifications();
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
      // Discard any background timestamp so it doesn't linger and cause
      // a spurious lock after auth completes (e.g. user switched to SMS
      // app during OTP flow, came back, then authenticated).
      _sessionLockService.discardBackgroundTimestamp();
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
        BlocProvider<ConversationBloc>.value(value: _conversationBloc),
        BlocProvider<ConversationActionsBloc>.value(value: _conversationActionsBloc),
        BlocProvider<UserSearchBloc>.value(value: _userSearchBloc),
        BlocProvider<CommunityBloc>.value(value: _communityBloc),
        BlocProvider<ContactBloc>.value(value: _contactBloc),
        BlocProvider<PotBloc>.value(value: _potBloc),
        BlocProvider<PurchaseBloc>.value(value: _purchaseBloc),
        BlocProvider<ReferralBloc>.value(value: _referralBloc),
        BlocProvider<RewardBloc>.value(value: _rewardBloc),
        BlocProvider<EarnInboxBloc>.value(value: _earnInboxBloc),
        BlocProvider<CallBloc>.value(value: _callBloc),
        BlocProvider<GiftBloc>.value(value: _giftBloc),
        BlocProvider<TokenPoolBloc>.value(value: _tokenPoolBloc),
        BlocProvider<BuyTabBloc>.value(value: _buyTabBloc),
        BlocProvider<FeatureFlagBloc>.value(value: _featureFlagBloc),
        BlocProvider<MarketplaceBloc>.value(value: _marketplaceBloc),
        BlocProvider<OrderBloc>.value(value: _orderBloc),
        BlocProvider<GroupBuyBloc>.value(value: _groupBuyBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            !prev.keyRestoreFailed && curr.keyRestoreFailed,
        listener: (context, state) {
          // Show a one-time snackbar when E2EE key restore failed and fresh
          // keys were generated. Some older messages may not be decryptable.
          final messenger = ScaffoldMessenger.maybeOf(context);
          if (messenger != null) {
            messenger.showSnackBar(
              const SnackBar(
                content: Text(
                  'Message encryption keys could not be restored. '
                  'Some older messages may not be readable.',
                ),
                duration: Duration(seconds: 6),
              ),
            );
          }
        },
        child: MaterialApp.router(
          title: 'iMali',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          routerConfig: _appRouter.router,
          builder: (context, child) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.backgroundGradient,
                ),
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
