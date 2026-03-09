import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class FeaturedContentManagementScreen extends StatefulWidget {
  const FeaturedContentManagementScreen({super.key});

  @override
  State<FeaturedContentManagementScreen> createState() =>
      _FeaturedContentManagementScreenState();
}

class _FeaturedContentManagementScreenState
    extends State<FeaturedContentManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadItems();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadItems() async {
    setState(() => _isLoading = true);
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListFeaturedItems')
          .call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      final list = (data?['items'] as List<dynamic>?) ?? [];
      if (mounted) {
        setState(() {
          _items = list.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      }
    } catch (e) {
      // Fallback: direct Firestore read
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('featuredItems')
            .orderBy('sortOrder')
            .get();
        if (mounted) {
          setState(() {
            _items = snapshot.docs.map((d) {
              final data = d.data();
              data['id'] = d.id;
              return data;
            }).toList();
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  List<Map<String, dynamic>> get _activeItems =>
      _items.where((i) => i['isActive'] == true).toList();

  List<Map<String, dynamic>> get _scheduledItems =>
      _items.where((i) {
        final start = i['scheduledStart'];
        if (start == null) return false;
        final startDate = start is Timestamp ? start.toDate() : DateTime.tryParse(start.toString());
        return startDate != null && startDate.isAfter(DateTime.now()) && i['isActive'] != true;
      }).toList();

  List<Map<String, dynamic>> get _expiredItems =>
      _items.where((i) {
        final end = i['scheduledEnd'];
        if (end == null) return i['isActive'] != true;
        final endDate = end is Timestamp ? end.toDate() : DateTime.tryParse(end.toString());
        return endDate != null && endDate.isBefore(DateTime.now());
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Padding(
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
                    const Text(
                      'Featured Content',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage featured carousel items & campaigns',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
                      onPressed: _loadItems,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Create Item'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _showItemDialog(null),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats
            _buildStats(),
            const SizedBox(height: 20),

            // Tabs
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textTertiary,
              tabs: [
                Tab(text: 'Active (${_activeItems.length})'),
                Tab(text: 'Scheduled (${_scheduledItems.length})'),
                Tab(text: 'Expired (${_expiredItems.length})'),
              ],
            ),
            const SizedBox(height: 16),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildItemList(_activeItems),
                        _buildItemList(_scheduledItems),
                        _buildItemList(_expiredItems),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _StatCard(
          icon: Icons.star,
          color: AppColors.success,
          title: 'Active',
          value: '${_activeItems.length}',
        ),
        _StatCard(
          icon: Icons.schedule,
          color: AppColors.secondary,
          title: 'Scheduled',
          value: '${_scheduledItems.length}',
        ),
        _StatCard(
          icon: Icons.inventory_2,
          color: AppColors.textTertiary,
          title: 'Total',
          value: '${_items.length}',
        ),
      ],
    );
  }

  Widget _buildItemList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No items in this category',
          style: TextStyle(color: AppColors.textTertiary),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(
        color: AppColors.borderDark,
        height: 1,
      ),
      itemBuilder: (context, index) => _buildItemRow(items[index]),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    final isActive = item['isActive'] == true;
    final type = item['type'] as String? ?? 'campaign';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.image, color: AppColors.textTertiary, size: 20),
          ),
          const SizedBox(width: 12),
          // Title + type
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String? ?? 'Untitled',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          // Sort order
          Expanded(
            child: Text(
              '#${item['sortOrder'] ?? 0}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // Status
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.textTertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? 'Active' : 'Inactive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.success : AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            color: AppColors.cardDark,
            onSelected: (action) => _onItemAction(action, item),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(
                value: 'toggle',
                child: Text(isActive ? 'Deactivate' : 'Activate'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onItemAction(String action, Map<String, dynamic> item) async {
    switch (action) {
      case 'edit':
        _showItemDialog(item);
      case 'toggle':
        await _toggleItem(item);
      case 'delete':
        await _deleteItem(item);
    }
  }

  Future<void> _toggleItem(Map<String, dynamic> item) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateFeaturedItem')
          .call<dynamic>({
        'itemId': item['id'],
        'isActive': !(item['isActive'] == true),
      });
      _loadItems();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to toggle: $e')),
        );
      }
    }
  }

  Future<void> _deleteItem(Map<String, dynamic> item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Delete Featured Item?'),
        content: Text('Delete "${item['title']}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminDeleteFeaturedItem')
          .call<dynamic>({'itemId': item['id']});
      _loadItems();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: $e')),
        );
      }
    }
  }

  void _showItemDialog(Map<String, dynamic>? existing) {
    final isEdit = existing != null;
    final formKey = GlobalKey<FormState>();
    final titleCtrl = TextEditingController(text: existing?['title'] as String? ?? '');
    final subtitleCtrl = TextEditingController(text: existing?['subtitle'] as String? ?? '');
    final imageUrlCtrl = TextEditingController(text: existing?['imageUrl'] as String? ?? '');
    final deepLinkCtrl = TextEditingController(text: existing?['deepLinkRoute'] as String? ?? '');
    final sortOrderCtrl = TextEditingController(
        text: (existing?['sortOrder'] ?? 0).toString());
    var type = existing?['type'] as String? ?? 'campaign';
    var bgGradient = existing?['bgGradientType'] as String? ?? 'goldOrange';
    var isActive = existing?['isActive'] as bool? ?? true;
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(isEdit ? 'Edit Featured Item' : 'Create Featured Item'),
            content: SizedBox(
              width: 480,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleCtrl,
                        decoration: const InputDecoration(labelText: 'Title *'),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: subtitleCtrl,
                        decoration: const InputDecoration(labelText: 'Subtitle'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: imageUrlCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration: const InputDecoration(labelText: 'Type'),
                        items: const [
                          DropdownMenuItem(value: 'campaign', child: Text('Campaign')),
                          DropdownMenuItem(value: 'collectible', child: Text('Collectible')),
                          DropdownMenuItem(value: 'trending', child: Text('Trending')),
                          DropdownMenuItem(value: 'promotion', child: Text('Promotion')),
                        ],
                        onChanged: (v) => setInnerState(() => type = v ?? type),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: bgGradient,
                        decoration:
                            const InputDecoration(labelText: 'Background Gradient'),
                        items: const [
                          DropdownMenuItem(value: 'goldOrange', child: Text('Gold Orange')),
                          DropdownMenuItem(value: 'cyanBlue', child: Text('Cyan Blue')),
                          DropdownMenuItem(value: 'pinkPurple', child: Text('Pink Purple')),
                          DropdownMenuItem(value: 'logo', child: Text('Logo')),
                        ],
                        onChanged: (v) =>
                            setInnerState(() => bgGradient = v ?? bgGradient),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: deepLinkCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Deep Link Route'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortOrderCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Sort Order'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        value: isActive,
                        title: const Text('Active'),
                        onChanged: (v) => setInnerState(() => isActive = v),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: saving
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        setInnerState(() => saving = true);
                        try {
                          final fn = isEdit
                              ? 'adminUpdateFeaturedItem'
                              : 'adminCreateFeaturedItem';
                          final data = <String, dynamic>{
                            if (isEdit) 'itemId': existing['id'],
                            'title': titleCtrl.text.trim(),
                            'subtitle': subtitleCtrl.text.trim().isEmpty
                                ? null
                                : subtitleCtrl.text.trim(),
                            'imageUrl': imageUrlCtrl.text.trim().isEmpty
                                ? null
                                : imageUrlCtrl.text.trim(),
                            'type': type,
                            'bgGradientType': bgGradient,
                            'deepLinkRoute': deepLinkCtrl.text.trim().isEmpty
                                ? null
                                : deepLinkCtrl.text.trim(),
                            'sortOrder':
                                int.tryParse(sortOrderCtrl.text) ?? 0,
                            'isActive': isActive,
                          };
                          await FirebaseFunctions.instanceFor(
                                  region: 'africa-south1')
                              .httpsCallable(fn)
                              .call<dynamic>(data);
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadItems();
                        } catch (e) {
                          setInnerState(() => saving = false);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isEdit ? 'Save' : 'Create'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
