import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/earn_opportunity.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Opportunity preview screen before starting an engagement
/// Shows details, requirements, and reward breakdown
class EarnDetailScreen extends StatelessWidget {
  final String? opportunityId;

  const EarnDetailScreen({super.key, this.opportunityId});

  @override
  Widget build(BuildContext context) {
    // Get opportunity from extra or from BLoC state
    final extraOpportunity =
        GoRouterState.of(context).extra as EarnOpportunity?;

    return BlocBuilder<EarnBloc, EarnState>(
      builder: (context, state) {
        final opportunity =
            extraOpportunity ?? state.selectedOpportunity;

        if (opportunity == null) {
          return Scaffold(
            appBar: IMaliAppBar(title: 'Opportunity'),
            body: const WaveBackground(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: IMaliAppBar(
            title: opportunity.title,
          ),
          body: WaveBackground(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header card with client info
                  _buildHeaderCard(context, opportunity),
                  SizedBox(height: AppSpacing.md),

                  // Reward card
                  _buildRewardCard(context, opportunity),
                  SizedBox(height: AppSpacing.md),

                  // Details card
                  _buildDetailsCard(context, opportunity),
                  SizedBox(height: AppSpacing.md),

                  // Requirements card
                  _buildRequirementsCard(context, opportunity),
                  SizedBox(height: AppSpacing.lg),

                  // User engagement status
                  if (opportunity.isCompletedByUser)
                    _buildCompletedBanner(context)
                  else if (opportunity.isInProgressByUser)
                    _buildInProgressBanner(context, opportunity)
                  else
                    _buildStartButton(context, opportunity),

                  SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard(BuildContext context, EarnOpportunity opportunity) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildClientAvatar(opportunity),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opportunity.clientName ?? 'Brand',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Row(
                        children: [
                          _buildTypeChip(context, opportunity),
                          if (opportunity.expiresAt != null) ...[
                            SizedBox(width: AppSpacing.sm),
                            _buildExpiryChip(context, opportunity),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (opportunity.description != null) ...[
              SizedBox(height: AppSpacing.md),
              Text(
                opportunity.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, EarnOpportunity opportunity) {
    final totalTokens = opportunity.tokenReward;
    final userTokens = (totalTokens * 0.90).round();
    final dailyPotTokens = (totalTokens * 0.05).round();
    final weeklyPotTokens = (totalTokens * 0.05).round();

    return Card(
      color: AppColors.primaryLight.withValues(alpha: 0.3),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // Total reward
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 40,
                  color: AppColors.gold,
                ),
                SizedBox(width: AppSpacing.sm),
                Text(
                  '+$totalTokens',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(width: AppSpacing.xs),
                Text(
                  'tokens',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            Divider(),
            SizedBox(height: AppSpacing.sm),

            // Breakdown preview
            Text(
              'Distribution Preview',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBreakdownItem(
                  context,
                  icon: Icons.account_balance_wallet,
                  label: 'You',
                  tokens: userTokens,
                  percentage: '90%',
                  color: AppColors.primary,
                ),
                _buildBreakdownItem(
                  context,
                  icon: Icons.today,
                  label: 'Daily',
                  tokens: dailyPotTokens,
                  percentage: '5%',
                  color: AppColors.secondary,
                ),
                _buildBreakdownItem(
                  context,
                  icon: Icons.emoji_events,
                  label: 'Weekly',
                  tokens: weeklyPotTokens,
                  percentage: '5%',
                  color: AppColors.gold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int tokens,
    required String percentage,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: AppSpacing.xs),
        Text(
          '+$tokens',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          '$label ($percentage)',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(BuildContext context, EarnOpportunity opportunity) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.md),
            _buildDetailRow(
              context,
              icon: Icons.timer_outlined,
              label: 'Duration',
              value: opportunity.formattedDuration,
            ),
            SizedBox(height: AppSpacing.sm),
            _buildDetailRow(
              context,
              icon: Icons.category_outlined,
              label: 'Type',
              value: opportunity.earningTypeLabel,
            ),
            SizedBox(height: AppSpacing.sm),
            _buildDetailRow(
              context,
              icon: Icons.quiz_outlined,
              label: 'Questions',
              value: '${opportunity.questions.length} question${opportunity.questions.length == 1 ? '' : 's'}',
            ),
            if (opportunity.mediaType == MediaType.video) ...[
              SizedBox(height: AppSpacing.sm),
              _buildDetailRow(
                context,
                icon: Icons.play_circle_outline,
                label: 'Media',
                value: 'Video',
              ),
            ],
            if (opportunity.expiresAt != null) ...[
              SizedBox(height: AppSpacing.sm),
              _buildDetailRow(
                context,
                icon: Icons.schedule,
                label: 'Expires',
                value: _formatExpiry(opportunity.expiresAt!),
                valueColor: opportunity.daysUntilExpiry != null &&
                        opportunity.daysUntilExpiry! <= 1
                    ? AppColors.error
                    : null,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
        ),
      ],
    );
  }

  Widget _buildRequirementsCard(
      BuildContext context, EarnOpportunity opportunity) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What You Need to Do',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.md),
            _buildRequirementItem(
              context,
              number: 1,
              text: opportunity.mediaType == MediaType.video
                  ? 'Watch the video for at least ${opportunity.durationSeconds} seconds'
                  : 'View the content carefully',
            ),
            _buildRequirementItem(
              context,
              number: 2,
              text: opportunity.questions.isNotEmpty
                  ? 'Answer ${opportunity.questions.length} question${opportunity.questions.length == 1 ? '' : 's'} about what you saw'
                  : 'Complete the engagement',
            ),
            _buildRequirementItem(
              context,
              number: 3,
              text: 'Tokens are credited instantly upon completion',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(
    BuildContext context, {
    required int number,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedBanner(BuildContext context) {
    return Card(
      color: AppColors.success.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.success,
            ),
            SizedBox(width: AppSpacing.sm),
            Text(
              'You\'ve completed this opportunity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.success,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInProgressBanner(
      BuildContext context, EarnOpportunity opportunity) {
    return Column(
      children: [
        Card(
          color: AppColors.warning.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_top,
                  color: AppColors.warning,
                ),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'You have an engagement in progress',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.warning,
                      ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        AppButton(
          text: 'Continue',
          onPressed: () => _navigateToInteraction(context, opportunity),
          icon: Icons.play_arrow,
        ),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context, EarnOpportunity opportunity) {
    return AppButton(
      text: 'Start Earning',
      onPressed: () => _navigateToInteraction(context, opportunity),
      icon: Icons.play_arrow,
    );
  }

  void _navigateToInteraction(
      BuildContext context, EarnOpportunity opportunity) {
    context.push('/earn/opportunity/${opportunity.id}');
  }

  Widget _buildClientAvatar(EarnOpportunity opportunity) {
    final color = AppColors.parseHex(opportunity.clientAvatarColor);

    final initials = opportunity.clientName != null &&
            opportunity.clientName!.isNotEmpty
        ? opportunity.clientName!.split(' ').map((w) => w[0]).take(2).join()
        : '??';

    return CircleAvatar(
      radius: 28,
      backgroundColor: color,
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTypeChip(BuildContext context, EarnOpportunity opportunity) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        opportunity.earningTypeLabel,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildExpiryChip(BuildContext context, EarnOpportunity opportunity) {
    final daysLeft = opportunity.daysUntilExpiry;
    final isUrgent = daysLeft != null && daysLeft <= 1;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppColors.error.withValues(alpha: 0.1)
            : AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 12,
            color: isUrgent ? AppColors.error : AppColors.warning,
          ),
          SizedBox(width: 4),
          Text(
            isUrgent
                ? 'Expires soon'
                : '${daysLeft ?? '?'} days left',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isUrgent ? AppColors.error : AppColors.warning,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  String _formatExpiry(DateTime expiresAt) {
    final now = DateTime.now();
    final diff = expiresAt.difference(now);

    if (diff.isNegative) {
      return 'Expired';
    } else if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        return '${diff.inMinutes} minutes';
      }
      return '${diff.inHours} hours';
    } else if (diff.inDays == 1) {
      return 'Tomorrow';
    } else {
      return '${diff.inDays} days';
    }
  }
}
