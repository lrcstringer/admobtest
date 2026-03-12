import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/gooi_cycle_status.dart';
import '../../../domain/enums/gooi_payout_status.dart';
import '../../blocs/gooi/gooi_dashboard_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiHistoryScreen extends StatelessWidget {
  final String groupId;
  const GooiHistoryScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: BlocBuilder<GooiDashboardBloc, GooiDashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.actionError != null && state.cycles.isEmpty) {
            return Center(
              child: Text('Failed to load history', style: TextStyle(color: Colors.red)),
            );
          }
          if (state.cycles.isEmpty) {
            return const Center(child: Text('No cycles yet'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: state.cycles.length,
            itemBuilder: (context, index) {
              final cycle = state.cycles[index];
              final payout = state.payouts
                  .where((p) => p.cycleId == cycle.id)
                  .firstOrNull;
              final recipient = state.members
                  .where((m) => m.userId == cycle.recipientUserId)
                  .firstOrNull;

              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: cycle.status.isTerminal
                        ? AppColors.teal
                        : AppColors.tealLight.withValues(alpha: 0.3),
                    child: Text('${cycle.cycleNumber}'),
                  ),
                  title: Text('Cycle ${cycle.cycleNumber}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recipient: ${recipient?.displayName ?? 'Unknown'}'),
                      Text('Status: ${cycle.status.name.toUpperCase()}'),
                      if (payout != null)
                        Text(
                          'Payout: R${(payout.totalPayoutAmount / 100).toStringAsFixed(0)} '
                          '(${payout.status == GooiPayoutStatus.completed ? 'Completed' : payout.status.name})',
                        ),
                      Text(
                        'Collected: R${(cycle.totalCollected / 100).toStringAsFixed(0)} '
                        '/ R${(cycle.totalExpected / 100).toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
