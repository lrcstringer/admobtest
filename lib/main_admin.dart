import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_app.dart';
import 'core/di/injection.dart';
import 'firebase_options.dart';

/// Entry point for the iMali Admin Portal (Web)
///
/// This is a separate entry point for the admin web dashboard.
/// Build with: flutter build web --target lib/main_admin.dart -o build/admin
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure dependencies (shared with mobile app)
  await configureDependencies();

  // Set up Bloc observer for debugging
  if (kDebugMode) {
    Bloc.observer = AdminBlocObserver();
  }

  runApp(const IMaliAdminApp());
}

/// Bloc observer for debugging and logging
class AdminBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('[Admin] onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('[Admin] onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('[Admin] onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}
