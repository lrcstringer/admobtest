import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/device_model.dart';

/// Remote data source for device trust operations.
///
/// Reads from Firestore directly (user-scoped reads allowed).
/// Writes go through Cloud Functions (server-only writes).
abstract class DeviceRemoteDataSource {
  Future<DeviceModel> registerDevice({
    required String publicKeyPem,
    required String fcmToken,
    required String platform,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    required String manufacturer,
    required bool hardwareBacked,
    required bool strongBox,
  });

  Future<bool> isDeviceTrusted(String deviceId);

  Future<List<DeviceModel>> getUserDevices();

  Future<void> revokeDevice(String deviceId);

  Future<void> updateFcmToken({
    required String deviceId,
    required String fcmToken,
  });
}

@LazySingleton(as: DeviceRemoteDataSource)
class DeviceRemoteDataSourceImpl implements DeviceRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final FirebaseAuth _auth;

  DeviceRemoteDataSourceImpl(
    this._firestore,
    this._functions,
    this._auth,
  );

  String get _currentUserId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  @override
  Future<DeviceModel> registerDevice({
    required String publicKeyPem,
    required String fcmToken,
    required String platform,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    required String manufacturer,
    required bool hardwareBacked,
    required bool strongBox,
  }) async {
    final callable = _functions.httpsCallable('registerDevice');
    final result = await callable.call<Map<String, dynamic>>({
      'publicKeyPem': publicKeyPem,
      'fcmToken': fcmToken,
      'platform': platform,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'manufacturer': manufacturer,
      'hardwareBacked': hardwareBacked,
      'strongBox': strongBox,
    });

    final data = Map<String, dynamic>.from(result.data);
    return DeviceModel.fromJson(data);
  }

  @override
  Future<bool> isDeviceTrusted(String deviceId) async {
    final doc = await _firestore.collection('devices').doc(deviceId).get();
    if (!doc.exists) return false;

    final data = doc.data()!;
    return data['userId'] == _currentUserId &&
        data['trusted'] == true &&
        data['revoked'] != true;
  }

  @override
  Future<List<DeviceModel>> getUserDevices() async {
    final snapshot = await _firestore
        .collection('devices')
        .where('userId', isEqualTo: _currentUserId)
        .get();

    return snapshot.docs
        .map((doc) => DeviceModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> revokeDevice(String deviceId) async {
    final callable = _functions.httpsCallable('revokeDevice');
    await callable.call<void>({
      'deviceId': deviceId,
    });
  }

  @override
  Future<void> updateFcmToken({
    required String deviceId,
    required String fcmToken,
  }) async {
    final callable = _functions.httpsCallable('updateDeviceFcmToken');
    await callable.call<void>({
      'deviceId': deviceId,
      'fcmToken': fcmToken,
    });
  }
}
