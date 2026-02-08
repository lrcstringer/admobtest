import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_bloc/flutter_bloc.dart';

/// Lightweight auth state for the admin web portal.
///
/// Uses [FirebaseAuth] directly — no mobile-specific dependencies
/// (device binding, biometric login, FCM, local DB, etc.).
class AdminAuthCubit extends Cubit<AdminAuthState> {
  final fb.FirebaseAuth _auth;
  StreamSubscription<fb.User?>? _authSub;

  AdminAuthCubit({fb.FirebaseAuth? auth})
      : _auth = auth ?? fb.FirebaseAuth.instance,
        super(const AdminAuthState.initial()) {
    _authSub = _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(fb.User? user) {
    if (user == null) {
      emit(const AdminAuthState.unauthenticated());
    } else {
      emit(AdminAuthState.authenticated(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
      ));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(const AdminAuthState.loading());
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verify admin custom claim
      final idTokenResult = await cred.user!.getIdTokenResult(true);
      final claims = idTokenResult.claims ?? {};
      if (claims['admin'] != true && claims['superAdmin'] != true) {
        await _auth.signOut();
        emit(const AdminAuthState.error(
          'Access denied. Admin privileges required.',
        ));
        return;
      }

      // Auth state listener will emit authenticated
    } on fb.FirebaseAuthException catch (e) {
      emit(AdminAuthState.error(_mapAuthError(e.code)));
    } catch (e) {
      emit(AdminAuthState.error(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    // Auth state listener will emit unauthenticated
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'Authentication failed ($code).';
    }
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}

/// Admin auth state — intentionally simple (no Freezed, no mobile concerns).
class AdminAuthState {
  final AdminAuthStatus status;
  final String? uid;
  final String? email;
  final String? displayName;
  final String? errorMessage;

  const AdminAuthState._({
    required this.status,
    this.uid,
    this.email,
    this.displayName,
    this.errorMessage,
  });

  const AdminAuthState.initial()
      : this._(status: AdminAuthStatus.initial);

  const AdminAuthState.loading()
      : this._(status: AdminAuthStatus.loading);

  const AdminAuthState.authenticated({
    required String uid,
    String? email,
    String? displayName,
  }) : this._(
          status: AdminAuthStatus.authenticated,
          uid: uid,
          email: email,
          displayName: displayName,
        );

  const AdminAuthState.unauthenticated()
      : this._(status: AdminAuthStatus.unauthenticated);

  const AdminAuthState.error(String message)
      : this._(status: AdminAuthStatus.error, errorMessage: message);

  bool get isAuthenticated => status == AdminAuthStatus.authenticated;
}

enum AdminAuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}
