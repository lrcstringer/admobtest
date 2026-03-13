import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/utils/image_resize_utils.dart';
import '../../theme/app_colors.dart';

class FeaturedContentManagementScreen extends StatefulWidget {
  const FeaturedContentManagementScreen({super.key});

  @override
  State<FeaturedContentManagementScreen> createState() =>
      _FeaturedContentManagementScreenState();
}

class _FeaturedContentManagementScreenState
    extends State<FeaturedContentManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadItems();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadItems() async {
    setState(() => _isLoading = true);
    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminListFeaturedItems')
          .call<dynamic>({});
      final data = result.data as Map<String, dynamic>?;
      final list = (data?['items'] as List<dynamic>?) ?? [];
      if (mounted) {
        setState(() {
          _items = list
              .map((e) => Map<String, dynamic>.from(e as Map))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      // Fallback: direct Firestore read (active items only)
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('featuredItems')
            .where('isActive', isEqualTo: true)
            .orderBy('sortOrder')
            .get();
        if (mounted) {
          setState(() {
            _items = snapshot.docs.map((d) {
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

  List<Map<String, dynamic>> get _activeItems =>
      _items.where((i) => i['isActive'] == true).toList();

  List<Map<String, dynamic>> get _scheduledItems =>
      _items.where((i) {
        final start = i['scheduledStart'];
        if (start == null) return false;
        final startDate = start is Timestamp ? start.toDate() : DateTime.tryParse(start.toString());
        return startDate != null && startDate.isAfter(DateTime.now().toUtc());
      }).toList();

  List<Map<String, dynamic>> get _expiredItems =>
      _items.where((i) {
        final end = i['scheduledEnd'];
        if (end == null) return false;
        final endDate = end is Timestamp ? end.toDate() : DateTime.tryParse(end.toString());
        return endDate != null && endDate.isBefore(DateTime.now().toUtc());
      }).toList();

  @override
  Widget build(BuildContext context) {
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
                      'Featured Content',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage featured carousel items & campaigns',
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
                      icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
                      onPressed: _loadItems,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Create Item'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 40),
                      ),
                      onPressed: () => _showItemDialog(null),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats
            _buildStats(),
            const SizedBox(height: 20),

            // Tabs
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textTertiary,
              tabs: [
                Tab(text: 'Active (${_activeItems.length})'),
                Tab(text: 'Scheduled (${_scheduledItems.length})'),
                Tab(text: 'Expired (${_expiredItems.length})'),
              ],
            ),
            const SizedBox(height: 16),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildItemList(_activeItems),
                        _buildItemList(_scheduledItems),
                        _buildItemList(_expiredItems),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _StatCard(
          icon: Icons.star,
          color: AppColors.success,
          title: 'Active',
          value: '${_activeItems.length}',
        ),
        _StatCard(
          icon: Icons.schedule,
          color: AppColors.secondary,
          title: 'Scheduled',
          value: '${_scheduledItems.length}',
        ),
        _StatCard(
          icon: Icons.inventory_2,
          color: AppColors.textTertiary,
          title: 'Total',
          value: '${_items.length}',
        ),
      ],
    );
  }

  Widget _buildItemList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No items in this category',
          style: TextStyle(color: AppColors.textTertiary),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(
        color: AppColors.borderDark,
        height: 1,
      ),
      itemBuilder: (context, index) => _buildItemRow(items[index]),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    final isActive = item['isActive'] == true;
    final type = item['type'] as String? ?? 'campaign';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(6),
            ),
            clipBehavior: Clip.antiAlias,
            child: (item['imageUrl'] as String?)?.isNotEmpty == true
                ? Image.network(
                    item['imageUrl'] as String,
                    width: 60,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        color: AppColors.textTertiary,
                        size: 20),
                  )
                : const Icon(Icons.image,
                    color: AppColors.textTertiary, size: 20),
          ),
          const SizedBox(width: 12),
          // Title + type
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String? ?? 'Untitled',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          // Sort order
          Expanded(
            child: Text(
              '#${item['sortOrder'] ?? 0}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // Status
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                  color: isActive ? AppColors.success : AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            color: AppColors.cardDark,
            onSelected: (action) => _onItemAction(action, item),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(
                value: 'toggle',
                child: Text(isActive ? 'Deactivate' : 'Activate'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onItemAction(String action, Map<String, dynamic> item) async {
    switch (action) {
      case 'edit':
        _showItemDialog(item);
      case 'toggle':
        await _toggleItem(item);
      case 'delete':
        await _deleteItem(item);
    }
  }

  Future<void> _toggleItem(Map<String, dynamic> item) async {
    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminUpdateFeaturedItem')
          .call<dynamic>({
        'itemId': item['id'],
        'isActive': !(item['isActive'] == true),
      });
      _loadItems();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to toggle: $e')),
        );
      }
    }
  }

  Future<void> _deleteItem(Map<String, dynamic> item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Delete Featured Item?'),
        content: Text('Delete "${item['title']}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('adminDeleteFeaturedItem')
          .call<dynamic>({'itemId': item['id']});
      _loadItems();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: $e')),
        );
      }
    }
  }

  VoidCallback _pickImageFile(
    BuildContext ctx,
    StateSetter setInnerState,
    void Function(Uint8List bytes, String name) onPicked,
  ) {
    return () async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'],
          withData: true,
        );
        if (result != null && result.files.single.bytes != null) {
          setInnerState(() {
            onPicked(result.files.single.bytes!, result.files.single.name);
          });
        }
      } catch (e) {
        if (ctx.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to pick image: $e')),
          );
        }
      }
    };
  }

  VoidCallback _pickVideoFile(
    BuildContext ctx,
    StateSetter setInnerState,
    void Function(Uint8List bytes, String name) onPicked,
  ) {
    return () async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp4', 'mov', 'webm'],
          withData: true,
        );
        if (result != null && result.files.single.bytes != null) {
          final bytes = result.files.single.bytes!;
          if (bytes.lengthInBytes > 10 * 1024 * 1024) {
            if (ctx.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Video must be under 10 MB')),
              );
            }
            return;
          }
          setInnerState(() {
            onPicked(bytes, result.files.single.name);
          });
        }
      } catch (e) {
        if (ctx.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to pick video: $e')),
          );
        }
      }
    };
  }

  Future<String?> _uploadFeaturedVideo(
      String itemId, Uint8List videoBytes, String fileName) async {
    final ext = fileName.split('.').last.toLowerCase();
    final contentType = switch (ext) {
      'mov' => 'video/quicktime',
      'webm' => 'video/webm',
      _ => 'video/mp4',
    };

    final ref = FirebaseStorage.instance
        .ref()
        .child('featured_videos')
        .child('$itemId.$ext');

    await ref.putData(
      videoBytes,
      SettableMetadata(contentType: contentType),
    );

    return ref.getDownloadURL();
  }

  Future<String?> _uploadFeaturedImage(
      String itemId, Uint8List imageBytes) async {
    final resized =
        resizeImageForUpload(imageBytes, ImageResizeTarget.featuredImage);
    if (resized == null) throw Exception('Failed to process image');

    final ref = FirebaseStorage.instance
        .ref()
        .child('featured_images')
        .child('$itemId.${resized.extension}');

    await ref.putData(
      resized.bytes,
      SettableMetadata(contentType: resized.contentType),
    );

    return ref.getDownloadURL();
  }

  void _showItemDialog(Map<String, dynamic>? existing) {
    final isEdit = existing != null;
    final formKey = GlobalKey<FormState>();
    final titleCtrl =
        TextEditingController(text: existing?['title'] as String? ?? '');
    final subtitleCtrl =
        TextEditingController(text: existing?['subtitle'] as String? ?? '');
    final imageUrlCtrl =
        TextEditingController(text: existing?['imageUrl'] as String? ?? '');
    final brandNameCtrl = TextEditingController(
        text: existing?['brandName'] as String? ?? '');
    final ctaTextCtrl = TextEditingController(
        text: existing?['ctaText'] as String? ?? '');
    final deepLinkCtrl = TextEditingController(
        text: existing?['deepLinkRoute'] as String? ?? '');
    final sortOrderCtrl = TextEditingController(
        text: (existing?['sortOrder'] ?? 0).toString());
    var type = existing?['type'] as String? ?? 'campaign';
    var bgGradient = existing?['bgGradientType'] as String? ?? 'goldOrange';
    var isActive = existing?['isActive'] as bool? ?? true;
    var saving = false;

    // Scheduling state
    DateTime? scheduledStart;
    DateTime? scheduledEnd;
    final existingStart = existing?['scheduledStart'];
    final existingEnd = existing?['scheduledEnd'];
    if (existingStart != null) {
      scheduledStart = existingStart is Timestamp
          ? existingStart.toDate()
          : DateTime.tryParse(existingStart.toString());
    }
    if (existingEnd != null) {
      scheduledEnd = existingEnd is Timestamp
          ? existingEnd.toDate()
          : DateTime.tryParse(existingEnd.toString());
    }

    // Community filtering
    final communityIdsCtrl = TextEditingController(
        text: (existing?['communityIds'] as List<dynamic>?)?.join(', ') ?? '');

    // Image upload state
    Uint8List? pickedImageBytes;
    String? pickedImageName;
    var showManualUrl = false;

    // Video upload state
    Uint8List? pickedVideoBytes;
    String? pickedVideoName;
    final videoUrlCtrl = TextEditingController(
        text: existing?['videoUrl'] as String? ?? '');

    // Custom background state
    var customColorHex = existing?['bgColorHex'] as String?;
    var colorIntensity =
        (existing?['colorIntensity'] as num?)?.toDouble() ?? 0.4;
    var imageOpacity =
        (existing?['imageOpacity'] as num?)?.toDouble() ?? 0.3;
    var imageLayout =
        existing?['imageLayout'] as String? ?? 'right';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          final hasImage = pickedImageBytes != null ||
              imageUrlCtrl.text.trim().isNotEmpty;

          return AlertDialog(
            backgroundColor: AppColors.cardDark,
            title:
                Text(isEdit ? 'Edit Featured Item' : 'Create Featured Item'),
            content: SizedBox(
              width: 480,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Title *'),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: subtitleCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Subtitle'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: brandNameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Brand Name',
                          hintText: 'e.g. VODACOM',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: ctaTextCtrl,
                        decoration: const InputDecoration(
                          labelText: 'CTA Button Text',
                          hintText: 'e.g. Claim with Sasaza',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Image upload section ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Image',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary)),
                            const SizedBox(height: 8),
                            if (hasImage) ...[
                              // Image preview
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: pickedImageBytes != null
                                    ? Image.memory(pickedImageBytes!,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover)
                                    : Image.network(
                                        imageUrlCtrl.text.trim(),
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            Container(
                                          height: 120,
                                          color: AppColors.surface,
                                          child: const Center(
                                            child: Icon(Icons.broken_image,
                                                color:
                                                    AppColors.textTertiary),
                                          ),
                                        ),
                                      ),
                              ),
                              if (pickedImageName != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(pickedImageName!,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textTertiary)),
                                ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: _pickImageFile(
                                        ctx, setInnerState,
                                        (bytes, name) {
                                      pickedImageBytes = bytes;
                                      pickedImageName = name;
                                    }),
                                    icon: const Icon(Icons.swap_horiz,
                                        size: 16),
                                    label: const Text('Change Image'),
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(0, 36),
                                      side: const BorderSide(
                                          color: AppColors.border),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        size: 18, color: AppColors.error),
                                    tooltip: 'Remove image',
                                    onPressed: () => setInnerState(() {
                                      pickedImageBytes = null;
                                      pickedImageName = null;
                                      imageUrlCtrl.clear();
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Image layout toggle
                              Row(
                                children: [
                                  Text('Image Layout',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              AppColors.textSecondary)),
                                  const Spacer(),
                                  SegmentedButton<String>(
                                    segments: const [
                                      ButtonSegment(
                                          value: 'right',
                                          label: Text('Right Half',
                                              style: TextStyle(
                                                  fontSize: 11))),
                                      ButtonSegment(
                                          value: 'full',
                                          label: Text('Full Card',
                                              style: TextStyle(
                                                  fontSize: 11))),
                                    ],
                                    selected: {imageLayout},
                                    onSelectionChanged: (v) =>
                                        setInnerState(() =>
                                            imageLayout = v.first),
                                    style: const ButtonStyle(
                                      visualDensity:
                                          VisualDensity.compact,
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              // Empty state — prominent upload area
                              GestureDetector(
                                onTap: _pickImageFile(ctx, setInnerState,
                                    (bytes, name) {
                                  pickedImageBytes = bytes;
                                  pickedImageName = name;
                                }),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.border,
                                      style: BorderStyle.solid,
                                    ),
                                    color: AppColors.surface,
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.cloud_upload_outlined,
                                            size: 32,
                                            color: AppColors.textSecondary),
                                        SizedBox(height: 6),
                                        Text('Click to upload image',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors
                                                    .textSecondary)),
                                        SizedBox(height: 2),
                                        Text(
                                            'JPG, PNG, GIF, WebP — max 5 MB',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: AppColors
                                                    .textTertiary)),
                                        SizedBox(height: 4),
                                        Text(
                                            'Full card: 700×360 · Right half: 320×360',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors
                                                    .textTertiary)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: TextButton.icon(
                                  onPressed: () => setInnerState(
                                      () => showManualUrl = !showManualUrl),
                                  icon: Icon(
                                      showManualUrl
                                          ? Icons.expand_less
                                          : Icons.link,
                                      size: 16),
                                  label: Text(showManualUrl
                                      ? 'Hide URL field'
                                      : 'Or paste an image URL'),
                                ),
                              ),
                            ],
                            if (showManualUrl) ...[
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: imageUrlCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Image URL',
                                  hintText: 'https://...',
                                ),
                                onChanged: (_) => setInnerState(() {}),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Video upload section ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Video (optional)',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary)),
                                const SizedBox(width: 8),
                                if (pickedVideoBytes != null ||
                                    videoUrlCtrl.text.trim().isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.success
                                          .withValues(alpha: 0.15),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                    ),
                                    child: Text('Video set',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.success)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Short looping video, no audio. Replaces the image on the card.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textTertiary),
                            ),
                            const SizedBox(height: 8),
                            if (pickedVideoName != null ||
                                videoUrlCtrl.text.trim().isNotEmpty) ...[
                              Row(
                                children: [
                                  const Icon(Icons.videocam,
                                      size: 18,
                                      color: AppColors.textSecondary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      pickedVideoName ??
                                          videoUrlCtrl.text.trim(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        size: 18,
                                        color: AppColors.error),
                                    tooltip: 'Remove video',
                                    onPressed: () => setInnerState(() {
                                      pickedVideoBytes = null;
                                      pickedVideoName = null;
                                      videoUrlCtrl.clear();
                                    }),
                                  ),
                                ],
                              ),
                            ] else
                              OutlinedButton.icon(
                                onPressed: _pickVideoFile(
                                    ctx, setInnerState,
                                    (bytes, name) {
                                  pickedVideoBytes = bytes;
                                  pickedVideoName = name;
                                }),
                                icon: const Icon(Icons.videocam_outlined,
                                    size: 16),
                                label:
                                    const Text('Upload video (MP4, max 10 MB)'),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(0, 36),
                                  side: const BorderSide(
                                      color: AppColors.border),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration:
                            const InputDecoration(labelText: 'Type'),
                        items: const [
                          DropdownMenuItem(
                              value: 'campaign',
                              child: Text('Campaign')),
                          DropdownMenuItem(
                              value: 'collectible',
                              child: Text('Collectible')),
                          DropdownMenuItem(
                              value: 'trending',
                              child: Text('Trending')),
                          DropdownMenuItem(
                              value: 'promotion',
                              child: Text('Promotion')),
                        ],
                        onChanged: (v) =>
                            setInnerState(() => type = v ?? type),
                      ),
                      const SizedBox(height: 16),

                      // ── Background Style ──
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Background Style',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary)),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(
                                value: false,
                                label: Text('Preset Gradient')),
                            ButtonSegment(
                                value: true, label: Text('Custom')),
                          ],
                          selected: {bgGradient == 'custom'},
                          onSelectionChanged: (v) =>
                              setInnerState(() {
                            if (v.first) {
                              bgGradient = 'custom';
                            } else {
                              bgGradient = 'goldOrange';
                              customColorHex = null;
                            }
                          }),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (bgGradient != 'custom')
                        _buildPresetGradientPicker(
                          bgGradient,
                          (v) => setInnerState(() => bgGradient = v),
                        )
                      else
                        _buildCustomBgControls(
                          setInnerState: setInnerState,
                          selectedColorHex: customColorHex,
                          onColorSelected: (hex) =>
                              setInnerState(
                                  () => customColorHex = hex),
                          colorIntensity: colorIntensity,
                          onIntensityChanged: (v) =>
                              setInnerState(
                                  () => colorIntensity = v),
                          imageOpacity: imageOpacity,
                          onOpacityChanged: (v) =>
                              setInnerState(
                                  () => imageOpacity = v),
                          hasImage: hasImage,
                          imageLayout: imageLayout,
                          title: titleCtrl.text,
                          type: type,
                          brandName: brandNameCtrl.text,
                          ctaText: ctaTextCtrl.text,
                          imageBytes: pickedImageBytes,
                          imageUrl: imageUrlCtrl.text.trim(),
                        ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: deepLinkCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Link (route or URL)',
                          helperText:
                              'Internal: /buy/category/airtime  ·  External: https://example.com',
                          helperMaxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: sortOrderCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Sort Order'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        value: isActive,
                        title: const Text('Active'),
                        onChanged: (v) =>
                            setInnerState(() => isActive = v),
                      ),
                      const SizedBox(height: 12),

                      // ── Scheduling ──
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Schedule (optional)',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary)),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          scheduledStart != null
                              ? 'Start: ${scheduledStart!.day}/${scheduledStart!.month}/${scheduledStart!.year} '
                                  '${scheduledStart!.hour.toString().padLeft(2, '0')}:${scheduledStart!.minute.toString().padLeft(2, '0')}'
                              : 'Scheduled Start: Not set',
                          style: TextStyle(
                            fontSize: 13,
                            color: scheduledStart != null
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 18),
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: ctx,
                                  initialDate: scheduledStart ?? DateTime.now(),
                                  firstDate: DateTime.now().subtract(const Duration(days: 1)),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (date != null && ctx.mounted) {
                                  final time = await showTimePicker(
                                    context: ctx,
                                    initialTime: TimeOfDay.fromDateTime(
                                        scheduledStart ?? DateTime.now()),
                                  );
                                  if (time != null) {
                                    setInnerState(() {
                                      scheduledStart = DateTime(
                                          date.year, date.month, date.day,
                                          time.hour, time.minute);
                                    });
                                  }
                                }
                              },
                            ),
                            if (scheduledStart != null)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () =>
                                    setInnerState(() => scheduledStart = null),
                              ),
                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          scheduledEnd != null
                              ? 'End: ${scheduledEnd!.day}/${scheduledEnd!.month}/${scheduledEnd!.year} '
                                  '${scheduledEnd!.hour.toString().padLeft(2, '0')}:${scheduledEnd!.minute.toString().padLeft(2, '0')}'
                              : 'Scheduled End: Not set',
                          style: TextStyle(
                            fontSize: 13,
                            color: scheduledEnd != null
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 18),
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: ctx,
                                  initialDate: scheduledEnd ?? DateTime.now().add(const Duration(days: 7)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (date != null && ctx.mounted) {
                                  final time = await showTimePicker(
                                    context: ctx,
                                    initialTime: scheduledEnd != null
                                        ? TimeOfDay.fromDateTime(scheduledEnd!)
                                        : const TimeOfDay(hour: 23, minute: 59),
                                  );
                                  if (time != null) {
                                    setInnerState(() {
                                      scheduledEnd = DateTime(
                                          date.year, date.month, date.day,
                                          time.hour, time.minute);
                                    });
                                  }
                                }
                              },
                            ),
                            if (scheduledEnd != null)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () =>
                                    setInnerState(() => scheduledEnd = null),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Community filtering ──
                      TextFormField(
                        controller: communityIdsCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Community IDs (comma-separated, empty = all)',
                          hintText: 'community1,community2',
                          helperText: 'Leave empty to show to all users',
                          helperMaxLines: 2,
                        ),
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
                        setInnerState(() => saving = true);
                        if (!formKey.currentState!.validate()) {
                          setInnerState(() => saving = false);
                          return;
                        }

                        // Validate 1-hour minimum window between start and end
                        if (scheduledStart != null && scheduledEnd != null) {
                          final minEnd = scheduledStart!.add(const Duration(hours: 1));
                          if (scheduledEnd!.isBefore(minEnd)) {
                            setInnerState(() => saving = false);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Scheduled end must be at least 1 hour after start',
                                  ),
                                ),
                              );
                            }
                            return;
                          }
                        }
                        try {
                          final fn = isEdit
                              ? 'adminUpdateFeaturedItem'
                              : 'adminCreateFeaturedItem';

                          // For edits with picked media, upload first
                          String? uploadedImageUrl;
                          String? uploadedVideoUrl;
                          if (pickedImageBytes != null && isEdit) {
                            uploadedImageUrl = await _uploadFeaturedImage(
                                existing['id'] as String,
                                pickedImageBytes!);
                          }
                          if (pickedVideoBytes != null && isEdit) {
                            uploadedVideoUrl = await _uploadFeaturedVideo(
                                existing['id'] as String,
                                pickedVideoBytes!,
                                pickedVideoName ?? 'video.mp4');
                          }

                          final data = <String, dynamic>{
                            if (isEdit) 'itemId': existing['id'],
                            'title': titleCtrl.text.trim(),
                            'subtitle': subtitleCtrl.text.trim().isEmpty
                                ? null
                                : subtitleCtrl.text.trim(),
                            'imageUrl': uploadedImageUrl ??
                                (imageUrlCtrl.text.trim().isEmpty
                                    ? null
                                    : imageUrlCtrl.text.trim()),
                            'videoUrl': uploadedVideoUrl ??
                                (videoUrlCtrl.text.trim().isEmpty
                                    ? null
                                    : videoUrlCtrl.text.trim()),
                            'type': type,
                            'bgGradientType': bgGradient,
                            'bgColorHex':
                                bgGradient == 'custom' ? customColorHex : null,
                            'colorIntensity':
                                bgGradient == 'custom' ? colorIntensity : 0.4,
                            'imageOpacity':
                                bgGradient == 'custom' ? imageOpacity : 0.3,
                            'imageLayout': imageLayout,
                            'brandName': brandNameCtrl.text.trim().isEmpty
                                ? null
                                : brandNameCtrl.text.trim(),
                            'ctaText': ctaTextCtrl.text.trim().isEmpty
                                ? null
                                : ctaTextCtrl.text.trim(),
                            'deepLinkRoute':
                                deepLinkCtrl.text.trim().isEmpty
                                    ? null
                                    : deepLinkCtrl.text.trim(),
                            'sortOrder':
                                int.tryParse(sortOrderCtrl.text) ?? 0,
                            'isActive': isActive,
                            'scheduledStart':
                                scheduledStart?.toUtc().toIso8601String(),
                            'scheduledEnd':
                                scheduledEnd?.toUtc().toIso8601String(),
                            'communityIds': communityIdsCtrl.text
                                .split(',')
                                .map((s) => s.trim())
                                .where((s) => s.isNotEmpty)
                                .toList(),
                          };

                          final result =
                              await FirebaseFunctions.instanceFor(
                                      region: 'africa-south1')
                                  .httpsCallable(fn)
                                  .call<dynamic>(data);

                          // For creates with picked media, upload after
                          if ((!isEdit) &&
                              (pickedImageBytes != null ||
                                  pickedVideoBytes != null)) {
                            final resultData =
                                result.data as Map<String, dynamic>?;
                            final newItemId =
                                resultData?['itemId'] as String?;
                            if (newItemId != null) {
                              final updates = <String, dynamic>{
                                'itemId': newItemId,
                              };
                              if (pickedImageBytes != null) {
                                updates['imageUrl'] =
                                    await _uploadFeaturedImage(
                                        newItemId, pickedImageBytes!);
                              }
                              if (pickedVideoBytes != null) {
                                updates['videoUrl'] =
                                    await _uploadFeaturedVideo(
                                        newItemId,
                                        pickedVideoBytes!,
                                        pickedVideoName ?? 'video.mp4');
                              }
                              await FirebaseFunctions.instanceFor(
                                      region: 'africa-south1')
                                  .httpsCallable(
                                      'adminUpdateFeaturedItem')
                                  .call<dynamic>(updates);
                            }
                          }

                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _loadItems();
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

  // ── Preset gradient picker ──

  Widget _buildPresetGradientPicker(
    String selected,
    ValueChanged<String> onChanged,
  ) {
    const presets = <(String, String, Color, Color)>[
      ('Gold Orange', 'goldOrange', Color(0xFFFFB82C), Color(0xFFFF6429)),
      ('Cyan Blue', 'cyanBlue', Color(0xFF08C2F4), Color(0xFF0974FF)),
      ('Pink Purple', 'pinkPurple', Color(0xFFFF328C), Color(0xFFA011FF)),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: presets.map((p) {
        final isSelected = selected == p.$2;
        return Tooltip(
          message: p.$1,
          child: GestureDetector(
            onTap: () => onChanged(p.$2),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [p.$3, p.$4],
                ),
                border: isSelected
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: p.$3.withValues(alpha: 0.5),
                            blurRadius: 8)
                      ]
                    : null,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Custom background controls ──

  static String _colorToHex(Color c) =>
      '#${c.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  /// Parse a single color from the selectedColorHex string.
  Color _parseColor(String? hex, [Color fallback = const Color(0xFFFFB82C)]) {
    if (hex == null || hex.isEmpty) return fallback;
    final single = hex.contains(',') ? hex.split(',').first.trim() : hex;
    try {
      return Color(int.parse(single.replaceFirst('#', '0xFF')));
    } catch (_) {
      return fallback;
    }
  }

  /// Parse the end color for gradients.
  Color _parseEndColor(String? hex,
      [Color fallback = const Color(0xFFFF6429)]) {
    if (hex == null || !hex.contains(',')) return fallback;
    final second = hex.split(',').last.trim();
    try {
      return Color(int.parse(second.replaceFirst('#', '0xFF')));
    } catch (_) {
      return fallback;
    }
  }

  Widget _buildColorButton(
    BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Icon(Icons.edit, size: 16, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  void _showColorPickerDialog(
    BuildContext context,
    Color initial,
    ValueChanged<Color> onPicked,
  ) {
    var pickedColor = initial;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Pick a Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initial,
            onColorChanged: (c) => pickedColor = c,
            enableAlpha: false,
            hexInputBar: true,
            labelTypes: const [],
            pickerAreaBorderRadius: BorderRadius.circular(8),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onPicked(pickedColor);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary),
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBgControls({
    required void Function(VoidCallback) setInnerState,
    required String? selectedColorHex,
    required ValueChanged<String?> onColorSelected,
    required double colorIntensity,
    required ValueChanged<double> onIntensityChanged,
    required double imageOpacity,
    required ValueChanged<double> onOpacityChanged,
    required bool hasImage,
    required String imageLayout,
    required String title,
    required String type,
    required String brandName,
    required String ctaText,
    required Uint8List? imageBytes,
    required String imageUrl,
  }) {
    final isGradient = selectedColorHex?.contains(',') ?? false;
    final startColor = _parseColor(selectedColorHex);
    final endColor = _parseEndColor(selectedColorHex);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Live Preview ──
          Text('Preview',
              style:
                  TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          _buildPreviewCard(
            colorHex: selectedColorHex,
            intensity: colorIntensity,
            imgOpacity: imageOpacity,
            imgLayout: imageLayout,
            title: title.isEmpty ? 'Card Title' : title,
            type: type,
            brandName: brandName,
            ctaText: ctaText,
            imageBytes: imageBytes,
            imageUrl: imageUrl,
          ),
          const SizedBox(height: 16),

          // ── Solid / Gradient toggle ──
          Row(
            children: [
              Text('Color Type',
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const Spacer(),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                      value: false, label: Text('Solid')),
                  ButtonSegment(
                      value: true, label: Text('Gradient')),
                ],
                selected: {isGradient},
                onSelectionChanged: (v) {
                  if (v.first) {
                    // Switch to gradient: duplicate current color
                    final hex = _colorToHex(startColor);
                    onColorSelected('$hex,$hex');
                  } else {
                    // Switch to solid: keep first color
                    onColorSelected(_colorToHex(startColor));
                  }
                },
                style: const ButtonStyle(
                    visualDensity: VisualDensity.compact),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Color picker button(s) ──
          Row(
            children: [
              _buildColorButton(
                context,
                label: isGradient ? 'Start' : 'Color',
                color: startColor,
                onTap: () => _showColorPickerDialog(
                  context,
                  startColor,
                  (c) {
                    final hex = _colorToHex(c);
                    if (isGradient) {
                      onColorSelected(
                          '$hex,${_colorToHex(endColor)}');
                    } else {
                      onColorSelected(hex);
                    }
                  },
                ),
              ),
              if (isGradient) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward,
                      size: 16, color: AppColors.textTertiary),
                ),
                _buildColorButton(
                  context,
                  label: 'End',
                  color: endColor,
                  onTap: () => _showColorPickerDialog(
                    context,
                    endColor,
                    (c) {
                      onColorSelected(
                          '${_colorToHex(startColor)},${_colorToHex(c)}');
                    },
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // ── Color Intensity slider ──
          Row(
            children: [
              Text('Color Intensity',
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const Spacer(),
              Text('${(colorIntensity * 100).round()}%',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
            ],
          ),
          Slider(
            value: colorIntensity,
            min: 0.05,
            max: 0.8,
            divisions: 15,
            activeColor: AppColors.primary,
            onChanged: onIntensityChanged,
          ),

          // ── Image controls (only when image present) ──
          if (hasImage) ...[
            const SizedBox(height: 8),

            // Image opacity slider
            Row(
              children: [
                Text('Image Opacity',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const Spacer(),
                Text('${(imageOpacity * 100).round()}%',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ],
            ),
            Slider(
              value: imageOpacity,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              activeColor: AppColors.primary,
              onChanged: onOpacityChanged,
            ),
          ],
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }

  Widget _buildPreviewCard({
    required String? colorHex,
    required double intensity,
    required double imgOpacity,
    required String imgLayout,
    required String title,
    required String type,
    required String brandName,
    required String ctaText,
    required Uint8List? imageBytes,
    required String imageUrl,
  }) {
    // Resolve colors
    final List<Color> bgColors;
    if (colorHex != null && colorHex.isNotEmpty) {
      if (colorHex.contains(',')) {
        final parts = colorHex.split(',');
        bgColors =
            parts.map((h) => _hexToColor(h.trim())).toList();
      } else {
        final c = _hexToColor(colorHex);
        bgColors = [c, c];
      }
    } else {
      bgColors = [const Color(0xFFFFB82C), const Color(0xFFFFB82C)];
    }

    final darkBg = [
      Color.alphaBlend(
          bgColors[0].withValues(alpha: intensity), const Color(0xFF0D0D0D)),
      Color.alphaBlend(
          bgColors[bgColors.length > 1 ? 1 : 0]
              .withValues(alpha: intensity * 0.75),
          const Color(0xFF0D0D0D)),
    ];

    final isFullImage = imgLayout == 'full';
    final hasImg =
        imageBytes != null || (imageUrl.isNotEmpty);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: darkBg,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image layer
            if (hasImg)
              Opacity(
                opacity: imgOpacity,
                child: isFullImage
                    ? (imageBytes != null
                        ? Image.memory(imageBytes,
                            fit: BoxFit.contain)
                        : Image.network(imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox.shrink()))
                    : Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          child: imageBytes != null
                              ? Image.memory(imageBytes,
                                  fit: BoxFit.contain)
                              : Image.network(imageUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox.shrink()),
                        ),
                      ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _previewBadgeColor(type),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      type.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (brandName.isNotEmpty)
                    Text(
                      brandName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: bgColors[0],
                        letterSpacing: 0.5,
                      ),
                    ),
                  const Spacer(),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  if (ctaText.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB82C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        ctaText,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Color _previewBadgeColor(String type) {
    switch (type) {
      case 'promotion':
        return const Color(0xFFFF6429);
      case 'trending':
        return const Color(0xFF08C2F4);
      case 'collectible':
        return const Color(0xFFA011FF);
      default:
        return const Color(0xFFFFB82C);
    }
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
