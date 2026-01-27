import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/cashout/cashout_bloc.dart';
import 'presentation/blocs/chat/chat_bloc.dart';
import 'presentation/blocs/earn/earn_bloc.dart';
import 'presentation/blocs/pot/pot_bloc.dart';
import 'presentation/blocs/purchase/purchase_bloc.dart';
import 'presentation/blocs/referral/referral_bloc.dart';
import 'presentation/blocs/wallet/wallet_bloc.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_theme.dart';

/// Main application widget
class IMaliChatApp extends StatefulWidget {
  const IMaliChatApp({super.key});

  @override
  State<IMaliChatApp> createState() => _IMaliChatAppState();
}

class _IMaliChatAppState extends State<IMaliChatApp> {
  late final AuthBloc _authBloc;
  late final WalletBloc _walletBloc;
  late final EarnBloc _earnBloc;
  late final CashoutBloc _cashoutBloc;
  late final ChatBloc _chatBloc;
  late final PotBloc _potBloc;
  late final PurchaseBloc _purchaseBloc;
  late final ReferralBloc _referralBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();
    _walletBloc = getIt<WalletBloc>();
    _earnBloc = getIt<EarnBloc>();
    _cashoutBloc = getIt<CashoutBloc>();
    _chatBloc = getIt<ChatBloc>();
    _potBloc = getIt<PotBloc>();
    _purchaseBloc = getIt<PurchaseBloc>();
    _referralBloc = getIt<ReferralBloc>();
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<WalletBloc>.value(value: _walletBloc),
        BlocProvider<EarnBloc>.value(value: _earnBloc),
        BlocProvider<CashoutBloc>.value(value: _cashoutBloc),
        BlocProvider<ChatBloc>.value(value: _chatBloc),
        BlocProvider<PotBloc>.value(value: _potBloc),
        BlocProvider<PurchaseBloc>.value(value: _purchaseBloc),
        BlocProvider<ReferralBloc>.value(value: _referralBloc),
      ],
      child: MaterialApp.router(
        title: 'iMali',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
