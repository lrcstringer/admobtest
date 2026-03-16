import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/admin_auth_cubit.dart';
import '../../theme/app_colors.dart';

/// Route → allowed roles map. `'*'` means all roles.
const routeRoles = <String, List<String>>{
  '/': ['*'],
  '/pots': ['superAdmin', 'financeAdmin', 'platformAdmin'],
  '/users': ['superAdmin', 'financeAdmin', 'auditor'],
  '/cashouts': ['superAdmin', 'financeAdmin'],
  '/accounts': ['superAdmin', 'financeAdmin', 'auditor'],
  '/ledger': ['superAdmin', 'financeAdmin', 'platformAdmin', 'auditor'],
  '/accounts-actions': ['superAdmin', 'financeAdmin', 'platformAdmin'],
  '/suppliers': ['superAdmin', 'financeAdmin'],
  '/clients': ['superAdmin', 'financeAdmin', 'campaignAdmin', 'auditor'],
  '/account-types': ['superAdmin', 'financeAdmin', 'campaignAdmin', 'auditor'],
  '/earn': ['superAdmin', 'campaignAdmin'],
  '/upload-reviews': ['superAdmin', 'campaignAdmin'],
  '/rewards': ['superAdmin', 'campaignAdmin', 'auditor'],
  '/reward-activity': ['superAdmin', 'campaignAdmin', 'auditor'],
  '/platform': ['superAdmin', 'platformAdmin'],
  '/admin-users': ['superAdmin'],
  '/audit-logs': [
    'superAdmin',
    'financeAdmin',
    'campaignAdmin',
    'platformAdmin',
    'auditor',
  ],
  '/pending-actions': ['superAdmin', 'financeAdmin'],
  '/buy-feature-flags': ['superAdmin', 'platformAdmin'],
  '/marketplace-categories': ['superAdmin', 'platformAdmin'],
  '/buy-vas-categories': ['superAdmin', 'platformAdmin'],
  '/buy-purchases': ['superAdmin', 'financeAdmin', 'auditor'],
  '/buy-featured': ['superAdmin', 'campaignAdmin'],
  '/buy-brand-storefronts': ['superAdmin', 'campaignAdmin'],
  '/buy-providers': ['superAdmin', 'platformAdmin'],
  '/buy-listings': ['superAdmin', 'platformAdmin'],
  '/buy-orders': ['superAdmin', 'financeAdmin', 'auditor'],
  '/buy-analytics': ['superAdmin', 'financeAdmin', 'auditor'],
  '/buy-group-buys': ['superAdmin', 'financeAdmin'],
  '/buy-escrow': ['superAdmin', 'financeAdmin', 'auditor'],
  '/buy-storefront-builder': ['superAdmin', 'campaignAdmin'],
  '/buy-vas-providers': ['superAdmin', 'platformAdmin'],
  '/buy-vas-products': ['superAdmin', 'platformAdmin'],
  '/buy-purchase-monitoring': ['superAdmin', 'financeAdmin'],
  '/gooi-management': ['superAdmin', 'financeAdmin'],
  '/gooi-config': ['superAdmin'],
  '/gooi-debts': ['superAdmin', 'financeAdmin'],
};

/// Whether a route is visible for the given roles.
bool isRouteAllowed(String path, List<String> roles) {
  if (roles.isEmpty) return false;
  if (roles.contains('superAdmin')) return true;
  final allowed = routeRoles[path];
  if (allowed == null) return false;
  if (allowed.contains('*')) return true;
  return roles.any((role) => allowed.contains(role));
}

/// Human-readable display name for a single role.
String _singleRoleDisplayName(String role) {
  switch (role) {
    case 'platformAdmin':
      return 'Platform Admin';
    case 'superAdmin':
      return 'Super Admin';
    case 'financeAdmin':
      return 'Finance Admin';
    case 'campaignAdmin':
      return 'Campaign Admin';
    case 'auditor':
      return 'Auditor';
    default:
      return 'Administrator';
  }
}

/// Human-readable display name for multiple roles.
String rolesDisplayName(List<String> roles) {
  if (roles.isEmpty) return 'Administrator';
  return roles.map(_singleRoleDisplayName).join(', ');
}

