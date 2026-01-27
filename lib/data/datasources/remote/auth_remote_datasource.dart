import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';

/// Remote data source for authentication operations
abstract class AuthRemoteDataSource {
  /// Get current Firebase user
  firebase_auth.User? get currentUser;

  /// Stream of auth state changes
  Stream<firebase_auth.User?> get authStateChanges;

  /// Send OTP to phone number
  Future<String> sendOtp({
    required String phoneNumber,
    required Function(firebase_auth.PhoneAuthCredential) onAutoVerify,
    required Function(String) onCodeSent,
    required Function(firebase_auth.FirebaseAuthException) onFailed,
    int? forceResendingToken,
  });

  /// Verify OTP and sign in
  Future<firebase_auth.UserCredential> verifyOtp({
    required String verificationId,
    required String otp,
  });

  /// Sign out
  Future<void> signOut();

  /// Delete account
  Future<void> deleteAccount();

  /// Get ID token
  Future<String?> getIdToken({bool forceRefresh = false});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<firebase_auth.User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  @override
  Future<String> sendOtp({
    required String phoneNumber,
    required Function(firebase_auth.PhoneAuthCredential) onAutoVerify,
    required Function(String) onCodeSent,
    required Function(firebase_auth.FirebaseAuthException) onFailed,
    int? forceResendingToken,
  }) async {
    String? verificationId;

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: forceResendingToken,
      verificationCompleted: (credential) {
        onAutoVerify(credential);
      },
      verificationFailed: (exception) {
        onFailed(exception);
      },
      codeSent: (verId, resendToken) {
        verificationId = verId;
        onCodeSent(verId);
      },
      codeAutoRetrievalTimeout: (verId) {
        verificationId ??= verId;
      },
    );

    // Wait a bit for the codeSent callback
    await Future.delayed(const Duration(milliseconds: 500));

    if (verificationId == null) {
      throw const AuthException(message: 'Failed to send OTP');
    }

    return verificationId!;
  }

  @override
  Future<firebase_auth.UserCredential> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        throw const AuthException(message: 'Invalid OTP code');
      } else if (e.code == 'session-expired') {
        throw const AuthException(message: 'OTP has expired. Please request a new one');
      }
      throw AuthException(message: e.message ?? 'Authentication failed');
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
    await user.delete();
  }

  @override
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    return await _firebaseAuth.currentUser?.getIdToken(forceRefresh);
  }
}
