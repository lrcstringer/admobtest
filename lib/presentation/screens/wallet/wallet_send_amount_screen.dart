import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class WalletSendAmountScreen extends StatefulWidget {
  final String recipientUserId;
  final String recipientName;
  final String? subAccountId;

  const WalletSendAmountScreen({
    super.key,
    required this.recipientUserId,
    required this.recipientName,
    this.subAccountId,
  });

  @override
  State<WalletSendAmountScreen> createState() =>
      _WalletSendAmountScreenState();
}

class _WalletSendAmountScreenState extends State<WalletSendAmountScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  int get _amount => int.tryParse(_amountController.text) ?? 0;

  void _send() {
    if (_amount <= 0) return;

    final walletBloc = context.read<WalletBloc>();
    final state = walletBloc.state;

    // Determine sub-account to send from ('main' = main wallet)
    final subAccountId = widget.subAccountId ?? 'main';

    // Check balance
    if (subAccountId == 'main') {
      if (_amount > state.mainWalletAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient balance')),
        );
        return;
      }
    } else {
      final subAccount = state.subAccounts
          .where((sa) => sa.id == subAccountId)
          .firstOrNull;
      if (subAccount != null && _amount > subAccount.balance) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient balance')),
        );
        return;
      }
    }

    setState(() => _isSending = true);

    walletBloc.add(WalletEvent.sendP2PTransfer(
      recipientUserId: widget.recipientUserId,
      amount: _amount,
      subAccountId: subAccountId,
      note: _noteController.text.isNotEmpty ? _noteController.text : null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state.successMessage != null && _isSending) {
          context.read<WalletBloc>().add(const WalletEvent.clearMessages());
          context.go('/home/wallet-send/success', extra: {
            'amount': _amount,
            'recipientName': widget.recipientName,
          });
        } else if (state.errorMessage != null && _isSending) {
          final error = state.errorMessage ?? 'Transfer failed';
          context.read<WalletBloc>().add(const WalletEvent.clearMessages());
          context.go('/home/wallet-send/failure', extra: {
            'error': error,
          });
        }
      },
      child: Scaffold(
        appBar: IMaliAppBar(title: 'Send Amount'),
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            final subAccountId = widget.subAccountId ?? 'main';
            final availableBalance = subAccountId == 'main'
                ? state.mainWalletAvailable
                : (state.subAccounts
                        .where((sa) => sa.id == subAccountId)
                        .firstOrNull
                        ?.balance ??
                    state.mainWalletAvailable);

            return SingleChildScrollView(
              child: WaveBackground(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipient info
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.cardPadding,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppSpacing.borderRadiusMd,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.15),
                          child: Text(
                            widget.recipientName.isNotEmpty
                                ? widget.recipientName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        AppSpacing.horizontalMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sending to',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.textSecondary),
                              ),
                              Text(
                                widget.recipientName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Amount input
                  Text(
                    'Amount (tokens)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => setState(() {}),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(color: AppColors.textHint),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      suffixText: _amount > 0
                          ? '= R${(_amount * 0.01).toStringAsFixed(2)}'
                          : null,
                      suffixStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    'Available: $availableBalance tokens',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  AppSpacing.verticalLg,

                  // Note input
                  Text(
                    'Note (optional)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  TextField(
                    controller: _noteController,
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'Add a message...',
                      hintStyle: TextStyle(color: AppColors.textHint),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Send button
                  AppButton(
                    text: 'Send',
                    onPressed:
                        _amount > 0 && _amount <= availableBalance && !_isSending
                            ? _send
                            : null,
                    isLoading: _isSending,
                    size: AppButtonSize.large,
                  ),
                ],
              ),
            ),
          ),
            );
          },
        ),
      ),
    );
  }
}
