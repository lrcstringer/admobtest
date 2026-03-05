import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/member_role.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Screen to invite a user to a community by searching for them.
class InviteMemberScreen extends StatefulWidget {
  final String communityId;

  const InviteMemberScreen({super.key, required this.communityId});

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  MemberRole _selectedRole = MemberRole.member;

  /// Selected contact from the picker.
  Map<String, String>? _selectedContact;

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
          context
              .read<CommunityBloc>()
              .add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final isLoading =
            state.operationStatus == CommunityOperationStatus.processing;

        return Scaffold(
          appBar: const IMaliAppBar(title: 'Invite Member'),
          body: WaveBackground(
            child: SingleChildScrollView(
              padding: AppSpacing.pagePadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact picker
                    Text(
                      'Who to invite',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    AppSpacing.verticalSm,
                    InkWell(
                      onTap: _pickContact,
                      borderRadius: AppSpacing.borderRadiusMd,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.chatSurface,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(
                            color: _selectedContact != null
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (_selectedContact != null) ...[
                              CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    AppColors.primary.withValues(alpha: 0.2),
                                child: Text(
                                  _initials(_selectedContact!['name'] ?? ''),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _selectedContact!['name'] ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Icon(Icons.swap_horiz,
                                  color: AppColors.textHint, size: 20),
                            ] else ...[
                              Icon(Icons.person_search,
                                  color: AppColors.textHint, size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Search for a contact',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.textHint,
                                      ),
                                ),
                              ),
                              Icon(Icons.chevron_right,
                                  color: AppColors.textHint, size: 20),
                            ],
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.verticalLg,

                    // Role selector — only shown after a contact is selected
                    if (_selectedContact != null) ...[
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
                              .where((r) =>
                                  r != MemberRole.owner &&
                                  r != MemberRole.treasurer)
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
                    ],

                    // Submit
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isLoading || _selectedContact == null
                                ? null
                                : _invite,
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
                                  color: AppColors.textOnPrimary,
                                ),
                              )
                            : const Text('Send Invitation'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickContact() async {
    final result = await context.push<Map<String, String>>(
      '/chat/pick-contact',
    );
    if (result != null && mounted) {
      setState(() => _selectedContact = result);
    }
  }

  void _invite() {
    // 8.6 Validate contact has required 'id' and 'name' keys
    if (_selectedContact == null ||
        !_selectedContact!.containsKey('id') ||
        !_selectedContact!.containsKey('name')) {
      return;
    }

    final userId = _selectedContact!['id'];
    if (userId == null || userId.isEmpty) {
      return;
    }

    context.read<CommunityBloc>().add(
          CommunityEvent.inviteMember(
            communityId: widget.communityId,
            userId: userId,
            role: _selectedRole,
          ),
        );
  }

  String _initials(String name) {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
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
