import 'package:flutter/material.dart';

import '../../../domain/entities/sub_account.dart';
import '../../../domain/value_objects/token_amount.dart';
import '../../theme/app_colors.dart';

/// Compact horizontal chip list for selecting which wallet to send/request from.
///
/// Filters sub-accounts by P2P rules:
/// - **Send mode**: shows sub-accounts where `allowP2pSend == true`
/// - **Request mode**: shows sub-accounts where `allowP2pReceive == true`
///
/// Only renders if the user has at least one eligible brand sub-account.
/// Returns `null` for main wallet selection.
class WalletPicker extends StatelessWidget {
  final int mainWalletBalance;
  final List<SubAccount> subAccounts;
  final bool isSendMode;
  final String? selectedSubAccountId;
  final ValueChanged<String?> onSelected;

  const WalletPicker({
    super.key,
    required this.mainWalletBalance,
    required this.subAccounts,
    required this.isSendMode,
    required this.selectedSubAccountId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final eligible = subAccounts.where((sa) {
      if (!sa.isRestricted) return false;
      return isSendMode ? sa.allowP2pSend : sa.allowP2pReceive;
    }).toList();

    if (eligible.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSendMode ? 'Send from' : 'Request into',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _WalletChip(
                  label: 'Main Wallet',
                  balance: TokenAmount(mainWalletBalance),
                  isSelected: selectedSubAccountId == null,
                  isSameTypeOnly: false,
                  onTap: () => onSelected(null),
                ),
                ...eligible.map((sa) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _WalletChip(
                        label: sa.name,
                        balance: sa.tokenBalance,
                        isSelected: selectedSubAccountId == sa.id,
                        isSameTypeOnly: sa.p2pRestrictToSameAccountType,
                        onTap: () => onSelected(sa.id),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletChip extends StatelessWidget {
  final String label;
  final TokenAmount balance;
  final bool isSelected;
  final bool isSameTypeOnly;
  final VoidCallback onTap;

  const _WalletChip({
    required this.label,
    required this.balance,
    required this.isSelected,
    required this.isSameTypeOnly,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.chatSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSameTypeOnly)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            const SizedBox(width: 6),
            Text(
              balance.formatted,
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
