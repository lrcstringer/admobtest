import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';

/// Remote data source for authentication operations
/// Uses custom Cloud Functions for OTP verification via MyMobileAPI
abstract class AuthRemoteDataSource {
  /// Get current Firebase user
  firebase_auth.User? get currentUser;

  /// Stream of auth state changes
  Stream<firebase_auth.User?> get authStateChanges;

  /// Send OTP to phone number via Cloud Function
  Future<void> sendOtp({
    required String phoneNumber,
  });

  /// Verify OTP via Cloud Function and sign in with custom token
  Future<firebase_auth.UserCredential> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  /// Sign out
  Future<void> signOut();

  /// Delete account
  Future<void> deleteAccount();

  /// Get ID token
  Future<String?> getIdToken({bool forceRefresh = false});

  /// Sign in with a Firebase custom token (used by push-based login).
  Future<firebase_auth.UserCredential> signInWithCustomToken(String token);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._functions);

  @override
  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<firebase_auth.User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  @override
  Future<void> sendOtp({
    required String phoneNumber,
  }) async {
    try {
      debugPrint('AuthRemoteDataSource: Calling sendOtp for $phoneNumber');
      final callable = _functions.httpsCallable('sendOtp');
      final result = await callable.call<Map<String, dynamic>>({
        'phoneNumber': phoneNumber,
      });

      final data = result.data;
      debugPrint('AuthRemoteDataSource: sendOtp response: $data');
      if (data['success'] != true) {
        throw AuthException(
          message: data['message'] as String? ?? 'Failed to send OTP',
        );
      }
    } on FirebaseFunctionsException catch (e) {
      debugPrint('AuthRemoteDataSource: FirebaseFunctionsException: ${e.code} - ${e.message}');
      throw _mapFunctionsError(e);
    } catch (e) {
      debugPrint('AuthRemoteDataSource: Unexpected error in sendOtp: $e');
      throw AuthException(message: 'Failed to send verification code. Please try again.');
    }
  }

  @override
  Future<firebase_auth.UserCredential> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final callable = _functions.httpsCallable('verifyOtp');
      final result = await callable.call<Map<String, dynamic>>({
        'phoneNumber': phoneNumber,
        'code': otp,
      });

      final data = result.data;
      if (data['success'] != true) {
        throw AuthException(
          message: data['message'] as String? ?? 'Verification failed',
        );
      }

      final customToken = data['customToken'] as String?;
      if (customToken == null) {
        throw const AuthException(message: 'No auth token received');
      }

      // Sign in with the custom token from Cloud Function
      final userCredential =
          await _firebaseAuth.signInWithCustomToken(customToken);

      // Force-refresh the ID token so the Firestore SDK picks up the new
      // auth context immediately. Without this, a re-registering user
      // (whose previous Auth account was deleted) may still have a stale
      // cached token, causing the very next Firestore read/write to fail
      // with permission-denied.
      await userCredential.user?.getIdToken(true);

      return userCredential;
    } on FirebaseFunctionsException catch (e) {
      throw _mapFunctionsError(e);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Authentication failed');
    }
  }

  /// Map Cloud Function errors to AuthException
  AuthException _mapFunctionsError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'invalid-argument':
        return AuthException(
          message: e.message ?? 'Invalid phone number or code',
        );
      case 'resource-exhausted':
        return AuthException(
          message: e.message ?? 'Too many attempts. Please wait and try again.',
        );
      case 'failed-precondition':
        return AuthException(
          message: e.message ?? 'Verification failed',
        );
      case 'not-found':
        return AuthException(
          message: e.message ?? 'No verification in progress. Please request a new code.',
        );
      case 'deadline-exceeded':
        return AuthException(
          message: e.message ?? 'Code has expired. Please request a new one.',
        );
      case 'internal':
        return AuthException(
          message: e.message ?? 'An error occurred. Please try again.',
        );
      default:
        return AuthException(
          message: e.message ?? 'Authentication error',
        );
    }
  }

  @override
  Future<firebase_auth.UserCredential> signInWithCustomToken(String token) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCustomToken(token);
      // Force-refresh so Firestore SDK has the new auth context immediately
      await userCredential.user?.getIdToken(true);
      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Custom token sign-in failed');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw const AuthException(message: 'No user signed in');
    }

    try {
      final callable = _functions.httpsCallable('deleteUserAccount');
      await callable.call<Map<String, dynamic>>({});
    } on FirebaseFunctionsException catch (e) {
      throw _mapFunctionsError(e);
    }

    // Sign out locally after server-side deletion completes.
    // The Auth account no longer exists server-side, so this just
    // clears the local Firebase Auth session cache.
    await _firebaseAuth.signOut();
  }

  @override
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    return await _firebaseAuth.currentUser?.getIdToken(forceRefresh);
  }
}
