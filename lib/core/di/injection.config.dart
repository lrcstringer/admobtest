// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
import 'package:firebase_app_check/firebase_app_check.dart' as _i56;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_database/firebase_database.dart' as _i345;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:local_auth/local_auth.dart' as _i152;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/local/app_database.dart' as _i483;
import '../../data/datasources/remote/admin_earn_remote_datasource.dart'
    as _i48;
import '../../data/datasources/remote/auth_remote_datasource.dart' as _i1057;
import '../../data/datasources/remote/buy_remote_datasource.dart' as _i574;
import '../../data/datasources/remote/call_remote_datasource.dart' as _i340;
import '../../data/datasources/remote/chat_remote_datasource.dart' as _i224;
import '../../data/datasources/remote/community_remote_datasource.dart'
    as _i560;
import '../../data/datasources/remote/conversation_remote_datasource.dart'
    as _i425;
import '../../data/datasources/remote/device_remote_datasource.dart' as _i433;
import '../../data/datasources/remote/earn_remote_datasource.dart' as _i520;
import '../../data/datasources/remote/feature_flag_remote_datasource.dart'
    as _i42;
import '../../data/datasources/remote/gamification_remote_datasource.dart'
    as _i749;
import '../../data/datasources/remote/gift_remote_datasource.dart' as _i108;
import '../../data/datasources/remote/group_buy_remote_datasource.dart'
    as _i590;
import '../../data/datasources/remote/group_remote_datasource.dart' as _i42;
import '../../data/datasources/remote/marketplace_remote_datasource.dart'
    as _i399;
import '../../data/datasources/remote/media_upload_datasource.dart' as _i654;
import '../../data/datasources/remote/moderation_remote_datasource.dart'
    as _i313;
import '../../data/datasources/remote/poll_remote_datasource.dart' as _i909;
import '../../data/datasources/remote/purchase_remote_datasource.dart' as _i267;
import '../../data/datasources/remote/referral_remote_datasource.dart' as _i9;
import '../../data/datasources/remote/reward_remote_datasource.dart' as _i366;
import '../../data/datasources/remote/token_pool_remote_datasource.dart'
    as _i684;
import '../../data/datasources/remote/token_spray_remote_datasource.dart'
    as _i1009;
import '../../data/datasources/remote/user_remote_datasource.dart' as _i50;
import '../../data/datasources/remote/wallet_remote_datasource.dart' as _i389;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/buy_repository_impl.dart' as _i193;
import '../../data/repositories/call_repository_impl.dart' as _i294;
import '../../data/repositories/chat_repository_impl.dart' as _i838;
import '../../data/repositories/community_repository_impl.dart' as _i462;
import '../../data/repositories/contact_repository_impl.dart' as _i133;
import '../../data/repositories/conversation_repository_impl.dart' as _i161;
import '../../data/repositories/device_repository_impl.dart' as _i34;
import '../../data/repositories/earn_repository_impl.dart' as _i965;
import '../../data/repositories/feature_flag_repository_impl.dart' as _i821;
import '../../data/repositories/gamification_repository_impl.dart' as _i500;
import '../../data/repositories/gift_repository_impl.dart' as _i350;
import '../../data/repositories/group_buy_repository_impl.dart' as _i923;
import '../../data/repositories/group_repository_impl.dart' as _i654;
import '../../data/repositories/marketplace_repository_impl.dart' as _i199;
import '../../data/repositories/moderation_repository_impl.dart' as _i527;
import '../../data/repositories/poll_repository_impl.dart' as _i570;
import '../../data/repositories/purchase_repository_impl.dart' as _i1044;
import '../../data/repositories/referral_repository_impl.dart' as _i904;
import '../../data/repositories/reward_repository_impl.dart' as _i905;
import '../../data/repositories/token_pool_repository_impl.dart' as _i889;
import '../../data/repositories/token_spray_repository_impl.dart' as _i895;
import '../../data/repositories/user_repository_impl.dart' as _i790;
import '../../data/repositories/wallet_repository_impl.dart' as _i520;
import '../../data/services/admob_service.dart' as _i284;
import '../../data/services/upload_service.dart' as _i434;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/buy_repository.dart' as _i637;
import '../../domain/repositories/call_repository.dart' as _i658;
import '../../domain/repositories/chat_repository.dart' as _i1072;
import '../../domain/repositories/community_repository.dart' as _i936;
import '../../domain/repositories/contact_repository.dart' as _i482;
import '../../domain/repositories/conversation_repository.dart' as _i973;
import '../../domain/repositories/device_repository.dart' as _i454;
import '../../domain/repositories/earn_repository.dart' as _i805;
import '../../domain/repositories/feature_flag_repository.dart' as _i993;
import '../../domain/repositories/gamification_repository.dart' as _i1010;
import '../../domain/repositories/gift_repository.dart' as _i533;
import '../../domain/repositories/group_buy_repository.dart' as _i525;
import '../../domain/repositories/group_repository.dart' as _i708;
import '../../domain/repositories/marketplace_repository.dart' as _i631;
import '../../domain/repositories/moderation_repository.dart' as _i862;
import '../../domain/repositories/poll_repository.dart' as _i731;
import '../../domain/repositories/purchase_repository.dart' as _i742;
import '../../domain/repositories/referral_repository.dart' as _i633;
import '../../domain/repositories/reward_repository.dart' as _i191;
import '../../domain/repositories/token_pool_repository.dart' as _i119;
import '../../domain/repositories/token_spray_repository.dart' as _i943;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/repositories/wallet_repository.dart' as _i851;
import '../../presentation/admin/blocs/admin_earn/admin_earn_bloc.dart'
    as _i1026;
