import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'double_ratchet_session.dart';
import 'session_store.dart';

/// [SessionStore] backed by [FlutterSecureStorage].
///
/// Session keys are stored with the prefix `e2ee_session_` followed by the
/// user ID, matching the existing storage layout for backward compatibility.
class SecureStorageSessionStore implements SessionStore {
  final FlutterSecureStorage _storage;

  static const _sessionPrefix = 'e2ee_session_';

  SecureStorageSessionStore(this._storage);

  @override
  Future<DoubleRatchetSession?> load(String userId) async {
    final stored = await _storage.read(key: '$_sessionPrefix$userId');
    if (stored == null) return null;
    return DoubleRatchetSession.fromJson(
        jsonDecode(stored) as Map<String, dynamic>);
  }

  @override
  Future<void> save(String userId, DoubleRatchetSession session) async {
    final json = jsonEncode(session.toJson());
    await _storage.write(key: '$_sessionPrefix$userId', value: json);
  }

  @override
  Future<void> delete(String userId) async {
    await _storage.delete(key: '$_sessionPrefix$userId');
  }

  @override
  Future<bool> exists(String userId) async {
    final stored = await _storage.read(key: '$_sessionPrefix$userId');
    return stored != null;
  }

  @override
  Future<void> deleteAll() async {
    final all = await _storage.readAll();
    for (final key in all.keys) {
      if (key.startsWith(_sessionPrefix)) {
        await _storage.delete(key: key);
      }
    }
  }

  @override
  Future<String?> readMeta(String key) async {
    return _storage.read(key: key);
  }

  @override
  Future<void> writeMeta(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<int> sessionCount() async {
    final all = await _storage.readAll();
    return all.keys.where((k) => k.startsWith(_sessionPrefix)).length;
  }
}
