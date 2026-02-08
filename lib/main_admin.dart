import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'admin_app.dart';
import 'firebase_options.dart';

/// Entry point for the iMali Admin Portal (Web)
///
/// This is a separate entry point for the admin web dashboard.
/// Build with: flutter build web --target lib/main_admin.dart -o build/admin
/// Run locally: flutter run -d chrome --target lib/main_admin.dart
///
/// Uses its own lightweight DI — does NOT use the shared injectable
/// config (which pulls in drift/sqlite3/local_auth and other
/// mobile-only packages incompatible with web).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const IMaliAdminApp());
}
