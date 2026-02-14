import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/security/step_up_auth_service.dart';
import '../../../domain/entities/cashout.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/cashout/cashout_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class CashoutScreen extends StatefulWidget {
  const CashoutScreen({super.key});

  @override
  State<CashoutScreen> createState() => _CashoutScreenState();
}

class _CashoutScreenState extends State<CashoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountHolderController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  CashoutMethod _selectedMethod = CashoutMethod.bankTransfer;
  int _tokenAmount = 0;

  @override
  void dispose() {
    _amountController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountHolderController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CashoutBloc, CashoutState>(
      listener: (context, state) {
        if (state.requestStatus == CashoutRequestStatus.success) {
          _showSuccessDialog(context, state.lastCashout!);
        } else if (state.requestStatus == CashoutRequestStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<CashoutBloc>().add(const CashoutEvent.clearError());
        }
      },
      child: Scaffold(
        appBar: IMaliAppBar(
          title: 'Cash Out',
          extraActions: [
            TextButton(
              onPressed: () => _showHistorySheet(context),
              child: const Text('History'),
            ),
          ],
        ),
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            final balance = walletState.balance;
            final balanceZar = walletState.balanceZar;
            final minCashout = 1000; // Minimum 1000 tokens (R10)

            return SingleChildScrollView(
              child: WaveBackground(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Form(
                    key: _formKey,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Card
                    _buildBalanceCard(context, balance, balanceZar),
                    AppSpacing.verticalLg,

                    // Minimum info
                    Container(
                      padding: AppSpacing.cardPadding,
                      decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.1),
                        borderRadius: AppSpacing.borderRadiusMd,
                        border: Border.all(color: AppColors.info),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.info),
                          AppSpacing.horizontalMd,
                          Expanded(
                            child: Text(
                              'Minimum cashout: $minCashout tokens (R${(minCashout * 0.01).toStringAsFixed(2)})',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalLg,

                    // Amount Input
                    Text(
                      'Amount (Tokens)',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    AppSpacing.verticalSm,
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Enter amount in tokens',
                        prefixIcon: const Icon(Icons.monetization_on),
                        suffixText: '= R${(_tokenAmount * 0.01).toStringAsFixed(2)}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        final amount = int.tryParse(value) ?? 0;
                        if (amount < minCashout) {
                          return 'Minimum cashout is $minCashout tokens';
                        }
                        if (amount > balance) {
                          return 'Insufficient balance';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _tokenAmount = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    AppSpacing.verticalMd,

                    // Quick amount buttons
                    Row(
                      children: [
                        _buildQuickAmountButton(1000),
                        AppSpacing.horizontalSm,
                        _buildQuickAmountButton(2500),
                        AppSpacing.horizontalSm,
                        _buildQuickAmountButton(5000),
                        AppSpacing.horizontalSm,
                        Expanded(
                          child: OutlinedButton(
                            onPressed: balance > 0
                                ? () {
                                    setState(() {
                                      _tokenAmount = balance;
                                      _amountController.text = balance.toString();
                                    });
                                  }
                                : null,
                            child: const Text('Max'),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalXl,

                    // Method Selection
                    Text(
                      'Cashout Method',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    AppSpacing.verticalMd,
                    _buildMethodSelector(),
                    AppSpacing.verticalLg,

                    // Method-specific fields
                    if (_selectedMethod == CashoutMethod.bankTransfer) ...[
                      _buildBankFields(),
                    ] else if (_selectedMethod == CashoutMethod.ewallet) ...[
                      _buildEwalletFields(),
                    ] else if (_selectedMethod == CashoutMethod.airtime) ...[
                      _buildAirtimeFields(),
                    ],

                    AppSpacing.verticalXl,

                    // Submit Button
                    BlocBuilder<CashoutBloc, CashoutState>(
                      builder: (context, cashoutState) {
                        final isLoading =
                            cashoutState.requestStatus == CashoutRequestStatus.loading;

                        return AppButton(
                          text: 'Request Cashout',
                          onPressed: isLoading ? null : () => _submitCashout(context),
                          isLoading: isLoading,
                        );
                      },
                    ),
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

  Widget _buildBalanceCard(BuildContext context, int balance, double balanceZar) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                ),
          ),
          AppSpacing.verticalSm,
          Text(
            '$balance Tokens',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            '= R${balanceZar.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButton(int amount) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _tokenAmount = amount;
            _amountController.text = amount.toString();
          });
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text('$amount'),
      ),
    );
  }

  Widget _buildMethodSelector() {
    return Column(
      children: [
        _buildMethodOption(
          CashoutMethod.bankTransfer,
          'Bank Transfer',
          'Transfer to your bank account',
          Icons.account_balance,
        ),
        AppSpacing.verticalSm,
        _buildMethodOption(
          CashoutMethod.ewallet,
          'E-Wallet',
          'Transfer to mobile wallet',
          Icons.phone_android,
        ),
        AppSpacing.verticalSm,
        _buildMethodOption(
          CashoutMethod.airtime,
          'Airtime',
          'Convert to mobile airtime',
          Icons.phone_in_talk,
        ),
      ],
    );
  }

  Widget _buildMethodOption(
    CashoutMethod method,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = _selectedMethod == method;

    return InkWell(
      onTap: () => setState(() => _selectedMethod = method),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.primary : null,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Details',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AppSpacing.verticalMd,
        TextFormField(
          controller: _bankNameController,
          decoration: const InputDecoration(
            labelText: 'Bank Name',
            hintText: 'e.g., FNB, Standard Bank',
          ),
          validator: (value) {
            if (_selectedMethod == CashoutMethod.bankTransfer &&
                (value == null || value.isEmpty)) {
              return 'Please enter bank name';
            }
            return null;
          },
        ),
        AppSpacing.verticalMd,
        TextFormField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Account Number',
            hintText: 'Enter your account number',
          ),
          validator: (value) {
            if (_selectedMethod == CashoutMethod.bankTransfer &&
                (value == null || value.isEmpty)) {
              return 'Please enter account number';
            }
            return null;
          },
        ),
        AppSpacing.verticalMd,
        TextFormField(
          controller: _accountHolderController,
          decoration: const InputDecoration(
            labelText: 'Account Holder Name',
            hintText: 'Enter name as on bank account',
          ),
          validator: (value) {
            if (_selectedMethod == CashoutMethod.bankTransfer &&
                (value == null || value.isEmpty)) {
              return 'Please enter account holder name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildEwalletFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'E-Wallet Details',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AppSpacing.verticalMd,
        TextFormField(
          controller: _mobileNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            hintText: '07X XXX XXXX',
            prefixText: '+27 ',
          ),
          validator: (value) {
            if (_selectedMethod == CashoutMethod.ewallet &&
                (value == null || value.isEmpty)) {
              return 'Please enter mobile number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAirtimeFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Airtime Details',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AppSpacing.verticalMd,
        TextFormField(
          controller: _mobileNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            hintText: '07X XXX XXXX',
            prefixText: '+27 ',
          ),
          validator: (value) {
            if (_selectedMethod == CashoutMethod.airtime &&
                (value == null || value.isEmpty)) {
              return 'Please enter mobile number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> _submitCashout(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    // Step-up auth guard: evaluate risk based on cashout amount
    final stepUpService = getIt<StepUpAuthService>();
    final zarAmount = _tokenAmount * 0.01;
    final stepUpResult = stepUpService.evaluateRequired(
      actionType: 'cashout',
      amount: zarAmount,
    );

    if (stepUpResult == StepUpResult.biometricVerified) {
      final biometricResult = await stepUpService.performBiometricStepUp();
      if (biometricResult == StepUpResult.cancelled ||
          biometricResult == StepUpResult.failed) {
        return;
      }
      if (biometricResult == StepUpResult.otpRequired) {
        final otpPassed = await _navigateToStepUpOtp('Cashout requires identity verification.');
        if (otpPassed != true) return;
      }
    } else if (stepUpResult == StepUpResult.otpRequired) {
      final otpPassed = await _navigateToStepUpOtp('Large cashout requires identity verification.');
      if (otpPassed != true) return;
    }

    String destinationDetails;
    switch (_selectedMethod) {
      case CashoutMethod.bankTransfer:
        destinationDetails =
            '${_bankNameController.text} - ${_accountNumberController.text}';
        break;
      case CashoutMethod.ewallet:
      case CashoutMethod.airtime:
        destinationDetails = '+27${_mobileNumberController.text}';
        break;
      case CashoutMethod.voucher:
        destinationDetails = 'Voucher';
        break;
    }

    if (!mounted) return;
    // ignore: use_build_context_synchronously
    context.read<CashoutBloc>().add(CashoutEvent.requestCashout(
          tokenAmount: _tokenAmount,
          method: _selectedMethod,
          destinationDetails: destinationDetails,
          bankName: _selectedMethod == CashoutMethod.bankTransfer
              ? _bankNameController.text
              : null,
          accountNumber: _selectedMethod == CashoutMethod.bankTransfer
              ? _accountNumberController.text
              : null,
          accountHolderName: _selectedMethod == CashoutMethod.bankTransfer
              ? _accountHolderController.text
              : null,
          mobileNumber: _selectedMethod != CashoutMethod.bankTransfer
              ? _mobileNumberController.text
              : null,
        ));
  }

  Future<bool?> _navigateToStepUpOtp(String reason) {
    final phoneNumber =
        context.read<AuthBloc>().state.user?.phoneNumber ?? '';
    return context.push<bool>(
      '/auth/step-up-otp',
      extra: {'phoneNumber': phoneNumber, 'reason': reason},
    );
  }

  void _showSuccessDialog(BuildContext context, Cashout cashout) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: AppColors.success),
            ),
            AppSpacing.horizontalMd,
            const Text('Request Submitted'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your cashout request has been submitted successfully.'),
            AppSpacing.verticalMd,
            Text(
              'Amount: ${cashout.tokenAmount} tokens (${cashout.formattedZarAmount})',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Method: ${cashout.methodDisplayName}'),
            AppSpacing.verticalMd,
            Text(
              'Processing typically takes 24-48 hours.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<CashoutBloc>().add(const CashoutEvent.reset());
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showHistorySheet(BuildContext context) {
    context.read<CashoutBloc>().add(const CashoutEvent.loadHistory());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const CashoutHistorySheet(),
    );
  }
}

class CashoutHistorySheet extends StatelessWidget {
  const CashoutHistorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cashout History',
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
              ),
              const Divider(),
              Expanded(
                child: BlocBuilder<CashoutBloc, CashoutState>(
                  builder: (context, state) {
                    if (state.isLoadingHistory && state.history.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.history.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 64,
                              color: AppColors.textHint,
                            ),
                            AppSpacing.verticalMd,
                            Text(
                              'No cashout history',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        final cashout = state.history[index];
                        return _buildCashoutItem(context, cashout);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCashoutItem(BuildContext context, Cashout cashout) {
    Color statusColor;
    IconData statusIcon;

    switch (cashout.status) {
      case _:
        if (cashout.isComplete) {
          statusColor = AppColors.success;
          statusIcon = Icons.check_circle;
        } else if (cashout.isFailed) {
          statusColor = AppColors.error;
          statusIcon = Icons.cancel;
        } else if (cashout.isProcessing) {
          statusColor = AppColors.warning;
          statusIcon = Icons.hourglass_empty;
        } else {
          statusColor = AppColors.info;
          statusIcon = Icons.pending;
        }
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: statusColor.withValues(alpha: 0.2),
        child: Icon(statusIcon, color: statusColor),
      ),
      title: Text('${cashout.tokenAmount} tokens'),
      subtitle: Text(
        '${cashout.methodDisplayName} - ${cashout.statusDisplayName}',
      ),
      trailing: Text(
        cashout.formattedZarAmount,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
