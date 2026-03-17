import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'client_app.dart';
import 'core/di/injection.dart';
import 'firebase_options.dart';

/// Entry point for the iMali Client/Brand Portal (Web)
///
/// This is a separate entry point for brand partners to manage campaigns.
/// Build with: flutter build web --target lib/main_client.dart -o build/client
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure dependencies (shared with mobile app)
  await configureDependencies();

  runApp(const IMaliClientApp());
}
