import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/core/security/audit_logger.dart';
import 'package:imalichat/core/security/device_binding_service.dart';
import 'package:imalichat/core/security/device_capability_service.dart';
import 'package:imalichat/core/security/keystore_service.dart';
import 'package:imalichat/core/security/pin_manager.dart';
import 'package:imalichat/core/services/biometric_login_service.dart';
import 'package:imalichat/core/services/fcm_challenge_handler.dart';
import 'package:imalichat/data/datasources/remote/auth_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/user_remote_datasource.dart';
import 'package:imalichat/domain/entities/auth_challenge.dart';
import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/entities/user_profile.dart';
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:imalichat/domain/repositories/auth_repository.dart';
import 'package:imalichat/domain/repositories/device_repository.dart';
import 'package:imalichat/domain/repositories/user_repository.dart';
import 'package:imalichat/domain/repositories/wallet_repository.dart';

// ==================== MOCKS ====================
// NOTE: MockFlutterSecureStorage, MockFirebaseFunctions, MockHttpsCallable,
// MockHttpsCallableResult, and MockKeyManagementService already exist in
// e2ee_test_helpers.dart — import from there if needed.

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDeviceBindingService extends Mock implements DeviceBindingService {}

class MockBiometricLoginService extends Mock implements BiometricLoginService {}

class MockFcmChallengeHandler extends Mock implements FcmChallengeHandler {}

class MockDeviceCapabilityService extends Mock
    implements DeviceCapabilityService {}

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockPinManager extends Mock implements PinManager {}

class MockAuditLogger extends Mock implements AuditLogger {}

class MockKeystoreService extends Mock implements KeystoreService {}

class MockDeviceRepository extends Mock implements DeviceRepository {}

class MockWalletRepository extends Mock implements WalletRepository {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

// ==================== TEST FIXTURES ====================

class AuthTestData {
  AuthTestData._();

  // ---- Constants ----
  static const testPhoneNumber = '+27612345678';
  static const testVerificationId =
      '+27612345678'; // sendOtp returns phone as verificationId
  static const testOtp = '123456';
  static const testUserId = 'user123';
  static const testCustomToken = 'custom_token_abc';

  // ---- Users ----

  /// Fully authenticated user with complete profile.
  static User get authenticatedUser => User(
        id: testUserId,
        phoneNumber: testPhoneNumber,
        status: UserStatus.active,
        isPotEligible: true,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: true,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        profile: completeProfile,
      );

  /// User who has not started onboarding.
  static User get onboardingUser => User(
        id: 'user_onboarding',
        phoneNumber: testPhoneNumber,
        status: UserStatus.active,
        isPotEligible: false,
        hasAcceptedTerms: false,
        hasCompletedOnboarding: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// User who has accepted terms but not completed onboarding.
  static User get termsAcceptedUser => User(
        id: 'user_terms',
        phoneNumber: testPhoneNumber,
        status: UserStatus.active,
        isPotEligible: false,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: false,
        createdAt: DateTime(2024, 1, 1),
      );

  // ---- Profiles ----

  /// Complete user profile with all required fields.
  static UserProfile get completeProfile => UserProfile(
        displayName: 'John Doe',
        username: 'johndoe',
        gender: 'male',
        dateOfBirth: DateTime(2000, 6, 15),
        firstName: 'John',
        lastName: 'Doe',
        province: 'Gauteng',
        city: 'Johannesburg',
      );

  /// Incomplete profile — missing username, gender, dateOfBirth.
  static const UserProfile incompleteProfile = UserProfile(
        displayName: 'Jane',
      );

  // ---- Auth Challenges ----

  /// Pending challenge — still actionable.
  static AuthChallenge get pendingChallenge => AuthChallenge(
        challengeId: 'challenge_123',
        userId: testUserId,
        nonce: 'random_nonce_abc',
        status: ChallengeStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
        expiresAt: DateTime.now().add(const Duration(minutes: 2)),
        deviceId: 'device_abc',
      );

  /// Expired challenge — past expiry time.
  static AuthChallenge get expiredChallenge => AuthChallenge(
        challengeId: 'challenge_expired',
        userId: testUserId,
        nonce: 'nonce_expired',
        status: ChallengeStatus.expired,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        expiresAt: DateTime.now().subtract(const Duration(minutes: 2)),
      );

  /// Approved challenge — user accepted on trusted device.
  static AuthChallenge get approvedChallenge => AuthChallenge(
        challengeId: 'challenge_approved',
        userId: testUserId,
        nonce: 'nonce_approved',
        status: ChallengeStatus.approved,
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
        expiresAt: DateTime.now().add(const Duration(minutes: 1)),
        respondedAt: DateTime.now().subtract(const Duration(minutes: 1)),
      );
}
