import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/purchase.dart';
import '../../../domain/entities/service_provider.dart';
import '../../../domain/entities/sub_account.dart';
import '../../../domain/value_objects/token_amount.dart';
import '../../blocs/purchase/purchase_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

class BuyWalletSelectionScreen extends StatefulWidget {
  const BuyWalletSelectionScreen({super.key});

  @override
  State<BuyWalletSelectionScreen> createState() =>
      _BuyWalletSelectionScreenState();
}

class _BuyWalletSelectionScreenState extends State<BuyWalletSelectionScreen> {
  /// null = main wallet selected
  String? _selectedSubAccountId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PurchaseBloc, PurchaseState>(
          listenWhen: (prev, curr) =>
              prev.lastPurchase != curr.lastPurchase &&
              curr.lastPurchase != null,
          listener: (context, state) {
            context.go('/buy/wallet-selection/success');
          },
        ),
        BlocListener<PurchaseBloc, PurchaseState>(
          listenWhen: (prev, curr) =>
              prev.errorMessage != curr.errorMessage &&
              curr.errorMessage != null &&
              curr.isPurchasing == false,
          listener: (context, state) {
            context.go('/buy/wallet-selection/failure');
          },
        ),
      ],
      child: BlocBuilder<PurchaseBloc, PurchaseState>(
        builder: (context, purchaseState) {
          final product = purchaseState.selectedProduct;
          final recipient = purchaseState.recipientNumber;

          // Guard: if product or recipient missing, redirect back
          if (product == null || recipient == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) context.go('/buy');
            });
            return const Scaffold(body: SizedBox.shrink());
          }

          final category = purchaseState.selectedProvider?.category ??
              PurchaseCategory.airtime;
          final categoryName = category.name;

          return Scaffold(
            backgroundColor: AppColors.buyBackground,
            appBar: IMaliAppBar(
              title: 'Confirm Purchase',
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.buyTextPrimary,
            ),
            body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Purchase summary card
                          _PurchaseSummaryCard(
                            product: product,
                            providerName:
                                purchaseState.selectedProvider?.name ?? '',
                            recipientNumber: recipient,
                          ),

                          const SizedBox(height: 24),

                          // Wallet selection
                          Text(
                            'Pay from',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),

                          BlocBuilder<WalletBloc, WalletState>(
                            builder: (context, walletState) {
                              return _WalletList(
                                mainWalletBalance:
                                    walletState.mainWalletAvailable,
                                subAccounts: walletState.subAccounts,
                                purchaseCategory: categoryName,
                                requiredAmount: product.priceTokens,
                                selectedSubAccountId: _selectedSubAccountId,
                                onSelected: (id) =>
                                    setState(() => _selectedSubAccountId = id),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Confirm button
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppButton(
                        text: purchaseState.isPurchasing
                            ? 'Processing...'
                            : 'Confirm Purchase — ${product.priceTokens} tokens',
                        onPressed: purchaseState.isPurchasing
                            ? null
                            : () => _confirmPurchase(context),
                        isFullWidth: true,
                      ),
                    ),
                  ),
                ],
              ),
          );
        },
      ),
    );
  }

  void _confirmPurchase(BuildContext context) {
    // Refresh wallet to ensure latest balance
    context.read<WalletBloc>().add(const WalletEvent.refreshLedger());

    context.read<PurchaseBloc>().add(
          PurchaseEvent.makePurchase(subAccountId: _selectedSubAccountId),
        );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Purchase Summary Card
// ─────────────────────────────────────────────────────────────────────────────

class _PurchaseSummaryCard extends StatelessWidget {
  final ServiceProduct product;
  final String providerName;
  final String recipientNumber;

  const _PurchaseSummaryCard({
    required this.product,
    required this.providerName,
    required this.recipientNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.chatSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.buyCardBorder),
      ),
      child: Column(
        children: [
          _SummaryRow(label: 'Product', value: product.name),
          if (providerName.isNotEmpty)
            _SummaryRow(label: 'Provider', value: providerName),
          _SummaryRow(label: 'Recipient', value: recipientNumber),
          const Divider(height: 24),
          _SummaryRow(
            label: 'Price',
            value: '${product.priceTokens} tokens',
            isBold: true,
          ),
          _SummaryRow(
            label: 'ZAR equivalent',
            value: 'R${product.priceZar.toStringAsFixed(2)}',
            isSecondary: true,
          ),
          if (product.priceZar > 0 &&
              product.priceZar != product.priceTokens / 100)
            _SummaryRow(
              label: 'Retail value',
              value: 'R${product.priceZar.toStringAsFixed(2)}',
              isSecondary: true,
            ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isSecondary;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isSecondary ? AppColors.buyTextSecondary : null,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Wallet List
// ─────────────────────────────────────────────────────────────────────────────

class _WalletList extends StatelessWidget {
  final int mainWalletBalance;
  final List<SubAccount> subAccounts;
  final String purchaseCategory;
  final int requiredAmount;
  final String? selectedSubAccountId;
  final ValueChanged<String?> onSelected;

  const _WalletList({
    required this.mainWalletBalance,
    required this.subAccounts,
    required this.purchaseCategory,
    required this.requiredAmount,
    required this.selectedSubAccountId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Filter brand sub-accounts that allow this purchase category
    final eligible = subAccounts
        .where((sa) =>
            sa.isRestricted &&
            sa.isActive &&
            sa.allowsPurchaseCategory(purchaseCategory))
        .toList();

    return Column(
      children: [
        // Main wallet — always available
        _WalletCard(
          name: 'Main Wallet',
          balance: TokenAmount(mainWalletBalance),
          isSelected: selectedSubAccountId == null,
          isDisabled: mainWalletBalance < requiredAmount,
          isRestricted: false,
          onTap: () => onSelected(null),
        ),
        ...eligible.map((sa) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _WalletCard(
                name: sa.name,
                balance: sa.tokenBalance,
                isSelected: selectedSubAccountId == sa.id,
                isDisabled: sa.balance < requiredAmount,
                isRestricted: true,
                allowedCategories: sa.allowedOfframps.contains('*')
                    ? null
                    : sa.allowedOfframps,
                onTap: () => onSelected(sa.id),
              ),
            )),
      ],
    );
  }
}

class _WalletCard extends StatelessWidget {
  final String name;
  final TokenAmount balance;
  final bool isSelected;
  final bool isDisabled;
  final bool isRestricted;
  final List<String>? allowedCategories;
  final VoidCallback onTap;

  const _WalletCard({
    required this.name,
    required this.balance,
    required this.isSelected,
    required this.isDisabled,
    required this.isRestricted,
    this.allowedCategories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveDisabled = isDisabled;

    return InkWell(
      onTap: effectiveDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: effectiveDisabled
              ? AppColors.chatSurface.withValues(alpha: 0.5)
              : isSelected
                  ? AppColors.buyMarketplaceAccent.withValues(alpha: 0.08)
                  : AppColors.chatSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.buyMarketplaceAccent : AppColors.buyCardBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Wallet icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.buyMarketplaceAccent.withValues(alpha: 0.15)
                    : AppColors.buyCardBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isRestricted
                    ? Icons.account_balance_wallet
                    : Icons.wallet,
                size: 20,
                color: effectiveDisabled
                    ? AppColors.buyTextSecondary
                    : isSelected
                        ? AppColors.buyMarketplaceAccent
                        : AppColors.buyTextPrimary,
              ),
            ),
            const SizedBox(width: 12),

            // Name + categories
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: effectiveDisabled
                          ? AppColors.buyTextSecondary
                          : isSelected
                              ? AppColors.buyMarketplaceAccent
                              : null,
                    ),
                  ),
                  if (allowedCategories != null)
                    Text(
                      allowedCategories!.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.buyTextSecondary,
                      ),
                    ),
                ],
              ),
            ),

            // Balance + status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  balance.formatted,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: effectiveDisabled
                        ? AppColors.buyError
                        : AppColors.buyTextPrimary,
                  ),
                ),
                if (effectiveDisabled)
                  Text(
                    'Insufficient',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.buyError,
                    ),
                  ),
              ],
            ),

            // Selection indicator
            if (isSelected && !effectiveDisabled) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check_circle,
                color: AppColors.buyMarketplaceAccent,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
