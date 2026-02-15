import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Reward Activity & Failed Allocations admin screen.
///
/// Shows the reward activity audit trail (allocations, redemptions, expirations)
/// and failed allocation queue for admin intervention.
class RewardActivityScreen extends StatefulWidget {
  const RewardActivityScreen({super.key});

  @override
  State<RewardActivityScreen> createState() => _RewardActivityScreenState();
}

class _RewardActivityScreenState extends State<RewardActivityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Activity Log'),
            Tab(text: 'Failed Allocations'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _ActivityLogTab(),
              _FailedAllocationsTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Activity Log Tab
// =============================================================================

class _ActivityLogTab extends StatelessWidget {
  final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rewardActivityLog')
          .orderBy('createdAt', descending: true)
          .limit(100)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: AppColors.error),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(child: Text('No reward activity recorded yet'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final action = data['action'] as String? ?? 'unknown';
            final userId = data['userId'] as String? ?? '';
            final campaignId = data['campaignId'] as String? ?? '';
            final itemId = data['itemId'] as String? ?? '';
            final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
            final notes = data['notes'] as String?;

            final IconData icon;
            final Color color;
            switch (action) {
              case 'allocated':
                icon = Icons.card_giftcard;
                color = AppColors.success;
              case 'redeemed':
                icon = Icons.check_circle;
                color = AppColors.primary;
              case 'expired':
                icon = Icons.timer_off;
                color = AppColors.error;
              case 'revoked':
                icon = Icons.cancel;
                color = AppColors.error;
              default:
                icon = Icons.info_outline;
                color = AppColors.textSecondary;
            }

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.15),
                  child: Icon(icon, color: color, size: 20),
                ),
                title: Text(
                  '${action.toUpperCase()} — Item $itemId',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User: $userId',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Campaign: $campaignId',
                      style: const TextStyle(fontSize: 12),
                    ),
                    if (notes != null)
                      Text(
                        notes,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
                trailing: createdAt != null
                    ? Text(
                        _dateFormat.format(createdAt),
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : null,
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}

// =============================================================================
// Failed Allocations Tab
// =============================================================================

class _FailedAllocationsTab extends StatelessWidget {
  final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('failedRewardAllocations')
          .where('resolved', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .limit(100)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: AppColors.error),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline,
                    size: 48, color: AppColors.success),
                const SizedBox(height: 12),
                const Text('No unresolved failed allocations'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data() as Map<String, dynamic>;
            final userId = data['userId'] as String? ?? '';
            final campaignId = data['campaignId'] as String? ?? '';
            final engagementId = data['engagementId'] as String? ?? '';
            final reason = data['reason'] as String? ?? 'unknown';
            final retryable = data['retryable'] as bool? ?? false;
            final createdAt = (data['createdAt'] as Timestamp?)?.toDate();

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              color: retryable
                  ? AppColors.warning.withValues(alpha: 0.05)
                  : AppColors.error.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          retryable ? Icons.refresh : Icons.error_outline,
                          color: retryable ? AppColors.warning : AppColors.error,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            reason,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: retryable
                                  ? AppColors.warning
                                  : AppColors.error,
                            ),
                          ),
                        ),
                        if (retryable)
                          TextButton.icon(
                            onPressed: () => _markResolved(context, doc.id),
                            icon: const Icon(Icons.check, size: 16),
                            label: const Text('Resolve'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('User: $userId', style: const TextStyle(fontSize: 12)),
                    Text('Campaign: $campaignId',
                        style: const TextStyle(fontSize: 12)),
                    Text('Engagement: $engagementId',
                        style: const TextStyle(fontSize: 12)),
                    if (createdAt != null)
                      Text(
                        'Failed at: ${_dateFormat.format(createdAt)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _markResolved(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('failedRewardAllocations')
          .doc(docId)
          .update({'resolved': true});
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Marked as resolved')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
