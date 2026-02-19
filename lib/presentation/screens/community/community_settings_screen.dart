import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/community.dart';
import '../../../domain/repositories/community_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/community/community_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Settings screen for an existing community.
///
/// Shows community info and settings. Admins can edit, owner can delete.
class CommunitySettingsScreen extends StatefulWidget {
  final String communityId;

  const CommunitySettingsScreen({super.key, required this.communityId});

  @override
  State<CommunitySettingsScreen> createState() =>
      _CommunitySettingsScreenState();
}

class _CommunitySettingsScreenState extends State<CommunitySettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  late bool _onlyAdminsPost;
  late bool _membersCanShareMedia;
  late bool _allowMemberInvites;
  late bool _allowMemberWithdrawals;
  late int _requireApprovalAbove;

  bool _initialised = false;

  void _initFromCommunity(Community community) {
    if (_initialised) return;
    _initialised = true;
    _nameController.text = community.name;
    _descriptionController.text = community.description ?? '';
    _onlyAdminsPost = community.settings.onlyAdminsPost;
    _membersCanShareMedia = community.settings.membersCanShareMedia;
    _allowMemberInvites = community.settings.allowMemberInvites;
    _allowMemberWithdrawals = community.settings.allowMemberWithdrawals;
    _requireApprovalAbove = community.settings.requireApprovalAbove;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.operationStatus == CommunityOperationStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? 'Settings updated!'),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        } else if (state.operationStatus == CommunityOperationStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Update failed'),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CommunityBloc>().add(const CommunityEvent.clearError());
        }
      },
      builder: (context, state) {
        final community = state.selectedCommunity;
        if (community == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        _initFromCommunity(community);

        final isAdmin = community.isAdmin(currentUserId);
        final isOwner = community.isOwner(currentUserId);
        final isLoading =
            state.operationStatus == CommunityOperationStatus.processing;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Community Settings'),
            actions: [
              if (isAdmin)
                TextButton(
                  onPressed: isLoading ? null : () => _saveSettings(community),
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Community Info ──
                  _buildInfoSection(context, community, isAdmin),
                  AppSpacing.verticalLg,

                  // ── Chat Settings ──
                  _buildSectionHeader(context, 'Chat Settings'),
                  AppSpacing.verticalSm,
                  _buildSwitchTile(
                    title: 'Only Admins Can Post',
                    subtitle: 'Regular members can only read messages',
                    value: _onlyAdminsPost,
                    enabled: isAdmin,
                    onChanged: (v) => setState(() => _onlyAdminsPost = v),
                  ),
                  _buildSwitchTile(
                    title: 'Members Can Share Media',
                    subtitle: 'Allow photos and voice messages',
                    value: _membersCanShareMedia,
                    enabled: isAdmin,
                    onChanged: (v) =>
                        setState(() => _membersCanShareMedia = v),
                  ),
                  AppSpacing.verticalLg,

                  // ── Membership ──
                  _buildSectionHeader(context, 'Membership'),
                  AppSpacing.verticalSm,
                  _buildSwitchTile(
                    title: 'Allow Member Invites',
                    subtitle: 'Members can invite others to join',
                    value: _allowMemberInvites,
                    enabled: isAdmin,
                    onChanged: (v) =>
                        setState(() => _allowMemberInvites = v),
                  ),
                  _buildInfoRow(
                    context,
                    'Members',
                    '${community.memberCount} / ${community.settings.maxMembers}',
                  ),
                  _buildInfoRow(
                    context,
                    'Type',
                    community.isStokvel ? 'Stokvel' : 'Regular',
                  ),
                  AppSpacing.verticalLg,

                  // ── Financial Settings ──
                  if (community.hasFinancials) ...[
                    _buildSectionHeader(context, 'Financial Settings'),
                    AppSpacing.verticalSm,
                    _buildSwitchTile(
                      title: 'Allow Member Withdrawals',
                      subtitle: 'Members can withdraw their contributions',
                      value: _allowMemberWithdrawals,
                      enabled: isAdmin,
                      onChanged: (v) =>
                          setState(() => _allowMemberWithdrawals = v),
                    ),
                    _buildInfoRow(
                      context,
                      'Approval Threshold',
                      'R${(_requireApprovalAbove / 100).toStringAsFixed(2)}',
                    ),
                    _buildInfoRow(
                      context,
                      'Contribution Cycle',
                      community.settings.contributionCycle,
                    ),
                    if (community.settings.contributionAmount > 0)
                      _buildInfoRow(
                        context,
                        'Contribution Amount',
                        'R${(community.settings.contributionAmount / 100).toStringAsFixed(2)}',
                      ),
                    AppSpacing.verticalLg,
                  ],

                  // ── Danger Zone ──
                  if (isOwner) ...[
                    _buildSectionHeader(
                        context, 'Danger Zone', color: AppColors.error),
                    AppSpacing.verticalSm,
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _confirmDelete(context, community),
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Delete Community'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    AppSpacing.verticalLg,
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    Community community,
    bool isAdmin,
  ) {
    return Column(
      children: [
        // Avatar
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            backgroundImage: community.avatarUrl != null
                ? NetworkImage(community.avatarUrl!)
                : null,
            child: community.avatarUrl == null
                ? Text(
                    community.displayInitials,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                : null,
          ),
        ),
        AppSpacing.verticalMd,

        // Name
        TextFormField(
          controller: _nameController,
          enabled: isAdmin,
          decoration: InputDecoration(
            labelText: 'Community Name',
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          maxLength: 50,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Name is required';
            if (v.trim().length < 3) return 'At least 3 characters';
            return null;
          },
        ),
        AppSpacing.verticalSm,

        // Description
        TextFormField(
          controller: _descriptionController,
          enabled: isAdmin,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          maxLength: 200,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title,
      {Color? color}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: enabled ? onChanged : null,
      activeThumbColor: AppColors.primary,
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  void _saveSettings(Community community) {
    if (!_formKey.currentState!.validate()) return;

    final params = UpdateCommunityParams(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      settings: CommunitySettings(
        maxMembers: community.settings.maxMembers,
        onlyAdminsPost: _onlyAdminsPost,
        membersCanShareMedia: _membersCanShareMedia,
        allowMemberInvites: _allowMemberInvites,
        enableFinancials: community.settings.enableFinancials,
        requireApprovalAbove: _requireApprovalAbove,
        allowMemberWithdrawals: _allowMemberWithdrawals,
        contributionCycle: community.settings.contributionCycle,
        contributionAmount: community.settings.contributionAmount,
        penaltyPercentage: community.settings.penaltyPercentage,
      ),
    );

    context.read<CommunityBloc>().add(
          CommunityEvent.updateCommunity(
            communityId: widget.communityId,
            params: params,
          ),
        );
  }

  void _confirmDelete(BuildContext context, Community community) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Community?'),
        content: Text(
          'This will permanently delete "${community.name}" and all its data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CommunityBloc>().add(
                    CommunityEvent.deleteCommunity(
                        communityId: widget.communityId),
                  );
              context.go('/chat');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
