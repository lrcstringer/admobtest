import 'dart:async';

import 'package:flutter/services.dart';

/// Copies text to the clipboard and automatically clears it after [clearAfter].
///
/// Prevents sensitive data (referral codes, account numbers, voucher codes)
/// from lingering on the clipboard where other apps can read it.
class SecureClipboard {
  SecureClipboard._();

  static Timer? _clearTimer;

  /// Copy [text] and auto-clear after [clearAfter] (default 30 seconds).
  static Future<void> copy(
    String text, {
    Duration clearAfter = const Duration(seconds: 30),
  }) async {
    _clearTimer?.cancel();
    await Clipboard.setData(ClipboardData(text: text));

    _clearTimer = Timer(clearAfter, () {
      Clipboard.setData(const ClipboardData(text: ''));
    });
  }
}
