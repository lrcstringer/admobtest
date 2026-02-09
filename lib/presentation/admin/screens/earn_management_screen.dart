import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/image_resize_utils.dart';
import '../../theme/app_colors.dart';

/// Earn Management screen for admin portal
/// Allows admins to manage earn threads, opportunities, and view analytics
class EarnManagementScreen extends StatefulWidget {
  const EarnManagementScreen({super.key});

  @override
  State<EarnManagementScreen> createState() => _EarnManagementScreenState();
}

class _EarnManagementScreenState extends State<EarnManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String? _selectedClientId;
  String? _selectedThreadId;

  // Data
  List<Map<String, dynamic>> _clients = [];
  List<Map<String, dynamic>> _threads = [];
  List<Map<String, dynamic>> _opportunities = [];
  Map<String, dynamic>? _statistics;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Load clients
      final clientsSnapshot = await FirebaseFirestore.instance
          .collection('clients')
          .where('isActive', isEqualTo: true)
          .get();

      _clients = clientsSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();

      // Load statistics
      final threadsCount = await FirebaseFirestore.instance
          .collection('earnThreads')
          .where('isActive', isEqualTo: true)
          .count()
          .get();

      final opportunitiesCount = await FirebaseFirestore.instance
          .collection('earnOpportunities')
          .where('isActive', isEqualTo: true)
          .count()
          .get();

      _statistics = {
        'activeClients': _clients.length,
        'activeThreads': threadsCount.count,
        'activeOpportunities': opportunitiesCount.count,
      };

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Color _clientAvatarColor(Map<String, dynamic> client, {Color? fallback}) {
    final colorStr = client['avatarColor'] as String?;
    if (colorStr != null && colorStr.startsWith('#')) {
      try {
        return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return fallback ?? AppColors.secondary;
  }

  Future<void> _loadThreadsForClient(String clientId) async {
    try {
      final threadsSnapshot = await FirebaseFirestore.instance
          .collection('earnThreads')
          .where('clientId', isEqualTo: clientId)
          .orderBy('createdAt', descending: true)
          .get();

      setState(() {
        _threads = threadsSnapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .where((t) => t['isDeleted'] != true)
            .toList();
        _selectedThreadId = null;
        _opportunities = [];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading threads: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _loadOpportunitiesForThread(String threadId) async {
    try {
      final opportunitiesSnapshot = await FirebaseFirestore.instance
          .collection('earnOpportunities')
          .where('threadId', isEqualTo: threadId)
          .orderBy('createdAt', descending: true)
          .get();

      setState(() {
        _opportunities = opportunitiesSnapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .where((o) => o['isDeleted'] != true)
            .toList();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading opportunities: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildStatCards(),
                  const SizedBox(height: 24),
                  _buildTabSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Earn Management',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage campaigns, threads, and opportunities',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 40),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _showCreateThreadDialog,
              icon: const Icon(Icons.add),
              label: const Text('New Campaign'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                minimumSize: const Size(0, 40),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCards() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _StatCard(
          title: 'Active Clients',
          value: '${_statistics?['activeClients'] ?? 0}',
          icon: Icons.business_center,
          color: AppColors.secondary,
        ),
        _StatCard(
          title: 'Active Campaigns',
          value: '${_statistics?['activeThreads'] ?? 0}',
          icon: Icons.campaign,
          color: AppColors.primary,
        ),
        _StatCard(
          title: 'Active Opportunities',
          value: '${_statistics?['activeOpportunities'] ?? 0}',
          icon: Icons.play_circle_outline,
          color: AppColors.success,
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'By Client'),
              Tab(text: 'All Campaigns'),
              Tab(text: 'All Opportunities'),
            ],
          ),
          const Divider(height: 1),
          SizedBox(
            height: 500,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildByClientTab(),
                _buildAllCampaignsTab(),
                _buildAllOpportunitiesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildByClientTab() {
    return Row(
      children: [
        // Client list
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: AppColors.borderDark),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Clients',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: _clients.isEmpty
                      ? Center(
                          child: Text(
                            'No clients found',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _clients.length,
                          itemBuilder: (context, index) {
                            final client = _clients[index];
                            final isSelected =
                                _selectedClientId == client['id'];
                            return Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.15)
                                    : Colors.transparent,
                                border: Border(
                                  left: BorderSide(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _clientAvatarColor(client, fallback: isSelected
                                        ? AppColors.primary
                                        : AppColors.secondary),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: (client['avatarImage'] as String?)?.isNotEmpty == true
                                      ? Image.network(
                                          client['avatarImage'] as String,
                                          fit: BoxFit.cover,
                                          width: 40,
                                          height: 40,
                                          errorBuilder: (_, __, ___) => Center(
                                            child: Text(
                                              ((client['displayName'] as String?)?.isNotEmpty == true
                                                  ? client['displayName'][0]
                                                  : 'C').toUpperCase(),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            ((client['displayName'] as String?)?.isNotEmpty == true
                                                ? client['displayName'][0]
                                                : 'C').toUpperCase(),
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                ),
                                title: Text(
                                  client['displayName'] ?? client['companyName'] ?? 'Unknown',
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimaryDark,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  setState(
                                      () => _selectedClientId = client['id']);
                                  _loadThreadsForClient(client['id']);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),

        // Threads list
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: AppColors.borderDark),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Campaigns',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (_selectedClientId != null)
                        IconButton(
                          icon: const Icon(Icons.add, size: 20),
                          onPressed: _showCreateThreadDialog,
                          tooltip: 'Add Campaign',
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: _selectedClientId == null
                      ? Center(
                          child: Text(
                            'Select a client',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        )
                      : _threads.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No campaigns',
                                    style: TextStyle(
                                        color: AppColors.textSecondary),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton.icon(
                                    onPressed: _showCreateThreadDialog,
                                    icon: const Icon(Icons.add),
                                    label: const Text('Create Campaign'),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _threads.length,
                              itemBuilder: (context, index) {
                                final thread = _threads[index];
                                final isSelected =
                                    _selectedThreadId == thread['id'];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary.withValues(alpha: 0.15)
                                        : Colors.transparent,
                                    border: Border(
                                      left: BorderSide(
                                        color: isSelected
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: thread['isActive'] == true
                                            ? AppColors.success
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                    title: Text(
                                      thread['title'] ?? 'Untitled',
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textPrimaryDark,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${thread['availableOpportunities'] ?? 0} opportunities',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (thread['isFeatured'] == true)
                                          const Icon(Icons.star,
                                              color: AppColors.warning,
                                              size: 18),
                                        IconButton(
                                          icon: Icon(Icons.edit_outlined,
                                              size: 16,
                                              color: AppColors.textSecondary),
                                          onPressed: () =>
                                              _showEditCampaignDialog(thread),
                                          tooltip: 'Edit Campaign',
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        const SizedBox(width: 4),
                                        IconButton(
                                          icon: Icon(Icons.delete_outline,
                                              size: 16,
                                              color: AppColors.error),
                                          onPressed: () =>
                                              _confirmDeleteThread(thread),
                                          tooltip: 'Delete Campaign',
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() =>
                                          _selectedThreadId = thread['id']);
                                      _loadOpportunitiesForThread(thread['id']);
                                    },
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),

        // Opportunities list
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opportunities',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (_selectedThreadId != null)
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: _showCreateOpportunityDialog,
                        tooltip: 'Add Opportunity',
                      ),
                  ],
                ),
              ),
              Expanded(
                child: _selectedThreadId == null
                    ? Center(
                        child: Text(
                          'Select a campaign',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      )
                    : _opportunities.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No opportunities',
                                  style: TextStyle(
                                      color: AppColors.textSecondary),
                                ),
                                const SizedBox(height: 8),
                                TextButton.icon(
                                  onPressed: _showCreateOpportunityDialog,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Create Opportunity'),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _opportunities.length,
                            itemBuilder: (context, index) {
                              final opp = _opportunities[index];
                              return _OpportunityCard(
                                opportunity: opp,
                                onQuestionsEdited: _loadData,
                                onUpdated: _loadData,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllCampaignsTab() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('earnThreads')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final allDocs = snapshot.data?.docs ?? [];
        final threads = allDocs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data['isDeleted'] != true;
        }).toList();

        if (threads.isEmpty) {
          return Center(
            child: Text(
              'No campaigns found',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: threads.length,
          itemBuilder: (context, index) {
            final thread = threads[index].data() as Map<String, dynamic>;
            thread['id'] = threads[index].id;
            return _CampaignCard(
              thread: thread,
              onUpdated: () => setState(() {}),
            );
          },
        );
      },
    );
  }

  Widget _buildAllOpportunitiesTab() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('earnOpportunities')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final allOppDocs = snapshot.data?.docs ?? [];
        final opportunities = allOppDocs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data['isDeleted'] != true;
        }).toList();

        if (opportunities.isEmpty) {
          return Center(
            child: Text(
              'No opportunities found',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: opportunities.length,
          itemBuilder: (context, index) {
            final opp = opportunities[index].data() as Map<String, dynamic>;
            opp['id'] = opportunities[index].id;
            return _OpportunityCard(
              opportunity: opp,
              onQuestionsEdited: () => setState(() {}),
              onUpdated: () => setState(() {}),
            );
          },
        );
      },
    );
  }

  void _showCreateThreadDialog() {
    if (_selectedClientId == null && _clients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please create a client first'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => _CreateThreadDialog(
        clients: _clients,
        selectedClientId: _selectedClientId,
        onCreated: () {
          if (_selectedClientId != null) {
            _loadThreadsForClient(_selectedClientId!);
          }
          _loadData();
        },
      ),
    );
  }

  void _showEditCampaignDialog(Map<String, dynamic> thread) {
    showDialog(
      context: context,
      builder: (context) => _EditCampaignDialog(
        thread: thread,
        onUpdated: () {
          if (_selectedClientId != null) {
            _loadThreadsForClient(_selectedClientId!);
          }
          _loadData();
        },
      ),
    );
  }

  Future<void> _confirmDeleteThread(Map<String, dynamic> thread) async {
    final oppCount = thread['availableOpportunities'] ?? 0;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Delete Campaign?',
            style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Text(
          'This will also delete all $oppCount opportunities in this campaign. '
          'Historical engagement data is preserved.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminSoftDeleteThread')
          .call({'threadId': thread['id']});
      final deleted = result.data['deletedOpportunities'] ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Campaign deleted ($deleted opportunities removed)'),
            backgroundColor: AppColors.success,
          ),
        );
        if (_selectedClientId != null) {
          _loadThreadsForClient(_selectedClientId!);
        }
        setState(() {
          _selectedThreadId = null;
          _opportunities = [];
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting campaign: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showCreateOpportunityDialog() {
    if (_selectedThreadId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a campaign first'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => _CreateOpportunityDialog(
        threadId: _selectedThreadId!,
        onCreated: () {
          _loadOpportunitiesForThread(_selectedThreadId!);
          _loadData();
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Map<String, dynamic> thread;
  final VoidCallback? onUpdated;

  const _CampaignCard({required this.thread, this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surfaceDark,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _threadAvatarColor(thread),
              ),
              clipBehavior: Clip.antiAlias,
              child: () {
                final imageUrl = thread['threadImage'] as String? ??
                    thread['clientAvatarImage'] as String?;
                if (imageUrl != null && imageUrl.isNotEmpty) {
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 48,
                    height: 48,
                    errorBuilder: (_, __, ___) => Center(
                      child: Text(
                        _threadInitials(thread),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    _threadInitials(thread),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thread['title'] ?? 'Untitled',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    thread['clientName'] ?? 'Unknown Client',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: thread['isActive'] == true
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.textSecondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        thread['isActive'] == true ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 12,
                          color: thread['isActive'] == true
                              ? AppColors.success
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    if (thread['budgetExhausted'] == true) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Budget Exhausted',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.edit_outlined,
                          size: 18, color: AppColors.textSecondary),
                      onPressed: () => _showEditDialog(context),
                      tooltip: 'Edit Campaign',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.delete_outline,
                          size: 18, color: AppColors.error),
                      onPressed: () => _confirmDelete(context),
                      tooltip: 'Delete Campaign',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${thread['availableOpportunities'] ?? 0} opportunities',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                // Show scheduling info if set
                if (thread['activeFrom'] != null || thread['activeTo'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.schedule, size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          _formatSchedule(),
                          style: TextStyle(
                            fontSize: 11,
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
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _EditCampaignDialog(
        thread: thread,
        onUpdated: onUpdated,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final oppCount = thread['availableOpportunities'] ?? 0;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Delete Campaign?',
            style: TextStyle(color: AppColors.textPrimaryDark)),
        content: Text(
          'This will also delete all $oppCount opportunities in this campaign. '
          'Historical engagement data is preserved.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminSoftDeleteThread')
          .call({'threadId': thread['id']});
      final deleted = result.data['deletedOpportunities'] ?? 0;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Campaign deleted ($deleted opportunities removed)'),
            backgroundColor: AppColors.success,
          ),
        );
      }
      onUpdated?.call();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting campaign: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _formatSchedule() {
    final fmt = DateFormat('dd MMM');
    final from = thread['activeFrom'];
    final to = thread['activeTo'];
    final fromDate = from is Timestamp ? fmt.format(from.toDate()) : null;
    final toDate = to is Timestamp ? fmt.format(to.toDate()) : null;
    if (fromDate != null && toDate != null) return '$fromDate – $toDate';
    if (fromDate != null) return 'From $fromDate';
    return 'Until $toDate';
  }

  Color _threadAvatarColor(Map<String, dynamic> thread) {
    final colorStr = thread['clientAvatarColor'] as String?;
    if (colorStr != null && colorStr.startsWith('#')) {
      try {
        return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return AppColors.secondary;
  }

  String _threadInitials(Map<String, dynamic> thread) {
    final name = thread['clientName'] as String? ?? '';
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}

class _OpportunityCard extends StatelessWidget {
  final Map<String, dynamic> opportunity;
  final VoidCallback? onQuestionsEdited;
  final VoidCallback? onUpdated;

  const _OpportunityCard({
    required this.opportunity,
    this.onQuestionsEdited,
    this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final earningType = opportunity['earningType'] ?? 'video';
    IconData typeIcon;
    switch (earningType) {
      case 'survey':
        typeIcon = Icons.quiz_outlined;
        break;
      case 'trivia':
        typeIcon = Icons.lightbulb_outline;
        break;
      case 'rating':
        typeIcon = Icons.star_outline;
        break;
      case 'poll':
        typeIcon = Icons.poll_outlined;
        break;
      default:
        typeIcon = Icons.smart_display_outlined;
    }

    return Card(
      color: AppColors.surfaceDark,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            () {
              final oppImage = opportunity['opportunityImage'] as String?;
              if (oppImage != null && oppImage.isNotEmpty) {
                return Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    oppImage,
                    fit: BoxFit.cover,
                    width: 48,
                    height: 48,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(typeIcon, color: AppColors.secondary),
                    ),
                  ),
                );
              }
              return Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(typeIcon, color: AppColors.secondary),
              );
            }(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity['title'] ?? 'Untitled',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.borderDark),
                        ),
                        child: Text(
                          earningType.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${opportunity['durationSeconds'] ?? 0}s',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${opportunity['tokenReward'] ?? 0} tokens',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (opportunity['tokenBudget'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Spent: ${opportunity['tokenSpent'] ?? 0}/${opportunity['tokenBudget']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: opportunity['budgetExhausted'] == true
                          ? AppColors.error
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
                if (opportunity['budgetExhausted'] == true) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Exhausted',
                      style: TextStyle(fontSize: 10, color: AppColors.error),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: opportunity['isActive'] == true
                            ? AppColors.success
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert,
                          size: 18, color: AppColors.textSecondary),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onSelected: (value) {
                        switch (value) {
                          case 'edit_details':
                            _showEditDetailsDialog(context);
                          case 'edit_video':
                            _showEditVideoDialog(context);
                          case 'edit_questions':
                            _showEditQuestionsDialog(context);
                          case 'delete':
                            _confirmDelete(context);
                        }
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'edit_details',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 8),
                              Text('Edit Details'),
                            ],
                          ),
                        ),
                        if (earningType == 'video')
                          const PopupMenuItem(
                            value: 'edit_video',
                            child: Row(
                              children: [
                                Icon(Icons.videocam_outlined, size: 18),
                                SizedBox(width: 8),
                                Text('Edit Video'),
                              ],
                            ),
                          ),
                        const PopupMenuItem(
                          value: 'edit_questions',
                          child: Row(
                            children: [
                              Icon(Icons.quiz_outlined, size: 18),
                              SizedBox(width: 8),
                              Text('Edit Questions'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 18,
                                  color: AppColors.error),
                              SizedBox(width: 8),
                              Text('Delete',
                                  style: TextStyle(color: AppColors.error)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDetailsDialog(BuildContext context) {
    final oppId = opportunity['id'] as String?;
    if (oppId == null) return;

    showDialog(
      context: context,
      builder: (ctx) => _EditOpportunityDialog(
        opportunity: opportunity,
        onUpdated: onUpdated ?? onQuestionsEdited,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final oppId = opportunity['id'] as String?;
    if (oppId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Delete Opportunity?',
            style: TextStyle(color: AppColors.textPrimaryDark)),
        content: const Text(
          'This will remove the opportunity from user visibility. '
          'Historical engagement data is preserved.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await FirebaseFunctions.instance
          .httpsCallable('adminSoftDeleteOpportunity')
          .call({'opportunityId': oppId});
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opportunity deleted'),
            backgroundColor: AppColors.success,
          ),
        );
      }
      onUpdated?.call();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting opportunity: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showEditVideoDialog(BuildContext context) {
    final oppId = opportunity['id'] as String?;
    if (oppId == null) return;

    showDialog(
      context: context,
      builder: (ctx) => _EditVideoDialog(
        opportunity: opportunity,
        onUpdated: onUpdated ?? onQuestionsEdited,
      ),
    );
  }

  void _showEditQuestionsDialog(BuildContext context) {
    final questions = (opportunity['questions'] as List?)
            ?.map((q) => Map<String, dynamic>.from(q as Map))
            .toList() ??
        [];
    final oppId = opportunity['id'] as String?;
    if (oppId == null) return;

    showDialog(
      context: context,
      builder: (ctx) => _EditQuestionsDialog(
        opportunityId: oppId,
        initialQuestions: questions,
        onSaved: onQuestionsEdited,
      ),
    );
  }
}

class _CreateThreadDialog extends StatefulWidget {
  final List<Map<String, dynamic>> clients;
  final String? selectedClientId;
  final VoidCallback onCreated;

  const _CreateThreadDialog({
    required this.clients,
    this.selectedClientId,
    required this.onCreated,
  });

  @override
  State<_CreateThreadDialog> createState() => _CreateThreadDialogState();
}

class _CreateThreadDialogState extends State<_CreateThreadDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedClientId;
  bool _isActive = true;
  bool _isFeatured = false;
  bool _isPinned = false;
  bool _isLoading = false;
  DateTime? _activeFrom;
  DateTime? _activeTo;

  // Token config
  String? _selectedSubAccountId;
  List<Map<String, dynamic>> _subAccounts = [];
  String? _selectedAccountTypeId;
  List<Map<String, dynamic>> _accountTypes = [];

  // Targeting
  Map<String, dynamic>? _targeting;

  // Image upload
  String? _pickedImageName;
  Uint8List? _pickedImageBytes;
  double _uploadProgress = 0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _selectedClientId = widget.selectedClientId;
    _loadAccountTypes();
    if (_selectedClientId != null) {
      _loadSubAccounts(_selectedClientId!);
    }
  }

  Future<void> _loadAccountTypes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('accountTypes')
          .where('isActive', isEqualTo: true)
          .get();
      if (mounted) {
        setState(() {
          _accountTypes = snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _loadSubAccounts(String clientId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminListClientSubAccounts')
          .call({'clientId': clientId});
      final list = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _subAccounts = list);
    } catch (_) {}
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final initial = isFrom ? (_activeFrom ?? now) : (_activeTo ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isFrom) {
          _activeFrom = picked;
        } else {
          _activeTo = picked;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _pickedImageName = result.files.single.name;
          _pickedImageBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String?> _uploadThreadImage(String threadId) async {
    if (_pickedImageBytes == null) return null;
    final resized = resizeImageForUpload(
      _pickedImageBytes!,
      ImageResizeTarget.threadImage,
    );
    if (resized == null) throw Exception('Failed to process image');

    final ref = FirebaseStorage.instance
        .ref()
        .child('thread_images')
        .child('$threadId.${resized.extension}');

    final uploadTask = ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleCreate({String? overrideSubAccountId}) async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a client')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Use createEarnThread CF — auto-creates sub-account if needed
      final result = await FirebaseFunctions.instance
          .httpsCallable('createEarnThread')
          .call({
        'clientId': _selectedClientId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'tokenSourceSubAccountId':
            overrideSubAccountId ?? _selectedSubAccountId,
        'tokenDestAccountTypeId': _selectedAccountTypeId,
        'isPinned': _isPinned,
        'isFeatured': _isFeatured,
        'isActive': _isActive,
        'activeFrom': _activeFrom?.toIso8601String(),
        'activeTo': _activeTo?.toIso8601String(),
        'targeting': _targeting,
      });

      final data = Map<String, dynamic>.from(result.data as Map);
      final createdThreadId = data['threadId'] as String?;

      // Upload image if picked (after thread is created so we have the ID)
      if (_pickedImageBytes != null && createdThreadId != null) {
        setState(() => _isUploading = true);
        try {
          final imageUrl = await _uploadThreadImage(createdThreadId);
          if (imageUrl != null) {
            await FirebaseFirestore.instance
                .collection('earnThreads')
                .doc(createdThreadId)
                .update({'threadImage': imageUrl});
          }
        } finally {
          if (mounted) setState(() => _isUploading = false);
        }
      }

      // Backend found a sub-account with the same name — ask the admin
      if (data['duplicateSubAccount'] == true && mounted) {
        setState(() => _isLoading = false);
        final existingId = data['existingSubAccountId'] as String;
        final existingName = data['existingSubAccountName'] as String;
        final existingBalance = data['existingSubAccountBalance'] ?? 0;

        final reuse = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text(
              'Sub-Account Already Exists',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
            content: Text(
              'A sub-account named "$existingName" already exists '
              'with a balance of $existingBalance tokens.\n\n'
              'Do you want to reuse it for this campaign?',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Reuse'),
              ),
            ],
          ),
        );

        if (reuse == true && mounted) {
          // Re-call with the existing sub-account ID explicitly selected
          await _handleCreate(overrideSubAccountId: existingId);
        }
        return;
      }

      if (mounted) {
        Navigator.of(context).pop();
        widget.onCreated();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Campaign created successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating campaign: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: const Text(
        'Create Campaign',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _selectedClientId,
                  decoration: const InputDecoration(labelText: 'Client'),
                items: widget.clients
                    .map((c) => DropdownMenuItem(
                          value: c['id'] as String,
                          child:
                              Text(c['displayName'] ?? c['companyName'] ?? ''),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClientId = value;
                    _selectedSubAccountId = null;
                    _subAccounts = [];
                  });
                  if (value != null) _loadSubAccounts(value);
                },
                validator: (value) =>
                    value == null ? 'Please select a client' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Campaign Title',
                  hintText: 'e.g., Summer Promotion 2024',
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Brief description of the campaign',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              // Campaign image upload
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderDark),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campaign Image (optional)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderDark),
                          ),
                          child: _pickedImageBytes != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.memory(
                                    _pickedImageBytes!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.campaign,
                                  color: AppColors.textSecondary,
                                  size: 28,
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_pickedImageName != null) ...[
                                Text(
                                  _pickedImageName!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textPrimaryDark,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                if (_isUploading)
                                  LinearProgressIndicator(
                                    value: _uploadProgress,
                                    backgroundColor: AppColors.borderDark,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            AppColors.secondary),
                                  ),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: _isLoading ? null : _pickImage,
                                    icon:
                                        const Icon(Icons.upload_file, size: 18),
                                    label: Text(_pickedImageBytes != null
                                        ? 'Change'
                                        : 'Upload'),
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(0, 36),
                                    ),
                                  ),
                                  if (_pickedImageBytes != null) ...[
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 18),
                                      color: AppColors.textSecondary,
                                      onPressed: _isLoading
                                          ? null
                                          : () => setState(() {
                                                _pickedImageName = null;
                                                _pickedImageBytes = null;
                                                _uploadProgress = 0;
                                              }),
                                      tooltip: 'Remove',
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Scheduling section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderDark),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scheduling (optional)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _pickDate(isFrom: true),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Active From',
                                isDense: true,
                                suffixIcon: Icon(Icons.calendar_today, size: 16),
                              ),
                              child: Text(
                                _activeFrom != null
                                    ? DateFormat('dd MMM yyyy').format(_activeFrom!)
                                    : 'No start date',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _activeFrom != null
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_activeFrom != null)
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            onPressed: () => setState(() => _activeFrom = null),
                            tooltip: 'Clear',
                          ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () => _pickDate(isFrom: false),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Active To',
                                isDense: true,
                                suffixIcon: Icon(Icons.calendar_today, size: 16),
                              ),
                              child: Text(
                                _activeTo != null
                                    ? DateFormat('dd MMM yyyy').format(_activeTo!)
                                    : 'No end date',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _activeTo != null
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_activeTo != null)
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            onPressed: () => setState(() => _activeTo = null),
                            tooltip: 'Clear',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Token config section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderDark),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Token Configuration',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_subAccounts.isNotEmpty) ...[
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSubAccountId,
                        decoration: const InputDecoration(
                          labelText: 'Token Source Sub-Account',
                          hintText: 'default',
                          isDense: true,
                        ),
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text('default'),
                          ),
                          ..._subAccounts.map((sa) => DropdownMenuItem<String>(
                                value: sa['id'] as String,
                                child: Text(sa['name']?.toString() ?? sa['id'].toString()),
                              )),
                        ],
                        onChanged: (v) =>
                            setState(() => _selectedSubAccountId = v),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (_accountTypes.isNotEmpty) ...[
                      DropdownButtonFormField<String>(
                        initialValue: _selectedAccountTypeId,
                        decoration: const InputDecoration(
                          labelText: 'Token Dest Account Type (optional)',
                          hintText: 'None',
                          isDense: true,
                        ),
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text('None (default)'),
                          ),
                          ..._accountTypes.map((at) => DropdownMenuItem<String>(
                                value: at['id'] as String,
                                child: Text(
                                    '${at['name']}${at['isRestricted'] == true ? ' (restricted)' : ''}'),
                              )),
                        ],
                        onChanged: (v) =>
                            setState(() => _selectedAccountTypeId = v),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Targeting
              _TargetingCriteriaWidget(
                onChanged: (v) => _targeting = v,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SwitchListTile(
                      value: _isActive,
                      onChanged: (v) => setState(() => _isActive = v),
                      title: const Text('Active'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: SwitchListTile(
                      value: _isFeatured,
                      onChanged: (v) => setState(() => _isFeatured = v),
                      title: const Text('Featured'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              SwitchListTile(
                value: _isPinned,
                onChanged: (v) => setState(() => _isPinned = v),
                title: const Text('Pinned'),
                contentPadding: EdgeInsets.zero,
              ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleCreate,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Edit Campaign Dialog
// ---------------------------------------------------------------------------

class _EditCampaignDialog extends StatefulWidget {
  final Map<String, dynamic> thread;
  final VoidCallback? onUpdated;

  const _EditCampaignDialog({
    required this.thread,
    this.onUpdated,
  });

  @override
  State<_EditCampaignDialog> createState() => _EditCampaignDialogState();
}

class _EditCampaignDialogState extends State<_EditCampaignDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late bool _isActive;
  late bool _isFeatured;
  late bool _isPinned;
  DateTime? _activeFrom;
  DateTime? _activeTo;
  bool _isLoading = false;

  // Token config
  String? _selectedSubAccountId;
  List<Map<String, dynamic>> _subAccounts = [];
  String? _selectedAccountTypeId;
  List<Map<String, dynamic>> _accountTypes = [];

  // Targeting
  Map<String, dynamic>? _targeting;

  // Image upload
  String? _existingImageUrl;
  String? _pickedImageName;
  Uint8List? _pickedImageBytes;
  double _uploadProgress = 0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final t = widget.thread;
    _titleController = TextEditingController(text: t['title']?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: t['description']?.toString() ?? '');
    _isActive = t['isActive'] == true;
    _isFeatured = t['isFeatured'] == true;
    _isPinned = t['isPinned'] == true;

    // Init image
    _existingImageUrl = t['threadImage'] as String?;

    // Init token config from existing data
    final srcSub = t['tokenSourceSubAccountId']?.toString();
    _selectedSubAccountId = (srcSub != null && srcSub != 'default') ? srcSub : null;
    _selectedAccountTypeId = t['tokenDestAccountTypeId']?.toString();

    // Parse existing dates
    final from = t['activeFrom'];
    if (from is Timestamp) {
      _activeFrom = from.toDate();
    }
    final to = t['activeTo'];
    if (to is Timestamp) {
      _activeTo = to.toDate();
    }

    // Init targeting
    _targeting = t['targeting'] != null
        ? Map<String, dynamic>.from(t['targeting'] as Map)
        : null;

    _loadAccountTypes();
    final clientId = t['clientId']?.toString();
    if (clientId != null) _loadSubAccounts(clientId);
  }

  Future<void> _loadAccountTypes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('accountTypes')
          .where('isActive', isEqualTo: true)
          .get();
      if (mounted) {
        setState(() {
          _accountTypes = snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _loadSubAccounts(String clientId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('adminListClientSubAccounts')
          .call({'clientId': clientId});
      final list = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];
      if (mounted) setState(() => _subAccounts = list);
    } catch (_) {}
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final initial = isFrom ? (_activeFrom ?? now) : (_activeTo ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isFrom) {
          _activeFrom = picked;
        } else {
          _activeTo = picked;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _pickedImageName = result.files.single.name;
          _pickedImageBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String?> _uploadThreadImage(String threadId) async {
    if (_pickedImageBytes == null) return null;
    final resized = resizeImageForUpload(
      _pickedImageBytes!,
      ImageResizeTarget.threadImage,
    );
    if (resized == null) throw Exception('Failed to process image');

    final ref = FirebaseStorage.instance
        .ref()
        .child('thread_images')
        .child('$threadId.${resized.extension}');

    final uploadTask = ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleSave({String? overrideSubAccountId}) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final threadId = widget.thread['id'] as String;
      final clientId = widget.thread['clientId'] as String;

      // Upload image if picked
      String? imageUrl = _existingImageUrl;
      if (_pickedImageBytes != null) {
        setState(() => _isUploading = true);
        imageUrl = await _uploadThreadImage(threadId);
        if (mounted) setState(() => _isUploading = false);
      }

      // Use createEarnThread CF (upsert) — auto-creates sub-account if needed
      final result = await FirebaseFunctions.instance
          .httpsCallable('createEarnThread')
          .call({
        'id': threadId,
        'clientId': clientId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'isActive': _isActive,
        'isFeatured': _isFeatured,
        'isPinned': _isPinned,
        'tokenSourceSubAccountId':
            overrideSubAccountId ?? _selectedSubAccountId,
        'tokenDestAccountTypeId': _selectedAccountTypeId,
        'activeFrom': _activeFrom?.toIso8601String(),
        'activeTo': _activeTo?.toIso8601String(),
        'targeting': _targeting,
        'threadImage': imageUrl,
      });

      final data = Map<String, dynamic>.from(result.data as Map);

      // Backend found a sub-account with the same name — ask the admin
      if (data['duplicateSubAccount'] == true && mounted) {
        setState(() => _isLoading = false);
        final existingId = data['existingSubAccountId'] as String;
        final existingName = data['existingSubAccountName'] as String;
        final existingBalance = data['existingSubAccountBalance'] ?? 0;

        final reuse = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text(
              'Sub-Account Already Exists',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
            content: Text(
              'A sub-account named "$existingName" already exists '
              'with a balance of $existingBalance tokens.\n\n'
              'Do you want to reuse it for this campaign?',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Reuse'),
              ),
            ],
          ),
        );

        if (reuse == true && mounted) {
          await _handleSave(overrideSubAccountId: existingId);
        }
        return;
      }

      if (mounted) {
        Navigator.of(context).pop();
        widget.onUpdated?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Campaign updated'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: const Text(
        'Edit Campaign',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Read-only client info
                Row(
                  children: [
                    Text(
                      'Client: ',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      widget.thread['clientName']?.toString() ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Campaign Title',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                // Campaign image upload
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Campaign Image (optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedImageBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.memory(
                                      _pickedImageBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _existingImageUrl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7),
                                        child: Image.network(
                                          _existingImageUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Icon(
                                            Icons.broken_image,
                                            color: AppColors.textSecondary,
                                            size: 28,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.campaign,
                                        color: AppColors.textSecondary,
                                        size: 28,
                                      ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_pickedImageName != null) ...[
                                  Text(
                                    _pickedImageName!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimaryDark,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  if (_isUploading)
                                    LinearProgressIndicator(
                                      value: _uploadProgress,
                                      backgroundColor: AppColors.borderDark,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              AppColors.secondary),
                                    ),
                                ] else if (_existingImageUrl != null)
                                  Text(
                                    'Current image',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed:
                                          _isLoading ? null : _pickImage,
                                      icon: const Icon(Icons.upload_file,
                                          size: 18),
                                      label: Text(
                                          _pickedImageBytes != null ||
                                                  _existingImageUrl != null
                                              ? 'Change'
                                              : 'Upload'),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(0, 36),
                                      ),
                                    ),
                                    if (_pickedImageBytes != null ||
                                        _existingImageUrl != null) ...[
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.close, size: 18),
                                        color: AppColors.textSecondary,
                                        onPressed: _isLoading
                                            ? null
                                            : () => setState(() {
                                                  _pickedImageName = null;
                                                  _pickedImageBytes = null;
                                                  _existingImageUrl = null;
                                                  _uploadProgress = 0;
                                                }),
                                        tooltip: 'Remove',
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Scheduling section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scheduling (optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _pickDate(isFrom: true),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Active From',
                                  isDense: true,
                                  suffixIcon:
                                      Icon(Icons.calendar_today, size: 16),
                                ),
                                child: Text(
                                  _activeFrom != null
                                      ? DateFormat('dd MMM yyyy')
                                          .format(_activeFrom!)
                                      : 'No start date',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _activeFrom != null
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_activeFrom != null)
                            IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () =>
                                  setState(() => _activeFrom = null),
                              tooltip: 'Clear',
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () => _pickDate(isFrom: false),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Active To',
                                  isDense: true,
                                  suffixIcon:
                                      Icon(Icons.calendar_today, size: 16),
                                ),
                                child: Text(
                                  _activeTo != null
                                      ? DateFormat('dd MMM yyyy')
                                          .format(_activeTo!)
                                      : 'No end date',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _activeTo != null
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_activeTo != null)
                            IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () =>
                                  setState(() => _activeTo = null),
                              tooltip: 'Clear',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Token config section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Token Configuration',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_subAccounts.isNotEmpty) ...[
                        DropdownButtonFormField<String>(
                          initialValue: _selectedSubAccountId,
                          decoration: const InputDecoration(
                            labelText: 'Token Source Sub-Account',
                            hintText: 'default',
                            isDense: true,
                          ),
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('default'),
                            ),
                            ..._subAccounts.map((sa) => DropdownMenuItem<String>(
                                  value: sa['id'] as String,
                                  child: Text(sa['name']?.toString() ?? sa['id'].toString()),
                                )),
                          ],
                          onChanged: (v) =>
                              setState(() => _selectedSubAccountId = v),
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (_accountTypes.isNotEmpty) ...[
                        DropdownButtonFormField<String>(
                          initialValue: _selectedAccountTypeId,
                          decoration: const InputDecoration(
                            labelText: 'Token Dest Account Type (optional)',
                            hintText: 'None',
                            isDense: true,
                          ),
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('None (default)'),
                            ),
                            ..._accountTypes.map((at) => DropdownMenuItem<String>(
                                  value: at['id'] as String,
                                  child: Text(
                                      '${at['name']}${at['isRestricted'] == true ? ' (restricted)' : ''}'),
                                )),
                          ],
                          onChanged: (v) =>
                              setState(() => _selectedAccountTypeId = v),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Targeting
                _TargetingCriteriaWidget(
                  initialTargeting: _targeting,
                  onChanged: (v) => _targeting = v,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        value: _isActive,
                        onChanged: (v) => setState(() => _isActive = v),
                        title: const Text('Active'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        value: _isFeatured,
                        onChanged: (v) => setState(() => _isFeatured = v),
                        title: const Text('Featured'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  value: _isPinned,
                  onChanged: (v) => setState(() => _isPinned = v),
                  title: const Text('Pinned'),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Create Opportunity Dialog
// ---------------------------------------------------------------------------

class _CreateOpportunityDialog extends StatefulWidget {
  final String threadId;
  final VoidCallback onCreated;

  const _CreateOpportunityDialog({
    required this.threadId,
    required this.onCreated,
  });

  @override
  State<_CreateOpportunityDialog> createState() =>
      _CreateOpportunityDialogState();
}

class _CreateOpportunityDialogState extends State<_CreateOpportunityDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _mediaUrlController = TextEditingController();
  final _tokenRewardController = TextEditingController(text: '10');
  final _durationController = TextEditingController(text: '30');
  String _earningType = 'video';
  bool _isActive = true;
  bool _isLoading = false;
  final List<Map<String, dynamic>> _questions = [];

  DateTime? _expiresAt;

  // Video upload state
  String? _pickedFileName;
  Uint8List? _pickedFileBytes;
  double _uploadProgress = 0;
  bool _isUploading = false;

  // Additional fields
  final _streakPointsController = TextEditingController(text: '0');
  final _dailyLimitController = TextEditingController();
  final _adUnitIdController = TextEditingController();
  bool _hasBonusReward = false;
  final _bonusRewardController = TextEditingController(text: '0');
  final _bonusMultiplierController = TextEditingController(text: '1.0');
  String _bonusIntervalType = 'daily';
  final _bonusIntervalXController = TextEditingController(text: '1');

  // Targeting
  Map<String, dynamic>? _targeting;

  // Budget cap
  final _tokenBudgetController = TextEditingController();

  // Opportunity image upload
  String? _pickedImageName;
  Uint8List? _pickedImageBytes;
  double _imageUploadProgress = 0;
  bool _isImageUploading = false;

  final _earningTypes = [
    ('video', 'Video'),
    ('survey', 'Survey'),
    ('trivia', 'Trivia'),
    ('rating', 'Rating'),
    ('poll', 'Poll'),
    ('adVideo', 'Ad Video (AdMob)'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mediaUrlController.dispose();
    _tokenRewardController.dispose();
    _durationController.dispose();
    _streakPointsController.dispose();
    _dailyLimitController.dispose();
    _adUnitIdController.dispose();
    _bonusRewardController.dispose();
    _bonusMultiplierController.dispose();
    _bonusIntervalXController.dispose();
    _tokenBudgetController.dispose();
    super.dispose();
  }

  Future<void> _pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pickedFileName = result.files.single.name;
        _pickedFileBytes = result.files.single.bytes;
        // Clear manual URL when a file is picked
        _mediaUrlController.clear();
      });
    }
  }

  void _clearPickedFile() {
    setState(() {
      _pickedFileName = null;
      _pickedFileBytes = null;
      _uploadProgress = 0;
    });
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _pickedImageName = result.files.single.name;
          _pickedImageBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String?> _uploadOpportunityImage(String opportunityId) async {
    if (_pickedImageBytes == null) return null;
    final resized = resizeImageForUpload(
      _pickedImageBytes!,
      ImageResizeTarget.opportunityImage,
    );
    if (resized == null) throw Exception('Failed to process image');

    final ref = FirebaseStorage.instance
        .ref()
        .child('opportunity_images')
        .child(widget.threadId)
        .child('$opportunityId.${resized.extension}');

    final uploadTask = ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _imageUploadProgress =
              snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  /// Uploads the picked video to Firebase Storage and returns the download URL.
  Future<String> _uploadVideoToStorage(String opportunityId) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('earn_videos')
        .child(widget.threadId)
        .child('$opportunityId.${_pickedFileName!.split('.').last}');

    final uploadTask = ref.putData(
      _pickedFileBytes!,
      SettableMetadata(contentType: 'video/${_pickedFileName!.split('.').last}'),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _uploadProgress =
              snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate video: must have either a file or a URL for video type
    if (_earningType == 'video' &&
        _pickedFileBytes == null &&
        _mediaUrlController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a video or enter a video URL'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _isUploading = _pickedFileBytes != null;
    });

    try {
      // Get thread data for denormalization
      final threadDoc = await FirebaseFirestore.instance
          .collection('earnThreads')
          .doc(widget.threadId)
          .get();
      final threadData = threadDoc.data()!;

      // Generate opportunity ID upfront (needed for storage path)
      final oppRef =
          FirebaseFirestore.instance.collection('earnOpportunities').doc();

      // Upload video file if picked, otherwise use manual URL
      String? mediaUrl = _mediaUrlController.text.trim().isEmpty
          ? null
          : _mediaUrlController.text.trim();
      if (_pickedFileBytes != null) {
        mediaUrl = await _uploadVideoToStorage(oppRef.id);
      }

      setState(() => _isUploading = false);

      // Upload opportunity image if picked
      String? opportunityImageUrl;
      if (_pickedImageBytes != null) {
        setState(() => _isImageUploading = true);
        opportunityImageUrl = await _uploadOpportunityImage(oppRef.id);
        if (mounted) setState(() => _isImageUploading = false);
      }

      // Create opportunity
      await oppRef.set({
        'id': oppRef.id,
        'threadId': widget.threadId,
        'clientId': threadData['clientId'],
        'clientName': threadData['clientName'],
        'clientAvatarColor': threadData['clientAvatarColor'],
        'clientAvatarImage': threadData['clientAvatarImage'],
        'threadImage': threadData['threadImage'],
        'opportunityImage': opportunityImageUrl,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'earningType': _earningType,
        'mediaType': _earningType == 'video' ? 'video' : 'text',
        'mediaUrl': mediaUrl,
        'tokenReward': int.tryParse(_tokenRewardController.text) ?? 10,
        'streakPoints': int.tryParse(_streakPointsController.text) ?? 0,
        'durationSeconds': int.tryParse(_durationController.text) ?? 30,
        'questions': _questions,
        'isActive': _isActive,
        'expiresAt': _expiresAt != null ? Timestamp.fromDate(_expiresAt!) : null,
        'dailyLimitPerUser': _dailyLimitController.text.trim().isNotEmpty
            ? int.tryParse(_dailyLimitController.text.trim())
            : null,
        'adUnitId': _adUnitIdController.text.trim().isNotEmpty
            ? _adUnitIdController.text.trim()
            : null,
        'bonusReward': _hasBonusReward,
        if (_hasBonusReward) ...{
          'bonusRewardMultiplier':
              double.tryParse(_bonusMultiplierController.text) ?? 1.0,
          'bonusIntervalType': _bonusIntervalType,
          'bonusIntervalX':
              int.tryParse(_bonusIntervalXController.text) ?? 1,
        },
        'targeting': _targeting,
        'tokenBudget': _tokenBudgetController.text.trim().isNotEmpty
            ? int.tryParse(_tokenBudgetController.text.trim())
            : null,
        'tokenSpent': 0,
        'budgetExhausted': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update thread opportunity count
      if (_isActive) {
        await threadDoc.reference.update({
          'availableOpportunities': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        Navigator.of(context).pop();
        widget.onCreated();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opportunity created successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating opportunity: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _showQuestionEditor({int? index, Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => _QuestionEditorDialog(existing: existing),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          _questions[index] = result;
        } else {
          _questions.add(result);
        }
        // Re-assign orderIndex based on list position
        for (var i = 0; i < _questions.length; i++) {
          _questions[i]['orderIndex'] = i;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: const Text(
        'Create Opportunity',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'e.g., Watch our new ad',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Title is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                // Opportunity image upload
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Opportunity Image (optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedImageBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.memory(
                                      _pickedImageBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.image,
                                    color: AppColors.textSecondary,
                                    size: 28,
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_pickedImageName != null) ...[
                                  Text(
                                    _pickedImageName!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimaryDark,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  if (_isImageUploading)
                                    LinearProgressIndicator(
                                      value: _imageUploadProgress,
                                      backgroundColor: AppColors.borderDark,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              AppColors.secondary),
                                    ),
                                ],
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed:
                                          _isLoading ? null : _pickImage,
                                      icon: const Icon(Icons.upload_file,
                                          size: 18),
                                      label: Text(_pickedImageBytes != null
                                          ? 'Change'
                                          : 'Upload'),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(0, 36),
                                      ),
                                    ),
                                    if (_pickedImageBytes != null) ...[
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.close, size: 18),
                                        color: AppColors.textSecondary,
                                        onPressed: _isLoading
                                            ? null
                                            : () => setState(() {
                                                  _pickedImageName = null;
                                                  _pickedImageBytes = null;
                                                  _imageUploadProgress = 0;
                                                }),
                                        tooltip: 'Remove',
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _earningType,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: _earningTypes
                      .map((t) => DropdownMenuItem(
                            value: t.$1,
                            child: Text(t.$2),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _earningType = value);
                  },
                ),
                const SizedBox(height: 16),
                if (_earningType == 'video') ...[
                  // Video upload section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Video',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (_pickedFileName != null) ...[
                          // Show picked file
                          Row(
                            children: [
                              const Icon(Icons.videocam,
                                  color: AppColors.success, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _pickedFileName!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textPrimaryDark,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                color: AppColors.textSecondary,
                                onPressed: _isLoading ? null : _clearPickedFile,
                                tooltip: 'Remove',
                              ),
                            ],
                          ),
                          if (_isUploading) ...[
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: _uploadProgress,
                              backgroundColor: AppColors.borderDark,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.secondary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Uploading... ${(_uploadProgress * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ] else ...[
                          // Upload button
                          OutlinedButton.icon(
                            onPressed: _isLoading ? null : _pickVideoFile,
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Choose Video File'),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 40),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        // Divider with "or"
                        if (_pickedFileName == null) ...[
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(color: AppColors.borderDark)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'or paste URL',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Divider(color: AppColors.borderDark)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _mediaUrlController,
                            decoration: const InputDecoration(
                              labelText: 'Video URL',
                              hintText: 'https://...',
                              isDense: true,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _tokenRewardController,
                        decoration: const InputDecoration(
                          labelText: 'Token Reward',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final num = int.tryParse(value ?? '');
                          if (num == null || num <= 0) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        decoration: const InputDecoration(
                          labelText: 'Duration (seconds)',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final num = int.tryParse(value ?? '');
                          if (num == null || num <= 0) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _streakPointsController,
                  decoration: const InputDecoration(
                    labelText: 'Streak Points',
                    hintText: '0',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tokenBudgetController,
                  decoration: const InputDecoration(
                    labelText: 'Token Budget (optional)',
                    hintText: 'Leave empty for unlimited',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return null;
                    final num = int.tryParse(value.trim());
                    if (num == null || num <= 0) {
                      return 'Enter a valid positive number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // AdMob fields (shown for adVideo type)
                if (_earningType == 'adVideo') ...[
                  TextFormField(
                    controller: _adUnitIdController,
                    decoration: const InputDecoration(
                      labelText: 'Ad Unit ID',
                      hintText: 'ca-app-pub-xxx/yyy',
                    ),
                    validator: (v) => _earningType == 'adVideo' &&
                            (v == null || v.trim().isEmpty)
                        ? 'Required for Ad Video type'
                        : null,
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _dailyLimitController,
                  decoration: const InputDecoration(
                    labelText: 'Daily Limit Per User (optional)',
                    hintText: 'No limit',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                // Bonus reward section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        value: _hasBonusReward,
                        onChanged: (v) => setState(() => _hasBonusReward = v),
                        title: const Text('Bonus Reward'),
                        subtitle: const Text('Extra tokens for streaks',
                            style: TextStyle(fontSize: 11)),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      if (_hasBonusReward) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _bonusRewardController,
                                decoration: const InputDecoration(
                                  labelText: 'Bonus Tokens',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _bonusMultiplierController,
                                decoration: const InputDecoration(
                                  labelText: 'Multiplier',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _bonusIntervalType,
                                decoration: const InputDecoration(
                                  labelText: 'Interval Type',
                                  isDense: true,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'daily', child: Text('Daily')),
                                  DropdownMenuItem(
                                      value: 'weekly', child: Text('Weekly')),
                                  DropdownMenuItem(
                                      value: 'monthly', child: Text('Monthly')),
                                ],
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() => _bonusIntervalType = v);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _bonusIntervalXController,
                                decoration: const InputDecoration(
                                  labelText: 'Interval X',
                                  hintText: 'Every X intervals',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Targeting
                _TargetingCriteriaWidget(
                  onChanged: (v) => _targeting = v,
                ),
                const SizedBox(height: 24),
                // Questions section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Questions',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: AppColors.secondary),
                      tooltip: 'Add question',
                      onPressed: () => _showQuestionEditor(),
                    ),
                  ],
                ),
                if (_questions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'No questions added yet',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ..._questions.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final q = entry.value;
                  final options = (q['options'] as List?)?.cast<String>() ?? [];
                  return Card(
                    color: AppColors.surfaceDark,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        q['text'] ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      subtitle: Text(
                        '${options.length} options',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            color: AppColors.textSecondary,
                            onPressed: () =>
                                _showQuestionEditor(index: idx, existing: q),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 18),
                            color: AppColors.error,
                            onPressed: () {
                              setState(() => _questions.removeAt(idx));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                SwitchListTile(
                  value: _isActive,
                  onChanged: (v) => setState(() => _isActive = v),
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                // Expiry date
                InkWell(
                  onTap: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _expiresAt ?? now.add(const Duration(days: 30)),
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 365 * 3)),
                    );
                    if (picked != null && mounted) {
                      setState(() => _expiresAt = picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Expires At (optional)',
                      isDense: true,
                      suffixIcon: _expiresAt != null
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () =>
                                  setState(() => _expiresAt = null),
                              tooltip: 'Clear',
                            )
                          : const Icon(Icons.calendar_today, size: 16),
                    ),
                    child: Text(
                      _expiresAt != null
                          ? DateFormat('dd MMM yyyy').format(_expiresAt!)
                          : 'No expiry date',
                      style: TextStyle(
                        fontSize: 13,
                        color: _expiresAt != null
                            ? AppColors.textPrimaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleCreate,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
          child: _isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    if (_isUploading) ...[
                      const SizedBox(width: 8),
                      Text('Uploading ${(_uploadProgress * 100).toInt()}%'),
                    ],
                  ],
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Edit Opportunity Details Dialog
// ---------------------------------------------------------------------------

class _EditOpportunityDialog extends StatefulWidget {
  final Map<String, dynamic> opportunity;
  final VoidCallback? onUpdated;

  const _EditOpportunityDialog({
    required this.opportunity,
    this.onUpdated,
  });

  @override
  State<_EditOpportunityDialog> createState() =>
      _EditOpportunityDialogState();
}

class _EditOpportunityDialogState extends State<_EditOpportunityDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _tokenRewardController;
  late final TextEditingController _durationController;
  late bool _isActive;
  DateTime? _expiresAt;
  bool _isLoading = false;

  // Additional fields
  late String _earningType;
  late final TextEditingController _streakPointsController;
  late final TextEditingController _dailyLimitController;
  late final TextEditingController _adUnitIdController;
  late final TextEditingController _mediaUrlController;
  late bool _hasBonusReward;
  late final TextEditingController _bonusRewardController;
  late final TextEditingController _bonusMultiplierController;
  late String _bonusIntervalType;
  late final TextEditingController _bonusIntervalXController;

  // Targeting
  Map<String, dynamic>? _targeting;

  // Budget cap
  late final TextEditingController _tokenBudgetController;

  // Opportunity image upload
  String? _existingImageUrl;
  String? _pickedImageName;
  Uint8List? _pickedImageBytes;
  double _imageUploadProgress = 0;
  bool _isImageUploading = false;

  final _earningTypes = [
    ('video', 'Video'),
    ('survey', 'Survey'),
    ('trivia', 'Trivia'),
    ('rating', 'Rating'),
    ('poll', 'Poll'),
    ('adVideo', 'Ad Video (AdMob)'),
  ];

  @override
  void initState() {
    super.initState();
    final o = widget.opportunity;
    _existingImageUrl = o['opportunityImage'] as String?;
    _titleController = TextEditingController(text: o['title']?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: o['description']?.toString() ?? '');
    _tokenRewardController =
        TextEditingController(text: (o['tokenReward'] ?? 10).toString());
    _durationController =
        TextEditingController(text: (o['durationSeconds'] ?? 30).toString());
    _isActive = o['isActive'] == true;

    // Init additional fields
    _earningType = o['earningType']?.toString() ?? 'video';
    _streakPointsController =
        TextEditingController(text: (o['streakPoints'] ?? 0).toString());
    _dailyLimitController = TextEditingController(
        text: o['dailyLimitPerUser'] != null
            ? o['dailyLimitPerUser'].toString()
            : '');
    _adUnitIdController =
        TextEditingController(text: o['adUnitId']?.toString() ?? '');
    _mediaUrlController =
        TextEditingController(text: o['mediaUrl']?.toString() ?? '');

    // Bonus reward (handle both bool and legacy int types)
    final rawBonus = o['bonusReward'];
    _hasBonusReward = rawBonus == true || (rawBonus is num && rawBonus > 0);
    _bonusRewardController =
        TextEditingController(text: rawBonus is num ? rawBonus.toString() : '0');
    _bonusMultiplierController = TextEditingController(
        text: (o['bonusRewardMultiplier'] ?? 1.0).toString());
    _bonusIntervalType = o['bonusIntervalType']?.toString() ?? 'daily';
    _bonusIntervalXController =
        TextEditingController(text: (o['bonusIntervalX'] ?? 1).toString());

    // Init targeting
    _targeting = o['targeting'] != null
        ? Map<String, dynamic>.from(o['targeting'] as Map)
        : null;

    // Budget cap
    _tokenBudgetController = TextEditingController(
        text: o['tokenBudget'] != null ? o['tokenBudget'].toString() : '');

    // Parse existing expiry date
    final exp = o['expiresAt'];
    if (exp is Timestamp) {
      _expiresAt = exp.toDate();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tokenRewardController.dispose();
    _durationController.dispose();
    _streakPointsController.dispose();
    _dailyLimitController.dispose();
    _adUnitIdController.dispose();
    _mediaUrlController.dispose();
    _bonusRewardController.dispose();
    _bonusMultiplierController.dispose();
    _bonusIntervalXController.dispose();
    _tokenBudgetController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _pickedImageName = result.files.single.name;
          _pickedImageBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String?> _uploadOpportunityImage(String opportunityId) async {
    if (_pickedImageBytes == null) return null;
    final resized = resizeImageForUpload(
      _pickedImageBytes!,
      ImageResizeTarget.opportunityImage,
    );
    if (resized == null) throw Exception('Failed to process image');

    final threadId = widget.opportunity['threadId'] as String;
    final ref = FirebaseStorage.instance
        .ref()
        .child('opportunity_images')
        .child(threadId)
        .child('$opportunityId.${resized.extension}');

    final uploadTask = ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _imageUploadProgress =
              snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final oppId = widget.opportunity['id'] as String;
      final wasActive = widget.opportunity['isActive'] == true;
      final nowActive = _isActive;

      // Upload opportunity image if picked
      String? imageUrl = _existingImageUrl;
      if (_pickedImageBytes != null) {
        setState(() => _isImageUploading = true);
        imageUrl = await _uploadOpportunityImage(oppId);
        if (mounted) setState(() => _isImageUploading = false);
      }

      await FirebaseFirestore.instance
          .collection('earnOpportunities')
          .doc(oppId)
          .update({
        'opportunityImage': imageUrl,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'earningType': _earningType,
        'mediaType': (_earningType == 'video' || _earningType == 'adVideo')
            ? 'video'
            : 'text',
        'mediaUrl': _mediaUrlController.text.trim().isNotEmpty
            ? _mediaUrlController.text.trim()
            : null,
        'tokenReward': int.tryParse(_tokenRewardController.text) ?? 10,
        'streakPoints': int.tryParse(_streakPointsController.text) ?? 0,
        'durationSeconds': int.tryParse(_durationController.text) ?? 30,
        'isActive': _isActive,
        'expiresAt': _expiresAt != null ? Timestamp.fromDate(_expiresAt!) : null,
        'dailyLimitPerUser': _dailyLimitController.text.trim().isNotEmpty
            ? int.tryParse(_dailyLimitController.text.trim())
            : null,
        'adUnitId': _adUnitIdController.text.trim().isNotEmpty
            ? _adUnitIdController.text.trim()
            : null,
        'bonusReward': _hasBonusReward,
        'bonusRewardMultiplier': _hasBonusReward
            ? (double.tryParse(_bonusMultiplierController.text) ?? 1.0)
            : null,
        'bonusIntervalType': _hasBonusReward ? _bonusIntervalType : null,
        'bonusIntervalX': _hasBonusReward
            ? (int.tryParse(_bonusIntervalXController.text) ?? 1)
            : null,
        'targeting': _targeting,
        'tokenBudget': _tokenBudgetController.text.trim().isNotEmpty
            ? int.tryParse(_tokenBudgetController.text.trim())
            : null,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update thread opportunity count if active status changed
      final threadId = widget.opportunity['threadId'] as String?;
      if (threadId != null && wasActive != nowActive) {
        await FirebaseFirestore.instance
            .collection('earnThreads')
            .doc(threadId)
            .update({
          'availableOpportunities':
              FieldValue.increment(nowActive ? 1 : -1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        Navigator.of(context).pop();
        widget.onUpdated?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opportunity updated'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: const Text(
        'Edit Opportunity',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Description (optional)'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                // Opportunity image upload
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Opportunity Image (optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedImageBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.memory(
                                      _pickedImageBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _existingImageUrl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7),
                                        child: Image.network(
                                          _existingImageUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Icon(
                                            Icons.broken_image,
                                            color: AppColors.textSecondary,
                                            size: 28,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.image,
                                        color: AppColors.textSecondary,
                                        size: 28,
                                      ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_pickedImageName != null) ...[
                                  Text(
                                    _pickedImageName!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimaryDark,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  if (_isImageUploading)
                                    LinearProgressIndicator(
                                      value: _imageUploadProgress,
                                      backgroundColor: AppColors.borderDark,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              AppColors.secondary),
                                    ),
                                ] else if (_existingImageUrl != null)
                                  Text(
                                    'Current image',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed:
                                          _isLoading ? null : _pickImage,
                                      icon: const Icon(Icons.upload_file,
                                          size: 18),
                                      label: Text(
                                          _pickedImageBytes != null ||
                                                  _existingImageUrl != null
                                              ? 'Change'
                                              : 'Upload'),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(0, 36),
                                      ),
                                    ),
                                    if (_pickedImageBytes != null ||
                                        _existingImageUrl != null) ...[
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.close, size: 18),
                                        color: AppColors.textSecondary,
                                        onPressed: _isLoading
                                            ? null
                                            : () => setState(() {
                                                  _pickedImageName = null;
                                                  _pickedImageBytes = null;
                                                  _existingImageUrl = null;
                                                  _imageUploadProgress = 0;
                                                }),
                                        tooltip: 'Remove',
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _tokenRewardController,
                        decoration:
                            const InputDecoration(labelText: 'Token Reward'),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          final n = int.tryParse(v ?? '');
                          return (n == null || n <= 0)
                              ? 'Enter a valid number'
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        decoration: const InputDecoration(
                            labelText: 'Duration (seconds)'),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          final n = int.tryParse(v ?? '');
                          return (n == null || n <= 0)
                              ? 'Enter a valid number'
                              : null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _earningType,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: _earningTypes
                      .map((t) => DropdownMenuItem(
                            value: t.$1,
                            child: Text(t.$2),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _earningType = value);
                  },
                ),
                const SizedBox(height: 16),
                // Media URL (editable)
                if (_earningType == 'video' || _earningType == 'adVideo') ...[
                  TextFormField(
                    controller: _mediaUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Media URL',
                      hintText: 'https://...',
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _streakPointsController,
                  decoration: const InputDecoration(
                    labelText: 'Streak Points',
                    hintText: '0',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _tokenBudgetController,
                        decoration: const InputDecoration(
                          labelText: 'Token Budget (optional)',
                          hintText: 'Leave empty for unlimited',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return null;
                          final num = int.tryParse(value.trim());
                          if (num == null || num <= 0) {
                            return 'Enter a valid positive number';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (widget.opportunity['tokenSpent'] != null &&
                        (widget.opportunity['tokenSpent'] as num? ?? 0) > 0) ...[
                      const SizedBox(width: 16),
                      Text(
                        'Spent: ${widget.opportunity['tokenSpent']}',
                        style: TextStyle(
                          fontSize: 13,
                          color: widget.opportunity['budgetExhausted'] == true
                              ? AppColors.error
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // AdMob fields
                if (_earningType == 'adVideo') ...[
                  TextFormField(
                    controller: _adUnitIdController,
                    decoration: const InputDecoration(
                      labelText: 'Ad Unit ID',
                      hintText: 'ca-app-pub-xxx/yyy',
                    ),
                    validator: (v) => _earningType == 'adVideo' &&
                            (v == null || v.trim().isEmpty)
                        ? 'Required for Ad Video type'
                        : null,
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _dailyLimitController,
                  decoration: const InputDecoration(
                    labelText: 'Daily Limit Per User (optional)',
                    hintText: 'No limit',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                // Bonus reward section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        value: _hasBonusReward,
                        onChanged: (v) => setState(() => _hasBonusReward = v),
                        title: const Text('Bonus Reward'),
                        subtitle: const Text('Extra tokens for streaks',
                            style: TextStyle(fontSize: 11)),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      if (_hasBonusReward) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _bonusRewardController,
                                decoration: const InputDecoration(
                                  labelText: 'Bonus Tokens',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _bonusMultiplierController,
                                decoration: const InputDecoration(
                                  labelText: 'Multiplier',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _bonusIntervalType,
                                decoration: const InputDecoration(
                                  labelText: 'Interval Type',
                                  isDense: true,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'daily', child: Text('Daily')),
                                  DropdownMenuItem(
                                      value: 'weekly', child: Text('Weekly')),
                                  DropdownMenuItem(
                                      value: 'monthly',
                                      child: Text('Monthly')),
                                ],
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() => _bonusIntervalType = v);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _bonusIntervalXController,
                                decoration: const InputDecoration(
                                  labelText: 'Interval X',
                                  hintText: 'Every X intervals',
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Targeting
                _TargetingCriteriaWidget(
                  initialTargeting: _targeting,
                  onChanged: (v) => _targeting = v,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  value: _isActive,
                  onChanged: (v) => setState(() => _isActive = v),
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                // Expiry date
                InkWell(
                  onTap: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _expiresAt ?? now.add(const Duration(days: 30)),
                      firstDate: now.subtract(const Duration(days: 365)),
                      lastDate: now.add(const Duration(days: 365 * 3)),
                    );
                    if (picked != null && mounted) {
                      setState(() => _expiresAt = picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Expires At (optional)',
                      isDense: true,
                      suffixIcon: _expiresAt != null
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () =>
                                  setState(() => _expiresAt = null),
                              tooltip: 'Clear',
                            )
                          : const Icon(Icons.calendar_today, size: 16),
                    ),
                    child: Text(
                      _expiresAt != null
                          ? DateFormat('dd MMM yyyy').format(_expiresAt!)
                          : 'No expiry date',
                      style: TextStyle(
                        fontSize: 13,
                        color: _expiresAt != null
                            ? AppColors.textPrimaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Edit Video Dialog
// ---------------------------------------------------------------------------

class _EditVideoDialog extends StatefulWidget {
  final Map<String, dynamic> opportunity;
  final VoidCallback? onUpdated;

  const _EditVideoDialog({
    required this.opportunity,
    this.onUpdated,
  });

  @override
  State<_EditVideoDialog> createState() => _EditVideoDialogState();
}

class _EditVideoDialogState extends State<_EditVideoDialog> {
  late final TextEditingController _mediaUrlController;
  String? _pickedFileName;
  Uint8List? _pickedFileBytes;
  double _uploadProgress = 0;
  bool _isUploading = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _mediaUrlController =
        TextEditingController(text: widget.opportunity['mediaUrl']?.toString() ?? '');
  }

  @override
  void dispose() {
    _mediaUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pickedFileName = result.files.single.name;
        _pickedFileBytes = result.files.single.bytes;
        _mediaUrlController.clear();
      });
    }
  }

  void _clearPickedFile() {
    setState(() {
      _pickedFileName = null;
      _pickedFileBytes = null;
      _uploadProgress = 0;
    });
  }

  Future<String> _uploadVideoToStorage() async {
    final oppId = widget.opportunity['id'] as String;
    final threadId = widget.opportunity['threadId'] as String? ?? 'unknown';
    final ext = _pickedFileName!.split('.').last;
    final ref = FirebaseStorage.instance
        .ref()
        .child('earn_videos')
        .child(threadId)
        .child('$oppId.$ext');

    final uploadTask = ref.putData(
      _pickedFileBytes!,
      SettableMetadata(contentType: 'video/$ext'),
    );

    uploadTask.snapshotEvents.listen((snapshot) {
      if (mounted) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  Future<void> _handleSave() async {
    // Must have either a file or URL
    if (_pickedFileBytes == null && _mediaUrlController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a video or enter a video URL'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _isUploading = _pickedFileBytes != null;
    });

    try {
      String? mediaUrl = _mediaUrlController.text.trim().isEmpty
          ? null
          : _mediaUrlController.text.trim();
      if (_pickedFileBytes != null) {
        mediaUrl = await _uploadVideoToStorage();
      }
      setState(() => _isUploading = false);

      await FirebaseFirestore.instance
          .collection('earnOpportunities')
          .doc(widget.opportunity['id'] as String)
          .update({
        'mediaUrl': mediaUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.of(context).pop();
        widget.onUpdated?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video updated'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUrl = widget.opportunity['mediaUrl']?.toString();
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text(
        'Edit Video: ${widget.opportunity['title'] ?? 'Opportunity'}',
        style: const TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentUrl != null && _pickedFileName == null) ...[
              Text(
                'Current video',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.videocam,
                        color: AppColors.success, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        Uri.tryParse(currentUrl)?.pathSegments.lastOrNull ??
                            currentUrl,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimaryDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            // Upload section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderDark),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _pickedFileName != null ? 'New Video' : 'Replace Video',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_pickedFileName != null) ...[
                    Row(
                      children: [
                        const Icon(Icons.videocam,
                            color: AppColors.success, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _pickedFileName!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textPrimaryDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          color: AppColors.textSecondary,
                          onPressed: _isLoading ? null : _clearPickedFile,
                          tooltip: 'Remove',
                        ),
                      ],
                    ),
                    if (_isUploading) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _uploadProgress,
                        backgroundColor: AppColors.borderDark,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.secondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Uploading... ${(_uploadProgress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ] else ...[
                    OutlinedButton.icon(
                      onPressed: _isLoading ? null : _pickVideoFile,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Choose Video File'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                      ),
                    ),
                  ],
                  if (_pickedFileName == null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.borderDark)),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or paste URL',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.borderDark)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _mediaUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Video URL',
                        hintText: 'https://...',
                        isDense: true,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
          child: _isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    if (_isUploading) ...[
                      const SizedBox(width: 8),
                      Text('Uploading ${(_uploadProgress * 100).toInt()}%'),
                    ],
                  ],
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Question Editor Dialog (used by both Create and Edit flows)
// ---------------------------------------------------------------------------

class _QuestionEditorDialog extends StatefulWidget {
  final Map<String, dynamic>? existing;

  const _QuestionEditorDialog({this.existing});

  @override
  State<_QuestionEditorDialog> createState() => _QuestionEditorDialogState();
}

class _QuestionEditorDialogState extends State<_QuestionEditorDialog> {
  final _textController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  bool _isAttentionCheck = false;
  String? _correctAnswer;

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      _textController.text = widget.existing!['text'] ?? '';
      _isAttentionCheck = widget.existing!['isAttentionCheck'] == true;
      _correctAnswer = widget.existing!['correctAnswer'] as String?;
      final options =
          (widget.existing!['options'] as List?)?.cast<String>() ?? [];
      for (final opt in options) {
        _optionControllers.add(TextEditingController(text: opt));
      }
    }
    // Ensure at least 2 option fields
    while (_optionControllers.length < 2) {
      _optionControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    for (final c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    if (_optionControllers.length >= 6) return;
    setState(() => _optionControllers.add(TextEditingController()));
  }

  void _removeOption(int index) {
    if (_optionControllers.length <= 2) return;
    setState(() {
      final removed = _optionControllers.removeAt(index);
      if (_correctAnswer == removed.text) {
        _correctAnswer = null;
      }
      removed.dispose();
    });
  }

  void _handleSave() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final options = _optionControllers
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();
    if (options.length < 2) return;

    final id = widget.existing?['id'] ??
        'q_${DateTime.now().millisecondsSinceEpoch}';

    Navigator.of(context).pop(<String, dynamic>{
      'id': id,
      'text': text,
      'options': options,
      'orderIndex': widget.existing?['orderIndex'] ?? 0,
      'isAttentionCheck': _isAttentionCheck,
      'correctAnswer': _isAttentionCheck ? _correctAnswer : null,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: Text(
        widget.existing != null ? 'Edit Question' : 'Add Question',
        style: const TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Question text',
                  hintText: 'e.g., What best describes your view?',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Options (${_optionControllers.length})',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  if (_optionControllers.length < 6)
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add'),
                      onPressed: _addOption,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              ...List.generate(_optionControllers.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _optionControllers[i],
                          decoration: InputDecoration(
                            labelText: 'Option ${i + 1}',
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_optionControllers.length > 2)
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          color: AppColors.error,
                          onPressed: () => _removeOption(i),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _isAttentionCheck,
                onChanged: (v) => setState(() {
                  _isAttentionCheck = v;
                  if (!v) _correctAnswer = null;
                }),
                title: const Text('Attention check',
                    style: TextStyle(fontSize: 13)),
                subtitle: const Text('Require a specific correct answer',
                    style: TextStyle(fontSize: 11)),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              if (_isAttentionCheck) ...[
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _correctAnswer,
                  decoration:
                      const InputDecoration(labelText: 'Correct answer'),
                  items: _optionControllers
                      .where((c) => c.text.trim().isNotEmpty)
                      .map((c) => DropdownMenuItem(
                            value: c.text.trim(),
                            child: Text(c.text.trim()),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _correctAnswer = v),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Edit Questions Dialog (for existing opportunities)
// ---------------------------------------------------------------------------

class _EditQuestionsDialog extends StatefulWidget {
  final String opportunityId;
  final List<Map<String, dynamic>> initialQuestions;
  final VoidCallback? onSaved;

  const _EditQuestionsDialog({
    required this.opportunityId,
    required this.initialQuestions,
    this.onSaved,
  });

  @override
  State<_EditQuestionsDialog> createState() => _EditQuestionsDialogState();
}

class _EditQuestionsDialogState extends State<_EditQuestionsDialog> {
  late List<Map<String, dynamic>> _questions;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _questions = widget.initialQuestions
        .map((q) => Map<String, dynamic>.from(q))
        .toList();
  }

  Future<void> _showQuestionEditor(
      {int? index, Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => _QuestionEditorDialog(existing: existing),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          _questions[index] = result;
        } else {
          _questions.add(result);
        }
        for (var i = 0; i < _questions.length; i++) {
          _questions[i]['orderIndex'] = i;
        }
      });
    }
  }

  Future<void> _handleSave() async {
    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance
          .collection('earnOpportunities')
          .doc(widget.opportunityId)
          .update({
        'questions': _questions,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.of(context).pop();
        widget.onSaved?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Questions updated successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving questions: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardDark,
      title: const Text(
        'Edit Questions',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_questions.length} question${_questions.length == 1 ? '' : 's'}',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline,
                        color: AppColors.secondary),
                    tooltip: 'Add question',
                    onPressed: () => _showQuestionEditor(),
                  ),
                ],
              ),
              if (_questions.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'No questions — tap + to add one',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ..._questions.asMap().entries.map((entry) {
                final idx = entry.key;
                final q = entry.value;
                final options =
                    (q['options'] as List?)?.cast<String>() ?? [];
                return Card(
                  color: AppColors.surfaceDark,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      q['text'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    subtitle: Text(
                      '${options.length} options${q['isAttentionCheck'] == true ? ' · attention check' : ''}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          color: AppColors.textSecondary,
                          onPressed: () => _showQuestionEditor(
                              index: idx, existing: q),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 18),
                          color: AppColors.error,
                          onPressed: () {
                            setState(() => _questions.removeAt(idx));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Targeting Criteria Widget (shared across all 4 dialogs)
// ---------------------------------------------------------------------------

class _TargetingCriteriaWidget extends StatefulWidget {
  final Map<String, dynamic>? initialTargeting;
  final ValueChanged<Map<String, dynamic>?> onChanged;

  const _TargetingCriteriaWidget({
    this.initialTargeting,
    required this.onChanged,
  });

  @override
  State<_TargetingCriteriaWidget> createState() =>
      _TargetingCriteriaWidgetState();
}

class _TargetingCriteriaWidgetState extends State<_TargetingCriteriaWidget> {
  bool _expanded = false;

  // Selections
  List<String> _genders = [];
  int? _ageMin;
  int? _ageMax;
  List<String> _provinces = [];
  List<String> _languages = [];
  List<String> _interests = [];
  List<String> _devicePlatforms = [];
  String? _engagementLevel;
  String? _previousBrandInteraction;
  int? _maxAudience;
  int? _accountAgeMinDays;
  int? _accountAgeMaxDays;

  final _ageMinController = TextEditingController();
  final _ageMaxController = TextEditingController();
  final _maxAudienceController = TextEditingController();
  final _accountAgeMinController = TextEditingController();
  final _accountAgeMaxController = TextEditingController();

  // Constants matching targeting.ts
  static const _allGenders = [
    ('male', 'Male'),
    ('female', 'Female'),
    ('non-binary', 'Non-Binary'),
    ('prefer_not_to_say', 'Prefer Not to Say'),
  ];

  static const _allProvinces = [
    ('gauteng', 'Gauteng'),
    ('western_cape', 'Western Cape'),
    ('eastern_cape', 'Eastern Cape'),
    ('kwazulu_natal', 'KwaZulu-Natal'),
    ('free_state', 'Free State'),
    ('north_west', 'North West'),
    ('mpumalanga', 'Mpumalanga'),
    ('limpopo', 'Limpopo'),
    ('northern_cape', 'Northern Cape'),
  ];

  static const _allLanguages = [
    ('en', 'English'),
    ('af', 'Afrikaans'),
    ('zu', 'Zulu'),
    ('xh', 'Xhosa'),
    ('st', 'Sesotho'),
    ('tn', 'Setswana'),
    ('nr', 'Ndebele'),
    ('nso', 'Sepedi'),
    ('ss', 'Swati'),
    ('ve', 'Venda'),
    ('ts', 'Tsonga'),
  ];

  static const _allInterests = [
    ('sports', 'Sports'),
    ('fashion', 'Fashion'),
    ('tech', 'Tech'),
    ('food', 'Food'),
    ('music', 'Music'),
    ('gaming', 'Gaming'),
    ('fitness', 'Fitness'),
    ('travel', 'Travel'),
    ('beauty', 'Beauty'),
    ('finance', 'Finance'),
    ('education', 'Education'),
    ('entertainment', 'Entertainment'),
    ('automotive', 'Automotive'),
    ('health', 'Health'),
    ('shopping', 'Shopping'),
    ('parenting', 'Parenting'),
  ];

  static const _allDevicePlatforms = [
    ('android', 'Android'),
    ('ios', 'iOS'),
  ];

  static const _allEngagementLevels = [
    ('new', 'New'),
    ('active', 'Active'),
    ('dormant', 'Dormant'),
  ];

  static const _allBrandInteractions = [
    ('include', 'Include (previous users)'),
    ('exclude', 'Exclude (new users only)'),
  ];

  @override
  void initState() {
    super.initState();
    final t = widget.initialTargeting;
    if (t != null) {
      _genders = List<String>.from(t['genders'] ?? []);
      _ageMin = t['ageMin'] as int?;
      _ageMax = t['ageMax'] as int?;
      _provinces = List<String>.from(t['provinces'] ?? []);
      _languages = List<String>.from(t['languages'] ?? []);
      _interests = List<String>.from(t['interests'] ?? []);
      _devicePlatforms = List<String>.from(t['devicePlatforms'] ?? []);
      _engagementLevel = t['engagementLevel'] as String?;
      _previousBrandInteraction = t['previousBrandInteraction'] as String?;
      _maxAudience = t['maxAudience'] as int?;
      _accountAgeMinDays = t['accountAgeMinDays'] as int?;
      _accountAgeMaxDays = t['accountAgeMaxDays'] as int?;

      if (_ageMin != null) _ageMinController.text = _ageMin.toString();
      if (_ageMax != null) _ageMaxController.text = _ageMax.toString();
      if (_maxAudience != null) {
        _maxAudienceController.text = _maxAudience.toString();
      }
      if (_accountAgeMinDays != null) {
        _accountAgeMinController.text = _accountAgeMinDays.toString();
      }
      if (_accountAgeMaxDays != null) {
        _accountAgeMaxController.text = _accountAgeMaxDays.toString();
      }

      _expanded = _hasAnyTargeting();
    }
  }

  @override
  void dispose() {
    _ageMinController.dispose();
    _ageMaxController.dispose();
    _maxAudienceController.dispose();
    _accountAgeMinController.dispose();
    _accountAgeMaxController.dispose();
    super.dispose();
  }

  bool _hasAnyTargeting() {
    return _genders.isNotEmpty ||
        _ageMin != null ||
        _ageMax != null ||
        _provinces.isNotEmpty ||
        _languages.isNotEmpty ||
        _interests.isNotEmpty ||
        _devicePlatforms.isNotEmpty ||
        _engagementLevel != null ||
        _previousBrandInteraction != null ||
        _maxAudience != null ||
        _accountAgeMinDays != null ||
        _accountAgeMaxDays != null;
  }

  void _emitChange() {
    if (!_hasAnyTargeting()) {
      widget.onChanged(null);
      return;
    }
    final targeting = <String, dynamic>{};
    if (_genders.isNotEmpty) targeting['genders'] = _genders;
    if (_ageMin != null) targeting['ageMin'] = _ageMin;
    if (_ageMax != null) targeting['ageMax'] = _ageMax;
    if (_provinces.isNotEmpty) targeting['provinces'] = _provinces;
    if (_languages.isNotEmpty) targeting['languages'] = _languages;
    if (_interests.isNotEmpty) targeting['interests'] = _interests;
    if (_devicePlatforms.isNotEmpty) {
      targeting['devicePlatforms'] = _devicePlatforms;
    }
    if (_engagementLevel != null) {
      targeting['engagementLevel'] = _engagementLevel;
    }
    if (_previousBrandInteraction != null) {
      targeting['previousBrandInteraction'] = _previousBrandInteraction;
    }
    if (_maxAudience != null) targeting['maxAudience'] = _maxAudience;
    if (_accountAgeMinDays != null) {
      targeting['accountAgeMinDays'] = _accountAgeMinDays;
    }
    if (_accountAgeMaxDays != null) {
      targeting['accountAgeMaxDays'] = _accountAgeMaxDays;
    }
    widget.onChanged(targeting);
  }

  Widget _buildChipSection(
    String label,
    List<(String, String)> options,
    List<String> selected,
    ValueChanged<List<String>> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: options.map((opt) {
            final isSelected = selected.contains(opt.$1);
            return FilterChip(
              label: Text(opt.$2, style: const TextStyle(fontSize: 11)),
              selected: isSelected,
              onSelected: (v) {
                setState(() {
                  if (v) {
                    selected.add(opt.$1);
                  } else {
                    selected.remove(opt.$1);
                  }
                });
                onChanged(selected);
                _emitChange();
              },
              selectedColor: AppColors.secondary.withValues(alpha: 0.3),
              checkmarkColor: AppColors.secondary,
              backgroundColor: AppColors.surfaceDark,
              side: BorderSide(
                color: isSelected ? AppColors.secondary : AppColors.borderDark,
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Targeting Criteria',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (_hasAnyTargeting()) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1, color: AppColors.borderDark),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Genders
                  _buildChipSection(
                    'Genders',
                    _allGenders,
                    _genders,
                    (v) => _genders = v,
                  ),
                  const SizedBox(height: 12),
                  // Age range
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ageMinController,
                          decoration: const InputDecoration(
                            labelText: 'Min Age',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            _ageMin = int.tryParse(v);
                            _emitChange();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _ageMaxController,
                          decoration: const InputDecoration(
                            labelText: 'Max Age',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            _ageMax = int.tryParse(v);
                            _emitChange();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Provinces
                  _buildChipSection(
                    'Provinces',
                    _allProvinces,
                    _provinces,
                    (v) => _provinces = v,
                  ),
                  const SizedBox(height: 12),
                  // Languages
                  _buildChipSection(
                    'Languages',
                    _allLanguages,
                    _languages,
                    (v) => _languages = v,
                  ),
                  const SizedBox(height: 12),
                  // Interests
                  _buildChipSection(
                    'Interests',
                    _allInterests,
                    _interests,
                    (v) => _interests = v,
                  ),
                  const SizedBox(height: 12),
                  // Device platforms
                  _buildChipSection(
                    'Device Platforms',
                    _allDevicePlatforms,
                    _devicePlatforms,
                    (v) => _devicePlatforms = v,
                  ),
                  const SizedBox(height: 12),
                  // Engagement level
                  DropdownButtonFormField<String>(
                    initialValue: _engagementLevel,
                    decoration: const InputDecoration(
                      labelText: 'Engagement Level (optional)',
                      isDense: true,
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                          value: null, child: Text('Any')),
                      ..._allEngagementLevels.map((e) => DropdownMenuItem(
                            value: e.$1,
                            child: Text(e.$2),
                          )),
                    ],
                    onChanged: (v) {
                      setState(() => _engagementLevel = v);
                      _emitChange();
                    },
                  ),
                  const SizedBox(height: 12),
                  // Brand interaction
                  DropdownButtonFormField<String>(
                    initialValue: _previousBrandInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Previous Brand Interaction (optional)',
                      isDense: true,
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                          value: null, child: Text('Any')),
                      ..._allBrandInteractions.map((e) => DropdownMenuItem(
                            value: e.$1,
                            child: Text(e.$2),
                          )),
                    ],
                    onChanged: (v) {
                      setState(() => _previousBrandInteraction = v);
                      _emitChange();
                    },
                  ),
                  const SizedBox(height: 12),
                  // Account age range
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _accountAgeMinController,
                          decoration: const InputDecoration(
                            labelText: 'Min Account Age (days)',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            _accountAgeMinDays = int.tryParse(v);
                            _emitChange();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _accountAgeMaxController,
                          decoration: const InputDecoration(
                            labelText: 'Max Account Age (days)',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            _accountAgeMaxDays = int.tryParse(v);
                            _emitChange();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Max audience
                  TextField(
                    controller: _maxAudienceController,
                    decoration: const InputDecoration(
                      labelText: 'Max Audience Size (optional)',
                      hintText: 'No limit',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      _maxAudience = int.tryParse(v);
                      _emitChange();
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
