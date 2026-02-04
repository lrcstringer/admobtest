import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/group.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../blocs/group/group_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  GroupType _selectedType = GroupType.stokvel;
  ContributionCycle _contributionCycle = ContributionCycle.monthly;
  int _contributionAmount = 1000; // 10 ZAR default
  int _approvalThreshold = 5000; // 50 ZAR default
  bool _allowMemberWithdrawals = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state.operationStatus == GroupOperationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'Group created!'),
                backgroundColor: AppColors.success,
              ),
            );
            context.go('/groups');
          } else if (state.operationStatus == GroupOperationStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<GroupBloc>().add(const GroupEvent.clearError());
          }
        },
        builder: (context, state) {
          final isLoading = state.operationStatus == GroupOperationStatus.processing;

          return Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Group Type Selection
                      Text(
                        'Group Type',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      AppSpacing.verticalSm,
                      _buildTypeSelector(),
                      AppSpacing.verticalLg,

                      // Group Name
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Group Name',
                          hintText: 'Enter a name for your group',
                          prefixIcon: Icon(Icons.group),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a group name';
                          }
                          if (value.trim().length < 3) {
                            return 'Name must be at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      AppSpacing.verticalMd,

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'What is this group about?',
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      AppSpacing.verticalLg,

                      // Settings Section
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      AppSpacing.verticalSm,

                      // Contribution Settings (for Stokvels)
                      if (_selectedType == GroupType.stokvel) ...[
                        Card(
                          child: Padding(
                            padding: AppSpacing.cardPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contribution Schedule',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                AppSpacing.verticalSm,
                                DropdownButtonFormField<ContributionCycle>(
                                  value: _contributionCycle,
                                  decoration: const InputDecoration(
                                    labelText: 'Cycle',
                                    prefixIcon: Icon(Icons.repeat),
                                  ),
                                  items: ContributionCycle.values
                                      .where((c) => c != ContributionCycle.none)
                                      .map((cycle) => DropdownMenuItem(
                                            value: cycle,
                                            child: Text(cycle.name.toUpperCase()),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => _contributionCycle = value);
                                    }
                                  },
                                ),
                                AppSpacing.verticalMd,
                                TextFormField(
                                  initialValue: (_contributionAmount / 100).toString(),
                                  decoration: const InputDecoration(
                                    labelText: 'Contribution Amount (ZAR)',
                                    prefixIcon: Icon(Icons.attach_money),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    final amount = double.tryParse(value);
                                    if (amount != null) {
                                      setState(() => _contributionAmount = (amount * 100).round());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppSpacing.verticalMd,
                      ],

                      // Approval Threshold
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.approval, color: AppColors.primary),
                          title: const Text('Approval Required Above'),
                          subtitle: Text(
                            'R${(_approvalThreshold / 100).toStringAsFixed(2)}',
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: TextFormField(
                              initialValue: (_approvalThreshold / 100).toString(),
                              decoration: const InputDecoration(
                                prefixText: 'R',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                final amount = double.tryParse(value);
                                if (amount != null) {
                                  setState(() => _approvalThreshold = (amount * 100).round());
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.verticalMd,

                      // Allow Member Withdrawals
                      Card(
                        child: SwitchListTile(
                          secondary: Icon(
                            Icons.account_balance_wallet,
                            color: AppColors.primary,
                          ),
                          title: const Text('Allow Member Withdrawals'),
                          subtitle: const Text(
                            'Members can withdraw their own contributions',
                          ),
                          value: _allowMemberWithdrawals,
                          onChanged: (value) {
                            setState(() => _allowMemberWithdrawals = value);
                          },
                        ),
                      ),
                      AppSpacing.verticalXl,

                      // Create Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _createGroup,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              isLoading ? 'Creating...' : 'Create Group',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.verticalLg,
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: GroupType.values.map((type) {
        final isSelected = type == _selectedType;
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getTypeIcon(type),
                size: 18,
                color: isSelected ? Colors.white : _getTypeColor(type),
              ),
              const SizedBox(width: 4),
              Text(_getTypeName(type)),
            ],
          ),
          selected: isSelected,
          selectedColor: _getTypeColor(type),
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedType = type;
                // Reset contribution settings for non-stokvel types
                if (type != GroupType.stokvel) {
                  _contributionCycle = ContributionCycle.none;
                  _contributionAmount = 0;
                  _allowMemberWithdrawals = true;
                } else {
                  _contributionCycle = ContributionCycle.monthly;
                  _contributionAmount = 1000;
                  _allowMemberWithdrawals = false;
                }
              });
            }
          },
        );
      }).toList(),
    );
  }

  void _createGroup() {
    if (!_formKey.currentState!.validate()) return;

    final settings = GroupSettings(
      requireApprovalAbove: _approvalThreshold,
      allowMemberWithdrawals: _allowMemberWithdrawals,
      contributionCycle: _selectedType == GroupType.stokvel
          ? _contributionCycle
          : ContributionCycle.none,
      contributionAmount: _selectedType == GroupType.stokvel
          ? _contributionAmount
          : 0,
      penaltyPercentage: _selectedType == GroupType.stokvel ? 5 : 0,
    );

    final params = CreateGroupParams(
      type: _selectedType,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      settings: settings,
    );

    context.read<GroupBloc>().add(GroupEvent.createGroup(params: params));
  }

  IconData _getTypeIcon(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return Icons.savings;
      case GroupType.family:
        return Icons.family_restroom;
      case GroupType.organization:
        return Icons.business;
      case GroupType.club:
        return Icons.groups;
    }
  }

  Color _getTypeColor(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return AppColors.primary;
      case GroupType.family:
        return AppColors.success;
      case GroupType.organization:
        return AppColors.secondary;
      case GroupType.club:
        return AppColors.tertiary;
    }
  }

  String _getTypeName(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return 'Stokvel';
      case GroupType.family:
        return 'Family';
      case GroupType.organization:
        return 'Organization';
      case GroupType.club:
        return 'Club';
    }
  }
}
