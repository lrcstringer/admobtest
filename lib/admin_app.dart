import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/admin/blocs/admin_auth_cubit.dart';
import 'presentation/admin/router/admin_router.dart';
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
  late final AdminAuthCubit _authCubit;
  late final AdminRouter _adminRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = AdminAuthCubit();
    _adminRouter = AdminRouter(authCubit: _authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminAuthCubit>.value(
      value: _authCubit,
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
