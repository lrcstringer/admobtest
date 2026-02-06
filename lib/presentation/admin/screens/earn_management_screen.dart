import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          children: [
            OutlinedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _showCreateThreadDialog,
              icon: const Icon(Icons.add),
              label: const Text('New Campaign'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
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
        Container(
          width: 250,
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
                          return ListTile(
                            selected: isSelected,
                            selectedTileColor:
                                AppColors.primary.withValues(alpha: 0.1),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              child: Text(
                                (client['displayName'] ?? 'C')[0]
                                    .toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              client['displayName'] ?? client['companyName'],
                              style: TextStyle(
                                color: AppColors.textPrimaryDark,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              setState(() => _selectedClientId = client['id']);
                              _loadThreadsForClient(client['id']);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),

        // Threads list
        Container(
          width: 300,
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
                              return ListTile(
                                selected: isSelected,
                                selectedTileColor:
                                    AppColors.primary.withValues(alpha: 0.1),
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
                                    color: AppColors.textPrimaryDark,
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
                                trailing: thread['isFeatured'] == true
                                    ? const Icon(Icons.star,
                                        color: AppColors.warning, size: 18)
                                    : null,
                                onTap: () {
                                  setState(
                                      () => _selectedThreadId = thread['id']);
                                  _loadOpportunitiesForThread(thread['id']);
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),

        // Opportunities list
        Expanded(
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
                              return _OpportunityCard(opportunity: opp);
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

        final threads = snapshot.data?.docs ?? [];

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
            return _CampaignCard(thread: thread);
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

        final opportunities = snapshot.data?.docs ?? [];

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
            return _OpportunityCard(opportunity: opp);
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

  const _CampaignCard({required this.thread});

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
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.campaign, color: AppColors.primary),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                const SizedBox(height: 8),
                Text(
                  '${thread['availableOpportunities'] ?? 0} opportunities',
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
    );
  }
}

class _OpportunityCard extends StatelessWidget {
  final Map<String, dynamic> opportunity;

  const _OpportunityCard({required this.opportunity});

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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(typeIcon, color: AppColors.secondary),
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
                const SizedBox(height: 8),
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
              ],
            ),
          ],
        ),
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedClientId = widget.selectedClientId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a client')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get client data for denormalization
      final clientDoc = await FirebaseFirestore.instance
          .collection('clients')
          .doc(_selectedClientId)
          .get();
      final clientData = clientDoc.data()!;

      // Create thread
      final threadRef =
          FirebaseFirestore.instance.collection('earnThreads').doc();
      await threadRef.set({
        'id': threadRef.id,
        'clientId': _selectedClientId,
        'clientName': clientData['displayName'] ?? clientData['companyName'],
        'clientAvatarImage': clientData['avatarImage'],
        'clientAvatarColor': clientData['avatarColor'],
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'tokenSourceSubAccountId': 'default', // TODO: Allow selection
        'isPinned': false,
        'isFeatured': _isFeatured,
        'isActive': _isActive,
        'availableOpportunities': 0,
        'completedOpportunities': 0,
        'completedUniqueUsers': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

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
                onChanged: (value) => setState(() => _selectedClientId = value),
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
            ],
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

  final _earningTypes = [
    ('video', 'Video'),
    ('survey', 'Survey'),
    ('trivia', 'Trivia'),
    ('rating', 'Rating'),
    ('poll', 'Poll'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mediaUrlController.dispose();
    _tokenRewardController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Get thread data for denormalization
      final threadDoc = await FirebaseFirestore.instance
          .collection('earnThreads')
          .doc(widget.threadId)
          .get();
      final threadData = threadDoc.data()!;

      // Create opportunity
      final oppRef =
          FirebaseFirestore.instance.collection('earnOpportunities').doc();
      await oppRef.set({
        'id': oppRef.id,
        'threadId': widget.threadId,
        'clientId': threadData['clientId'],
        'clientName': threadData['clientName'],
        'clientAvatarColor': threadData['clientAvatarColor'],
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'earningType': _earningType,
        'mediaType': _earningType == 'video' ? 'video' : 'text',
        'mediaUrl': _mediaUrlController.text.trim().isEmpty
            ? null
            : _mediaUrlController.text.trim(),
        'tokenReward': int.tryParse(_tokenRewardController.text) ?? 10,
        'durationSeconds': int.tryParse(_durationController.text) ?? 30,
        'questions': [],
        'isActive': _isActive,
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
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating opportunity: $e'),
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
                if (_earningType == 'video')
                  TextFormField(
                    controller: _mediaUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Video URL',
                      hintText: 'https://...',
                    ),
                  ),
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
                SwitchListTile(
                  value: _isActive,
                  onChanged: (v) => setState(() => _isActive = v),
                  title: const Text('Active'),
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
