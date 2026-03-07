import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/ledger_journal.dart';
import '../../../domain/entities/reward_item.dart';
import '../../../domain/enums/reward_enums.dart';
import '../../blocs/reward/reward_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

enum _HistoryView { all, tokensOnly }

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  LedgerJournalType? _selectedFilter;
  _HistoryView _currentView = _HistoryView.all;
  bool _rewardFilterActive = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<WalletBloc>().add(const WalletEvent.loadMoreLedgerJournals());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'Activity History',
        extraActions: [
          IconButton(
            icon: Badge(
              isLabelVisible: _selectedFilter != null || _rewardFilterActive,
              child: const Icon(Icons.filter_list),
            ),
            tooltip: 'Filter',
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: WaveBackground(
        child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, walletState) {
          return BlocBuilder<RewardBloc, RewardState>(
            builder: (context, rewardState) {
              return Column(
                children: [
                  // View toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: SegmentedButton<_HistoryView>(
                      segments: const [
                        ButtonSegment(
                          value: _HistoryView.all,
                          label: Text('All Activity'),
                        ),
                        ButtonSegment(
                          value: _HistoryView.tokensOnly,
                          label: Text('Tokens Only'),
                        ),
                      ],
                      selected: {_currentView},
                      onSelectionChanged: (selected) {
                        setState(() {
                          _currentView = selected.first;
                          // Clear reward filter when switching to tokens-only
                          if (_currentView == _HistoryView.tokensOnly) {
                            _rewardFilterActive = false;
                          }
                        });
                      },
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        textStyle: WidgetStatePropertyAll(
                          Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Expanded(
                    child: _buildHistoryContent(
                        context, walletState, rewardState),
                  ),
                ],
              );
            },
          );
        },
      ),
      ),
    );
  }

  Widget _buildHistoryContent(
    BuildContext context,
    WalletState walletState,
    RewardState rewardState,
  ) {
    if (walletState.status == WalletStatus.loading &&
        walletState.ledgerJournals.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentView == _HistoryView.tokensOnly) {
      return _buildTokensOnlyView(context, walletState);
    }

    return _buildAllActivityView(context, walletState, rewardState);
  }

  Widget _buildTokensOnlyView(BuildContext context, WalletState state) {
    final filteredJournals = _selectedFilter == null
        ? state.ledgerJournals
        : state.ledgerJournals
            .where((j) => j.type == _selectedFilter)
            .toList();

    if (state.ledgerJournals.isEmpty) {
      return _buildEmptyState(context);
    }

    if (filteredJournals.isEmpty && _selectedFilter != null) {
      return _buildNoFilterResultsState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: AppSpacing.pagePadding,
        itemCount: filteredJournals.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == filteredJournals.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final journal = filteredJournals[index];
          return _buildJournalCard(
              context, journal, state.ledgerAccount?.id);
        },
      ),
    );
  }

  Widget _buildAllActivityView(
    BuildContext context,
    WalletState walletState,
    RewardState rewardState,
  ) {
    // Build unified activity list
    final activities = <_UnifiedActivity>[];

    // Add token journals (unless reward filter is active)
    if (!_rewardFilterActive) {
      final filteredJournals = _selectedFilter == null
          ? walletState.ledgerJournals
          : walletState.ledgerJournals
              .where((j) => j.type == _selectedFilter)
              .toList();

      for (final journal in filteredJournals) {
        activities.add(_UnifiedActivity(
          timestamp: journal.postedAt ?? journal.createdAt,
          journal: journal,
        ));
      }
    }

    // Add reward items (unless a token-type filter is active)
    if (_selectedFilter == null || _rewardFilterActive) {
      final rewardItems = [
        ...rewardState.activeItems,
        ...rewardState.redeemedItems,
        ...rewardState.expiredItems,
      ];
      for (final item in rewardItems) {
        activities.add(_UnifiedActivity(
          timestamp: item.redeemedAt ?? item.allocatedAt ?? DateTime(2000),
          rewardItem: item,
        ));
      }
    }

    // Sort by timestamp descending
    activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    if (activities.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
        context.read<RewardBloc>().add(const RewardEvent.refreshItems());
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: AppSpacing.pagePadding,
        itemCount:
            activities.length + (walletState.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == activities.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final activity = activities[index];
          if (activity.journal != null) {
            return _buildJournalCard(
              context,
              activity.journal!,
              walletState.ledgerAccount?.id,
            );
          } else if (activity.rewardItem != null) {
            return _buildRewardActivityCard(context, activity.rewardItem!);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRewardActivityCard(BuildContext context, RewardItem item) {
    final Color color;
    final String statusLabel;

    switch (item.status) {
      case RewardItemStatus.allocated:
        color = AppColors.success;
        statusLabel = 'Active';
      case RewardItemStatus.redeemed:
        color = AppColors.textSecondary;
        statusLabel = 'Used';
      case RewardItemStatus.expired:
        color = AppColors.error;
        statusLabel = 'Expired';
      default:
        color = AppColors.textTertiary;
        statusLabel = item.status.displayName;
    }

    return InkWell(
      onTap: () => context.go('/home/wallet-rewards/${item.id}'),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: AppSpacing.cardPadding,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.card_giftcard, color: AppColors.accent, size: 24),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.campaignName ?? 'Reward',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    item.clientName ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _FilterSheet(
        selectedFilter: _selectedFilter,
        rewardFilterActive: _rewardFilterActive,
        showRewardFilter: _currentView == _HistoryView.all,
        onFilterSelected: (filter) {
          setState(() {
            _selectedFilter = filter;
            _rewardFilterActive = false;
          });
          Navigator.pop(context);
        },
        onRewardFilterToggled: () {
          setState(() {
            _rewardFilterActive = !_rewardFilterActive;
            if (_rewardFilterActive) _selectedFilter = null;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildNoFilterResultsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list_off,
              size: 80,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalLg,
            Text(
              'No matching transactions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Try changing your filter',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalLg,
            TextButton(
              onPressed: () => setState(() => _selectedFilter = null),
              child: const Text('Clear Filter'),
            ),
          ],
        ),
      ),
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
              Icons.receipt_long_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalLg,
            Text(
              'No transactions yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Your transaction history will appear here',
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

  Widget _buildJournalCard(BuildContext context, LedgerJournal journal, String? userAccountId) {
    // Find the user's entry in the journal (if any)
    final userEntry = userAccountId != null
        ? journal.entries.where((e) => e.accountId == userAccountId).firstOrNull
        : null;

    // Determine if this is a credit (positive) or debit (negative) for the user
    final isCredit = userEntry?.entryType == LedgerEntryType.credit;
    final amount = userEntry?.amount ?? journal.totalCredits;

    final icon = _getJournalIcon(journal.type);
    final color = isCredit ? AppColors.success : AppColors.error;

    return InkWell(
      onTap: () => _showJournalDetails(context, journal, userEntry),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: AppSpacing.cardPadding,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journal.description,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    _formatDateTime(journal.postedAt ?? journal.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isCredit ? '+' : '-'}$amount',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'tokens',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getJournalIcon(LedgerJournalType type) {
    switch (type) {
      case LedgerJournalType.earn:
        return Icons.monetization_on;
      case LedgerJournalType.potContribution:
        return Icons.savings;
      case LedgerJournalType.potWin:
        return Icons.emoji_events;
      case LedgerJournalType.purchase:
        return Icons.shopping_bag;
      case LedgerJournalType.referralReward:
        return Icons.people;
      case LedgerJournalType.p2pTransfer:
        return Icons.swap_horiz;
      case LedgerJournalType.cashoutInitiate:
      case LedgerJournalType.cashoutComplete:
        return Icons.account_balance_wallet;
      case LedgerJournalType.cashoutFailed:
        return Icons.error_outline;
      case LedgerJournalType.reversal:
        return Icons.undo;
      case LedgerJournalType.adjustment:
        return Icons.tune;
      case LedgerJournalType.clientFund:
      case LedgerJournalType.clientRefund:
      case LedgerJournalType.subaccFund:
        return Icons.account_balance;
    }
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showJournalDetails(BuildContext context, LedgerJournal journal, LedgerEntry? userEntry) {
    showModalBottomSheet(
      context: context,
      builder: (context) => JournalDetailSheet(journal: journal, userEntry: userEntry),
    );
  }
}

class JournalDetailSheet extends StatelessWidget {
  final LedgerJournal journal;
  final LedgerEntry? userEntry;

  const JournalDetailSheet({
    super.key,
    required this.journal,
    this.userEntry,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = userEntry?.entryType == LedgerEntryType.credit;
    final amount = userEntry?.amount ?? journal.totalCredits;
    final color = isCredit ? AppColors.success : AppColors.error;
    // 1 token = R0.01
    final zarAmount = amount * 0.01;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          AppSpacing.verticalMd,
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit ? Icons.add : Icons.remove,
                    color: color,
                    size: 32,
                  ),
                ),
                AppSpacing.verticalMd,
                Text(
                  '${isCredit ? '+' : '-'}$amount Tokens',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '= R${zarAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalLg,
          _buildDetailRow(context, 'Type', _getTypeDisplayName(journal.type)),
          _buildDetailRow(context, 'Description', journal.description),
          _buildDetailRow(
            context,
            'Date',
            _formatFullDate(journal.postedAt ?? journal.createdAt),
          ),
          if (userEntry != null)
            _buildDetailRow(context, 'Balance After', '${userEntry!.balanceAfter} tokens'),
          _buildDetailRow(context, 'Status', journal.status.name.toUpperCase()),
          _buildDetailRow(context, 'Transaction ID', journal.id),
          AppSpacing.verticalLg,
        ],
      ),
    );
  }

  String _getTypeDisplayName(LedgerJournalType type) {
    switch (type) {
      case LedgerJournalType.earn:
        return 'Earned';
      case LedgerJournalType.potContribution:
        return 'Pot Contribution';
      case LedgerJournalType.potWin:
        return 'Pot Win';
      case LedgerJournalType.purchase:
        return 'Purchase';
      case LedgerJournalType.referralReward:
        return 'Referral Reward';
      case LedgerJournalType.p2pTransfer:
        return 'Transfer';
      case LedgerJournalType.cashoutInitiate:
        return 'Cashout Started';
      case LedgerJournalType.cashoutComplete:
        return 'Cashout Completed';
      case LedgerJournalType.cashoutFailed:
        return 'Cashout Failed';
      case LedgerJournalType.reversal:
        return 'Reversal';
      case LedgerJournalType.adjustment:
        return 'Adjustment';
      case LedgerJournalType.clientFund:
        return 'Client Funding';
      case LedgerJournalType.clientRefund:
        return 'Client Refund';
      case LedgerJournalType.subaccFund:
        return 'Sub-Account Funding';
    }
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final LedgerJournalType? selectedFilter;
  final bool rewardFilterActive;
  final bool showRewardFilter;
  final ValueChanged<LedgerJournalType?> onFilterSelected;
  final VoidCallback onRewardFilterToggled;

  const _FilterSheet({
    required this.selectedFilter,
    required this.rewardFilterActive,
    required this.showRewardFilter,
    required this.onFilterSelected,
    required this.onRewardFilterToggled,
  });

  @override
  Widget build(BuildContext context) {
    final hasActiveFilter = selectedFilter != null || rewardFilterActive;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Activity',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (hasActiveFilter)
                TextButton(
                  onPressed: () => onFilterSelected(null),
                  child: const Text('Clear'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(context, LedgerJournalType.earn, 'Earned', Icons.monetization_on),
              _buildFilterChip(context, LedgerJournalType.potWin, 'Pot Wins', Icons.emoji_events),
              _buildFilterChip(context, LedgerJournalType.potContribution, 'Pot Entry', Icons.savings),
              _buildFilterChip(context, LedgerJournalType.purchase, 'Purchases', Icons.shopping_bag),
              _buildFilterChip(context, LedgerJournalType.p2pTransfer, 'Transfers', Icons.swap_horiz),
              _buildFilterChip(context, LedgerJournalType.cashoutInitiate, 'Cashouts', Icons.account_balance_wallet),
              _buildFilterChip(context, LedgerJournalType.referralReward, 'Referrals', Icons.people),
              if (showRewardFilter)
                FilterChip(
                  selected: rewardFilterActive,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        size: 18,
                        color: rewardFilterActive ? Colors.white : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      const Text('Rewards'),
                    ],
                  ),
                  onSelected: (_) => onRewardFilterToggled(),
                  selectedColor: AppColors.accent,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: rewardFilterActive ? Colors.white : AppColors.textPrimary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    LedgerJournalType type,
    String label,
    IconData icon,
  ) {
    final isSelected = selectedFilter == type;
    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      onSelected: (_) => onFilterSelected(isSelected ? null : type),
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textPrimary,
      ),
    );
  }
}

class _UnifiedActivity {
  final DateTime timestamp;
  final LedgerJournal? journal;
  final RewardItem? rewardItem;

  _UnifiedActivity({
    required this.timestamp,
    this.journal,
    this.rewardItem,
  });
}
