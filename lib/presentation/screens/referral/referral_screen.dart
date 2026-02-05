import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/referral.dart';
import '../../blocs/referral/referral_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ReferralBloc>();
    bloc.add(const ReferralEvent.loadStats());
    bloc.add(const ReferralEvent.watchReferrals());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Invite & Earn'),
      body: BlocConsumer<ReferralBloc, ReferralState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<ReferralBloc>().add(const ReferralEvent.clearError());
          }
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context
                .read<ReferralBloc>()
                .add(const ReferralEvent.clearSuccess());
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.stats == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<ReferralBloc>()
                  .add(const ReferralEvent.loadStats());
              context
                  .read<ReferralBloc>()
                  .add(const ReferralEvent.loadReferrals());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary card
                  if (state.stats != null)
                    _buildSummaryCard(context, state.stats!),
                  AppSpacing.verticalLg,

                  // Share card
                  if (state.stats != null)
                    _buildShareCard(context, state.stats!),
                  AppSpacing.verticalSm,

                  // Enter code link
                  Center(
                    child: GestureDetector(
                      onTap: () => _showApplyCodeSheet(context),
                      child: Text(
                        'Have a referral code? Apply it here',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ),
                  AppSpacing.verticalLg,

                  // How referrals work link
                  _buildHowReferralsWorkLink(context),
                  AppSpacing.verticalLg,

                  // Referral list header
                  Text(
                    "People you've brought to iMaliChat",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  AppSpacing.verticalMd,

                  // Referral list
                  if (state.referrals.isEmpty)
                    _buildEmptyReferrals(context)
                  else
                    ...state.referrals.map(
                      (referral) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildReferralItem(context, referral),
                      ),
                    ),

                  // Extra padding for fixed footer
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildInviteFooter(context),
    );
  }

  // ---------------------------------------------------------------------------
  // Summary card (Total Earned + Assist Score + Invited/Joined)
  // ---------------------------------------------------------------------------
  Widget _buildSummaryCard(BuildContext context, ReferralStats stats) {
    final totalEarned = stats.totalEarned;
    final assistScore = stats.completedReferrals;
    final invited = stats.totalReferrals;
    final joined = stats.completedReferrals;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondary.withValues(alpha: 0.15),
            AppColors.orange.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusXl,
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invite friends & earn',
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You and your friend both get bonus tokens when they join using your invite.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.card_giftcard,
                    color: AppColors.secondary, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats grid (2 columns)
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.6),
                    borderRadius: AppSpacing.borderRadiusMd,
                    border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL EARNED',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  fontSize: 10,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalEarned Tokens',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.6),
                    borderRadius: AppSpacing.borderRadiusMd,
                    border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ASSIST SCORE',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  fontSize: 10,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$assistScore',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Invited / Joined counts
          Row(
            children: [
              const Icon(Icons.people_outline,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$invited',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    TextSpan(
                      text: ' Invited',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.check, size: 14, color: AppColors.success),
              const SizedBox(width: 6),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$joined',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    TextSpan(
                      text: ' Joined',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Share card
  // ---------------------------------------------------------------------------
  Widget _buildShareCard(BuildContext context, ReferralStats stats) {
    return Container(
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Referral Code',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: AppSpacing.borderRadiusMd,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    stats.referralCode,
                    style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                            ),
                  ),
                ),
              ),
              AppSpacing.horizontalMd,
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: stats.referralCode));
                  context
                      .read<ReferralBloc>()
                      .add(const ReferralEvent.copyCode());
                },
                icon: const Icon(Icons.copy),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  foregroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<ReferralBloc>().add(
                      const ReferralEvent.shareReferral(platform: 'share'),
                    );
              },
              icon: const Icon(Icons.share),
              label: const Text('Share with Friends'),
            ),
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: stats.referralLink));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied!')),
                    );
                  },
                  icon: const Icon(Icons.link, size: 18),
                  label: const Text('Copy Link'),
                ),
              ),
              AppSpacing.horizontalMd,
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _showQRCodeSheet(context, stats.referralCode),
                  icon: const Icon(Icons.qr_code, size: 18),
                  label: const Text('QR Code'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // How referrals work — centered link that opens a dialog
  // ---------------------------------------------------------------------------
  Widget _buildHowReferralsWorkLink(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showHowItWorksDialog(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.help_outline,
                size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              'How referrals work',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHowItWorksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gift icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.15),
                    AppColors.orange.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.card_giftcard,
                      size: 40, color: AppColors.secondary),
                ),
              ),
            ),

            // Steps
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'How referrals work',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildExplainerStep(context, '1',
                      'Invite your contacts directly from iMaliChat.'),
                  _buildExplainerStep(context, '2',
                      'When someone you invited signs up using their mobile number, you both receive a starter bonus.'),
                  _buildExplainerStep(context, '3',
                      'First-touch wins: You are recorded as the referrer only if you were the first person to invite that number.'),
                  _buildExplainerStep(context, '4',
                      'As your friends keep watching ads and completing surveys, your assist score grows.'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExplainerStep(
      BuildContext context, String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.surfaceElevated,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty referrals
  // ---------------------------------------------------------------------------
  Widget _buildEmptyReferrals(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people_outline,
              size: 28,
              color: AppColors.textHint,
            ),
          ),
          AppSpacing.verticalMd,
          Text(
            'No referrals yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          AppSpacing.verticalSm,
          Text(
            'Invite your contacts to start earning bonus tokens.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Referral item with simplified Joined / Invited badges
  // ---------------------------------------------------------------------------
  Widget _buildReferralItem(BuildContext context, Referral referral) {
    final isJoined = referral.status == ReferralStatus.registered ||
        referral.status == ReferralStatus.qualified ||
        referral.status == ReferralStatus.rewarded;
    final statusText = isJoined ? 'Joined' : 'Invited';
    final statusColor =
        isJoined ? AppColors.success : AppColors.textSecondary;
    final avatarColor = isJoined
        ? AppColors.primary.withValues(alpha: 0.15)
        : AppColors.background;
    final avatarBorderColor = isJoined
        ? AppColors.primary.withValues(alpha: 0.2)
        : AppColors.border;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
              border: Border.all(color: avatarBorderColor),
            ),
            child: referral.refereeAvatarUrl != null
                ? ClipOval(
                    child: Image.network(
                      referral.refereeAvatarUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          referral.refereeInitials,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isJoined
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      referral.refereeInitials,
                      style:
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isJoined
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),

          // Name and secondary info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  referral.refereeDisplayName ?? 'User',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (referral.refereeUsername != null)
                  Text(
                    '@${referral.refereeUsername}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
              ],
            ),
          ),

          // Status badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isJoined
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusText,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Fixed footer — "Invite Friends" CTA
  // ---------------------------------------------------------------------------
  Widget _buildInviteFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient:
                const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: () {
              context.read<ReferralBloc>().add(
                    const ReferralEvent.shareReferral(platform: 'share'),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Invite Friends',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Apply code bottom sheet (accessible via "Have a referral code?" link)
  // ---------------------------------------------------------------------------
  void _showApplyCodeSheet(BuildContext context) {
    final controller = TextEditingController();
    final bloc = context.read<ReferralBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              AppSpacing.verticalMd,
              Text(
                'Enter Referral Code',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Enter a friend\'s referral code to get bonus tokens!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              AppSpacing.verticalLg,
              TextField(
                controller: controller,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Referral Code',
                  hintText: 'ABC123',
                  prefixIcon: const Icon(Icons.card_giftcard),
                  suffixIcon: BlocBuilder<ReferralBloc, ReferralState>(
                    builder: (context, state) {
                      if (state.isValidating) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      if (state.isCodeValid == true) {
                        return const Icon(Icons.check_circle,
                            color: AppColors.success);
                      }
                      if (state.isCodeValid == false) {
                        return const Icon(Icons.error,
                            color: AppColors.error);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 6) {
                    bloc.add(ReferralEvent.validateCode(value));
                  }
                },
              ),
              AppSpacing.verticalLg,
              BlocBuilder<ReferralBloc, ReferralState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isApplying ||
                              controller.text.length < 6 ||
                              state.isCodeValid == false
                          ? null
                          : () {
                              bloc.add(ReferralEvent.applyCode(
                                  controller.text));
                              Navigator.pop(context);
                            },
                      child: state.isApplying
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Apply Code'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // QR code bottom sheet
  // ---------------------------------------------------------------------------
  void _showQRCodeSheet(BuildContext context, String code) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              'Your QR Code',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalLg,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: const Icon(
                Icons.qr_code_2,
                size: 200,
                color: AppColors.textPrimary,
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              code,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Let your friend scan this code',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }
}
