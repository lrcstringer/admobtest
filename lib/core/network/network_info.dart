import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstract interface for checking network connectivity
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using internet_connection_checker_plus
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _internetConnection;

  NetworkInfoImpl(this._internetConnection);

  @override
  Future<bool> get isConnected async {
    return await _internetConnection.hasInternetAccess;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _internetConnection.onStatusChange.map(
      (status) => status == InternetStatus.connected,
    );
  }
}
