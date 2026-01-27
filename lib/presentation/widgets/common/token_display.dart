import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../theme/app_colors.dart';

/// Display style for token amounts
enum TokenDisplayStyle { small, medium, large, hero }

/// Widget to display token amounts with optional ZAR conversion
class TokenDisplay extends StatelessWidget {
  final int amount;
  final bool showZar;
  final TokenDisplayStyle style;
  final Color? color;
  final bool showIcon;

  const TokenDisplay({
    super.key,
    required this.amount,
    this.showZar = false,
    this.style = TokenDisplayStyle.medium,
    this.color,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final formattedAmount = _formatAmount(amount);
    final zarValue = amount * AppConstants.tokenValueZar;
    final formattedZar = NumberFormat.currency(
      locale: 'en_ZA',
      symbol: 'R',
      decimalDigits: 2,
    ).format(zarValue);

    final textStyle = _getTextStyle(context);
    final iconSize = _getIconSize();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(
                Icons.toll,
                size: iconSize,
                color: color ?? AppColors.tokenGold,
              ),
              SizedBox(width: iconSize * 0.25),
            ],
            Text(
              formattedAmount,
              style: textStyle.copyWith(
                color: color ?? textStyle.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (showZar) ...[
          const SizedBox(height: 2),
          Text(
            formattedZar,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: _getZarFontSize(),
                ),
          ),
        ],
      ],
    );
  }

  String _formatAmount(int amount) {
    return NumberFormat('#,###').format(amount);
  }

  TextStyle _getTextStyle(BuildContext context) {
    switch (style) {
      case TokenDisplayStyle.small:
        return Theme.of(context).textTheme.bodyMedium!;
      case TokenDisplayStyle.medium:
        return Theme.of(context).textTheme.titleMedium!;
      case TokenDisplayStyle.large:
        return Theme.of(context).textTheme.headlineSmall!;
      case TokenDisplayStyle.hero:
        return Theme.of(context).textTheme.displaySmall!;
    }
  }

  double _getIconSize() {
    switch (style) {
      case TokenDisplayStyle.small:
        return 14;
      case TokenDisplayStyle.medium:
        return 18;
      case TokenDisplayStyle.large:
        return 24;
      case TokenDisplayStyle.hero:
        return 32;
    }
  }

  double _getZarFontSize() {
    switch (style) {
      case TokenDisplayStyle.small:
        return 10;
      case TokenDisplayStyle.medium:
        return 12;
      case TokenDisplayStyle.large:
        return 14;
      case TokenDisplayStyle.hero:
        return 16;
    }
  }
}

/// Compact inline token display for use in text
class TokenAmountText extends StatelessWidget {
  final int amount;
  final TextStyle? style;

  const TokenAmountText({
    super.key,
    required this.amount,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final formattedAmount = NumberFormat('#,###').format(amount);

    return RichText(
      text: TextSpan(
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              Icons.toll,
              size: 14,
              color: AppColors.tokenGold,
            ),
          ),
          TextSpan(text: ' $formattedAmount'),
        ],
      ),
    );
  }
}

/// ZAR amount display
class ZarDisplay extends StatelessWidget {
  final double amount;
  final TextStyle? style;
  final bool showSign;

  const ZarDisplay({
    super.key,
    required this.amount,
    this.style,
    this.showSign = false,
  });

  @override
  Widget build(BuildContext context) {
    final formatted = NumberFormat.currency(
      locale: 'en_ZA',
      symbol: 'R',
      decimalDigits: 2,
    ).format(amount.abs());

    String prefix = '';
    Color? color;

    if (showSign && amount != 0) {
      if (amount > 0) {
        prefix = '+';
        color = AppColors.success;
      } else {
        prefix = '-';
        color = AppColors.error;
      }
    }

    return Text(
      '$prefix$formatted',
      style: (style ?? Theme.of(context).textTheme.bodyMedium)?.copyWith(
        color: color,
        fontWeight: showSign ? FontWeight.w600 : null,
      ),
    );
  }
}
