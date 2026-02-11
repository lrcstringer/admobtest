import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';

/// Admin screen for reviewing upload submissions that require approval.
/// Lists engagements with status == 'pending_review' and allows
/// approve / reject actions.
class UploadReviewScreen extends StatefulWidget {
  const UploadReviewScreen({super.key});

  @override
  State<UploadReviewScreen> createState() => _UploadReviewScreenState();
}

class _UploadReviewScreenState extends State<UploadReviewScreen> {
  List<Map<String, dynamic>> _queue = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadQueue();
  }

  Future<void> _loadQueue() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('getUploadReviewQueue');
      final result = await callable.call<dynamic>({'limit': 50});

      final list = (result.data['engagements'] as List<dynamic>?) ?? [];
      setState(() {
        _queue = list
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _handleReview(
    String engagementId, {
    required String action,
    String? reason,
  }) async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('adminReviewUpload');
      await callable.call<dynamic>({
        'engagementId': engagementId,
        'action': action,
        if (reason != null) 'reason': reason,
      });

      // Remove from local queue
      setState(() {
        _queue.removeWhere((e) => e['id'] == engagementId);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(action == 'approve'
                ? 'Submission approved — tokens awarded'
                : 'Submission rejected'),
            backgroundColor:
                action == 'approve' ? AppColors.success : AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Review failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _showRejectDialog(String engagementId) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reject Submission'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Reason (required)',
            hintText: 'Why is this submission being rejected?',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.of(ctx).pop(controller.text.trim());
              }
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (reason != null && reason.isNotEmpty) {
      await _handleReview(engagementId, action: 'reject', reason: reason);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _queue.isEmpty
                  ? _buildEmpty()
                  : _buildQueue(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 48),
          const SizedBox(height: 12),
          Text('Error: $_error',
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _loadQueue,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline,
              color: AppColors.success.withValues(alpha: 0.6), size: 64),
          const SizedBox(height: 16),
          const Text(
            'No pending uploads',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All upload submissions have been reviewed.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _loadQueue,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildQueue() {
    return SingleChildScrollView(
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
                    'Upload Reviews',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_queue.length} submission${_queue.length == 1 ? '' : 's'} pending review',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: _loadQueue,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Queue cards
          ...List.generate(_queue.length, (i) => _buildReviewCard(_queue[i])),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> engagement) {
    final engagementId = engagement['id'] as String? ?? '';
    final userId = engagement['userId'] as String? ?? 'Unknown';
    final userDisplayName =
        engagement['userDisplayName'] as String? ?? userId;
    final opportunityTitle =
        engagement['opportunityTitle'] as String? ?? 'Untitled';
    final tokenReward = engagement['tokenReward'] ?? 0;
    final prompt = engagement['uploadPrompt'] as String? ?? '';
    final evidence =
        engagement['evidence'] as Map<String, dynamic>? ?? {};
    final uploadedFiles =
        (evidence['uploadedFiles'] as List<dynamic>?) ?? [];
    final textResponse = evidence['uploadTextResponse'] as String?;
    final createdAt = engagement['createdAt'];

    String formattedDate = '';
    if (createdAt is String) {
      try {
        formattedDate =
            DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(createdAt));
      } catch (_) {}
    } else if (createdAt is Map && createdAt['_seconds'] != null) {
      final dt = DateTime.fromMillisecondsSinceEpoch(
          (createdAt['_seconds'] as num).toInt() * 1000);
      formattedDate = DateFormat('dd MMM yyyy HH:mm').format(dt);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: user + opportunity + date
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    userDisplayName.isNotEmpty
                        ? userDisplayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userDisplayName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      Text(
                        opportunityTitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$tokenReward tokens',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.warning,
                    ),
                  ),
                ),
                if (formattedDate.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),

            // Prompt
            if (prompt.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prompt',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prompt,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Uploaded files
            if (uploadedFiles.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Submitted Files',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: uploadedFiles.map<Widget>((file) {
                  final fileMap = file is Map
                      ? Map<String, dynamic>.from(file)
                      : <String, dynamic>{};
                  final type = fileMap['type'] as String? ?? 'file';
                  final url = fileMap['url'] as String? ?? '';
                  final sizeBytes = (fileMap['sizeBytes'] as num?)?.toInt() ?? 0;

                  return _buildFileChip(
                    type: type,
                    url: url,
                    sizeBytes: sizeBytes,
                  );
                }).toList(),
              ),
            ],

            // Text response
            if (textResponse != null && textResponse.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Text Response',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      textResponse,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showRejectDialog(engagementId),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Reject'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _handleReview(
                    engagementId,
                    action: 'approve',
                  ),
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Approve'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileChip({
    required String type,
    required String url,
    required int sizeBytes,
  }) {
    final icon = type == 'video' ? Icons.videocam : Icons.image;
    final label = type == 'video' ? 'Video' : 'Image';
    final sizeMb = (sizeBytes / (1024 * 1024)).toStringAsFixed(1);

    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text('$label ($sizeMb MB)'),
      onPressed: url.isNotEmpty
          ? () async {
              final uri = Uri.tryParse(url);
              if (uri != null && await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            }
          : null,
    );
  }
}
