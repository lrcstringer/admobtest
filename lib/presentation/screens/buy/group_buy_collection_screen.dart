import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/group_buy/group_buy_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Physical collection fulfilment screen (Spec §9.8).
///
/// Shows collection addresses with "Get directions" links, QR code
/// proof of purchase, collection deadline, and "I collected it" CTA.
class GroupBuyCollectionScreen extends StatefulWidget {
  final String groupBuyId;

  const GroupBuyCollectionScreen({
    super.key,
    required this.groupBuyId,
  });

  @override
  State<GroupBuyCollectionScreen> createState() =>
      _GroupBuyCollectionScreenState();
}

class _GroupBuyCollectionScreenState
    extends State<GroupBuyCollectionScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GroupBuyBloc>()
        .add(GroupBuyEvent.loadGroupBuy(widget.groupBuyId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupBuyBloc, GroupBuyState>(
      listenWhen: (prev, curr) =>
          prev.isConfirmingCollection != curr.isConfirmingCollection ||
          prev.successMessage != curr.successMessage ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.successMessage != null && !state.isConfirmingCollection) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.buyGroupBuyAccent,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
        }
        if (state.errorMessage != null && !state.isConfirmingCollection) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
          context
              .read<GroupBuyBloc>()
              .add(const GroupBuyEvent.clearMessages());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.buyBackground,
        appBar: AppBar(
          backgroundColor: AppColors.buyCard,
          foregroundColor: AppColors.buyTextPrimary,
          elevation: 0,
          title: const Text(
            'Collect Your Item',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<GroupBuyBloc, GroupBuyState>(
          builder: (context, state) {
          final groupBuy = state.selectedGroupBuy;
          if (groupBuy == null) {
            return const Center(
              child: CircularProgressIndicator(
                  color: AppColors.buyGroupBuyAccent),
            );
          }

          final uid = context.read<AuthBloc>().state.user?.id;
          final contribution = uid != null
              ? state.contributions
                  .where((c) => c.userId == uid)
                  .firstOrNull
              : null;

          final hasCollected = contribution?.hasCollected ?? false;
          final shortId = contribution?.id.substring(0, 8).toUpperCase() ?? 'N/A';

          // Check if delivery type — show delivery card instead
          final isDelivery = contribution?.deliveryAddress != null &&
              contribution!.deliveryAddress!.isNotEmpty;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Main card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.buyCard,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                        color: AppColors.buyGroupBuyAccent, width: 2),
                  ),
                  child: isDelivery
                      ? _buildDeliveryContent(
                          groupBuy.deliveryStatus,
                          contribution.deliveryAddress!,
                        )
                      : _buildCollectionContent(
                          groupBuy.addresses,
                          shortId,
                          hasCollected,
                        ),
                ),

                // Collection deadline
                if (groupBuy.collectionDeadline != null &&
                    !hasCollected) ...[
                  const SizedBox(height: 12),
                  _buildDeadlineWarning(groupBuy.collectionDeadline!),
                ],

                // Collected confirmation
                if (hasCollected) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.buyGroupBuyAccent
                          .withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle,
                            size: 20,
                            color: AppColors.buyGroupBuyAccent),
                        const SizedBox(width: 8),
                        const Text(
                          'Collection confirmed!',
                          style: TextStyle(
                            color: AppColors.buyGroupBuyAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Deal title reference
                Text(
                  groupBuy.title,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<GroupBuyBloc, GroupBuyState>(
        builder: (context, state) {
          final uid = context.read<AuthBloc>().state.user?.id;
          final contribution = uid != null
              ? state.contributions
                  .where((c) => c.userId == uid)
                  .firstOrNull
              : null;
          final hasCollected = contribution?.hasCollected ?? false;
          final isDelivery = contribution?.deliveryAddress != null &&
              contribution!.deliveryAddress!.isNotEmpty;

          if (hasCollected) return const SizedBox.shrink();

          final label = isDelivery ? 'I received it' : 'I collected it';

          return Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16,
                MediaQuery.of(context).padding.bottom + 10),
            decoration: const BoxDecoration(
              color: AppColors.buyCard,
              border: Border(
                top: BorderSide(
                    color: AppColors.buyCardBorder, width: 0.5),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () =>
                    _showConfirmCollectionSheet(contribution?.id),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.buyGroupBuyAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
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

  // ── Collection content ──

  Widget _buildCollectionContent(
    List<String> addresses,
    String shortId,
    bool hasCollected,
  ) {
    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on,
                size: 20, color: AppColors.buyGroupBuyAccent),
            const SizedBox(width: 8),
            const Text(
              'Collect your item',
              style: TextStyle(
                color: AppColors.buyGroupBuyAccent,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Address list
        if (addresses.isNotEmpty) ...[
          ...addresses.map((addr) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () => _openMaps(addr),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.buyChipBg,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.buyTextSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            addr,
                            style: const TextStyle(
                              color: AppColors.buyTextPrimary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Text(
                          'Get directions',
                          style: TextStyle(
                            color: AppColors.buyGroupBuyAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 16),
        ],

        // QR code proof of purchase
        if (!hasCollected) ...[
          const Text(
            'Show this QR code when you collect',
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          QrImageView(
            data: 'HLG-$shortId',
            version: QrVersions.auto,
            size: 150,
            backgroundColor: Colors.white,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppColors.buyTextPrimary,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppColors.buyTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '#HLG-$shortId',
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  // ── Delivery content ──

  Widget _buildDeliveryContent(
    String? deliveryStatus,
    String deliveryAddress,
  ) {
    final statusText = switch (deliveryStatus) {
      'shipped' => 'Your item has been shipped',
      'delivered' => 'Your item has been delivered',
      _ => 'The brand is preparing deliveries',
    };

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping,
                size: 20, color: AppColors.buyGroupBuyAccent),
            const SizedBox(width: 8),
            const Text(
              'Your item will be delivered',
              style: TextStyle(
                color: AppColors.buyGroupBuyAccent,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Delivery address
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.buyChipBg,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery address',
                style: TextStyle(
                  color: AppColors.buyTextTertiary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                deliveryAddress,
                style: const TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Status
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              deliveryStatus == 'shipped'
                  ? Icons.local_shipping
                  : Icons.inventory_2_outlined,
              size: 16,
              color: AppColors.buyGroupBuyAccent,
            ),
            const SizedBox(width: 6),
            Text(
              statusText,
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Deadline warning ──

  Widget _buildDeadlineWarning(DateTime deadline) {
    final now = DateTime.now();
    final daysLeft = deadline.difference(now).inDays;
    final isUrgent = daysLeft < 3;
    final dateStr = DateFormat('dd MMM yyyy').format(deadline);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppColors.buyWarning.withValues(alpha: 0.1)
            : AppColors.buyChipBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 14,
            color: isUrgent
                ? AppColors.buyWarning
                : AppColors.buyTextTertiary,
          ),
          const SizedBox(width: 6),
          Text(
            'Collect by $dateStr',
            style: TextStyle(
              color: isUrgent
                  ? AppColors.buyWarning
                  : AppColors.buyTextSecondary,
              fontSize: 12,
              fontWeight: isUrgent ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ── Confirm collection ──

  void _showConfirmCollectionSheet(String? contributionId) {
    if (contributionId == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.buyDivider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Confirm you collected your item?',
                style: TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.read<GroupBuyBloc>().add(
                          GroupBuyEvent.confirmCollection(
                            groupBuyId: widget.groupBuyId,
                            contributionId: contributionId,
                          ),
                        );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.buyGroupBuyAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                  child: const Text(
                    'Yes, I collected it',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text(
                  'Not yet',
                  style: TextStyle(
                    color: AppColors.buyTextTertiary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMaps(String address) {
    final encoded = Uri.encodeComponent(address);
    launchUrl(Uri.parse('https://maps.google.com/?q=$encoded'));
  }
}
