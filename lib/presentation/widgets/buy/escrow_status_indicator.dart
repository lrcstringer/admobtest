import 'package:flutter/material.dart';

import '../../../domain/enums/order_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Visual stepper showing the order lifecycle:
/// Pending → Escrowed → Fulfilled → Completed
///
/// Handles dispute/refund/cancelled states as terminal deviations.
class EscrowStatusIndicator extends StatelessWidget {
  final OrderStatus status;

  const EscrowStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Terminal deviation states
    if (status == OrderStatus.disputed ||
        status == OrderStatus.refunding ||
        status == OrderStatus.refunded ||
        status == OrderStatus.cancelled) {
      return _buildTerminalState();
    }

    return Row(
      children: [
        _buildStep('Pending', 0),
        _buildConnector(0),
        _buildStep('Escrowed', 1),
        _buildConnector(1),
        _buildStep('Fulfilled', 2),
        _buildConnector(2),
        _buildStep('Completed', 3),
      ],
    );
  }

  Widget _buildTerminalState() {
    final Color color;
    final IconData icon;
    final String label;

    switch (status) {
      case OrderStatus.disputed:
        color = AppColors.buyWarning;
        icon = Icons.warning_amber_rounded;
        label = 'Disputed';
        break;
      case OrderStatus.refunding:
        color = AppColors.buyWarning;
        icon = Icons.hourglass_bottom_rounded;
        label = 'Refunding';
        break;
      case OrderStatus.refunded:
        color = AppColors.secondary;
        icon = Icons.replay_rounded;
        label = 'Refunded';
        break;
      case OrderStatus.cancelled:
        color = AppColors.buyError;
        icon = Icons.cancel_outlined;
        label = 'Cancelled';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  int get _currentStepIndex {
    switch (status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.escrowed:
        return 1;
      case OrderStatus.fulfilled:
        return 2;
      case OrderStatus.completed:
        return 3;
      default:
        return -1;
    }
  }

  Widget _buildStep(String label, int stepIndex) {
    final isActive = stepIndex <= _currentStepIndex;
    final isCurrent = stepIndex == _currentStepIndex;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.buySuccess
                  : AppColors.buyCard,
              border: Border.all(
                color: isActive ? AppColors.buySuccess : AppColors.buyCardBorder,
                width: isCurrent ? 2 : 1,
              ),
            ),
            child: isActive
                ? const Icon(Icons.check, size: 14, color: AppColors.textOnPrimary)
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.buyTextPrimary : AppColors.buyTextTertiary,
              fontSize: 10,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConnector(int afterStepIndex) {
    final isActive = afterStepIndex < _currentStepIndex;

    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16),
        color: isActive ? AppColors.buySuccess : AppColors.buyCardBorder,
      ),
    );
  }
}
