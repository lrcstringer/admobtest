import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/gift.dart';
import '../../../domain/enums/gift_status.dart';
import '../../blocs/gift/gift_bloc.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/tab_background.dart';

/// Screen showing gift history — sent and received tabs.
/// Reached via /profile/gift-history
class GiftHistoryScreen extends StatefulWidget {
  const GiftHistoryScreen({super.key});

  @override
  State<GiftHistoryScreen> createState() => _GiftHistoryScreenState();
}

class _GiftHistoryScreenState extends State<GiftHistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<GiftBloc>().add(const GiftEvent.loadSentGifts());
    context.read<GiftBloc>().add(const GiftEvent.loadReceivedGifts());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text('Gift History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Sent'),
            Tab(text: 'Received'),
          ],
        ),
      ),
      body: TabBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
        overlayAsset: null,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + kTextTabBarHeight),
          child: BlocBuilder<GiftBloc, GiftState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _GiftList(gifts: state.sentGifts, isSent: true),
                _GiftList(gifts: state.receivedGifts, isSent: false),
              ],
            );
          },
        ),
        ),
      ),
    );
  }
}

class _GiftList extends StatelessWidget {
  final List<Gift> gifts;
  final bool isSent;

  const _GiftList({required this.gifts, required this.isSent});

  @override
  Widget build(BuildContext context) {
    if (gifts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              isSent ? 'No gifts sent yet' : 'No gifts received yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: gifts.length,
      itemBuilder: (context, index) {
        final gift = gifts[index];
        return _GiftTile(gift: gift, isSent: isSent);
      },
    );
  }
}

class _GiftTile extends StatelessWidget {
  final Gift gift;
  final bool isSent;

  const _GiftTile({required this.gift, required this.isSent});

  @override
  Widget build(BuildContext context) {
    final name = isSent ? gift.recipientName : gift.senderName;
    final statusColor = switch (gift.status) {
      GiftStatus.pending => AppColors.tertiary,
      GiftStatus.opened => AppColors.secondary,
      GiftStatus.claimed => AppColors.success,
      GiftStatus.expired => AppColors.textSecondary,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.15),
          child: Icon(Icons.card_giftcard, color: statusColor),
        ),
        title: Text(
          isSent ? 'To $name' : 'From $name',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          '${gift.amount} tokens - ${gift.style.displayName}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                gift.status.displayName,
                style: TextStyle(fontSize: 11, color: statusColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
