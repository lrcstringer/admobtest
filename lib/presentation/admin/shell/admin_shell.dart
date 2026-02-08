import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/admin_auth_cubit.dart';
import '../../theme/app_colors.dart';

/// Admin portal shell with sidebar navigation
class AdminShell extends StatelessWidget {
  final Widget child;

  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          _AdminSidebar(currentPath: currentPath),

          // Divider
          const VerticalDivider(width: 1, thickness: 1),

          // Main content
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _AdminSidebar extends StatelessWidget {
  final String currentPath;

  const _AdminSidebar({required this.currentPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: AppColors.cardDark,
      child: Column(
        children: [
          // Logo/Header
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'iMali Admin',
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
                _NavItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  label: 'Dashboard',
                  path: '/',
                  isSelected: currentPath == '/',
                ),
                _NavItem(
                  icon: Icons.account_balance_outlined,
                  selectedIcon: Icons.account_balance,
                  label: 'Ledger Recon',
                  path: '/ledger',
                  isSelected: currentPath == '/ledger',
                ),
                _NavItem(
                  icon: Icons.emoji_events_outlined,
                  selectedIcon: Icons.emoji_events,
                  label: 'Pot Management',
                  path: '/pots',
                  isSelected: currentPath == '/pots',
                ),
                _NavItem(
                  icon: Icons.people_outline,
                  selectedIcon: Icons.people,
                  label: 'User Management',
                  path: '/users',
                  isSelected: currentPath == '/users',
                ),
                _NavItem(
                  icon: Icons.payments_outlined,
                  selectedIcon: Icons.payments,
                  label: 'Cashout Approvals',
                  path: '/cashouts',
                  isSelected: currentPath == '/cashouts',
                ),

                // Account Management section
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    'ACCOUNT MANAGEMENT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                _NavItem(
                  icon: Icons.business_outlined,
                  selectedIcon: Icons.business,
                  label: 'Suppliers',
                  path: '/suppliers',
                  isSelected: currentPath == '/suppliers',
                ),
                _NavItem(
                  icon: Icons.business_center_outlined,
                  selectedIcon: Icons.business_center,
                  label: 'Clients (Brands)',
                  path: '/clients',
                  isSelected: currentPath == '/clients',
                ),

                // Earn Management section
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    'EARN MANAGEMENT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                _NavItem(
                  icon: Icons.campaign_outlined,
                  selectedIcon: Icons.campaign,
                  label: 'Campaigns',
                  path: '/earn',
                  isSelected: currentPath == '/earn' ||
                      currentPath.startsWith('/earn/'),
                ),
              ],
            ),
          ),

          // User info & logout
          const Divider(height: 1),
          BlocBuilder<AdminAuthCubit, AdminAuthState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        state.displayName?.isNotEmpty == true
                            ? state.displayName![0].toUpperCase()
                            : state.email?.isNotEmpty == true
                                ? state.email![0].toUpperCase()
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
                            state.displayName ?? state.email ?? 'Admin',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Administrator',
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
              );
            },
          ),
        ],
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
