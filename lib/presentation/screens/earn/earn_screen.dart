import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/earn_notification.dart';
import '../../../domain/entities/inbox_client.dart';
import '../../../domain/entities/inbox_thread.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../blocs/earn_inbox/earn_inbox_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/tab_background.dart';
import '../../widgets/earn/engagement_history_sheet.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  /// Client IDs where "Expiring Soon" filter is active
  final _expiringSoonFilter = <String>{};

  @override
  void initState() {
    super.initState();
    context.read<EarnInboxBloc>().add(const EarnInboxEvent.loadInbox());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'Earn',
        extraActions: [
          // Notification bell with unread badge
          BlocBuilder<EarnInboxBloc, EarnInboxState>(
            buildWhen: (prev, curr) =>
                prev.unreadNotificationCount != curr.unreadNotificationCount,
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_outlined,
                        color: Theme.of(context).colorScheme.onSurface),
                    onPressed: () => _showNotificationsSheet(context),
                  ),
                  if (state.unreadNotificationCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${state.unreadNotificationCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => EngagementHistorySheet.show(context),
          ),
        ],
      ),
      body: BlocListener<EarnBloc, EarnState>(
        listenWhen: (prev, curr) =>
            prev.engagementPhase != curr.engagementPhase,
        listener: (context, state) {
          // Refresh wallet + inbox when engagement completes
          if (state.engagementPhase == EngagementPhase.completed) {
            context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
            context
                .read<EarnInboxBloc>()
                .add(const EarnInboxEvent.refreshInbox());
          }
        },
        child: BlocConsumer<EarnInboxBloc, EarnInboxState>(
          listenWhen: (prev, curr) =>
              prev.errorMessage != curr.errorMessage &&
              curr.errorMessage != null,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context
                .read<EarnInboxBloc>()
                .add(const EarnInboxEvent.clearError());
          },
          buildWhen: (prev, curr) =>
              prev.status != curr.status ||
              prev.clients != curr.clients ||
              prev.expandedClientId != curr.expandedClientId ||
              prev.notifications != curr.notifications ||
              prev.dailyLimitReached != curr.dailyLimitReached,
          builder: (context, state) {
            if (state.status == EarnInboxStatus.loading &&
                state.clients.isEmpty) {
              return TabBackground(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.themed(context).tabGradient,
                  ),
                  overlayAsset: AppColors.themed(context).waveOverlay,
                  child: const Center(child: CircularProgressIndicator()));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<EarnInboxBloc>()
                    .add(const EarnInboxEvent.refreshInbox());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: TabBackground(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.themed(context).tabGradient,
                  ),
                  overlayAsset: AppColors.themed(context).waveOverlay,
                  child: Padding(
                    padding: AppSpacing.pagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Notification section (top 2)
                        if (state.hasNotifications)
                          _buildNotificationSection(context, state),
                        // Daily limit banner
                        if (state.dailyLimitReached) ...[
                          _buildDailyLimitBanner(context),
                          AppSpacing.verticalMd,
                        ],
                        // Client list
                        _buildClientList(context, state),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================================
  // Notification Section
  // =========================================================================

  Widget _buildNotificationSection(
      BuildContext context, EarnInboxState state) {
    final topNotifs = state.notifications.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (state.notifications.length > 2)
              GestureDetector(
                onTap: () => _showNotificationsSheet(context),
                child: Text(
                  'See all',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
          ],
        ),
        AppSpacing.verticalSm,
        ...topNotifs.map((n) => _buildNotificationTile(context, n)),
        AppSpacing.verticalMd,
      ],
    );
  }

  Widget _buildNotificationTile(BuildContext context, EarnNotification notif) {
    final icon = _notificationIcon(notif.type);
    final iconColor = _notificationColor(notif.type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _onNotificationTap(context, notif),
        borderRadius: AppSpacing.borderRadiusSm,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: notif.isUnread
                ? AppColors.primary.withValues(alpha: 0.08)
                : AppColors.surface,
            borderRadius: AppSpacing.borderRadiusSm,
            border: Border.all(
              color: notif.isUnread
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              AppSpacing.horizontalSm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notif.title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight:
                                notif.isUnread ? FontWeight.w600 : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      notif.body,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSm,
              Text(
                notif.timeAgo,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textHint,
                    ),
              ),
              if (notif.isUnread) ...[
                AppSpacing.horizontalXs,
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _notificationIcon(String type) {
    switch (type) {
      case 'new_client':
        return Icons.storefront;
      case 'new_thread':
        return Icons.campaign;
      case 'new_opportunity':
        return Icons.add_circle_outline;
      case 'expiry_warning':
        return Icons.timer;
      default:
        return Icons.notifications;
    }
  }

  Color _notificationColor(String type) {
    switch (type) {
      case 'new_client':
        return AppColors.secondary;
      case 'new_thread':
        return AppColors.primary;
      case 'new_opportunity':
        return AppColors.success;
      case 'expiry_warning':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  void _onNotificationTap(BuildContext context, EarnNotification notif) {
    // Mark as read
    if (notif.isUnread) {
      context
          .read<EarnInboxBloc>()
          .add(EarnInboxEvent.markNotificationRead(notificationId: notif.id));
    }

    // Navigate based on notification data
    final threadId = notif.data['threadId'] as String?;
    if (threadId != null) {
      context.read<EarnBloc>().add(EarnEvent.selectThread(threadId));
      context.push('/earn/thread/$threadId');
    }
  }

  void _showNotificationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        expand: false,
        builder: (_, scrollController) {
          return BlocBuilder<EarnInboxBloc, EarnInboxState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notifications',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (state.hasUnreadNotifications)
                          TextButton(
                            onPressed: () {
                              context.read<EarnInboxBloc>().add(
                                  const EarnInboxEvent
                                      .markAllNotificationsRead());
                            },
                            child: const Text('Mark all read'),
                          ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: state.notifications.isEmpty
                        ? Center(
                            child: Text(
                              'No notifications',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(12),
                            itemCount: state.notifications.length,
                            itemBuilder: (_, i) => _buildNotificationTile(
                                context, state.notifications[i]),
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // =========================================================================
  // Daily Limit Banner
  // =========================================================================

  Widget _buildDailyLimitBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.celebration, color: AppColors.success, size: 24),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good going!',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                ),
                AppSpacing.verticalXs,
                Text(
                  'You have reached the 30 completions per day limit. '
                  'This will reset at midnight tonight.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // Client List (Accordion)
  // =========================================================================

  Widget _buildClientList(BuildContext context, EarnInboxState state) {
    if (!state.hasClients && state.status != EarnInboxStatus.loading) {
      return _buildEmptyState(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Chat with brands, complete tasks, earn tokens.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Text(
              '${state.totalAvailableOpportunities} opportunities',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        AppSpacing.verticalMd,
        ...state.clients.map((client) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildClientCard(
                context,
                client,
                isExpanded: state.expandedClientId == client.clientId,
                isDisabled: state.dailyLimitReached,
              ),
            )),
      ],
    );
  }

  Widget _buildClientCard(
    BuildContext context,
    InboxClient client, {
    required bool isExpanded,
    bool isDisabled = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: client.isPinned
              ? AppColors.primary.withValues(alpha: 0.5)
              : client.isFeatured
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : AppColors.border,
          width: client.isPinned || client.isFeatured ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Client header (always visible)
          InkWell(
            onTap: () => context
                .read<EarnInboxBloc>()
                .add(EarnInboxEvent.toggleClient(clientId: client.clientId)),
            borderRadius: isExpanded
                ? const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.radiusMd))
                : AppSpacing.borderRadiusMd,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  _buildClientAvatar(context, client),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                client.clientName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (client.isPinned) ...[
                              AppSpacing.horizontalXs,
                              const Icon(Icons.push_pin,
                                  size: 14, color: AppColors.primary),
                            ],
                            if (client.isFeatured) ...[
                              AppSpacing.horizontalXs,
                              const Icon(Icons.star,
                                  size: 14, color: AppColors.accent),
                            ],
                          ],
                        ),
                        AppSpacing.verticalXxs,
                        Row(
                          children: [
                            Text(
                              '${client.activeThreadCount} campaign${client.activeThreadCount != 1 ? 's' : ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            if (client.totalTokens > 0) ...[
                              Text(
                                ' · ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.textHint),
                              ),
                              Icon(Icons.toll,
                                  size: 12, color: AppColors.gold),
                              const SizedBox(width: 3),
                              Text(
                                '${client.totalTokens} tokens',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.gold,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.expand_more,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded threads section
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: _buildThreadList(context, client, isDisabled),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildClientAvatar(BuildContext context, InboxClient client) {
    final color = AppColors.parseHex(client.clientAvatarColor);
    final imageUrl = client.clientAvatarImage;

    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 22,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => CircleAvatar(
          radius: 22,
          backgroundColor: color.withValues(alpha: 0.2),
          child: const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => _buildInitialsAvatar(
            context, client.clientInitials, color),
      );
    }

    return _buildInitialsAvatar(context, client.clientInitials, color);
  }

  Widget _buildInitialsAvatar(
      BuildContext context, String initials, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        initials,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  // =========================================================================
  // Thread List (inside expanded client)
  // =========================================================================

  Widget _buildThreadList(
      BuildContext context, InboxClient client, bool isDisabled) {
    if (client.threads.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Text(
          'No current uncompleted earn opportunities',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textHint,
              ),
        ),
      );
    }

    final expiringCount =
        client.threads.where((t) => t.isExpiringSoon).length;
    final showExpiring = _expiringSoonFilter.contains(client.clientId);

    // Filter threads based on selected chip, then sort completed to bottom
    final filteredThreads = showExpiring
        ? client.threads.where((t) => t.isExpiringSoon).toList()
        : client.threads.where((t) => !t.isExpiringSoon).toList()
      ..sort((a, b) {
        final aDone = a.allCompleted;
        final bDone = b.allCompleted;
        if (aDone != bDone) return aDone ? 1 : -1;
        if (!aDone) {
          if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
          if (a.isFeatured != b.isFeatured) return a.isFeatured ? -1 : 1;
        }
        return 0;
      });

    return Column(
      children: [
        const Divider(height: 1, indent: 14, endIndent: 14),
        // Filter chips (only show if there are expiring threads)
        if (expiringCount > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: 'Current Offers',
                  isSelected: !showExpiring,
                  onTap: () => setState(() {
                    _expiringSoonFilter.remove(client.clientId);
                  }),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Expiring Soon',
                  count: expiringCount,
                  isSelected: showExpiring,
                  isUrgent: true,
                  onTap: () => setState(() {
                    _expiringSoonFilter.add(client.clientId);
                  }),
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              14, expiringCount > 0 ? 4 : 8, 14, 10),
          child: Column(
            children: filteredThreads.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        showExpiring
                            ? 'No offers expiring soon'
                            : 'All offers are expiring soon!',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textHint,
                                ),
                      ),
                    ),
                  ]
                : filteredThreads
                    .map((thread) => _buildThreadCard(context, thread,
                        clientId: client.clientId, isDisabled: isDisabled))
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    int? count,
    bool isUrgent = false,
  }) {
    final activeColor = isUrgent ? AppColors.error : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: AppSpacing.borderRadiusSm,
          border: Border.all(
            color: isSelected
                ? activeColor.withValues(alpha: 0.6)
                : AppColors.border.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isUrgent && isSelected) ...[
              Icon(Icons.timer, size: 11, color: activeColor),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected ? activeColor : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            if (count != null) ...[
              const SizedBox(width: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeColor.withValues(alpha: 0.25)
                      : AppColors.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? activeColor
                            : AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildThreadCard(
    BuildContext context,
    InboxThread thread, {
    required String clientId,
    bool isDisabled = false,
  }) {
    final allDone = thread.allCompleted;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Opacity(
        opacity: (isDisabled || allDone) ? 0.5 : 1.0,
        child: InkWell(
          onTap: (isDisabled || allDone)
              ? null
              : () {
                  if (thread.isSingleOpportunity) {
                    // Single opportunity — skip intermediate screen.
                    // Engagement starts when user taps "Start Earning" on
                    // the interaction screen.
                    context
                        .read<EarnBloc>()
                        .add(EarnEvent.selectThread(thread.id));
                    context.push(
                        '/earn/opportunity/${thread.singleOpportunityId}');
                  } else {
                    // Multiple opportunities — show thread detail
                    context
                        .read<EarnBloc>()
                        .add(EarnEvent.selectThread(thread.id));
                    context.push('/earn/thread/${thread.id}');
                  }
                },
          borderRadius: AppSpacing.borderRadiusSm,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.alphaBlend(
                    AppColors.tertiaryGradient[0]
                        .withValues(alpha: 0.05),
                    AppColors.surface,
                  ),
                  Color.alphaBlend(
                    AppColors.tertiaryGradient[1]
                        .withValues(alpha: 0.025),
                    AppColors.surface,
                  ),
                ],
              ),
              borderRadius: AppSpacing.borderRadiusSm,
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                // Thread image or icon
                _buildThreadImage(context, thread),
                AppSpacing.horizontalSm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with badges
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              thread.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (thread.isPinned)
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(Icons.push_pin,
                                  size: 12, color: AppColors.primary),
                            ),
                          if (thread.isFeatured)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.accent.withValues(alpha: 0.2),
                                  borderRadius: AppSpacing.borderRadiusXs,
                                ),
                                child: Text(
                                  'Featured',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.accent,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (thread.description != null) ...[
                        AppSpacing.verticalXxs,
                        Text(
                          thread.description!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      AppSpacing.verticalXs,
                      // Duration and opps row
                      if (thread.formattedDuration.isNotEmpty ||
                          thread.availableOpportunities > 1)
                        Row(
                          children: [
                            if (thread.formattedDuration.isNotEmpty) ...[
                              Icon(Icons.schedule,
                                  size: 11, color: AppColors.textHint),
                              const SizedBox(width: 3),
                              Text(
                                thread.formattedDuration,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                            if (thread.availableOpportunities > 1) ...[
                              const Spacer(),
                              Text(
                                thread.completedByUser > 0
                                    ? '${thread.completedByUser}/${thread.availableOpportunities} done'
                                    : '${thread.availableOpportunities} opportunities',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: thread.completedByUser > 0
                                          ? AppColors.success
                                          : AppColors.textSecondary,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      AppSpacing.verticalXxs,
                      // Reward info row
                      Row(
                        children: [
                          Icon(
                            allDone ? Icons.check_circle_outline : Icons.toll,
                            size: 14,
                            color: allDone ? AppColors.success : AppColors.gold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            allDone
                                ? 'Completed'
                                : 'Earn ${thread.totalTokenReward} tokens',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: allDone
                                      ? AppColors.success
                                      : AppColors.gold,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          if (thread.rewardTypeLabel != null) ...[
                            Text(' + ',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.textHint)),
                            Icon(Icons.card_giftcard,
                                size: 12, color: AppColors.secondary),
                            const SizedBox(width: 2),
                            Text(
                              thread.rewardTypeLabel!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ],
                      ),
                      // Expiry warning
                      if (thread.isExpiringSoon) ...[
                        AppSpacing.verticalXs,
                        Row(
                          children: [
                            Icon(Icons.timer,
                                size: 12, color: AppColors.error),
                            const SizedBox(width: 4),
                            Text(
                              thread.daysUntilExpiry == 0
                                  ? 'Expires today!'
                                  : 'Expires in ${thread.daysUntilExpiry} day${thread.daysUntilExpiry != 1 ? 's' : ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                AppSpacing.horizontalXs,
                Icon(
                  allDone ? Icons.check_circle : Icons.chevron_right,
                  size: 18,
                  color: allDone ? AppColors.success : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThreadImage(BuildContext context, InboxThread thread) {
    if (thread.threadImage != null) {
      return CachedNetworkImage(
        imageUrl: thread.threadImage!,
        imageBuilder: (context, imageProvider) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusSm,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          child: const Center(
              child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))),
        ),
        errorWidget: (context, url, error) => _buildThreadIconFallback(),
      );
    }

    return _buildThreadIconFallback();
  }

  Widget _buildThreadIconFallback() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: const Icon(Icons.campaign, size: 20, color: AppColors.primary),
    );
  }

  // =========================================================================
  // Empty State
  // =========================================================================

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on_outlined,
              size: 80,
              color: AppColors.textHint,
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
              'Check back later for new earning opportunities',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
