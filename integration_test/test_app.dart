import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:imalichat/presentation/blocs/auth/auth_bloc.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';
import 'package:imalichat/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:imalichat/presentation/router/app_router.dart';
import 'package:imalichat/presentation/theme/app_theme.dart';

import 'mocks/mock_dependencies.dart';

/// Test app wrapper for integration tests.
/// Uses mock dependencies instead of real Firebase services.
class TestApp extends StatefulWidget {
  final MockDependencies mocks;

  const TestApp({
    super.key,
    required this.mocks,
  });

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  late final AuthBloc _authBloc;
  late final EarnBloc _earnBloc;
  late final WalletBloc _walletBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = widget.mocks.authBloc;
    _earnBloc = widget.mocks.earnBloc;
    _walletBloc = widget.mocks.walletBloc;
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _earnBloc),
        BlocProvider.value(value: _walletBloc),
      ],
      child: MaterialApp.router(
        title: 'iMali Test',
        theme: AppTheme.dark,
        routerConfig: _appRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
