import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/earn_opportunity.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';

class EarnThreadScreen extends StatefulWidget {
  final String threadId;

  const EarnThreadScreen({super.key, required this.threadId});

  @override
  State<EarnThreadScreen> createState() => _EarnThreadScreenState();
}

class _EarnThreadScreenState extends State<EarnThreadScreen> {
  @override
  void initState() {
    super.initState();
    // Always reload so counters and statuses are fresh after completing
    // an opportunity and navigating back.
    context.read<EarnBloc>().add(EarnEvent.selectThread(widget.threadId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EarnBloc, EarnState>(
      builder: (context, state) {
        final thread = state.selectedThread;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: IMaliAppBar(
            title: thread?.title ?? 'Opportunities',
          ),
          body: TabBackground(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.themed(context).tabGradient,
            ),
            overlayAsset: null,
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, EarnState state) {
    if (state.opportunitiesStatus == EarnStatus.loading) {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.opportunitiesStatus == EarnStatus.error) {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              AppSpacing.verticalMd,
              Text(
                'Failed to load opportunities',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              AppSpacing.verticalSm,
              AppButton(
                text: 'Retry',
                onPressed: () {
                  context
                      .read<EarnBloc>()
                      .add(EarnEvent.loadOpportunities(threadId: widget.threadId));
                },
                isFullWidth: false,
              ),
            ],
          ),
        ),
      );
    }

    if (state.opportunities.isEmpty) {
      return _buildEmptyState(context);
    }

    // Sort: active opportunities first (pinned/featured on top), completed last
    final sorted = List<EarnOpportunity>.from(state.opportunities)
      ..sort((a, b) {
        final aCompleted = a.isCompletedByUser;
        final bCompleted = b.isCompletedByUser;
        // Active before completed
        if (aCompleted != bCompleted) return aCompleted ? 1 : -1;
        // Within active: pinned first, then featured
        if (!aCompleted) {
          if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
          if (a.isFeatured != b.isFeatured) return a.isFeatured ? -1 : 1;
        }
        return 0; // preserve original order otherwise
      });

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<EarnBloc>()
            .add(EarnEvent.loadOpportunities(threadId: widget.threadId));
      },
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md + MediaQuery.of(context).padding.top + kToolbarHeight,
          AppSpacing.md,
          AppSpacing.md,
        ),
        itemCount: sorted.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildThreadHeader(context, state);
          }
          final opportunity = sorted[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOpportunityCard(context, opportunity),
          );
        },
      ),
    );
  }

  Widget _buildThreadHeader(BuildContext context, EarnState state) {
    final thread = state.selectedThread;
    if (thread == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildClientAvatar(context, thread.clientName,
                  thread.threadImage ?? thread.clientAvatarImage, thread.clientAvatarColor),
              AppSpacing.horizontalMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBrandedClientName(context, thread.clientName),
                    if (thread.description != null) ...[
                      AppSpacing.verticalXs,
                      Text(
                        thread.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.85),
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          Row(
            children: [
              _buildStatChip(
                context,
                '${state.opportunities.length}',
                'Opportunities',
                Icons.play_circle_outline,
                AppColors.success,
              ),
              AppSpacing.horizontalSm,
              _buildStatChip(
                context,
                '${state.opportunities.where((o) => o.isCompletedByUser).length}',
                'Completed',
                Icons.check_circle_outline,
                AppColors.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientAvatar(
    BuildContext context,
    String name,
    String? imageUrl,
    String? colorHex,
  ) {
    final color = AppColors.parseHex(colorHex);

    if (imageUrl != null) {
      return CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(imageUrl),
      );
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'C',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildBrandedClientName(BuildContext context, String name) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );

    if (name.startsWith('iMali')) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'iMali',
              style: style?.copyWith(color: AppColors.gold),
            ),
            TextSpan(
              text: name.substring(5),
              style: style,
            ),
          ],
        ),
      );
    }
    return Text(name, style: style);
  }

  Widget _buildStatChip(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            color.withValues(alpha: 0.15),
            Theme.of(context).colorScheme.surface,
          ),
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityCard(BuildContext context, EarnOpportunity opportunity) {
    final isCompleted = opportunity.isCompletedByUser;
    final isInProgress = opportunity.isInProgressByUser;

    // Green gradient for uncompleted, orange gradient for completed
    final accentColors = isCompleted
        ? AppColors.tertiaryGradient // gold-orange
        : [AppColors.success, AppColors.successDark]; // green

    return InkWell(
      onTap: isCompleted
          ? null
          : () => _startOpportunity(context, opportunity),
      borderRadius: AppSpacing.borderRadiusLg,
      child: ClipRRect(
        borderRadius: AppSpacing.borderRadiusLg,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: accentColors[0].withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              // Top color bar (pot-card style)
              Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: accentColors),
                ),
              ),
              // Card content
              Padding(
                padding: AppSpacing.cardPadding,
                child: Row(
                  children: [
                    _buildOpportunityIcon(opportunity),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (opportunity.isPinned)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.push_pin,
                                    size: 12,
                                    color: accentColors[0],
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  opportunity.title,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              if (opportunity.isFeatured)
                                Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: AppSpacing.borderRadiusSm,
                                  ),
                                  child: Text(
                                    'Featured',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9,
                                        ),
                                  ),
                                ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: accentColors[0].withValues(alpha: 0.15),
                                  borderRadius: AppSpacing.borderRadiusSm,
                                ),
                                child: Text(
                                  '${opportunity.tokenReward} tokens',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: accentColors[0],
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalXs,
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                opportunity.formattedDuration,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: AppSpacing.borderRadiusSm,
                                  border: Border.all(color: Theme.of(context).colorScheme.outline),
                                ),
                                child: Text(
                                  opportunity.earningTypeLabel,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          if (opportunity.description != null) ...[
                            AppSpacing.verticalXs,
                            Text(
                              opportunity.description!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    AppSpacing.horizontalSm,
                    _buildOpportunityAction(context, opportunity, isCompleted, isInProgress),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpportunityIcon(EarnOpportunity opportunity) {
    final isCompleted = opportunity.isCompletedByUser;
    final accentColor = isCompleted ? AppColors.tertiary : AppColors.success;

    IconData icon;
    switch (opportunity.earningType) {
      case EarningType.survey:
        icon = Icons.quiz_outlined;
        break;
      case EarningType.video:
        icon = Icons.smart_display_outlined;
        break;
      case EarningType.image:
        icon = Icons.image_outlined;
        break;
      case EarningType.poll:
        icon = Icons.poll_outlined;
        break;
      case EarningType.adVideo:
        icon = Icons.play_circle_outline;
        break;
      case EarningType.upload:
        icon = Icons.upload_outlined;
        break;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.15),
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Icon(
        icon,
        color: accentColor,
        size: 24,
      ),
    );
  }

  Widget _buildOpportunityAction(
    BuildContext context,
    EarnOpportunity opportunity,
    bool isCompleted,
    bool isInProgress,
  ) {
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: AppColors.success,
          size: 20,
        ),
      );
    }

    if (isInProgress) {
      return AppButton(
        text: 'Resume',
        onPressed: () => _resumeOpportunity(context, opportunity),
        isFullWidth: false,
        size: AppButtonSize.small,
      );
    }

    return Icon(
      Icons.chevron_right,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            AppSpacing.verticalLg,
            Text(
              'No opportunities available',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Check back later for new opportunities from this brand',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _startOpportunity(BuildContext context, EarnOpportunity opportunity) {
    // Pre-load ad for adVideo opportunities so it's ready when watch screen renders
    if (opportunity.earningType == EarningType.adVideo) {
      context.read<EarnBloc>().add(const EarnEvent.loadAdVideo());
    }

    // Navigate to interaction screen — engagement starts when user taps "Start Earning"
    context.push('/earn/opportunity/${opportunity.id}');
  }

  void _resumeOpportunity(BuildContext context, EarnOpportunity opportunity) {
    // Resume existing engagement
    context.push('/earn/opportunity/${opportunity.id}');
  }
}
