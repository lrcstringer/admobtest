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
        debugPrint('[RASP] App integrity violation detected');
        _handleCriticalThreat('app_integrity');
      },
      onObfuscationIssues: () {
        debugPrint('[RASP] Obfuscation issues detected');
      },
      onDebug: () {
        debugPrint('[RASP] Debugger attached');
        _handleCriticalThreat('debugger');
      },
      onDeviceBinding: () {
        debugPrint('[RASP] Device binding violation');
      },
      onHooks: () {
        debugPrint('[RASP] Hooking framework detected (Frida/Xposed)');
        _handleCriticalThreat('hooks');
      },
      onPasscode: () {
        debugPrint('[RASP] Device has no passcode set');
      },
      onPrivilegedAccess: () {
        debugPrint('[RASP] Rooted/jailbroken device detected');
        _handleCriticalThreat('root');
      },
      onSecureHardwareNotAvailable: () {
        debugPrint('[RASP] Secure hardware not available');
      },
      onSimulator: () {
        debugPrint('[RASP] Running on emulator/simulator');
      },
      onUnofficialStore: () {
        debugPrint('[RASP] App installed from unofficial store');
      },
    );

    try {
      Talsec.instance.attachListener(callback);
      await Talsec.instance.start(config).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint('[RASP] Initialization timed out — continuing without RASP');
        },
      );
      _initialized = true;
      debugPrint('[RASP] Initialized successfully');
    } catch (e) {
      debugPrint('[RASP] Initialization failed: $e — continuing without RASP');
    }
  }

  void _handleCriticalThreat(String threatType) {
    debugPrint('[RASP] CRITICAL THREAT: $threatType — forcing re-auth');
    _authBloc.add(const AuthEvent.forceReauth());
  }
}
