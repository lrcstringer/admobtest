import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/group_buy_card.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Browse active group buys (Hlangana deals) filtered by community.
class GroupBuyListScreen extends StatefulWidget {
  const GroupBuyListScreen({super.key});

  @override
  State<GroupBuyListScreen> createState() => _GroupBuyListScreenState();
}

class _GroupBuyListScreenState extends State<GroupBuyListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context
        .read<GroupBuyBloc>()
        .add(const GroupBuyEvent.loadActiveGroupBuys());
    context.read<GroupBuyBloc>().add(const GroupBuyEvent.loadMyGroupBuys());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Hlangana Deals'),
      body: Column(
        children: [
          // Tabs
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Active Deals'),
                Tab(text: 'My Deals'),
              ],
            ),
          ),

          // Body
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActiveDeals(),
                _buildMyDeals(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/buy/group-buys/create'),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textOnSecondary,
        icon: const Icon(Icons.add),
        label: const Text('Create Deal'),
      ),
    );
  }

  Widget _buildActiveDeals() {
    return BlocBuilder<GroupBuyBloc, GroupBuyState>(
      buildWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.activeGroupBuys != curr.activeGroupBuys ||
          prev.errorMessage != curr.errorMessage,
      builder: (context, state) {
        if (state.isLoading && state.activeGroupBuys.isEmpty) {
          return _buildShimmer();
        }

        if (state.errorMessage != null && state.activeGroupBuys.isEmpty) {
          return _buildError(state.errorMessage!);
        }

        if (state.activeGroupBuys.isEmpty) {
          return _buildEmpty(
            'No active deals',
            'Be the first to create a Hlangana deal for your community!',
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<GroupBuyBloc>()
                .add(const GroupBuyEvent.loadActiveGroupBuys());
            await context
                .read<GroupBuyBloc>()
                .stream
                .firstWhere((s) => !s.isLoading);
          },
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 80),
            itemCount: state.activeGroupBuys.length,
            itemBuilder: (context, index) {
              final gb = state.activeGroupBuys[index];
              return GroupBuyCard(
                groupBuy: gb,
                onTap: () => context.push('/buy/group-buys/${gb.id}'),
                onJoinTap: () => context.push('/buy/group-buys/${gb.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMyDeals() {
    return BlocBuilder<GroupBuyBloc, GroupBuyState>(
      buildWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.myGroupBuys != curr.myGroupBuys ||
          prev.errorMessage != curr.errorMessage,
      builder: (context, state) {
        if (state.isLoading && state.myGroupBuys.isEmpty) {
          return _buildShimmer();
        }

        if (state.myGroupBuys.isEmpty) {
          return _buildEmpty(
            'No deals yet',
            'Join a Hlangana deal to see it here.',
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<GroupBuyBloc>()
                .add(const GroupBuyEvent.loadMyGroupBuys());
            await context
                .read<GroupBuyBloc>()
                .stream
                .firstWhere((s) => !s.isLoading);
          },
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 80),
            itemCount: state.myGroupBuys.length,
            itemBuilder: (context, index) {
              final gb = state.myGroupBuys[index];
              return GroupBuyCard(
                groupBuy: gb,
                onTap: () => context.push('/buy/group-buys/${gb.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: 4,
        itemBuilder: (_, __) => Container(
          height: 160,
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton.icon(
              onPressed: () => context
                  .read<GroupBuyBloc>()
                  .add(const GroupBuyEvent.loadActiveGroupBuys()),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.groups_outlined,
              color: AppColors.textHint,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
