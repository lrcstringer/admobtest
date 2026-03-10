import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing Buy categories (VAS + coming soon).
class BuyCategoryManagementScreen extends StatefulWidget {
  const BuyCategoryManagementScreen({super.key});

  @override
  State<BuyCategoryManagementScreen> createState() =>
      _BuyCategoryManagementScreenState();
}

class _BuyCategoryManagementScreenState
    extends State<BuyCategoryManagementScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('buyCategories')
          .orderBy('sortOrder')
          .get();
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
      if (mounted) setState(() { _categories = list; _isLoading = false; });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading categories: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = _categories.where((c) => c['isActive'] == true).length;
    final comingSoon =
        _categories.where((c) => c['isComingSoon'] == true).length;
    final inactive = _categories.length - active - comingSoon;

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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Buy Categories',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Manage VAS and marketplace categories',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: _loadCategories,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _showCreateDialog,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Category'),
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

                  // Stats
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _StatCard(
                          title: 'Total',
                          value: '${_categories.length}',
                          icon: Icons.category,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Active',
                          value: '$active',
                          icon: Icons.check_circle,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Coming Soon',
                          value: '$comingSoon',
                          icon: Icons.schedule,
                          color: AppColors.warning),
                      _StatCard(
                          title: 'Inactive',
                          value: '$inactive',
                          icon: Icons.block,
                          color: AppColors.error),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Table
                  _buildTableHeader(),
                  ..._categories.map(_buildCategoryRow),
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
          _headerCell('Icon', flex: 1),
          _headerCell('Name', flex: 2),
          _headerCell('Sort Order', flex: 1),
          _headerCell('VAS Mapping', flex: 2),
          _headerCell('Status', flex: 1),
          _headerCell('Actions', flex: 1),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(text,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary)),
    );
  }

  Widget _buildCategoryRow(Map<String, dynamic> cat) {
    final isActive = cat['isActive'] == true;
    final isComingSoon = cat['isComingSoon'] == true;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(cat['iconEmoji'] ?? '',
                style: const TextStyle(fontSize: 24)),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(cat['name'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                    ),
                    if ((cat['subcategories'] as List?)?.isNotEmpty ==
                        true) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color:
                              AppColors.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${(cat['subcategories'] as List).length} subs',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (cat['id'] != null)
                  Text(cat['id'],
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('${cat['sortOrder'] ?? 0}',
                style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 2,
            child: Text(cat['purchaseCategoryMapping'] ?? '—',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.success.withValues(alpha: 0.15)
                    : isComingSoon
                        ? AppColors.warning.withValues(alpha: 0.15)
                        : AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActive
                    ? 'Active'
                    : isComingSoon
                        ? 'Coming Soon'
                        : 'Inactive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? AppColors.success
                      : isComingSoon
                          ? AppColors.warning
                          : AppColors.error,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert,
                  color: AppColors.textSecondary),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditDialog(cat);
                  case 'toggle':
                    _toggleCategory(cat);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(children: [
                    Icon(Icons.edit, size: 18),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ]),
                ),
                PopupMenuItem(
                  value: 'toggle',
                  child: Row(children: [
                    Icon(isActive ? Icons.visibility_off : Icons.visibility,
                        size: 18),
                    const SizedBox(width: 8),
                    Text(isActive ? 'Deactivate' : 'Activate'),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleCategory(Map<String, dynamic> cat) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminToggleBuyCategory')
          .call({
        'categoryId': cat['id'],
        'isActive': !(cat['isActive'] == true),
      });
      _loadCategories();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showSubcategoryDialog({
    required BuildContext context,
    required List<Map<String, String>> subcategories,
    required StateSetter setParentState,
    int? editIndex,
  }) {
    final isSubEdit = editIndex != null;
    final existing = isSubEdit ? subcategories[editIndex] : null;
    final idCtrl = TextEditingController(text: existing?['id'] ?? '');
    final nameCtrl = TextEditingController(text: existing?['name'] ?? '');
    final emojiCtrl =
        TextEditingController(text: existing?['iconEmoji'] ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(isSubEdit ? 'Edit Subcategory' : 'Add Subcategory'),
        content: SizedBox(
          width: 350,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idCtrl,
                  enabled: !isSubEdit,
                  decoration: const InputDecoration(
                    labelText: 'ID (kebab-case slug)',
                    hintText: 'e.g. hair-styling',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    if (RegExp(r'[^a-z0-9\-]').hasMatch(v.trim())) {
                      return 'Use lowercase letters, numbers, hyphens only';
                    }
                    if (!isSubEdit &&
                        subcategories.any((s) => s['id'] == v.trim())) {
                      return 'ID already exists';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nameCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Display Name'),
                  validator: (v) =>
                      v?.trim().isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emojiCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Emoji (optional)'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              final entry = {
                'id': idCtrl.text.trim(),
                'name': nameCtrl.text.trim(),
                'iconEmoji': emojiCtrl.text.trim(),
              };
              setParentState(() {
                if (isSubEdit) {
                  subcategories[editIndex] = entry;
                } else {
                  subcategories.add(entry);
                }
              });
              Navigator.of(ctx).pop();
            },
            child: Text(isSubEdit ? 'Save' : 'Add'),
          ),
        ],
      ),
    );
  }

  void _showCreateDialog() {
    _showCategoryDialog(null);
  }

  void _showEditDialog(Map<String, dynamic> cat) {
    _showCategoryDialog(cat);
  }

  void _showCategoryDialog(Map<String, dynamic>? existing) {
    final isEdit = existing != null;
    final nameCtrl =
        TextEditingController(text: existing?['name'] ?? '');
    final emojiCtrl =
        TextEditingController(text: existing?['iconEmoji'] ?? '');
    final sortCtrl = TextEditingController(
        text: '${existing?['sortOrder'] ?? 0}');
    final logoUrlCtrl =
        TextEditingController(text: existing?['logoUrl'] ?? '');
    final bgColorCtrl =
        TextEditingController(text: existing?['backgroundColor'] ?? '');
    var isActive = existing?['isActive'] ?? true;
    var isComingSoon = existing?['isComingSoon'] ?? false;
    var mapping = existing?['purchaseCategoryMapping'] ?? '';
    var featureFlagKey = existing?['featureFlagKey'] ?? '';
    final formKey = GlobalKey<FormState>();
    var saving = false;
    var subcategories = List<Map<String, String>>.from(
      (existing?['subcategories'] as List<dynamic>?)?.map((s) {
            final m = Map<String, dynamic>.from(s as Map);
            return {
              'id': (m['id'] ?? '') as String,
              'name': (m['name'] ?? '') as String,
              'iconEmoji': (m['iconEmoji'] ?? m['emoji'] ?? '') as String,
            };
          }).toList() ??
          [],
    );

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(isEdit ? 'Edit Category' : 'Create Category'),
            content: SizedBox(
              width: 450,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Name'),
                        validator: (v) =>
                            v?.trim().isEmpty == true ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: emojiCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Icon Emoji (e.g. \u{1F4F1})'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Sort Order'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: logoUrlCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Logo URL (optional)'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: bgColorCtrl,
                        decoration: const InputDecoration(
                            labelText:
                                'Background Color Hex (optional, e.g. #FF0000)'),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: mapping.isEmpty ? null : mapping,
                        decoration: const InputDecoration(
                            labelText: 'VAS Category Mapping'),
                        items: const [
                          DropdownMenuItem(
                              value: 'airtime', child: Text('Airtime')),
                          DropdownMenuItem(
                              value: 'data', child: Text('Data')),
                          DropdownMenuItem(
                              value: 'electricity',
                              child: Text('Electricity')),
                          DropdownMenuItem(
                              value: 'voucher', child: Text('Voucher')),
                          DropdownMenuItem(
                              value: 'other', child: Text('Other')),
                        ],
                        onChanged: (v) =>
                            setInnerState(() => mapping = v ?? ''),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: featureFlagKey,
                        decoration: const InputDecoration(
                            labelText: 'Feature Flag Key (optional)'),
                        onChanged: (v) => featureFlagKey = v,
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Active'),
                        value: isActive,
                        onChanged: (v) =>
                            setInnerState(() => isActive = v),
                      ),
                      SwitchListTile(
                        title: const Text('Coming Soon'),
                        value: isComingSoon,
                        onChanged: (v) =>
                            setInnerState(() => isComingSoon = v),
                      ),
                      const Divider(height: 32),
                      // ── Subcategories section ──
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subcategories (${subcategories.length})',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline,
                                size: 20),
                            onPressed: () => _showSubcategoryDialog(
                              context: ctx,
                              subcategories: subcategories,
                              setParentState: setInnerState,
                            ),
                          ),
                        ],
                      ),
                      if (subcategories.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'No subcategories',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        )
                      else
                        ...subcategories.asMap().entries.map((entry) {
                          final i = entry.key;
                          final sub = entry.value;
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              sub['iconEmoji']?.isNotEmpty == true
                                  ? sub['iconEmoji']!
                                  : '•',
                              style: const TextStyle(fontSize: 18),
                            ),
                            title: Text(sub['name'] ?? '',
                                style: const TextStyle(fontSize: 13)),
                            subtitle: Text(sub['id'] ?? '',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textTertiary)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      size: 16),
                                  onPressed: () =>
                                      _showSubcategoryDialog(
                                    context: ctx,
                                    subcategories: subcategories,
                                    setParentState: setInnerState,
                                    editIndex: i,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 16,
                                      color: AppColors.error),
                                  onPressed: () {
                                    setInnerState(() {
                                      subcategories.removeAt(i);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                    ],
                  ),
                ),
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
                        if (!formKey.currentState!.validate()) return;
                        setInnerState(() => saving = true);
                        try {
                          final fn = isEdit
                              ? 'adminUpdateBuyCategory'
                              : 'adminCreateBuyCategory';
                          final data = {
                            if (isEdit) 'categoryId': existing['id'],
                            'name': nameCtrl.text.trim(),
                            'iconEmoji': emojiCtrl.text.trim(),
                            'sortOrder':
                                int.tryParse(sortCtrl.text.trim()) ?? 0,
                            'isActive': isActive,
                            'isComingSoon': isComingSoon,
                            'purchaseCategoryMapping': mapping,
                            'featureFlagKey': featureFlagKey,
                            'logoUrl': logoUrlCtrl.text.trim(),
                            'backgroundColor': bgColorCtrl.text.trim(),
                            'subcategories': subcategories,
                          };
                          await FirebaseFunctions.instanceFor(
                                  region: 'africa-south1')
                              .httpsCallable(fn)
                              .call(data);
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadCategories();
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
                        child:
                            CircularProgressIndicator(strokeWidth: 2))
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
