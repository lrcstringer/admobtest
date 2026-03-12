import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/entities/sa_location.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Type-ahead location autocomplete widget (Spec §8.17).
///
/// Queries the local SA locations database with 200ms debounce.
/// Displays province → city → suburb hierarchy in results.
class LocationAutocomplete extends StatefulWidget {
  final Future<List<SaLocation>> Function(String query) onSearch;
  final ValueChanged<SaLocation> onSelected;
  final SaLocation? initialValue;
  final String? hintText;

  const LocationAutocomplete({
    super.key,
    required this.onSearch,
    required this.onSelected,
    this.initialValue,
    this.hintText,
  });

  @override
  State<LocationAutocomplete> createState() => _LocationAutocompleteState();
}

class _LocationAutocompleteState extends State<LocationAutocomplete> {
  late final TextEditingController _controller;
  Timer? _debounce;
  List<SaLocation> _results = [];
  bool _isLoading = false;
  bool _showResults = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue?.name ?? '',
    );
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _showResults = false);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String query) {
    _debounce?.cancel();
    if (query.trim().length < 2) {
      setState(() {
        _results = [];
        _showResults = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 200), () async {
      if (!mounted) return;
      setState(() => _isLoading = true);
      final results = await widget.onSearch(query.trim());
      if (!mounted) return;
      setState(() {
        _results = results;
        _isLoading = false;
        _showResults = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Input field
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _onChanged,
          style: const TextStyle(
            color: AppColors.buyTextPrimary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Search suburb, city, or province',
            hintStyle: const TextStyle(
              color: AppColors.buyTextTertiary,
              fontSize: 13,
            ),
            prefixIcon: const Icon(Icons.location_on_outlined,
                size: 20, color: AppColors.buyTextTertiary),
            suffixIcon: _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: AppColors.buyMarketplaceAccent,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            size: 18, color: AppColors.buyTextTertiary),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            _results = [];
                            _showResults = false;
                          });
                        },
                      )
                    : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              borderSide: const BorderSide(
                  color: AppColors.buyCardBorder, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              borderSide: const BorderSide(
                  color: AppColors.buyCardBorder, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              borderSide: const BorderSide(
                  color: AppColors.buyMarketplaceAccent, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 12),
          ),
        ),

        // Results dropdown
        if (_showResults && _results.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.buyShadow,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _results.length,
              separatorBuilder: (_, _) =>
                  const Divider(color: AppColors.buyDivider, height: 1),
              itemBuilder: (_, index) {
                final loc = _results[index];
                return InkWell(
                  onTap: () {
                    _controller.text = loc.name;
                    setState(() => _showResults = false);
                    _focusNode.unfocus();
                    widget.onSelected(loc);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          _iconForType(loc.type),
                          size: 16,
                          color: AppColors.buyTextTertiary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.name,
                                style: const TextStyle(
                                  color: AppColors.buyTextPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (loc.city != null || loc.province != null)
                                Text(
                                  [loc.city, loc.province]
                                      .whereType<String>()
                                      .join(', '),
                                  style: const TextStyle(
                                    color: AppColors.buyTextTertiary,
                                    fontSize: 11,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.buyChipBg,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            loc.type,
                            style: const TextStyle(
                              color: AppColors.buyTextTertiary,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        if (_showResults && _results.isEmpty && !_isLoading)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
            ),
            child: const Text(
              'No locations found',
              style: TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'province':
        return Icons.map_outlined;
      case 'city':
        return Icons.location_city_outlined;
      case 'suburb':
        return Icons.place_outlined;
      default:
        return Icons.location_on_outlined;
    }
  }
}
