import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'presentation/admin/router/admin_router.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/theme/app_theme.dart';

/// Admin Portal Application Widget
///
/// Web-optimized admin dashboard for iMali operations:
/// - Ledger reconciliation
/// - Pot management
/// - User management
/// - Cashout approvals
class IMaliAdminApp extends StatefulWidget {
  const IMaliAdminApp({super.key});

  @override
  State<IMaliAdminApp> createState() => _IMaliAdminAppState();
}

class _IMaliAdminAppState extends State<IMaliAdminApp> {
  late final AuthBloc _authBloc;
  late final AdminRouter _adminRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();
    _adminRouter = AdminRouter(authBloc: _authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
      ],
      child: MaterialApp.router(
        title: 'iMali Admin',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: _adminRouter.router,
      ),
    );
  }
}