import '../../presentation/blocs/auth/auth_bloc.dart' as _i141;
import '../../presentation/blocs/brand_storefront/brand_storefront_bloc.dart'
    as _i604;
import '../../presentation/blocs/buy_tab/buy_tab_bloc.dart' as _i809;
import '../../presentation/blocs/call/call_bloc.dart' as _i807;
import '../../presentation/blocs/cashout/cashout_bloc.dart' as _i772;
import '../../presentation/blocs/chat/chat_bloc.dart' as _i142;
import '../../presentation/blocs/community/community_bloc.dart' as _i856;
import '../../presentation/blocs/community_messaging/community_messaging_bloc.dart'
    as _i256;
import '../../presentation/blocs/contact/contact_bloc.dart' as _i792;
import '../../presentation/blocs/conversation/conversation_bloc.dart' as _i654;
import '../../presentation/blocs/conversation_actions/conversation_actions_bloc.dart'
    as _i531;
import '../../presentation/blocs/earn/earn_bloc.dart' as _i775;
import '../../presentation/blocs/earn_inbox/earn_inbox_bloc.dart' as _i480;
import '../../presentation/blocs/feature_flag/feature_flag_bloc.dart' as _i394;
import '../../presentation/blocs/gift/gift_bloc.dart' as _i66;
import '../../presentation/blocs/group/group_bloc.dart' as _i275;
import '../../presentation/blocs/group_buy/group_buy_bloc.dart' as _i399;
import '../../presentation/blocs/home/home_bloc.dart' as _i973;
import '../../presentation/blocs/marketplace/marketplace_bloc.dart' as _i46;
import '../../presentation/blocs/order/order_bloc.dart' as _i25;
import '../../presentation/blocs/pot/pot_bloc.dart' as _i58;
import '../../presentation/blocs/profile/profile_bloc.dart' as _i344;
import '../../presentation/blocs/provider_registration/provider_registration_bloc.dart'
    as _i682;
