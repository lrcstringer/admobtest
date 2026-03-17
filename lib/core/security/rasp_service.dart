import 'package:flutter/foundation.dart';
import 'package:freerasp/freerasp.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/blocs/auth/auth_bloc.dart';

/// Runtime Application Self-Protection (RASP) service.
///
/// Detects tampering, rooting, hooking frameworks (Frida), debuggers,
/// emulators, and unofficial app stores. Critical threats force
/// re-authentication to protect user funds.
@lazySingleton
class RaspService {
  final AuthBloc _authBloc;
  bool _initialized = false;

  RaspService(this._authBloc);

  Future<void> initialize() async {
    if (_initialized || kDebugMode) return;

    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'com.imalichat.app',
        signingCertHashes: ['++ys+86Amp+pFhaBPLAwcISWowW/a5Msc1bntnILIBY='],
      ),
      iosConfig: IOSConfig(
        bundleIds: ['com.imalichat.app'],
        // TODO: Replace with your real Apple Developer Team ID from
        // https://developer.apple.com → Membership → Team ID
        teamId: 'PLACEHOLDER_TEAM_ID',
      ),
      watcherMail: 'security@imalichat.com',
    );

    final callback = ThreatCallback(
      onAppIntegrity: () {
        _handleCriticalThreat('app_integrity');
      },
      onObfuscationIssues: () {
      },
      onDebug: () {
        _handleCriticalThreat('debugger');
      },
      onDeviceBinding: () {
      },
      onHooks: () {
        _handleCriticalThreat('hooks');
      },
      onPasscode: () {
      },
      onPrivilegedAccess: () {
        _handleCriticalThreat('root');
      },
      onSecureHardwareNotAvailable: () {
      },
      onSimulator: () {
      },
      onUnofficialStore: () {
      },
    );

    try {
      Talsec.instance.attachListener(callback);
      await Talsec.instance.start(config).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
        },
      );
      _initialized = true;
    } catch (e) {
    }
  }

  void _handleCriticalThreat(String threatType) {
    _authBloc.add(const AuthEvent.forceReauth());
  }
}
