import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Admin screen for managing banned words for listing moderation
/// (Spec §8.22, §8.12, Phase 4.8).
///
/// Text area (one word per line), stored in `config/marketplace` Firestore doc.
/// Includes a test field to check if a phrase would trigger a flag.
class BannedWordsManagementScreen extends StatefulWidget {
  const BannedWordsManagementScreen({super.key});

  @override
  State<BannedWordsManagementScreen> createState() =>
      _BannedWordsManagementScreenState();
}

class _BannedWordsManagementScreenState
    extends State<BannedWordsManagementScreen> {
  bool _isLoading = false;
  bool _isSaving = false;
  final _wordsController = TextEditingController();
  final _testController = TextEditingController();
  String? _testResult;
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _wordsController.dispose();
    _testController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('marketplace')
          .get();
      final data = doc.data();
      final words = List<String>.from(data?['bannedWords'] ?? []);
      if (mounted) {
        setState(() {
          _wordsController.text = words.join('\n');
          _wordCount = words.length;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading banned words: $e')),
        );
      }
    }
  }

  List<String> get _parsedWords => _wordsController.text
      .split('\n')
      .map((w) => w.trim().toLowerCase())
      .where((w) => w.isNotEmpty)
      .toSet()
      .toList()
    ..sort();

  Future<void> _save() async {
    final words = _parsedWords;
    setState(() => _isSaving = true);
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateBannedWords')
          .call({'bannedWords': words});
      if (mounted) {
        setState(() {
          _isSaving = false;
          _wordCount = words.length;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved ${words.length} banned words')),
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

  void _testPhrase() {
    final phrase = _testController.text.trim().toLowerCase();
    if (phrase.isEmpty) {
      setState(() => _testResult = null);
      return;
    }

    final words = _parsedWords;
    final matches = words.where((w) => phrase.contains(w)).toList();
    setState(() {
      if (matches.isEmpty) {
        _testResult = 'PASS — No banned words found in phrase.';
      } else {
        _testResult =
            'FLAG — Matches: ${matches.map((w) => '"$w"').join(', ')}';
      }
    });
  }

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
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Banned Words',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                              '$_wordCount words configured',
                              style: const TextStyle(
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
                            onPressed: _isSaving ? null : _save,
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
                  const SizedBox(height: 24),

                  // Two columns: word list + test panel
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Word list
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.cardDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Banned Word List',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text(
                                  'One word or phrase per line. '
                                  'Case-insensitive, duplicates auto-removed on save.',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _wordsController,
                                maxLines: 20,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'monospace'),
                                decoration: InputDecoration(
                                  hintText:
                                      'Enter banned words, one per line...',
                                  hintStyle: TextStyle(
                                      color: AppColors.textTertiary),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.borderDark),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.borderDark),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.all(12),
                                ),
                                onChanged: (_) {
                                  setState(() {
                                    _wordCount = _parsedWords.length;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Test panel
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.cardDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Test Phrase',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text(
                                  'Check if a phrase would trigger a flag.',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _testController,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 13),
                                decoration: InputDecoration(
                                  hintText: 'Enter a test phrase...',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.all(12),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _testPhrase,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                    minimumSize: const Size(0, 40),
                                  ),
                                  child: const Text('Test'),
                                ),
                              ),
                              if (_testResult != null) ...[
                                const SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _testResult!.startsWith('PASS')
                                        ? AppColors.success
                                            .withValues(alpha: 0.1)
                                        : AppColors.error
                                            .withValues(alpha: 0.1),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _testResult!.startsWith('PASS')
                                          ? AppColors.success
                                              .withValues(alpha: 0.3)
                                          : AppColors.error
                                              .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        _testResult!.startsWith('PASS')
                                            ? Icons.check_circle
                                            : Icons.flag,
                                        size: 18,
                                        color:
                                            _testResult!.startsWith('PASS')
                                                ? AppColors.success
                                                : AppColors.error,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(_testResult!,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: _testResult!
                                                      .startsWith('PASS')
                                                  ? AppColors.success
                                                  : AppColors.error,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
