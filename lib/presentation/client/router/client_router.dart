import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../screens/client_analytics_screen.dart';
import '../screens/client_campaigns_screen.dart';
import '../screens/client_dashboard_screen.dart';
import '../screens/client_login_screen.dart';
import '../shell/client_shell.dart';

/// Router for the Client/Brand Portal
class ClientRouter {
  final AuthBloc authBloc;

  ClientRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      // Login screen
      GoRoute(
        path: '/login',
        name: 'clientLogin',
        builder: (context, state) => const ClientLoginScreen(),
      ),

      // Client shell with sidebar navigation
      ShellRoute(
        builder: (context, state, child) => ClientShell(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: '/',
            name: 'clientDashboard',
            builder: (context, state) => const ClientDashboardScreen(),
          ),

          // Campaigns
          GoRoute(
            path: '/campaigns',
            name: 'clientCampaigns',
            builder: (context, state) => const ClientCampaignsScreen(),
          ),

          // Analytics
          GoRoute(
            path: '/analytics',
            name: 'clientAnalytics',
            builder: (context, state) => const ClientAnalyticsScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isOnLogin = state.matchedLocation == '/login';

      // TODO: Implement proper brand/client role check using Firebase custom claims
      // For now, allow any authenticated user in development
      // In production, check: authState.user?.customClaims?['brand'] == true

      // Not authenticated -> login
      if (!isAuthenticated && !isOnLogin) {
        return '/login';
      }

      // Authenticated on login page -> dashboard
      if (isAuthenticated && isOnLogin) {
        return '/';
      }

      return null;
    },
  );
}

/// A [ChangeNotifier] that listens to a [Stream] and notifies listeners
/// when the stream emits.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
