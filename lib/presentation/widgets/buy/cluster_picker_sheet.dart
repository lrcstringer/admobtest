import 'package:flutter/material.dart';

import '../../../core/constants/cluster_constants.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet that lets a user select regional clusters for group buy matching.
///
/// Returns the selected cluster list when the user taps "Save".
class ClusterPickerSheet extends StatefulWidget {
  final List<String> initialSelection;

  const ClusterPickerSheet({
    super.key,
    this.initialSelection = const [],
  });

  /// Show as a modal bottom sheet and return the selected clusters.
  static Future<List<String>?> show(
    BuildContext context, {
    List<String> initialSelection = const [],
  }) {
    return showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ClusterPickerSheet(initialSelection: initialSelection),
    );
  }

  @override
  State<ClusterPickerSheet> createState() => _ClusterPickerSheetState();
}

class _ClusterPickerSheetState extends State<ClusterPickerSheet> {
  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.buyCardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Areas',
                          style: TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Select areas where you can collect group buy items',
                          style: TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(_selected.toList()),
                    child: Text(
                      'Save (${_selected.length})',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Province sections
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                children: ClusterConstants.clustersByProvince.entries
                    .map(_buildProvinceSection)
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProvinceSection(MapEntry<String, List<String>> entry) {
    final province = entry.key;
    final clusters = entry.value;
    final allSelected = clusters.every(_selected.contains);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Province header with select-all
        InkWell(
          onTap: () {
            setState(() {
              if (allSelected) {
                _selected.removeAll(clusters);
              } else {
                _selected.addAll(clusters);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  allSelected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  size: 20,
                  color: allSelected
                      ? AppColors.buyGroupBuyAccent
                      : AppColors.buyTextTertiary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  province,
                  style: const TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Cluster checkboxes
        ...clusters.map((cluster) {
          final isSelected = _selected.contains(cluster);
          return CheckboxListTile(
            value: isSelected,
            onChanged: (v) {
              setState(() {
                if (v == true) {
                  _selected.add(cluster);
                } else {
                  _selected.remove(cluster);
                }
              });
            },
            title: Text(
              cluster,
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 13,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            activeColor: AppColors.buyGroupBuyAccent,
            contentPadding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.md,
            ),
          );
        }),
      ],
    );
  }
}
