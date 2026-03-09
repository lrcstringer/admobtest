import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/admin_auth_cubit.dart';
import '../screens/accounts_action_screen.dart';
import '../screens/accounts_overview_screen.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/admin_login_screen.dart';
import '../screens/admin_user_management_screen.dart';
import '../screens/audit_log_screen.dart';
import '../screens/cashout_approval_screen.dart';
import '../screens/account_type_management_screen.dart';
import '../screens/client_management_screen.dart';
import '../screens/buy_category_management_screen.dart';
import '../screens/buy_purchase_monitoring_screen.dart';
import '../screens/brand_storefront_management_screen.dart';
import '../screens/marketplace_provider_management_screen.dart';
import '../screens/marketplace_listing_moderation_screen.dart';
import '../screens/marketplace_order_management_screen.dart';
import '../screens/marketplace_analytics_screen.dart';
import '../screens/group_buy_management_screen.dart';
import '../screens/escrow_overview_screen.dart';
import '../screens/earn_management_screen.dart';
import '../screens/feature_flag_management_screen.dart';
import '../screens/featured_content_management_screen.dart';
import '../screens/pending_actions_screen.dart';
import '../screens/reward_activity_screen.dart';
import '../screens/reward_campaign_screen.dart';
import '../screens/upload_review_screen.dart';
import '../screens/ledger_recon_screen.dart';
import '../screens/platform_management_screen.dart';
import '../screens/pot_entries_screen.dart';
import '../screens/pot_management_screen.dart';
import '../screens/supplier_management_screen.dart';
import '../screens/user_management_screen.dart';
import '../shell/admin_shell.dart';

/// Router for the Admin Portal
class AdminRouter {
  final AdminAuthCubit authCubit;

  AdminRouter({required this.authCubit});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
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

          // Pot Entries Viewer
          GoRoute(
            path: '/pot-entries',
            name: 'adminPotEntries',
            builder: (context, state) {
              final potId =
                  state.uri.queryParameters['potId'] ?? '';
              return PotEntriesScreen(potId: potId);
            },
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

          // Accounts Overview
          GoRoute(
            path: '/accounts',
            name: 'adminAccounts',
            builder: (context, state) => const AccountsOverviewScreen(),
          ),

          // Accounts Actions
          GoRoute(
            path: '/accounts-actions',
            name: 'adminAccountsActions',
            builder: (context, state) => const AccountsActionScreen(),
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

          // Account Type Management
          GoRoute(
            path: '/account-types',
            name: 'adminAccountTypes',
            builder: (context, state) =>
                const AccountTypeManagementScreen(),
          ),

          // Earn Management (Campaigns, Threads, Opportunities)
          GoRoute(
            path: '/earn',
            name: 'adminEarn',
            builder: (context, state) => const EarnManagementScreen(),
          ),

          // Upload Review Queue
          GoRoute(
            path: '/upload-reviews',
            name: 'adminUploadReviews',
            builder: (context, state) => const UploadReviewScreen(),
          ),

          // Reward Campaign Management
          GoRoute(
            path: '/rewards',
            name: 'adminRewards',
            builder: (context, state) => const RewardCampaignScreen(),
          ),

          // Reward Activity & Failed Allocations
          GoRoute(
            path: '/reward-activity',
            name: 'adminRewardActivity',
            builder: (context, state) => const RewardActivityScreen(),
          ),

          // Platform Management
          GoRoute(
            path: '/platform',
            name: 'adminPlatform',
            builder: (context, state) => const PlatformManagementScreen(),
          ),

          // Admin User Management (SuperAdmin only)
          GoRoute(
            path: '/admin-users',
            name: 'adminUserManagement',
            builder: (context, state) =>
                const AdminUserManagementScreen(),
          ),

          // Audit Logs
          GoRoute(
            path: '/audit-logs',
            name: 'adminAuditLogs',
            builder: (context, state) => const AuditLogScreen(),
          ),

          // Pending Actions (Maker-Checker approval queue)
          GoRoute(
            path: '/pending-actions',
            name: 'adminPendingActions',
            builder: (context, state) => const PendingActionsScreen(),
          ),

          // Buy Management
          GoRoute(
            path: '/buy-feature-flags',
            name: 'adminBuyFeatureFlags',
            builder: (context, state) =>
                const FeatureFlagManagementScreen(),
          ),
          GoRoute(
            path: '/buy-categories',
            name: 'adminBuyCategories',
            builder: (context, state) =>
                const BuyCategoryManagementScreen(),
          ),
          GoRoute(
            path: '/buy-purchases',
            name: 'adminBuyPurchases',
            builder: (context, state) =>
                const BuyPurchaseMonitoringScreen(),
          ),
          GoRoute(
            path: '/buy-featured',
            name: 'adminBuyFeatured',
            builder: (context, state) =>
                const FeaturedContentManagementScreen(),
          ),
          GoRoute(
            path: '/buy-brand-storefronts',
            name: 'adminBuyBrandStorefronts',
            builder: (context, state) =>
                const BrandStorefrontManagementScreen(),
          ),
          GoRoute(
            path: '/buy-providers',
            name: 'adminBuyProviders',
            builder: (context, state) =>
                const MarketplaceProviderManagementScreen(),
          ),
          GoRoute(
            path: '/buy-listings',
            name: 'adminBuyListings',
            builder: (context, state) =>
                const MarketplaceListingModerationScreen(),
          ),
          GoRoute(
            path: '/buy-orders',
            name: 'adminBuyOrders',
            builder: (context, state) =>
                const MarketplaceOrderManagementScreen(),
          ),
          GoRoute(
            path: '/buy-analytics',
            name: 'adminBuyAnalytics',
            builder: (context, state) =>
                const MarketplaceAnalyticsScreen(),
          ),
          GoRoute(
            path: '/buy-group-buys',
            name: 'adminBuyGroupBuys',
            builder: (context, state) =>
                const GroupBuyManagementScreen(),
          ),
          GoRoute(
            path: '/buy-escrow',
            name: 'adminBuyEscrow',
            builder: (context, state) =>
                const EscrowOverviewScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AdminAuthCubit>().state;
      final isAuthenticated = authState.isAuthenticated;
      final isOnLogin = state.matchedLocation == '/login';

      // Not authenticated -> login
      if (!isAuthenticated && !isOnLogin) {
        return '/login';
      }

      // Authenticated on login page -> dashboard
      if (isAuthenticated && isOnLogin) {
        return '/';
      }

      // Role-based route guard
      if (isAuthenticated && authState.roles.isNotEmpty) {
        if (!isRouteAllowed(state.matchedLocation, authState.roles)) {
          return '/';
        }
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
