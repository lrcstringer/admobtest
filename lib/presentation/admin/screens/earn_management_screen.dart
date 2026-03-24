import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/image_resize_utils.dart';
import '../../theme/app_colors.dart';
import '../widgets/svg_aware_image.dart';

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
      // Load clients (active and not soft-deleted)
      final clientsSnapshot = await FirebaseFirestore.instance
          .collection('clients')
          .where('isActive', isEqualTo: true)
          .get();

      _clients = clientsSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((c) => c['isDeleted'] != true)
          .toList();

      // Load statistics (exclude soft-deleted)
      final threadsSnapshot = await FirebaseFirestore.instance
          .collection('earnThreads')
          .where('isActive', isEqualTo: true)
          .get();
      final activeThreads = threadsSnapshot.docs
          .where((d) => (d.data())['isDeleted'] != true)
          .length;

      final opportunitiesSnapshot = await FirebaseFirestore.instance
          .collection('earnOpportunities')
          .where('isActive', isEqualTo: true)
          .get();
      final activeOpportunities = opportunitiesSnapshot.docs
          .where((d) => (d.data())['isDeleted'] != true)
          .length;

      _statistics = {
        'activeClients': _clients.length,
        'activeThreads': activeThreads,
        'activeOpportunities': activeOpportunities,
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

      final loadedOpps = opportunitiesSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((o) => o['isDeleted'] != true)
          .toList();

      // Self-heal: fix the availableOpportunities counter if it drifted
      final activeCount = loadedOpps.where((o) => o['isActive'] == true).length;
      final threadIdx = _threads.indexWhere((t) => t['id'] == threadId);
      if (threadIdx >= 0) {
        final storedCount =
            (_threads[threadIdx]['availableOpportunities'] as num?)?.toInt() ?? 0;
        if (storedCount != activeCount) {
          // Fix Firestore counter silently
          FirebaseFirestore.instance
              .collection('earnThreads')
              .doc(threadId)
              .update({'availableOpportunities': activeCount})
              .catchError((_) {});
          _threads[threadIdx]['availableOpportunities'] = activeCount;
        }
      }

      setState(() {
        _opportunities = loadedOpps;
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
      backgroundColor: AppColors.adminBackground,
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
        color: AppColors.adminCard,
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
                                          errorBuilder: (_, _, _) => Center(
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
                                    leading: SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 36,
                                            height: 36,
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
                                                  width: 36,
                                                  height: 36,
                                                  errorBuilder: (_, _, _) => Center(
                                                    child: Text(
                                                      _threadInitials(thread),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
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
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              );
                                            }(),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: thread['isActive'] == true
                                                    ? AppColors.success
                                                    : AppColors.textSecondary,
                                                border: Border.all(
                                                  color: isSelected
                                                      ? AppColors.primary.withValues(alpha: 0.15)
                                                      : AppColors.adminSurface,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
        backgroundColor: AppColors.adminSurface,
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
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
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
        color: AppColors.adminCard,
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
      color: AppColors.adminSurface,
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
                    errorBuilder: (_, _, _) => Center(
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
        backgroundColor: AppColors.adminSurface,
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
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
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

}

// Top-level helpers shared by _EarnManagementScreenState and _CampaignCard
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
      case 'image':
        typeIcon = Icons.image_outlined;
        break;
      case 'poll':
        typeIcon = Icons.poll_outlined;
        break;
      case 'adVideo':
        typeIcon = Icons.play_circle_outline;
        break;
      default:
        typeIcon = Icons.smart_display_outlined;
    }

    return Card(
      color: AppColors.adminSurface,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Stack(
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
                          errorBuilder: (_, _, _) => Container(
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
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: opportunity['isActive'] == true
                            ? AppColors.success
                            : AppColors.textSecondary,
                        border: Border.all(
                          color: AppColors.adminSurface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                          color: AppColors.adminSurface,
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
                          case 'open_poll':
                            _handlePollAction(context, 'openPoll', 'Poll opened');
                          case 'reopen_poll':
                            _handlePollAction(context, 'reopenPoll', 'Poll reopened');
                          case 'close_poll':
                            _handlePollAction(context, 'closePoll', 'Poll closed');
                          case 'poll_results':
                            _showPollResultsDialog(context);
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
                        if (earningType != 'poll')
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
                        if (earningType == 'poll') ...[
                          if (!(opportunity['isActive'] == true))
                            PopupMenuItem(
                              value: 'open_poll',
                              child: Row(
                                children: [
                                  Icon(Icons.play_arrow, size: 18,
                                      color: AppColors.success),
                                  SizedBox(width: 8),
                                  Text('Open Poll'),
                                ],
                              ),
                            ),
                          if (!(opportunity['isActive'] == true))
                            PopupMenuItem(
                              value: 'reopen_poll',
                              child: Row(
                                children: [
                                  Icon(Icons.refresh, size: 18,
                                      color: AppColors.secondary),
                                  SizedBox(width: 8),
                                  Text('Reopen Poll'),
                                ],
                              ),
                            ),
                          if (opportunity['isActive'] == true)
                            const PopupMenuItem(
                              value: 'close_poll',
                              child: Row(
                                children: [
                                  Icon(Icons.stop, size: 18,
                                      color: AppColors.warning),
                                  SizedBox(width: 8),
                                  Text('Close Poll'),
                                ],
                              ),
                            ),
                          const PopupMenuItem(
                            value: 'poll_results',
                            child: Row(
                              children: [
                                Icon(Icons.bar_chart, size: 18),
                                SizedBox(width: 8),
                                Text('Poll Results'),
                              ],
                            ),
                          ),
                        ],
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
        backgroundColor: AppColors.adminSurface,
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
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
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

    // TODO: Remove debug print after verifying Edit Questions data flow
    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      debugPrint('[EditQuestions.open] q[$i] keys=${q.keys.toList()} '
          'correctResponseMediaUrl=${q['correctResponseMediaUrl']}');
    }

    showDialog(
      context: context,
      builder: (ctx) => _EditQuestionsDialog(
        opportunityId: oppId,
        initialQuestions: questions,
        onSaved: onQuestionsEdited,
      ),
    );
  }

  Future<void> _handlePollAction(
      BuildContext context, String functionName, String successMsg) async {
    final pollId = opportunity['pollId'] as String?;
    if (pollId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No linked poll found'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable(functionName);
      await callable.call(<String, dynamic>{'pollId': pollId});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMsg),
            backgroundColor: AppColors.success,
          ),
        );
        onUpdated?.call();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showPollResultsDialog(BuildContext context) {
    final pollId = opportunity['pollId'] as String?;
    if (pollId == null) return;

    showDialog(
      context: context,
      builder: (ctx) => _PollResultsDialog(pollId: pollId),
    );
  }
}

// ---------------------------------------------------------------------------
// Poll Results Dialog
// ---------------------------------------------------------------------------

class _PollResultsDialog extends StatefulWidget {
  final String pollId;
  const _PollResultsDialog({required this.pollId});

  @override
  State<_PollResultsDialog> createState() => _PollResultsDialogState();
}

class _PollResultsDialogState extends State<_PollResultsDialog> {
  bool _isLoading = true;
  Map<String, dynamic>? _data;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    try {
      final callable =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('getPollAdminDetails');
      final result = await callable.call(<String, dynamic>{
        'pollId': widget.pollId,
      });
      if (mounted) {
        setState(() {
          _data = Map<String, dynamic>.from(result.data as Map);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.adminCard,
      title: const Text(
        'Poll Results',
        style: TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 500,
        child: _isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            : _error != null
                ? Text('Error: $_error',
                    style: const TextStyle(color: AppColors.error))
                : _buildResults(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildResults() {
    final poll =
        Map<String, dynamic>.from(_data!['poll'] as Map? ?? {});
    final results =
        Map<String, dynamic>.from(_data!['results'] as Map? ?? {});
    final responses = (_data!['responses'] as List?) ?? [];

    final question = poll['question'] as String? ?? '';
    final status = poll['status'] as String? ?? 'draft';
    final options = (poll['options'] as List?) ?? [];
    final totalRespondents = results['totalRespondents'] as int? ?? 0;
    final optionCounts = Map<String, dynamic>.from(
        results['optionCounts'] as Map? ?? {});
    final percentages = Map<String, dynamic>.from(
        results['percentages'] as Map? ?? {});

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status badge
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == 'open'
                      ? AppColors.success.withValues(alpha: 0.2)
                      : status == 'draft'
                          ? AppColors.warning.withValues(alpha: 0.2)
                          : AppColors.textSecondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: status == 'open'
                        ? AppColors.success
                        : status == 'draft'
                            ? AppColors.warning
                            : AppColors.textSecondary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '$totalRespondents respondent${totalRespondents == 1 ? '' : 's'}',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Question
          Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 16),
          // Bar chart per option
          ...options.map((opt) {
            final optMap = Map<String, dynamic>.from(opt as Map);
            final optId = optMap['id'] as String;
            final optText = optMap['text'] as String;
            final count =
                (optionCounts[optId] as num?)?.toInt() ?? 0;
            final pct =
                (percentages[optId] as num?)?.toDouble() ?? 0.0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          optText,
                          style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textPrimaryDark),
                        ),
                      ),
                      Text(
                        '$count (${pct.toStringAsFixed(0)}%)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      minHeight: 12,
                      backgroundColor:
                          AppColors.adminSurface,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                              AppColors.secondary),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (responses.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Recent Responses (${responses.length})',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            ...responses.take(20).map((r) {
              final resp = Map<String, dynamic>.from(r as Map);
              final userId = resp['userId'] as String? ?? '';
              final selectedOpt =
                  resp['selectedOption'] as String? ?? '';
              final rStatus =
                  resp['status'] as String? ?? 'valid';
              // Find option text
              final optionObj = options.cast<Map>().firstWhere(
                (o) => o['id'] == selectedOpt,
                orElse: () => {'text': selectedOpt},
              );
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'User: ${userId.substring(0, userId.length > 8 ? 8 : userId.length)}...',
                  style: const TextStyle(fontSize: 12),
                ),
                subtitle: Text(
                  optionObj['text'] as String? ?? selectedOpt,
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
                trailing: rStatus == 'invalidated'
                    ? const Text('INVALIDATED',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.error))
                    : null,
              );
            }),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------

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

  // Inline sub-account creation
  bool _createNewSubAccount = false;
  final _subAccountNameController = TextEditingController();
  bool _subAccountNameManuallyEdited = false;

  // Inline account type restrictions
  bool _configureRestrictions = false;
  bool _allowP2pSend = true;
  bool _allowP2pReceive = true;
  bool _allowCashout = true;
  final _expiryDaysController = TextEditingController();
  List<String> _allowedOfframps = ['*'];

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
      _loadTokenSourceAccounts(_selectedClientId!);
    }
    // Auto-sync sub-account name with title when creating new
    _titleController.addListener(_syncSubAccountName);
  }

  void _syncSubAccountName() {
    if (_createNewSubAccount && !_subAccountNameManuallyEdited) {
      _subAccountNameController.text = _titleController.text;
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

  Future<void> _loadTokenSourceAccounts(String clientId) async {
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListClientSubAccounts')
          .call({'clientId': clientId});
      final subList = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];

      // Find client display name from widget.clients
      final clientData = widget.clients.firstWhere(
        (c) => c['id'] == clientId,
        orElse: () => <String, dynamic>{},
      );
      final clientName =
          clientData['displayName'] ?? clientData['companyName'] ?? clientId;

      // Build unified list: client main account + sub-accounts
      final accounts = <Map<String, dynamic>>[
        {
          'ledgerAccountId': 'client:$clientId',
          'name': '$clientName (Main Account)',
        },
        ...subList,
      ];

      if (mounted) {
        setState(() {
          _subAccounts = accounts;
          // Auto-select main account if none selected
          _selectedSubAccountId ??= 'client:$clientId';
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _titleController.removeListener(_syncSubAccountName);
    _titleController.dispose();
    _descriptionController.dispose();
    _subAccountNameController.dispose();
    _expiryDaysController.dispose();
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
        allowedExtensions: adminImageExtensions,
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
    return uploadAdminImage(
      bytes: _pickedImageBytes!,
      fileName: _pickedImageName,
      storagePath: 'thread_images',
      fileId: threadId,
      resizeTarget: ImageResizeTarget.threadImage,
      onProgress: (p) {
        if (mounted) setState(() => _uploadProgress = p);
      },
    );
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
      final callData = <String, dynamic>{
        'clientId': _selectedClientId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'isPinned': _isPinned,
        'isFeatured': _isFeatured,
        'isActive': _isActive,
        'activeFrom': _activeFrom?.toIso8601String(),
        'activeTo': _activeTo?.toIso8601String(),
        'targeting': _targeting,
      };

      if (_createNewSubAccount) {
        // Omit tokenSourceAccountId → backend auto-creates sub-account
        callData['subAccountName'] =
            _subAccountNameController.text.trim();
        if (_configureRestrictions) {
          callData['inlineAccountType'] = {
            'name': _subAccountNameController.text.trim(),
            'description':
                'Account type for ${_subAccountNameController.text.trim()}',
            'rules': {
              'allowedOfframps': _allowedOfframps,
              'allowP2pSend': _allowP2pSend,
              'allowP2pReceive': _allowP2pReceive,
              'allowCashout': _allowCashout,
              if (_expiryDaysController.text.trim().isNotEmpty)
                'expiryDays':
                    int.tryParse(_expiryDaysController.text.trim()),
            },
          };
        }
      } else {
        // Existing flow — use selected sub-account and account type
        callData['tokenSourceAccountId'] =
            overrideSubAccountId ?? _selectedSubAccountId;
        callData['tokenDestAccountTypeId'] = _selectedAccountTypeId;
      }
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('createEarnThread')
          .call(callData);

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
            backgroundColor: AppColors.adminCard,
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
        final msg = e is FirebaseFunctionsException
            ? 'Error: [${e.code}] ${e.message ?? e.details ?? 'Unknown'}'
            : 'Error creating campaign: $e';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 8),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.adminCard,
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
                  if (value != null) _loadTokenSourceAccounts(value);
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
                            color: AppColors.adminSurface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderDark),
                          ),
                          child: _pickedImageBytes != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: svgAwareMemoryImage(
                                    _pickedImageBytes!,
                                    fileName: _pickedImageName,
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
                    // Toggle: existing sub-account vs create new
                    SwitchListTile(
                      value: _createNewSubAccount,
                      onChanged: _selectedClientId == null
                          ? null
                          : (v) {
                              setState(() {
                                _createNewSubAccount = v;
                                if (v) {
                                  _subAccountNameManuallyEdited = false;
                                  _subAccountNameController.text =
                                      _titleController.text;
                                }
                              });
                            },
                      title: const Text(
                        'Create new sub-account',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      subtitle: Text(
                        _createNewSubAccount
                            ? 'A new sub-account will be created with 0 balance (fund separately)'
                            : 'Select an existing token source account',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    const SizedBox(height: 12),
                    if (!_createNewSubAccount) ...[
                      // === Existing sub-account dropdown ===
                      if (_subAccounts.isNotEmpty) ...[
                        DropdownButtonFormField<String>(
                          initialValue: _selectedSubAccountId,
                          decoration: const InputDecoration(
                            labelText: 'Token Source Account',
                            isDense: true,
                          ),
                          items: _subAccounts
                              .map((sa) => DropdownMenuItem<String>(
                                    value: (sa['ledgerAccountId'] ?? sa['id'])
                                        as String,
                                    child: Text(sa['name']?.toString() ??
                                        sa['id'].toString()),
                                  ))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedSubAccountId = v),
                        ),
                        const SizedBox(height: 12),
                      ],
                      // Existing account type dropdown
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
                            ..._accountTypes.map(
                                (at) => DropdownMenuItem<String>(
                                      value: at['id'] as String,
                                      child: Text(
                                          '${at['name']}${at['isRestricted'] == true ? ' (restricted)' : ''}'),
                                    )),
                          ],
                          onChanged: (v) =>
                              setState(() => _selectedAccountTypeId = v),
                        ),
                      ],
                    ] else ...[
                      // === Inline sub-account creation ===
                      TextFormField(
                        controller: _subAccountNameController,
                        decoration: const InputDecoration(
                          labelText: 'Sub-Account Name',
                          hintText: 'Auto-filled from campaign title',
                          isDense: true,
                        ),
                        onChanged: (_) {
                          _subAccountNameManuallyEdited = true;
                        },
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Sub-account name is required'
                            : null,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Balance: 0 tokens — fund via Client Management after creation',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Restrictions toggle
                      SwitchListTile(
                        value: _configureRestrictions,
                        onChanged: (v) =>
                            setState(() => _configureRestrictions = v),
                        title: const Text(
                          'Configure account restrictions',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        subtitle: Text(
                          _configureRestrictions
                              ? 'Set spending and transfer rules for user wallets'
                              : 'Default: unrestricted — users can spend, transfer, cashout freely',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      if (_configureRestrictions) ...[
                        const Divider(height: 24),
                        // Allowed offramps
                        _OfframpChipEditor(
                          offramps: _allowedOfframps,
                          onChanged: (list) =>
                              setState(() => _allowedOfframps = list),
                        ),
                        const SizedBox(height: 8),
                        SwitchListTile(
                          value: _allowP2pSend,
                          onChanged: (v) =>
                              setState(() => _allowP2pSend = v),
                          title: const Text('Allow P2P Send',
                              style: TextStyle(fontSize: 13)),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        SwitchListTile(
                          value: _allowP2pReceive,
                          onChanged: (v) =>
                              setState(() => _allowP2pReceive = v),
                          title: const Text('Allow P2P Receive',
                              style: TextStyle(fontSize: 13)),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        SwitchListTile(
                          value: _allowCashout,
                          onChanged: (v) =>
                              setState(() => _allowCashout = v),
                          title: const Text('Allow Cashout',
                              style: TextStyle(fontSize: 13)),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _expiryDaysController,
                          decoration: const InputDecoration(
                            labelText: 'Expiry Days (optional)',
                            hintText: 'Leave empty for no expiry',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
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
    final srcSub = t['tokenSourceAccountId']?.toString() ?? t['tokenSourceSubAccountId']?.toString();
    _selectedSubAccountId = srcSub;
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
    if (clientId != null) _loadTokenSourceAccounts(clientId);
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

  Future<void> _loadTokenSourceAccounts(String clientId) async {
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListClientSubAccounts')
          .call({'clientId': clientId});
      final subList = (result.data['subAccounts'] as List?)
              ?.map((s) => Map<String, dynamic>.from(s as Map))
              .toList() ??
          [];

      final clientName = widget.thread['clientName']?.toString() ?? clientId;

      // Build unified list: client main account + sub-accounts
      final accounts = <Map<String, dynamic>>[
        {
          'ledgerAccountId': 'client:$clientId',
          'name': '$clientName (Main Account)',
        },
        ...subList,
      ];

      if (mounted) {
        setState(() {
          _subAccounts = accounts;
          // If existing selection isn't in the list, keep main account
          if (_selectedSubAccountId != null &&
              !accounts.any((sa) =>
                  (sa['ledgerAccountId'] ?? sa['id']) == _selectedSubAccountId)) {
            _selectedSubAccountId = 'client:$clientId';
          }
        });
      }
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
        allowedExtensions: adminImageExtensions,
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
    return uploadAdminImage(
      bytes: _pickedImageBytes!,
      fileName: _pickedImageName,
      storagePath: 'thread_images',
      fileId: threadId,
      resizeTarget: ImageResizeTarget.threadImage,
      onProgress: (p) {
        if (mounted) setState(() => _uploadProgress = p);
      },
    );
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
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
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
        'tokenSourceAccountId':
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
            backgroundColor: AppColors.adminCard,
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
      backgroundColor: AppColors.adminCard,
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
                              color: AppColors.adminSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedImageBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: svgAwareMemoryImage(
                                      _pickedImageBytes!,
                                      fileName: _pickedImageName,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _existingImageUrl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7),
                                        child: svgAwareNetworkImage(
                                          _existingImageUrl!,
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
                            labelText: 'Token Source Account',
                            isDense: true,
                          ),
                          items: _subAccounts.map((sa) => DropdownMenuItem<String>(
                                value: (sa['ledgerAccountId'] ?? sa['id']) as String,
                                child: Text(sa['name']?.toString() ?? sa['id'].toString()),
                              )).toList(),
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
  bool _isActive = false;
  bool _isPinned = false;
  bool _isFeatured = false;
  bool _isLoading = false;
  final List<Map<String, dynamic>> _questions = [];

  // Balance check state
  int? _tokenSourceBalance;
  bool _loadingBalance = false;

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

  // Poll-specific fields (used when earningType == 'poll')
  String _pollQuestionType = 'multipleChoice'; // 'multipleChoice', 'ranking', 'text', 'scale'
  final List<TextEditingController> _pollOptionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  // Media for each poll option: index → {bytes, type ('image'/'video'), name}
  final Map<int, Map<String, dynamic>> _pollOptionMedia = {};
  bool _pollIsAnonymous = false;
  bool _pollAllowChange = true;
  bool _pollAllowMultiSelect = false;
  final _pollMaxSelectionsController = TextEditingController();
  DateTime? _pollClosesAt;
  final _pollMinResponsesController = TextEditingController();
  String _pollResultVisibility = 'immediate'; // 'immediate', 'afterClose', 'afterThreshold'
  bool _pollAllowOtherOption = false;
  // Scale question config
  final _pollScaleMinController = TextEditingController(text: '1');
  final _pollScaleMaxController = TextEditingController(text: '10');
  final _pollScaleMinLabelController = TextEditingController();
  final _pollScaleMaxLabelController = TextEditingController();
  // Text question config
  final _pollTextMinLenController = TextEditingController(text: '1');
  final _pollTextMaxLenController = TextEditingController(text: '500');

  // Reward campaign linkage
  String? _rewardCampaignId;
  List<Map<String, dynamic>> _rewardCampaigns = [];
  bool _loadingRewardCampaigns = false;

  // Token source override (Q1: opportunity-level token source)
  String? _tokenSourceAccountId;
  List<Map<String, dynamic>> _clientSubAccounts = [];
  bool _loadingClientSubAccounts = false;

  // Reward quantity (Q2: how many reward items per engagement)
  final _rewardQuantityController = TextEditingController(text: '1');

  // Upload-specific fields (used when earningType == 'upload')
  final _uploadPromptController = TextEditingController();
  bool _uploadVideoEnabled = false;
  bool _uploadImageEnabled = false;
  bool _uploadTextEnabled = false;
  bool _uploadVideoRequired = false;
  bool _uploadImageRequired = false;
  bool _uploadTextRequired = false;
  int _uploadVideoMaxSeconds = 60;
  final _uploadTextMinCharsController = TextEditingController(text: '10');
  final _uploadTextMaxCharsController = TextEditingController(text: '1500');
  bool _requiresAdminReview = false;

  @override
  void initState() {
    super.initState();
    _loadRewardCampaigns();
    _loadClientSubAccounts();
    _checkTokenSourceBalance();
  }

  Future<void> _checkTokenSourceBalance() async {
    setState(() => _loadingBalance = true);
    try {
      final threadDoc = await FirebaseFirestore.instance
          .collection('earnThreads')
          .doc(widget.threadId)
          .get();
      if (!threadDoc.exists || !mounted) return;
      final threadData = threadDoc.data()!;
      final accountId = threadData['tokenSourceAccountId'] as String? ??
          'client:${threadData['clientId']}';
      final ledgerDoc = await FirebaseFirestore.instance
          .collection('ledgerAccounts')
          .doc(accountId)
          .get();
      if (mounted) {
        setState(() {
          _tokenSourceBalance =
              (ledgerDoc.data()?['balance'] as num?)?.toInt() ?? 0;
        });
      }
    } catch (_) {
      // If we can't check, leave as null (unknown)
    } finally {
      if (mounted) setState(() => _loadingBalance = false);
    }
  }

  void _onActiveToggled(bool value) {
    if (value) {
      if (_loadingBalance) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Checking account balance...'),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }
      if (_tokenSourceBalance != null && _tokenSourceBalance! <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cannot activate: the campaign\'s token source account has a zero balance',
            ),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }
    setState(() => _isActive = value);
  }

  Future<void> _loadRewardCampaigns() async {
    setState(() => _loadingRewardCampaigns = true);
    try {
      // Get thread to find clientId
      final threadDoc = await FirebaseFirestore.instance
          .collection('earnThreads')
          .doc(widget.threadId)
          .get();
      if (!threadDoc.exists) return;
      final clientId = threadDoc.data()?['clientId'] as String?;
      if (clientId == null) return;

      // Query reward campaigns for this client
      final snapshot = await FirebaseFirestore.instance
          .collection('rewardCampaigns')
          .where('clientId', isEqualTo: clientId)
          .where('isDeleted', isEqualTo: false)
          .get();

      if (mounted) {
        setState(() {
          _rewardCampaigns = snapshot.docs
              .map((d) => {'id': d.id, ...d.data()})
              .where((c) =>
                  c['status'] == 'draft' ||
                  c['status'] == 'active')
              .toList();
        });
      }
    } catch (e) {
      // Silently fail — reward campaigns are optional
    } finally {
      if (mounted) setState(() => _loadingRewardCampaigns = false);
    }
  }

  Future<void> _loadClientSubAccounts() async {
    setState(() => _loadingClientSubAccounts = true);
    try {
      final threadDoc = await FirebaseFirestore.instance
          .collection('earnThreads')
          .doc(widget.threadId)
          .get();
      if (!threadDoc.exists || !mounted) return;
      final clientId = threadDoc.data()?['clientId'] as String?;
      if (clientId == null) return;

      final accountDoc = await FirebaseFirestore.instance
          .collection('ledgerAccounts')
          .doc('client:$clientId')
          .get();
      if (!accountDoc.exists || !mounted) return;

      final subAccountsSnap = await accountDoc.reference
          .collection('subAccounts')
          .where('isActive', isEqualTo: true)
          .get();

      if (mounted) {
        setState(() {
          _clientSubAccounts = subAccountsSnap.docs
              .map((d) => {'id': d.id, ...d.data()})
              .toList();
        });
      }
    } catch (_) {}
    finally {
      if (mounted) setState(() => _loadingClientSubAccounts = false);
    }
  }

  int get _uploadEnabledCount =>
      [_uploadVideoEnabled, _uploadImageEnabled, _uploadTextEnabled]
          .where((e) => e)
          .length;

  final _earningTypes = [
    ('video', 'Video'),
    ('image', 'Image'),
    ('survey', 'Survey'),
    ('poll', 'Poll'),
    ('adVideo', 'Ad Video (AdMob)'),
    ('upload', 'Upload'),
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
    _rewardQuantityController.dispose();
    _uploadPromptController.dispose();
    _uploadTextMinCharsController.dispose();
    _uploadTextMaxCharsController.dispose();
    _pollScaleMinController.dispose();
    _pollScaleMaxController.dispose();
    _pollScaleMinLabelController.dispose();
    _pollScaleMaxLabelController.dispose();
    _pollTextMinLenController.dispose();
    _pollTextMaxLenController.dispose();
    for (final c in _pollOptionControllers) {
      c.dispose();
    }
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
        allowedExtensions: adminImageExtensions,
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

  /// Pick an image or video for a poll option
  Future<void> _pickPollOptionMedia(int optionIndex) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [...adminImageExtensions, 'mp4', 'mov', 'webm'],
        withData: true,
      );
      if (result == null || result.files.single.bytes == null) return;
      final file = result.files.single;
      final ext = file.extension?.toLowerCase() ?? '';
      final isVideo = ['mp4', 'mov', 'webm'].contains(ext);

      // Enforce 50 MB limit for video
      if (isVideo && file.size > 50 * 1024 * 1024) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Video must be under 50 MB'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }

      setState(() {
        _pollOptionMedia[optionIndex] = {
          'bytes': file.bytes,
          'name': file.name,
          'type': isVideo ? 'video' : 'image',
          'ext': ext,
        };
      });
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

  /// Upload poll option media to Firebase Storage and return download URL
  Future<String?> _uploadPollOptionMedia({
    required String pollId,
    required String optionId,
    required Uint8List bytes,
    required String ext,
    required String mediaType,
  }) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('poll_media')
        .child(pollId)
        .child('$optionId.$ext');

    final contentType = mediaType == 'video' ? 'video/$ext' : 'image/$ext';
    final uploadTask = ref.putData(bytes, SettableMetadata(contentType: contentType));
    final snapshot = await uploadTask;
    return snapshot.ref.getDownloadURL();
  }

  Future<String?> _uploadOpportunityImage(String opportunityId) async {
    if (_pickedImageBytes == null) return null;
    return uploadAdminImage(
      bytes: _pickedImageBytes!,
      fileName: _pickedImageName,
      storagePath: 'opportunity_images/${widget.threadId}',
      fileId: opportunityId,
      resizeTarget: ImageResizeTarget.opportunityImage,
      onProgress: (p) {
        if (mounted) setState(() => _imageUploadProgress = p);
      },
    );
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

    // Validate upload: at least one upload type must be enabled
    if (_earningType == 'upload' && _uploadEnabledCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enable at least one upload type (Video, Image, or Text)'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Validate upload prompt
    if (_earningType == 'upload' &&
        _uploadPromptController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a prompt/question for the upload'),
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
      if (_earningType == 'poll') {
        await _handleCreatePoll();
      } else {
        await _handleCreateOpportunity();
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

  Future<void> _handleCreatePoll() async {
    // Validate poll options (text questions don't need options)
    final pollOptions = _pollOptionControllers
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();
    if (_pollQuestionType != 'text' && pollOptions.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least 2 poll options are required'),
          backgroundColor: AppColors.error,
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    // Validate scale config
    if (_pollQuestionType == 'scale') {
      final sMin = int.tryParse(_pollScaleMinController.text.trim());
      final sMax = int.tryParse(_pollScaleMaxController.text.trim());
      if (sMin == null || sMax == null || sMin >= sMax || sMin < 1 || sMax > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Scale min must be < max, both between 1 and 10'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }
    }

    // Validate text config
    if (_pollQuestionType == 'text') {
      final tMin = int.tryParse(_pollTextMinLenController.text.trim()) ?? 1;
      final tMax = int.tryParse(_pollTextMaxLenController.text.trim()) ?? 500;
      if (tMin < 1 || tMax < tMin || tMax > 5000) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Text min must be ≥ 1 and max must be ≥ min (up to 5000)'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }
    }

    // Validate afterThreshold requires minResponses
    if (_pollResultVisibility == 'afterThreshold') {
      final minResp = int.tryParse(_pollMinResponsesController.text.trim());
      if (minResp == null || minResp < 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Minimum responses is required for "after threshold" visibility'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }
    }

    // Upload opportunity image if picked
    String? opportunityImageUrl;
    if (_pickedImageBytes != null) {
      setState(() => _isImageUploading = true);
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      opportunityImageUrl = await _uploadOpportunityImage(tempId);
      if (mounted) setState(() => _isImageUploading = false);
    }

    // Build options list with text (media URLs added after poll creation)
    final optionsList = <Map<String, dynamic>>[];
    for (int i = 0; i < _pollOptionControllers.length; i++) {
      final text = _pollOptionControllers[i].text.trim();
      if (text.isEmpty) continue;
      optionsList.add({'text': text});
    }

    // Convert closesAt from SAST (local) to UTC ISO string
    String? closesAtUtc;
    if (_pollClosesAt != null) {
      // _pollClosesAt is in SAST (UTC+2), convert to UTC
      final utc = _pollClosesAt!.subtract(const Duration(hours: 2));
      closesAtUtc = utc.toUtc().toIso8601String();
    }

    // Call createPoll Cloud Function
    final callable = FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('createPoll');
    final result = await callable.call(<String, dynamic>{
      'threadId': widget.threadId,
      'question': _titleController.text.trim(),
      'questionType': _pollQuestionType,
      if (_pollQuestionType != 'text') 'options': optionsList,
      'isAnonymous': _pollIsAnonymous,
      'allowChangeVote': _pollAllowChange,
      if (_pollQuestionType == 'multipleChoice') ...{
        'allowMultipleSelections': _pollAllowMultiSelect,
        if (_pollAllowMultiSelect && _pollMaxSelectionsController.text.trim().isNotEmpty)
          'maxSelections': int.tryParse(_pollMaxSelectionsController.text.trim()),
        'allowOtherOption': _pollAllowOtherOption,
      },
      if (_pollQuestionType == 'scale') ...{
        'scaleMin': int.tryParse(_pollScaleMinController.text.trim()) ?? 1,
        'scaleMax': int.tryParse(_pollScaleMaxController.text.trim()) ?? 10,
        if (_pollScaleMinLabelController.text.trim().isNotEmpty)
          'scaleMinLabel': _pollScaleMinLabelController.text.trim(),
        if (_pollScaleMaxLabelController.text.trim().isNotEmpty)
          'scaleMaxLabel': _pollScaleMaxLabelController.text.trim(),
      },
      if (_pollQuestionType == 'text') ...{
        'textMinLength': int.tryParse(_pollTextMinLenController.text.trim()) ?? 1,
        'textMaxLength': int.tryParse(_pollTextMaxLenController.text.trim()) ?? 500,
      },
      if (closesAtUtc != null) 'closesAt': closesAtUtc,
      if (_pollResultVisibility == 'afterThreshold')
        'minResponsesForResults': int.tryParse(_pollMinResponsesController.text.trim()),
      'resultVisibility': _pollResultVisibility,
      'tokenReward': int.tryParse(_tokenRewardController.text) ?? 10,
      'durationSeconds': int.tryParse(_durationController.text) ?? 15,
      if (_targeting != null) 'targeting': _targeting,
      if (_tokenBudgetController.text.trim().isNotEmpty)
        'tokenBudget': int.tryParse(_tokenBudgetController.text.trim()),
      if (_dailyLimitController.text.trim().isNotEmpty)
        'dailyLimitPerUser': int.tryParse(_dailyLimitController.text.trim()),
      if (opportunityImageUrl != null) 'opportunityImage': opportunityImageUrl,
    });

    // Upload poll option media (if any) now that we have the pollId
    final pollId = result.data['pollId'] as String?;
    if (pollId != null && _pollOptionMedia.isNotEmpty) {
      for (final entry in _pollOptionMedia.entries) {
        final idx = entry.key;
        final media = entry.value;
        // Only upload if the option index is within the valid options
        if (idx >= optionsList.length) continue;
        final optionId = 'opt_$idx';
        try {
          final url = await _uploadPollOptionMedia(
            pollId: pollId,
            optionId: optionId,
            bytes: media['bytes'] as Uint8List,
            ext: media['ext'] as String,
            mediaType: media['type'] as String,
          );
          if (url != null) {
            // Update the poll option with the media URL
            final pollRef = FirebaseFirestore.instance.collection('polls').doc(pollId);
            final pollDoc = await pollRef.get();
            if (pollDoc.exists) {
              final options = List<Map<String, dynamic>>.from(
                (pollDoc.data()!['options'] as List).map((e) => Map<String, dynamic>.from(e as Map)),
              );
              final optIdx = options.indexWhere((o) => o['id'] == optionId);
              if (optIdx >= 0) {
                options[optIdx]['mediaUrl'] = url;
                options[optIdx]['mediaType'] = media['type'];
                await pollRef.update({'options': options});
              }
            }
          }
        } catch (e) {
          // Non-fatal — poll is created, media just failed
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Warning: Failed to upload media for option ${idx + 1}'),
                backgroundColor: AppColors.warning,
              ),
            );
          }
        }
      }
    }

    if (mounted) {
      Navigator.of(context).pop();
      widget.onCreated();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Poll created in draft status. Open it to activate.'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _handleCreateOpportunity() async {
    // Get thread data for denormalization
    final threadDoc = await FirebaseFirestore.instance
        .collection('earnThreads')
        .doc(widget.threadId)
        .get();
    final threadData = threadDoc.data()!;

    // Re-check balance at save time if activating
    if (_isActive) {
      final accountId = threadData['tokenSourceAccountId'] as String? ??
          'client:${threadData['clientId']}';
      final ledgerDoc = await FirebaseFirestore.instance
          .collection('ledgerAccounts')
          .doc(accountId)
          .get();
      final balance = (ledgerDoc.data()?['balance'] as num?)?.toInt() ?? 0;
      if (balance <= 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Cannot activate: the campaign\'s token source account has a zero balance',
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
    }

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
      'isPinned': _isPinned,
      'isFeatured': _isFeatured,
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
      // Token source override (Q1)
      'tokenSourceAccountId': _tokenSourceAccountId,
      // Reward campaign linkage
      'rewardCampaignId': _rewardCampaignId,
      if (_rewardCampaignId != null) ...{
        'rewardCampaignName': _rewardCampaigns
            .firstWhere((c) => c['id'] == _rewardCampaignId,
                orElse: () => {})['name'],
        'rewardType': _rewardCampaigns
            .firstWhere((c) => c['id'] == _rewardCampaignId,
                orElse: () => {})['rewardType'],
        'rewardQuantity': int.tryParse(_rewardQuantityController.text) ?? 1,
      },
      // Upload-specific fields
      if (_earningType == 'upload') ...{
        'uploadPrompt': _uploadPromptController.text.trim(),
        'uploadVideoEnabled': _uploadVideoEnabled,
        'uploadImageEnabled': _uploadImageEnabled,
        'uploadTextEnabled': _uploadTextEnabled,
        'uploadVideoRequired': _uploadVideoRequired ||
            (_uploadEnabledCount == 1 && _uploadVideoEnabled),
        'uploadImageRequired': _uploadImageRequired ||
            (_uploadEnabledCount == 1 && _uploadImageEnabled),
        'uploadTextRequired': _uploadTextRequired ||
            (_uploadEnabledCount == 1 && _uploadTextEnabled),
        'uploadVideoMaxSeconds': _uploadVideoMaxSeconds,
        'uploadTextMinChars':
            int.tryParse(_uploadTextMinCharsController.text) ?? 10,
        'uploadTextMaxChars':
            int.tryParse(_uploadTextMaxCharsController.text) ?? 1500,
        'requiresAdminReview': _requiresAdminReview,
      },
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
  }

  Future<void> _showQuestionEditor({int? index, Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => _QuestionEditorDialog(existing: existing, allQuestions: _questions),
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
      backgroundColor: AppColors.adminCard,
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
                  decoration: InputDecoration(
                    labelText: _earningType == 'poll' ? 'Poll Question' : 'Title',
                    hintText: _earningType == 'poll'
                        ? 'e.g., Which feature do you want next?'
                        : 'e.g., Watch our new ad',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? (_earningType == 'poll' ? 'Poll question is required' : 'Title is required')
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
                              color: AppColors.adminSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedImageBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: svgAwareMemoryImage(
                                      _pickedImageBytes!,
                                      fileName: _pickedImageName,
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
                // Reward Campaign Linkage (optional)
                if (_loadingRewardCampaigns)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LinearProgressIndicator(),
                  )
                else if (_rewardCampaigns.isNotEmpty) ...[
                  DropdownButtonFormField<String?>(
                    initialValue: _rewardCampaignId,
                    decoration: const InputDecoration(
                      labelText: 'Reward Campaign (optional)',
                      hintText: 'Link an inventory reward',
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('None'),
                      ),
                      ..._rewardCampaigns.map((c) => DropdownMenuItem<String?>(
                            value: c['id'] as String,
                            child: Text(
                              '${c['name']} (${c['remainingQuantity']}/${c['totalQuantity']} left)',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) => setState(() => _rewardCampaignId = v),
                  ),
                  const SizedBox(height: 16),
                  // Reward quantity (visible when reward campaign is linked)
                  if (_rewardCampaignId != null) ...[
                    TextFormField(
                      controller: _rewardQuantityController,
                      decoration: const InputDecoration(
                        labelText: 'Reward Quantity per Completion',
                        hintText: 'Items allocated per engagement',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return null;
                        final n = int.tryParse(value.trim());
                        if (n == null || n < 1) return 'Must be at least 1';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ]
                else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.adminSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderDark),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.card_giftcard_outlined, size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'No reward campaigns found for this client. Create one in the Reward Campaigns section first.',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                // Token source override (optional — defaults to thread's token source)
                if (_loadingClientSubAccounts)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LinearProgressIndicator(),
                  )
                else if (_clientSubAccounts.isNotEmpty) ...[
                  DropdownButtonFormField<String?>(
                    initialValue: _tokenSourceAccountId,
                    decoration: const InputDecoration(
                      labelText: 'Token Source Override (optional)',
                      hintText: 'Defaults to campaign token source',
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Use campaign default'),
                      ),
                      ..._clientSubAccounts.map((sa) => DropdownMenuItem<String?>(
                            value: sa['id'] as String,
                            child: Text(
                              '${sa['name'] ?? sa['id']} (bal: ${sa['balance'] ?? 0})',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) => setState(() => _tokenSourceAccountId = v),
                  ),
                  const SizedBox(height: 16),
                ],
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
                // Upload config fields (shown for upload type)
                if (_earningType == 'upload') ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Upload Configuration',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _uploadPromptController,
                          decoration: const InputDecoration(
                            labelText: 'Prompt / Question *',
                            hintText:
                                'What question should the user respond to?',
                          ),
                          maxLines: 3,
                          validator: (v) => _earningType == 'upload' &&
                                  (v == null || v.trim().isEmpty)
                              ? 'Prompt is required for upload type'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        const Text('Allowed response types:',
                            style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 8),
                        CheckboxListTile(
                          title: const Text('Video Recording'),
                          value: _uploadVideoEnabled,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) =>
                              setState(() => _uploadVideoEnabled = v ?? false),
                        ),
                        if (_uploadVideoEnabled) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: DropdownButtonFormField<int>(
                              initialValue: _uploadVideoMaxSeconds,
                              decoration: const InputDecoration(
                                labelText: 'Max Video Duration',
                                isDense: true,
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 30, child: Text('30 seconds')),
                                DropdownMenuItem(
                                    value: 60, child: Text('60 seconds')),
                                DropdownMenuItem(
                                    value: 120, child: Text('120 seconds')),
                              ],
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _uploadVideoMaxSeconds = v);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        CheckboxListTile(
                          title: const Text('Image Capture'),
                          value: _uploadImageEnabled,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) =>
                              setState(() => _uploadImageEnabled = v ?? false),
                        ),
                        CheckboxListTile(
                          title: const Text('Text Response'),
                          value: _uploadTextEnabled,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) =>
                              setState(() => _uploadTextEnabled = v ?? false),
                        ),
                        if (_uploadTextEnabled) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _uploadTextMinCharsController,
                                    decoration: const InputDecoration(
                                      labelText: 'Min chars',
                                      isDense: true,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _uploadTextMaxCharsController,
                                    decoration: const InputDecoration(
                                      labelText: 'Max chars',
                                      isDense: true,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        // Required toggles (shown when 2+ types enabled)
                        if (_uploadEnabledCount >= 2) ...[
                          const Divider(),
                          const Text('Required fields:',
                              style: TextStyle(fontSize: 13)),
                          if (_uploadVideoEnabled)
                            CheckboxListTile(
                              title: const Text('Video required'),
                              value: _uploadVideoRequired,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) => setState(
                                  () => _uploadVideoRequired = v ?? false),
                            ),
                          if (_uploadImageEnabled)
                            CheckboxListTile(
                              title: const Text('Image required'),
                              value: _uploadImageRequired,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) => setState(
                                  () => _uploadImageRequired = v ?? false),
                            ),
                          if (_uploadTextEnabled)
                            CheckboxListTile(
                              title: const Text('Text required'),
                              value: _uploadTextRequired,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) => setState(
                                  () => _uploadTextRequired = v ?? false),
                            ),
                        ],
                        const Divider(),
                        CheckboxListTile(
                          title: const Text('Require Admin Review'),
                          subtitle:
                              const Text('Tokens held until admin approves'),
                          value: _requiresAdminReview,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) => setState(
                              () => _requiresAdminReview = v ?? false),
                        ),
                      ],
                    ),
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
                // Poll-specific section or Questions section
                if (_earningType == 'poll') ...[
                  // Question type selector
                  const Text(
                    'Question Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _pollQuestionType,
                    decoration: const InputDecoration(
                      labelText: 'Question type',
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'multipleChoice',
                        child: Text('Multiple Choice', style: TextStyle(fontSize: 13)),
                      ),
                      DropdownMenuItem(
                        value: 'ranking',
                        child: Text('Ranking (drag to reorder)', style: TextStyle(fontSize: 13)),
                      ),
                      DropdownMenuItem(
                        value: 'text',
                        child: Text('Open Text (free response)', style: TextStyle(fontSize: 13)),
                      ),
                      DropdownMenuItem(
                        value: 'scale',
                        child: Text('Rating Scale (1-10, Likert, etc.)', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                    onChanged: (v) => setState(() {
                      _pollQuestionType = v ?? 'multipleChoice';
                      // Reset type-specific flags when switching
                      if (_pollQuestionType != 'multipleChoice') {
                        _pollAllowMultiSelect = false;
                        _pollAllowOtherOption = false;
                      }
                    }),
                  ),
                  const SizedBox(height: 16),

                  // Poll Options (not shown for text questions)
                  if (_pollQuestionType != 'text') ...[
                  const Text(
                    'Poll Options',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _pollQuestionType == 'ranking'
                        ? 'Add the options users will rank from best to worst.'
                        : _pollQuestionType == 'scale'
                            ? 'Add the items users will rate on a scale.'
                            : 'Add 2-6 answer options for the poll question above.',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(_pollOptionControllers.length, (i) {
                    final hasMedia = _pollOptionMedia.containsKey(i);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _pollOptionControllers[i],
                                  decoration: InputDecoration(
                                    labelText: 'Option ${i + 1}',
                                    isDense: true,
                                  ),
                                ),
                              ),
                              // Media picker button
                              IconButton(
                                icon: Icon(
                                  hasMedia ? Icons.image : Icons.add_photo_alternate_outlined,
                                  size: 18,
                                  color: hasMedia ? AppColors.primary : AppColors.textSecondary,
                                ),
                                tooltip: hasMedia ? 'Change media' : 'Add image/video',
                                onPressed: () => _pickPollOptionMedia(i),
                              ),
                              if (_pollOptionControllers.length > 2)
                                IconButton(
                                  icon: const Icon(Icons.close, size: 16),
                                  color: AppColors.error,
                                  onPressed: () {
                                    if (_pollOptionControllers.length <= 2) return;
                                    setState(() {
                                      _pollOptionControllers.removeAt(i).dispose();
                                      // Shift media indices
                                      final newMedia = <int, Map<String, dynamic>>{};
                                      for (final entry in _pollOptionMedia.entries) {
                                        if (entry.key < i) {
                                          newMedia[entry.key] = entry.value;
                                        } else if (entry.key > i) {
                                          newMedia[entry.key - 1] = entry.value;
                                        }
                                      }
                                      _pollOptionMedia
                                        ..clear()
                                        ..addAll(newMedia);
                                    });
                                  },
                                ),
                            ],
                          ),
                          if (hasMedia)
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    _pollOptionMedia[i]!['type'] == 'video'
                                        ? Icons.videocam
                                        : Icons.image,
                                    size: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      _pollOptionMedia[i]!['name'] as String? ?? 'Media attached',
                                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.clear, size: 14),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => setState(() => _pollOptionMedia.remove(i)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                  if (_pollOptionControllers.length < 20)
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add option'),
                      onPressed: () => setState(() =>
                          _pollOptionControllers.add(TextEditingController())),
                    ),
                  ], // end if (_pollQuestionType != 'text')

                  // Scale configuration (only for scale type)
                  if (_pollQuestionType == 'scale') ...[
                    const SizedBox(height: 12),
                    const Text(
                      'Scale Configuration',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pollScaleMinController,
                            decoration: const InputDecoration(
                              labelText: 'Min value',
                              hintText: '1',
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _pollScaleMaxController,
                            decoration: const InputDecoration(
                              labelText: 'Max value',
                              hintText: '10',
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _pollScaleMinLabelController,
                      decoration: const InputDecoration(
                        labelText: 'Min label (optional)',
                        hintText: 'e.g., Extremely unlikely',
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _pollScaleMaxLabelController,
                      decoration: const InputDecoration(
                        labelText: 'Max label (optional)',
                        hintText: 'e.g., Extremely likely',
                        isDense: true,
                      ),
                    ),
                  ],

                  // Text configuration (only for text type)
                  if (_pollQuestionType == 'text') ...[
                    const SizedBox(height: 12),
                    const Text(
                      'Text Response Configuration',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Users will type a free-text answer. No options needed.',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pollTextMinLenController,
                            decoration: const InputDecoration(
                              labelText: 'Min characters',
                              hintText: '1',
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _pollTextMaxLenController,
                            decoration: const InputDecoration(
                              labelText: 'Max characters',
                              hintText: '500',
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 12),
                  // Poll configuration section
                  const Text(
                    'Poll Configuration',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    value: _pollIsAnonymous,
                    onChanged: (v) => setState(() => _pollIsAnonymous = v),
                    title: const Text('Anonymous voting',
                        style: TextStyle(fontSize: 13)),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SwitchListTile(
                    value: _pollAllowChange,
                    onChanged: (v) => setState(() => _pollAllowChange = v),
                    title: const Text('Allow vote change',
                        style: TextStyle(fontSize: 13)),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  // Multi-select & "Other" only for multipleChoice
                  if (_pollQuestionType == 'multipleChoice') ...[
                    SwitchListTile(
                      value: _pollAllowMultiSelect,
                      onChanged: (v) => setState(() => _pollAllowMultiSelect = v),
                      title: const Text('Allow multiple selections',
                          style: TextStyle(fontSize: 13)),
                      subtitle: const Text('Users can pick more than one option',
                          style: TextStyle(fontSize: 11)),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    if (_pollAllowMultiSelect)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: TextField(
                          controller: _pollMaxSelectionsController,
                          decoration: const InputDecoration(
                            labelText: 'Max selections (optional)',
                            hintText: 'Leave empty for unlimited',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    SwitchListTile(
                      value: _pollAllowOtherOption,
                      onChanged: (v) => setState(() => _pollAllowOtherOption = v),
                      title: const Text('Allow "Other" free-text option',
                          style: TextStyle(fontSize: 13)),
                      subtitle: const Text('Adds an "Other" option with a 200-char text field',
                          style: TextStyle(fontSize: 11)),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ],
                  const SizedBox(height: 12),
                  // Result visibility dropdown
                  DropdownButtonFormField<String>(
                    value: _pollResultVisibility,
                    decoration: const InputDecoration(
                      labelText: 'Result visibility',
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'immediate',
                        child: Text('Immediately after voting', style: TextStyle(fontSize: 13)),
                      ),
                      DropdownMenuItem(
                        value: 'afterClose',
                        child: Text('Only after poll closes', style: TextStyle(fontSize: 13)),
                      ),
                      DropdownMenuItem(
                        value: 'afterThreshold',
                        child: Text('After minimum responses met', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                    onChanged: (v) => setState(() => _pollResultVisibility = v ?? 'immediate'),
                  ),
                  if (_pollResultVisibility == 'afterThreshold')
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextField(
                        controller: _pollMinResponsesController,
                        decoration: const InputDecoration(
                          labelText: 'Minimum responses required',
                          hintText: 'e.g., 50',
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  const SizedBox(height: 12),
                  // Poll deadline / closesAt
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text('Auto-close deadline (optional)',
                        style: TextStyle(fontSize: 13)),
                    subtitle: Text(
                      _pollClosesAt != null
                          ? '${_pollClosesAt!.day}/${_pollClosesAt!.month}/${_pollClosesAt!.year} '
                            '${_pollClosesAt!.hour.toString().padLeft(2, '0')}:'
                            '${_pollClosesAt!.minute.toString().padLeft(2, '0')} SAST'
                          : 'No deadline set',
                      style: const TextStyle(fontSize: 11),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today, size: 18),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _pollClosesAt ?? DateTime.now().add(const Duration(days: 1)),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date == null || !mounted) return;
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                _pollClosesAt ?? DateTime.now().add(const Duration(hours: 1)),
                              ),
                            );
                            if (time == null || !mounted) return;
                            setState(() {
                              // Store as SAST (UTC+2) — will convert to UTC when sending
                              _pollClosesAt = DateTime(
                                date.year, date.month, date.day,
                                time.hour, time.minute,
                              );
                            });
                          },
                        ),
                        if (_pollClosesAt != null)
                          IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () => setState(() => _pollClosesAt = null),
                          ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Survey questions section
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
                  if (_questions.isNotEmpty)
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      buildDefaultDragHandles: false,
                      itemCount: _questions.length,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) newIndex--;
                          final item = _questions.removeAt(oldIndex);
                          _questions.insert(newIndex, item);
                          for (var i = 0; i < _questions.length; i++) {
                            _questions[i]['orderIndex'] = i;
                          }
                        });
                      },
                      itemBuilder: (context, idx) {
                        final q = _questions[idx];
                        final qType = q['questionType'] ?? 'single_select';
                        final options =
                            (q['options'] as List?)?.cast<String>() ?? [];
                        return Card(
                          key: ValueKey(q['id'] ?? idx),
                          color: AppColors.adminSurface,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            dense: true,
                            leading: ReorderableDragStartListener(
                              index: idx,
                              child: const Icon(Icons.drag_handle,
                                  size: 20, color: AppColors.textSecondary),
                            ),
                            title: Text(
                              q['text'] ?? '',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textPrimaryDark,
                              ),
                            ),
                            subtitle: Text(
                              _questionSubtitle(qType, options, q),
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
                                    setState(
                                        () => _questions.removeAt(idx));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
                const SizedBox(height: 8),
                SwitchListTile(
                  value: _isActive,
                  onChanged: _onActiveToggled,
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: _isPinned,
                  onChanged: (v) => setState(() => _isPinned = v),
                  title: const Text('Pinned'),
                  subtitle: const Text('Pin to top of opportunity list'),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                  title: const Text('Featured'),
                  subtitle: const Text('Highlight as featured opportunity'),
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
  late bool _isPinned;
  late bool _isFeatured;
  DateTime? _expiresAt;
  bool _isLoading = false;

  // Balance check state
  int? _tokenSourceBalance;
  bool _loadingBalance = false;

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

  // Reward campaign linkage
  String? _rewardCampaignId;
  List<Map<String, dynamic>> _rewardCampaigns = [];
  bool _loadingRewardCampaigns = false;

  // Token source override (Q1: opportunity-level token source)
  String? _tokenSourceAccountId;
  List<Map<String, dynamic>> _clientSubAccounts = [];
  bool _loadingClientSubAccounts = false;

  // Reward quantity (Q2)
  late final TextEditingController _rewardQuantityController;

  // Poll-specific state (loaded from polls collection when earningType == 'poll')
  bool _loadingPoll = false;
  Map<String, dynamic>? _pollData;
  List<TextEditingController> _pollOptionControllers = [];
  bool _pollIsAnonymous = false;
  bool _pollAllowChange = true;
  bool _pollAllowMultiSelect = false;
  final _pollMaxSelectionsController = TextEditingController();
  String _pollResultVisibility = 'immediate';
  final _pollMinResponsesController = TextEditingController();
  bool _pollAllowOtherOption = false;
  DateTime? _pollClosesAt;
  String? _pollStatus;

  // Upload-specific fields (used when earningType == 'upload')
  late final TextEditingController _uploadPromptController;
  bool _uploadVideoEnabled = false;
  bool _uploadImageEnabled = false;
  bool _uploadTextEnabled = false;
  bool _uploadVideoRequired = false;
  bool _uploadImageRequired = false;
  bool _uploadTextRequired = false;
  int _uploadVideoMaxSeconds = 60;
  late final TextEditingController _uploadTextMinCharsController;
  late final TextEditingController _uploadTextMaxCharsController;
  bool _requiresAdminReview = false;

  int get _uploadEnabledCount =>
      [_uploadVideoEnabled, _uploadImageEnabled, _uploadTextEnabled]
          .where((e) => e)
          .length;

  final _earningTypes = [
    ('video', 'Video'),
    ('image', 'Image'),
    ('survey', 'Survey'),
    ('poll', 'Poll'),
    ('adVideo', 'Ad Video (AdMob)'),
    ('upload', 'Upload'),
  ];

  @override
  void initState() {
    super.initState();
    final o = widget.opportunity;
    _rewardCampaignId = o['rewardCampaignId'] as String?;
    _tokenSourceAccountId = o['tokenSourceAccountId'] as String?;
    _rewardQuantityController = TextEditingController(
        text: (o['rewardQuantity'] ?? 1).toString());
    _loadRewardCampaigns();
    _loadClientSubAccounts();
    _existingImageUrl = o['opportunityImage'] as String?;
    _titleController = TextEditingController(text: o['title']?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: o['description']?.toString() ?? '');
    _tokenRewardController =
        TextEditingController(text: (o['tokenReward'] ?? 10).toString());
    _durationController =
        TextEditingController(text: (o['durationSeconds'] ?? 30).toString());
    _isActive = o['isActive'] == true;
    _isPinned = o['isPinned'] == true;
    _isFeatured = o['isFeatured'] == true;

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

    // Init upload-specific fields from existing data
    _uploadPromptController =
        TextEditingController(text: o['uploadPrompt']?.toString() ?? '');
    _uploadVideoEnabled = o['uploadVideoEnabled'] == true;
    _uploadImageEnabled = o['uploadImageEnabled'] == true;
    _uploadTextEnabled = o['uploadTextEnabled'] == true;
    _uploadVideoRequired = o['uploadVideoRequired'] == true;
    _uploadImageRequired = o['uploadImageRequired'] == true;
    _uploadTextRequired = o['uploadTextRequired'] == true;
    _uploadVideoMaxSeconds = (o['uploadVideoMaxSeconds'] as num?)?.toInt() ?? 60;
    _uploadTextMinCharsController = TextEditingController(
        text: (o['uploadTextMinChars'] ?? 10).toString());
    _uploadTextMaxCharsController = TextEditingController(
        text: (o['uploadTextMaxChars'] ?? 1500).toString());
    _requiresAdminReview = o['requiresAdminReview'] == true;
    _checkTokenSourceBalance();
    if (_earningType == 'poll') _loadPollData();
  }

  Future<void> _loadPollData() async {
    final pollId = widget.opportunity['pollId'] as String?;
    if (pollId == null) return;
    setState(() => _loadingPoll = true);
    try {
      final pollDoc = await FirebaseFirestore.instance
          .collection('polls')
          .doc(pollId)
          .get();
      if (!pollDoc.exists || !mounted) return;
      final data = pollDoc.data()!;
      _pollData = data;
      _pollStatus = data['status'] as String? ?? 'draft';

      // Populate option controllers
      final options = (data['options'] as List?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [];
      _pollOptionControllers = options
          .map((o) => TextEditingController(text: o['text']?.toString() ?? ''))
          .toList();

      // Populate config
      _pollIsAnonymous = data['isAnonymous'] == true;
      _pollAllowChange = data['allowChangeVote'] != false;
      _pollAllowMultiSelect = data['allowMultipleSelections'] == true;
      _pollMaxSelectionsController.text =
          data['maxSelections'] != null ? data['maxSelections'].toString() : '';
      _pollResultVisibility =
          data['resultVisibility']?.toString() ?? 'immediate';
      _pollMinResponsesController.text = data['minResponsesForResults'] != null
          ? data['minResponsesForResults'].toString()
          : '';
      _pollAllowOtherOption = data['allowOtherOption'] == true;

      // Parse closesAt
      final closesAtRaw = data['closesAt'];
      if (closesAtRaw is Timestamp) {
        _pollClosesAt = closesAtRaw.toDate();
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingPoll = false);
    }
  }

  Future<void> _checkTokenSourceBalance() async {
    setState(() => _loadingBalance = true);
    try {
      final threadId = widget.opportunity['threadId'] as String?;
      if (threadId == null) return;
      final threadDoc = await FirebaseFirestore.instance
          .collection('earnThreads')
          .doc(threadId)
          .get();
      if (!threadDoc.exists || !mounted) return;
      final threadData = threadDoc.data()!;
      final accountId = threadData['tokenSourceAccountId'] as String? ??
          'client:${threadData['clientId']}';
      final ledgerDoc = await FirebaseFirestore.instance
          .collection('ledgerAccounts')
          .doc(accountId)
          .get();
      if (mounted) {
        setState(() {
          _tokenSourceBalance =
              (ledgerDoc.data()?['balance'] as num?)?.toInt() ?? 0;
        });
      }
    } catch (_) {
      // If we can't check, leave as null (unknown)
    } finally {
      if (mounted) setState(() => _loadingBalance = false);
    }
  }

  void _onActiveToggled(bool value) {
    if (value) {
      if (_loadingBalance) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Checking account balance...'),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }
      if (_tokenSourceBalance != null && _tokenSourceBalance! <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cannot activate: the campaign\'s token source account has a zero balance',
            ),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }
    setState(() => _isActive = value);
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
    _rewardQuantityController.dispose();
    _uploadPromptController.dispose();
    _uploadTextMinCharsController.dispose();
    _uploadTextMaxCharsController.dispose();
    for (final c in _pollOptionControllers) {
      c.dispose();
    }
    _pollMaxSelectionsController.dispose();
    _pollMinResponsesController.dispose();
    super.dispose();
  }

  Future<void> _loadRewardCampaigns() async {
    setState(() => _loadingRewardCampaigns = true);
    try {
      final clientId = widget.opportunity['clientId'] as String?;
      if (clientId == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('rewardCampaigns')
          .where('clientId', isEqualTo: clientId)
          .where('isDeleted', isEqualTo: false)
          .get();

      if (mounted) {
        setState(() {
          _rewardCampaigns = snapshot.docs
              .map((d) => {'id': d.id, ...d.data()})
              .where((c) =>
                  c['status'] == 'draft' ||
                  c['status'] == 'active')
              .toList();
        });
      }
    } catch (e) {
      // Silently fail — reward campaigns are optional
    } finally {
      if (mounted) setState(() => _loadingRewardCampaigns = false);
    }
  }

  Future<void> _loadClientSubAccounts() async {
    setState(() => _loadingClientSubAccounts = true);
    try {
      final clientId = widget.opportunity['clientId'] as String?;
      if (clientId == null) return;

      final accountDoc = await FirebaseFirestore.instance
          .collection('ledgerAccounts')
          .doc('client:$clientId')
          .get();
      if (!accountDoc.exists || !mounted) return;

      final subAccountsSnap = await accountDoc.reference
          .collection('subAccounts')
          .where('isActive', isEqualTo: true)
          .get();

      if (mounted) {
        setState(() {
          _clientSubAccounts = subAccountsSnap.docs
              .map((d) => {'id': d.id, ...d.data()})
              .toList();
        });
      }
    } catch (_) {}
    finally {
      if (mounted) setState(() => _loadingClientSubAccounts = false);
    }
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: adminImageExtensions,
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
    final threadId = widget.opportunity['threadId'] as String;
    return uploadAdminImage(
      bytes: _pickedImageBytes!,
      fileName: _pickedImageName,
      storagePath: 'opportunity_images/$threadId',
      fileId: opportunityId,
      resizeTarget: ImageResizeTarget.opportunityImage,
      onProgress: (p) {
        if (mounted) setState(() => _imageUploadProgress = p);
      },
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    // Re-check balance at save time if switching from inactive to active
    final wasActive = widget.opportunity['isActive'] == true;
    if (_isActive && !wasActive) {
      try {
        final threadId = widget.opportunity['threadId'] as String?;
        if (threadId != null) {
          final threadDoc = await FirebaseFirestore.instance
              .collection('earnThreads')
              .doc(threadId)
              .get();
          if (threadDoc.exists) {
            final threadData = threadDoc.data()!;
            final accountId =
                threadData['tokenSourceAccountId'] as String? ??
                    'client:${threadData['clientId']}';
            final ledgerDoc = await FirebaseFirestore.instance
                .collection('ledgerAccounts')
                .doc(accountId)
                .get();
            final balance =
                (ledgerDoc.data()?['balance'] as num?)?.toInt() ?? 0;
            if (balance <= 0) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Cannot activate: the campaign\'s token source account has a zero balance',
                    ),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
              return;
            }
          }
        }
      } catch (_) {
        // If balance check fails, allow the save (backend will enforce)
      }
    }

    setState(() => _isLoading = true);
    try {
      final oppId = widget.opportunity['id'] as String;
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
        'isPinned': _isPinned,
        'isFeatured': _isFeatured,
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
        // Token source override (Q1)
        'tokenSourceAccountId': _tokenSourceAccountId,
        // Reward campaign linkage
        'rewardCampaignId': _rewardCampaignId,
        if (_rewardCampaignId != null) ...{
          'rewardCampaignName': _rewardCampaigns
              .firstWhere((c) => c['id'] == _rewardCampaignId,
                  orElse: () => {})['name'],
          'rewardType': _rewardCampaigns
              .firstWhere((c) => c['id'] == _rewardCampaignId,
                  orElse: () => {})['rewardType'],
          'rewardQuantity': int.tryParse(_rewardQuantityController.text) ?? 1,
        },
        if (_rewardCampaignId == null) ...{
          'rewardCampaignName': null,
          'rewardType': null,
          'rewardQuantity': null,
        },
        // Upload-specific fields
        if (_earningType == 'upload') ...{
          'uploadPrompt': _uploadPromptController.text.trim(),
          'uploadVideoEnabled': _uploadVideoEnabled,
          'uploadImageEnabled': _uploadImageEnabled,
          'uploadTextEnabled': _uploadTextEnabled,
          'uploadVideoRequired': _uploadVideoRequired ||
              (_uploadEnabledCount == 1 && _uploadVideoEnabled),
          'uploadImageRequired': _uploadImageRequired ||
              (_uploadEnabledCount == 1 && _uploadImageEnabled),
          'uploadTextRequired': _uploadTextRequired ||
              (_uploadEnabledCount == 1 && _uploadTextEnabled),
          'uploadVideoMaxSeconds': _uploadVideoMaxSeconds,
          'uploadTextMinChars':
              int.tryParse(_uploadTextMinCharsController.text) ?? 10,
          'uploadTextMaxChars':
              int.tryParse(_uploadTextMaxCharsController.text) ?? 1500,
          'requiresAdminReview': _requiresAdminReview,
        },
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update poll data if this is a poll opportunity
      final pollId = widget.opportunity['pollId'] as String?;
      if (_earningType == 'poll' && pollId != null && _pollData != null) {
        final functions = FirebaseFunctions.instanceFor(region: 'africa-south1');

        // Handle poll open/close via dedicated CFs when active status changes
        if (wasActive != nowActive) {
          try {
            if (nowActive && _pollStatus == 'draft') {
              // Open the poll (draft → open) — this also sets isActive on the opportunity
              await functions.httpsCallable('openPoll').call({'pollId': pollId});
            } else if (nowActive && _pollStatus == 'closed') {
              // Reopen a closed poll (closed → open)
              await functions.httpsCallable('reopenPoll').call({'pollId': pollId});
            } else if (!nowActive && _pollStatus == 'open') {
              // Close the poll (open → closed) — this also sets isActive=false
              await functions.httpsCallable('closePoll').call({'pollId': pollId});
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Poll status change failed: $e'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          }
        }

        // Update poll config (only if poll is in draft or open status)
        if (_pollStatus == 'draft' || _pollStatus == 'open') {
          final pollUpdates = <String, dynamic>{
            'pollId': pollId,
            'isAnonymous': _pollIsAnonymous,
            'allowChangeVote': _pollAllowChange,
            'allowMultipleSelections': _pollAllowMultiSelect,
            'maxSelections': _pollAllowMultiSelect &&
                    _pollMaxSelectionsController.text.trim().isNotEmpty
                ? int.tryParse(_pollMaxSelectionsController.text.trim())
                : null,
            'resultVisibility': _pollResultVisibility,
            'allowOtherOption': _pollAllowOtherOption,
          };
          if (_pollResultVisibility == 'afterThreshold') {
            pollUpdates['minResponsesForResults'] =
                int.tryParse(_pollMinResponsesController.text.trim());
          }
          // closesAt: convert SAST to UTC ISO string
          if (_pollClosesAt != null) {
            final utc = _pollClosesAt!.subtract(const Duration(hours: 2));
            pollUpdates['closesAt'] = utc.toUtc().toIso8601String();
          } else {
            pollUpdates['closesAt'] = null;
          }
          // Question & options only in draft
          if (_pollStatus == 'draft') {
            pollUpdates['question'] = _titleController.text.trim();
            final opts = _pollOptionControllers
                .map((c) => c.text.trim())
                .where((t) => t.isNotEmpty)
                .toList();
            if (opts.length >= 2) {
              // Preserve existing media URLs
              final existingOptions = (_pollData!['options'] as List?)
                      ?.map((e) => Map<String, dynamic>.from(e as Map))
                      .toList() ??
                  [];
              pollUpdates['options'] = opts.asMap().entries.map((e) {
                final m = <String, dynamic>{'text': e.value};
                if (e.key < existingOptions.length) {
                  final existing = existingOptions[e.key];
                  if (existing['mediaUrl'] != null) {
                    m['mediaUrl'] = existing['mediaUrl'];
                    m['mediaType'] = existing['mediaType'] ?? 'image';
                  }
                }
                return m;
              }).toList();
            }
          }
          try {
            await functions.httpsCallable('updatePoll').call(pollUpdates);
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Warning: Poll config update failed: $e'),
                  backgroundColor: AppColors.warning,
                ),
              );
            }
          }
        }
      }

      // Update thread opportunity count if active status changed
      // (skip for polls — openPoll/closePoll CFs already handle this)
      final threadId = widget.opportunity['threadId'] as String?;
      if (threadId != null && wasActive != nowActive && _earningType != 'poll') {
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
      backgroundColor: AppColors.adminCard,
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
                              color: AppColors.adminSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.borderDark),
                            ),
                            child: _pickedImageBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: svgAwareMemoryImage(
                                      _pickedImageBytes!,
                                      fileName: _pickedImageName,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _existingImageUrl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7),
                                        child: svgAwareNetworkImage(
                                          _existingImageUrl!,
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
                // Reward Campaign Linkage (optional)
                if (_loadingRewardCampaigns)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LinearProgressIndicator(),
                  )
                else if (_rewardCampaigns.isNotEmpty) ...[
                  DropdownButtonFormField<String?>(
                    initialValue: _rewardCampaignId,
                    decoration: const InputDecoration(
                      labelText: 'Reward Campaign (optional)',
                      hintText: 'Link an inventory reward',
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('None'),
                      ),
                      ..._rewardCampaigns.map((c) => DropdownMenuItem<String?>(
                            value: c['id'] as String,
                            child: Text(
                              '${c['name']} (${c['remainingQuantity']}/${c['totalQuantity']} left)',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) => setState(() => _rewardCampaignId = v),
                  ),
                  const SizedBox(height: 16),
                  // Reward quantity (visible when reward campaign is linked)
                  if (_rewardCampaignId != null) ...[
                    TextFormField(
                      controller: _rewardQuantityController,
                      decoration: const InputDecoration(
                        labelText: 'Reward Quantity per Completion',
                        hintText: 'Items allocated per engagement',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return null;
                        final n = int.tryParse(value.trim());
                        if (n == null || n < 1) return 'Must be at least 1';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ]
                else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.adminSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderDark),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.card_giftcard_outlined, size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'No reward campaigns found for this client. Create one in the Reward Campaigns section first.',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                // Token source override (optional — defaults to thread's token source)
                if (_loadingClientSubAccounts)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LinearProgressIndicator(),
                  )
                else if (_clientSubAccounts.isNotEmpty) ...[
                  DropdownButtonFormField<String?>(
                    initialValue: _tokenSourceAccountId,
                    decoration: const InputDecoration(
                      labelText: 'Token Source Override (optional)',
                      hintText: 'Defaults to campaign token source',
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Use campaign default'),
                      ),
                      ..._clientSubAccounts.map((sa) => DropdownMenuItem<String?>(
                            value: sa['id'] as String,
                            child: Text(
                              '${sa['name'] ?? sa['id']} (bal: ${sa['balance'] ?? 0})',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) => setState(() => _tokenSourceAccountId = v),
                  ),
                  const SizedBox(height: 16),
                ],
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
                // Poll configuration (shown for poll type)
                if (_earningType == 'poll') ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _loadingPoll
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : _pollData == null
                            ? const Text(
                                'Poll data not found',
                                style: TextStyle(color: AppColors.error),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Poll Configuration',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimaryDark,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _pollStatus == 'open'
                                              ? AppColors.success
                                                  .withValues(alpha: 0.15)
                                              : _pollStatus == 'closed'
                                                  ? AppColors.error
                                                      .withValues(alpha: 0.15)
                                                  : AppColors.warning
                                                      .withValues(alpha: 0.15),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          (_pollStatus ?? 'draft')
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _pollStatus == 'open'
                                                ? AppColors.success
                                                : _pollStatus == 'closed'
                                                    ? AppColors.error
                                                    : AppColors.warning,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Response Options',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._pollOptionControllers
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final idx = entry.key;
                                    final ctrl = entry.value;
                                    final isDraft = _pollStatus == 'draft';
                                    final options =
                                        (_pollData!['options'] as List?)
                                                ?.map((e) =>
                                                    Map<String, dynamic>.from(
                                                        e as Map))
                                                .toList() ??
                                            [];
                                    final hasMedia = idx < options.length &&
                                        options[idx]['mediaUrl'] != null;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.secondary
                                                  .withValues(alpha: 0.15),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '${idx + 1}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.secondary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: TextFormField(
                                              controller: ctrl,
                                              enabled: isDraft,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Option ${idx + 1}',
                                                isDense: true,
                                                suffixIcon: hasMedia
                                                    ? const Icon(
                                                        Icons.image,
                                                        size: 16,
                                                        color: AppColors
                                                            .secondary,
                                                      )
                                                    : null,
                                              ),
                                              style: const TextStyle(
                                                  fontSize: 13),
                                            ),
                                          ),
                                          if (isDraft &&
                                              _pollOptionControllers.length >
                                                  2)
                                            IconButton(
                                              icon: const Icon(Icons.close,
                                                  size: 16),
                                              color: AppColors.error,
                                              onPressed: () {
                                                setState(() {
                                                  _pollOptionControllers
                                                      .removeAt(idx);
                                                });
                                              },
                                              tooltip: 'Remove option',
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
                                  if (_pollStatus == 'draft' &&
                                      _pollOptionControllers.length < 6)
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _pollOptionControllers
                                              .add(TextEditingController());
                                        });
                                      },
                                      icon: const Icon(Icons.add, size: 16),
                                      label: const Text('Add Option'),
                                      style: TextButton.styleFrom(
                                        minimumSize: const Size(0, 32),
                                      ),
                                    ),
                                  if (_pollStatus != 'draft')
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        'Options can only be edited in draft status',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textSecondary,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  const Divider(height: 24),
                                  SwitchListTile(
                                    value: _pollIsAnonymous,
                                    onChanged: (v) => setState(
                                        () => _pollIsAnonymous = v),
                                    title: const Text('Anonymous Voting'),
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  SwitchListTile(
                                    value: _pollAllowChange,
                                    onChanged: (v) => setState(
                                        () => _pollAllowChange = v),
                                    title: const Text('Allow Vote Change'),
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  SwitchListTile(
                                    value: _pollAllowMultiSelect,
                                    onChanged: (v) => setState(
                                        () => _pollAllowMultiSelect = v),
                                    title:
                                        const Text('Allow Multiple Selections'),
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  if (_pollAllowMultiSelect)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16),
                                      child: TextFormField(
                                        controller:
                                            _pollMaxSelectionsController,
                                        decoration: const InputDecoration(
                                          labelText:
                                              'Max Selections (optional)',
                                          isDense: true,
                                        ),
                                        keyboardType:
                                            TextInputType.number,
                                      ),
                                    ),
                                  SwitchListTile(
                                    value: _pollAllowOtherOption,
                                    onChanged: (v) => setState(
                                        () => _pollAllowOtherOption = v),
                                    title:
                                        const Text('Allow "Other" Free-text'),
                                    subtitle: const Text('Max 200 chars',
                                        style: TextStyle(fontSize: 11)),
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<String>(
                                    initialValue: _pollResultVisibility,
                                    decoration: const InputDecoration(
                                      labelText: 'Result Visibility',
                                      isDense: true,
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'immediate',
                                        child: Text('Immediately after voting'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'afterClose',
                                        child:
                                            Text('Only after poll closes'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'afterThreshold',
                                        child: Text(
                                            'After minimum responses met'),
                                      ),
                                    ],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setState(() =>
                                            _pollResultVisibility = v);
                                      }
                                    },
                                  ),
                                  if (_pollResultVisibility ==
                                      'afterThreshold') ...[
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller:
                                          _pollMinResponsesController,
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Minimum Responses Required',
                                        isDense: true,
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () async {
                                      final now = DateTime.now();
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: _pollClosesAt ??
                                            now.add(
                                                const Duration(days: 7)),
                                        firstDate: now,
                                        lastDate: now.add(
                                            const Duration(days: 365)),
                                      );
                                      if (picked != null && mounted) {
                                        final time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime:
                                              TimeOfDay.fromDateTime(
                                                  _pollClosesAt ?? now),
                                        );
                                        if (time != null && mounted) {
                                          setState(() {
                                            _pollClosesAt = DateTime(
                                              picked.year,
                                              picked.month,
                                              picked.day,
                                              time.hour,
                                              time.minute,
                                            );
                                          });
                                        }
                                      }
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText:
                                            'Auto-close Deadline (optional)',
                                        isDense: true,
                                        suffixIcon: _pollClosesAt != null
                                            ? IconButton(
                                                icon: const Icon(
                                                    Icons.close,
                                                    size: 16),
                                                onPressed: () => setState(
                                                    () => _pollClosesAt =
                                                        null),
                                                tooltip: 'Clear',
                                              )
                                            : const Icon(
                                                Icons.calendar_today,
                                                size: 16),
                                      ),
                                      child: Text(
                                        _pollClosesAt != null
                                            ? DateFormat('dd MMM yyyy HH:mm')
                                                .format(_pollClosesAt!)
                                            : 'No auto-close',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: _pollClosesAt != null
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if ((_pollData!['totalRespondents']
                                              as num? ??
                                          0) >
                                      0) ...[
                                    const SizedBox(height: 12),
                                    Text(
                                      'Total Respondents: ${_pollData!['totalRespondents']}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                  ),
                  const SizedBox(height: 16),
                ],
                // Upload config fields (shown for upload type)
                if (_earningType == 'upload') ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Upload Configuration',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _uploadPromptController,
                          decoration: const InputDecoration(
                            labelText: 'Prompt / Question *',
                            hintText:
                                'What question should the user respond to?',
                          ),
                          maxLines: 3,
                          validator: (v) => _earningType == 'upload' &&
                                  (v == null || v.trim().isEmpty)
                              ? 'Prompt is required for upload type'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        const Text('Allowed response types:',
                            style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 8),
                        CheckboxListTile(
                          title: const Text('Video Recording'),
                          value: _uploadVideoEnabled,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) =>
                              setState(() => _uploadVideoEnabled = v ?? false),
                        ),
                        if (_uploadVideoEnabled) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: DropdownButtonFormField<int>(
                              initialValue: _uploadVideoMaxSeconds,
                              decoration: const InputDecoration(
                                labelText: 'Max Video Duration',
                                isDense: true,
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 30, child: Text('30 seconds')),
                                DropdownMenuItem(
                                    value: 60, child: Text('60 seconds')),
                                DropdownMenuItem(
                                    value: 120, child: Text('120 seconds')),
                              ],
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _uploadVideoMaxSeconds = v);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        CheckboxListTile(
                          title: const Text('Image Capture'),
                          value: _uploadImageEnabled,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) =>
                              setState(() => _uploadImageEnabled = v ?? false),
                        ),
                        CheckboxListTile(
                          title: const Text('Text Response'),
                          value: _uploadTextEnabled,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) =>
                              setState(() => _uploadTextEnabled = v ?? false),
                        ),
                        if (_uploadTextEnabled) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _uploadTextMinCharsController,
                                    decoration: const InputDecoration(
                                      labelText: 'Min chars',
                                      isDense: true,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _uploadTextMaxCharsController,
                                    decoration: const InputDecoration(
                                      labelText: 'Max chars',
                                      isDense: true,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        // Required toggles (shown when 2+ types enabled)
                        if (_uploadEnabledCount >= 2) ...[
                          const Divider(),
                          const Text('Required fields:',
                              style: TextStyle(fontSize: 13)),
                          if (_uploadVideoEnabled)
                            CheckboxListTile(
                              title: const Text('Video required'),
                              value: _uploadVideoRequired,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) => setState(
                                  () => _uploadVideoRequired = v ?? false),
                            ),
                          if (_uploadImageEnabled)
                            CheckboxListTile(
                              title: const Text('Image required'),
                              value: _uploadImageRequired,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) => setState(
                                  () => _uploadImageRequired = v ?? false),
                            ),
                          if (_uploadTextEnabled)
                            CheckboxListTile(
                              title: const Text('Text required'),
                              value: _uploadTextRequired,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) => setState(
                                  () => _uploadTextRequired = v ?? false),
                            ),
                        ],
                        const Divider(),
                        CheckboxListTile(
                          title: const Text('Require Admin Review'),
                          subtitle:
                              const Text('Tokens held until admin approves'),
                          value: _requiresAdminReview,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (v) => setState(
                              () => _requiresAdminReview = v ?? false),
                        ),
                      ],
                    ),
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
                  onChanged: _onActiveToggled,
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: _isPinned,
                  onChanged: (v) => setState(() => _isPinned = v),
                  title: const Text('Pinned'),
                  subtitle: const Text('Pin to top of opportunity list'),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                  title: const Text('Featured'),
                  subtitle: const Text('Highlight as featured opportunity'),
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
      backgroundColor: AppColors.adminCard,
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
                  color: AppColors.adminSurface,
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
// Question subtitle helper (used by both Create and Edit question lists)
// ---------------------------------------------------------------------------

String _questionSubtitle(
    String qType, List<String> options, Map<String, dynamic> q) {
  const labels = {
    'single_select': 'Single Select',
    'multi_select': 'Multi Select',
    'text_input': 'Text Input',
    'likert': 'Likert',
    'star_tags': 'Star + Tags',
    'slider': 'Slider',
  };
  final label = labels[qType] ?? qType;
  final parts = <String>[label];
  if (options.isNotEmpty) parts.add('${options.length} options');
  if (q['isAttentionCheck'] == true) parts.add('attention check');
  final hasCorrectnessBranch = q['correctGoToQuestionId'] != null ||
      q['incorrectGoToQuestionId'] != null;
  if (hasCorrectnessBranch) parts.add('correct/incorrect branching');
  final rules = (q['branchRules'] as List?) ?? [];
  if (rules.isNotEmpty) parts.add('branching');
  return parts.join(' · ');
}

// ---------------------------------------------------------------------------
// Question Editor Dialog (used by both Create and Edit flows)
// ---------------------------------------------------------------------------

class _QuestionEditorDialog extends StatefulWidget {
  final Map<String, dynamic>? existing;
  /// All questions in the survey (for branch rule target selection)
  final List<Map<String, dynamic>> allQuestions;

  const _QuestionEditorDialog({this.existing, this.allQuestions = const []});

  @override
  State<_QuestionEditorDialog> createState() => _QuestionEditorDialogState();
}

class _QuestionEditorDialogState extends State<_QuestionEditorDialog> {
  final _textController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  bool _isAttentionCheck = false;
  String? _correctAnswer;
  String? _correctGoToQuestionId;
  String? _incorrectGoToQuestionId;

  // Response Box state
  final _correctResponseTextController = TextEditingController();
  String? _correctResponseMediaUrl; // existing URL (from Firestore)
  String? _correctResponseMediaType;
  Uint8List? _correctResponseMediaBytes; // newly picked (not yet uploaded)
  String? _correctResponseMediaFileName;
  final _incorrectResponseTextController = TextEditingController();
  String? _incorrectResponseMediaUrl; // existing URL (from Firestore)
  String? _incorrectResponseMediaType;
  Uint8List? _incorrectResponseMediaBytes; // newly picked (not yet uploaded)
  String? _incorrectResponseMediaFileName;

  // Question type
  String _questionType = 'single_select';
  bool _isRequired = true;

  // multi_select
  final _maxSelectionsController = TextEditingController();

  // text_input
  final _textInputCountController = TextEditingController(text: '1');
  final _textMaxLengthController = TextEditingController(text: '50');

  // likert
  final _likertLowController = TextEditingController();
  final _likertHighController = TextEditingController();

  // star_tags
  final List<TextEditingController> _tagControllers = [];
  final _maxTagsController = TextEditingController();

  // slider
  final _sliderMinController = TextEditingController(text: '0');
  final _sliderMaxController = TextEditingController(text: '100');
  final _sliderStepController = TextEditingController(text: '1');
  final _sliderMinLabelController = TextEditingController();
  final _sliderMaxLabelController = TextEditingController();

  // branch rules: optionIndex -> target questionId (null = next)
  final Map<int, String?> _branchRules = {};

  static const _typeLabels = {
    'single_select': 'Single Select',
    'multi_select': 'Multi Select',
    'text_input': 'Text Input',
    'likert': 'Likert Scale',
    'star_tags': 'Star + Tags',
    'slider': 'Slider',
  };

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      final e = widget.existing!;
      // TODO: Remove debug print after verifying Edit Question loads existing media
      debugPrint('[QuestionEditor.initState] existing keys=${e.keys.toList()} '
          'correctResponseMediaUrl=${e['correctResponseMediaUrl']} '
          'incorrectResponseMediaUrl=${e['incorrectResponseMediaUrl']} '
          'isAttentionCheck=${e['isAttentionCheck']} '
          'correctAnswer=${e['correctAnswer']}');
      _textController.text = e['text'] ?? '';
      _questionType = e['questionType'] ?? 'single_select';
      _isRequired = e['isRequired'] ?? e['required'] ?? true;
      _isAttentionCheck = e['isAttentionCheck'] == true;
      _correctAnswer = e['correctAnswer'] as String?;
      _correctGoToQuestionId = e['correctGoToQuestionId'] as String?;
      _incorrectGoToQuestionId = e['incorrectGoToQuestionId'] as String?;
      _correctResponseTextController.text =
          e['correctResponseText'] as String? ?? '';
      _correctResponseMediaUrl = e['correctResponseMediaUrl'] as String?;
      _correctResponseMediaType = e['correctResponseMediaType'] as String?;
      _incorrectResponseTextController.text =
          e['incorrectResponseText'] as String? ?? '';
      _incorrectResponseMediaUrl = e['incorrectResponseMediaUrl'] as String?;
      _incorrectResponseMediaType = e['incorrectResponseMediaType'] as String?;

      final options = (e['options'] as List?)?.cast<String>() ?? [];
      for (final opt in options) {
        _optionControllers.add(TextEditingController(text: opt));
      }

      // multi_select
      if (e['maxSelections'] != null) {
        _maxSelectionsController.text = e['maxSelections'].toString();
      }

      // text_input
      _textInputCountController.text =
          (e['textInputCount'] ?? 1).toString();
      _textMaxLengthController.text =
          (e['textMaxLength'] ?? 50).toString();

      // likert
      _likertLowController.text = e['likertLowLabel'] ?? '';
      _likertHighController.text = e['likertHighLabel'] ?? '';

      // star_tags
      final tags = (e['tags'] as List?)?.cast<String>() ?? [];
      for (final t in tags) {
        _tagControllers.add(TextEditingController(text: t));
      }
      if (e['maxTags'] != null) {
        _maxTagsController.text = e['maxTags'].toString();
      }

      // slider
      _sliderMinController.text = (e['sliderMin'] ?? 0).toString();
      _sliderMaxController.text = (e['sliderMax'] ?? 100).toString();
      _sliderStepController.text = (e['sliderStep'] ?? 1).toString();
      _sliderMinLabelController.text = e['sliderMinLabel'] ?? '';
      _sliderMaxLabelController.text = e['sliderMaxLabel'] ?? '';

      // branch rules
      final rules = (e['branchRules'] as List?) ?? [];
      for (final r in rules) {
        final optVal = r['optionValue'] as String?;
        final target = r['goToQuestionId'] as String?;
        if (optVal != null) {
          final idx = options.indexOf(optVal);
          if (idx >= 0) _branchRules[idx] = target;
        }
      }
    }

    // Ensure at least 2 option fields for select types
    if (_questionType == 'single_select' || _questionType == 'multi_select') {
      while (_optionControllers.length < 2) {
        _optionControllers.add(TextEditingController());
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    for (final c in _optionControllers) {
      c.dispose();
    }
    _maxSelectionsController.dispose();
    _textInputCountController.dispose();
    _textMaxLengthController.dispose();
    _likertLowController.dispose();
    _likertHighController.dispose();
    for (final c in _tagControllers) {
      c.dispose();
    }
    _maxTagsController.dispose();
    _sliderMinController.dispose();
    _sliderMaxController.dispose();
    _sliderStepController.dispose();
    _sliderMinLabelController.dispose();
    _sliderMaxLabelController.dispose();
    _correctResponseTextController.dispose();
    _incorrectResponseTextController.dispose();
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
      _branchRules.remove(index);
      // Shift branch rules for indices above removed
      final shifted = <int, String?>{};
      for (final entry in _branchRules.entries) {
        if (entry.key > index) {
          shifted[entry.key - 1] = entry.value;
        } else {
          shifted[entry.key] = entry.value;
        }
      }
      _branchRules
        ..clear()
        ..addAll(shifted);
      removed.dispose();
    });
  }

  void _addTag() {
    setState(() => _tagControllers.add(TextEditingController()));
  }

  void _removeTag(int index) {
    setState(() {
      final removed = _tagControllers.removeAt(index);
      removed.dispose();
    });
  }

  bool get _needsOptions =>
      _questionType == 'single_select' || _questionType == 'multi_select';

  bool _isSavingQuestion = false;

  Future<void> _handleSave() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    if (_needsOptions) {
      final optCount = _optionControllers
          .where((c) => c.text.trim().isNotEmpty)
          .length;
      if (optCount < 2) return;
    }

    final id = widget.existing?['id'] ??
        'q_${DateTime.now().millisecondsSinceEpoch}';

    // Upload any picked response media before saving
    setState(() => _isSavingQuestion = true);
    try {
      if (_correctResponseMediaBytes != null) {
        final url = await uploadAdminImage(
          bytes: _correctResponseMediaBytes!,
          fileName: _correctResponseMediaFileName,
          storagePath: 'survey_assets/response_media',
          fileId: '${id}_correct_${DateTime.now().millisecondsSinceEpoch}',
          resizeTarget: ImageResizeTarget.responseBoxImage,
        );
        _correctResponseMediaUrl = url;
        _correctResponseMediaType = 'image';
      }
      if (_incorrectResponseMediaBytes != null) {
        final url = await uploadAdminImage(
          bytes: _incorrectResponseMediaBytes!,
          fileName: _incorrectResponseMediaFileName,
          storagePath: 'survey_assets/response_media',
          fileId: '${id}_incorrect_${DateTime.now().millisecondsSinceEpoch}',
          resizeTarget: ImageResizeTarget.responseBoxImage,
        );
        _incorrectResponseMediaUrl = url;
        _incorrectResponseMediaType = 'image';
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSavingQuestion = false);
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Text('Image upload failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }
    if (mounted) setState(() => _isSavingQuestion = false);

    final options = _optionControllers
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final result = <String, dynamic>{
      'id': id,
      'text': text,
      'orderIndex': widget.existing?['orderIndex'] ?? 0,
      'questionType': _questionType,
      'isRequired': _isRequired,
    };

    // Type-specific fields
    switch (_questionType) {
      case 'single_select':
        result['options'] = options;
        result['isAttentionCheck'] = _isAttentionCheck;
        result['correctAnswer'] =
            _isAttentionCheck ? _correctAnswer : null;
        if (_isAttentionCheck && _correctGoToQuestionId != null) {
          result['correctGoToQuestionId'] = _correctGoToQuestionId;
        }
        if (_isAttentionCheck && _incorrectGoToQuestionId != null) {
          result['incorrectGoToQuestionId'] = _incorrectGoToQuestionId;
        }
        // Response Box fields — always write all 6 keys so removed values
        // are explicitly nulled out in Firestore (not silently kept).
        if (_isAttentionCheck) {
          final correctText = _correctResponseTextController.text.trim();
          result['correctResponseText'] = correctText.isNotEmpty ? correctText : null;
          result['correctResponseMediaUrl'] = _correctResponseMediaUrl;
          result['correctResponseMediaType'] = _correctResponseMediaType;
          final incorrectText =
              _incorrectResponseTextController.text.trim();
          result['incorrectResponseText'] = incorrectText.isNotEmpty ? incorrectText : null;
          result['incorrectResponseMediaUrl'] = _incorrectResponseMediaUrl;
          result['incorrectResponseMediaType'] = _incorrectResponseMediaType;
        }
        // TODO: Remove debug print after verifying Response Box saves
        debugPrint('[QuestionSave] isAttentionCheck=$_isAttentionCheck '
            'correctAnswer=$_correctAnswer '
            'correctResponseText=${_correctResponseTextController.text} '
            'correctResponseMediaUrl=$_correctResponseMediaUrl '
            'incorrectResponseText=${_incorrectResponseTextController.text} '
            'incorrectResponseMediaUrl=$_incorrectResponseMediaUrl '
            'result keys=${result.keys.toList()}');
        // Branch rules
        final rules = <Map<String, dynamic>>[];
        for (final entry in _branchRules.entries) {
          if (entry.value != null && entry.key < options.length) {
            rules.add({
              'optionValue': options[entry.key],
              'goToQuestionId': entry.value,
            });
          }
        }
        if (rules.isNotEmpty) result['branchRules'] = rules;
        break;
      case 'multi_select':
        result['options'] = options;
        final maxSel = int.tryParse(_maxSelectionsController.text.trim());
        if (maxSel != null && maxSel > 0) {
          result['maxSelections'] = maxSel;
        }
        break;
      case 'text_input':
        result['textInputCount'] =
            int.tryParse(_textInputCountController.text.trim()) ?? 1;
        result['textMaxLength'] =
            int.tryParse(_textMaxLengthController.text.trim()) ?? 50;
        break;
      case 'likert':
        result['likertScale'] = 5;
        final low = _likertLowController.text.trim();
        final high = _likertHighController.text.trim();
        if (low.isNotEmpty) result['likertLowLabel'] = low;
        if (high.isNotEmpty) result['likertHighLabel'] = high;
        break;
      case 'star_tags':
        result['maxStars'] = 5;
        final tags = _tagControllers
            .map((c) => c.text.trim())
            .where((t) => t.isNotEmpty)
            .toList();
        if (tags.isNotEmpty) result['tags'] = tags;
        final maxTags = int.tryParse(_maxTagsController.text.trim());
        if (maxTags != null && maxTags > 0) {
          result['maxTags'] = maxTags;
        }
        break;
      case 'slider':
        result['sliderMin'] =
            int.tryParse(_sliderMinController.text.trim()) ?? 0;
        result['sliderMax'] =
            int.tryParse(_sliderMaxController.text.trim()) ?? 100;
        result['sliderStep'] =
            int.tryParse(_sliderStepController.text.trim()) ?? 1;
        final minLabel = _sliderMinLabelController.text.trim();
        final maxLabel = _sliderMaxLabelController.text.trim();
        if (minLabel.isNotEmpty) result['sliderMinLabel'] = minLabel;
        if (maxLabel.isNotEmpty) result['sliderMaxLabel'] = maxLabel;
        break;
    }

    Navigator.of(context).pop(result);
  }

  /// Other questions available as branch targets
  List<Map<String, dynamic>> get _branchTargets {
    final currentId = widget.existing?['id'];
    return widget.allQuestions
        .where((q) => q['id'] != currentId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.adminCard,
      title: Text(
        widget.existing != null ? 'Edit Question' : 'Add Question',
        style: const TextStyle(color: AppColors.textPrimaryDark),
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question type selector
              DropdownButtonFormField<String>(
                initialValue: _questionType,
                decoration:
                    const InputDecoration(labelText: 'Question type'),
                items: _typeLabels.entries
                    .map((e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v == null) return;
                  setState(() {
                    _questionType = v;
                    // Ensure min options for select types
                    if (_needsOptions &&
                        _optionControllers.length < 2) {
                      while (_optionControllers.length < 2) {
                        _optionControllers
                            .add(TextEditingController());
                      }
                    }
                    // Reset attention check for non-single_select
                    if (v != 'single_select') {
                      _isAttentionCheck = false;
                      _correctAnswer = null;
                      _correctGoToQuestionId = null;
                      _incorrectGoToQuestionId = null;
                      _correctResponseTextController.clear();
                      _correctResponseMediaUrl = null;
                      _correctResponseMediaType = null;
                      _correctResponseMediaBytes = null;
                      _correctResponseMediaFileName = null;
                      _incorrectResponseTextController.clear();
                      _incorrectResponseMediaUrl = null;
                      _incorrectResponseMediaType = null;
                      _incorrectResponseMediaBytes = null;
                      _incorrectResponseMediaFileName = null;
                      _branchRules.clear();
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              // Question text
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Question text',
                  hintText: 'e.g., What best describes your view?',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              // Required toggle
              SwitchListTile(
                value: _isRequired,
                onChanged: (v) => setState(() => _isRequired = v),
                title: const Text('Required',
                    style: TextStyle(fontSize: 13)),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              const SizedBox(height: 8),

              // === TYPE-SPECIFIC CONFIG ===
              if (_needsOptions) ..._buildOptionsSection(),
              if (_questionType == 'single_select')
                ..._buildSingleSelectExtras(),
              if (_questionType == 'multi_select')
                ..._buildMultiSelectExtras(),
              if (_questionType == 'text_input')
                ..._buildTextInputConfig(),
              if (_questionType == 'likert') ..._buildLikertConfig(),
              if (_questionType == 'star_tags')
                ..._buildStarTagsConfig(),
              if (_questionType == 'slider') ..._buildSliderConfig(),
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
          onPressed: _isSavingQuestion ? null : _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
          child: _isSavingQuestion
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  // --- Options section (shared by single_select + multi_select) ---
  List<Widget> _buildOptionsSection() {
    return [
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
      const SizedBox(height: 8),
    ];
  }

  // --- Single select extras: attention check + branching ---
  List<Widget> _buildSingleSelectExtras() {
    return [
      SwitchListTile(
        value: _isAttentionCheck,
        onChanged: (v) => setState(() {
          _isAttentionCheck = v;
          if (!v) {
            _correctAnswer = null;
            _correctGoToQuestionId = null;
            _incorrectGoToQuestionId = null;
            _correctResponseTextController.clear();
            _correctResponseMediaUrl = null;
            _correctResponseMediaType = null;
            _correctResponseMediaBytes = null;
            _correctResponseMediaFileName = null;
            _incorrectResponseTextController.clear();
            _incorrectResponseMediaUrl = null;
            _incorrectResponseMediaType = null;
            _incorrectResponseMediaBytes = null;
            _incorrectResponseMediaFileName = null;
          }
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
        if (_correctAnswer != null && _branchTargets.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text(
            'Correctness Branching',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Jump to a specific question based on whether the answer is correct or incorrect',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _correctGoToQuestionId,
            decoration: const InputDecoration(
              labelText: 'If correct → go to',
              hintText: 'Next (default)',
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            isExpanded: true,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('Next (default)',
                    style: TextStyle(fontSize: 12)),
              ),
              ..._branchTargets.map((q) => DropdownMenuItem(
                    value: q['id'] as String,
                    child: Text(
                      q['text'] as String? ?? q['id'] as String,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ],
            onChanged: (v) =>
                setState(() => _correctGoToQuestionId = v),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _incorrectGoToQuestionId,
            decoration: const InputDecoration(
              labelText: 'If incorrect → go to',
              hintText: 'Next (default)',
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            isExpanded: true,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('Next (default)',
                    style: TextStyle(fontSize: 12)),
              ),
              ..._branchTargets.map((q) => DropdownMenuItem(
                    value: q['id'] as String,
                    child: Text(
                      q['text'] as String? ?? q['id'] as String,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ],
            onChanged: (v) =>
                setState(() => _incorrectGoToQuestionId = v),
          ),
        ],
      ],
      // --- Response Box (visible whenever correct answer is set) ---
      if (_correctAnswer != null) ...[
        const SizedBox(height: 16),
        const Text(
          'Response Box (optional)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Show feedback text/media before branching to the next question',
          style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _correctResponseTextController,
          decoration: const InputDecoration(
            labelText: 'Correct answer feedback',
            hintText: 'e.g., Well done! That\'s right.',
            isDense: true,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        _buildResponseMediaPicker(
          label: 'Correct answer media',
          currentUrl: _correctResponseMediaUrl,
          pickedBytes: _correctResponseMediaBytes,
          onPick: () => _pickResponseMedia(
            onPicked: (bytes, name) => setState(() {
              _correctResponseMediaBytes = bytes;
              _correctResponseMediaFileName = name;
            }),
          ),
          onRemoved: () {
            final urlToDelete = _correctResponseMediaUrl;
            setState(() {
              _correctResponseMediaUrl = null;
              _correctResponseMediaType = null;
              _correctResponseMediaBytes = null;
              _correctResponseMediaFileName = null;
            });
            if (urlToDelete != null) {
              FirebaseStorage.instance.refFromURL(urlToDelete).delete().catchError((_) {});
            }
          },
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _incorrectResponseTextController,
          decoration: const InputDecoration(
            labelText: 'Incorrect answer feedback',
            hintText: 'e.g., Not quite. The correct answer is...',
            isDense: true,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        _buildResponseMediaPicker(
          label: 'Incorrect answer media',
          currentUrl: _incorrectResponseMediaUrl,
          pickedBytes: _incorrectResponseMediaBytes,
          onPick: () => _pickResponseMedia(
            onPicked: (bytes, name) => setState(() {
              _incorrectResponseMediaBytes = bytes;
              _incorrectResponseMediaFileName = name;
            }),
          ),
          onRemoved: () {
            final urlToDelete = _incorrectResponseMediaUrl;
            setState(() {
              _incorrectResponseMediaUrl = null;
              _incorrectResponseMediaType = null;
              _incorrectResponseMediaBytes = null;
              _incorrectResponseMediaFileName = null;
            });
            if (urlToDelete != null) {
              FirebaseStorage.instance.refFromURL(urlToDelete).delete().catchError((_) {});
            }
          },
        ),
      ],
      // Branch rules
      if (_branchTargets.isNotEmpty) ...[
        const SizedBox(height: 16),
        const Text(
          'Branch Rules',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Optionally skip to a specific question based on selection',
          style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        ...List.generate(_optionControllers.length, (i) {
          final optText = _optionControllers[i].text.trim();
          if (optText.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    optText,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _branchRules[i],
                    decoration: const InputDecoration(
                      hintText: 'Next (default)',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                    ),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Next (default)',
                            style: TextStyle(fontSize: 12)),
                      ),
                      ..._branchTargets.map((q) => DropdownMenuItem(
                            value: q['id'] as String,
                            child: Text(
                              q['text'] as String? ?? q['id'] as String,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) =>
                        setState(() => _branchRules[i] = v),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ];
  }

  // --- Multi select extras ---
  List<Widget> _buildMultiSelectExtras() {
    return [
      TextField(
        controller: _maxSelectionsController,
        decoration: const InputDecoration(
          labelText: 'Max selections (optional)',
          hintText: 'e.g., 3 = "select up to 3"',
          isDense: true,
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
    ];
  }

  // --- Text input config ---
  List<Widget> _buildTextInputConfig() {
    return [
      TextField(
        controller: _textInputCountController,
        decoration: const InputDecoration(
          labelText: 'Number of text fields',
          hintText: '1-5',
          isDense: true,
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _textMaxLengthController,
        decoration: const InputDecoration(
          labelText: 'Max characters per field',
          hintText: 'Default: 50',
          isDense: true,
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
    ];
  }

  // --- Likert config ---
  List<Widget> _buildLikertConfig() {
    return [
      Text(
        '5-point scale',
        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _likertLowController,
        decoration: const InputDecoration(
          labelText: 'Low label (1)',
          hintText: 'e.g., Strongly Disagree',
          isDense: true,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _likertHighController,
        decoration: const InputDecoration(
          labelText: 'High label (5)',
          hintText: 'e.g., Strongly Agree',
          isDense: true,
        ),
      ),
      const SizedBox(height: 8),
    ];
  }

  // --- Star + Tags config ---
  List<Widget> _buildStarTagsConfig() {
    return [
      Text(
        '5-star rating + selectable tags',
        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tags (${_tagControllers.length})',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add tag'),
            onPressed: _addTag,
          ),
        ],
      ),
      ...List.generate(_tagControllers.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tagControllers[i],
                  decoration: InputDecoration(
                    labelText: 'Tag ${i + 1}',
                    hintText: 'e.g., Fast delivery',
                    isDense: true,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                color: AppColors.error,
                onPressed: () => _removeTag(i),
              ),
            ],
          ),
        );
      }),
      const SizedBox(height: 8),
      TextField(
        controller: _maxTagsController,
        decoration: const InputDecoration(
          labelText: 'Max tags (optional)',
          hintText: 'Leave empty for unlimited',
          isDense: true,
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
    ];
  }

  // --- Slider config ---
  List<Widget> _buildSliderConfig() {
    return [
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sliderMinController,
              decoration: const InputDecoration(
                labelText: 'Min value',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _sliderMaxController,
              decoration: const InputDecoration(
                labelText: 'Max value',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _sliderStepController,
              decoration: const InputDecoration(
                labelText: 'Step',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _sliderMinLabelController,
        decoration: const InputDecoration(
          labelText: 'Min label (optional)',
          hintText: 'e.g., Not at all',
          isDense: true,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _sliderMaxLabelController,
        decoration: const InputDecoration(
          labelText: 'Max label (optional)',
          hintText: 'e.g., Extremely',
          isDense: true,
        ),
      ),
      const SizedBox(height: 8),
    ];
  }

  /// Reusable media picker row for Response Box.
  /// Shows: existing URL preview, or newly picked bytes preview, or pick button.
  Widget _buildResponseMediaPicker({
    required String label,
    required String? currentUrl,
    required Uint8List? pickedBytes,
    required VoidCallback onPick,
    required VoidCallback onRemoved,
  }) {
    // TODO: Remove debug print after verifying media picker shows existing
    debugPrint('[MediaPicker] label=$label currentUrl=${currentUrl != null ? "SET(${currentUrl.length} chars)" : "null"} pickedBytes=${pickedBytes != null ? "SET(${pickedBytes.length} bytes)" : "null"}');
    // Show preview of newly picked image (from memory)
    if (pickedBytes != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.memory(
              pickedBytes,
              width: 60,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            color: AppColors.error,
            tooltip: 'Remove',
            onPressed: onRemoved,
          ),
        ],
      );
    }

    // Show preview of existing uploaded URL
    if (currentUrl != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              currentUrl,
              width: 60,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            color: AppColors.error,
            tooltip: 'Remove',
            onPressed: onRemoved,
          ),
        ],
      );
    }

    // No media yet — show pick button
    return OutlinedButton.icon(
      icon: const Icon(Icons.upload, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 36),
      ),
      onPressed: onPick,
    );
  }

  Future<void> _pickResponseMedia({
    required void Function(Uint8List bytes, String fileName) onPicked,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: adminImageExtensions,
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        onPicked(result.files.single.bytes!, result.files.single.name);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
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
      builder: (ctx) => _QuestionEditorDialog(existing: existing, allQuestions: _questions),
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
      backgroundColor: AppColors.adminCard,
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
              if (_questions.isNotEmpty)
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: false,
                  itemCount: _questions.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      final item = _questions.removeAt(oldIndex);
                      _questions.insert(newIndex, item);
                      for (var i = 0; i < _questions.length; i++) {
                        _questions[i]['orderIndex'] = i;
                      }
                    });
                  },
                  itemBuilder: (context, idx) {
                    final q = _questions[idx];
                    final qType = q['questionType'] ?? 'single_select';
                    final options =
                        (q['options'] as List?)?.cast<String>() ?? [];
                    return Card(
                      key: ValueKey(q['id'] ?? idx),
                      color: AppColors.adminSurface,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        dense: true,
                        leading: ReorderableDragStartListener(
                          index: idx,
                          child: const Icon(Icons.drag_handle,
                              size: 20, color: AppColors.textSecondary),
                        ),
                        title: Text(
                          q['text'] ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        subtitle: Text(
                          _questionSubtitle(qType, options, q),
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
                  },
                ),
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
// ---------------------------------------------------------------------------
// Offramp Chip Editor (for inline account type restrictions)
// ---------------------------------------------------------------------------

class _OfframpChipEditor extends StatefulWidget {
  final List<String> offramps;
  final ValueChanged<List<String>> onChanged;

  const _OfframpChipEditor({
    required this.offramps,
    required this.onChanged,
  });

  @override
  State<_OfframpChipEditor> createState() => _OfframpChipEditorState();
}

class _OfframpChipEditorState extends State<_OfframpChipEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isUnrestricted =>
      widget.offramps.length == 1 && widget.offramps.first == '*';

  void _addOfframp() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    final updated = List<String>.from(widget.offramps);
    // Adding a specific offramp removes the wildcard
    updated.remove('*');
    if (!updated.contains(value)) {
      updated.add(value);
    }
    _controller.clear();
    widget.onChanged(updated);
  }

  void _removeOfframp(String value) {
    final updated = List<String>.from(widget.offramps)..remove(value);
    // If all removed, revert to unrestricted
    if (updated.isEmpty) {
      updated.add('*');
    }
    widget.onChanged(updated);
  }

  void _setUnrestricted() {
    widget.onChanged(['*']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Allowed Offramps',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const Spacer(),
            if (!_isUnrestricted)
              TextButton.icon(
                onPressed: _setUnrestricted,
                icon: const Icon(Icons.lock_open, size: 14),
                label: const Text('Set Unrestricted', style: TextStyle(fontSize: 11)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        if (_isUnrestricted)
          Chip(
            label: const Text('All offramps (unrestricted)'),
            deleteIcon: const Icon(Icons.edit, size: 14),
            onDeleted: () => widget.onChanged([]),
            backgroundColor: AppColors.success.withValues(alpha: 0.15),
            labelStyle: TextStyle(
              fontSize: 12,
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          )
        else ...[
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: widget.offramps
                .map((o) => InputChip(
                      label: Text(o, style: const TextStyle(fontSize: 12)),
                      onDeleted: () => _removeOfframp(o),
                      deleteIconColor: AppColors.error,
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Add supplier ID...',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onSubmitted: (_) => _addOfframp(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _addOfframp,
                icon: const Icon(Icons.add_circle_outline, size: 20),
                tooltip: 'Add offramp',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

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
              backgroundColor: AppColors.adminSurface,
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
