import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing VAS products of a specific provider.
///
/// Route: `/buy-vas-products?providerId=xxx`
class VasProductManagementScreen extends StatefulWidget {
  final String providerId;

  const VasProductManagementScreen({super.key, required this.providerId});

  @override
  State<VasProductManagementScreen> createState() =>
      _VasProductManagementScreenState();
}

class _VasProductManagementScreenState
    extends State<VasProductManagementScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _provider;
  List<Map<String, dynamic>> _products = [];

  FirebaseFunctions get _functions =>
      FirebaseFunctions.instanceFor(region: 'africa-south1');

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (widget.providerId.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final provResult =
          await _functions.httpsCallable('adminListVasProviders').call({
        'includeInactive': true,
      });
      final providers = (provResult.data['providers'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      final provider = providers.firstWhere(
        (p) => p['id'] == widget.providerId,
        orElse: () => <String, dynamic>{},
      );

      List<Map<String, dynamic>> products = [];
      try {
        final prodResult =
            await _functions.httpsCallable('adminListVasProducts').call({
          'providerId': widget.providerId,
          'includeInactive': true,
        });
        products = (prodResult.data['products'] as List<dynamic>)
            .cast<Map<String, dynamic>>();
      } catch (e) {
        if (provider['products'] is List) {
          products = (provider['products'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading products: $e')),
          );
        }
      }

      if (mounted) {
        setState(() {
          _provider = provider.isEmpty ? null : provider;
          _products = products;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading products: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = _products.where((p) => p['isActive'] == true).length;
    final inactive = _products.length - active;
    final providerName = _provider?['name'] as String? ?? 'Provider';
    final category = _provider?['category'] as String? ?? '';

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
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$providerName — Products',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark)),
                              const SizedBox(height: 4),
                              Text(
                                  'Category: ${_categoryLabel(category)}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _showBulkPriceDialog,
                            icon:
                                const Icon(Icons.price_change, size: 18),
                            label: const Text('Bulk Price Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              minimumSize: const Size(0, 40),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: _loadData,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () => _showCreateEditDialog(null),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Product'),
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
                          title: 'Total Products',
                          value: '${_products.length}',
                          icon: Icons.inventory_2,
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
                  ..._products.map(_buildProductRow),

                  if (_products.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.inventory_2_outlined,
                                size: 48,
                                color: AppColors.textTertiary),
                            const SizedBox(height: 12),
                            Text(
                              'No products for this provider yet',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Click "Add Product" to create one',
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
          _headerCell('Price (ZAR)', flex: 1),
          _headerCell('Tokens', flex: 1),
          _headerCell('Validity', flex: 1),
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

  Widget _buildProductRow(Map<String, dynamic> product) {
    final isActive = product['isActive'] == true;
    final priceZar = (product['priceZar'] as num?)?.toDouble() ?? 0;
    final priceTokens = product['priceTokens'] as int? ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name'] as String? ?? '—',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
                if (product['description'] != null)
                  Text(product['description'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(product['code'] as String? ?? '—',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'monospace',
                    color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Text('R${priceZar.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 1,
            child: Text('$priceTokens',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tokenGold)),
          ),
          Expanded(
            flex: 1,
            child: Text(product['validity'] as String? ?? '—',
                style: const TextStyle(fontSize: 13)),
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
                  case 'edit':
                    _showCreateEditDialog(product);
                  case 'duplicate':
                    _duplicateProduct(product);
                  case 'toggle':
                    _toggleProduct(product);
                  case 'delete':
                    _deleteProduct(product);
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
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Row(children: [
                    Icon(Icons.copy, size: 18),
                    SizedBox(width: 8),
                    Text('Duplicate'),
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

  Future<void> _toggleProduct(Map<String, dynamic> product) async {
    try {
      await _functions.httpsCallable('adminToggleVasProduct').call({
        'productId': product['id'],
        'providerId': widget.providerId,
      });
      _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _deleteProduct(Map<String, dynamic> product) async {
    final name = product['name'] as String? ?? 'this product';
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title:
            const Text('Delete Product', style: TextStyle(fontSize: 16)),
        content: Text('Are you sure you want to delete "$name"?',
            style: const TextStyle(fontSize: 13)),
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
      await _functions.httpsCallable('adminDeleteVasProduct').call({
        'productId': product['id'],
        'providerId': widget.providerId,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted')),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _duplicateProduct(Map<String, dynamic> product) {
    final duplicate = Map<String, dynamic>.from(product);
    duplicate['name'] = '${product['name']} (Copy)';
    duplicate['code'] = '${product['code']}-copy';
    duplicate.remove('id');
    _showCreateEditDialog(duplicate, isDuplicate: true);
  }

  // ─── Create / Edit Dialog ──────────────────────────

  void _showCreateEditDialog(Map<String, dynamic>? existing,
      {bool isDuplicate = false}) {
    final isEdit = existing != null && !isDuplicate;
    final nameCtrl =
        TextEditingController(text: existing?['name'] as String? ?? '');
    final codeCtrl =
        TextEditingController(text: existing?['code'] as String? ?? '');
    final priceZarCtrl = TextEditingController(
        text: existing?['priceZar'] != null
            ? (existing!['priceZar'] as num).toStringAsFixed(2)
            : '');
    final validityCtrl =
        TextEditingController(text: existing?['validity'] as String? ?? '');
    final sortCtrl =
        TextEditingController(text: '${existing?['sortOrder'] ?? 0}');
    final metadataCtrl = TextEditingController(
        text: existing?['metadata'] != null
            ? const JsonEncoder.withIndent('  ')
                .convert(existing!['metadata'])
            : '');
    final descCtrl = TextEditingController(
        text: existing?['description'] as String? ?? '');
    var isActive = existing?['isActive'] as bool? ?? true;
    final formKey = GlobalKey<FormState>();
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          final zarVal = double.tryParse(priceZarCtrl.text) ?? 0;
          final autoTokens = (zarVal * 100).round();

          return AlertDialog(
            backgroundColor: AppColors.adminCard,
            title: Text(
              isEdit
                  ? 'Edit Product'
                  : isDuplicate
                      ? 'Duplicate Product'
                      : 'Add Product',
            ),
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
                          hintText: 'e.g. airtime-10',
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
                      TextFormField(
                        controller: priceZarCtrl,
                        decoration: InputDecoration(
                          labelText: 'Price (ZAR)',
                          suffixText: '= $autoTokens tokens',
                        ),
                        keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true),
                        onChanged: (_) => setInnerState(() {}),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          final parsed = double.tryParse(v);
                          if (parsed == null || parsed <= 0) {
                            return 'Must be a positive number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: validityCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Validity',
                          hintText: 'e.g. 30 days',
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
                      TextFormField(
                        controller: metadataCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Metadata (JSON, optional)',
                          hintText: '{"key": "value"}',
                        ),
                        maxLines: 3,
                        validator: (v) {
                          if (v != null && v.trim().isNotEmpty) {
                            try {
                              json.decode(v);
                            } catch (_) {
                              return 'Invalid JSON';
                            }
                          }
                          return null;
                        },
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
                        final priceZar =
                            double.tryParse(priceZarCtrl.text) ?? 0;
                        Map<String, dynamic>? metadata;
                        if (metadataCtrl.text.trim().isNotEmpty) {
                          metadata = json.decode(metadataCtrl.text)
                              as Map<String, dynamic>;
                        }
                        try {
                          final fn = isEdit
                              ? 'adminUpdateVasProduct'
                              : 'adminCreateVasProduct';
                          final data = {
                            'providerId': widget.providerId,
                            if (isEdit)
                              'productId': existing['id'] as String,
                            'name': nameCtrl.text.trim(),
                            'code': codeCtrl.text.trim(),
                            'priceZar': priceZar,
                            if (validityCtrl.text.trim().isNotEmpty)
                              'validity': validityCtrl.text.trim(),
                            'sortOrder':
                                int.tryParse(sortCtrl.text.trim()) ?? 0,
                            if (descCtrl.text.trim().isNotEmpty)
                              'description': descCtrl.text.trim(),
                            if (metadata != null) 'metadata': metadata,
                            'isActive': isActive,
                          };
                          await _functions
                              .httpsCallable(fn)
                              .call(data);
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadData();
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

  // ─── Bulk Price Dialog ─────────────────────────────

  void _showBulkPriceDialog() {
    var adjustmentType = 'percentage';
    final valueCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            backgroundColor: AppColors.adminCard,
            title: const Text('Bulk Price Update'),
            content: SizedBox(
              width: 400,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adjust prices for all active products.',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: adjustmentType,
                      decoration: const InputDecoration(
                          labelText: 'Adjustment Type'),
                      items: const [
                        DropdownMenuItem(
                            value: 'percentage',
                            child: Text('Percentage (%)')),
                        DropdownMenuItem(
                            value: 'flat',
                            child: Text('Flat Amount (ZAR)')),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setInnerState(() => adjustmentType = v);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: valueCtrl,
                      decoration: InputDecoration(
                        labelText: adjustmentType == 'percentage'
                            ? 'Percentage (e.g. 10 for +10%)'
                            : 'Amount in ZAR (e.g. 5 for +R5)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) {
                          return 'Must be a number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Token prices auto-recalculated (ZAR × 100).',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textTertiary),
                    ),
                  ],
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
                          final result = await _functions
                              .httpsCallable(
                                  'adminBulkUpdateVasProductPrices')
                              .call({
                            'providerId': widget.providerId,
                            'adjustmentType': adjustmentType,
                            'adjustmentValue':
                                double.tryParse(valueCtrl.text) ?? 0,
                          });
                          final updated =
                              result.data['updatedCount'] ?? 0;
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Updated $updated product prices')),
                            );
                            _loadData();
                          }
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
                    : const Text('Apply'),
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
