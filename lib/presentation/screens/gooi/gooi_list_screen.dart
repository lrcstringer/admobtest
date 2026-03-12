import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/gooi_group_status.dart';
import '../../blocs/gooi/gooi_list_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gooi/gooi_group_tile.dart';

class GooiListScreen extends StatefulWidget {
  const GooiListScreen({super.key});

  @override
  State<GooiListScreen> createState() => _GooiListScreenState();
}

class _GooiListScreenState extends State<GooiListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GooiListBloc>().add(const GooiListEvent.loadGroups());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gooi-Gooi'),
        actions: [
          PopupMenuButton<GooiGroupStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) {
              context.read<GooiListBloc>().add(GooiListEvent.filterByStatus(status));
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: null, child: Text('All')),
              const PopupMenuItem(value: GooiGroupStatus.forming, child: Text('Forming')),
              const PopupMenuItem(value: GooiGroupStatus.active, child: Text('Active')),
              const PopupMenuItem(value: GooiGroupStatus.completed, child: Text('Completed')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<GooiListBloc, GooiListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.filteredGroups.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () => context.read<GooiListBloc>().add(const GooiListEvent.loadGroups()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.filteredGroups.isEmpty) {
            return _buildEmptyState(context);
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<GooiListBloc>().add(const GooiListEvent.refreshGroups());
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: state.filteredGroups.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final group = state.filteredGroups[index];
                return GooiGroupTile(
                  group: group,
                  onTap: () => context.push('/chat/gooi/${group.id}'),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/chat/gooi/create'),
        icon: const Icon(Icons.add),
        label: const Text('New Group'),
        backgroundColor: AppColors.teal,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.groups_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No Gooi-Gooi groups yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Start a rotating savings group with people you trust. '
              'Everyone contributes, and each member takes a turn receiving the full pot.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: () => context.push('/chat/gooi/create'),
              icon: const Icon(Icons.add),
              label: const Text('Create Your First Group'),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
