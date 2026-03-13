import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

/// Reward Campaign Management screen for admin portal
/// Allows admins to manage reward campaigns, import codes, and view analytics
class RewardCampaignScreen extends StatefulWidget {
  const RewardCampaignScreen({super.key});

  @override
  State<RewardCampaignScreen> createState() => _RewardCampaignScreenState();
}

class _RewardCampaignScreenState extends State<RewardCampaignScreen> {
  // Data
  List<Map<String, dynamic>> _campaigns = [];
  List<Map<String, dynamic>> _clients = [];
  Map<String, dynamic>? _statistics;
  bool _isLoading = true;

  // Filters
  String? _filterClientId;
  String? _filterStatus;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Load clients (reward sponsors)
      final clientsSnapshot = await FirebaseFirestore.instance
          .collection('clients')
          .where('isActive', isEqualTo: true)
          .get();

      _clients = clientsSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((c) => c['isDeleted'] != true)
          .toList();

      // Load campaigns
      Query query = FirebaseFirestore.instance
          .collection('rewardCampaigns')
          .orderBy('createdAt', descending: true);

      final campaignsSnapshot = await query.get();

      _campaigns = campaignsSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .where((c) => c['isDeleted'] != true)
          .toList();

      // Calculate statistics
      final activeCampaigns =
          _campaigns.where((c) => c['status'] == 'active').length;
      final totalAllocated = _campaigns.fold<int>(
          0, (total, c) => total + ((c['allocatedQuantity'] as num?)?.toInt() ?? 0));
      final totalRedeemed = _campaigns.fold<int>(
          0, (total, c) => total + ((c['redeemedQuantity'] as num?)?.toInt() ?? 0));

      _statistics = {
        'totalCampaigns': _campaigns.length,
        'activeCampaigns': activeCampaigns,
        'totalAllocated': totalAllocated,
        'totalRedeemed': totalRedeemed,
      };

      if (mounted) setState(() => _isLoading = false);
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

  List<Map<String, dynamic>> get _filteredCampaigns {
    var filtered = _campaigns;
    if (_filterClientId != null) {
      filtered =
          filtered.where((c) => c['clientId'] == _filterClientId).toList();
    }
    if (_filterStatus != null) {
      filtered = filtered.where((c) => c['status'] == _filterStatus).toList();
    }
    return filtered;
  }

