import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/admin_login_screen.dart';
import '../screens/cashout_approval_screen.dart';
import '../screens/client_management_screen.dart';
import '../screens/ledger_recon_screen.dart';
import '../screens/pot_management_screen.dart';
import '../screens/supplier_management_screen.dart';
import '../screens/user_management_screen.dart';
import '../shell/admin_shell.dart';

/// Router for the Admin Portal
class AdminRouter {
  final AuthBloc authBloc;

  AdminRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      // Login screen
      GoRoute(
        path: '/login',
        name: 'adminLogin',
        builder: (context, state) => const AdminLoginScreen(),
      ),

      // Admin shell with sidebar navigation
      ShellRoute(
        builder: (context, state, child) => AdminShell(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: '/',
            name: 'adminDashboard',
            builder: (context, state) => const AdminDashboardScreen(),
          ),

          // Ledger Reconciliation
          GoRoute(
            path: '/ledger',
            name: 'adminLedger',
            builder: (context, state) => const LedgerReconScreen(),
          ),

          // Pot Management
          GoRoute(
            path: '/pots',
            name: 'adminPots',
            builder: (context, state) => const PotManagementScreen(),
          ),

          // User Management
          GoRoute(
            path: '/users',
            name: 'adminUsers',
            builder: (context, state) => const UserManagementScreen(),
          ),

          // Cashout Approvals
          GoRoute(
            path: '/cashouts',
            name: 'adminCashouts',
            builder: (context, state) => const CashoutApprovalScreen(),
          ),

          // Supplier Management
          GoRoute(
            path: '/suppliers',
            name: 'adminSuppliers',
            builder: (context, state) => const SupplierManagementScreen(),
          ),

          // Client (Brand Partner) Management
          GoRoute(
            path: '/clients',
            name: 'adminClients',
            builder: (context, state) => const ClientManagementScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isOnLogin = state.matchedLocation == '/login';

      // TODO: Implement proper admin role check using Firebase custom claims
      // For now, allow any authenticated user in development
      // In production, check: authState.user?.customClaims?['admin'] == true

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
