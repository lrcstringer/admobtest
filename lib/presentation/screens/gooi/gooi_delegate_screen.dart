import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/gooi_member_status.dart';
import '../../blocs/gooi/gooi_dashboard_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GooiDelegateScreen extends StatefulWidget {
  final String groupId;
  const GooiDelegateScreen({super.key, required this.groupId});

  @override
  State<GooiDelegateScreen> createState() => _GooiDelegateScreenState();
}

class _GooiDelegateScreenState extends State<GooiDelegateScreen> {
  String? _selectedMemberId;
  final _daysController = TextEditingController(text: '7');

  @override
  void dispose() {
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delegate Trigger')),
      body: BlocConsumer<GooiDashboardBloc, GooiDashboardState>(
        listener: (context, state) {
          if (state.actionSuccess != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionSuccess!)),
            );
          }
          if (state.actionError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final currentUserId = state.currentUserId;
          final eligibleMembers = state.members
              .where((m) => m.userId != currentUserId && m.status.isParticipating)
              .toList();

          final currentDelegate = state.members
              .where((m) => m.role.name == 'triggerDelegate')
              .firstOrNull;

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (currentDelegate != null) ...[
                  Card(
                    color: AppColors.teal.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: AppColors.teal),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Current delegate: ${currentDelegate.displayName}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          TextButton(
                            onPressed: state.isActionInProgress
                                ? null
                                : () => context.read<GooiDashboardBloc>().add(
                                      const GooiDashboardEvent.revokeDelegation(),
                                    ),
                            child: const Text('Revoke', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                Text('Select a member to delegate trigger rights:',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: AppSpacing.md),
                ...eligibleMembers.map((m) => RadioListTile<String>(
                      value: m.userId,
                      // ignore: deprecated_member_use
                      groupValue: _selectedMemberId,
                      // ignore: deprecated_member_use
                      onChanged: (v) => setState(() => _selectedMemberId = v),
                      title: Text(m.displayName),
                      activeColor: AppColors.teal,
                    )),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _daysController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (days)',
                    helperText: 'Between 1 and 14 days',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    final days = int.tryParse(value ?? '') ?? 0;
                    if (days < 1 || days > 14) return 'Must be between 1 and 14';
                    return null;
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _selectedMemberId != null && !state.isActionInProgress
                      ? () {
                          final days = (int.tryParse(_daysController.text) ?? 7).clamp(1, 14);
                          context.read<GooiDashboardBloc>().add(
                                GooiDashboardEvent.delegateTrigger(
                                  delegateUserId: _selectedMemberId!,
                                  durationDays: days,
                                ),
                              );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Delegate'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