/// Admin portal shell with sidebar navigation.
///
/// Wraps content with a [Listener] to reset the inactivity timer
/// on any pointer-down event.
class AdminShell extends StatelessWidget {
  final Widget child;

  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).matchedLocation;

    return Listener(
      onPointerDown: (_) =>
          context.read<AdminAuthCubit>().resetInactivityTimer(),
      child: Scaffold(
        backgroundColor: AppColors.adminBackground,
        body: Row(
          children: [
            _AdminSidebar(currentPath: currentPath),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _AdminSidebar extends StatelessWidget {
  final String currentPath;

  const _AdminSidebar({required this.currentPath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminAuthCubit, AdminAuthState>(
      builder: (context, authState) {
        final roles = authState.roles;

        return Container(
          width: 260,
          color: AppColors.adminSidebar,
          child: Column(
            children: [
              // Logo/Header
              Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/iMaliCrown4.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'iMaliChat Admin',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Navigation items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    // ── Top section ──
                    if (isRouteAllowed('/', roles))
                      _NavItem(
                        icon: Icons.dashboard_outlined,
                        selectedIcon: Icons.dashboard,
                        label: 'Dashboard',
                        path: '/',
                        isSelected: currentPath == '/',
                      ),
                    if (isRouteAllowed('/pots', roles))
                      _NavItem(
                        icon: Icons.emoji_events_outlined,
                        selectedIcon: Icons.emoji_events,
                        label: 'Pot Management',
                        path: '/pots',
                        isSelected: currentPath == '/pots',
                      ),
                    if (isRouteAllowed('/users', roles))
                      _NavItem(
                        icon: Icons.people_outline,
                        selectedIcon: Icons.people,
                        label: 'User Management',
                        path: '/users',
                        isSelected: currentPath == '/users',
                      ),
                    if (isRouteAllowed('/cashouts', roles))
                      _NavItem(
                        icon: Icons.payments_outlined,
                        selectedIcon: Icons.payments,
                        label: 'Cashout Approvals',
                        path: '/cashouts',
                        isSelected: currentPath == '/cashouts',
                      ),

                    // ── ACCOUNT MANAGEMENT ──
                    if (_anySectionVisible(roles, [
                      '/accounts',
                      '/ledger',
                      '/accounts-actions',
                      '/suppliers',
                      '/clients',
                      '/account-types',
                    ]))
                      const _SectionHeader('ACCOUNT MANAGEMENT'),
                    if (isRouteAllowed('/accounts', roles))
                      _NavItem(
                        icon: Icons.account_balance_wallet_outlined,
                        selectedIcon: Icons.account_balance_wallet,
                        label: 'Accounts Overview',
                        path: '/accounts',
                        isSelected: currentPath == '/accounts',
                      ),
                    if (isRouteAllowed('/ledger', roles))
                      _NavItem(
                        icon: Icons.account_balance_outlined,
                        selectedIcon: Icons.account_balance,
                        label: 'Ledger Recon',
                        path: '/ledger',
                        isSelected: currentPath == '/ledger',
                      ),
                    if (isRouteAllowed('/accounts-actions', roles))
                      _NavItem(
                        icon: Icons.settings_suggest_outlined,
                        selectedIcon: Icons.settings_suggest,
                        label: 'Accounts Actions',
                        path: '/accounts-actions',
                        isSelected: currentPath == '/accounts-actions',
                      ),
                    if (isRouteAllowed('/suppliers', roles))
                      _NavItem(
                        icon: Icons.business_outlined,
                        selectedIcon: Icons.business,
                        label: 'Suppliers',
                        path: '/suppliers',
                        isSelected: currentPath == '/suppliers',
                      ),
                    if (isRouteAllowed('/clients', roles))
                      _NavItem(
                        icon: Icons.business_center_outlined,
                        selectedIcon: Icons.business_center,
                        label: 'Clients (Brands)',
                        path: '/clients',
                        isSelected: currentPath == '/clients',
                      ),
                    if (isRouteAllowed('/account-types', roles))
                      _NavItem(
                        icon: Icons.rule_outlined,
                        selectedIcon: Icons.rule,
                        label: 'Account Types',
                        path: '/account-types',
                        isSelected: currentPath == '/account-types',
                      ),

                    // ── EARN MANAGEMENT ──
                    if (_anySectionVisible(roles,
                        ['/earn', '/upload-reviews', '/rewards', '/reward-activity']))
                      const _SectionHeader('EARN MANAGEMENT'),
                    if (isRouteAllowed('/earn', roles))
                      _NavItem(
                        icon: Icons.campaign_outlined,
                        selectedIcon: Icons.campaign,
                        label: 'Campaigns',
                        path: '/earn',
                        isSelected: currentPath == '/earn' ||
                            currentPath.startsWith('/earn/'),
                      ),
                    if (isRouteAllowed('/upload-reviews', roles))
                      _NavItem(
                        icon: Icons.rate_review_outlined,
                        selectedIcon: Icons.rate_review,
                        label: 'Upload Reviews',
                        path: '/upload-reviews',
                        isSelected: currentPath == '/upload-reviews',
                      ),
                    if (isRouteAllowed('/rewards', roles))
                      _NavItem(
                        icon: Icons.card_giftcard_outlined,
                        selectedIcon: Icons.card_giftcard,
                        label: 'Reward Campaigns',
                        path: '/rewards',
                        isSelected: currentPath == '/rewards',
                      ),
                    if (isRouteAllowed('/reward-activity', roles))
                      _NavItem(
                        icon: Icons.history_outlined,
                        selectedIcon: Icons.history,
                        label: 'Reward Activity',
                        path: '/reward-activity',
                        isSelected: currentPath == '/reward-activity',
                      ),

                    // ── BUY MANAGEMENT ──
                    if (_anySectionVisible(roles, [
                      '/buy-featured',
                      '/buy-brand-storefronts',
                      '/marketplace-categories',
                      '/buy-vas-categories',
                      '/buy-purchases',
                      '/buy-vas-providers',
                      '/buy-providers',
                      '/buy-listings',
                      '/buy-group-buys',
                      '/buy-orders',
                      '/buy-analytics',
                      '/buy-escrow',
                      '/buy-feature-flags',
                    ]))
                      const _SectionHeader('BUY MANAGEMENT'),
                    if (isRouteAllowed('/buy-featured', roles))
                      _NavItem(
                        icon: Icons.star_outline,
                        selectedIcon: Icons.star,
                        label: 'Featured Content',
                        path: '/buy-featured',
                        isSelected: currentPath == '/buy-featured',
                      ),
                    if (isRouteAllowed('/buy-vas-categories', roles))
                      _NavItem(
                        icon: Icons.bolt_outlined,
                        selectedIcon: Icons.bolt,
                        label: 'VAS Categories',
                        path: '/buy-vas-categories',
                        isSelected: currentPath == '/buy-vas-categories',
                      ),
                    if (isRouteAllowed('/buy-vas-providers', roles))
                      _NavItem(
                        icon: Icons.electrical_services_outlined,
                        selectedIcon: Icons.electrical_services,
                        label: 'VAS Providers',
                        path: '/buy-vas-providers',
                        isSelected: currentPath == '/buy-vas-providers',
                      ),
                    if (isRouteAllowed('/buy-purchases', roles))
                      _NavItem(
                        icon: Icons.receipt_long_outlined,
                        selectedIcon: Icons.receipt_long,
                        label: 'VAS Purchases',
                        path: '/buy-purchases',
                        isSelected: currentPath == '/buy-purchases',
                      ),
                    if (isRouteAllowed('/buy-brand-storefronts', roles))
                      _NavItem(
                        icon: Icons.storefront_outlined,
                        selectedIcon: Icons.storefront,
                        label: 'Brand Storefronts',
                        path: '/buy-brand-storefronts',
                        isSelected: currentPath == '/buy-brand-storefronts',
                      ),
                    if (isRouteAllowed('/marketplace-categories', roles))
                      _NavItem(
                        icon: Icons.category_outlined,
                        selectedIcon: Icons.category,
                        label: 'Marketplace Categories',
                        path: '/marketplace-categories',
                        isSelected: currentPath == '/marketplace-categories',
                      ),
                    if (isRouteAllowed('/buy-providers', roles))
                      _NavItem(
                        icon: Icons.person_search_outlined,
                        selectedIcon: Icons.person_search,
                        label: 'Marketplace Providers',
                        path: '/buy-providers',
                        isSelected: currentPath == '/buy-providers',
                      ),
                    if (isRouteAllowed('/buy-analytics', roles))
                      _NavItem(
                        icon: Icons.analytics_outlined,
                        selectedIcon: Icons.analytics,
                        label: 'Marketplace Analytics',
                        path: '/buy-analytics',
                        isSelected: currentPath == '/buy-analytics',
                      ),
                    if (isRouteAllowed('/buy-listings', roles))
                      _NavItem(
                        icon: Icons.inventory_2_outlined,
                        selectedIcon: Icons.inventory_2,
                        label: 'Listings',
                        path: '/buy-listings',
                        isSelected: currentPath == '/buy-listings',
                      ),
                    if (isRouteAllowed('/buy-group-buys', roles))
                      _NavItem(
                        icon: Icons.group_work_outlined,
                        selectedIcon: Icons.group_work,
                        label: 'Group Buys',
                        path: '/buy-group-buys',
                        isSelected: currentPath == '/buy-group-buys',
                      ),
                    if (isRouteAllowed('/buy-orders', roles))
                      _NavItem(
                        icon: Icons.gavel_outlined,
                        selectedIcon: Icons.gavel,
                        label: 'Orders & Disputes',
                        path: '/buy-orders',
                        isSelected: currentPath == '/buy-orders',
                      ),
                    if (isRouteAllowed('/buy-escrow', roles))
                      _NavItem(
                        icon: Icons.account_balance_outlined,
                        selectedIcon: Icons.account_balance,
                        label: 'Escrow Overview',
                        path: '/buy-escrow',
                        isSelected: currentPath == '/buy-escrow',
                      ),
                    if (isRouteAllowed('/buy-feature-flags', roles))
                      _NavItem(
                        icon: Icons.flag_outlined,
                        selectedIcon: Icons.flag,
                        label: 'Feature Flags',
                        path: '/buy-feature-flags',
                        isSelected: currentPath == '/buy-feature-flags',
                      ),

                    // ── PLATFORM MANAGEMENT ──
                    if (_anySectionVisible(roles, [
                      '/platform',
                      '/admin-users',
                      '/audit-logs',
                      '/pending-actions',
                    ]))
                      const _SectionHeader('PLATFORM MANAGEMENT'),
                    if (isRouteAllowed('/platform', roles))
                      _NavItem(
                        icon: Icons.settings_applications_outlined,
                        selectedIcon: Icons.settings_applications,
                        label: 'Platform Setup',
                        path: '/platform',
                        isSelected: currentPath == '/platform',
                      ),
                    if (isRouteAllowed('/admin-users', roles))
                      _NavItem(
                        icon: Icons.admin_panel_settings_outlined,
                        selectedIcon: Icons.admin_panel_settings,
                        label: 'Admin Users',
                        path: '/admin-users',
                        isSelected: currentPath == '/admin-users',
                      ),
                    if (isRouteAllowed('/audit-logs', roles))
                      _NavItem(
                        icon: Icons.history_outlined,
                        selectedIcon: Icons.history,
                        label: 'Audit Logs',
                        path: '/audit-logs',
                        isSelected: currentPath == '/audit-logs',
                      ),
                    if (isRouteAllowed('/pending-actions', roles))
                      _NavItem(
                        icon: Icons.pending_actions_outlined,
                        selectedIcon: Icons.pending_actions,
                        label: 'Pending Actions',
                        path: '/pending-actions',
                        isSelected: currentPath == '/pending-actions',
                      ),
                  ],
                ),
              ),

              // User info & logout
              const Divider(height: 1),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        authState.displayName?.isNotEmpty == true
                            ? authState.displayName![0].toUpperCase()
                            : authState.email?.isNotEmpty == true
                                ? authState.email![0].toUpperCase()
                                : 'A',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            authState.displayName ??
                                authState.email ??
                                'Admin',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            rolesDisplayName(authState.roles),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, size: 20),
                      color: AppColors.textSecondary,
                      onPressed: () {
                        context.read<AdminAuthCubit>().signOut();
                      },
                      tooltip: 'Sign out',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static bool _anySectionVisible(List<String> roles, List<String> paths) {
    return paths.any((path) => isRouteAllowed(path, roles));
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String path;
  final bool isSelected;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.path,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => context.go(path),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  size: 22,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
