// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:local_auth/local_auth.dart' as _i152;

import '../../data/services/admob_service.dart' as _i284;
import '../security/audit_logger.dart' as _i988;
import '../security/device_capability_service.dart' as _i309;
import '../security/pin_manager.dart' as _i752;
import '../security/session_lock_service.dart' as _i942;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => registerModule.firestore,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i152.LocalAuthentication>(
      () => registerModule.localAuthentication,
    );
    gh.lazySingleton<_i309.DeviceCapabilityService>(
      () => _i309.DeviceCapabilityService(
        gh<_i152.LocalAuthentication>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i752.PinManager>(
      () => _i752.PinManager(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i988.AuditLogger>(
      () => _i988.AuditLogger(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i942.SessionLockService>(
      () => _i942.SessionLockService(
        gh<_i309.DeviceCapabilityService>(),
        gh<_i152.LocalAuthentication>(),
        gh<_i752.PinManager>(),
        gh<_i988.AuditLogger>(),
      ),
    );
    gh.lazySingleton<_i284.AdMobService>(
      () => _i284.AdMobService(
        gh<_i942.SessionLockService>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
