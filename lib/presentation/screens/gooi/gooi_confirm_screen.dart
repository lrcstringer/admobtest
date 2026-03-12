import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/gooi/gooi_formation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiConfirmScreen extends StatefulWidget {
  final String groupId;
  const GooiConfirmScreen({super.key, required this.groupId});

  @override
  State<GooiConfirmScreen> createState() => _GooiConfirmScreenState();
}

class _GooiConfirmScreenState extends State<GooiConfirmScreen> {
  bool _accepted = false;

  @override
  void initState() {
    super.initState();
    context.read<GooiFormationBloc>().add(GooiFormationEvent.loadGroup(widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Activation')),
      body: BlocConsumer<GooiFormationBloc, GooiFormationState>(
        listener: (context, state) {
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionSuccess!)),
            );
            if (state.group?.status.name == 'active') {
              context.go('/chat/gooi/${widget.groupId}');
            }
          }
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final group = state.group;
          if (group == null) {
            return const Center(child: Text('Group not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(group.name, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: AppSpacing.sm),
                        _InfoRow('Contribution', 'R${(group.contributionAmount / 100).toStringAsFixed(0)} per cycle'),
                        _InfoRow('Frequency', group.cycleFrequency.name.toUpperCase()),
                        _InfoRow('Total Cycles', '${group.totalCycles}'),
                        _InfoRow('Members', '${state.members.length}'),
                        _InfoRow('Roster Method', group.rosterMethod.name.toUpperCase()),
                        _InfoRow('Grace Period', '${group.gracePeriodHours}h'),
                        _InfoRow('Late Fee', '${group.lateFeePercent}%'),
                        _InfoRow('Recipient Contributes', group.recipientContributes ? 'Yes' : 'No'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Card(
                  color: AppColors.teal.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Terms', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: AppSpacing.sm),
                        const Text(
                          '• You commit to contributing each cycle on time\n'
                          '• Late contributions may incur a fee\n'
                          '• Missed contributions create debt against your name\n'
                          '• Withdrawal requires group vote (80% approval)\n'
                          '• Reserve fund contributions (3%) are non-refundable on removal\n'
                          '• The initiator manages payouts and group rules',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                CheckboxListTile(
                  value: _accepted,
                  onChanged: (v) => setState(() => _accepted = v ?? false),
                  title: const Text('I understand and accept the terms'),
                  activeColor: AppColors.teal,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: _accepted && !state.isActionInProgress
                      ? () => context.read<GooiFormationBloc>().add(
                            const GooiFormationEvent.confirmActivation(),
                          )
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: state.isActionInProgress
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Confirm & Activate'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
