import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Campaign management screen for brand partners
class ClientCampaignsScreen extends StatefulWidget {
  const ClientCampaignsScreen({super.key});

  @override
  State<ClientCampaignsScreen> createState() => _ClientCampaignsScreenState();
}

class _ClientCampaignsScreenState extends State<ClientCampaignsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Campaigns',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create and manage your marketing campaigns',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('New Campaign'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Scheduled'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCampaignList('active'),
                _buildCampaignList('scheduled'),
                _buildCampaignList('completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignList(String type) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'active'
                  ? Icons.campaign_outlined
                  : type == 'scheduled'
                      ? Icons.schedule
                      : Icons.check_circle_outline,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 24),
            Text(
              type == 'active'
                  ? 'No active campaigns'
                  : type == 'scheduled'
                      ? 'No scheduled campaigns'
                      : 'No completed campaigns',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              type == 'active'
                  ? 'Create a campaign to start reaching users.'
                  : type == 'scheduled'
                      ? 'Schedule campaigns to launch at a specific time.'
                      : 'Your completed campaigns will appear here.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (type != 'completed') ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: Text(type == 'active' ? 'Create Campaign' : 'Schedule Campaign'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
