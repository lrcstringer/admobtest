import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/image_resize_utils.dart';
import '../../../domain/entities/purchase.dart';
import '../../theme/app_colors.dart';
import '../widgets/svg_aware_image.dart';

/// Admin screen for managing VAS (Value Added Services) providers.
///
/// Route: `/buy-vas-providers`
class VasProviderManagementScreen extends StatefulWidget {
  const VasProviderManagementScreen({super.key});

  @override
  State<VasProviderManagementScreen> createState() =>
      _VasProviderManagementScreenState();
}

class _VasProviderManagementScreenState
    extends State<VasProviderManagementScreen> {
  bool _isLoading = false;
  bool _isSeeding = false;
  List<Map<String, dynamic>> _providers = [];

  FirebaseFunctions get _functions =>
      FirebaseFunctions.instanceFor(region: 'africa-south1');

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    setState(() => _isLoading = true);
    try {
      final result = await _functions
          .httpsCallable('adminListVasProviders')
          .call({'includeInactive': true});
      final list = (result.data['providers'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      if (mounted) {
        setState(() {
          _providers = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading providers: $e')),
        );
      }
    }
  }

  int get _activeCount =>
      _providers.where((p) => p['isActive'] == true).length;

  @override
  Widget build(BuildContext context) {
    final active = _activeCount;
    final inactive = _providers.length - active;

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
                          Text('VAS Providers',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(
                            'Manage service providers (Vodacom, Eskom, etc.)',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _isSeeding ? null : _seedDefaults,
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
                            onPressed: _loadProviders,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () => _showCreateEditDialog(null),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Provider'),
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
                          value: '${_providers.length}',
                          icon: Icons.electrical_services,
                          color: AppColors.secondary),
                      _StatCard(
                          title: 'Active',
                          value: '$active',
                          icon: Icons.check_circle,
                          color: AppColors.success),
                      _StatCard(
                          title: 'Inactive',
                          value: '$inactive',
                          icon: Icons.cancel,
                          color: AppColors.error),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Table
                  _buildTableHeader(),
                  ..._providers.map(_buildProviderRow),

                  if (_providers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.electrical_services,
                                size: 48,
                                color: AppColors.textTertiary),
                            const SizedBox(height: 12),
                            Text(
                              'No VAS providers yet',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Use "Seed Defaults" to create standard South African providers',
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
          _headerCell('Name', flex: 2),
          _headerCell('Code', flex: 1),
          _headerCell('Category', flex: 1),
          _headerCell('Products', flex: 1),
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

  Widget _buildProviderRow(Map<String, dynamic> provider) {
    final isActive = provider['isActive'] == true;
    final productCount = provider['productCount'] ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (provider['logoUrl'] != null &&
                    (provider['logoUrl'] as String).isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: svgAwareNetworkImage(
                      provider['logoUrl'] as String,
                      width: 32,
                      height: 32,
                      errorBuilder: (_, _, _) => Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.borderDark,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.image_not_supported,
                            size: 16, color: AppColors.textTertiary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ] else ...[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.borderDark,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.electrical_services,
                        size: 16, color: AppColors.textTertiary),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider['name'] as String? ?? '—',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      if (provider['description'] != null)
                        Text(provider['description'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(provider['code'] as String? ?? '—',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'monospace',
                    color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Text(
                _categoryLabel(provider['category'] as String? ?? ''),
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child:
                Text('$productCount', style: const TextStyle(fontSize: 14)),
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
              icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
              onSelected: (value) {
                switch (value) {
                  case 'products':
                    context.push(
                        '/buy-vas-products?providerId=${provider['id']}');
                  case 'edit':
                    _showCreateEditDialog(provider);
                  case 'toggle':
                    _toggleProvider(provider);
                  case 'delete':
                    _deleteProvider(provider);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'products',
                  child: Row(children: [
                    Icon(Icons.inventory_2, size: 18),
                    SizedBox(width: 8),
                    Text('View Products'),
                  ]),
                ),
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
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(children: [
                    Icon(Icons.delete_outline, size: 18),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Actions ────────────────────────────────────────

  Future<void> _toggleProvider(Map<String, dynamic> provider) async {
    try {
      await _functions.httpsCallable('adminToggleVasProvider').call({
        'providerId': provider['id'],
      });
      _loadProviders();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _deleteProvider(Map<String, dynamic> provider) async {
    final name = provider['name'] as String? ?? 'this provider';
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Delete Provider', style: TextStyle(fontSize: 16)),
        content: Text(
          'Are you sure you want to delete "$name"?',
          style: const TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await _functions.httpsCallable('adminDeleteVasProvider').call({
        'providerId': provider['id'],
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provider deleted')),
        );
        _loadProviders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _seedDefaults() async {
    setState(() => _isSeeding = true);
    try {
      final result = await _functions
          .httpsCallable('adminSeedVasProviders')
          .call<dynamic>({});
      final data = result.data as Map<String, dynamic>;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Seeded: ${data['createdCount']} created, '
              '${data['skippedCount']} skipped',
            ),
          ),
        );
        _loadProviders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seed error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSeeding = false);
    }
  }

  // ─── Create / Edit Dialog ──────────────────────────

  void _showCreateEditDialog(Map<String, dynamic>? existing) {
    final isEdit = existing != null;
    final nameCtrl =
        TextEditingController(text: existing?['name'] as String? ?? '');
    final codeCtrl =
        TextEditingController(text: existing?['code'] as String? ?? '');
    final descCtrl = TextEditingController(
        text: existing?['description'] as String? ?? '');
    final sortCtrl =
        TextEditingController(text: '${existing?['sortOrder'] ?? 0}');
    var selectedCategory = existing?['category'] as String? ?? 'airtime';
    var isActive = existing?['isActive'] as bool? ?? true;
    final formKey = GlobalKey<FormState>();
    var saving = false;

    // Logo state
    final existingLogoUrl = existing?['logoUrl'] as String?;
    Uint8List? pickedLogoBytes;
    String? pickedLogoName;
    double uploadProgress = 0;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(isEdit ? 'Edit Provider' : 'Add Provider'),
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
                        controller: codeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Code',
                          hintText: 'e.g. vodacom, eskom',
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Required';
                          }
                          if (!RegExp(r'^[a-z0-9_-]+$').hasMatch(v)) {
                            return 'Lowercase, numbers, hyphens, underscores only';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                        ),
                        items: PurchaseCategory.values
                            .map((c) => DropdownMenuItem(
                                  value: c.name,
                                  child: Text(_categoryLabel(c.name)),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setInnerState(() => selectedCategory = v);
                          }
                        },
                      ),
                      const SizedBox(height: 12),

                      // Logo picker
                      InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Logo',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        child: Column(
                          children: [
                            // Preview
                            if (pickedLogoBytes != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: svgAwareMemoryImage(
                                  pickedLogoBytes!,
                                  fileName: pickedLogoName,
                                  width: 80,
                                  height: 80,
                                ),
                              )
                            else if (existingLogoUrl != null &&
                                existingLogoUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: svgAwareNetworkImage(
                                  existingLogoUrl,
                                  width: 80,
                                  height: 80,
                                  errorBuilder: (_, _, _) => Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: AppColors.borderDark,
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.broken_image,
                                        color: AppColors.textTertiary),
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.borderDark,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.image_outlined,
                                    color: AppColors.textTertiary,
                                    size: 32),
                              ),
                            const SizedBox(height: 8),
                            if (pickedLogoName != null)
                              Text(
                                pickedLogoName!,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textTertiary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            const SizedBox(height: 4),
                            TextButton.icon(
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions:
                                      adminImageExtensions,
                                  withData: true,
                                );
                                if (result != null &&
                                    result.files.single.bytes != null) {
                                  setInnerState(() {
                                    pickedLogoBytes =
                                        result.files.single.bytes;
                                    pickedLogoName =
                                        result.files.single.name;
                                  });
                                }
                              },
                              icon: const Icon(Icons.upload, size: 16),
                              label: Text(pickedLogoBytes != null ||
                                      (existingLogoUrl != null &&
                                          existingLogoUrl.isNotEmpty)
                                  ? 'Change Logo'
                                  : 'Select Logo'),
                            ),
                            if (saving && uploadProgress > 0 &&
                                uploadProgress < 1)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: LinearProgressIndicator(
                                    value: uploadProgress),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Description'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Sort Order'),
                        keyboardType: TextInputType.number,
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
                          // Upload logo if a new image was picked
                          String? logoUrl = existingLogoUrl;
                          if (pickedLogoBytes != null) {
                            final providerId = isEdit
                                ? existing['id'] as String
                                : codeCtrl.text.trim();
                            logoUrl = await uploadAdminImage(
                              bytes: pickedLogoBytes!,
                              fileName: pickedLogoName,
                              storagePath: 'vas_provider_logos',
                              fileId: providerId,
                              resizeTarget:
                                  ImageResizeTarget.clientLogo,
                              onProgress: (p) {
                                if (ctx.mounted) {
                                  setInnerState(
                                      () => uploadProgress = p);
                                }
                              },
                            );
                          }

                          final fn = isEdit
                              ? 'adminUpdateVasProvider'
                              : 'adminCreateVasProvider';
                          final data = {
                            if (isEdit)
                              'providerId': existing['id'] as String,
                            'name': nameCtrl.text.trim(),
                            'code': codeCtrl.text.trim(),
                            'category': selectedCategory,
                            if (logoUrl != null && logoUrl.isNotEmpty)
                              'logoUrl': logoUrl,
                            if (descCtrl.text.trim().isNotEmpty)
                              'description': descCtrl.text.trim(),
                            'sortOrder':
                                int.tryParse(sortCtrl.text.trim()) ?? 0,
                            'isActive': isActive,
                          };
                          await _functions
                              .httpsCallable(fn)
                              .call(data);
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadProviders();
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
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(isEdit ? 'Save' : 'Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────

  String _categoryLabel(String category) {
    switch (category) {
      case 'airtime':
        return 'Airtime';
      case 'data':
        return 'Data';
      case 'electricity':
        return 'Electricity';
      case 'voucher':
        return 'Vouchers';
      case 'school':
        return 'School';
      case 'municipal':
        return 'Municipal';
      case 'insurance':
        return 'Insurance';
      case 'funeral':
        return 'Funeral';
      case 'stokvel':
        return 'Stokvel';
      case 'gaming':
        return 'Gaming';
      case 'other':
        return 'Other';
      default:
        return category;
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
