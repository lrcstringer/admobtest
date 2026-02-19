import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/member_role.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Screen to invite a user to a community by their user ID.
class InviteMemberScreen extends StatefulWidget {
  final String communityId;

  const InviteMemberScreen({super.key, required this.communityId});

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  MemberRole _selectedRole = MemberRole.member;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.operationStatus == CommunityOperationStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? 'Invitation sent!'),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        } else if (state.operationStatus == CommunityOperationStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to invite'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final isLoading =
            state.operationStatus == CommunityOperationStatus.processing;

        return Scaffold(
          appBar: AppBar(title: const Text('Invite Member')),
          body: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: AppColors.primary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Enter the user ID of the person you want to invite.',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primary,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalLg,

                  // User ID
                  TextFormField(
                    controller: _userIdController,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      hintText: 'Enter user ID',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a user ID';
                      }
                      return null;
                    },
                  ),
                  AppSpacing.verticalLg,

                  // Role selector
                  Text(
                    'Role',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  RadioGroup<MemberRole>(
                    groupValue: _selectedRole,
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedRole = v);
                    },
                    child: Column(
                      children: MemberRole.values
                          .where((r) => r != MemberRole.owner)
                          .map((role) => RadioListTile<MemberRole>(
                                title: Text(_roleLabel(role)),
                                subtitle: Text(_roleDescription(role)),
                                value: role,
                                toggleable: false,
                              ))
                          .toList(),
                    ),
                  ),
                  AppSpacing.verticalLg,

                  // Submit
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _invite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Send Invitation'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _invite() {
    if (!_formKey.currentState!.validate()) return;

    context.read<CommunityBloc>().add(
          CommunityEvent.inviteMember(
            communityId: widget.communityId,
            userId: _userIdController.text.trim(),
            role: _selectedRole,
          ),
        );
  }

  String _roleLabel(MemberRole role) {
    switch (role) {
      case MemberRole.owner:
        return 'Owner';
      case MemberRole.admin:
        return 'Admin';
      case MemberRole.treasurer:
        return 'Treasurer';
      case MemberRole.member:
        return 'Member';
      case MemberRole.viewer:
        return 'Viewer';
    }
  }

  String _roleDescription(MemberRole role) {
    switch (role) {
      case MemberRole.owner:
        return 'Full control';
      case MemberRole.admin:
        return 'Manage members and settings';
      case MemberRole.treasurer:
        return 'Approve transactions';
      case MemberRole.member:
        return 'Chat and contribute';
      case MemberRole.viewer:
        return 'Read-only access';
    }
  }
}
