import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../models/feature_flag_model.dart';

abstract class FeatureFlagRemoteDataSource {
  /// Get all feature flags
  Future<List<FeatureFlagModel>> getFeatureFlags();
}

@LazySingleton(as: FeatureFlagRemoteDataSource)
class FeatureFlagRemoteDataSourceImpl implements FeatureFlagRemoteDataSource {
  final FirebaseFirestore _firestore;

  /// In-memory cache with 30-minute TTL
  List<FeatureFlagModel>? _cachedFlags;
  DateTime? _cacheTimestamp;
  static const _cacheDuration = Duration(minutes: 30);

  FeatureFlagRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _flagsCollection =>
      _firestore.collection('featureFlags');

  @override
  Future<List<FeatureFlagModel>> getFeatureFlags() async {
    // Return cached data if still fresh
    if (_cachedFlags != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return _cachedFlags!;
    }

    final snapshot = await _flagsCollection.get();

    final flags = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return FeatureFlagModel.fromJson(data);
    }).toList();

    _cachedFlags = flags;
    _cacheTimestamp = DateTime.now();

    return flags;
  }
}
