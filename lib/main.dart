import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Sign in anonymously so Firestore writes are authenticated.
  // Non-fatal: if anonymous auth is disabled or offline, the app still loads.
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (e) {
    debugPrint('[Auth] Anonymous sign-in failed: $e');
  }

  MobileAds.instance.initialize();
  await configureDependencies();

  runApp(const PlayAdApp());
}
