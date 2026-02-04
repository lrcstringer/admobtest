import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/client/router/client_router.dart';
import 'presentation/theme/app_theme.dart';

/// Client/Brand Portal Application Widget
///
/// Web-optimized portal for brand partners:
/// - Campaign management
/// - Analytics and reporting
/// - Content approval
/// - Audience targeting
class IMaliClientApp extends StatefulWidget {
  const IMaliClientApp({super.key});

  @override
  State<IMaliClientApp> createState() => _IMaliClientAppState();
}

class _IMaliClientAppState extends State<IMaliClientApp> {
  late final AuthBloc _authBloc;
  late final ClientRouter _clientRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();
    _clientRouter = ClientRouter(authBloc: _authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
      ],
      child: MaterialApp.router(
        title: 'iMali Brand Portal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: _clientRouter.router,
      ),
    );
  }
}
