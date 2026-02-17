import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

/// Prevents screenshots and screen recording on both Android and iOS.
///
/// Android: Uses FLAG_SECURE on the window.
/// iOS: Uses secure text field overlay technique.
@lazySingleton
class ScreenshotPreventionService {
  static const _channel = MethodChannel('com.imalichat/screenshot');

  Future<void> enable() async {
    try {
      await _channel.invokeMethod('enableSecure');
    } on MissingPluginException {
      // Platform channel not available (e.g., running on web or desktop)
    }
  }

  Future<void> disable() async {
    try {
      await _channel.invokeMethod('disableSecure');
    } on MissingPluginException {
      // Platform channel not available
    }
  }
}
