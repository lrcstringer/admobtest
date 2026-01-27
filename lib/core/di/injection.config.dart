// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/remote/auth_remote_datasource.dart' as _i1057;
import '../../data/datasources/remote/chat_remote_datasource.dart' as _i224;
import '../../data/datasources/remote/earn_remote_datasource.dart' as _i520;
import '../../data/datasources/remote/gamification_remote_datasource.dart'
    as _i749;
import '../../data/datasources/remote/purchase_remote_datasource.dart' as _i267;
import '../../data/datasources/remote/referral_remote_datasource.dart' as _i9;
import '../../data/datasources/remote/user_remote_datasource.dart' as _i50;
import '../../data/datasources/remote/wallet_remote_datasource.dart' as _i389;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/chat_repository_impl.dart' as _i838;
import '../../data/repositories/earn_repository_impl.dart' as _i965;
import '../../data/repositories/gamification_repository_impl.dart' as _i500;
import '../../data/repositories/purchase_repository_impl.dart' as _i1044;
import '../../data/repositories/referral_repository_impl.dart' as _i904;
import '../../data/repositories/user_repository_impl.dart' as _i790;
import '../../data/repositories/wallet_repository_impl.dart' as _i520;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/chat_repository.dart' as _i1072;
import '../../domain/repositories/earn_repository.dart' as _i805;
import '../../domain/repositories/gamification_repository.dart' as _i1010;
import '../../domain/repositories/purchase_repository.dart' as _i742;
import '../../domain/repositories/referral_repository.dart' as _i633;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/repositories/wallet_repository.dart' as _i851;
import '../../presentation/blocs/auth/auth_bloc.dart' as _i141;
import '../../presentation/blocs/cashout/cashout_bloc.dart' as _i772;
import '../../presentation/blocs/chat/chat_bloc.dart' as _i142;
import '../../presentation/blocs/earn/earn_bloc.dart' as _i775;
import '../../presentation/blocs/pot/pot_bloc.dart' as _i58;
import '../../presentation/blocs/purchase/purchase_bloc.dart' as _i936;
import '../../presentation/blocs/referral/referral_bloc.dart' as _i595;
import '../../presentation/blocs/wallet/wallet_bloc.dart' as _i1019;
import '../network/network_info.dart' as _i932;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(
      () => registerModule.firebaseStorage,
    );
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => registerModule.internetConnection,
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i1057.AuthRemoteDataSource>(
      () => _i1057.AuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i749.GamificationRemoteDataSource>(
      () => _i749.GamificationRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i224.ChatRemoteDataSource>(
      () => _i224.ChatRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i389.WalletRemoteDataSource>(
      () => _i389.WalletRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i50.UserRemoteDataSource>(
      () => _i50.UserRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i520.EarnRemoteDataSource>(
      () => _i520.EarnRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i267.PurchaseRemoteDataSource>(
      () => _i267.PurchaseRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i9.ReferralRemoteDataSource>(
      () => _i9.ReferralRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i1072.ChatRepository>(
      () => _i838.ChatRepositoryImpl(gh<_i224.ChatRemoteDataSource>()),
    );
    gh.lazySingleton<_i805.EarnRepository>(
      () => _i965.EarnRepositoryImpl(gh<_i520.EarnRemoteDataSource>()),
    );
    gh.lazySingleton<_i271.UserRepository>(
      () => _i790.UserRepositoryImpl(
        gh<_i50.UserRemoteDataSource>(),
        gh<_i1057.AuthRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i851.WalletRepository>(
      () => _i520.WalletRepositoryImpl(
        gh<_i389.WalletRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1010.GamificationRepository>(
      () => _i500.GamificationRepositoryImpl(
        gh<_i749.GamificationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i895.AuthRepositoryImpl(
        gh<_i1057.AuthRemoteDataSource>(),
        gh<_i50.UserRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i58.PotBloc>(
      () => _i58.PotBloc(gh<_i1010.GamificationRepository>()),
    );
    gh.lazySingleton<_i742.PurchaseRepository>(
      () => _i1044.PurchaseRepositoryImpl(gh<_i267.PurchaseRemoteDataSource>()),
    );
    gh.factory<_i141.AuthBloc>(
      () => _i141.AuthBloc(
        gh<_i1073.AuthRepository>(),
        gh<_i271.UserRepository>(),
      ),
    );
    gh.lazySingleton<_i633.ReferralRepository>(
      () => _i904.ReferralRepositoryImpl(gh<_i9.ReferralRemoteDataSource>()),
    );
    gh.factory<_i142.ChatBloc>(
      () => _i142.ChatBloc(gh<_i1072.ChatRepository>()),
    );
    gh.factory<_i595.ReferralBloc>(
      () => _i595.ReferralBloc(gh<_i633.ReferralRepository>()),
    );
    gh.factory<_i1019.WalletBloc>(
      () => _i1019.WalletBloc(gh<_i851.WalletRepository>()),
    );
    gh.factory<_i772.CashoutBloc>(
      () => _i772.CashoutBloc(gh<_i851.WalletRepository>()),
    );
    gh.factory<_i775.EarnBloc>(
      () => _i775.EarnBloc(gh<_i805.EarnRepository>()),
    );
    gh.factory<_i936.PurchaseBloc>(
      () => _i936.PurchaseBloc(gh<_i742.PurchaseRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
