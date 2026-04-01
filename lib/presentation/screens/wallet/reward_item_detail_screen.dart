import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/security/secure_clipboard.dart';
import '../../../domain/entities/reward_item.dart';
import '../../../domain/enums/reward_enums.dart';
import '../../blocs/reward/reward_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

class RewardItemDetailScreen extends StatefulWidget {
  final String rewardId;

  const RewardItemDetailScreen({super.key, required this.rewardId});

  @override
  State<RewardItemDetailScreen> createState() => _RewardItemDetailScreenState();
}

class _RewardItemDetailScreenState extends State<RewardItemDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<RewardBloc>()
        .add(RewardEvent.loadItemDetail(widget.rewardId));
  }

  @override
  void dispose() {
    context.read<RewardBloc>().add(const RewardEvent.clearSelectedItem());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Reward Detail'),
      body: BlocConsumer<RewardBloc, RewardState>(
        listenWhen: (prev, curr) =>
            prev.redeemStatus != curr.redeemStatus ||
            prev.successMessage != curr.successMessage,
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context
                .read<RewardBloc>()
                .add(const RewardEvent.clearMessages());
          }
          if (state.redeemStatus == RewardLoadStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context
                .read<RewardBloc>()
                .add(const RewardEvent.clearMessages());
          }
        },
        builder: (context, state) {
          if (state.detailStatus == RewardLoadStatus.loading &&
              state.selectedItem == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.detailStatus == RewardLoadStatus.error &&
              state.selectedItem == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  AppSpacing.verticalMd,
                  Text(
                    state.errorMessage ?? 'Failed to load reward',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalLg,
                  AppButton(
                    text: 'Retry',
                    onPressed: () => context
                        .read<RewardBloc>()
                        .add(RewardEvent.loadItemDetail(widget.rewardId)),
                    isFullWidth: false,
                  ),
                ],
              ),
            );
          }

          final item = state.selectedItem;
          if (item == null) {
            return const Center(child: Text('Reward not found'));
          }

          return SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Client branding header
                _buildBrandingHeader(context, item),
                AppSpacing.verticalLg,

                // Campaign info
                _buildCampaignInfo(context, item),
                AppSpacing.verticalLg,

                // Code display — show spinner while decrypted code is loading
                if (item.hasCode) ...[
                  if (state.codeStatus == RewardLoadStatus.loading)
                    _buildCodeLoadingPlaceholder(context)
                  else if (state.codeStatus == RewardLoadStatus.error)
                    _buildCodeErrorPlaceholder(context, state.errorMessage)
                  else if (item.codeValue != null)
                    _buildCodeDisplay(context, item),
                ],

                // Redemption instructions
                if (item.redemptionInstructions != null) ...[
                  AppSpacing.verticalLg,
                  _buildInstructions(context, item),
                ],

                // Expiry info
                if (item.expiresAt != null && item.isUsable) ...[
                  AppSpacing.verticalLg,
                  _buildExpiryCard(context, item),
                ],

                AppSpacing.verticalXl,

                // Action button
                _buildActionButton(context, item, state),

                // Terms & conditions
                if (item.termsAndConditions != null) ...[
                  AppSpacing.verticalLg,
                  _buildTerms(context, item),
                ],

                AppSpacing.verticalXl,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandingHeader(BuildContext context, RewardItem item) {
    final brandColor = item.clientAvatarColor != null
        ? Color(int.parse('0xFF${item.clientAvatarColor!.replaceFirst('#', '')}'))
        : AppColors.primary;

    return Column(
      children: [
        // Brand color accent bar
        Container(
          height: 4,
          width: 80,
          decoration: BoxDecoration(
            color: brandColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        AppSpacing.verticalMd,
        // Client avatar / name
        if (item.clientAvatarImage != null)
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(item.clientAvatarImage!),
          )
        else
          CircleAvatar(
            radius: 28,
            backgroundColor: brandColor.withValues(alpha: 0.15),
            child: Text(
              (item.clientName ?? 'R').substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: brandColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        AppSpacing.verticalSm,
        Text(
          item.clientName ?? '',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildCampaignInfo(BuildContext context, RewardItem item) {
    return Column(
      children: [
        Text(
          item.campaignName ?? 'Reward',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.verticalXs,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            item.rewardType?.displayName ?? 'Reward',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  /// Try to parse Digital Content JSON: {"url":"...","accessCode":"..."}
  /// Returns null if not valid Digital Content JSON.
  Map<String, String>? _parseDigitalContent(String codeValue) {
    try {
      final parsed = jsonDecode(codeValue);
      if (parsed is Map && parsed.containsKey('url')) {
        return {
          'url': parsed['url'] as String? ?? '',
          if (parsed['accessCode'] != null)
            'accessCode': parsed['accessCode'] as String,
        };
      }
    } catch (_) {
      // Not JSON — treat as plain code
    }
    return null;
  }

  Widget _buildCodeLoadingPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: const Column(
        children: [
          SizedBox(height: 8),
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text('Loading your code...'),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCodeErrorPlaceholder(BuildContext context, String? message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.06),
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 28),
          const SizedBox(height: 8),
          Text(
            message ?? 'Failed to load code',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context
                .read<RewardBloc>()
                .add(RewardEvent.loadItemDetail(widget.rewardId)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeDisplay(BuildContext context, RewardItem item) {
    // Check if this is a Digital Content item with structured JSON
    final digitalContent = item.rewardType == RewardType.digitalContent
        ? _parseDigitalContent(item.codeValue!)
        : null;

    if (digitalContent != null) {
      return _buildDigitalContentDisplay(context, digitalContent);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        children: [
          if (item.isQrType) ...[
            // QR code display
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: QrImageView(
                data: item.codeValue!,
                version: QrVersions.auto,
                size: 200,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              'Show this QR code to redeem',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ] else ...[
            // Text code display
            Text(
              'Your Code',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: SelectableText(
                item.codeValue!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            AppSpacing.verticalMd,
            TextButton.icon(
              onPressed: () {
                SecureClipboard.copy(item.codeValue!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Code copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copy Code'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDigitalContentDisplay(
      BuildContext context, Map<String, String> content) {
    final url = content['url'] ?? '';
    final accessCode = content['accessCode'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        children: [
          // URL section
          if (url.isNotEmpty) ...[
            Text(
              'Download / Access URL',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: SelectableText(
                url,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                    ),
              ),
            ),
            AppSpacing.verticalSm,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final uri = Uri.tryParse(url);
                    if (uri != null && await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Open Link'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    SecureClipboard.copy(url);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('URL copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 18),
                  label: const Text('Copy URL'),
                ),
              ],
            ),
          ],

          // Access code section
          if (accessCode != null && accessCode.isNotEmpty) ...[
            if (url.isNotEmpty) ...[
              AppSpacing.verticalMd,
              Divider(color: Theme.of(context).colorScheme.outline),
              AppSpacing.verticalMd,
            ],
            Text(
              'Access Code',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: SelectableText(
                accessCode,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            AppSpacing.verticalMd,
            TextButton.icon(
              onPressed: () {
                SecureClipboard.copy(accessCode);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Access code copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copy Code'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstructions(BuildContext context, RewardItem item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 18),
              const SizedBox(width: 8),
              Text(
                'How to Redeem',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          Text(
            item.redemptionInstructions!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryCard(BuildContext context, RewardItem item) {
    final hours = item.hoursUntilExpiry;
    final days = item.daysUntilExpiry;
    final isUrgent = hours != null && hours < 24;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppColors.error.withValues(alpha: 0.08)
            : AppColors.warning.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            color: isUrgent ? AppColors.error : AppColors.warning,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isUrgent
                ? 'Expires in ${hours}h — use it now!'
                : 'Expires in $days day${days == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isUrgent ? AppColors.error : AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    RewardItem item,
    RewardState state,
  ) {
    if (item.status == RewardItemStatus.redeemed) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.1),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 8),
            Text(
              'Used on ${_formatDate(item.redeemedAt!)}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    if (item.status == RewardItemStatus.expired) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer_off, color: AppColors.error, size: 20),
            const SizedBox(width: 8),
            Text(
              'Expired',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.error,
                  ),
            ),
          ],
        ),
      );
    }

    // Active — show "Mark as Used" button
    final isRedeeming = state.redeemStatus == RewardLoadStatus.loading;

    return AppButton(
      text: 'Mark as Used',
      onPressed: isRedeeming ? null : () => _confirmRedeem(context, item),
      isLoading: isRedeeming,
    );
  }

  void _confirmRedeem(BuildContext context, RewardItem item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Mark as Used?'),
        content: const Text(
          'Have you used this reward? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          AppButton(
            text: 'Yes, I Used It',
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<RewardBloc>()
                  .add(RewardEvent.redeemItem(item.id));
            },
            isFullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTerms(BuildContext context, RewardItem item) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        'Terms & Conditions',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            item.termsAndConditions!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.5,
                ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
