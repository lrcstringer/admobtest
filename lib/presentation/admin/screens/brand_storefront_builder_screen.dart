import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

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
  final _heroImageUrlController = TextEditingController();
  final _coverImageUrlController = TextEditingController();
  final _brandLogoUrlController = TextEditingController();
  final _brandColorController = TextEditingController();
  final _accentColorController = TextEditingController();
  final _secondaryColorController = TextEditingController();
  double _heroFocalPointX = 0.5;
  double _heroFocalPointY = 0.5;
  String _heroStyle = 'fullBleedImage';

  // Tab 3: Content & Links
  final _bannerImageUrlController = TextEditingController();
  final _bannerDeepLinkController = TextEditingController();
  final _announcementTextController = TextEditingController();
  final _announcementDeepLinkController = TextEditingController();

  // Tab 4: Dynamic Content — managed as lists in _data
  List<String> _sectionOrder = [];
  Map<String, Map<String, dynamic>> _sectionSettings = {};

  // Tab 5: Products — loaded separately from subcollection

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadData();
    // Auto-save every 30 seconds
    _autoSaveTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (_isDirty && !_isSaving) _save();
      },
    );
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _tabController.dispose();
    _brandNameController.dispose();
    _brandIdController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    _establishedYearController.dispose();
    _heroImageUrlController.dispose();
    _coverImageUrlController.dispose();
    _brandLogoUrlController.dispose();
    _brandColorController.dispose();
    _accentColorController.dispose();
    _secondaryColorController.dispose();
    _bannerImageUrlController.dispose();
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
    _heroImageUrlController.text = _str('heroImageUrl');
    _coverImageUrlController.text = _str('coverImageUrl');
    _brandLogoUrlController.text = _str('brandLogoUrl');
    _brandColorController.text = _str('brandColor');
    _accentColorController.text = _str('accentColor');
    _secondaryColorController.text = _str('secondaryColor');
    _heroFocalPointX = (_data['heroFocalPointX'] as num?)?.toDouble() ?? 0.5;
    _heroFocalPointY = (_data['heroFocalPointY'] as num?)?.toDouble() ?? 0.5;
    _heroStyle = _str('heroStyle').isNotEmpty ? _str('heroStyle') : 'fullBleedImage';
    _bannerImageUrlController.text = _str('bannerImageUrl');
    _bannerDeepLinkController.text = _str('bannerDeepLink');
    _announcementTextController.text = _str('announcementText');
    _announcementDeepLinkController.text = _str('announcementDeepLink');
    _isPublished = _data['isDraft'] != true;

    final orderRaw = _data['sectionOrder'];
    if (orderRaw is List) {
      _sectionOrder = orderRaw.cast<String>();
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
    setState(() => _isDirty = true);
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
    _data['heroImageUrl'] = _heroImageUrlController.text.trim().isEmpty
        ? null
        : _heroImageUrlController.text.trim();
    _data['coverImageUrl'] = _coverImageUrlController.text.trim().isEmpty
        ? null
        : _coverImageUrlController.text.trim();
    _data['brandLogoUrl'] = _brandLogoUrlController.text.trim().isEmpty
        ? null
        : _brandLogoUrlController.text.trim();
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
    _data['bannerImageUrl'] = _bannerImageUrlController.text.trim().isEmpty
        ? null
        : _bannerImageUrlController.text.trim();
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

    try {
      if (widget.storefrontId != null) {
        await _functions
            .httpsCallable('adminUpdateBrandStorefront')
            .call<dynamic>({
          'storefrontId': widget.storefrontId,
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
    if (_brandLogoUrlController.text.trim().isEmpty) {
      errors.add('Brand logo URL is required');
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
        backgroundColor: AppColors.backgroundDark,
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
      backgroundColor: AppColors.cardDark,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (_isDirty) {
            showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: AppColors.cardDark,
                title: const Text('Unsaved changes'),
                content:
                    const Text('Save before leaving?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.go('/buy-brand-storefronts');
                    },
                    child: const Text('Discard'),
                  ),
                  ElevatedButton(
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
            : 'New Storefront',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      actions: [
        // Undo
        IconButton(
          icon: const Icon(Icons.undo),
          tooltip: 'Undo (Ctrl+Z)',
          onPressed: _undoStack.length > 1 ? _undo : null,
        ),
        // Redo
        IconButton(
          icon: const Icon(Icons.redo),
          tooltip: 'Redo (Ctrl+Shift+Z)',
          onPressed: _redoStack.isNotEmpty ? _redo : null,
        ),
        const SizedBox(width: 8),
        // Save indicator
        if (_isDirty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                'Unsaved',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        // Save button
        TextButton.icon(
          icon: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save, size: 18),
          label: const Text('Save'),
          onPressed: _isDirty && !_isSaving ? _save : null,
        ),
        const SizedBox(width: 8),
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
          color: AppColors.cardDark,
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
              Tab(text: 'Content & Links'),
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
              _buildContentLinksTab(),
              _buildDynamicContentTab(),
              _buildProductsTab(),
              _buildAnalyticsTab(),
            ],
          ),
        ),
      ],
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
                backgroundColor: AppColors.surfaceDark,
                labelStyle: const TextStyle(color: AppColors.textPrimary),
                onPressed: () => _applyTemplate(name),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
        _field('Brand Name *', _brandNameController),
        _field('Brand ID (Firestore doc ID)', _brandIdController),
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
          dropdownColor: AppColors.cardDark,
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
        _field('Hero Image URL', _heroImageUrlController),
        _field('Cover Image URL (fallback)', _coverImageUrlController),
        _field('Brand Logo URL *', _brandLogoUrlController),

        // Focal point editor
        if (_heroImageUrlController.text.isNotEmpty) ...[
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
                          imageUrl: _heroImageUrlController.text,
                          width: constraints.maxWidth,
                          height: 160,
                          fit: BoxFit.cover,
                          alignment: Alignment(
                            _heroFocalPointX * 2 - 1,
                            _heroFocalPointY * 2 - 1,
                          ),
                          errorWidget: (_, _, _) => Container(
                            color: AppColors.surfaceDark,
                            child: const Center(
                                child: Text('Invalid URL',
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

  // ─── Tab 3: Content & Links ─────────────────────────────

  Widget _buildContentLinksTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Banner',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        const SizedBox(height: 8),
        _field('Banner Image URL', _bannerImageUrlController),
        _field('Banner Deep Link', _bannerDeepLinkController),
        const SizedBox(height: 20),
        const Divider(color: AppColors.borderDark),
        const SizedBox(height: 12),
        const Text('Announcement Bar',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        const SizedBox(height: 8),
        _field('Announcement Text', _announcementTextController),
        _field('Announcement Deep Link', _announcementDeepLinkController),
        SwitchListTile(
          title: const Text('Dismissible',
              style: TextStyle(color: AppColors.textPrimary)),
          value: _data['announcementDismissible'] != false,
          activeThumbColor: AppColors.primary,
          onChanged: (v) {
            _data['announcementDismissible'] = v;
            _markDirty();
          },
        ),
        const SizedBox(height: 20),
        const Divider(color: AppColors.borderDark),
        const SizedBox(height: 12),
        const Text('Social Links',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        const SizedBox(height: 8),
        ..._buildSocialLinksEditor(),
      ],
    );
  }

  List<Widget> _buildSocialLinksEditor() {
    final links =
        (_data['socialLinks'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final platforms = [
      'whatsapp',
      'instagram',
      'facebook',
      'website',
      'tiktok',
      'x',
      'youtube'
    ];
    return platforms.map((platform) {
      final controller = TextEditingController(text: links[platform] as String? ?? '');
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _inputDecoration(
            platform[0].toUpperCase() + platform.substring(1),
          ),
          onChanged: (v) {
            links[platform] = v.trim().isEmpty ? null : v.trim();
            _data['socialLinks'] = links;
            _markDirty();
          },
        ),
      );
    }).toList();
  }

  // ─── Tab 4: Dynamic Content (Sections) ──────────────────

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
                color: AppColors.cardDark,
                onSelected: (type) {
                  _sectionOrder.add(type);
                  _markDirty();
                },
                itemBuilder: (_) => _allSectionTypes
                    .map((t) => PopupMenuItem(value: t, child: Text(t)))
                    .toList(),
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
                    return ListTile(
                      key: ValueKey('$type-$index'),
                      tileColor: AppColors.surfaceDark,
                      leading: const Icon(Icons.drag_handle,
                          color: AppColors.textTertiary),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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

  // ─── Tab 5: Products ────────────────────────────────────

  Widget _buildProductsTab() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 48, color: AppColors.textTertiary),
            SizedBox(height: 12),
            Text(
              'Products are managed in the storefront subcollection.\n'
              'Use the admin product CFs to add/edit/remove products.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
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

  Widget _buildPreviewPanel() {
    _collectFormData();
    final brandName = _brandNameController.text.isEmpty
        ? 'Brand Name'
        : _brandNameController.text;
    final tagline = _taglineController.text;
    final heroUrl = _heroImageUrlController.text;
    final logoUrl = _brandLogoUrlController.text;
    final accentHex = _accentColorController.text;
    final brandHex = _brandColorController.text;

    Color accent = AppColors.buyMarketplaceAccent;
    if (accentHex.isNotEmpty) {
      final parsed = _parseHex(accentHex);
      if (parsed != null) accent = parsed;
    }

    Color brand = AppColors.primary;
    if (brandHex.isNotEmpty) {
      final parsed = _parseHex(brandHex);
      if (parsed != null) brand = parsed;
    }

    return Container(
      color: AppColors.backgroundDark,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Live Preview',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // Phone frame
          Expanded(
            child: Container(
              width: 375,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderDark, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero preview
                    if (heroUrl.isNotEmpty)
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: heroUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment(
                            _heroFocalPointX * 2 - 1,
                            _heroFocalPointY * 2 - 1,
                          ),
                          errorWidget: (_, _, _) => Container(
                            color: brand.withValues(alpha: 0.2),
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [brand, accent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: logoUrl.isNotEmpty
                            ? Center(
                                child: CachedNetworkImage(
                                  imageUrl: logoUrl,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.contain,
                                  errorWidget: (_, _, _) =>
                                      const SizedBox.shrink(),
                                ),
                              )
                            : Center(
                                child: Text(
                                  brandName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),

                    // Brand header preview
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          if (logoUrl.isNotEmpty) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: logoUrl,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                                errorWidget: (_, _, _) =>
                                    const SizedBox(width: 40, height: 40),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brandName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                if (tagline.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    tagline,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Section previews
                    ..._sectionOrder.map((type) {
                      final settings = _sectionSettings[type];
                      if (settings != null && settings['isVisible'] == false) {
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
        ],
      ),
    );
  }

  Widget _buildPreviewSection(String type, Color accent) {
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

  IconData _sectionIcon(String type) {
    switch (type) {
      case 'quickActions':
        return Icons.touch_app;
      case 'featuredProducts':
        return Icons.star_outline;
      case 'products':
        return Icons.shopping_bag_outlined;
      case 'banner':
        return Icons.image_outlined;
      case 'promotions':
        return Icons.local_offer_outlined;
      case 'gallery':
        return Icons.photo_library_outlined;
      case 'reviews':
        return Icons.rate_review_outlined;
      case 'about':
        return Icons.info_outline;
      case 'socialLinks':
        return Icons.share_outlined;
      case 'announcementBar':
        return Icons.campaign_outlined;
      case 'videoShowcase':
        return Icons.videocam_outlined;
      case 'couponCenter':
        return Icons.confirmation_number_outlined;
      case 'faq':
        return Icons.help_outline;
      case 'testimonials':
        return Icons.format_quote;
      case 'locationCard':
        return Icons.location_on_outlined;
      case 'divider':
        return Icons.horizontal_rule;
      case 'richText':
        return Icons.text_fields;
      default:
        return Icons.widgets;
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
          // Color swatch preview
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: parsed ?? AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderDark),
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      filled: true,
      fillColor: AppColors.surfaceDark,
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
