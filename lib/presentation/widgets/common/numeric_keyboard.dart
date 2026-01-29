import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Custom numeric keyboard widget for phone number input
class NumericKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onBackspace;
  final double keyHeight;
  final double horizontalPadding;

  const NumericKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onBackspace,
    this.keyHeight = 44,
    this.horizontalPadding = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(['1', '2', '3']),
          _buildRow(['4', '5', '6']),
          _buildRow(['7', '8', '9']),
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) => _buildKey(key)).toList(),
      ),
    );
  }

  Widget _buildBottomRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Empty space on left
          _buildEmptyKey(),
          // Zero key
          _buildKey('0'),
          // Backspace key
          _buildBackspaceKey(),
        ],
      ),
    );
  }

  Widget _buildKey(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => onKeyPressed(value),
            borderRadius: BorderRadius.circular(12),
            splashColor: AppColors.primary.withValues(alpha: 0.3),
            highlightColor: AppColors.primary.withValues(alpha: 0.1),
            child: Container(
              height: keyHeight,
              alignment: Alignment.center,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyKey() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(height: keyHeight),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onBackspace,
            borderRadius: BorderRadius.circular(12),
            splashColor: AppColors.primary.withValues(alpha: 0.3),
            highlightColor: AppColors.primary.withValues(alpha: 0.1),
            child: Container(
              height: keyHeight,
              alignment: Alignment.center,
              child: const Icon(
                Icons.backspace_outlined,
                size: 22,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