  Color _parseColor(String? hex, {Color fallback = AppColors.secondary}) {
    if (hex != null && hex.startsWith('#')) {
      try {
        return Color(int.parse(hex.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return fallback;
  }

  String _formatDate(dynamic value) {
    if (value == null) return '—';
    DateTime dt;
    if (value is Timestamp) {
      dt = value.toDate();
    } else if (value is String) {
      dt = DateTime.parse(value);
    } else {
      return '—';
    }
    return DateFormat('dd MMM yyyy').format(dt);
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
                  _buildFilters(),
                  const SizedBox(height: 16),
                  _buildCampaignsList(),
                ],
              ),
            ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reward Campaigns',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage reward campaigns, import codes, and track redemptions',
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
              onPressed: () => _showCreateCampaignDialog(),
              icon: const Icon(Icons.add),
              label: const Text('New Campaign'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                minimumSize: const Size(0, 40),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Stats
  // ---------------------------------------------------------------------------

  Widget _buildStatCards() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _StatCard(
          title: 'Total Campaigns',
          value: '${_statistics?['totalCampaigns'] ?? 0}',
          icon: Icons.card_giftcard,
          color: AppColors.accent,
        ),
        _StatCard(
          title: 'Active',
          value: '${_statistics?['activeCampaigns'] ?? 0}',
          icon: Icons.check_circle_outline,
          color: AppColors.success,
        ),
        _StatCard(
          title: 'Items Allocated',
          value: '${_statistics?['totalAllocated'] ?? 0}',
          icon: Icons.assignment_ind,
          color: AppColors.primary,
        ),
        _StatCard(
          title: 'Items Redeemed',
          value: '${_statistics?['totalRedeemed'] ?? 0}',
          icon: Icons.redeem,
          color: AppColors.secondary,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Filters
  // ---------------------------------------------------------------------------

  Widget _buildFilters() {
    return Row(
      children: [
        // Client filter
        SizedBox(
          width: 220,
          child: DropdownButtonFormField<String>(
            value: _filterClientId,
            decoration: const InputDecoration(
              labelText: 'Client',
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: [
              const DropdownMenuItem(value: null, child: Text('All Clients')),
              ..._clients.map((c) => DropdownMenuItem(
                    value: c['id'] as String,
                    child: Text(c['displayName'] as String? ??
                        c['companyName'] as String? ??
                        'Unknown'),
                  )),
            ],
            onChanged: (val) => setState(() => _filterClientId = val),
          ),
        ),
        const SizedBox(width: 16),
        // Status filter
        SizedBox(
          width: 180,
          child: DropdownButtonFormField<String>(
            value: _filterStatus,
            decoration: const InputDecoration(
              labelText: 'Status',
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: const [
              DropdownMenuItem(value: null, child: Text('All Statuses')),
              DropdownMenuItem(value: 'draft', child: Text('Draft')),
              DropdownMenuItem(value: 'active', child: Text('Active')),
              DropdownMenuItem(value: 'paused', child: Text('Paused')),
              DropdownMenuItem(value: 'exhausted', child: Text('Exhausted')),
              DropdownMenuItem(value: 'expired', child: Text('Expired')),
              DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
            ],
            onChanged: (val) => setState(() => _filterStatus = val),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Campaign list
  // ---------------------------------------------------------------------------

  Widget _buildCampaignsList() {
    final campaigns = _filteredCampaigns;

    if (campaigns.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.card_giftcard_outlined,
                  size: 64, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text(
                'No reward campaigns found',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create a new campaign to get started',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children:
          campaigns.map((c) => _buildCampaignCard(c)).toList(),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    final status = campaign['status'] as String? ?? 'draft';
    final rewardType = campaign['rewardType'] as String? ?? 'custom';
    final total = (campaign['totalQuantity'] as num?)?.toInt() ?? 0;
    final remaining = (campaign['remainingQuantity'] as num?)?.toInt() ?? 0;
    final allocated = (campaign['allocatedQuantity'] as num?)?.toInt() ?? 0;
    final redeemed = (campaign['redeemedQuantity'] as num?)?.toInt() ?? 0;
    final progress = total > 0 ? (allocated / total) : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: client avatar, campaign name, status, actions
          Row(
            children: [
              _buildClientAvatar(campaign),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign['name'] as String? ?? 'Untitled Campaign',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${campaign['clientName'] ?? 'Unknown client'} · ${_rewardTypeLabel(rewardType)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusChip(status),
              if ((campaign['abTest'] as Map<String, dynamic>?)?['enabled'] ==
                  true) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'A/B',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 12),
              PopupMenuButton<String>(
                onSelected: (action) =>
                    _handleCampaignAction(action, campaign),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: 'edit', child: Text('Edit Campaign')),
                  PopupMenuItem(
                      value: 'import',
                      child: Text(rewardType == 'digital_content'
                          ? 'Import URLs / Codes'
                          : 'Import Codes')),
                  if (status == 'draft' || status == 'paused')
                    const PopupMenuItem(
                        value: 'activate', child: Text('Activate')),
                  if (status == 'active')
                    const PopupMenuItem(
                        value: 'pause', child: Text('Pause')),
                  const PopupMenuItem(
                      value: 'cancel',
                      child:
                          Text('Cancel', style: TextStyle(color: Colors.red))),
                ],
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.more_vert,
                      color: AppColors.textSecondary, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Date range
          Row(
            children: [
              Icon(Icons.date_range, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                '${_formatDate(campaign['startsAt'])} — ${_formatDate(campaign['endsAt'])}',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$allocated / $total allocated  ·  $redeemed redeemed',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor:
                            AppColors.textSecondary.withValues(alpha: 0.2),
                        color: _progressColor(progress),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Inventory breakdown chips
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildInventoryChip('Available', remaining, AppColors.success),
              _buildInventoryChip('Allocated', allocated, AppColors.primary),
              _buildInventoryChip('Redeemed', redeemed, AppColors.secondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientAvatar(Map<String, dynamic> campaign) {
    final color =
        _parseColor(campaign['clientAvatarColor'] as String?);
    final name = campaign['clientName'] as String? ?? '';
    final initials = name.isNotEmpty
        ? name.split(' ').map((w) => w.isNotEmpty ? w[0] : '').take(2).join()
        : '??';

    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final Color bgColor;
    final Color textColor;
    final String label;

    switch (status) {
      case 'draft':
        bgColor = AppColors.textSecondary.withValues(alpha: 0.15);
        textColor = AppColors.textSecondary;
        label = 'Draft';
      case 'active':
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        label = 'Active';
      case 'paused':
        bgColor = AppColors.warning.withValues(alpha: 0.15);
        textColor = AppColors.warning;
        label = 'Paused';
      case 'exhausted':
        bgColor = AppColors.primary.withValues(alpha: 0.15);
        textColor = AppColors.primary;
        label = 'Exhausted';
      case 'expired':
        bgColor = AppColors.error.withValues(alpha: 0.15);
        textColor = AppColors.error;
        label = 'Expired';
      case 'cancelled':
        bgColor = AppColors.error.withValues(alpha: 0.15);
        textColor = AppColors.error;
        label = 'Cancelled';
      default:
        bgColor = AppColors.textSecondary.withValues(alpha: 0.15);
        textColor = AppColors.textSecondary;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInventoryChip(String label, int count, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: $count',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Color _progressColor(double progress) {
    if (progress >= 0.9) return AppColors.error;
    if (progress >= 0.7) return AppColors.warning;
    return AppColors.success;
  }

  String _rewardTypeLabel(String type) {
    switch (type) {
      case 'qr_code':
        return 'QR Code';
      case 'voucher_code':
        return 'Voucher Code';
      case 'discount_code':
        return 'Discount Code';
      case 'digital_content':
        return 'Digital Content';
      default:
        return type;
    }
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  void _handleCampaignAction(String action, Map<String, dynamic> campaign) {
    switch (action) {
      case 'edit':
        _showCreateCampaignDialog(campaign: campaign);
      case 'import':
        _showImportCodesDialog(campaign);
      case 'activate':
        _updateCampaignStatus(campaign['id'] as String, 'active');
      case 'pause':
        _updateCampaignStatus(campaign['id'] as String, 'paused');
      case 'cancel':
        _confirmCancelCampaign(campaign);
    }
  }

  Future<void> _updateCampaignStatus(
      String campaignId, String newStatus) async {
    try {
      final fn = FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable(
        'updateRewardCampaign',
      );
      await fn.call({
        'campaignId': campaignId,
        'updates': {'status': newStatus},
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Campaign ${newStatus == 'active' ? 'activated' : newStatus}'),
            backgroundColor: AppColors.success,
          ),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating campaign: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _confirmCancelCampaign(Map<String, dynamic> campaign) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Campaign'),
        content: Text(
            'Are you sure you want to cancel "${campaign['name']}"? This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('No')),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _updateCampaignStatus(campaign['id'] as String, 'cancelled');
            },
            child: const Text('Yes, Cancel',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Create / Edit Campaign Dialog
  // ---------------------------------------------------------------------------

  void _showCreateCampaignDialog({Map<String, dynamic>? campaign}) {
    showDialog(
      context: context,
      builder: (ctx) => _CampaignFormDialog(
        clients: _clients,
        campaign: campaign,
        onSaved: () {
          _loadData();
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Import Codes Dialog
  // ---------------------------------------------------------------------------

  void _showImportCodesDialog(Map<String, dynamic> campaign) {
    showDialog(
      context: context,
      builder: (ctx) => _ImportCodesDialog(
        campaign: campaign,
        onImported: () {
          _loadData();
        },
      ),
    );
  }
}

// =============================================================================
// Campaign Form Dialog (Create / Edit)
// =============================================================================

class _CampaignFormDialog extends StatefulWidget {
  final List<Map<String, dynamic>> clients;
  final Map<String, dynamic>? campaign;
  final VoidCallback onSaved;

  const _CampaignFormDialog({
    required this.clients,
    this.campaign,
    required this.onSaved,
  });

  @override
  State<_CampaignFormDialog> createState() => _CampaignFormDialogState();
}

class _CampaignFormDialogState extends State<_CampaignFormDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  // Form fields
  String? _clientId;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _displayImageUrlController = TextEditingController();
  int _displayPriority = 0;
  String _rewardType = 'qr_code';
  DateTime? _startsAt;
  DateTime? _endsAt;
  DateTime? _itemExpiresAt;
  int _maxPerUser = 1;
  final _instructionsController = TextEditingController();
  final _termsController = TextEditingController();

  // A/B test fields
  bool _abTestEnabled = false;
  List<_AbVariant> _abVariants = [
    _AbVariant(name: 'control', weight: 50),
    _AbVariant(name: 'variant_a', weight: 50),
  ];

  bool get _isEditing => widget.campaign != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final c = widget.campaign!;
      _clientId = c['clientId'] as String?;
      _nameController.text = c['name'] as String? ?? '';
      _descriptionController.text = c['description'] as String? ?? '';
      _rewardType = c['rewardType'] as String? ?? 'qr_code';
      _startsAt = _parseDateTime(c['startsAt']);
      _endsAt = _parseDateTime(c['endsAt']);
      _itemExpiresAt = _parseDateTime(c['itemExpiresAt']);
      _maxPerUser = (c['maxPerUser'] as num?)?.toInt() ?? 1;
      final meta = c['metadata'] as Map<String, dynamic>? ?? {};
      _instructionsController.text =
          meta['redemption_instructions'] as String? ?? '';
      _termsController.text =
          meta['terms_and_conditions'] as String? ?? '';
      _displayImageUrlController.text =
          c['displayImageUrl'] as String? ?? '';
      _displayPriority = (c['displayPriority'] as num?)?.toInt() ?? 0;

      // Pre-populate A/B test fields
      final abTest = c['abTest'] as Map<String, dynamic>?;
      if (abTest != null && abTest['enabled'] == true) {
        _abTestEnabled = true;
        final variants = abTest['variants'] as List<dynamic>? ?? [];
        if (variants.isNotEmpty) {
          _abVariants = variants
              .map((v) => _AbVariant(
                    name: (v as Map<String, dynamic>)['id'] as String? ?? '',
                    weight: ((v)['weight'] as num?)?.toInt() ?? 0,
                  ))
              .toList();
        }
      }
    }
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _displayImageUrlController.dispose();
    _instructionsController.dispose();
    _termsController.dispose();
    super.dispose();
  }

  Widget _buildAbTestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'A/B Testing',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Switch(
              value: _abTestEnabled,
              onChanged: (v) => setState(() => _abTestEnabled = v),
            ),
          ],
        ),
        if (_abTestEnabled) ...[
          const SizedBox(height: 8),
          Text(
            'Variant weights must sum to 100. Users are assigned deterministically.',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          ..._abVariants.asMap().entries.map((entry) {
            final idx = entry.key;
            final variant = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      initialValue: variant.name,
                      decoration: InputDecoration(
                        labelText: 'Variant ${idx + 1} name',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (v) => variant.name = v,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      initialValue: '${variant.weight}',
                      decoration: const InputDecoration(
                        labelText: 'Weight',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (v) =>
                          variant.weight = int.tryParse(v) ?? 0,
                    ),
                  ),
                  if (_abVariants.length > 2)
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.red, size: 20),
                      onPressed: () =>
                          setState(() => _abVariants.removeAt(idx)),
                    ),
                ],
              ),
            );
          }),
          Row(
            children: [
              if (_abVariants.length < 4)
                TextButton.icon(
                  onPressed: () => setState(() => _abVariants.add(
                        _AbVariant(
                          name: 'variant_${String.fromCharCode(97 + _abVariants.length - 1)}',
                          weight: 0,
                        ),
                      )),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Variant'),
                ),
              const Spacer(),
              Text(
                'Total: ${_abVariants.fold<int>(0, (s, v) => s + v.weight)}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _abVariants.fold<int>(0, (s, v) => s + v.weight) == 100
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_clientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a client')),
      );
      return;
    }
    if (_startsAt == null || _endsAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set start and end dates')),
      );
      return;
    }

    if (_abTestEnabled) {
      final totalWeight =
          _abVariants.fold<int>(0, (s, v) => s + v.weight);
      if (totalWeight != 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('A/B variant weights must sum to 100')),
        );
        return;
      }
      if (_abVariants.any((v) => v.name.trim().isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('All A/B variants must have a name')),
        );
        return;
      }
    }

    // Warn when editing an active campaign
    if (_isEditing) {
      final currentStatus = widget.campaign!['status'] as String? ?? 'draft';
      if (currentStatus == 'active') {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Edit Active Campaign?'),
            content: const Text(
              'This campaign is currently active. Changes will take effect immediately for all users.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
      }
    }

    setState(() => _isSaving = true);

    try {
      final metadata = <String, dynamic>{};
      if (_instructionsController.text.isNotEmpty) {
        metadata['redemption_instructions'] = _instructionsController.text;
      }
      if (_termsController.text.isNotEmpty) {
        metadata['terms_and_conditions'] = _termsController.text;
      }

      final abTestData = _abTestEnabled
          ? {
              'enabled': true,
              'variants': _abVariants
                  .map((v) => {
                        'id': v.name.trim(),
                        'weight': v.weight,
                        'metadata': <String, dynamic>{},
                      })
                  .toList(),
            }
          : {'enabled': false, 'variants': <Map<String, dynamic>>[]};

      if (_isEditing) {
        final fn = FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable(
          'updateRewardCampaign',
        );
        await fn.call({
          'campaignId': widget.campaign!['id'],
          'updates': {
            'name': _nameController.text,
            'description': _descriptionController.text,
            'startsAt': _startsAt!.toIso8601String(),
            'endsAt': _endsAt!.toIso8601String(),
            if (_itemExpiresAt != null)
              'itemExpiresAt': _itemExpiresAt!.toIso8601String(),
            'maxPerUser': _maxPerUser,
            'displayImageUrl': _displayImageUrlController.text.isNotEmpty
                ? _displayImageUrlController.text
                : null,
            'displayPriority': _displayPriority,
            'metadata': metadata,
            'abTest': abTestData,
          },
        });
      } else {
        final fn = FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable(
          'createRewardCampaign',
        );
        await fn.call({
          'clientId': _clientId,
          'name': _nameController.text,
          'description': _descriptionController.text,
          'rewardType': _rewardType,
          'startsAt': _startsAt!.toIso8601String(),
          'endsAt': _endsAt!.toIso8601String(),
          if (_itemExpiresAt != null)
            'itemExpiresAt': _itemExpiresAt!.toIso8601String(),
          'maxPerUser': _maxPerUser,
          if (_displayImageUrlController.text.isNotEmpty)
            'displayImageUrl': _displayImageUrlController.text,
          'displayPriority': _displayPriority,
          'metadata': metadata,
          'abTest': abTestData,
        });
      }

      if (mounted) {
        Navigator.of(context).pop();
        widget.onSaved();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Campaign ${_isEditing ? 'updated' : 'created'} successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _pickDate(String field) async {
    final initial = field == 'start'
        ? _startsAt
        : field == 'end'
            ? _endsAt
            : _itemExpiresAt;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (picked != null) {
      setState(() {
        switch (field) {
          case 'start':
            _startsAt = picked;
          case 'end':
            _endsAt = picked;
          case 'itemExpiry':
            _itemExpiresAt = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Campaign' : 'New Reward Campaign'),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Client dropdown (only for create)
                if (!_isEditing)
                  DropdownButtonFormField<String>(
                    value: _clientId,
                    decoration: const InputDecoration(
                      labelText: 'Client (Sponsor)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null ? 'Required' : null,
                    items: widget.clients
                        .map((c) => DropdownMenuItem(
                              value: c['id'] as String,
                              child: Text(c['displayName'] as String? ??
                                  c['companyName'] as String? ??
                                  'Unknown'),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _clientId = v),
                  ),
                if (!_isEditing) const SizedBox(height: 16),

                // Campaign name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Campaign Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // Display image URL
                TextFormField(
                  controller: _displayImageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Display Image URL (optional)',
                    border: OutlineInputBorder(),
                    helperText: 'Image shown to users in the reward card',
                  ),
                ),
                const SizedBox(height: 16),

                // Display priority
                TextFormField(
                  initialValue: '$_displayPriority',
                  decoration: const InputDecoration(
                    labelText: 'Display Priority',
                    border: OutlineInputBorder(),
                    helperText: 'Higher values appear first (0 = default)',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      _displayPriority = int.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 16),

                // Reward type
                DropdownButtonFormField<String>(
                  value: _rewardType,
                  decoration: const InputDecoration(
                    labelText: 'Reward Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'qr_code', child: Text('QR Code')),
                    DropdownMenuItem(
                        value: 'voucher_code', child: Text('Voucher Code')),
                    DropdownMenuItem(
                        value: 'discount_code',
                        child: Text('Discount Code')),
                    DropdownMenuItem(
                        value: 'digital_content',
                        child: Text('Digital Content')),
                  ],
                  onChanged: (v) =>
                      setState(() => _rewardType = v ?? 'qr_code'),
                ),
                const SizedBox(height: 16),

                // Date range
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickDate('start'),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Starts At',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _startsAt != null
                                ? DateFormat('dd MMM yyyy')
                                    .format(_startsAt!)
                                : 'Pick date',
                            style: TextStyle(
                              color: _startsAt != null
                                  ? null
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickDate('end'),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Ends At',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _endsAt != null
                                ? DateFormat('dd MMM yyyy').format(_endsAt!)
                                : 'Pick date',
                            style: TextStyle(
                              color: _endsAt != null
                                  ? null
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Item expiry date (optional)
                InkWell(
                  onTap: () => _pickDate('itemExpiry'),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Item Expiry Date (optional)',
                      border: const OutlineInputBorder(),
                      suffixIcon: _itemExpiresAt != null
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () =>
                                  setState(() => _itemExpiresAt = null),
                            )
                          : null,
                    ),
                    child: Text(
                      _itemExpiresAt != null
                          ? DateFormat('dd MMM yyyy')
                              .format(_itemExpiresAt!)
                          : 'No individual item expiry',
                      style: TextStyle(
                        color: _itemExpiresAt != null
                            ? null
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Max per user
                TextFormField(
                  initialValue: '$_maxPerUser',
                  decoration: const InputDecoration(
                    labelText: 'Max Per User',
                    border: OutlineInputBorder(),
                    helperText: 'Maximum items a single user can earn',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    final n = int.tryParse(v);
                    if (n == null || n < 1) return 'Must be at least 1';
                    return null;
                  },
                  onChanged: (v) =>
                      _maxPerUser = int.tryParse(v) ?? 1,
                ),
                const SizedBox(height: 16),

                // Redemption instructions
                TextFormField(
                  controller: _instructionsController,
                  decoration: const InputDecoration(
                    labelText: 'Redemption Instructions',
                    border: OutlineInputBorder(),
                    helperText: 'Shown to users when viewing their reward',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Terms & conditions
                TextFormField(
                  controller: _termsController,
                  decoration: const InputDecoration(
                    labelText: 'Terms & Conditions',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // A/B Testing section
                _buildAbTestSection(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isEditing ? 'Update' : 'Create'),
        ),
      ],
    );
  }
}

// =============================================================================
// Import Codes Dialog
// =============================================================================

class _ImportCodesDialog extends StatefulWidget {
  final Map<String, dynamic> campaign;
  final VoidCallback onImported;

  const _ImportCodesDialog({
    required this.campaign,
    required this.onImported,
  });

  @override
  State<_ImportCodesDialog> createState() => _ImportCodesDialogState();
}

class _ImportCodesDialogState extends State<_ImportCodesDialog> {
  List<String> _codes = [];
  int _duplicates = 0;
  bool _isImporting = false;
  bool _isParsed = false;
  String? _fileName;
  String? _error;
  int _importedCount = 0;
  int _totalBatches = 0;
  int _completedBatches = 0;

  bool get _isDigitalContent =>
      widget.campaign['rewardType'] == 'digital_content';

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'txt'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      _fileName = file.name;

      final content = utf8.decode(file.bytes!);
      final lines = content
          .split('\n')
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .toList();

      // Skip header row if it looks like a header
      final startIndex = lines.isNotEmpty &&
              (lines[0].toLowerCase().contains('code') ||
                  lines[0].toLowerCase().contains('url'))
          ? 1
          : 0;

      final codes = <String>{};
      final dupes = <String>{};

      for (var i = startIndex; i < lines.length; i++) {
        final columns = lines[i].split(',').map((c) => c.trim()).toList();
        final col1 = columns.isNotEmpty ? columns[0] : '';
        if (col1.isEmpty) continue;

        String code;
        if (_isDigitalContent) {
          // Digital Content: col1 = URL, col2 = access code (optional)
          final col2 = columns.length > 1 ? columns[1] : '';
          final payload = <String, String>{'url': col1};
          if (col2.isNotEmpty) payload['accessCode'] = col2;
          code = jsonEncode(payload);
        } else {
          code = col1;
        }

        if (!codes.add(code)) {
          dupes.add(col1.length > 6 ? '${col1.substring(0, 6)}...' : col1);
        }
      }

      setState(() {
        _codes = codes.toList();
        _duplicates = dupes.length;
        _isParsed = true;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Error reading file: $e';
        _isParsed = false;
      });
    }
  }

  Future<void> _import() async {
    if (_codes.isEmpty) return;

    setState(() {
      _isImporting = true;
      _importedCount = 0;
    });

    try {
      // Batch in groups of 500
      const batchSize = 500;
      final batches = <List<String>>[];
      for (var i = 0; i < _codes.length; i += batchSize) {
        batches.add(_codes.sublist(
          i,
          i + batchSize > _codes.length ? _codes.length : i + batchSize,
        ));
      }

      _totalBatches = batches.length;
      _completedBatches = 0;

      final fn =
          FirebaseFunctions.instanceFor(region: 'africa-south1').httpsCallable('importRewardItems');

      for (final batch in batches) {
        await fn.call({
          'campaignId': widget.campaign['id'],
          'codes': batch.map((c) => {'code': c}).toList(),
        });
        setState(() {
          _completedBatches++;
          _importedCount += batch.length;
        });
      }

      if (mounted) {
        Navigator.of(context).pop();
        widget.onImported();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Imported $_importedCount items successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isImporting = false;
          _error = 'Import error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _isDigitalContent
        ? 'Import Digital Content — ${widget.campaign['name']}'
        : 'Import Codes — ${widget.campaign['name']}';

    final description = _isDigitalContent
        ? 'Upload a CSV with URL in column 1 and access code in column 2 (optional).\n'
            'Example: https://example.com/download/abc,ACCESS-CODE-123'
        : 'Upload a CSV or TXT file with one code per line (or first column).';

    final previewLabel = _isDigitalContent
        ? '${_codes.length} valid items found'
        : '${_codes.length} valid codes found';

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            // File picker
            OutlinedButton.icon(
              onPressed: _isImporting ? null : _pickFile,
              icon: const Icon(Icons.upload_file),
              label: Text(_fileName ?? 'Choose File'),
            ),
            const SizedBox(height: 16),

            // Preview
            if (_isParsed) ...[
              Text(
                previewLabel,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (_duplicates > 0)
                Text(
                  '$_duplicates duplicates removed',
                  style: TextStyle(color: AppColors.warning),
                ),
            ],

            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: AppColors.error)),
            ],

            // Import progress
            if (_isImporting) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _totalBatches > 0
                    ? _completedBatches / _totalBatches
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                'Importing batch $_completedBatches of $_totalBatches ($_importedCount items)',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isImporting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:
              _isParsed && _codes.isNotEmpty && !_isImporting ? _import : null,
          child: _isImporting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Import'),
        ),
      ],
    );
  }
}

// =============================================================================
// A/B Variant helper class
// =============================================================================

class _AbVariant {
  String name;
  int weight;
  _AbVariant({required this.name, required this.weight});
}

// =============================================================================
// Stat Card (reusable)
// =============================================================================

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
