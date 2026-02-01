import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../models/user_model.dart';

/// Remote data source for user operations
abstract class UserRemoteDataSource {
  /// Get user by ID
  Future<UserModel?> getUserById(String oddienceUserId);

  /// Get user by phone number
  Future<UserModel?> getUserByPhoneNumber(String phoneNumber);

  /// Create new user
  Future<UserModel> createUser(UserModel user);

  /// Update user
  Future<UserModel> updateUser(UserModel user);

  /// Stream user changes
  Stream<UserModel?> watchUser(String oddienceUserId);

  /// Check if username is available
  Future<bool> isUsernameAvailable(String username);

  /// Search users by username
  Future<List<UserModel>> searchByUsername(String query, {int limit = 20});

  /// Update FCM token
  Future<void> updateFcmToken(String oddienceUserId, String token);

  /// Update last active
  Future<void> updateLastActive(String oddienceUserId);
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection(ApiConstants.usersCollection);

  @override
  Future<UserModel?> getUserById(String oddienceUserId) async {
    try {
      final doc = await _usersCollection.doc(oddienceUserId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return UserModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'oddienceUserId': doc.id});
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to get user');
    }
  }

  @override
  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      final querySnapshot = await _usersCollection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final doc = querySnapshot.docs.first;
      return UserModel.fromJson({...sanitizeFirestoreData(doc.data()), 'oddienceUserId': doc.id});
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to find user');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
      final data = user.toJson();
      data.remove('oddienceUserId');

      await _usersCollection.doc(user.oddienceUserId).set({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return user;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to create user');
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      final data = user.toJson();
      data.remove('oddienceUserId');
      data.remove('createdAt');

      await _usersCollection.doc(user.oddienceUserId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return user;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to update user');
    }
  }

  @override
  Stream<UserModel?> watchUser(String oddienceUserId) {
    return _usersCollection.doc(oddienceUserId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return UserModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'oddienceUserId': doc.id});
    });
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final querySnapshot = await _usersCollection
          .where('usernameLower', isEqualTo: username.toLowerCase())
          .limit(1)
          .get();

      return querySnapshot.docs.isEmpty;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to check username');
    }
  }

  @override
  Future<List<UserModel>> searchByUsername(String query, {int limit = 20}) async {
    try {
      final queryLower = query.toLowerCase();
      final querySnapshot = await _usersCollection
          .where('usernameLower', isGreaterThanOrEqualTo: queryLower)
          .where('usernameLower', isLessThan: '${queryLower}z')
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson({...sanitizeFirestoreData(doc.data()), 'oddienceUserId': doc.id}))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to search users');
    }
  }

  @override
  Future<void> updateFcmToken(String oddienceUserId, String token) async {
    try {
      await _usersCollection.doc(oddienceUserId).update({
        'fcmToken': token,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to update FCM token');
    }
  }

  @override
  Future<void> updateLastActive(String oddienceUserId) async {
    try {
      await _usersCollection.doc(oddienceUserId).update({
        'lastActiveAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to update last active');
    }
  }
}
