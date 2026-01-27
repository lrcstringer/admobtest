import 'package:intl/intl.dart';

/// Utility class for formatting values
class Formatters {
  Formatters._();

  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_ZA',
    symbol: 'R ',
    decimalDigits: 2,
  );

  static final _compactCurrencyFormat = NumberFormat.compactCurrency(
    locale: 'en_ZA',
    symbol: 'R ',
    decimalDigits: 0,
  );

  static final _numberFormat = NumberFormat('#,##0', 'en_ZA');

  /// Format tokens to display string (e.g., "1,234 Tokens")
  static String formatTokens(int tokens) {
    return '${_numberFormat.format(tokens)} Tokens';
  }

  /// Format tokens to short display (e.g., "1,234")
  static String formatTokensShort(int tokens) {
    return _numberFormat.format(tokens);
  }

  /// Convert tokens to ZAR and format (e.g., "R 12.34")
  static String formatTokensAsZar(int tokens) {
    final zar = tokens * 0.01;
    return _currencyFormat.format(zar);
  }

  /// Format ZAR amount (e.g., "R 12.34")
  static String formatZar(double amount) {
    return _currencyFormat.format(amount);
  }

  /// Format large ZAR amounts compactly (e.g., "R 1.2K")
  static String formatZarCompact(double amount) {
    return _compactCurrencyFormat.format(amount);
  }

  /// Format phone number for display (e.g., "082 123 4567")
  static String formatPhoneNumber(String phoneNumber) {
    // Handle E.164 format (+27821234567)
    if (phoneNumber.startsWith('+27') && phoneNumber.length == 12) {
      final local = '0${phoneNumber.substring(3)}';
      return '${local.substring(0, 3)} ${local.substring(3, 6)} ${local.substring(6)}';
    }

    // Handle local format (0821234567)
    if (phoneNumber.startsWith('0') && phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    }

    return phoneNumber;
  }

  /// Get initials from name (e.g., "John Doe" -> "JD")
  static String getInitials(String name) {
    if (name.isEmpty) return '??';

    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();

    if (parts.isEmpty) return '??';
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length.clamp(0, 2)).toUpperCase();
    }

    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Format rank with suffix (e.g., "1st", "2nd", "3rd", "4th")
  static String formatRank(int rank) {
    if (rank <= 0) return '-';

    final suffix = _getRankSuffix(rank);
    return '${_numberFormat.format(rank)}$suffix';
  }

  static String _getRankSuffix(int rank) {
    if (rank >= 11 && rank <= 13) {
      return 'th';
    }
    switch (rank % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// Format percentage (e.g., "35%")
  static String formatPercent(double value) {
    return '${(value * 100).toInt()}%';
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 3)}...';
  }
}
