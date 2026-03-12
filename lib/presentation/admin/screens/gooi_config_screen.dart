import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

class GooiConfigScreen extends StatefulWidget {
  const GooiConfigScreen({super.key});

  @override
  State<GooiConfigScreen> createState() => _GooiConfigScreenState();
}

class _GooiConfigScreenState extends State<GooiConfigScreen> {
  bool _isLoading = true;
  bool _isSaving = false;

  late final TextEditingController _maxGroupSizeCtl;
  late final TextEditingController _maxTotalCyclesCtl;
  late final TextEditingController _maxActiveGroupsCtl;
  late final TextEditingController _minContributionCtl;
  late final TextEditingController _maxContributionCtl;
  late final TextEditingController _maxLateFeePercentCtl;
  late final TextEditingController _autoTriggerHoursCtl;
  late final TextEditingController _maxDelegationDaysCtl;
  late final TextEditingController _biddingWindowHoursCtl;
  late final TextEditingController _minBidPercentCtl;
  late final TextEditingController _invitationExpiryDaysCtl;

  @override
  void initState() {
    super.initState();
    _maxGroupSizeCtl = TextEditingController();
    _maxTotalCyclesCtl = TextEditingController();
    _maxActiveGroupsCtl = TextEditingController();
    _minContributionCtl = TextEditingController();
    _maxContributionCtl = TextEditingController();
    _maxLateFeePercentCtl = TextEditingController();
    _autoTriggerHoursCtl = TextEditingController();
    _maxDelegationDaysCtl = TextEditingController();
    _biddingWindowHoursCtl = TextEditingController();
    _minBidPercentCtl = TextEditingController();
    _invitationExpiryDaysCtl = TextEditingController();
    _loadConfig();
  }

  @override
  void dispose() {
    _maxGroupSizeCtl.dispose();
    _maxTotalCyclesCtl.dispose();
    _maxActiveGroupsCtl.dispose();
    _minContributionCtl.dispose();
    _maxContributionCtl.dispose();
    _maxLateFeePercentCtl.dispose();
    _autoTriggerHoursCtl.dispose();
    _maxDelegationDaysCtl.dispose();
    _biddingWindowHoursCtl.dispose();
    _minBidPercentCtl.dispose();
    _invitationExpiryDaysCtl.dispose();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('gooiGooiConfig')
          .doc('default')
          .get();

      final data = doc.data() ?? _defaultConfig();

      setState(() {
        _maxGroupSizeCtl.text = '${data['maxGroupSize'] ?? 12}';
        _maxTotalCyclesCtl.text = '${data['maxTotalCycles'] ?? 12}';
        _maxActiveGroupsCtl.text = '${data['maxActiveGroups'] ?? 3}';
        _minContributionCtl.text = '${data['minContribution'] ?? 1000}';
        _maxContributionCtl.text = '${data['maxContribution'] ?? 1000000}';
        _maxLateFeePercentCtl.text = '${data['maxLateFeePercent'] ?? 10}';
        _autoTriggerHoursCtl.text = '${data['autoTriggerHours'] ?? 72}';
        _maxDelegationDaysCtl.text = '${data['maxDelegationDays'] ?? 14}';
        _biddingWindowHoursCtl.text = '${data['biddingWindowHours'] ?? 48}';
        _minBidPercentCtl.text = '${data['minBidPercent'] ?? 80}';
        _invitationExpiryDaysCtl.text = '${data['invitationExpiryDays'] ?? 7}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load config: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Map<String, dynamic> _defaultConfig() => {
        'maxGroupSize': 12,
        'maxTotalCycles': 12,
        'maxActiveGroups': 3,
        'minContribution': 1000,
        'maxContribution': 1000000,
        'maxLateFeePercent': 10,
        'autoTriggerHours': 72,
        'maxDelegationDays': 14,
        'biddingWindowHours': 48,
        'minBidPercent': 80,
        'invitationExpiryDays': 7,
      };

  Future<void> _saveConfig() async {
    setState(() => _isSaving = true);
    try {
      final updated = {
        'maxGroupSize': int.tryParse(_maxGroupSizeCtl.text) ?? 12,
        'maxTotalCycles': int.tryParse(_maxTotalCyclesCtl.text) ?? 12,
        'maxActiveGroups': int.tryParse(_maxActiveGroupsCtl.text) ?? 3,
        'minContribution': int.tryParse(_minContributionCtl.text) ?? 1000,
        'maxContribution': int.tryParse(_maxContributionCtl.text) ?? 1000000,
        'maxLateFeePercent': int.tryParse(_maxLateFeePercentCtl.text) ?? 10,
        'autoTriggerHours': int.tryParse(_autoTriggerHoursCtl.text) ?? 72,
        'maxDelegationDays': int.tryParse(_maxDelegationDaysCtl.text) ?? 14,
        'biddingWindowHours': int.tryParse(_biddingWindowHoursCtl.text) ?? 48,
        'minBidPercent': int.tryParse(_minBidPercentCtl.text) ?? 80,
        'invitationExpiryDays': int.tryParse(_invitationExpiryDaysCtl.text) ?? 7,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('gooiGooiConfig')
          .doc('default')
          .set(updated, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Config saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gooi-Gooi Config'),
        actions: [
          TextButton.icon(
            onPressed: _isSaving ? null : _saveConfig,
            icon: _isSaving
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Group Limits'),
                  _ConfigField(controller: _maxGroupSizeCtl, label: 'Max Group Size', hint: 'e.g. 12'),
                  _ConfigField(controller: _maxTotalCyclesCtl, label: 'Max Total Cycles', hint: 'e.g. 12'),
                  _ConfigField(controller: _maxActiveGroupsCtl, label: 'Max Active Groups per User', hint: 'e.g. 3'),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Contribution Bounds (tokens)'),
                  _ConfigField(controller: _minContributionCtl, label: 'Min Contribution', hint: '1000 = R10'),
                  _ConfigField(controller: _maxContributionCtl, label: 'Max Contribution', hint: '1000000 = R10,000'),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Timing'),
                  _ConfigField(controller: _autoTriggerHoursCtl, label: 'Auto-Trigger Hours', hint: 'e.g. 72'),
                  _ConfigField(controller: _maxDelegationDaysCtl, label: 'Max Delegation Days', hint: 'e.g. 14'),
                  _ConfigField(controller: _biddingWindowHoursCtl, label: 'Bidding Window Hours', hint: 'e.g. 48'),
                  _ConfigField(controller: _invitationExpiryDaysCtl, label: 'Invitation Expiry Days', hint: 'e.g. 7'),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Fees & Bidding'),
                  _ConfigField(controller: _maxLateFeePercentCtl, label: 'Max Late Fee %', hint: 'e.g. 10'),
                  _ConfigField(controller: _minBidPercentCtl, label: 'Min Bid %', hint: 'e.g. 80'),
                ],
              ),
            ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.teal)),
    );
  }
}

class _ConfigField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const _ConfigField({required this.controller, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
