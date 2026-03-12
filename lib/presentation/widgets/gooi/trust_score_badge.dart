import 'package:flutter/material.dart';

import '../../../domain/entities/gooi_member.dart';
import '../../theme/app_colors.dart';

class TrustScoreBadge extends StatelessWidget {
  final GooiMember member;

  const TrustScoreBadge({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final score = _computeTrustScore(member);
    final color = _scoreColor(score);
    final label = _scoreLabel(score);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            '$score% $label',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static int _computeTrustScore(GooiMember member) {
    final total = member.contributedCycles + member.missedCycles;
    if (total == 0) return 50; // New member, neutral — no track record

    // Base score: contribution rate (0-80 points)
    final contributionRate = member.contributedCycles / total;
    var score = (contributionRate * 80).round();

    // Bonus for consistency (0-10 points): no missed cycles
    if (member.missedCycles == 0) score += 10;

    // Bonus for no debt (0-10 points)
    if (!member.hasDebt) score += 10;

    // Confidence factor: scores converge toward 50 with less history.
    // At 6+ cycles the confidence is full (1.0); below that it blends
    // the raw score toward 50 proportionally.
    final confidence = (total / 6.0).clamp(0.0, 1.0);
    final adjusted = (50 + (score - 50) * confidence).round();

    return adjusted.clamp(0, 100);
  }

  static Color _scoreColor(int score) {
    if (score >= 80) return AppColors.teal;
    if (score >= 60) return AppColors.gold;
    return Colors.red;
  }

  static String _scoreLabel(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Good';
    if (score >= 60) return 'Fair';
    return 'At Risk';
  }
}
