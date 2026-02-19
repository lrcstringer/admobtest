import 'package:flutter/material.dart';

import '../../../domain/entities/token_spray.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Top 5 contributors leaderboard for a token spray.
class SprayLeaderboard extends StatelessWidget {
  final List<SprayTopContributor> topContributors;

  const SprayLeaderboard({
    super.key,
    required this.topContributors,
  });

  @override
  Widget build(BuildContext context) {
    if (topContributors.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Text('No contributions yet'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Top Contributors',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...topContributors.map((contributor) {
          return _ContributorTile(contributor: contributor);
        }),
      ],
    );
  }
}

class _ContributorTile extends StatelessWidget {
  final SprayTopContributor contributor;

  const _ContributorTile({required this.contributor});

  Widget _buildRankBadge() {
    final (icon, color) = switch (contributor.rank) {
      1 => (Icons.emoji_events, AppColors.gold),
      2 => (Icons.emoji_events, AppColors.tokenSilver),
      3 => (Icons.emoji_events, AppColors.tokenBronze),
      _ => (Icons.circle, AppColors.textSecondary),
    };

    return Icon(icon, color: color, size: contributor.rank <= 3 ? 24 : 16);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: _buildRankBadge(),
      title: Text(
        contributor.displayName,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: contributor.rank == 1 ? FontWeight.bold : null,
        ),
      ),
      trailing: Text(
        '${contributor.amount} tokens',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: contributor.rank == 1 ? AppColors.goldDark : null,
        ),
      ),
    );
  }
}
