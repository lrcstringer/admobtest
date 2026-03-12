import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing VAS products of a specific provider.
///
/// Phase 6.2 — Route: `/buy-vas-products?providerId=xxx`
/// Features: product table, CRUD, bulk price update, duplicate product.
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

  final _functions =
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
      // Load provider details + products via listing providers
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
        final snapshot = await FirebaseFirestore.instance
            .collection('serviceProducts')
            .where('providerId', isEqualTo: widget.providerId)
            .orderBy('sortOrder')
            .get();
        products = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
      } catch (_) {
        // Fallback: products may be embedded in provider doc
        if (provider['products'] is List) {
          products = (provider['products'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
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

  int get _activeCount =>
      _products.where((p) => p['isActive'] == true).length;
  int get _inactiveCount =>
      _products.where((p) => p['isActive'] != true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildStatsRow(),
                  const SizedBox(height: 24),
                  _buildTable(),
                ],
              ),
            ),
    );
  }

  // ─── Header ──────────────────────────────────────────

  Widget _buildHeader() {
    final providerName = _provider?['name'] as String? ?? 'Provider';
    final category = _provider?['category'] as String? ?? '';

    return Row(
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
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Category: ${_categoryLabel(category)}',
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _showBulkPriceDialog,
              icon: const Icon(Icons.price_change, size: 18),
              label: const Text('Bulk Price Update'),
            ),
            const SizedBox(width: 12),
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
    );
  }

  // ─── Stats Row ──────────────────────────────────────

  Widget _buildStatsRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _StatCard(
          title: 'Total Products',
          value: '${_products.length}',
          icon: Icons.inventory_2,
          color: AppColors.secondary,
        ),
        _StatCard(
          title: 'Active',
          value: '$_activeCount',
          icon: Icons.check_circle,
          color: AppColors.success,
        ),
        _StatCard(
          title: 'Inactive',
          value: '$_inactiveCount',
          icon: Icons.cancel,
          color: AppColors.error,
        ),
      ],
    );
  }

  // ─── Table ──────────────────────────────────────────

  Widget _buildTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                _headerCell('Name', flex: 2),
                _headerCell('Code', flex: 1),
                _headerCell('Price (ZAR)', flex: 1),
                _headerCell('Price (Tokens)', flex: 1),
                _headerCell('Validity', flex: 1),
                _headerCell('Sort', flex: 1),
                _headerCell('Status', flex: 1),
                _headerCell('Actions', flex: 2),
              ],
            ),
          ),
          const Divider(height: 1),
          if (_products.isEmpty)
            Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                children: [
                  Icon(Icons.inventory_2_outlined,
                      size: 48, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    'No products for this provider yet.\nClick "Add Product" to create one.',
                    style: TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ..._products.map(_buildRow),
        ],
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> product) {
    final isActive = product['isActive'] == true;
    final priceZar = (product['priceZar'] as num?)?.toDouble() ?? 0;
    final priceTokens = product['priceTokens'] as int? ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderDark)),
      ),
      child: Row(
        children: [
          // Name
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] as String? ?? '—',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
                if (product['description'] != null)
                  Text(
                    product['description'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textTertiary),
                  ),
              ],
            ),
          ),
          // Code
          Expanded(
            flex: 1,
            child: Text(
              product['code'] as String? ?? '—',
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: AppColors.textSecondary),
            ),
          ),
          // Price ZAR
          Expanded(
            flex: 1,
            child: Text('R${priceZar.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 13)),
          ),
          // Price Tokens
          Expanded(
            flex: 1,
            child: Text('$priceTokens',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tokenGold)),
          ),
          // Validity
          Expanded(
            flex: 1,
            child: Text(product['validity'] as String? ?? '—',
                style: const TextStyle(fontSize: 12)),
          ),
          // Sort order
          Expanded(
            flex: 1,
            child: Text('${product['sortOrder'] ?? 0}',
                style: const TextStyle(fontSize: 13)),
          ),
          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isActive ? AppColors.success : AppColors.error)
                    .withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActive ? 'Active' : 'Inactive',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.success : AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Actions
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  color: AppColors.textSecondary,
                  onPressed: () => _showCreateEditDialog(product),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  color: AppColors.secondary,
                  onPressed: () => _duplicateProduct(product),
                  tooltip: 'Duplicate',
                ),
                IconButton(
                  icon: Icon(
                    isActive
                        ? Icons.toggle_off_outlined
                        : Icons.toggle_on_outlined,
                    size: 20,
                  ),
                  color: isActive ? AppColors.warning : AppColors.success,
                  onPressed: () => _toggleProduct(product),
                  tooltip: isActive ? 'Deactivate' : 'Activate',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  color: AppColors.error,
                  onPressed: () => _deleteProduct(product),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
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

  // ─── Actions ────────────────────────────────────────

  Future<void> _toggleProduct(Map<String, dynamic> product) async {
    final id = product['id'] as String;
    final isActive = product['isActive'] == true;
    try {
      await _functions.httpsCallable('adminToggleVasProduct')
          .call({'productId': id, 'providerId': widget.providerId});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Product ${isActive ? 'deactivated' : 'activated'}')),
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

  Future<void> _deleteProduct(Map<String, dynamic> product) async {
    final id = product['id'] as String;
    final name = product['name'] as String? ?? 'this product';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Delete Product', style: TextStyle(fontSize: 16)),
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
      await _functions.httpsCallable('adminDeleteVasProduct')
          .call({'productId': id, 'providerId': widget.providerId});
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
    // Pre-fill the create dialog with existing product data, different name/code
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
    final sortCtrl = TextEditingController(
        text: '${existing?['sortOrder'] ?? 0}');
    final metadataCtrl = TextEditingController(
        text: existing?['metadata'] != null
            ? const JsonEncoder.withIndent('  ')
                .convert(existing!['metadata'])
            : '');
    final descCtrl =
        TextEditingController(text: existing?['description'] as String? ?? '');
    var isActive = existing?['isActive'] as bool? ?? true;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          // Auto-calculate tokens from ZAR
          final zarVal = double.tryParse(priceZarCtrl.text) ?? 0;
          final autoTokens = (zarVal * 100).round();

          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: Text(
              isEdit
                  ? 'Edit Product'
                  : isDuplicate
                      ? 'Duplicate Product'
                      : 'Add Product',
              style: const TextStyle(fontSize: 16),
            ),
            content: SizedBox(
              width: 500,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Name *'),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Required'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: codeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Code *',
                          hintText: 'e.g., airtime-10',
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
                          labelText: 'Price (ZAR) *',
                          suffixText: '= $autoTokens tokens',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (_) => setDialogState(() {}),
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
                          hintText: 'e.g., 30 days, 7 days',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Sort Order'),
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
                            setDialogState(() => isActive = v),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  nameCtrl.dispose();
                  codeCtrl.dispose();
                  priceZarCtrl.dispose();
                  validityCtrl.dispose();
                  sortCtrl.dispose();
                  metadataCtrl.dispose();
                  descCtrl.dispose();
                  Navigator.of(ctx).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final priceZar =
                      double.tryParse(priceZarCtrl.text) ?? 0;
                  Map<String, dynamic>? metadata;
                  if (metadataCtrl.text.trim().isNotEmpty) {
                    metadata = json.decode(metadataCtrl.text)
                        as Map<String, dynamic>;
                  }

                  final data = {
                    'providerId': widget.providerId,
                    'name': nameCtrl.text.trim(),
                    'code': codeCtrl.text.trim(),
                    'priceZar': priceZar,
                    if (validityCtrl.text.trim().isNotEmpty)
                      'validity': validityCtrl.text.trim(),
                    'sortOrder': int.tryParse(sortCtrl.text) ?? 0,
                    if (metadata != null) 'metadata': metadata,
                  };

                  try {
                    if (isEdit) {
                      data['productId'] = existing['id'] as String;
                      await _functions
                          .httpsCallable('adminUpdateVasProduct')
                          .call(data);
                    } else {
                      await _functions
                          .httpsCallable('adminCreateVasProduct')
                          .call(data);
                    }
                    nameCtrl.dispose();
                    codeCtrl.dispose();
                    priceZarCtrl.dispose();
                    validityCtrl.dispose();
                    sortCtrl.dispose();
                    metadataCtrl.dispose();
                    descCtrl.dispose();
                    if (ctx.mounted) Navigator.of(ctx).pop();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(isEdit
                                ? 'Product updated'
                                : 'Product created')),
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
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: Text(isEdit ? 'Save' : 'Create'),
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

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title: const Text('Bulk Price Update',
                style: TextStyle(fontSize: 16)),
            content: SizedBox(
              width: 400,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adjust prices for all active products of this provider.',
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
                          setDialogState(() => adjustmentType = v);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: valueCtrl,
                      decoration: InputDecoration(
                        labelText: adjustmentType == 'percentage'
                            ? 'Percentage (e.g., 10 for +10%, -5 for -5%)'
                            : 'Amount in ZAR (e.g., 5 for +R5, -2 for -R2)',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
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
                      'Token prices will be auto-recalculated (ZAR × 100).',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  valueCtrl.dispose();
                  Navigator.of(ctx).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final adjustmentValue =
                      double.tryParse(valueCtrl.text) ?? 0;
                  try {
                    final result = await _functions
                        .httpsCallable('adminBulkUpdateVasProductPrices')
                        .call({
                      'providerId': widget.providerId,
                      'adjustmentType': adjustmentType,
                      'adjustmentValue': adjustmentValue,
                    });
                    final updated = result.data['updatedCount'] ?? 0;
                    valueCtrl.dispose();
                    if (ctx.mounted) Navigator.of(ctx).pop();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Updated $updated product prices')),
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
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: const Text('Apply'),
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
      case 'marketplace':
        return 'Marketplace';
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

// ─── Private Widgets ──────────────────────────────────

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
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
