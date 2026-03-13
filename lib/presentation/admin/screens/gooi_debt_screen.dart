import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class GooiDebtScreen extends StatefulWidget {
  const GooiDebtScreen({super.key});

  @override
  State<GooiDebtScreen> createState() => _GooiDebtScreenState();
}

class _GooiDebtScreenState extends State<GooiDebtScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _debts = [];

  @override
  void initState() {
    super.initState();
    _loadDebts();
  }

  Future<void> _loadDebts() async {
    setState(() => _isLoading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('gooiGooiDebts')
          .orderBy('createdAt', descending: true)
          .limit(200)
          .get();

      setState(() {
        _debts = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load debts: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final outstanding = _debts.where((d) => d['status'] == 'OUTSTANDING').toList();
    final resolved = _debts.where((d) => d['status'] != 'OUTSTANDING').toList();
    final totalOutstanding = outstanding.fold<int>(
      0,
      (total, d) => total + ((d['amount'] as int?) ?? 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gooi-Gooi Debts'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadDebts),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: totalOutstanding > 0
                      ? Colors.red.withValues(alpha: 0.1)
                      : AppColors.teal.withValues(alpha: 0.1),
                  child: Column(
                    children: [
                      Text(
                        'R${(totalOutstanding / 100).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: totalOutstanding > 0 ? Colors.red : AppColors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${outstanding.length} outstanding debt(s)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadDebts,
                    child: ListView(
                      children: [
                        if (outstanding.isNotEmpty) ...[
                          _buildSectionTitle(context, 'Outstanding'),
                          ...outstanding.map((d) => _buildDebtTile(context, d)),
                        ],
                        if (resolved.isNotEmpty) ...[
                          _buildSectionTitle(context, 'Resolved'),
                          ...resolved.map((d) => _buildDebtTile(context, d)),
                        ],
                        if (_debts.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Text('No debts recorded'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey)),
    );
  }

  Widget _buildDebtTile(BuildContext context, Map<String, dynamic> debt) {
    final amount = (debt['amount'] as int? ?? 0) / 100;
    final status = debt['status'] as String? ?? 'OUTSTANDING';
    final userId = debt['userId'] as String? ?? '';
    final reason = debt['reason'] as String? ?? '';
    final groupId = debt['groupId'] as String? ?? '';

    final statusColor = switch (status) {
      'OUTSTANDING' => Colors.red,
      'RECOVERED' => AppColors.teal,
      'WRITTEN_OFF' => Colors.grey,
      _ => Colors.grey,
    };

    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: statusColor.withValues(alpha: 0.15),
        child: Icon(
          status == 'OUTSTANDING' ? Icons.warning : Icons.check,
          color: statusColor,
          size: 16,
        ),
      ),
      title: Text('R${amount.toStringAsFixed(2)}'),
      subtitle: Text('$reason\nUser: ${userId.substring(0, userId.length.clamp(0, 8))}... · Group: ${groupId.substring(0, groupId.length.clamp(0, 8))}...'),
      isThreeLine: true,
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          status,
          style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
