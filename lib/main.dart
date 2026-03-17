// App Check disabled until Play Store publish — Play Integrity requires listing
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart'
    as callkit;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'core/security/rasp_service.dart';
import 'core/security/screenshot_prevention_service.dart';
import 'core/security/version_enforcement_service.dart';
import 'data/datasources/local/app_database.dart';
import 'firebase_options.dart';

/// Top-level background message handler for FCM.
/// Must be a top-level function (not a class method).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final type = message.data['type'] as String?;

  // Handle call cancellation — dismiss CallKit UI and stop ringing
  if (type == 'call_ended') {
    final callId = message.data['callId'] as String? ?? '';
    if (callId.isNotEmpty) {
      await FlutterCallkitIncoming.endCall(callId);
    }
    return;
  }

  // Handle incoming call push in background/killed state
  if (type == 'incoming_call') {
    final callId = message.data['callId'] as String? ?? '';
    final callerName = message.data['callerName'] as String? ?? 'Unknown';
    final callerAvatarUrl = message.data['callerAvatarUrl'] as String?;
    final callType = message.data['callType'] as String? ?? 'voice';
    final hasVideo = callType == 'video';

    final params = callkit.CallKitParams(
      id: callId,
      nameCaller: callerName,
      avatar: callerAvatarUrl,
      type: hasVideo ? 1 : 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      duration: 30000,
      extra: <String, dynamic>{
        'callId': callId,
        'conversationId': message.data['conversationId'] ?? '',
        'callerId': message.data['callerId'] ?? '',
        'callerName': callerName,
        'callerAvatarUrl': callerAvatarUrl ?? '',
        'callType': callType,
      },
      android: const callkit.AndroidParams(
        isCustomNotification: false,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        actionColor: '#4CAF50',
        isShowFullLockedScreen: true,
      ),
      ios: const callkit.IOSParams(
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
    return;
  }

  // Background challenges are handled when the app opens via
  // getInitialMessage / onMessageOpenedApp in app.dart
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Suppress all debugPrint output in release builds to prevent
  // leaking security-sensitive info (keys, tokens, crypto state) via logcat.
  if (!kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF2C325C),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable Firestore offline persistence with a generous cache size.
  // Default on mobile is 40 MB; 100 MB gives more headroom for cached
  // threads, opportunities, and engagement history across sessions.
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: 100 * 1024 * 1024, // 100 MB
  );

  // Disable RTDB disk persistence — signaling data is ephemeral.
  // SDK still queues writes in-memory over the persistent WebSocket.
  FirebaseDatabase.instance.setPersistenceEnabled(false);

  // Initialize Google Mobile Ads SDK (don't block app launch)
  MobileAds.instance.initialize();

  // App Check disabled — Play Integrity requires the app to be listed on Play Store.
  // SafetyNet has been deprecated and removed by Google.
  // Server-side enforcement is disabled (security.ts enforce=false) so this is safe to skip.
  // Once on Play Store, uncomment and use AndroidProvider.playIntegrity:
  //
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider:
  //       kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  //   appleProvider:
  //       kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
  // );

  // Register FCM background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Configure dependencies
  await configureDependencies();

  // Warm up the encrypted DB connection (FlutterSecureStorage key read +
  // SQLCipher open can take 1-3s). Fire-and-forget so it doesn't block startup,
  // but starts early enough to be ready before the messaging screen mounts.
  GetIt.instance<AppDatabase>().warmUp();

  // Initialize Runtime Application Self-Protection (skip in debug)
  // Fire-and-forget: don't block app startup; RASP has internal timeout
  if (!kDebugMode) {
    GetIt.instance<RaspService>().initialize();
  }

  // Enable screenshot prevention in release builds
  if (!kDebugMode) {
    GetIt.instance<ScreenshotPreventionService>().enable();
  }

  // Check minimum app version (non-blocking on failure)
  if (!kDebugMode) {
    final versionResult =
        await GetIt.instance<VersionEnforcementService>().check();
    if (versionResult == VersionCheckResult.updateRequired) {
      runApp(const _ForceUpdateApp());
      return;
    }
  }

  // Set up Bloc observer for debugging (only in debug mode)
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }

  runApp(const IMaliChatApp());
}

/// Bloc observer for debugging and logging
/// Only active in debug mode to avoid performance overhead in production.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) debugPrint('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) debugPrint('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Always log errors, but use different strategies for debug vs release
    if (kDebugMode) {
      debugPrint('onError -- ${bloc.runtimeType}, $error');
    }
    // In production, errors are captured by the ErrorHandler/crash reporting
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) debugPrint('onClose -- ${bloc.runtimeType}');
  }
}

/// Minimal app shown when the installed version is below the server minimum.
/// Blocks all functionality and directs the user to update.
class _ForceUpdateApp extends StatelessWidget {
  const _ForceUpdateApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1F3C),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.system_update, size: 64, color: Colors.white),
                const SizedBox(height: 24),
                const Text(
                  'Update Required',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'A newer version of iMaliChat is available. '
                  'Please update the app to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Opens the Play Store / App Store listing
                    // TODO: Replace with actual store URL once published
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0955FA),
                    minimumSize: const Size(200, 48),
                  ),
                  child: const Text('Update Now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
