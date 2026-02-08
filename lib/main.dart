// TODO: Uncomment when enabling App Check after Play Store publish
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'core/security/rasp_service.dart';
//import 'core/security/screenshot_prevention_service.dart';
import 'core/services/fcm_challenge_handler.dart';
import 'firebase_options.dart';

/// Top-level background message handler for FCM.
/// Must be a top-level function (not a class method).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Background challenges are handled when the app opens via
  // getInitialMessage / onMessageOpenedApp in app.dart
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      systemNavigationBarColor: Color(0xFF0C1124),
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

  // Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  // TODO: Activate App Check once app is published to Google Play
  // Play Integrity requires the app to be listed on Play Store.
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

  // Initialize Runtime Application Self-Protection (skip in debug)
  if (!kDebugMode) {
    final raspService = GetIt.instance<RaspService>();
    await raspService.initialize();
  }

  // TODO: Re-enable screenshot prevention before production release
  // Enable screenshot prevention (skip in debug for testing)
  // if (!kDebugMode) {
  //   final screenshotService = GetIt.instance<ScreenshotPreventionService>();
  //   await screenshotService.enable();
  // }

  // Start listening for auth challenge push notifications
  final challengeHandler = GetIt.instance<FcmChallengeHandler>();
  challengeHandler.startListening();

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
