import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/image_resize_utils.dart';
import '../../../data/models/brand_product_model.dart';
import '../../../domain/entities/brand_storefront.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buy/brand_storefront_hero.dart';
import '../../widgets/buy/storefront_preview.dart';
import '../widgets/svg_aware_image.dart';

/// Split-pane brand storefront builder (Spec §4.7).
/// Left panel: 5 tabs + Analytics. Right panel: phone-frame live preview.
/// Features: auto-save, undo/redo, section reorder, templates, validation.
class BrandStorefrontBuilderScreen extends StatefulWidget {
  /// null = create new storefront
  final String? storefrontId;

  const BrandStorefrontBuilderScreen({super.key, this.storefrontId});

  @override
  State<BrandStorefrontBuilderScreen> createState() =>
      _BrandStorefrontBuilderScreenState();
}

class _BrandStorefrontBuilderScreenState
    extends State<BrandStorefrontBuilderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _autoSaveTimer;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isDirty = false;
  bool _isPublished = false;

  // ─── Undo/Redo ───────────────────────────────────────────
  final List<Map<String, dynamic>> _undoStack = [];
  final List<Map<String, dynamic>> _redoStack = [];
  static const int _maxUndoStates = 30;

  // ─── Form Data ───────────────────────────────────────────
  Map<String, dynamic> _data = {};

  // Tab 1: Basics
  final _brandNameController = TextEditingController();
  final _brandIdController = TextEditingController();
  final _taglineController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _establishedYearController = TextEditingController();

  // Tab 2: Hero & Visual Identity
  // URLs are populated from Firestore or after upload — no longer user-editable.
  String _heroImageUrl = '';
  String _coverImageUrl = '';
  String _brandLogoUrl = '';
  // Upload progress: null = idle, 0..1 = in progress
  double? _heroImageProgress;
  double? _coverImageProgress;
  double? _brandLogoProgress;
  final _brandColorController = TextEditingController();
  final _accentColorController = TextEditingController();
  final _secondaryColorController = TextEditingController();
  double _heroFocalPointX = 0.5;
  double _heroFocalPointY = 0.5;
  String _heroStyle = 'fullBleedImage';

  // Tab 3: Content & Links
  String _bannerImageUrl = '';
  double? _bannerImageProgress;
  final _bannerDeepLinkController = TextEditingController();
  final _announcementTextController = TextEditingController();
  final _announcementDeepLinkController = TextEditingController();

  // Tab 4: Dynamic Content — managed as lists in _data
  List<String> _sectionOrder = [];
  Map<String, Map<String, dynamic>> _sectionSettings = {};

  // Tab 5: Products — loaded separately via CFs
  List<Map<String, dynamic>> _products = [];
  bool _isLoadingProducts = false;
  bool _productsLoaded = false;

  // Preview mode toggle
  bool _showAppPreview = false;
  int _previewRefreshKey = 0;

  final _functions = FirebaseFunctions.instanceFor(region: 'africa-south1');

  static const _allSectionTypes = [
    'quickActions',
    'featuredProducts',
    'products',
    'banner',
    'promotions',
    'gallery',
    'reviews',
    'about',
    'socialLinks',
    'announcementBar',
    'videoShowcase',
    'couponCenter',
    'faq',
    'testimonials',
    'locationCard',
    'divider',
    'richText',
  ];

  /// Sections backed by a single field — only one instance allowed.
  static const _singletonSections = {
    'quickActions',
    'featuredProducts',
    'products',
    'banner',
    'promotions',
    'gallery',
    'reviews',
    'about',
    'socialLinks',
    'announcementBar',
    'videoShowcase',
    'couponCenter',
    'faq',
    'testimonials',
    'locationCard',
    'richText',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Auto-populate Brand ID from Brand Name on create
    if (widget.storefrontId == null) {
      _brandNameController.addListener(_autopopulateBrandId);
    }
    _loadData();
    // Auto-save every 30 seconds
    _autoSaveTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (_isDirty && !_isSaving) _save();
      },
    );
  }

  /// Track whether the user has manually edited the Brand ID field.
  bool _brandIdManuallyEdited = false;

  void _autopopulateBrandId() {
    if (_brandIdManuallyEdited) return;
    final name = _brandNameController.text.trim();
    _brandIdController.text = _toCamelCase(name);
  }

  static String _toCamelCase(String input) {
    final words = input
        .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '';
    return [
      words.first.toLowerCase(),
      ...words.skip(1).map(
          (w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}'),
    ].join();
  }

  @override
  void dispose() {
    _brandNameController.removeListener(_autopopulateBrandId);
    _autoSaveTimer?.cancel();
    _tabController.dispose();
    _brandNameController.dispose();
    _brandIdController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    _establishedYearController.dispose();
    // _heroImageUrl, _coverImageUrl, _brandLogoUrl are plain strings — no dispose needed.
    _brandColorController.dispose();
    _accentColorController.dispose();
    _secondaryColorController.dispose();
    // _bannerImageUrl is a plain string — no dispose needed.
    _bannerDeepLinkController.dispose();
    _announcementTextController.dispose();
    _announcementDeepLinkController.dispose();
    super.dispose();
  }

  // ─── Data Loading ────────────────────────────────────────

  Future<void> _loadData() async {
    if (widget.storefrontId == null) {
      // New storefront — start with defaults
      _data = {
        'brandName': '',
        'brandId': '',
        'isActive': false,
        'isDeleted': false,
        'isDraft': true,
        'tier': 'standard',
        'heroStyle': 'fullBleedImage',
        'heroFocalPointX': 0.5,
        'heroFocalPointY': 0.5,
        'showChatButton': false,
        'sectionOrder': <String>[
          'quickActions',
          'featuredProducts',
          'products',
          'banner',
          'promotions',
          'gallery',
          'reviews',
          'about',
          'socialLinks',
        ],
        'sectionSettings': <String, dynamic>{},
        'trustBadges': <String>[],
        'quickActions': <dynamic>[],
        'socialLinks': <String, dynamic>{},
        'galleryImageUrls': <String>[],
        'promotions': <dynamic>[],
        'showcaseVideos': <dynamic>[],
        'coupons': <dynamic>[],
        'faqItems': <dynamic>[],
        'locations': <dynamic>[],
        'testimonialReviewIds': <String>[],
        'richTextBlocks': <String, dynamic>{},
      };
      _populateControllers();
      setState(() => _isLoading = false);
      return;
    }

    try {
      final result = await _functions
          .httpsCallable('adminListBrandStorefronts')
          .call<dynamic>({});
      final list =
          ((result.data as Map<String, dynamic>)['storefronts'] as List?) ?? [];
      final match = list.firstWhere(
        (s) => (s as Map)['id'] == widget.storefrontId,
        orElse: () => null,
      );
      if (match != null) {
        _data = Map<String, dynamic>.from(match as Map);
      }
    } catch (_) {
      // Fallback — just show empty
    }

    _populateControllers();
    _pushUndoState();
    if (mounted) setState(() => _isLoading = false);
  }

  void _populateControllers() {
    _brandNameController.text = _str('brandName');
    _brandIdController.text = _str('brandId');
    _taglineController.text = _str('tagline');
    _descriptionController.text = _str('description');
    _establishedYearController.text =
        _data['establishedYear']?.toString() ?? '';
    _heroImageUrl = _str('heroImageUrl');
    _coverImageUrl = _str('coverImageUrl');
    _brandLogoUrl = _str('brandLogoUrl');
    _brandColorController.text = _str('brandColor');
    _accentColorController.text = _str('accentColor');
    _secondaryColorController.text = _str('secondaryColor');
    _heroFocalPointX = (_data['heroFocalPointX'] as num?)?.toDouble() ?? 0.5;
    _heroFocalPointY = (_data['heroFocalPointY'] as num?)?.toDouble() ?? 0.5;
    _heroStyle = _str('heroStyle').isNotEmpty ? _str('heroStyle') : 'fullBleedImage';
    _bannerImageUrl = _str('bannerImageUrl');
    _bannerDeepLinkController.text = _str('bannerDeepLink');
    _announcementTextController.text = _str('announcementText');
    _announcementDeepLinkController.text = _str('announcementDeepLink');
    _isPublished = _data['isDraft'] != true;

    final orderRaw = _data['sectionOrder'];
    if (orderRaw is List) {
      final raw = orderRaw.cast<String>();
      // Deduplicate singleton sections (keep first occurrence)
      final seen = <String>{};
      _sectionOrder = raw.where((t) {
        if (_singletonSections.contains(t)) {
          return seen.add(t); // returns false if already present
        }
        return true; // non-singleton (e.g. divider) can repeat
      }).toList();
    }
    final settingsRaw = _data['sectionSettings'];
    if (settingsRaw is Map) {
      _sectionSettings = settingsRaw.map(
        (k, v) => MapEntry(k as String, Map<String, dynamic>.from(v as Map)),
      );
    }
  }

  String _str(String key) => (_data[key] as String?) ?? '';

  // ─── Undo / Redo ─────────────────────────────────────────

  void _pushUndoState() {
    _undoStack.add(Map<String, dynamic>.from(_data));
    if (_undoStack.length > _maxUndoStates) {
      _undoStack.removeAt(0);
    }
    _redoStack.clear();
  }

  void _undo() {
    if (_undoStack.length <= 1) return;
    _redoStack.add(_undoStack.removeLast());
    _data = Map<String, dynamic>.from(_undoStack.last);
    _populateControllers();
    setState(() => _isDirty = true);
  }

  void _redo() {
    if (_redoStack.isEmpty) return;
    final state = _redoStack.removeLast();
    _undoStack.add(state);
    _data = Map<String, dynamic>.from(state);
    _populateControllers();
    setState(() => _isDirty = true);
  }

  // ─── Save ────────────────────────────────────────────────

  void _markDirty() {
    _pushUndoState();
    setState(() {
      _isDirty = true;
      _previewRefreshKey++;
    });
  }

  void _collectFormData() {
    _data['brandName'] = _brandNameController.text.trim();
    _data['brandId'] = _brandIdController.text.trim();
    _data['tagline'] = _taglineController.text.trim().isEmpty
        ? null
        : _taglineController.text.trim();
    _data['description'] = _descriptionController.text.trim().isEmpty
        ? null
        : _descriptionController.text.trim();
    _data['establishedYear'] =
        int.tryParse(_establishedYearController.text.trim());
    _data['heroImageUrl'] = _heroImageUrl.isEmpty ? null : _heroImageUrl;
    _data['coverImageUrl'] = _coverImageUrl.isEmpty ? null : _coverImageUrl;
    _data['brandLogoUrl'] = _brandLogoUrl.isEmpty ? null : _brandLogoUrl;
    _data['brandColor'] = _brandColorController.text.trim().isEmpty
        ? null
        : _brandColorController.text.trim();
    _data['accentColor'] = _accentColorController.text.trim().isEmpty
        ? null
        : _accentColorController.text.trim();
    _data['secondaryColor'] = _secondaryColorController.text.trim().isEmpty
        ? null
        : _secondaryColorController.text.trim();
    _data['heroFocalPointX'] = _heroFocalPointX;
    _data['heroFocalPointY'] = _heroFocalPointY;
    _data['heroStyle'] = _heroStyle;
    _data['bannerImageUrl'] = _bannerImageUrl.isEmpty ? null : _bannerImageUrl;
    _data['bannerDeepLink'] = _bannerDeepLinkController.text.trim().isEmpty
        ? null
        : _bannerDeepLinkController.text.trim();
    _data['announcementText'] =
        _announcementTextController.text.trim().isEmpty
            ? null
            : _announcementTextController.text.trim();
    _data['announcementDeepLink'] =
        _announcementDeepLinkController.text.trim().isEmpty
            ? null
            : _announcementDeepLinkController.text.trim();
    _data['sectionOrder'] = _sectionOrder;
    _data['sectionSettings'] = _sectionSettings;
  }

  Future<void> _save() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    _collectFormData();

    // Use widget param OR the ID returned from a prior create
    final existingId =
        widget.storefrontId ?? (_data['id'] as String?);

    try {
      if (existingId != null && existingId.isNotEmpty) {
        await _functions
            .httpsCallable('adminUpdateBrandStorefront')
            .call<dynamic>({
          'storefrontId': existingId,
          ..._data,
        });
      } else {
        final result = await _functions
            .httpsCallable('adminCreateBrandStorefront')
            .call<dynamic>(_data);
        final newId =
            (result.data as Map<String, dynamic>?)?['storefrontId'] as String?;
        if (newId != null) {
          _data['id'] = newId;
        }
      }
      if (mounted) {
        setState(() {
          _isDirty = false;
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    }
  }

  Future<void> _publish() async {
    _collectFormData();
    // Validate required fields
    final errors = <String>[];
    if (_brandNameController.text.trim().isEmpty) {
      errors.add('Brand name is required');
    }
    if (_brandLogoUrl.isEmpty) {
      errors.add('Brand logo is required');
    }
    if (_sectionOrder.isEmpty) {
      errors.add('At least one section is required');
    }

    if (errors.isNotEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Validation: ${errors.join(', ')}')),
        );
      }
      return;
    }

    _data['isDraft'] = false;
    _data['isActive'] = true;
    _data['isDeleted'] = false;
    _data['publishedAt'] = DateTime.now().toIso8601String();
    await _save();
    setState(() => _isPublished = true);
  }

  // ─── Templates ───────────────────────────────────────────

  static const Map<String, List<String>> _templates = {
    'Telecom': [
      'announcementBar',
      'quickActions',
      'featuredProducts',
      'products',
      'couponCenter',
      'faq',
      'about',
      'socialLinks',
    ],
    'Retail': [
      'banner',
      'featuredProducts',
      'products',
      'promotions',
      'gallery',
      'reviews',
      'locationCard',
      'about',
      'socialLinks',
    ],
    'Restaurant': [
      'videoShowcase',
      'gallery',
      'promotions',
      'reviews',
      'testimonials',
      'locationCard',
      'about',
      'socialLinks',
    ],
    'Services': [
      'quickActions',
      'about',
      'faq',
      'testimonials',
      'reviews',
      'locationCard',
      'socialLinks',
    ],
    'Entertainment': [
      'announcementBar',
      'videoShowcase',
      'gallery',
      'featuredProducts',
      'couponCenter',
      'reviews',
      'socialLinks',
    ],
  };

  void _applyTemplate(String name) {
    final sections = _templates[name];
    if (sections == null) return;
    _sectionOrder = List<String>.from(sections);
    _data['sectionOrder'] = _sectionOrder;
    _markDirty();
  }

  // ─── Keyboard shortcuts ──────────────────────────────────

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final ctrl = HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed;
    if (ctrl && event.logicalKey == LogicalKeyboardKey.keyZ) {
      if (HardwareKeyboard.instance.isShiftPressed) {
        _redo();
      } else {
        _undo();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  // ─── Build ───────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: AppColors.adminBackground,
        appBar: _buildAppBar(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  // Left panel: editor tabs
                  Expanded(
                    flex: 5,
                    child: _buildEditorPanel(),
                  ),
                  const VerticalDivider(width: 1, color: AppColors.borderDark),
                  // Right panel: live preview
                  Expanded(
                    flex: 3,
                    child: _buildPreviewPanel(),
                  ),
                ],
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.adminSurface,
      elevation: 2,
      shadowColor: Colors.black45,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        tooltip: 'Back to Storefronts',
        onPressed: () {
          if (_isDirty) {
            showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: AppColors.adminCard,
                title: const Text('Unsaved changes'),
                content:
                    const Text('Save before leaving?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 40),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.go('/buy-brand-storefronts');
                    },
                    child: const Text('Discard'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                    ),
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                      await _save();
                      if (mounted) context.go('/buy-brand-storefronts');
                    },
                    child: const Text('Save & Exit'),
                  ),
                ],
              ),
            );
          } else {
            context.go('/buy-brand-storefronts');
          }
        },
      ),
      title: Text(
        widget.storefrontId != null
            ? 'Edit Storefront'
            : 'Create Storefront',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      actions: [
        // Save button
        OutlinedButton.icon(
          icon: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.save_outlined, size: 18),
          label: const Text('Save Draft'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minimumSize: const Size(0, 40),
          ),
          onPressed: _isDirty && !_isSaving ? _save : null,
        ),
        const SizedBox(width: 12),
        // Publish button
        ElevatedButton.icon(
          icon: Icon(
            _isPublished ? Icons.check_circle : Icons.publish,
            size: 18,
          ),
          label: Text(_isPublished ? 'Published' : 'Publish'),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _isPublished ? AppColors.success : AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            minimumSize: const Size(0, 40),
          ),
          onPressed: !_isPublished ? _publish : null,
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // ─── Editor Panel ────────────────────────────────────────

  Widget _buildEditorPanel() {
    return Column(
      children: [
        // Tab bar
        Container(
          color: AppColors.adminCard,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'Basics'),
              Tab(text: 'Hero & Visual'),
              Tab(text: 'Dynamic Content'),
              Tab(text: 'Products'),
              Tab(text: 'Analytics'),
            ],
          ),
        ),
        // Tab body
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBasicsTab(),
              _buildHeroVisualTab(),
              _buildDynamicContentTab(),
              _buildProductsTab(),
              _buildAnalyticsTab(),
            ],
          ),
        ),
        // Bottom bar — undo/redo + status
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.adminSurface,
        border: Border(
          top: BorderSide(color: AppColors.borderDark.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          // Undo
          IconButton(
            icon: Icon(
              Icons.undo,
              color: _undoStack.length > 1
                  ? Colors.white
                  : Colors.white24,
              size: 20,
            ),
            tooltip: 'Undo (Ctrl+Z)',
            onPressed: _undoStack.length > 1 ? _undo : null,
          ),
          // Redo
          IconButton(
            icon: Icon(
              Icons.redo,
              color: _redoStack.isNotEmpty
                  ? Colors.white
                  : Colors.white24,
              size: 20,
            ),
            tooltip: 'Redo (Ctrl+Shift+Z)',
            onPressed: _redoStack.isNotEmpty ? _redo : null,
          ),
          const SizedBox(width: 12),
          // Unsaved indicator
          if (_isDirty) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Unsaved changes',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ] else ...[
            const Icon(Icons.cloud_done_outlined,
                size: 16, color: AppColors.textTertiary),
            const SizedBox(width: 6),
            const Text(
              'All changes saved',
              style: TextStyle(
                color: AppColors.textTertiary,
                fontSize: 12,
              ),
            ),
          ],
          const Spacer(),
          // Auto-save hint
          const Text(
            'Auto-saves every 30s',
            style: TextStyle(
              color: AppColors.textTertiary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Tab 1: Basics ──────────────────────────────────────

  Widget _buildBasicsTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Templates (only on create)
        if (widget.storefrontId == null) ...[
          const Text(
            'Start from template',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _templates.keys.map((name) {
              return ActionChip(
                label: Text(name),
                backgroundColor: AppColors.adminSurface,
                labelStyle: const TextStyle(color: AppColors.textPrimary),
                onPressed: () => _applyTemplate(name),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
        _field('Brand Name *', _brandNameController),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextField(
            controller: _brandIdController,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: _inputDecoration('Brand ID (Firestore doc ID)'),
            onChanged: (_) {
              _brandIdManuallyEdited = true;
              _markDirty();
            },
          ),
        ),
        _field('Tagline', _taglineController),
        _field('Description', _descriptionController, maxLines: 4),
        _field('Established Year', _establishedYearController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        // Show Chat Button toggle
        SwitchListTile(
          title: const Text('Show Chat Button',
              style: TextStyle(color: AppColors.textPrimary)),
          subtitle: const Text('Floating chat FAB on storefront',
              style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
          value: _data['showChatButton'] == true,
          activeThumbColor: AppColors.primary,
          onChanged: (v) {
            _data['showChatButton'] = v;
            _markDirty();
          },
        ),
        // Premium Brand toggle
        SwitchListTile(
          title: const Text('Premium Brand',
              style: TextStyle(color: AppColors.textPrimary)),
          subtitle: const Text('Gold badge and priority placement',
              style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
          value: _data['isPremium'] == true,
          activeThumbColor: AppColors.gold,
          onChanged: (v) {
            _data['isPremium'] = v;
            _markDirty();
          },
        ),
        // Trust Badges
        const SizedBox(height: 16),
        const Text('Trust Badges',
            style: TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['verified', 'topSeller', 'localBusiness', 'newBrand']
              .map((badge) {
            final badges =
                (_data['trustBadges'] as List<dynamic>?)?.cast<String>() ?? [];
            final isSelected = badges.contains(badge);
            return FilterChip(
              label: Text(badge),
              selected: isSelected,
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              onSelected: (selected) {
                if (selected) {
                  badges.add(badge);
                } else {
                  badges.remove(badge);
                }
                _data['trustBadges'] = badges;
                _markDirty();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // ─── Tab 2: Hero & Visual Identity ──────────────────────

  Widget _buildHeroVisualTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Hero style dropdown
        const Text('Hero Style',
            style: TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _heroStyle,
          dropdownColor: AppColors.adminCard,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _inputDecoration(''),
          items: const [
            DropdownMenuItem(
                value: 'fullBleedImage', child: Text('Full Bleed Image')),
            DropdownMenuItem(
                value: 'gradientOverlay', child: Text('Gradient Overlay')),
            DropdownMenuItem(value: 'minimal', child: Text('Minimal')),
          ],
          onChanged: (v) {
            if (v == null) return;
            _heroStyle = v;
            _markDirty();
          },
        ),
        const SizedBox(height: 16),
        _imageUploadField(
          label: 'Hero Image',
          currentUrl: _heroImageUrl,
          progress: _heroImageProgress,
          storageSuffix: 'hero',
          onUploaded: (url) => setState(() {
            _heroImageUrl = url;
            _markDirty();
          }),
          onRemoved: () => setState(() {
            _heroImageUrl = '';
            _markDirty();
          }),
          onProgressChanged: (p) =>
              setState(() => _heroImageProgress = p),
        ),
        _imageUploadField(
          label: 'Cover Image (fallback)',
          currentUrl: _coverImageUrl,
          progress: _coverImageProgress,
          storageSuffix: 'cover',
          onUploaded: (url) => setState(() {
            _coverImageUrl = url;
            _markDirty();
          }),
          onRemoved: () => setState(() {
            _coverImageUrl = '';
            _markDirty();
          }),
          onProgressChanged: (p) =>
              setState(() => _coverImageProgress = p),
        ),
        _imageUploadField(
          label: 'Brand Logo *',
          currentUrl: _brandLogoUrl,
          progress: _brandLogoProgress,
          storageSuffix: 'logo',
          onUploaded: (url) => setState(() {
            _brandLogoUrl = url;
            _markDirty();
          }),
          onRemoved: () => setState(() {
            _brandLogoUrl = '';
            _markDirty();
          }),
          onProgressChanged: (p) =>
              setState(() => _brandLogoProgress = p),
        ),

        // Focal point editor
        if (_heroImageUrl.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text('Hero Focal Point',
              style: TextStyle(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(
            'Drag the pin to set the focal point (${_heroFocalPointX.toStringAsFixed(2)}, ${_heroFocalPointY.toStringAsFixed(2)})',
            style: const TextStyle(
                color: AppColors.textTertiary, fontSize: 12),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _heroFocalPointX = (details.localPosition.dx /
                              constraints.maxWidth)
                          .clamp(0.0, 1.0);
                      _heroFocalPointY = (details.localPosition.dy / 160)
                          .clamp(0.0, 1.0);
                    });
                    _markDirty();
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: _heroImageUrl,
                          width: constraints.maxWidth,
                          height: 160,
                          fit: BoxFit.cover,
                          alignment: Alignment(
                            _heroFocalPointX * 2 - 1,
                            _heroFocalPointY * 2 - 1,
                          ),
                          errorWidget: (_, _, _) => Container(
                            color: AppColors.adminSurface,
                            child: const Center(
                                child: Text('Image load error',
                                    style: TextStyle(
                                        color: AppColors.textTertiary))),
                          ),
                        ),
                      ),
                      Positioned(
                        left: _heroFocalPointX * constraints.maxWidth - 12,
                        top: _heroFocalPointY * 160 - 12,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.center_focus_strong,
                              size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],

        const SizedBox(height: 20),
        const Divider(color: AppColors.borderDark),
        const SizedBox(height: 12),
        const Text('Colour Palette',
            style: TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _colorField('Brand Color', _brandColorController),
        _colorField('Accent Color', _accentColorController),
        _colorField('Secondary Color', _secondaryColorController),
      ],
    );
  }

  // ─── Tab 3: Dynamic Content (Sections) ──────────────────

  Widget _buildDynamicContentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add section button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Section Order',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.add_circle_outline,
                    color: AppColors.primary),
                tooltip: 'Add section',
                color: AppColors.adminCard,
                onSelected: (type) {
                  _sectionOrder.add(type);
                  _markDirty();
                },
                itemBuilder: (_) {
                  final existing = _sectionOrder.toSet();
                  return _allSectionTypes
                      .where((t) =>
                          !_singletonSections.contains(t) ||
                          !existing.contains(t))
                      .map((t) => PopupMenuItem(value: t, child: Text(t)))
                      .toList();
                },
              ),
            ],
          ),
        ),
        // Reorderable list
        Expanded(
          child: _sectionOrder.isEmpty
              ? const Center(
                  child: Text('No sections. Add one above.',
                      style: TextStyle(color: AppColors.textTertiary)),
                )
              : ReorderableListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _sectionOrder.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _sectionOrder.removeAt(oldIndex);
                    _sectionOrder.insert(newIndex, item);
                    _markDirty();
                  },
                  itemBuilder: (_, index) {
                    final type = _sectionOrder[index];
                    final settings = _sectionSettings[type];
                    final isVisible = settings?['isVisible'] != false;
                    final editable = _isSectionEditable(type);
                    return ListTile(
                      key: ValueKey('$type-$index'),
                      tileColor: AppColors.adminSurface,
                      leading: Icon(_sectionIcon(type),
                          color: isVisible
                              ? AppColors.textSecondary
                              : AppColors.textTertiary,
                          size: 20),
                      title: Text(type,
                          style: TextStyle(
                            color: isVisible
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                            fontWeight: FontWeight.w500,
                            decoration: isVisible
                                ? null
                                : TextDecoration.lineThrough,
                          )),
                      subtitle: editable
                          ? null
                          : Text(
                              _sectionHint(type),
                              style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 11),
                            ),
                      onTap: editable ? () => _editSection(type) : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (editable)
                            const Icon(Icons.edit_outlined,
                                size: 16,
                                color: AppColors.textTertiary),
                          // Visibility toggle
                          IconButton(
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20,
                              color: isVisible
                                  ? AppColors.primary
                                  : AppColors.textTertiary,
                            ),
                            onPressed: () {
                              _sectionSettings.putIfAbsent(
                                  type, () => <String, dynamic>{});
                              _sectionSettings[type]!['isVisible'] = !isVisible;
                              _markDirty();
                            },
                          ),
                          // Remove
                          IconButton(
                            icon: const Icon(Icons.close,
                                size: 20, color: AppColors.error),
                            onPressed: () {
                              _sectionOrder.removeAt(index);
                              _markDirty();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ─── Section Helpers ────────────────────────────────────

  IconData _sectionIcon(String type) => switch (type) {
        'quickActions' => Icons.touch_app_outlined,
        'featuredProducts' => Icons.star_outline,
        'products' => Icons.shopping_bag_outlined,
        'banner' => Icons.image_outlined,
        'promotions' => Icons.local_offer_outlined,
        'gallery' => Icons.photo_library_outlined,
        'reviews' => Icons.rate_review_outlined,
        'about' => Icons.info_outline,
        'socialLinks' => Icons.share_outlined,
        'announcementBar' => Icons.campaign_outlined,
        'videoShowcase' => Icons.videocam_outlined,
        'couponCenter' => Icons.confirmation_num_outlined,
        'faq' => Icons.help_outline,
        'testimonials' => Icons.format_quote_outlined,
        'locationCard' => Icons.location_on_outlined,
        'divider' => Icons.horizontal_rule,
        'richText' => Icons.article_outlined,
        _ => Icons.extension_outlined,
      };

  bool _isSectionEditable(String type) => switch (type) {
        'featuredProducts' ||
        'products' ||
        'reviews' ||
        'about' ||
        'testimonials' ||
        'divider' =>
          false,
        _ => true,
      };

  String _sectionHint(String type) => switch (type) {
        'featuredProducts' => 'Auto from Products tab (isFeatured)',
        'products' => 'Auto from Products tab',
        'reviews' => 'Auto from user reviews',
        'about' => 'Uses Description & Year from Basics',
        'testimonials' => 'Auto from top reviews',
        'divider' => 'Visual separator — no config needed',
        _ => '',
      };

  // ─── Section Editor Dispatcher ──────────────────────────

  void _editSection(String type) {
    switch (type) {
      case 'quickActions':
        _editQuickActions();
      case 'banner':
        _editBanner();
      case 'promotions':
        _editPromotions();
      case 'gallery':
        _editGallery();
      case 'socialLinks':
        _editSocialLinks();
      case 'announcementBar':
        _editAnnouncementBar();
      case 'videoShowcase':
        _editVideoShowcase();
      case 'couponCenter':
        _editCouponCenter();
      case 'faq':
        _editFaq();
      case 'locationCard':
        _editLocationCard();
      case 'richText':
        _editRichText();
    }
  }

  // ─── Shared dialog helpers ──────────────────────────────

  /// Standard section editor dialog shell.
  Future<void> _showSectionDialog({
    required String title,
    required Widget Function(BuildContext ctx, StateSetter setDialogState)
        builder,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.adminSurface,
          title: Text(title,
              style: const TextStyle(color: AppColors.textPrimary)),
          content: SizedBox(
            width: 520,
            child: builder(ctx, setDialogState),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child:
                  const Text('Done', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dialogInput(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textTertiary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderDark),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: AppColors.adminCard,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      );

  // ─── Quick Actions Editor ──────────────────────────────

  void _editQuickActions() {
    final actions = ((_data['quickActions'] as List?) ?? [])
        .map((a) => Map<String, dynamic>.from(a as Map))
        .toList();

    _showSectionDialog(
      title: 'Quick Actions',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 350),
              child: actions.isEmpty
                  ? const Center(
                      child: Text('No actions yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : ReorderableListView.builder(
                      shrinkWrap: true,
                      itemCount: actions.length,
                      onReorder: (o, n) {
                        if (n > o) n--;
                        final item = actions.removeAt(o);
                        actions.insert(n, item);
                        setDialogState(() {});
                        _data['quickActions'] = actions;
                        _markDirty();
                      },
                      itemBuilder: (_, i) {
                        final a = actions[i];
                        return ListTile(
                          key: ValueKey('qa-$i'),
                          leading: Text(
                            a['iconEmoji'] as String? ?? '⚡',
                            style: const TextStyle(fontSize: 20),
                          ),
                          title: Text(a['label'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textPrimary)),
                          subtitle: Text(
                              a['deepLink'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 11)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18,
                                    color: AppColors.textSecondary),
                                onPressed: () => _editSingleQuickAction(
                                    actions, i, setDialogState),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: AppColors.error),
                                onPressed: () {
                                  actions.removeAt(i);
                                  _data['quickActions'] = actions;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Action'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () =>
                  _editSingleQuickAction(actions, null, setDialogState),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSingleQuickAction(List<Map<String, dynamic>> actions,
      int? editIndex, StateSetter parentSetState) async {
    final existing = editIndex != null ? actions[editIndex] : null;
    final labelCtrl =
        TextEditingController(text: existing?['label'] as String? ?? '');
    final emojiCtrl =
        TextEditingController(text: existing?['iconEmoji'] as String? ?? '');
    final linkCtrl =
        TextEditingController(text: existing?['deepLink'] as String? ?? '');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminSurface,
        title: Text(editIndex != null ? 'Edit Action' : 'Add Action',
            style: const TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: labelCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Label *')),
            const SizedBox(height: 10),
            TextField(
                controller: emojiCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Icon Emoji (e.g. 🛒)')),
            const SizedBox(height: 10),
            TextField(
                controller: linkCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Deep Link')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36)),
            onPressed: () {
              if (labelCtrl.text.trim().isEmpty) { return; }
              final entry = {
                'label': labelCtrl.text.trim(),
                'iconEmoji': emojiCtrl.text.trim().isEmpty
                    ? '⚡'
                    : emojiCtrl.text.trim(),
                'deepLink': linkCtrl.text.trim(),
                'sortOrder': editIndex ?? actions.length,
              };
              if (editIndex != null) {
                actions[editIndex] = entry;
              } else {
                actions.add(entry);
              }
              _data['quickActions'] = actions;
              _markDirty();
              parentSetState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ─── Banner Editor ─────────────────────────────────────

  void _editBanner() {
    _showSectionDialog(
      title: 'Banner',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _imageUploadField(
              label: 'Banner Image',
              currentUrl: _bannerImageUrl,
              progress: _bannerImageProgress,
              storageSuffix: 'banner',
              fit: BoxFit.contain,
              height: 160,
              onUploaded: (url) {
                setState(() => _bannerImageUrl = url);
                setDialogState(() {});
                _markDirty();
              },
              onRemoved: () {
                setState(() => _bannerImageUrl = '');
                setDialogState(() {});
                _markDirty();
              },
              onProgressChanged: (p) {
                setState(() => _bannerImageProgress = p);
                setDialogState(() {});
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bannerDeepLinkController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _dialogInput('Banner Deep Link'),
              onChanged: (_) => _markDirty(),
            ),
          ],
        );
      },
    );
  }

  // ─── Promotions Editor ─────────────────────────────────

  void _editPromotions() {
    final promos = ((_data['promotions'] as List?) ?? [])
        .map((p) => Map<String, dynamic>.from(p as Map))
        .toList();

    _showSectionDialog(
      title: 'Promotions',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: promos.isEmpty
                  ? const Center(
                      child: Text('No promotions yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: promos.length,
                      itemBuilder: (_, i) {
                        final p = promos[i];
                        return ListTile(
                          title: Text(p['title'] as String? ?? 'Untitled',
                              style: const TextStyle(
                                  color: AppColors.textPrimary)),
                          subtitle: Text(
                              p['description'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 11)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18,
                                    color: AppColors.textSecondary),
                                onPressed: () => _editSinglePromo(
                                    promos, i, setDialogState),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: AppColors.error),
                                onPressed: () {
                                  promos.removeAt(i);
                                  _data['promotions'] = promos;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Promotion'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () =>
                  _editSinglePromo(promos, null, setDialogState),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSinglePromo(List<Map<String, dynamic>> promos,
      int? editIndex, StateSetter parentSetState) async {
    final existing = editIndex != null ? promos[editIndex] : null;
    final titleCtrl =
        TextEditingController(text: existing?['title'] as String? ?? '');
    final descCtrl = TextEditingController(
        text: existing?['description'] as String? ?? '');
    final linkCtrl =
        TextEditingController(text: existing?['deepLink'] as String? ?? '');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminSurface,
        title: Text(editIndex != null ? 'Edit Promotion' : 'Add Promotion',
            style: const TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Title *')),
            const SizedBox(height: 10),
            TextField(
                controller: descCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Description'),
                maxLines: 2),
            const SizedBox(height: 10),
            TextField(
                controller: linkCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Deep Link')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36)),
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) { return; }
              final entry = <String, dynamic>{
                'title': titleCtrl.text.trim(),
                'description': descCtrl.text.trim().isEmpty
                    ? null
                    : descCtrl.text.trim(),
                'deepLink': linkCtrl.text.trim().isEmpty
                    ? null
                    : linkCtrl.text.trim(),
              };
              if (editIndex != null) {
                promos[editIndex] = entry;
              } else {
                promos.add(entry);
              }
              _data['promotions'] = promos;
              _markDirty();
              parentSetState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ─── Gallery Editor ────────────────────────────────────

  void _editGallery() {
    final images =
        ((_data['galleryImageUrls'] as List?) ?? []).cast<String>().toList();
    double? uploadProgress;

    _showSectionDialog(
      title: 'Gallery',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: images.isEmpty
                  ? const Center(
                      child: Text('No images yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: images.length,
                      itemBuilder: (_, i) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: images[i],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: GestureDetector(
                                onTap: () {
                                  images.removeAt(i);
                                  _data['galleryImageUrls'] = images;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(Icons.close,
                                      size: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            if (uploadProgress != null) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                  value: uploadProgress, color: AppColors.primary),
            ],
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_photo_alternate, size: 18),
              label: const Text('Upload Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: adminImageExtensions,
                  withData: true,
                );
                if (result == null || result.files.single.bytes == null) {
                  return;
                }
                setDialogState(() => uploadProgress = 0.0);
                try {
                  final url = await uploadAdminImage(
                    bytes: result.files.single.bytes!,
                    fileName: result.files.single.name,
                    storagePath:
                        'brand_assets/$_effectiveStorefrontId/gallery',
                    fileId:
                        'gal_${DateTime.now().millisecondsSinceEpoch}',
                    resizeTarget: ImageResizeTarget.featuredImage,
                    onProgress: (p) =>
                        setDialogState(() => uploadProgress = p),
                  );
                  images.add(url);
                  _data['galleryImageUrls'] = images;
                  _markDirty();
                  setDialogState(() => uploadProgress = null);
                } catch (e) {
                  setDialogState(() => uploadProgress = null);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Upload failed: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  // ─── Social Links Editor ───────────────────────────────

  void _editSocialLinks() {
    final links =
        (_data['socialLinks'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final platforms = [
      'whatsapp',
      'instagram',
      'facebook',
      'website',
      'tiktok',
      'x',
      'youtube',
    ];
    final controllers = {
      for (final p in platforms)
        p: TextEditingController(text: links[p] as String? ?? ''),
    };

    _showSectionDialog(
      title: 'Social Links',
      builder: (ctx, setDialogState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: platforms.map((platform) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: controllers[platform],
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _dialogInput(
                    platform[0].toUpperCase() + platform.substring(1),
                  ),
                  onChanged: (v) {
                    links[platform] =
                        v.trim().isEmpty ? null : v.trim();
                    _data['socialLinks'] = links;
                    _markDirty();
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // ─── Announcement Bar Editor ───────────────────────────

  void _editAnnouncementBar() {
    _showSectionDialog(
      title: 'Announcement Bar',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _announcementTextController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _dialogInput('Announcement Text'),
              onChanged: (_) => _markDirty(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _announcementDeepLinkController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _dialogInput('Deep Link'),
              onChanged: (_) => _markDirty(),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Dismissible',
                  style: TextStyle(color: AppColors.textPrimary)),
              value: _data['announcementDismissible'] != false,
              activeThumbColor: AppColors.primary,
              tileColor: AppColors.adminCard,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onChanged: (v) {
                _data['announcementDismissible'] = v;
                _markDirty();
                setDialogState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  // ─── Video Showcase Editor ─────────────────────────────

  void _editVideoShowcase() {
    final videos = ((_data['showcaseVideos'] as List?) ?? [])
        .map((v) => Map<String, dynamic>.from(v as Map))
        .toList();

    _showSectionDialog(
      title: 'Video Showcase',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: videos.isEmpty
                  ? const Center(
                      child: Text('No videos yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: videos.length,
                      itemBuilder: (_, i) {
                        final v = videos[i];
                        return ListTile(
                          leading: v['thumbnailUrl'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        v['thumbnailUrl'] as String,
                                    width: 48,
                                    height: 36,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.videocam,
                                  color: AppColors.textTertiary),
                          title: Text(
                              v['title'] as String? ?? 'Untitled',
                              style: const TextStyle(
                                  color: AppColors.textPrimary)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18,
                                    color: AppColors.textSecondary),
                                onPressed: () => _editSingleVideo(
                                    videos, i, setDialogState),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: AppColors.error),
                                onPressed: () {
                                  videos.removeAt(i);
                                  _data['showcaseVideos'] = videos;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Video'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () =>
                  _editSingleVideo(videos, null, setDialogState),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSingleVideo(List<Map<String, dynamic>> videos,
      int? editIndex, StateSetter parentSetState) async {
    final existing = editIndex != null ? videos[editIndex] : null;
    final titleCtrl =
        TextEditingController(text: existing?['title'] as String? ?? '');
    String videoUrl = existing?['url'] as String? ?? '';
    String thumbnailUrl = existing?['thumbnailUrl'] as String? ?? '';
    double? videoProgress;
    double? thumbProgress;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.adminSurface,
          title: Text(editIndex != null ? 'Edit Video' : 'Add Video',
              style: const TextStyle(color: AppColors.textPrimary)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: titleCtrl,
                    style:
                        const TextStyle(color: AppColors.textPrimary),
                    decoration: _dialogInput('Title')),
                const SizedBox(height: 12),
                // Video file upload
                if (videoProgress != null)
                  LinearProgressIndicator(
                      value: videoProgress, color: AppColors.primary)
                else if (videoUrl.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 18),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text('Video uploaded',
                            style: TextStyle(
                                color: AppColors.textSecondary)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            size: 16, color: AppColors.error),
                        onPressed: () =>
                            setDialogState(() => videoUrl = ''),
                      ),
                    ],
                  ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.upload_file, size: 18),
                  label: Text(
                      videoUrl.isEmpty ? 'Upload Video' : 'Replace Video'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: AppColors.borderDark),
                    minimumSize: const Size(0, 36),
                  ),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['mp4', 'mov', 'webm'],
                      withData: true,
                    );
                    if (result == null ||
                        result.files.single.bytes == null) {
                      return;
                    }
                    setDialogState(() => videoProgress = 0.0);
                    try {
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child(
                              'brand_assets/$_effectiveStorefrontId/videos')
                          .child(
                              'vid_${DateTime.now().millisecondsSinceEpoch}.${result.files.single.extension ?? 'mp4'}');
                      final task = ref.putData(
                        result.files.single.bytes!,
                        SettableMetadata(contentType: 'video/mp4'),
                      );
                      task.snapshotEvents.listen((snap) {
                        setDialogState(() => videoProgress =
                            snap.bytesTransferred / snap.totalBytes);
                      });
                      await task;
                      videoUrl = await ref.getDownloadURL();
                      setDialogState(() => videoProgress = null);
                    } catch (e) {
                      setDialogState(() => videoProgress = null);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Video upload failed: $e')),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 12),
                // Thumbnail upload
                if (thumbProgress != null)
                  LinearProgressIndicator(
                      value: thumbProgress, color: AppColors.primary)
                else if (thumbnailUrl.isNotEmpty)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: thumbnailUrl,
                          height: 80,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => setDialogState(
                              () => thumbnailUrl = ''),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close,
                                size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.image_outlined, size: 18),
                  label: Text(thumbnailUrl.isEmpty
                      ? 'Upload Thumbnail'
                      : 'Replace Thumbnail'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: AppColors.borderDark),
                    minimumSize: const Size(0, 36),
                  ),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: adminImageExtensions,
                      withData: true,
                    );
                    if (result == null ||
                        result.files.single.bytes == null) {
                      return;
                    }
                    setDialogState(() => thumbProgress = 0.0);
                    try {
                      final url = await uploadAdminImage(
                        bytes: result.files.single.bytes!,
                        fileName: result.files.single.name,
                        storagePath:
                            'brand_assets/$_effectiveStorefrontId/videos',
                        fileId:
                            'thumb_${DateTime.now().millisecondsSinceEpoch}',
                        resizeTarget: ImageResizeTarget.featuredImage,
                        onProgress: (p) =>
                            setDialogState(() => thumbProgress = p),
                      );
                      thumbnailUrl = url;
                      setDialogState(() => thumbProgress = null);
                    } catch (e) {
                      setDialogState(() => thumbProgress = null);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Thumbnail upload failed: $e')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(0, 36)),
              onPressed: () {
                if (videoUrl.isEmpty) { return; }
                final entry = <String, dynamic>{
                  'url': videoUrl,
                  'title': titleCtrl.text.trim().isEmpty
                      ? null
                      : titleCtrl.text.trim(),
                  'thumbnailUrl':
                      thumbnailUrl.isEmpty ? null : thumbnailUrl,
                  'sortOrder': editIndex ?? videos.length,
                };
                if (editIndex != null) {
                  videos[editIndex] = entry;
                } else {
                  videos.add(entry);
                }
                _data['showcaseVideos'] = videos;
                _markDirty();
                parentSetState(() {});
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Coupon Center Editor ──────────────────────────────

  void _editCouponCenter() {
    final coupons = ((_data['coupons'] as List?) ?? [])
        .map((c) => Map<String, dynamic>.from(c as Map))
        .toList();

    _showSectionDialog(
      title: 'Coupon Center',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: coupons.isEmpty
                  ? const Center(
                      child: Text('No coupons yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: coupons.length,
                      itemBuilder: (_, i) {
                        final c = coupons[i];
                        return ListTile(
                          leading: const Icon(
                              Icons.confirmation_num_outlined,
                              color: AppColors.textTertiary),
                          title: Text(c['code'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontFamily: 'monospace')),
                          subtitle: Text(
                              c['title'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 11)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18,
                                    color: AppColors.textSecondary),
                                onPressed: () => _editSingleCoupon(
                                    coupons, i, setDialogState),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: AppColors.error),
                                onPressed: () {
                                  coupons.removeAt(i);
                                  _data['coupons'] = coupons;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Coupon'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () =>
                  _editSingleCoupon(coupons, null, setDialogState),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSingleCoupon(List<Map<String, dynamic>> coupons,
      int? editIndex, StateSetter parentSetState) async {
    final existing = editIndex != null ? coupons[editIndex] : null;
    final codeCtrl =
        TextEditingController(text: existing?['code'] as String? ?? '');
    final titleCtrl =
        TextEditingController(text: existing?['title'] as String? ?? '');
    final descCtrl = TextEditingController(
        text: existing?['description'] as String? ?? '');
    final maxClaimsCtrl = TextEditingController(
        text: (existing?['maxClaims'] as num?)?.toString() ?? '');
    bool isActive = existing?['isActive'] as bool? ?? true;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.adminSurface,
          title: Text(editIndex != null ? 'Edit Coupon' : 'Add Coupon',
              style: const TextStyle(color: AppColors.textPrimary)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: codeCtrl,
                    style:
                        const TextStyle(color: AppColors.textPrimary),
                    decoration: _dialogInput('Coupon Code *')),
                const SizedBox(height: 10),
                TextField(
                    controller: titleCtrl,
                    style:
                        const TextStyle(color: AppColors.textPrimary),
                    decoration: _dialogInput('Title *')),
                const SizedBox(height: 10),
                TextField(
                    controller: descCtrl,
                    style:
                        const TextStyle(color: AppColors.textPrimary),
                    decoration: _dialogInput('Description'),
                    maxLines: 2),
                const SizedBox(height: 10),
                TextField(
                    controller: maxClaimsCtrl,
                    style:
                        const TextStyle(color: AppColors.textPrimary),
                    decoration:
                        _dialogInput('Max Claims (blank = unlimited)'),
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: const Text('Active',
                      style: TextStyle(color: AppColors.textPrimary)),
                  value: isActive,
                  activeThumbColor: AppColors.primary,
                  tileColor: AppColors.adminCard,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onChanged: (v) =>
                      setDialogState(() => isActive = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(0, 36)),
              onPressed: () {
                if (codeCtrl.text.trim().isEmpty ||
                    titleCtrl.text.trim().isEmpty) { return; }
                final entry = <String, dynamic>{
                  'id': existing?['id'] ??
                      'cpn_${DateTime.now().millisecondsSinceEpoch}',
                  'code': codeCtrl.text.trim().toUpperCase(),
                  'title': titleCtrl.text.trim(),
                  'description': descCtrl.text.trim().isEmpty
                      ? null
                      : descCtrl.text.trim(),
                  'maxClaims':
                      int.tryParse(maxClaimsCtrl.text.trim()),
                  'claimCount': existing?['claimCount'] ?? 0,
                  'isActive': isActive,
                };
                if (editIndex != null) {
                  coupons[editIndex] = entry;
                } else {
                  coupons.add(entry);
                }
                _data['coupons'] = coupons;
                _markDirty();
                parentSetState(() {});
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // ─── FAQ Editor ────────────────────────────────────────

  void _editFaq() {
    final items = ((_data['faqItems'] as List?) ?? [])
        .map((f) => Map<String, dynamic>.from(f as Map))
        .toList();

    _showSectionDialog(
      title: 'FAQ',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 350),
              child: items.isEmpty
                  ? const Center(
                      child: Text('No FAQ items yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : ReorderableListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      onReorder: (o, n) {
                        if (n > o) n--;
                        final item = items.removeAt(o);
                        items.insert(n, item);
                        for (var j = 0; j < items.length; j++) {
                          items[j]['sortOrder'] = j;
                        }
                        _data['faqItems'] = items;
                        _markDirty();
                        setDialogState(() {});
                      },
                      itemBuilder: (_, i) {
                        final f = items[i];
                        return ListTile(
                          key: ValueKey('faq-$i'),
                          title: Text(
                              f['question'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18,
                                    color: AppColors.textSecondary),
                                onPressed: () => _editSingleFaq(
                                    items, i, setDialogState),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: AppColors.error),
                                onPressed: () {
                                  items.removeAt(i);
                                  _data['faqItems'] = items;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add FAQ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () =>
                  _editSingleFaq(items, null, setDialogState),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSingleFaq(List<Map<String, dynamic>> items,
      int? editIndex, StateSetter parentSetState) async {
    final existing = editIndex != null ? items[editIndex] : null;
    final qCtrl =
        TextEditingController(text: existing?['question'] as String? ?? '');
    final aCtrl =
        TextEditingController(text: existing?['answer'] as String? ?? '');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminSurface,
        title: Text(editIndex != null ? 'Edit FAQ' : 'Add FAQ',
            style: const TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: qCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Question *')),
            const SizedBox(height: 10),
            TextField(
                controller: aCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _dialogInput('Answer *'),
                maxLines: 4),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36)),
            onPressed: () {
              if (qCtrl.text.trim().isEmpty ||
                  aCtrl.text.trim().isEmpty) { return; }
              final entry = <String, dynamic>{
                'question': qCtrl.text.trim(),
                'answer': aCtrl.text.trim(),
                'sortOrder': editIndex ?? items.length,
              };
              if (editIndex != null) {
                items[editIndex] = entry;
              } else {
                items.add(entry);
              }
              _data['faqItems'] = items;
              _markDirty();
              parentSetState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ─── Location Card Editor ──────────────────────────────

  void _editLocationCard() {
    final locations = ((_data['locations'] as List?) ?? [])
        .map((l) => Map<String, dynamic>.from(l as Map))
        .toList();

    _showSectionDialog(
      title: 'Locations',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: locations.isEmpty
                  ? const Center(
                      child: Text('No locations yet.',
                          style: TextStyle(color: AppColors.textTertiary)))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: locations.length,
                      itemBuilder: (_, i) {
                        final l = locations[i];
                        return ListTile(
                          leading: const Icon(Icons.location_on,
                              color: AppColors.textTertiary),
                          title: Text(
                              l['name'] as String? ?? 'Unnamed',
                              style: const TextStyle(
                                  color: AppColors.textPrimary)),
                          subtitle: Text(
                              l['address'] as String? ?? '',
                              style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18,
                                    color: AppColors.textSecondary),
                                onPressed: () => _editSingleLocation(
                                    locations, i, setDialogState),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: AppColors.error),
                                onPressed: () {
                                  locations.removeAt(i);
                                  _data['locations'] = locations;
                                  _markDirty();
                                  setDialogState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36),
              ),
              onPressed: () =>
                  _editSingleLocation(locations, null, setDialogState),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editSingleLocation(List<Map<String, dynamic>> locations,
      int? editIndex, StateSetter parentSetState) async {
    final existing = editIndex != null ? locations[editIndex] : null;
    final nameCtrl =
        TextEditingController(text: existing?['name'] as String? ?? '');
    final addressCtrl =
        TextEditingController(text: existing?['address'] as String? ?? '');
    final phoneCtrl =
        TextEditingController(text: existing?['phone'] as String? ?? '');
    final hoursCtrl =
        TextEditingController(text: existing?['hours'] as String? ?? '');
    final latCtrl = TextEditingController(
        text: (existing?['latitude'] as num?)?.toString() ?? '');
    final lngCtrl = TextEditingController(
        text: (existing?['longitude'] as num?)?.toString() ?? '');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminSurface,
        title: Text(
            editIndex != null ? 'Edit Location' : 'Add Location',
            style: const TextStyle(color: AppColors.textPrimary)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _dialogInput('Name *')),
              const SizedBox(height: 10),
              TextField(
                  controller: addressCtrl,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _dialogInput('Address *'),
                  maxLines: 2),
              const SizedBox(height: 10),
              TextField(
                  controller: phoneCtrl,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _dialogInput('Phone')),
              const SizedBox(height: 10),
              TextField(
                  controller: hoursCtrl,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _dialogInput('Hours (e.g. Mon-Fri 9-5)')),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: latCtrl,
                        style: const TextStyle(
                            color: AppColors.textPrimary),
                        decoration: _dialogInput('Latitude'),
                        keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                        controller: lngCtrl,
                        style: const TextStyle(
                            color: AppColors.textPrimary),
                        decoration: _dialogInput('Longitude'),
                        keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true)),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 36)),
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty ||
                  addressCtrl.text.trim().isEmpty) { return; }
              final entry = <String, dynamic>{
                'name': nameCtrl.text.trim(),
                'address': addressCtrl.text.trim(),
                'phone': phoneCtrl.text.trim().isEmpty
                    ? null
                    : phoneCtrl.text.trim(),
                'hours': hoursCtrl.text.trim().isEmpty
                    ? null
                    : hoursCtrl.text.trim(),
                'latitude': double.tryParse(latCtrl.text.trim()),
                'longitude': double.tryParse(lngCtrl.text.trim()),
              };
              if (editIndex != null) {
                locations[editIndex] = entry;
              } else {
                locations.add(entry);
              }
              _data['locations'] = locations;
              _markDirty();
              parentSetState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ─── Rich Text Editor ─────────────────────────────────

  void _editRichText() {
    final blocks = (_data['richTextBlocks'] as Map<String, dynamic>?) ??
        <String, dynamic>{};
    // Use a single 'main' block for simplicity
    final ctrl = TextEditingController(
        text: blocks['main'] as String? ?? '');

    _showSectionDialog(
      title: 'Rich Text',
      builder: (ctx, setDialogState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Supports basic markdown (bold, italic, links)',
                style: TextStyle(
                    color: AppColors.textTertiary, fontSize: 11),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: ctrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _dialogInput('Content'),
              maxLines: 10,
              onChanged: (v) {
                blocks['main'] = v;
                _data['richTextBlocks'] = blocks;
                _markDirty();
              },
            ),
          ],
        );
      },
    );
  }

  // ─── Tab 4: Products ──────────────────────────────────

  Future<void> _loadProducts() async {
    final storefrontId = _data['id'] as String?;
    if (storefrontId == null || storefrontId.isEmpty) {
      return;
    }
    setState(() => _isLoadingProducts = true);
    try {
      final result = await _functions
          .httpsCallable('adminListBrandProducts')
          .call<dynamic>({'storefrontId': storefrontId});
      final list =
          ((result.data as Map<String, dynamic>)['products'] as List?) ?? [];
      if (mounted) {
        setState(() {
          _products = list
              .map((p) => Map<String, dynamic>.from(p as Map))
              .toList();
          _isLoadingProducts = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingProducts = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load products (ID: $storefrontId): $e'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Widget _buildProductsTab() {
    final storefrontId = _data['id'] as String?;
    final hasStorefront = storefrontId != null && storefrontId.isNotEmpty;

    if (!hasStorefront) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.save_outlined,
                  size: 48, color: AppColors.textTertiary),
              SizedBox(height: 12),
              Text(
                'Save the storefront first before adding products.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    // Auto-load products on first visit (only once)
    if (!_productsLoaded && !_isLoadingProducts) {
      _productsLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadProducts());
    }

    return Column(
      children: [
        // Header row
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Products (${_products.length})',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon:
                    const Icon(Icons.refresh, color: AppColors.textSecondary),
                onPressed: _isLoadingProducts ? null : _loadProducts,
                tooltip: 'Refresh',
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 36),
                ),
                onPressed: () => _showProductDialog(),
              ),
            ],
          ),
        ),
        // Product list
        Expanded(
          child: _isLoadingProducts
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2))
              : _products.isEmpty
                  ? const Center(
                      child: Text(
                        'No products yet. Tap "Add Product" to create one.',
                        style: TextStyle(
                            color: AppColors.textTertiary, fontSize: 13),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                      itemCount: _products.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) =>
                          _buildProductTile(_products[index]),
                    ),
        ),
      ],
    );
  }

  Widget _buildProductTile(Map<String, dynamic> product) {
    final name = product['name'] as String? ?? 'Untitled';
    final priceZar = (product['priceZar'] as num?)?.toDouble();
    final imageUrl = product['imageUrl'] as String?;
    final isActive = product['isActive'] as bool? ?? true;
    final isFeatured = product['isFeatured'] as bool? ?? false;
    final category = product['category'] as String?;
    final fulfilment = product['fulfilmentType'] as String? ?? 'catalog';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.adminCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive
              ? AppColors.borderDark
              : AppColors.error.withValues(alpha: 0.4),
        ),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            width: 48,
            height: 48,
            child: imageUrl != null && imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) => Container(
                      color: AppColors.adminSurface,
                      child: const Icon(Icons.image_not_supported,
                          size: 20, color: AppColors.textTertiary),
                    ),
                  )
                : Container(
                    color: AppColors.adminSurface,
                    child: const Icon(Icons.inventory_2_outlined,
                        size: 20, color: AppColors.textTertiary),
                  ),
          ),
        ),
        title: Row(
          children: [
            if (isFeatured)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child:
                    Icon(Icons.star, size: 16, color: AppColors.gold),
              ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: isActive
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Text(
          [
            if (priceZar != null) 'R${priceZar.toStringAsFixed(2)}',
            if (category != null && category.isNotEmpty) category,
            fulfilment,
            if (!isActive) 'INACTIVE',
          ].join(' · '),
          style: const TextStyle(
              color: AppColors.textSecondary, fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFeatured ? Icons.star : Icons.star_border,
                color: isFeatured
                    ? AppColors.gold
                    : AppColors.textTertiary,
                size: 20,
              ),
              tooltip: isFeatured
                  ? 'Remove from featured'
                  : 'Mark as featured',
              onPressed: () => _toggleProductField(
                product['id'] as String,
                'isFeatured',
                !isFeatured,
              ),
            ),
            IconButton(
              icon: Icon(
                isActive ? Icons.visibility : Icons.visibility_off,
                color: isActive
                    ? AppColors.success
                    : AppColors.textTertiary,
                size: 20,
              ),
              tooltip: isActive ? 'Deactivate' : 'Activate',
              onPressed: () => _toggleProductField(
                product['id'] as String,
                'isActive',
                !isActive,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined,
                  size: 20, color: AppColors.textSecondary),
              tooltip: 'Edit',
              onPressed: () =>
                  _showProductDialog(existing: product),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline,
                  size: 20, color: AppColors.error),
              tooltip: 'Delete',
              onPressed: () => _confirmDeleteProduct(
                product['id'] as String,
                name,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleProductField(
      String productId, String field, dynamic value) async {
    try {
      await _functions
          .httpsCallable('adminUpdateBrandProduct')
          .call<dynamic>({'productId': productId, field: value});
      await _loadProducts();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
  }

  Future<void> _confirmDeleteProduct(
      String productId, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: const Text('Delete Product',
            style: TextStyle(color: AppColors.textPrimary)),
        content: Text(
          'Delete "$name"? This cannot be undone.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 40),
            ),
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
              minimumSize: const Size(0, 40),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await _functions
          .httpsCallable('adminDeleteBrandProduct')
          .call<dynamic>({'productId': productId});
      await _loadProducts();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: $e')),
        );
      }
    }
  }

  Future<void> _showProductDialog(
      {Map<String, dynamic>? existing}) async {
    final isEdit = existing != null;
    final nameCtrl = TextEditingController(
        text: existing?['name'] as String? ?? '');
    final descCtrl = TextEditingController(
        text: existing?['description'] as String? ?? '');
    final priceCtrl = TextEditingController(
        text: (existing?['priceZar'] as num?)?.toString() ?? '');
    final categoryCtrl = TextEditingController(
        text: existing?['category'] as String? ?? '');
    final contactCtrl = TextEditingController(
        text: existing?['contactMethod'] as String? ?? '');
    final voucherCtrl = TextEditingController(
        text: existing?['voucherInstructions'] as String? ?? '');
    final collectionCtrl = TextEditingController(
        text: existing?['collectionAddress'] as String? ?? '');
    final deliveryCtrl = TextEditingController(
        text: existing?['deliveryInfo'] as String? ?? '');
    final externalUrlCtrl = TextEditingController(
        text: existing?['externalUrl'] as String? ?? '');
    final stockCtrl = TextEditingController(
        text: (existing?['stockCount'] as num?)?.toString() ?? '');

    String fulfilmentType =
        existing?['fulfilmentType'] as String? ?? 'catalog';
    bool isFeatured = existing?['isFeatured'] as bool? ?? false;
    bool isActive = existing?['isActive'] as bool? ?? true;
    bool unlimitedStock = existing?['stockCount'] == null;
    String productImageUrl = existing?['imageUrl'] as String? ?? '';
    double? imageProgress;
    bool isSaving = false;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final priceZar = double.tryParse(priceCtrl.text);
          final tokenEquiv =
              priceZar != null ? (priceZar * 100).round() : null;

          return AlertDialog(
            backgroundColor: AppColors.adminCard,
            title: Text(
              isEdit ? 'Edit Product' : 'Add Product',
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            content: SizedBox(
              width: 480,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    TextField(
                      controller: nameCtrl,
                      style:
                          const TextStyle(color: AppColors.textPrimary),
                      decoration: _inputDecoration('Product Name *'),
                    ),
                    const SizedBox(height: 12),

                    // Description (supports Markdown)
                    TextField(
                      controller: descCtrl,
                      maxLines: 6,
                      minLines: 3,
                      style:
                          const TextStyle(color: AppColors.textPrimary),
                      decoration: _inputDecoration(
                          'Description (supports Markdown: **bold**, *italic*, - bullets, [links](url))'),
                    ),
                    const SizedBox(height: 12),

                    // Image
                    const Text('Product Image',
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12)),
                    const SizedBox(height: 4),
                    if (imageProgress != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: LinearProgressIndicator(
                            value: imageProgress,
                            color: AppColors.primary),
                      )
                    else if (productImageUrl.isNotEmpty)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: productImageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.white, size: 18),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                              ),
                              onPressed: () => setDialogState(
                                  () => productImageUrl = ''),
                            ),
                          ),
                        ],
                      )
                    else
                      OutlinedButton.icon(
                        icon: const Icon(Icons.upload, size: 16),
                        label: const Text('Upload Image'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(
                              color: AppColors.borderDark),
                          minimumSize: const Size(0, 36),
                        ),
                        onPressed: () async {
                          final result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: adminImageExtensions,
                            withData: true,
                          );
                          if (result == null ||
                              result.files.single.bytes == null) {
                            return;
                          }
                          setDialogState(
                              () => imageProgress = 0.0);
                          try {
                            final url = await uploadAdminImage(
                              bytes: result.files.single.bytes!,
                              fileName: result.files.single.name,
                              storagePath:
                                  'brand_assets/$_effectiveStorefrontId/products',
                              fileId:
                                  'prod_${DateTime.now().millisecondsSinceEpoch}',
                              resizeTarget:
                                  ImageResizeTarget.productImage,
                              onProgress: (p) => setDialogState(
                                  () => imageProgress = p),
                            );
                            setDialogState(() {
                              productImageUrl = url;
                              imageProgress = null;
                            });
                          } catch (e) {
                            setDialogState(
                                () => imageProgress = null);
                            if (ctx.mounted) {
                              ScaffoldMessenger.of(ctx)
                                  .showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Upload failed: $e'),
                                    duration: const Duration(
                                        seconds: 5)),
                              );
                            }
                          }
                        },
                      ),
                    const SizedBox(height: 12),

                    // Price + token equivalent
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: priceCtrl,
                            keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                            style: const TextStyle(
                                color: AppColors.textPrimary),
                            decoration:
                                _inputDecoration('Price (ZAR)'),
                            onChanged: (_) =>
                                setDialogState(() {}),
                          ),
                        ),
                        if (tokenEquiv != null) ...[
                          const SizedBox(width: 12),
                          Text(
                            '= $tokenEquiv tokens',
                            style: const TextStyle(
                                color: AppColors.gold, fontSize: 13),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Category
                    TextField(
                      controller: categoryCtrl,
                      style:
                          const TextStyle(color: AppColors.textPrimary),
                      decoration: _inputDecoration('Category'),
                    ),
                    const SizedBox(height: 12),

                    // Fulfilment type
                    DropdownButtonFormField<String>(
                      initialValue: fulfilmentType,
                      dropdownColor: AppColors.adminCard,
                      style:
                          const TextStyle(color: AppColors.textPrimary),
                      decoration:
                          _inputDecoration('Fulfilment Type'),
                      items: const [
                        DropdownMenuItem(
                            value: 'catalog',
                            child: Text('Catalog (enquiry)')),
                        DropdownMenuItem(
                            value: 'digital',
                            child: Text('Digital (voucher/code)')),
                        DropdownMenuItem(
                            value: 'physical',
                            child:
                                Text('Physical (delivery/collection)')),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setDialogState(() => fulfilmentType = v);
                        }
                      },
                    ),
                    const SizedBox(height: 12),

                    // Conditional fulfilment fields
                    if (fulfilmentType == 'catalog') ...[
                      TextField(
                        controller: contactCtrl,
                        style: const TextStyle(
                            color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                            'Contact Method (WhatsApp link, email, etc.)'),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (fulfilmentType == 'digital') ...[
                      TextField(
                        controller: voucherCtrl,
                        maxLines: 2,
                        style: const TextStyle(
                            color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                            'Voucher / Redemption Instructions'),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (fulfilmentType == 'physical') ...[
                      TextField(
                        controller: collectionCtrl,
                        style: const TextStyle(
                            color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                            'Collection Address'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: deliveryCtrl,
                        style: const TextStyle(
                            color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                            'Delivery Info (terms, timeframes)'),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // External URL
                    TextField(
                      controller: externalUrlCtrl,
                      style:
                          const TextStyle(color: AppColors.textPrimary),
                      decoration: _inputDecoration(
                          'External URL (optional — overrides in-app detail)'),
                    ),
                    const SizedBox(height: 12),

                    // Stock
                    Row(
                      children: [
                        Checkbox(
                          value: unlimitedStock,
                          activeColor: AppColors.primary,
                          onChanged: (v) => setDialogState(
                              () => unlimitedStock = v ?? true),
                        ),
                        const Text('Unlimited stock',
                            style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 13)),
                        if (!unlimitedStock) ...[
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: stockCtrl,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: AppColors.textPrimary),
                              decoration:
                                  _inputDecoration('Count'),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Toggles row
                    Row(
                      children: [
                        const Text('Featured',
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13)),
                        Switch(
                          value: isFeatured,
                          activeThumbColor: AppColors.gold,
                          onChanged: (v) =>
                              setDialogState(() => isFeatured = v),
                        ),
                        const SizedBox(width: 24),
                        const Text('Active',
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13)),
                        Switch(
                          value: isActive,
                          activeThumbColor: AppColors.success,
                          onChanged: (v) =>
                              setDialogState(() => isActive = v),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(0, 40),
                ),
                onPressed:
                    isSaving ? null : () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 36),
                ),
                onPressed: isSaving
                    ? null
                    : () async {
                        final prodName = nameCtrl.text.trim();
                        if (prodName.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Product name is required')),
                          );
                          return;
                        }
                        setDialogState(() => isSaving = true);
                        try {
                          final payload = <String, dynamic>{
                            'name': prodName,
                            'description':
                                descCtrl.text.trim().isEmpty
                                    ? null
                                    : descCtrl.text.trim(),
                            'priceZar': double.tryParse(
                                priceCtrl.text.trim()),
                            'imageUrl':
                                productImageUrl.isEmpty
                                    ? null
                                    : productImageUrl,
                            'category':
                                categoryCtrl.text.trim().isEmpty
                                    ? null
                                    : categoryCtrl.text.trim(),
                            'fulfilmentType': fulfilmentType,
                            'isFeatured': isFeatured,
                            'isActive': isActive,
                            'stockCount': unlimitedStock
                                ? null
                                : int.tryParse(
                                    stockCtrl.text.trim()),
                            'contactMethod':
                                contactCtrl.text.trim().isEmpty
                                    ? null
                                    : contactCtrl.text.trim(),
                            'voucherInstructions':
                                voucherCtrl.text.trim().isEmpty
                                    ? null
                                    : voucherCtrl.text.trim(),
                            'collectionAddress':
                                collectionCtrl.text.trim().isEmpty
                                    ? null
                                    : collectionCtrl.text.trim(),
                            'deliveryInfo':
                                deliveryCtrl.text.trim().isEmpty
                                    ? null
                                    : deliveryCtrl.text.trim(),
                            'externalUrl':
                                externalUrlCtrl.text.trim().isEmpty
                                    ? null
                                    : externalUrlCtrl.text.trim(),
                          };

                          if (isEdit) {
                            payload['productId'] =
                                existing['id'] as String;
                            await _functions
                                .httpsCallable(
                                    'adminUpdateBrandProduct')
                                .call<dynamic>(payload);
                          } else {
                            payload['storefrontId'] =
                                _data['id'] as String;
                            await _functions
                                .httpsCallable(
                                    'adminCreateBrandProduct')
                                .call<dynamic>(payload);
                          }

                          if (ctx.mounted) Navigator.pop(ctx);
                          await _loadProducts();
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(isEdit
                                    ? 'Product updated'
                                    : 'Product created'),
                              ),
                            );
                          }
                        } catch (e) {
                          setDialogState(
                              () => isSaving = false);
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Failed to save: $e')),
                            );
                          }
                        }
                      },
                child: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white),
                      )
                    : Text(isEdit ? 'Save' : 'Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── Tab 6: Analytics ───────────────────────────────────

  Widget _buildAnalyticsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.analytics_outlined,
                size: 48, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text(
              'Total Views: ${_data['totalViews'] ?? 0}',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Detailed analytics available via getBrandAnalytics CF.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Live Preview Panel ─────────────────────────────────

  /// Builds a [BrandStorefront] entity from the current form state
  /// so the preview can use the exact same widgets as the consumer app.
  BrandStorefront _buildPreviewStorefront() {
    final heroStyleEnum = switch (_heroStyle) {
      'gradient' => HeroStyle.gradient,
      'videoThumbnail' => HeroStyle.videoThumbnail,
      _ => HeroStyle.fullBleedImage,
    };

    // Parse trust badges
    final trustBadgeNames = (_data['trustBadges'] as List?)?.cast<String>() ?? [];
    final trustBadges = trustBadgeNames
        .map((name) => TrustBadge.values.firstWhere(
              (e) => e.name == name,
              orElse: () => TrustBadge.verified,
            ))
        .toList();

    // Parse quick actions
    final quickActionsRaw = (_data['quickActions'] as List?) ?? [];
    final quickActions = quickActionsRaw
        .whereType<Map>()
        .map((a) => QuickAction(
              label: a['label'] as String? ?? '',
              iconEmoji: a['iconEmoji'] as String? ?? '\u{1F4E6}',
              deepLink: a['deepLink'] as String? ?? '/',
              sortOrder: (a['sortOrder'] as num?)?.toInt() ?? 0,
            ))
        .toList();

    // Parse promotions
    final promosRaw = (_data['promotions'] as List?) ?? [];
    final promotions = promosRaw
        .whereType<Map>()
        .map((p) => StorefrontPromo(
              title: p['title'] as String? ?? '',
              description: p['description'] as String?,
            ))
        .toList();

    // Parse gallery
    final galleryUrls =
        (_data['galleryImageUrls'] as List?)?.cast<String>() ?? [];

    // Parse social links
    final socialLinksRaw = _data['socialLinks'];
    final socialLinks = socialLinksRaw is Map
        ? socialLinksRaw.map((k, v) =>
            MapEntry(k as String, v as String))
        : <String, String>{};

    // Parse showcase videos
    final videosRaw = (_data['showcaseVideos'] as List?) ?? [];
    final showcaseVideos = videosRaw
        .whereType<Map>()
        .map((v) => ShowcaseVideo(
              url: v['url'] as String? ?? '',
              thumbnailUrl: v['thumbnailUrl'] as String?,
              title: v['title'] as String?,
              sortOrder: (v['sortOrder'] as num?)?.toInt() ?? 0,
            ))
        .toList();

    // Parse coupons
    final couponsRaw = (_data['coupons'] as List?) ?? [];
    final coupons = couponsRaw
        .whereType<Map>()
        .map((c) => StorefrontCoupon(
              id: c['id'] as String? ?? '',
              code: c['code'] as String? ?? '',
              title: c['title'] as String? ?? '',
              description: c['description'] as String?,
              maxClaims: (c['maxClaims'] as num?)?.toInt(),
              claimCount: (c['claimCount'] as num?)?.toInt() ?? 0,
              isActive: c['isActive'] as bool? ?? true,
            ))
        .toList();

    // Parse FAQ items
    final faqRaw = (_data['faqItems'] as List?) ?? [];
    final faqItems = faqRaw
        .whereType<Map>()
        .map((f) => FaqItem(
              question: f['question'] as String? ?? '',
              answer: f['answer'] as String? ?? '',
              sortOrder: (f['sortOrder'] as num?)?.toInt() ?? 0,
            ))
        .toList();

    // Parse locations
    final locationsRaw = (_data['locations'] as List?) ?? [];
    final locations = locationsRaw
        .whereType<Map>()
        .map((l) => BrandLocation(
              name: l['name'] as String? ?? '',
              address: l['address'] as String? ?? '',
              latitude: (l['latitude'] as num?)?.toDouble(),
              longitude: (l['longitude'] as num?)?.toDouble(),
              phone: l['phone'] as String?,
              hours: l['hours'] as String?,
            ))
        .toList();

    // Parse testimonial review IDs
    final testimonialReviewIds =
        (_data['testimonialReviewIds'] as List?)?.cast<String>() ?? [];

    // Parse rich text blocks
    final richTextRaw = _data['richTextBlocks'];
    final richTextBlocks = richTextRaw is Map
        ? richTextRaw.map((k, v) =>
            MapEntry(k as String, v as String))
        : <String, String>{};

    // Parse section settings
    final sectionSettingsMap = <String, SectionSettings>{};
    for (final entry in _sectionSettings.entries) {
      final s = entry.value;
      sectionSettingsMap[entry.key] = SectionSettings(
        isVisible: s['isVisible'] as bool? ?? true,
        headingOverride: s['headingOverride'] as String?,
      );
    }
    return BrandStorefront(
      id: (_data['id'] as String?) ?? '',
      brandId: _brandIdController.text,
      brandName: _brandNameController.text.isEmpty
          ? 'Brand Name'
          : _brandNameController.text,
      brandLogoUrl: _brandLogoUrl.isEmpty ? null : _brandLogoUrl,
      brandColor: _brandColorController.text.isEmpty
          ? null
          : _brandColorController.text,
      coverImageUrl: _coverImageUrl.isEmpty ? null : _coverImageUrl,
      tagline: _taglineController.text.isEmpty
          ? null
          : _taglineController.text,
      heroStyle: heroStyleEnum,
      heroImageUrl: _heroImageUrl.isEmpty ? null : _heroImageUrl,
      accentColor: _accentColorController.text.isEmpty
          ? null
          : _accentColorController.text,
      secondaryColor: _secondaryColorController.text.isEmpty
          ? null
          : _secondaryColorController.text,
      logoPlacement: _data['logoPlacement'] == 'left'
          ? LogoPlacement.left
          : LogoPlacement.centered,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      establishedYear: int.tryParse(_establishedYearController.text),
      bannerImageUrl: _bannerImageUrl.isEmpty ? null : _bannerImageUrl,
      bannerDeepLink: _bannerDeepLinkController.text.isEmpty
          ? null
          : _bannerDeepLinkController.text,
      showChatButton: _data['showChatButton'] as bool? ?? false,
      announcementText: _announcementTextController.text.isEmpty
          ? null
          : _announcementTextController.text,
      announcementDeepLink: _announcementDeepLinkController.text.isEmpty
          ? null
          : _announcementDeepLinkController.text,
      announcementDismissible:
          _data['announcementDismissible'] as bool? ?? true,
      averageRating: (_data['averageRating'] as num?)?.toDouble(),
      ratingCount: (_data['ratingCount'] as num?)?.toInt(),
      trustBadges: trustBadges,
      quickActions: quickActions,
      promotions: promotions,
      galleryImageUrls: galleryUrls,
      socialLinks: socialLinks,
      showcaseVideos: showcaseVideos,
      coupons: coupons,
      faqItems: faqItems,
      locations: locations,
      testimonialReviewIds: testimonialReviewIds,
      richTextBlocks: richTextBlocks,
      sectionSettings: sectionSettingsMap,
      sectionOrder: _sectionOrder
          .map((s) => StorefrontSectionType.values.firstWhere(
                (e) => e.name == s,
                orElse: () => StorefrontSectionType.quickActions,
              ))
          .toList(),
    );
  }

  Widget _buildPreviewPanel() {
    _collectFormData();

    return Container(
      color: AppColors.adminBackground,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Toggle: Section Order ↔ App Preview
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _previewToggleButton(
                label: 'Sections',
                icon: Icons.view_list,
                isActive: !_showAppPreview,
                onTap: () => setState(() => _showAppPreview = false),
              ),
              const SizedBox(width: 8),
              _previewToggleButton(
                label: 'App Preview',
                icon: Icons.phone_iphone,
                isActive: _showAppPreview,
                onTap: () {
                  _collectFormData();
                  setState(() {
                    _showAppPreview = true;
                    _previewRefreshKey++;
                  });
                },
              ),
              if (_showAppPreview) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  tooltip: 'Refresh preview',
                  color: AppColors.textSecondary,
                  onPressed: () {
                    _collectFormData();
                    setState(() => _previewRefreshKey++);
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            key: ValueKey('preview-$_showAppPreview-$_previewRefreshKey'),
            child: _showAppPreview
                ? _buildAppPreview()
                : _buildSectionOrderPreview(),
          ),
        ],
      ),
    );
  }

  Widget _previewToggleButton({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.borderDark,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 14,
                color: isActive
                    ? AppColors.primary
                    : AppColors.textTertiary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppColors.primary
                    : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section-order boxes preview (existing behavior).
  Widget _buildSectionOrderPreview() {
    final storefront = _buildPreviewStorefront();

    final accentHex = _accentColorController.text;
    Color accent = AppColors.buyMarketplaceAccent;
    if (accentHex.isNotEmpty) {
      final parsed = _parseHex(accentHex);
      if (parsed != null) accent = parsed;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        const phoneWidth = 375.0;
        final scale = availableWidth < phoneWidth
            ? availableWidth / phoneWidth
            : 1.0;

        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: phoneWidth * scale,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24 * scale),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: AppColors.borderDark, width: 2),
                  borderRadius: BorderRadius.circular(24 * scale),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22 * scale),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      BrandStorefrontHero(
                        storefront: storefront,
                        height: 180 * scale,
                        maxImageCacheWidth: 375,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16 * scale),
                        child: Row(
                          children: [
                            if (storefront.brandLogoUrl != null) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    8 * scale),
                                child: CachedNetworkImage(
                                  imageUrl: storefront.brandLogoUrl!,
                                  width: 40 * scale,
                                  height: 40 * scale,
                                  fit: BoxFit.contain,
                                  errorWidget: (_, _, _) => SizedBox(
                                      width: 40 * scale,
                                      height: 40 * scale),
                                ),
                              ),
                              SizedBox(width: 10 * scale),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    storefront.brandName,
                                    style: TextStyle(
                                      fontSize: 18 * scale,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  if (storefront.tagline != null) ...[
                                    SizedBox(height: 2 * scale),
                                    Text(
                                      storefront.tagline!,
                                      style: TextStyle(
                                        fontSize: 12 * scale,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ..._sectionOrder.map((type) {
                        final settings = _sectionSettings[type];
                        if (settings != null &&
                            settings['isVisible'] == false) {
                          return const SizedBox.shrink();
                        }
                        return _buildPreviewSection(type, accent);
                      }),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Pixel-accurate app preview using the shared StorefrontPreview widget.
  Widget _buildAppPreview() {
    _collectFormData();
    final storefront = _buildPreviewStorefront();
    final products = _products
        .map((p) => BrandProductModel.fromJson(p).toEntity())
        .toList();



    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        const phoneWidth = 375.0;
        // Use full available height instead of fixed 812
        final availableHeight = constraints.maxHeight;

        final scale = availableWidth < phoneWidth
            ? availableWidth / phoneWidth
            : 1.0;
        final scaledHeight = availableHeight / scale;

        return Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16 * scale),
            child: Container(
              width: phoneWidth * scale,
              decoration: BoxDecoration(
                color: AppColors.buyBackground,
                border:
                    Border.all(color: AppColors.borderDark, width: 2),
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: phoneWidth,
                  height: scaledHeight,
                  child: MediaQuery(
                    data: MediaQueryData(
                        size: Size(phoneWidth, scaledHeight)),
                    child: StorefrontPreview(
                      key: ValueKey(_previewRefreshKey),
                      storefront: storefront,
                      products: products,
                      isLoadingProducts: _isLoadingProducts,
                      interactive: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviewSection(String type, Color accent) {
    // Show product mini-cards for product sections
    if (type == 'featuredProducts' || type == 'products') {
      return _buildPreviewProductSection(type, accent);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(_sectionIcon(type), size: 18, color: accent),
            const SizedBox(width: 8),
            Text(
              type,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewProductSection(String type, Color accent) {
    final isFeaturedSection = type == 'featuredProducts';
    final items = isFeaturedSection
        ? _products
            .where((p) =>
                p['isFeatured'] == true && p['isActive'] != false)
            .toList()
        : _products
            .where((p) => p['isActive'] != false)
            .toList();

    final label = isFeaturedSection
        ? 'Featured'
        : 'Products (${items.length})';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Icon(_sectionIcon(type), size: 14, color: accent),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (items.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                isFeaturedSection
                    ? 'No featured products'
                    : 'No products yet',
                style: const TextStyle(
                    fontSize: 11, color: Color(0xFF94A3B8)),
              ),
            )
          else if (isFeaturedSection)
            // Horizontal scroll for featured
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: 6),
                itemBuilder: (_, i) =>
                    _buildMiniProductCard(items[i], width: 70),
              ),
            )
          else
            // Grid for all products
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: items
                  .take(6)
                  .map((p) => _buildMiniProductCard(p, width: 70))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildMiniProductCard(Map<String, dynamic> product,
      {required double width}) {
    final name = product['name'] as String? ?? '';
    final imageUrl = product['imageUrl'] as String?;
    final priceZar = (product['priceZar'] as num?)?.toDouble();

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(5)),
            child: SizedBox(
              height: 44,
              width: width,
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Container(
                        color: const Color(0xFFF1F5F9),
                        child: const Icon(Icons.image,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                    )
                  : Container(
                      color: const Color(0xFFF1F5F9),
                      child: const Center(
                        child: Icon(Icons.inventory_2,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                    ),
            ),
          ),
          // Name + price
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A2E)),
                ),
                if (priceZar != null)
                  Text(
                    'R${priceZar.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 8, color: Color(0xFF64748B)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Image Upload Helper ────────────────────────────────

  /// Resolves a storefront ID for building storage paths.
  /// Falls back to brandId or a timestamp if no ID exists yet.
  String get _effectiveStorefrontId {
    final fromWidget = widget.storefrontId;
    if (fromWidget != null) return fromWidget;
    final fromData = _data['id'] as String?;
    if (fromData != null && fromData.isNotEmpty) return fromData;
    final fromBrandId = _brandIdController.text.trim();
    if (fromBrandId.isNotEmpty) return fromBrandId;
    return 'draft_${DateTime.now().millisecondsSinceEpoch}';
  }

  Widget _imageUploadField({
    required String label,
    required String currentUrl,
    required double? progress,
    required String storageSuffix,
    required void Function(String url) onUploaded,
    required VoidCallback onRemoved,
    required void Function(double?) onProgressChanged,
    BoxFit fit = BoxFit.cover,
    double height = 120,
  }) {
    final hasImage = currentUrl.isNotEmpty;
    final isUploading = progress != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (hasImage) ...[
            // Show current image with replace/remove options
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: currentUrl,
                    height: height,
                    width: double.infinity,
                    fit: fit,
                    errorWidget: (_, _, _) => Container(
                      height: height,
                      color: AppColors.adminSurface,
                      child: const Center(
                          child: Icon(Icons.broken_image,
                              color: AppColors.textTertiary)),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _iconButton(
                          icon: Icons.swap_horiz,
                          tooltip: 'Replace',
                          onTap: () => _pickAndUploadImage(
                            storageSuffix: storageSuffix,
                            onUploaded: onUploaded,
                            onProgressChanged: onProgressChanged,
                          ),
                        ),
                        const SizedBox(width: 4),
                        _iconButton(
                          icon: Icons.delete_outline,
                          tooltip: 'Remove',
                          onTap: onRemoved,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ] else if (isUploading) ...[
            // Upload in progress
            Container(
              height: height,
              decoration: BoxDecoration(
                color: AppColors.adminSurface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderDark),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.borderDark,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Uploading… ${(progress * 100).toInt()}%',
                    style: const TextStyle(
                        color: AppColors.textTertiary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Empty — show upload button
            InkWell(
              onTap: () => _pickAndUploadImage(
                storageSuffix: storageSuffix,
                onUploaded: onUploaded,
                onProgressChanged: onProgressChanged,
              ),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.adminSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.borderDark,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_upload_outlined,
                          size: 32, color: AppColors.textTertiary),
                      SizedBox(height: 8),
                      Text('Click to upload image',
                          style: TextStyle(
                              color: AppColors.textTertiary, fontSize: 13)),
                      SizedBox(height: 2),
                      Text('JPG, PNG, GIF, WebP, SVG — max 5 MB',
                          style: TextStyle(
                              color: AppColors.textTertiary, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _pickAndUploadImage({
    required String storageSuffix,
    required void Function(String url) onUploaded,
    required void Function(double?) onProgressChanged,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: adminImageExtensions,
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;

    final bytes = result.files.single.bytes!;
    final fileName = result.files.single.name;

    onProgressChanged(0.0);

    try {
      final url = await uploadAdminImage(
        bytes: bytes,
        fileName: fileName,
        storagePath: 'brand_assets/$_effectiveStorefrontId',
        fileId: storageSuffix,
        resizeTarget: storageSuffix == 'logo'
            ? ImageResizeTarget.brandLogo
            : ImageResizeTarget.heroImage,
        onProgress: (p) => onProgressChanged(p),
      );
      onUploaded(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    } finally {
      onProgressChanged(null);
    }
  }

  // ─── Shared Helpers ─────────────────────────────────────

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: _inputDecoration(label),
        onChanged: (_) => _markDirty(),
      ),
    );
  }

  Widget _colorField(String label, TextEditingController controller) {
    final hex = controller.text.trim();
    final parsed = _parseHex(hex);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Tappable color swatch — opens picker
          GestureDetector(
            onTap: () => _showColorPicker(label, controller),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: parsed ?? AppColors.adminSurface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderDark),
              ),
              child: parsed == null
                  ? Icon(Icons.colorize,
                      size: 16, color: AppColors.textTertiary)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration(label).copyWith(
                hintText: '#RRGGBB',
                hintStyle: const TextStyle(color: AppColors.textHint),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.palette, size: 20),
                  color: AppColors.textSecondary,
                  onPressed: () => _showColorPicker(label, controller),
                  tooltip: 'Pick colour',
                ),
              ),
              onChanged: (_) {
                setState(() {});
                _markDirty();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(String label, TextEditingController controller) {
    final currentColor = _parseHex(controller.text.trim()) ?? Colors.blue;
    var pickedColor = currentColor;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.adminCard,
        title: Text('Pick $label'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => pickedColor = color,
            enableAlpha: false,
            hexInputBar: true,
            labelTypes: const [],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 40),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 40),
            ),
            onPressed: () {
              final r = (pickedColor.r * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
              final g = (pickedColor.g * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
              final b = (pickedColor.b * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
              controller.text = '#$r$g$b';
              setState(() {});
              _markDirty();
              Navigator.of(ctx).pop();
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      filled: true,
      fillColor: AppColors.adminSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  Color? _parseHex(String hex) {
    if (hex.isEmpty) return null;
    final cleaned = hex.replaceFirst('#', '');
    if (cleaned.length != 6) return null;
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return null;
    return Color(0xFF000000 | value);
  }
}
