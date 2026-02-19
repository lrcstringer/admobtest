import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/token_spray.dart';
import '../../blocs/token_spray/token_spray_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/spray/spray_countdown.dart';
import '../../widgets/spray/spray_leaderboard.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

/// Detail screen for a token spray with live-updating progress,
/// contributor list, leaderboard, countdown timer, and contribute button.
class SprayDetailScreen extends StatefulWidget {
  final String sprayId;
  final String communityId;

  const SprayDetailScreen({
    super.key,
    required this.sprayId,
    required this.communityId,
  });

  @override
  State<SprayDetailScreen> createState() => _SprayDetailScreenState();
}

class _SprayDetailScreenState extends State<SprayDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TokenSprayBloc>().add(
          TokenSprayEvent.watchSpray(widget.sprayId),
        );
  }

  void _showContributeSheet(BuildContext context, TokenSpray spray) {
    final amountController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + AppSpacing.md,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contribute to Spray',
                style: Theme.of(ctx).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'For ${spray.recipientName}',
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Amount input
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount (min 10 tokens)',
                  prefixIcon: Icon(Icons.toll),
                ),
                validator: (value) {
                  final amount = int.tryParse(value ?? '');
                  if (amount == null || amount < 10) {
                    return 'Minimum contribution is 10 tokens';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              // Quick amount chips
              Wrap(
                spacing: AppSpacing.sm,
                children: [50, 100, 200, 500].map((amount) {
                  return ActionChip(
                    label: Text('$amount'),
                    onPressed: () => amountController.text = '$amount',
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),

              // Optional message
              TextFormField(
                controller: messageController,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'Add a message (optional)',
                  prefixIcon: Icon(Icons.message),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Contribute button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: BlocBuilder<TokenSprayBloc, TokenSprayState>(
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      onPressed: state.isContributing
                          ? null
                          : () {
                              if (!formKey.currentState!.validate()) return;
                              final amount = int.parse(
                                amountController.text.trim(),
                              );
                              context.read<TokenSprayBloc>().add(
                                    TokenSprayEvent.contribute(
                                      sprayId: spray.id,
                                      amount: amount,
                                      message:
                                          messageController.text.trim().isEmpty
                                              ? null
                                              : messageController.text.trim(),
                                    ),
                                  );
                              Navigator.pop(ctx);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tertiary,
                        foregroundColor: AppColors.textOnPrimary,
                      ),
                      icon: state.isContributing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.celebration),
                      label: Text(
                        state.isContributing ? 'Contributing...' : 'Contribute',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Token Spray'),
      body: WaveBackground(
        child: BlocConsumer<TokenSprayBloc, TokenSprayState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
            context
                .read<TokenSprayBloc>()
                .add(const TokenSprayEvent.clearError());
          }
        },
        builder: (context, state) {
          final spray = state.activeSpray;
          if (spray == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // Header card
              _SprayHeaderCard(spray: spray),
              const SizedBox(height: AppSpacing.md),

              // Progress section
              if (spray.targetAmount != null && spray.targetAmount! > 0) ...[
                _ProgressSection(spray: spray),
                const SizedBox(height: AppSpacing.md),
              ],

              // Stats row
              _StatsRow(spray: spray),
              const SizedBox(height: AppSpacing.md),

              // Leaderboard
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: SprayLeaderboard(
                    topContributors: spray.topContributors,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // All contributors
              if (spray.contributions.isNotEmpty) ...[
                Text(
                  'All Contributors (${spray.contributorCount})',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...spray.contributions.entries.map((entry) {
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text(
                        entry.value.displayName.isNotEmpty
                            ? entry.value.displayName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    title: Text(entry.value.displayName),
                    subtitle: entry.value.message != null
                        ? Text(
                            entry.value.message!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : null,
                    trailing: Text(
                      '${entry.value.amount} tokens',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  );
                }),
              ],

              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
      ),
      bottomNavigationBar: BlocBuilder<TokenSprayBloc, TokenSprayState>(
        builder: (context, state) {
          final spray = state.activeSpray;
          if (spray == null || !spray.isActive) return const SizedBox.shrink();

          return Container(
            padding: EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.sm,
              bottom: MediaQuery.of(context).padding.bottom + AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => _showContributeSheet(context, spray),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tertiary,
                  foregroundColor: AppColors.textOnPrimary,
                ),
                icon: const Icon(Icons.celebration),
                label: const Text('Contribute'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SprayHeaderCard extends StatelessWidget {
  final TokenSpray spray;

  const _SprayHeaderCard({required this.spray});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // Occasion icon
            const Icon(Icons.celebration, color: AppColors.tertiary, size: 40),
            const SizedBox(height: AppSpacing.sm),

            // Recipient
            Text(
              'For ${spray.recipientName}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              spray.occasionText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Message
            if (spray.message.isNotEmpty) ...[
              Text(
                '"${spray.message}"',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],

            // Countdown
            if (spray.isActive) SprayCountdown(expiresAt: spray.expiresAt),

            // Status badge
            if (!spray.isActive)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: spray.isClaimed
                      ? AppColors.success.withValues(alpha: 0.15)
                      : AppColors.textSecondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  spray.isClaimed ? 'Claimed' : 'Closed',
                  style: TextStyle(
                    color: spray.isClaimed ? AppColors.success : AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final TokenSpray spray;

  const _ProgressSection({required this.spray});

  @override
  Widget build(BuildContext context) {
    final progress = spray.progressPercent;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${spray.currentTotal} / ${spray.targetAmount} tokens',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.tertiary.withValues(alpha: 0.15),
                color: AppColors.tertiary,
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final TokenSpray spray;

  const _StatsRow({required this.spray});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Total',
            value: '${spray.currentTotal}',
            icon: Icons.toll,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            label: 'Contributors',
            value: '${spray.contributorCount}',
            icon: Icons.people,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            label: 'Value',
            value: 'R${spray.currentTotalZar.toStringAsFixed(2)}',
            icon: Icons.account_balance_wallet,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppColors.tertiary),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
