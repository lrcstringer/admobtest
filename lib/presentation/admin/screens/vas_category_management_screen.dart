import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing VAS (Value Added Service) categories.
/// These categories appear under Utilities on the Buy tab.
class VasCategoryManagementScreen extends StatefulWidget {
  const VasCategoryManagementScreen({super.key});

  @override
  State<VasCategoryManagementScreen> createState() =>
      _VasCategoryManagementScreenState();
}

class _VasCategoryManagementScreenState
    extends State<VasCategoryManagementScreen> {
  bool _isLoading = false;
  bool _isSeeding = false;
  List<Map<String, dynamic>> _categories = [];

  FirebaseFunctions get _functions =>
      FirebaseFunctions.instanceFor(region: 'africa-south1');

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('vasCategories')
          .orderBy('sortOrder')
          .get();
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
      if (mounted) {
        setState(() {
          _categories = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading VAS categories: $e')),
        );
      }
    }
  }

  Future<void> _seedCategories() async {
    setState(() => _isSeeding = true);
    try {
      final result = await _functions
          .httpsCallable('adminSeedVasCategories')
          .call<dynamic>({});
      final data = result.data as Map<String, dynamic>;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Seeded: ${data['created']} created, ${data['skipped']} skipped',
            ),
          ),
        );
        _loadCategories();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error seeding: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSeeding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = _categories.where((c) => c['isActive'] == true).length;
    final inactive = _categories.length - active;

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
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
                          Text('VAS Categories',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark)),
                          SizedBox(height: 4),
                          Text(
                              'Manage utility categories shown on the Buy tab',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _isSeeding ? null : _seedCategories,
                            icon: _isSeeding
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2))
                                : const Icon(Icons.auto_fix_high, size: 18),
                            label: const Text('Seed Defaults'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              minimumSize: const Size(0, 40),
                            ),
                          ),
                          const SizedBox(width: 8),
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
                          icon: Icons.bolt,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Active',
                          value: '$active',
                          icon: Icons.check_circle,
                          color: AppColors.success),
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

                  if (_categories.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.bolt_outlined,
                                size: 48,
                                color: AppColors.textTertiary),
                            const SizedBox(height: 12),
                            Text(
                              'No VAS categories yet',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Use "Seed Defaults" to create the 9 standard categories',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textTertiary),
                            ),
                          ],
                        ),
                      ),
                    ),
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
          _headerCell('Purchase Mapping', flex: 2),
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(cat['iconName'] ?? '',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat['name'] ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
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
                    : AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActive ? 'Active' : 'Inactive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.success : AppColors.error,
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
                    Icon(
                        isActive
                            ? Icons.visibility_off
                            : Icons.visibility,
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
      await _functions.httpsCallable('adminToggleVasCategory').call({
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
    final iconNameCtrl =
        TextEditingController(text: existing?['iconName'] ?? '');
    final sortCtrl = TextEditingController(
        text: '${existing?['sortOrder'] ?? 0}');
    var mapping = (existing?['purchaseCategoryMapping'] as String?) ?? '';
    var isActive = existing?['isActive'] ?? true;
    final formKey = GlobalKey<FormState>();
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.adminCard,
            title: Text(isEdit ? 'Edit VAS Category' : 'Create VAS Category'),
            content: SizedBox(
              width: 400,
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
                        controller: iconNameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Icon Name',
                          hintText: 'e.g. phone, wifi, lightning',
                          helperText:
                              'Maps to assets/icons/fintech_complete_icon_set/{name}_light.svg',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Sort Order'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: mapping.isEmpty ? null : mapping,
                        decoration: const InputDecoration(
                          labelText: 'Purchase Category Mapping',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'airtime', child: Text('Airtime')),
                          DropdownMenuItem(value: 'data', child: Text('Data')),
                          DropdownMenuItem(value: 'electricity', child: Text('Electricity')),
                          DropdownMenuItem(value: 'voucher', child: Text('Voucher')),
                          DropdownMenuItem(value: 'school', child: Text('School')),
                          DropdownMenuItem(value: 'municipal', child: Text('Municipal')),
                          DropdownMenuItem(value: 'insurance', child: Text('Insurance')),
                          DropdownMenuItem(value: 'funeral', child: Text('Funeral')),
                          DropdownMenuItem(value: 'stokvel', child: Text('Stokvel')),
                          DropdownMenuItem(value: 'gaming', child: Text('Gaming')),
                          DropdownMenuItem(value: 'other', child: Text('Other')),
                        ],
                        onChanged: (v) =>
                            setInnerState(() => mapping = v ?? ''),
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Active'),
                        value: isActive,
                        onChanged: (v) =>
                            setInnerState(() => isActive = v),
                      ),
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
                              ? 'adminUpdateVasCategory'
                              : 'adminCreateVasCategory';
                          final data = {
                            if (isEdit) 'categoryId': existing['id'],
                            'name': nameCtrl.text.trim(),
                            'iconName': iconNameCtrl.text.trim(),
                            'sortOrder':
                                int.tryParse(sortCtrl.text.trim()) ?? 0,
                            'isActive': isActive,
                            'purchaseCategoryMapping': mapping,
                          };
                          await _functions
                              .httpsCallable(fn)
                              .call(data);
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadCategories();
                        } catch (e) {
                          setInnerState(() => saving = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
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
          Text(value,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
