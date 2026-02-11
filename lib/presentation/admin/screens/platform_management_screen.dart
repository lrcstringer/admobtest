import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Platform management screen for setting up core platform services
class PlatformManagementScreen extends StatefulWidget {
  const PlatformManagementScreen({super.key});

  @override
  State<PlatformManagementScreen> createState() =>
      _PlatformManagementScreenState();
}

class _PlatformManagementScreenState extends State<PlatformManagementScreen> {
  bool _isLoading = true;
  bool _isRunningSetup = false;

  // Setup status
  bool _clientExists = false;
  bool _subAccountExists = false;
  bool _threadExists = false;
  bool _opportunityExists = false;

  // Config data (populated from existing docs)
  Map<String, dynamic>? _clientData;
  Map<String, dynamic>? _subAccountData;
  Map<String, dynamic>? _threadData;
  Map<String, dynamic>? _opportunityData;

  // Reward feature flags
  bool _rewardsEnabled = true;
  bool _rewardsWalletUiEnabled = true;
  bool _rewardsEarnIntegrationEnabled = true;
  bool _rewardsAdminEnabled = true;
  bool _isLoadingFlags = true;
  bool _isSavingFlags = false;

  @override
  void initState() {
    super.initState();
    _checkSetupStatus();
    _loadRewardFlags();
  }

