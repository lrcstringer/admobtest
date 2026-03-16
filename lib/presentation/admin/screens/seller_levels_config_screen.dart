import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/enums/seller_level.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buy/seller_level_badge.dart';

/// Admin screen for configuring seller level thresholds (Spec §8.22, Phase 4.7).
///
/// Editable thresholds per level + current distribution counts.
class SellerLevelsConfigScreen extends StatefulWidget {
  const SellerLevelsConfigScreen({super.key});

  @override
  State<SellerLevelsConfigScreen> createState() =>
      _SellerLevelsConfigScreenState();
}

class _SellerLevelsConfigScreenState extends State<SellerLevelsConfigScreen> {
  bool _isLoading = false;
  bool _isSaving = false;
  Map<String, int> _distribution = {};

  // Editable thresholds
  final _activeOrdersCtrl = TextEditingController(text: '3');
  final _activeRatingCtrl = TextEditingController(text: '3.0');
  final _trustedOrdersCtrl = TextEditingController(text: '10');
  final _trustedRatingCtrl = TextEditingController(text: '4.0');
  final _starOrdersCtrl = TextEditingController(text: '25');
  final _starRatingCtrl = TextEditingController(text: '4.5');

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _activeOrdersCtrl.dispose();
    _activeRatingCtrl.dispose();
    _trustedOrdersCtrl.dispose();
    _trustedRatingCtrl.dispose();
    _starOrdersCtrl.dispose();
    _starRatingCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Load config
      final configDoc = await FirebaseFirestore.instance
          .collection('config')
          .doc('marketplace')
          .get();
      final config = configDoc.data();
      if (config != null) {
        final levels = config['sellerLevels'] as Map<String, dynamic>?;
        if (levels != null) {
          final active = levels['active'] as Map<String, dynamic>?;
          final trusted = levels['trusted'] as Map<String, dynamic>?;
          final star = levels['star'] as Map<String, dynamic>?;
          if (active != null) {
            _activeOrdersCtrl.text = '${active['minOrders'] ?? 3}';
            _activeRatingCtrl.text = '${active['minRating'] ?? 3.0}';
          }
          if (trusted != null) {
            _trustedOrdersCtrl.text = '${trusted['minOrders'] ?? 10}';
            _trustedRatingCtrl.text = '${trusted['minRating'] ?? 4.0}';
          }
          if (star != null) {
            _starOrdersCtrl.text = '${star['minOrders'] ?? 25}';
            _starRatingCtrl.text = '${star['minRating'] ?? 4.5}';
          }
        }
      }

      // Load distribution counts
      final providersSnap = await FirebaseFirestore.instance
          .collection('providers')
          .get();
      final dist = <String, int>{};
      for (final doc in providersSnap.docs) {
        final level = doc.data()['sellerLevel'] as String? ?? 'newSeller';
        dist[level] = (dist[level] ?? 0) + 1;
      }

      if (mounted) {
        setState(() {
          _distribution = dist;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading config: $e')),
        );
      }
    }
  }

  Future<void> _saveConfig() async {
    setState(() => _isSaving = true);
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateSellerLevelConfig')
          .call({
        'active': {
          'minOrders': int.tryParse(_activeOrdersCtrl.text) ?? 3,
          'minRating': double.tryParse(_activeRatingCtrl.text) ?? 3.0,
        },
        'trusted': {
          'minOrders': int.tryParse(_trustedOrdersCtrl.text) ?? 10,
          'minRating': double.tryParse(_trustedRatingCtrl.text) ?? 4.0,
        },
        'star': {
          'minOrders': int.tryParse(_starOrdersCtrl.text) ?? 25,
          'minRating': double.tryParse(_starRatingCtrl.text) ?? 4.5,
        },
      });
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seller level config saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          Text('Seller Levels Config',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark)),
                          SizedBox(height: 4),
                          Text(
                              'Configure thresholds for seller level progression',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: _loadData,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _isSaving ? null : _saveConfig,
                            icon: _isSaving
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2))
                                : const Icon(Icons.save, size: 18),
                            label: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: const Size(0, 40),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Distribution overview
                  const Text('Current Distribution',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: SellerLevel.values.map((level) {
                      final count = _distribution[level.name] ?? 0;
                      return _LevelDistCard(level: level, count: count);
                    }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Threshold config cards
                  const Text('Level Thresholds',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  _LevelThresholdCard(
                    level: SellerLevel.newSeller,
                    description: 'Default level for all new sellers. No requirements.',
                    isBase: true,
                  ),
                  const SizedBox(height: 12),
                  _LevelThresholdCard(
                    level: SellerLevel.active,
                    description: 'Promoted after meeting minimum orders and rating.',
                    ordersController: _activeOrdersCtrl,
                    ratingController: _activeRatingCtrl,
                  ),
                  const SizedBox(height: 12),
                  _LevelThresholdCard(
                    level: SellerLevel.trusted,
                    description: 'Verified sellers with consistent performance.',
                    ordersController: _trustedOrdersCtrl,
                    ratingController: _trustedRatingCtrl,
                  ),
                  const SizedBox(height: 12),
                  _LevelThresholdCard(
                    level: SellerLevel.star,
                    description: 'Top-tier sellers with exceptional track record.',
                    ordersController: _starOrdersCtrl,
                    ratingController: _starRatingCtrl,
                  ),
                ],
              ),
            ),
    );
  }
}

class _LevelDistCard extends StatelessWidget {
  final SellerLevel level;
  final int count;

  const _LevelDistCard({required this.level, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.adminCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SellerLevelBadge(
            level: level,
            size: SellerBadgeSize.medium,
          ),
          const SizedBox(height: 12),
          Text('$count',
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold)),
          Text('sellers',
              style: TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _LevelThresholdCard extends StatelessWidget {
  final SellerLevel level;
  final String description;
  final bool isBase;
  final TextEditingController? ordersController;
  final TextEditingController? ratingController;

  const _LevelThresholdCard({
    required this.level,
    required this.description,
    this.isBase = false,
    this.ordersController,
    this.ratingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.adminCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SellerLevelBadge(
                    level: level, size: SellerBadgeSize.large),
                const SizedBox(height: 8),
                Text(description,
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 32),
          if (isBase)
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Base level — no thresholds required',
                    style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textTertiary)),
              ),
            )
          else ...[
            SizedBox(
              width: 150,
              child: TextField(
                controller: ordersController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Min Orders',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 150,
              child: TextField(
                controller: ratingController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Min Rating',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
