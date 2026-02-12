import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Lightweight auth state for the admin web portal.
///
/// Uses [FirebaseAuth] directly — no mobile-specific dependencies
/// (device binding, biometric login, FCM, local DB, etc.).
///
/// Includes:
/// - Role extraction from custom claims (`adminRoles` array or `adminRole` string)
/// - Inactivity timeout (30 minutes)
/// - Forced sign-out detection via token revocation
class AdminAuthCubit extends Cubit<AdminAuthState> {
  final fb.FirebaseAuth _auth;
  StreamSubscription<fb.User?>? _authSub;

  /// 30-minute inactivity timeout
  static const _inactivityDuration = Duration(minutes: 30);
  Timer? _inactivityTimer;

  AdminAuthCubit({fb.FirebaseAuth? auth})
      : _auth = auth ?? fb.FirebaseAuth.instance,
        super(const AdminAuthState.initial()) {
    _authSub = _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(fb.User? user) async {
    if (user == null) {
      _cancelInactivityTimer();
      // Only emit unauthenticated if we're not already in sessionExpired
      if (state.status != AdminAuthStatus.sessionExpired) {
        emit(const AdminAuthState.unauthenticated());
      }
    } else {
      // Fetch claims to get roles
      final idTokenResult = await user.getIdTokenResult();
      final claims = idTokenResult.claims ?? {};

      final roles = _extractRoles(claims);
      if (roles.isEmpty) {
        // Not an admin — sign out
        await _auth.signOut();
        return;
      }

      emit(AdminAuthState.authenticated(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        roles: roles,
      ));
      _resetInactivityTimer();
    }
  }

  static const _validRoles = [
    'platformAdmin',
    'superAdmin',
    'financeAdmin',
    'campaignAdmin',
    'auditor',
  ];

  /// Extract admin roles from custom claims.
  /// Priority: adminRoles (array) > adminRole (string) > legacy booleans
  List<String> _extractRoles(Map<String, dynamic> claims) {
    // New array claim
    final adminRoles = claims['adminRoles'];
    if (adminRoles is List && adminRoles.isNotEmpty) {
      return adminRoles
          .cast<String>()
          .where((r) => _validRoles.contains(r))
          .toList();
    }

    // Old single string claim
    final adminRole = claims['adminRole'] as String?;
    if (adminRole != null && _validRoles.contains(adminRole)) {
      return [adminRole];
    }

    // Legacy boolean fallback
    if (claims['superAdmin'] == true) return ['superAdmin'];
    if (claims['admin'] == true) return ['campaignAdmin'];
    return [];
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

      final roles = _extractRoles(claims);

      emit(AdminAuthState.authenticated(
        uid: cred.user!.uid,
        email: cred.user!.email,
        displayName: cred.user!.displayName,
        roles: roles.isNotEmpty ? roles : ['campaignAdmin'],
      ));
      _resetInactivityTimer();
    } on fb.FirebaseAuthException catch (e) {
      emit(AdminAuthState.error(_mapAuthError(e.code)));
    } catch (e) {
      emit(AdminAuthState.error(e.toString()));
    }
  }

  Future<void> signOut() async {
    _cancelInactivityTimer();
    await _auth.signOut();
    // Auth state listener will emit unauthenticated
  }

  /// Call this on user interaction events to reset the inactivity timer.
  void resetInactivityTimer() {
    if (state.isAuthenticated) {
      _resetInactivityTimer();
    }
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, _onInactivityTimeout);
  }

  void _cancelInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  void _onInactivityTimeout() {
    if (state.isAuthenticated) {
      emit(const AdminAuthState.sessionExpired());
      _auth.signOut();
    }
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
    _cancelInactivityTimer();
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
  final List<String> roles;
  final String? errorMessage;

  const AdminAuthState._({
    required this.status,
    this.uid,
    this.email,
    this.displayName,
    this.roles = const [],
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
    required List<String> roles,
  }) : this._(
          status: AdminAuthStatus.authenticated,
          uid: uid,
          email: email,
          displayName: displayName,
          roles: roles,
        );

  const AdminAuthState.unauthenticated()
      : this._(status: AdminAuthStatus.unauthenticated);

  const AdminAuthState.sessionExpired()
      : this._(status: AdminAuthStatus.sessionExpired);

  const AdminAuthState.error(String message)
      : this._(status: AdminAuthStatus.error, errorMessage: message);

  bool get isAuthenticated => status == AdminAuthStatus.authenticated;

  /// Primary role (first in list) for display purposes.
  String? get primaryRole => roles.isNotEmpty ? roles.first : null;

  /// Whether the admin has superAdmin role.
  bool get isSuperAdmin => roles.contains('superAdmin');

  /// Check if the admin has any of the given roles.
  bool hasAnyRole(List<String> check) =>
      isSuperAdmin || roles.any((r) => check.contains(r));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminAuthState &&
          status == other.status &&
          uid == other.uid &&
          listEquals(roles, other.roles) &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(status, uid, roles, errorMessage);
}

enum AdminAuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  sessionExpired,
  error,
}