  Future<void> _checkSetupStatus() async {
    setState(() => _isLoading = true);

    try {
      final db = FirebaseFirestore.instance;

      final results = await Future.wait([
        db.collection('clients').doc('imalichat').get(),
        db
            .collection('clients')
            .doc('imalichat')
            .collection('subAccounts')
            .doc('default')
            .get(),
        db.collection('earnThreads').doc('imalichat_watch_earn').get(),
        db
            .collection('earnOpportunities')
            .doc('imalichat_watch_earn_ad')
            .get(),
      ]);

      if (!mounted) return;

      // Treat soft-deleted docs as non-existent
      bool isAlive(DocumentSnapshot doc) =>
          doc.exists && (doc.data() as Map<String, dynamic>?)?['isDeleted'] != true;

      setState(() {
        _clientExists = isAlive(results[0]);
        _clientData = results[0].data();
        _subAccountExists = isAlive(results[1]);
        _subAccountData = results[1].data();
        _threadExists = isAlive(results[2]);
        _threadData = results[2].data();
        _opportunityExists = isAlive(results[3]);
        _opportunityData = results[3].data();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check setup status: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _runSetup() async {
    setState(() => _isRunningSetup = true);

    try {
      await FirebaseFunctions.instance
          .httpsCallable('adminRunPlatformSetup')
          .call();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Platform setup completed successfully!'),
          backgroundColor: AppColors.success,
        ),
      );

      // Refresh status
      await _checkSetupStatus();
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Setup failed: ${e.message}'),
          backgroundColor: AppColors.error,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Setup failed: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isRunningSetup = false);
    }
  }

  Future<void> _loadRewardFlags() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('platformSettings')
          .doc('rewards')
          .get();

      if (!mounted) return;

      if (doc.exists) {
        final data = doc.data() ?? {};
        setState(() {
          _rewardsEnabled = data['rewardsEnabled'] ?? true;
          _rewardsWalletUiEnabled = data['rewardsWalletUiEnabled'] ?? true;
          _rewardsEarnIntegrationEnabled =
              data['rewardsEarnIntegrationEnabled'] ?? true;
          _rewardsAdminEnabled = data['rewardsAdminEnabled'] ?? true;
          _isLoadingFlags = false;
        });
      } else {
        setState(() => _isLoadingFlags = false);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingFlags = false);
    }
  }

  Future<void> _saveRewardFlag(String key, bool value) async {
    setState(() => _isSavingFlags = true);
    try {
      await FirebaseFirestore.instance
          .collection('platformSettings')
          .doc('rewards')
          .set({key: value}, SetOptions(merge: true));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$key updated'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update flag: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSavingFlags = false);
    }
  }

  bool get _allSetUp =>
      _clientExists &&
      _subAccountExists &&
      _threadExists &&
      _opportunityExists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Platform Setup',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Configure core platform services and AdMob integration',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _isLoading ? null : _checkSetupStatus,
                  icon: const Icon(Icons.refresh),
                  color: AppColors.textSecondaryDark,
                  tooltip: 'Refresh status',
                ),
              ],
            ),
            const SizedBox(height: 32),

            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(48),
                  child: CircularProgressIndicator(),
                ),
              )
            else ...[
              // Status overview
              _buildStatusOverview(),
              const SizedBox(height: 24),

              // AdMob setup card
              _buildAdMobSetupCard(),
              const SizedBox(height: 24),

              // Configuration details
              if (_allSetUp) _buildConfigDetails(),
              const SizedBox(height: 24),

              // Reward system feature flags
              _buildRewardFlagsCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOverview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _allSetUp ? Icons.check_circle : Icons.warning_amber_rounded,
                color: _allSetUp ? AppColors.success : AppColors.warning,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                _allSetUp
                    ? 'All platform services configured'
                    : 'Platform setup required',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildStatusRow(
            'IMaliChat Client',
            _clientExists,
            'clients/imalichat',
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            'Default Sub-Account',
            _subAccountExists,
            'clients/imalichat/subAccounts/default',
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            'Watch & Earn Thread',
            _threadExists,
            'earnThreads/imalichat_watch_earn',
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            'AdMob Opportunity',
            _opportunityExists,
            'earnOpportunities/imalichat_watch_earn_ad',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, bool exists, String docPath) {
    return Row(
      children: [
        Icon(
          exists ? Icons.check_circle : Icons.cancel,
          color: exists ? AppColors.success : AppColors.error,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryDark,
            ),
          ),
        ),
        Text(
          docPath,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: AppColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAdMobSetupCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: !_allSetUp
            ? Border.all(color: AppColors.warning.withValues(alpha: 0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.ads_click, color: AppColors.tokenGold, size: 24),
              SizedBox(width: 12),
              Text(
                'AdMob Watch & Earn Setup',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Creates the IMaliChat platform client with a proper ledger account, '
            'a default sub-account for budget tracking, the Watch & Earn campaign '
            'thread, and the AdMob rewarded video opportunity.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondaryDark,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Expected configuration
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                _ConfigRow('Client ID', 'imalichat'),
                SizedBox(height: 8),
                _ConfigRow('Client Name', 'IMaliChat'),
                SizedBox(height: 8),
                _ConfigRow('Thread ID', 'imalichat_watch_earn'),
                SizedBox(height: 8),
                _ConfigRow('Opportunity ID', 'imalichat_watch_earn_ad'),
                SizedBox(height: 8),
                _ConfigRow('Token Reward', '5 tokens per ad'),
                SizedBox(height: 8),
                _ConfigRow('Daily Limit', '3 ads per user'),
                SizedBox(height: 8),
                _ConfigRow(
                    'Ad Unit ID', 'ca-app-pub-9331591670168644/1108724925'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isRunningSetup ? null : _runSetup,
              icon: _isRunningSetup
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      _allSetUp ? Icons.refresh : Icons.play_arrow,
                      size: 20,
                    ),
              label: Text(
                _isRunningSetup
                    ? 'Running Setup...'
                    : _allSetUp
                        ? 'Re-run Setup (Idempotent)'
                        : 'Run Setup',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _allSetUp ? AppColors.info : AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          if (_allSetUp) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline,
                      color: AppColors.warning, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Remember to fund the IMaliChat client via Clients page '
                      'before users can earn from ads.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRewardFlagsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.card_giftcard, color: AppColors.accent, size: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Reward System Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              if (_isSavingFlags)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Control which parts of the reward system are active.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondaryDark,
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoadingFlags)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else ...[
            _buildFlagToggle(
              'Master Kill Switch',
              'rewardsEnabled',
              _rewardsEnabled,
              'Disables all reward functionality globally',
              (val) {
                setState(() => _rewardsEnabled = val);
                _saveRewardFlag('rewardsEnabled', val);
              },
            ),
            const Divider(height: 1, color: AppColors.borderDark),
            _buildFlagToggle(
              'Wallet UI',
              'rewardsWalletUiEnabled',
              _rewardsWalletUiEnabled,
              'Show/hide My Rewards card in consumer wallet',
              (val) {
                setState(() => _rewardsWalletUiEnabled = val);
                _saveRewardFlag('rewardsWalletUiEnabled', val);
              },
            ),
            const Divider(height: 1, color: AppColors.borderDark),
            _buildFlagToggle(
              'Earn Integration',
              'rewardsEarnIntegrationEnabled',
              _rewardsEarnIntegrationEnabled,
              'Allocate rewards when engagements complete',
              (val) {
                setState(() => _rewardsEarnIntegrationEnabled = val);
                _saveRewardFlag('rewardsEarnIntegrationEnabled', val);
              },
            ),
            const Divider(height: 1, color: AppColors.borderDark),
            _buildFlagToggle(
              'Admin Screens',
              'rewardsAdminEnabled',
              _rewardsAdminEnabled,
              'Enable reward management in admin panel',
              (val) {
                setState(() => _rewardsAdminEnabled = val);
                _saveRewardFlag('rewardsAdminEnabled', val);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFlagToggle(
    String label,
    String key,
    bool value,
    String description,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: _isSavingFlags ? null : onChanged,
            activeThumbColor: AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildConfigDetails() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Configuration',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 16),

          // Client info
          if (_clientData != null) ...[
            _buildSectionHeader('Client'),
            _ConfigRow('Display Name',
                _clientData!['displayName']?.toString() ?? '-'),
            const SizedBox(height: 4),
            _ConfigRow(
                'Status', _clientData!['status']?.toString() ?? '-'),
            const SizedBox(height: 4),
            _ConfigRow('Ledger Account',
                _clientData!['ledgerAccountId']?.toString() ?? '-'),
            const SizedBox(height: 16),
          ],

          // Sub-account info
          if (_subAccountData != null) ...[
            _buildSectionHeader('Sub-Account'),
            _ConfigRow(
                'Name', _subAccountData!['name']?.toString() ?? '-'),
            const SizedBox(height: 4),
            _ConfigRow('Balance',
                '${_subAccountData!['balance'] ?? 0} tokens'),
            const SizedBox(height: 4),
            _ConfigRow(
                'Active',
                _subAccountData!['isActive'] == true
                    ? 'Yes'
                    : 'No'),
            const SizedBox(height: 16),
          ],

          // Thread info
          if (_threadData != null) ...[
            _buildSectionHeader('Thread'),
            _ConfigRow(
                'Title', _threadData!['title']?.toString() ?? '-'),
            const SizedBox(height: 4),
            _ConfigRow(
                'Active',
                _threadData!['isActive'] == true ? 'Yes' : 'No'),
            const SizedBox(height: 4),
            _ConfigRow('Token Source Sub-Account',
                _threadData!['tokenSourceSubAccountId']?.toString() ?? '-'),
            const SizedBox(height: 4),
            _ConfigRow('Completed Engagements',
                '${_threadData!['completedOpportunities'] ?? 0}'),
            const SizedBox(height: 16),
          ],

          // Opportunity info
          if (_opportunityData != null) ...[
            _buildSectionHeader('Opportunity'),
            _ConfigRow('Title',
                _opportunityData!['title']?.toString() ?? '-'),
            const SizedBox(height: 4),
            _ConfigRow('Token Reward',
                '${_opportunityData!['tokenReward'] ?? 0}'),
            const SizedBox(height: 4),
            _ConfigRow('Daily Limit',
                '${_opportunityData!['dailyLimitPerUser'] ?? 0}'),
            const SizedBox(height: 4),
            _ConfigRow('Ad Unit ID',
                _opportunityData!['adUnitId']?.toString() ?? '-'),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.info,
        ),
      ),
    );
  }
}

class _ConfigRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConfigRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondaryDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: AppColors.textPrimaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
