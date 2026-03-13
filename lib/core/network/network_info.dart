import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstract interface for checking network connectivity
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using internet_connection_checker_plus.
///
/// The connectivity stream is debounced by 500ms to prevent redundant
/// processing during WiFi/cellular flaps (quick disconnect/reconnect cycles).
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _internetConnection;

  /// Debounce duration to filter out transient connectivity flaps.
  static const _debounceDuration = Duration(milliseconds: 500);

  NetworkInfoImpl(this._internetConnection);

  @override
  Future<bool> get isConnected async {
    return await _internetConnection.hasInternetAccess;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    // Debounce: only emit after connectivity state is stable for 500ms.
    // This prevents redundant sync restarts during WiFi↔cellular handoffs.
    return _internetConnection.onStatusChange
        .map((status) => status == InternetStatus.connected)
        .distinct()
        .transform(_debounceTransformer(_debounceDuration));
  }

  /// Creates a stream transformer that debounces events by [duration].
  static StreamTransformer<T, T> _debounceTransformer<T>(Duration duration) {
    Timer? timer;
    return StreamTransformer<T, T>.fromHandlers(
      handleData: (T data, EventSink<T> sink) {
        timer?.cancel();
        timer = Timer(duration, () => sink.add(data));
      },
      handleDone: (EventSink<T> sink) {
        timer?.cancel();
        sink.close();
      },
    );
  }
}
