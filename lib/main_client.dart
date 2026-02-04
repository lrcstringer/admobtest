import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  // Set up Bloc observer for debugging
  if (kDebugMode) {
    Bloc.observer = ClientBlocObserver();
  }

  runApp(const IMaliClientApp());
}

/// Bloc observer for debugging and logging
class ClientBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('[Client] onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('[Client] onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('[Client] onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}