import '../../presentation/blocs/purchase/purchase_bloc.dart' as _i936;
import '../../presentation/blocs/referral/referral_bloc.dart' as _i595;
import '../../presentation/blocs/reward/reward_bloc.dart' as _i206;
import '../../presentation/blocs/token_pool/token_pool_bloc.dart' as _i969;
import '../../presentation/blocs/token_spray/token_spray_bloc.dart' as _i609;
import '../../presentation/blocs/user_search/user_search_bloc.dart' as _i812;
import '../../presentation/blocs/wallet/wallet_bloc.dart' as _i1019;
import '../network/network_info.dart' as _i932;
import '../security/audit_logger.dart' as _i988;
import '../security/device_binding_service.dart' as _i693;
import '../security/device_capability_service.dart' as _i309;
import '../security/keystore_service.dart' as _i892;
import '../security/pin_manager.dart' as _i752;
import '../security/play_integrity_service.dart' as _i351;
import '../security/rasp_service.dart' as _i727;
import '../security/screenshot_prevention_service.dart' as _i921;
import '../security/security_service.dart' as _i383;
import '../security/session_lock_service.dart' as _i942;
import '../security/sim_change_detector.dart' as _i925;
import '../security/step_up_auth_service.dart' as _i720;
import '../services/audio_playback_service.dart' as _i38;
import '../services/biometric_login_service.dart' as _i290;
import '../services/call_analytics_service.dart' as _i108;
import '../services/call_notification_service.dart' as _i673;
import '../services/call_signaling_service.dart' as _i846;
import '../services/chat_analytics_service.dart' as _i550;
import '../services/community_sync_service.dart' as _i310;
import '../services/crypto_service.dart' as _i1024;
import '../services/deep_link_service.dart' as _i391;
import '../services/key_backup_service.dart' as _i946;
import '../services/key_management_service.dart' as _i418;
import '../services/media_recovery_service.dart' as _i124;
import '../services/message_decryption_service.dart' as _i465;
import '../services/message_sync_service.dart' as _i1034;
import '../services/notification_service.dart' as _i941;
import '../services/offline_action_queue.dart' as _i340;
import '../services/outgoing_message_queue.dart' as _i111;
import '../services/sender_key_service.dart' as _i407;
import '../services/share_service.dart' as _i474;
import '../services/signal_protocol_service.dart' as _i161;
import '../services/webrtc_service.dart' as _i980;
import '../utils/error_handler.dart' as _i383;
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
    gh.lazySingleton<_i398.FirebaseAnalytics>(
      () => registerModule.firebaseAnalytics,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(
      () => registerModule.firebaseStorage,
    );
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
    );
    gh.lazySingleton<_i56.FirebaseAppCheck>(
      () => registerModule.firebaseAppCheck,
    );
    gh.lazySingleton<_i809.FirebaseFunctions>(
      () => registerModule.firebaseFunctions,
    );
    gh.lazySingleton<_i345.FirebaseDatabase>(
      () => registerModule.firebaseDatabase,
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => registerModule.internetConnection,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i152.LocalAuthentication>(
      () => registerModule.localAuthentication,
    );
    gh.lazySingleton<_i892.KeystoreService>(() => _i892.KeystoreService());
    gh.lazySingleton<_i921.ScreenshotPreventionService>(
      () => _i921.ScreenshotPreventionService(),
    );
    gh.lazySingleton<_i383.SecurityService>(() => _i383.SecurityService());
    gh.lazySingleton<_i673.CallNotificationService>(
      () => _i673.CallNotificationService(),
    );
    gh.lazySingleton<_i1024.CryptoService>(() => _i1024.CryptoService());
    gh.lazySingleton<_i391.DeepLinkService>(() => _i391.DeepLinkService());
    gh.lazySingleton<_i941.NotificationService>(
      () => _i941.NotificationService(),
    );
    gh.lazySingleton<_i980.WebRtcServiceFactory>(
      () => _i980.WebRtcServiceFactory(),
    );
    gh.lazySingleton<_i383.ErrorHandler>(() => _i383.ErrorHandler());
    gh.lazySingleton<_i483.AppDatabase>(() => _i483.AppDatabase());
    gh.lazySingleton<_i434.UploadService>(
      () => _i434.UploadService(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i50.UserRemoteDataSource>(
      () => _i50.UserRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i1057.AuthRemoteDataSource>(
      () => _i1057.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i846.CallSignalingService>(
      () => _i846.CallSignalingService(
        gh<_i974.FirebaseFirestore>(),
        gh<_i345.FirebaseDatabase>(),
      ),
    );
    gh.lazySingleton<_i654.MediaUploadDatasource>(
      () => _i654.MediaUploadDatasource(
        gh<_i457.FirebaseStorage>(),
        gh<_i1024.CryptoService>(),
      ),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i366.RewardRemoteDataSource>(
      () => _i366.RewardRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i418.KeyManagementService>(
      () => _i418.KeyManagementService(
        gh<_i1024.CryptoService>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i399.MarketplaceRemoteDataSource>(
      () => _i399.MarketplaceRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i161.SignalProtocolService>(
      () => _i161.SignalProtocolService(
        gh<_i418.KeyManagementService>(),
        gh<_i1024.CryptoService>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i271.UserRepository>(
      () => _i790.UserRepositoryImpl(
        gh<_i50.UserRemoteDataSource>(),
        gh<_i1057.AuthRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i590.GroupBuyRemoteDataSource>(
      () => _i590.GroupBuyRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i752.PinManager>(
      () => _i752.PinManager(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i48.AdminEarnRemoteDataSource>(
      () => _i48.AdminEarnRemoteDataSource(
        gh<_i809.FirebaseFunctions>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i433.DeviceRemoteDataSource>(
      () => _i433.DeviceRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i191.RewardRepository>(
      () => _i905.RewardRepositoryImpl(gh<_i366.RewardRemoteDataSource>()),
    );
    gh.lazySingleton<_i631.MarketplaceRepository>(
      () => _i199.MarketplaceRepositoryImpl(
        gh<_i399.MarketplaceRemoteDataSource>(),
        gh<_i654.MediaUploadDatasource>(),
      ),
    );
    gh.lazySingleton<_i749.GamificationRemoteDataSource>(
      () => _i749.GamificationRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i946.KeyBackupService>(
      () => _i946.KeyBackupService(
        gh<_i418.KeyManagementService>(),
        gh<_i1024.CryptoService>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i474.ShareService>(
      () => _i474.ShareService(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i525.GroupBuyRepository>(
      () => _i923.GroupBuyRepositoryImpl(gh<_i590.GroupBuyRemoteDataSource>()),
    );
    gh.lazySingleton<_i988.AuditLogger>(
      () => _i988.AuditLogger(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i124.MediaRecoveryService>(
      () => _i124.MediaRecoveryService(
        gh<_i892.KeystoreService>(),
        gh<_i1024.CryptoService>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i313.ModerationRemoteDatasource>(
      () => _i313.ModerationRemoteDatasourceImpl(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i309.DeviceCapabilityService>(
      () => _i309.DeviceCapabilityService(
        gh<_i152.LocalAuthentication>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i38.AudioPlaybackService>(
      () => _i38.AudioPlaybackService(gh<_i654.MediaUploadDatasource>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i895.AuthRepositoryImpl(
        gh<_i1057.AuthRemoteDataSource>(),
        gh<_i50.UserRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
        gh<_i483.AppDatabase>(),
      ),
    );
    gh.lazySingleton<_i108.CallAnalyticsService>(
      () => _i108.CallAnalyticsService(gh<_i398.FirebaseAnalytics>()),
    );
    gh.lazySingleton<_i550.ChatAnalyticsService>(
      () => _i550.ChatAnalyticsService(gh<_i398.FirebaseAnalytics>()),
    );
    gh.lazySingleton<_i925.SimChangeDetector>(
      () => _i925.SimChangeDetector(
        gh<_i892.KeystoreService>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i988.AuditLogger>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i574.BuyRemoteDataSource>(
      () => _i574.BuyRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i351.PlayIntegrityService>(
      () => _i351.PlayIntegrityService(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i340.CallRemoteDatasource>(
      () => _i340.CallRemoteDatasource(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i909.PollRemoteDataSource>(
      () => _i909.PollRemoteDataSource(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i425.ConversationRemoteDataSource>(
      () => _i425.ConversationRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i407.SenderKeyService>(
      () => _i407.SenderKeyService(
        gh<_i1024.CryptoService>(),
        gh<_i161.SignalProtocolService>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i42.FeatureFlagRemoteDataSource>(
      () => _i42.FeatureFlagRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i482.ContactRepository>(
      () => _i133.ContactRepositoryImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i454.DeviceRepository>(
      () => _i34.DeviceRepositoryImpl(
        gh<_i433.DeviceRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i206.RewardBloc>(
      () => _i206.RewardBloc(gh<_i191.RewardRepository>()),
    );
    gh.lazySingleton<_i465.MessageDecryptionService>(
      () => _i465.MessageDecryptionService(
        gh<_i161.SignalProtocolService>(),
        gh<_i425.ConversationRemoteDataSource>(),
        gh<_i483.AppDatabase>(),
      ),
    );
    gh.lazySingleton<_i9.ReferralRemoteDataSource>(
      () => _i9.ReferralRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i637.BuyRepository>(
      () => _i193.BuyRepositoryImpl(
        gh<_i574.BuyRemoteDataSource>(),
        gh<_i483.AppDatabase>(),
      ),
    );
    gh.factory<_i46.MarketplaceBloc>(
      () => _i46.MarketplaceBloc(gh<_i631.MarketplaceRepository>()),
    );
    gh.factory<_i25.OrderBloc>(
      () => _i25.OrderBloc(gh<_i631.MarketplaceRepository>()),
    );
    gh.factory<_i682.ProviderRegistrationBloc>(
      () => _i682.ProviderRegistrationBloc(gh<_i631.MarketplaceRepository>()),
    );
    gh.lazySingleton<_i267.PurchaseRemoteDataSource>(
      () => _i267.PurchaseRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i862.ModerationRepository>(
      () => _i527.ModerationRepositoryImpl(
        gh<_i313.ModerationRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i658.CallRepository>(
      () => _i294.CallRepositoryImpl(gh<_i340.CallRemoteDatasource>()),
    );
    gh.lazySingleton<_i942.SessionLockService>(
      () => _i942.SessionLockService(
        gh<_i309.DeviceCapabilityService>(),
        gh<_i152.LocalAuthentication>(),
        gh<_i752.PinManager>(),
        gh<_i988.AuditLogger>(),
      ),
    );
    gh.lazySingleton<_i1034.MessageSyncService>(
      () => _i1034.MessageSyncService(
        gh<_i425.ConversationRemoteDataSource>(),
        gh<_i465.MessageDecryptionService>(),
        gh<_i483.AppDatabase>(),
        gh<_i124.MediaRecoveryService>(),
      ),
    );
    gh.factory<_i399.GroupBuyBloc>(
      () => _i399.GroupBuyBloc(gh<_i525.GroupBuyRepository>()),
    );
    gh.factory<_i1026.AdminEarnBloc>(
      () => _i1026.AdminEarnBloc(gh<_i48.AdminEarnRemoteDataSource>()),
    );
    gh.lazySingleton<_i1010.GamificationRepository>(
      () => _i500.GamificationRepositoryImpl(
        gh<_i749.GamificationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i993.FeatureFlagRepository>(
      () => _i821.FeatureFlagRepositoryImpl(
        gh<_i42.FeatureFlagRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i224.ChatRemoteDataSource>(
      () => _i224.ChatRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i389.WalletRemoteDataSource>(
      () => _i389.WalletRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i560.CommunityRemoteDataSource>(
      () => _i560.CommunityRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.factory<_i604.BrandStorefrontBloc>(
      () => _i604.BrandStorefrontBloc(gh<_i637.BuyRepository>()),
    );
    gh.factory<_i58.PotBloc>(
      () => _i58.PotBloc(gh<_i1010.GamificationRepository>()),
    );
    gh.lazySingleton<_i684.TokenPoolRemoteDataSource>(
      () => _i684.TokenPoolRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i693.DeviceBindingService>(
      () => _i693.DeviceBindingService(
        gh<_i892.KeystoreService>(),
        gh<_i454.DeviceRepository>(),
        gh<_i892.FirebaseMessaging>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i988.AuditLogger>(),
        gh<_i124.MediaRecoveryService>(),
      ),
    );
    gh.lazySingleton<_i742.PurchaseRepository>(
      () => _i1044.PurchaseRepositoryImpl(gh<_i267.PurchaseRemoteDataSource>()),
    );
    gh.factory<_i807.CallBloc>(
      () => _i807.CallBloc(
        gh<_i658.CallRepository>(),
        gh<_i980.WebRtcServiceFactory>(),
        gh<_i846.CallSignalingService>(),
        gh<_i108.CallAnalyticsService>(),
      ),
    );
    gh.factory<_i394.FeatureFlagBloc>(
      () => _i394.FeatureFlagBloc(gh<_i993.FeatureFlagRepository>()),
    );
    gh.lazySingleton<_i42.GroupRemoteDataSource>(
      () => _i42.GroupRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i1009.TokenSprayRemoteDataSource>(
      () => _i1009.TokenSprayRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i731.PollRepository>(
      () => _i570.PollRepositoryImpl(
        gh<_i909.PollRemoteDataSource>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i108.GiftRemoteDataSource>(
      () => _i108.GiftRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i119.TokenPoolRepository>(
      () =>
          _i889.TokenPoolRepositoryImpl(gh<_i684.TokenPoolRemoteDataSource>()),
    );
    gh.lazySingleton<_i720.StepUpAuthService>(
      () => _i720.StepUpAuthService(
        gh<_i309.DeviceCapabilityService>(),
        gh<_i152.LocalAuthentication>(),
        gh<_i942.SessionLockService>(),
        gh<_i988.AuditLogger>(),
      ),
    );
    gh.factory<_i809.BuyTabBloc>(
      () =>
          _i809.BuyTabBloc(gh<_i637.BuyRepository>(), gh<_i932.NetworkInfo>()),
    );
    gh.lazySingleton<_i520.EarnRemoteDataSource>(
      () => _i520.EarnRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i351.PlayIntegrityService>(),
      ),
    );
    gh.lazySingleton<_i633.ReferralRepository>(
      () => _i904.ReferralRepositoryImpl(gh<_i9.ReferralRemoteDataSource>()),
    );
    gh.lazySingleton<_i310.CommunitySyncService>(
      () => _i310.CommunitySyncService(
        gh<_i560.CommunityRemoteDataSource>(),
        gh<_i407.SenderKeyService>(),
        gh<_i161.SignalProtocolService>(),
        gh<_i483.AppDatabase>(),
        gh<_i124.MediaRecoveryService>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i943.TokenSprayRepository>(
      () => _i895.TokenSprayRepositoryImpl(
        gh<_i1009.TokenSprayRemoteDataSource>(),
      ),
    );
    gh.factory<_i595.ReferralBloc>(
      () => _i595.ReferralBloc(gh<_i633.ReferralRepository>()),
    );
    gh.lazySingleton<_i340.OfflineActionQueue>(
      () => _i340.OfflineActionQueue(
        gh<_i483.AppDatabase>(),
        gh<_i932.NetworkInfo>(),
        gh<_i425.ConversationRemoteDataSource>(),
        gh<_i560.CommunityRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1072.ChatRepository>(
      () => _i838.ChatRepositoryImpl(gh<_i224.ChatRemoteDataSource>()),
    );
    gh.lazySingleton<_i805.EarnRepository>(
      () => _i965.EarnRepositoryImpl(gh<_i520.EarnRemoteDataSource>()),
    );
    gh.lazySingleton<_i708.GroupRepository>(
      () => _i654.GroupRepositoryImpl(
        gh<_i42.GroupRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i275.GroupBloc>(
      () => _i275.GroupBloc(gh<_i708.GroupRepository>()),
    );
    gh.lazySingleton<_i284.AdMobService>(
      () => _i284.AdMobService(gh<_i942.SessionLockService>()),
    );
    gh.lazySingleton<_i290.BiometricLoginService>(
      () => _i290.BiometricLoginService(
        gh<_i693.DeviceBindingService>(),
        gh<_i309.DeviceCapabilityService>(),
        gh<_i892.KeystoreService>(),
        gh<_i152.LocalAuthentication>(),
        gh<_i809.FirebaseFunctions>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i851.WalletRepository>(
      () => _i520.WalletRepositoryImpl(
        gh<_i389.WalletRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i969.TokenPoolBloc>(
      () => _i969.TokenPoolBloc(gh<_i119.TokenPoolRepository>()),
    );
    gh.factory<_i936.PurchaseBloc>(
      () => _i936.PurchaseBloc(gh<_i742.PurchaseRepository>()),
    );
    gh.factory<_i344.ProfileBloc>(
      () => _i344.ProfileBloc(
        gh<_i271.UserRepository>(),
        gh<_i851.WalletRepository>(),
      ),
    );
    gh.factoryParam<_i609.TokenSprayBloc, String, dynamic>(
      (_communityId, _) =>
          _i609.TokenSprayBloc(gh<_i943.TokenSprayRepository>(), _communityId),
    );
    gh.lazySingleton<_i533.GiftRepository>(
      () => _i350.GiftRepositoryImpl(gh<_i108.GiftRemoteDataSource>()),
    );
    gh.lazySingleton<_i111.OutgoingMessageQueue>(
      () => _i111.OutgoingMessageQueue(
        gh<_i483.AppDatabase>(),
        gh<_i932.NetworkInfo>(),
        gh<_i425.ConversationRemoteDataSource>(),
        gh<_i560.CommunityRemoteDataSource>(),
        gh<_i161.SignalProtocolService>(),
        gh<_i407.SenderKeyService>(),
        gh<_i1034.MessageSyncService>(),
        gh<_i310.CommunitySyncService>(),
        gh<_i124.MediaRecoveryService>(),
      ),
    );
    gh.factory<_i141.AuthBloc>(
      () => _i141.AuthBloc(
        gh<_i1073.AuthRepository>(),
        gh<_i271.UserRepository>(),
        gh<_i693.DeviceBindingService>(),
        gh<_i290.BiometricLoginService>(),
        gh<_i418.KeyManagementService>(),
        gh<_i161.SignalProtocolService>(),
        gh<_i1034.MessageSyncService>(),
        gh<_i340.OfflineActionQueue>(),
        gh<_i310.CommunitySyncService>(),
        gh<_i111.OutgoingMessageQueue>(),
      ),
    );
    gh.factory<_i775.EarnBloc>(
      () =>
          _i775.EarnBloc(gh<_i805.EarnRepository>(), gh<_i284.AdMobService>()),
    );
    gh.lazySingleton<_i936.CommunityRepository>(
      () => _i462.CommunityRepositoryImpl(
        gh<_i560.CommunityRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
        gh<_i483.AppDatabase>(),
        gh<_i340.OfflineActionQueue>(),
        gh<_i111.OutgoingMessageQueue>(),
        gh<_i654.MediaUploadDatasource>(),
        gh<_i310.CommunitySyncService>(),
        gh<_i407.SenderKeyService>(),
      ),
    );
    gh.factory<_i142.ChatBloc>(
      () => _i142.ChatBloc(gh<_i1072.ChatRepository>()),
    );
    gh.factory<_i772.CashoutBloc>(
      () => _i772.CashoutBloc(gh<_i851.WalletRepository>()),
    );
    gh.factory<_i1019.WalletBloc>(
      () => _i1019.WalletBloc(gh<_i851.WalletRepository>()),
    );
    gh.factory<_i480.EarnInboxBloc>(
      () => _i480.EarnInboxBloc(gh<_i805.EarnRepository>()),
    );
    gh.factory<_i973.HomeBloc>(
      () => _i973.HomeBloc(
        gh<_i805.EarnRepository>(),
        gh<_i1010.GamificationRepository>(),
      ),
    );
    gh.factory<_i66.GiftBloc>(() => _i66.GiftBloc(gh<_i533.GiftRepository>()));
    gh.lazySingleton<_i727.RaspService>(
      () => _i727.RaspService(gh<_i141.AuthBloc>()),
    );
    gh.lazySingleton<_i973.ConversationRepository>(
      () => _i161.ConversationRepositoryImpl(
        gh<_i425.ConversationRemoteDataSource>(),
        gh<_i483.AppDatabase>(),
        gh<_i654.MediaUploadDatasource>(),
        gh<_i340.OfflineActionQueue>(),
        gh<_i111.OutgoingMessageQueue>(),
      ),
    );
    gh.factoryParam<_i256.CommunityMessagingBloc, String, dynamic>(
      (communityId, _) => _i256.CommunityMessagingBloc(
        gh<_i936.CommunityRepository>(),
        communityId: communityId,
      ),
    );
    gh.factory<_i856.CommunityBloc>(
      () => _i856.CommunityBloc(gh<_i936.CommunityRepository>()),
    );
    gh.factory<_i792.ContactBloc>(
      () => _i792.ContactBloc(
        gh<_i482.ContactRepository>(),
        gh<_i973.ConversationRepository>(),
      ),
    );
    gh.factory<_i654.ConversationBloc>(
      () => _i654.ConversationBloc(gh<_i973.ConversationRepository>()),
    );
    gh.factory<_i531.ConversationActionsBloc>(
      () => _i531.ConversationActionsBloc(gh<_i973.ConversationRepository>()),
    );
    gh.factory<_i812.UserSearchBloc>(
      () => _i812.UserSearchBloc(gh<_i973.ConversationRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
