import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class BrandStorefrontManagementScreen extends StatefulWidget {
  const BrandStorefrontManagementScreen({super.key});

  @override
  State<BrandStorefrontManagementScreen> createState() =>
      _BrandStorefrontManagementScreenState();
}

class _BrandStorefrontManagementScreenState
    extends State<BrandStorefrontManagementScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _storefronts = [];

  @override
  void initState() {
    super.initState();
    _loadStorefronts();
  }

  Future<void> _loadStorefronts() async {
    setState(() => _isLoading = true);
    try {
      final result =
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminListBrandStorefronts')
              .call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      final list = (data?['storefronts'] as List<dynamic>?) ?? [];
      if (mounted) {
        setState(() {
          _storefronts = list.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      }
    } catch (e) {
      // Fallback: direct Firestore read
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('brandStorefronts')
            .get();
        if (mounted) {
          setState(() {
            _storefronts = snapshot.docs.map((d) {
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

  @override
  Widget build(BuildContext context) {
    final active =
        _storefronts.where((s) => s['isActive'] == true).length;
    final premium =
        _storefronts.where((s) => s['isPremium'] == true).length;

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
                      'Brand Storefronts',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage branded storefront pages',
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
                      icon: const Icon(Icons.refresh,
                          color: AppColors.textPrimary),
                      onPressed: _loadStorefronts,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Create Storefront'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _showStorefrontDialog(null),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatCard(
                  icon: Icons.storefront,
                  color: AppColors.secondary,
                  title: 'Total',
                  value: '${_storefronts.length}',
                ),
                _StatCard(
                  icon: Icons.check_circle,
                  color: AppColors.success,
                  title: 'Active',
                  value: '$active',
                ),
                _StatCard(
                  icon: Icons.star,
                  color: AppColors.gold,
                  title: 'Premium',
                  value: '$premium',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table header
            _buildTableHeader(),
            const Divider(color: AppColors.borderDark, height: 1),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _storefronts.isEmpty
                      ? const Center(
                          child: Text(
                            'No storefronts configured yet',
                            style:
                                TextStyle(color: AppColors.textTertiary),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _storefronts.length,
                          separatorBuilder: (_, __) => Divider(
                            color: AppColors.borderDark,
                            height: 1,
                          ),
                          itemBuilder: (_, i) =>
                              _buildRow(_storefronts[i]),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          Expanded(
              flex: 3,
              child: Text('Brand',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          Expanded(
              flex: 2,
              child: Text('Sections',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          Expanded(
              child: Text('Premium',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          Expanded(
              child: Text('Status',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12))),
          SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> sf) {
    final isActive = sf['isActive'] == true;
    final isPremium = sf['isPremium'] == true;
    final sections = (sf['sections'] as List<dynamic>?)?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Brand name + ID
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sf['brandName'] as String? ?? 'Unknown',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  sf['tagline'] as String? ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          // Sections count
          Expanded(
            flex: 2,
            child: Text(
              '$sections section${sections != 1 ? 's' : ''}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // Premium
          Expanded(
            child: isPremium
                ? const Icon(Icons.star, color: AppColors.gold, size: 18)
                : const Text('—',
                    style: TextStyle(color: AppColors.textTertiary)),
          ),
          // Status
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                  color:
                      isActive ? AppColors.success : AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert,
                color: AppColors.textSecondary),
            color: AppColors.cardDark,
            onSelected: (action) => _onAction(action, sf),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(
                value: 'toggle',
                child: Text(isActive ? 'Deactivate' : 'Activate'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete',
                    style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onAction(String action, Map<String, dynamic> sf) async {
    switch (action) {
      case 'edit':
        _showStorefrontDialog(sf);
      case 'toggle':
        try {
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminUpdateBrandStorefront')
              .call<dynamic>({
            'storefrontId': sf['id'],
            'isActive': !(sf['isActive'] == true),
          });
          _loadStorefronts();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: $e')),
            );
          }
        }
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text('Delete Storefront?'),
            content: Text(
                'Delete "${sf['brandName']}" storefront? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
        try {
          await FirebaseFunctions.instanceFor(region: 'africa-south1')
              .httpsCallable('adminDeleteBrandStorefront')
              .call<dynamic>({'storefrontId': sf['id']});
          _loadStorefronts();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: $e')),
            );
          }
        }
    }
  }

  void _showStorefrontDialog(Map<String, dynamic>? existing) {
    final isEdit = existing != null;
    final formKey = GlobalKey<FormState>();
    final brandNameCtrl =
        TextEditingController(text: existing?['brandName'] as String? ?? '');
    final brandIdCtrl =
        TextEditingController(text: existing?['brandId'] as String? ?? '');
    final taglineCtrl =
        TextEditingController(text: existing?['tagline'] as String? ?? '');
    final logoUrlCtrl =
        TextEditingController(text: existing?['brandLogoUrl'] as String? ?? '');
    final coverUrlCtrl = TextEditingController(
        text: existing?['coverImageUrl'] as String? ?? '');
    final brandColorCtrl =
        TextEditingController(text: existing?['brandColor'] as String? ?? '');
    var isActive = existing?['isActive'] as bool? ?? true;
    var isPremium = existing?['isPremium'] as bool? ?? false;
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(isEdit ? 'Edit Storefront' : 'Create Storefront'),
            content: SizedBox(
              width: 480,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: brandNameCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Brand Name *'),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: brandIdCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Brand ID *'),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: taglineCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Tagline'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: logoUrlCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Logo URL'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: coverUrlCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Cover Image URL'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: brandColorCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Brand Color (hex, e.g. #E60000)'),
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        value: isActive,
                        title: const Text('Active'),
                        onChanged: (v) =>
                            setInnerState(() => isActive = v),
                      ),
                      SwitchListTile(
                        value: isPremium,
                        title: const Text('Premium'),
                        subtitle: const Text(
                            'Premium brands appear first with gold border'),
                        onChanged: (v) =>
                            setInnerState(() => isPremium = v),
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
                              ? 'adminUpdateBrandStorefront'
                              : 'adminCreateBrandStorefront';
                          final data = <String, dynamic>{
                            if (isEdit) 'storefrontId': existing['id'],
                            'brandName': brandNameCtrl.text.trim(),
                            'brandId': brandIdCtrl.text.trim(),
                            'tagline': taglineCtrl.text.trim().isEmpty
                                ? null
                                : taglineCtrl.text.trim(),
                            'brandLogoUrl': logoUrlCtrl.text.trim().isEmpty
                                ? null
                                : logoUrlCtrl.text.trim(),
                            'coverImageUrl':
                                coverUrlCtrl.text.trim().isEmpty
                                    ? null
                                    : coverUrlCtrl.text.trim(),
                            'brandColor':
                                brandColorCtrl.text.trim().isEmpty
                                    ? null
                                    : brandColorCtrl.text.trim(),
                            'isActive': isActive,
                            'isPremium': isPremium,
                          };
                          await FirebaseFunctions.instanceFor(
                                  region: 'africa-south1')
                              .httpsCallable(fn)
                              .call<dynamic>(data);
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadStorefronts();
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
                        child:
                            CircularProgressIndicator(strokeWidth: 2),
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
