import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing feature flags that control feature rollout.
class FeatureFlagManagementScreen extends StatefulWidget {
  const FeatureFlagManagementScreen({super.key});

  @override
  State<FeatureFlagManagementScreen> createState() =>
      _FeatureFlagManagementScreenState();
}

class _FeatureFlagManagementScreenState
    extends State<FeatureFlagManagementScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _flags = [];

  @override
  void initState() {
    super.initState();
    _loadFlags();
  }

  Future<void> _loadFlags() async {
    setState(() => _isLoading = true);
    try {
      final result =
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminListFeatureFlags')
              .call();
      final list = (result.data['flags'] as List?)
              ?.map((f) => Map<String, dynamic>.from(f as Map))
              .toList() ??
          [];
      if (mounted) setState(() { _flags = list; _isLoading = false; });
    } catch (_) {
      // Fallback to Firestore direct read
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('featureFlags')
            .get();
        final list = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        if (mounted) setState(() { _flags = list; _isLoading = false; });
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading flags: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabledCount = _flags.where((f) => f['isEnabled'] == true).length;
    final globalCount = _flags
        .where((f) => f['isEnabled'] == true && f['isGlobal'] == true)
        .length;
    final perCommunity = enabledCount - globalCount;
    final disabledCount = _flags.length - enabledCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Feature Flags',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            'Control feature rollout across communities',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: _loadFlags,
                            tooltip: 'Refresh',
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _showSeedDataDialog,
                            icon: const Icon(Icons.download, size: 18),
                            label: const Text('Seed Defaults'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.warning,
                              minimumSize: const Size(0, 40),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _showCreateFlagDialog,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Flag'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: const Size(0, 40),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Stats row
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _StatCard(
                          title: 'Total Flags',
                          value: '${_flags.length}',
                          icon: Icons.flag,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Enabled Globally',
                          value: '$globalCount',
                          icon: Icons.public,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Per-Community',
                          value: '$perCommunity',
                          icon: Icons.groups,
                          color: AppColors.warning),
                      _StatCard(
                          title: 'Disabled',
                          value: '$disabledCount',
                          icon: Icons.block,
                          color: AppColors.error),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Table header
                  _buildTableHeader(),

                  // Table rows
                  ..._flags.map(_buildFlagRow),
                ],
              ),
            ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _headerCell('Feature Key', flex: 3),
          _headerCell('Status', flex: 1),
          _headerCell('Scope', flex: 1),
          _headerCell('Communities', flex: 2),
          _headerCell('Actions', flex: 1),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildFlagRow(Map<String, dynamic> flag) {
    final isEnabled = flag['isEnabled'] == true;
    final isGlobal = flag['isGlobal'] == true;
    final communities =
        (flag['enabledCommunityIds'] as List?)?.cast<String>() ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          // Feature Key
          Expanded(
            flex: 3,
            child: Text(
              flag['featureKey'] ?? flag['id'] ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isEnabled
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isEnabled ? 'Enabled' : 'Disabled',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      isEnabled ? AppColors.success : AppColors.error,
                ),
              ),
            ),
          ),
          // Scope
          Expanded(
            flex: 1,
            child: Text(
              isEnabled ? (isGlobal ? 'Global' : 'Per-Community') : '—',
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary),
            ),
          ),
          // Communities
          Expanded(
            flex: 2,
            child: Text(
              isGlobal
                  ? 'All'
                  : communities.isEmpty
                      ? '—'
                      : communities.join(', '),
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Actions
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Switch(
                  value: isEnabled,
                  onChanged: (value) =>
                      _toggleFlag(flag['id'] ?? flag['featureKey'], value),
                  activeTrackColor: AppColors.success.withValues(alpha: 0.5),
                  activeThumbColor: AppColors.success,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  color: AppColors.textSecondary,
                  onPressed: () => _showEditDialog(flag),
                  tooltip: 'Edit',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFlag(String flagId, bool isEnabled) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateFeatureFlag')
          .call({'flagId': flagId, 'isEnabled': isEnabled});
      _loadFlags();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showEditDialog(Map<String, dynamic> flag) {
    final isGlobal = flag['isGlobal'] == true;
    final communities =
        (flag['enabledCommunityIds'] as List?)?.cast<String>() ?? [];
    var editIsGlobal = isGlobal;
    var editCommunities = List<String>.from(communities);
    final communityController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(
              'Edit: ${flag['featureKey'] ?? flag['id']}',
              style: const TextStyle(fontSize: 18),
            ),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text('Global'),
                    subtitle:
                        const Text('Enable for all communities'),
                    value: editIsGlobal,
                    onChanged: (v) =>
                        setInnerState(() => editIsGlobal = v),
                    activeTrackColor: AppColors.success.withValues(alpha: 0.5),
                  activeThumbColor: AppColors.success,
                  ),
                  if (!editIsGlobal) ...[
                    const SizedBox(height: 12),
                    const Text('Communities',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: communityController,
                            decoration: const InputDecoration(
                              hintText: 'Community ID',
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final id =
                                communityController.text.trim();
                            if (id.isNotEmpty &&
                                !editCommunities.contains(id)) {
                              setInnerState(() {
                                editCommunities.add(id);
                                communityController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: editCommunities.map((c) {
                        return Chip(
                          label: Text(c, style: const TextStyle(fontSize: 12)),
                          onDeleted: () => setInnerState(
                              () => editCommunities.remove(c)),
                          deleteIconColor: AppColors.error,
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseFunctions.instanceFor(
                            region: 'africa-south1')
                        .httpsCallable('adminUpdateFeatureFlag')
                        .call({
                      'flagId': flag['id'] ?? flag['featureKey'],
                      'isGlobal': editIsGlobal,
                      'enabledCommunityIds': editCommunities,
                    });
                    if (ctx.mounted) Navigator.of(ctx).pop();
                    _loadFlags();
                  } catch (e) {
                    if (ctx.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCreateFlagDialog() {
    final keyCtrl = TextEditingController();
    var isEnabled = false;
    var isGlobal = false;
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text('Create Feature Flag'),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: keyCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Feature Key',
                      hintText: 'e.g. buy_new_feature',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Enabled'),
                    value: isEnabled,
                    onChanged: (v) => setInnerState(() => isEnabled = v),
                  ),
                  SwitchListTile(
                    title: const Text('Global'),
                    subtitle: const Text('Enable for all communities'),
                    value: isGlobal,
                    onChanged: (v) => setInnerState(() => isGlobal = v),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: saving ? null : () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: saving
                    ? null
                    : () async {
                        final key = keyCtrl.text.trim();
                        if (key.isEmpty) return;
                        setInnerState(() => saving = true);
                        try {
                          await FirebaseFunctions.instanceFor(
                                  region: 'africa-south1')
                              .httpsCallable('adminCreateFeatureFlag')
                              .call({
                            'featureKey': key,
                            'isEnabled': isEnabled,
                            'isGlobal': isGlobal,
                          });
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadFlags();
                        } catch (e) {
                          setInnerState(() => saving = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                child: saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showSeedDataDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Seed Default Buy Data'),
        content: const Text(
          'This will create default feature flags and buy categories if they don\'t already exist.\n\n'
          'Existing data will NOT be overwritten.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
            ),
            child: const Text('Seed Data'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _isLoading = true);
    try {
      final result =
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminSeedBuyInitialData')
              .call();
      final created = result.data['created'] ?? 0;
      final skipped = result.data['skipped'] ?? 0;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Seeded: $created created, $skipped already existed'),
          ),
        );
      }
      _loadFlags();
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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
      width: 180,
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
          Text(value,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
