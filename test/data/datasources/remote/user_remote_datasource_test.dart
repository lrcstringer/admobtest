import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/data/datasources/remote/user_remote_datasource.dart';
import 'package:imalichat/data/models/user_model.dart';
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

// ==================== TEST FIXTURES ====================

const _userId = 'user123';
const _phoneNumber = '+27612345678';

final _testUserData = <String, dynamic>{
  'phoneNumber': '+27612345678',
  'displayName': 'Test User',
  'status': 'active',
  'hasAcceptedTerms': true,
  'hasCompletedOnboarding': true,
  'isPotEligible': false,
  'createdAt': DateTime(2024, 1, 1).toIso8601String(),
};

UserModel _createTestUserModel() {
  return UserModel(
    userId: _userId,
    phoneNumber: _phoneNumber,
    displayName: 'Test User',
    status: UserStatus.active,
    hasAcceptedTerms: true,
    hasCompletedOnboarding: true,
    isPotEligible: false,
    createdAt: DateTime(2024, 1, 1),
  );
}

// ==================== TESTS ====================

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocRef;
  late MockDocumentSnapshot mockDocSnapshot;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQuery mockQuery;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();
    mockDocSnapshot = MockDocumentSnapshot();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQuery = MockQuery();
    dataSource = UserRemoteDataSourceImpl(mockFirestore);

    // Default: firestore.collection('users') returns mockCollection
    when(() => mockFirestore.collection('users')).thenReturn(mockCollection);
  });

  // ===========================================================================
  // getUserById
  // ===========================================================================

  group('getUserById', () {
    test('returns UserModel when document exists with valid data', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocSnapshot.data()).thenReturn(Map.of(_testUserData));
      when(() => mockDocSnapshot.id).thenReturn(_userId);

      final result = await dataSource.getUserById(_userId);

      expect(result, isNotNull);
      expect(result!.userId, _userId);
      expect(result.phoneNumber, _phoneNumber);
      expect(result.displayName, 'Test User');
      expect(result.status, UserStatus.active);
    });

    test('returns null when document does not exist', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(() => mockDocSnapshot.exists).thenReturn(false);
      when(() => mockDocSnapshot.data()).thenReturn(null);

      final result = await dataSource.getUserById(_userId);

      expect(result, isNull);
    });

    test('returns null when document data is null', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocSnapshot.data()).thenReturn(null);

      final result = await dataSource.getUserById(_userId);

      expect(result, isNull);
    });

    test('returns null when document is incomplete (no phoneNumber)', () async {
      final incompleteData = <String, dynamic>{
        'lastLoginAt': DateTime(2024, 1, 1).toIso8601String(),
      };

      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocSnapshot.data()).thenReturn(incompleteData);
      when(() => mockDocSnapshot.id).thenReturn(_userId);

      final result = await dataSource.getUserById(_userId);

      expect(result, isNull);
    });

    test('throws ServerException on FirebaseException', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.get()).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Permission denied'),
      );

      expect(
        () => dataSource.getUserById(_userId),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // getUserByPhoneNumber
  // ===========================================================================

  group('getUserByPhoneNumber', () {
    test('returns UserModel when user found by phone number', () async {
      final mockQueryDocSnapshot = MockQueryDocumentSnapshot();

      when(() => mockCollection.where('phoneNumber',
          isEqualTo: _phoneNumber)).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]);
      when(() => mockQueryDocSnapshot.data()).thenReturn(Map.of(_testUserData));
      when(() => mockQueryDocSnapshot.id).thenReturn(_userId);

      final result = await dataSource.getUserByPhoneNumber(_phoneNumber);

      expect(result, isNotNull);
      expect(result!.userId, _userId);
      expect(result.phoneNumber, _phoneNumber);
    });

    test('returns null when no user found for phone number', () async {
      when(() => mockCollection.where('phoneNumber',
          isEqualTo: _phoneNumber)).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([]);

      final result = await dataSource.getUserByPhoneNumber(_phoneNumber);

      expect(result, isNull);
    });

    test('throws ServerException on FirebaseException', () async {
      when(() => mockCollection.where('phoneNumber',
          isEqualTo: _phoneNumber)).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Network error'),
      );

      expect(
        () => dataSource.getUserByPhoneNumber(_phoneNumber),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // createUser
  // ===========================================================================

  group('createUser', () {
    test('calls doc.set() with correct data and returns the user', () async {
      final testUser = _createTestUserModel();

      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.set(any())).thenAnswer((_) async {});

      final result = await dataSource.createUser(testUser);

      expect(result.userId, _userId);
      expect(result.phoneNumber, _phoneNumber);

      // Verify the data written to Firestore
      final captured = verify(() => mockDocRef.set(captureAny())).captured;
      final writtenData = captured.first as Map<String, dynamic>;

      // userId should be removed from the data
      expect(writtenData.containsKey('userId'), isFalse);
      // Timestamps should be server timestamps
      expect(writtenData['createdAt'], isA<FieldValue>());
      expect(writtenData['updatedAt'], isA<FieldValue>());
    });

    test('throws ServerException on FirebaseException', () async {
      final testUser = _createTestUserModel();

      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.set(any())).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Write failed'),
      );

      expect(
        () => dataSource.createUser(testUser),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // updateUser
  // ===========================================================================

  group('updateUser', () {
    test('calls doc.update() with correct data and returns the user', () async {
      final testUser = _createTestUserModel();

      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.update(any())).thenAnswer((_) async {});

      final result = await dataSource.updateUser(testUser);

      expect(result.userId, _userId);

      final captured =
          verify(() => mockDocRef.update(captureAny())).captured;
      final writtenData = Map<String, dynamic>.from(
          captured.first as Map<Object, Object?>);

      // userId and createdAt should be removed from the data
      expect(writtenData.containsKey('userId'), isFalse);
      expect(writtenData.containsKey('createdAt'), isFalse);
      // updatedAt should be a server timestamp
      expect(writtenData['updatedAt'], isA<FieldValue>());
    });

    test('throws ServerException on FirebaseException', () async {
      final testUser = _createTestUserModel();

      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.update(any())).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Update failed'),
      );

      expect(
        () => dataSource.updateUser(testUser),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // watchUser
  // ===========================================================================

  group('watchUser', () {
    test('emits UserModel when document exists with valid data', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.snapshots())
          .thenAnswer((_) => Stream.value(mockDocSnapshot));
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocSnapshot.data()).thenReturn(Map.of(_testUserData));
      when(() => mockDocSnapshot.id).thenReturn(_userId);

      final result = await dataSource.watchUser(_userId).first;

      expect(result, isNotNull);
      expect(result!.userId, _userId);
      expect(result.phoneNumber, _phoneNumber);
    });

    test('emits null when document does not exist', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.snapshots())
          .thenAnswer((_) => Stream.value(mockDocSnapshot));
      when(() => mockDocSnapshot.exists).thenReturn(false);
      when(() => mockDocSnapshot.data()).thenReturn(null);

      final result = await dataSource.watchUser(_userId).first;

      expect(result, isNull);
    });
  });

  // ===========================================================================
  // isUsernameAvailable
  // ===========================================================================

  group('isUsernameAvailable', () {
    test('returns true when username is available', () async {
      when(() => mockCollection.where('usernameLower',
          isEqualTo: 'testuser')).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([]);

      final result = await dataSource.isUsernameAvailable('TestUser');

      expect(result, isTrue);
    });

    test('returns false when username is taken', () async {
      final mockQueryDocSnapshot = MockQueryDocumentSnapshot();

      when(() => mockCollection.where('usernameLower',
          isEqualTo: 'testuser')).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]);

      final result = await dataSource.isUsernameAvailable('TestUser');

      expect(result, isFalse);
    });

    test('throws ServerException on FirebaseException', () async {
      when(() => mockCollection.where('usernameLower',
          isEqualTo: 'testuser')).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Query failed'),
      );

      expect(
        () => dataSource.isUsernameAvailable('TestUser'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // searchByUsername
  // ===========================================================================

  group('searchByUsername', () {
    test('returns list of users matching query', () async {
      final mockQueryDocSnapshot = MockQueryDocumentSnapshot();

      when(() => mockCollection.where('usernameLower',
          isGreaterThanOrEqualTo: 'test')).thenReturn(mockQuery);
      when(() =>
          mockQuery.where('usernameLower', isLessThan: 'testz')).thenReturn(mockQuery);
      when(() => mockQuery.limit(20)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]);
      when(() => mockQueryDocSnapshot.data()).thenReturn(Map.of(_testUserData));
      when(() => mockQueryDocSnapshot.id).thenReturn(_userId);

      final result = await dataSource.searchByUsername('Test');

      expect(result.length, 1);
      expect(result.first.userId, _userId);
    });

    test('returns empty list when no matches', () async {
      when(() => mockCollection.where('usernameLower',
          isGreaterThanOrEqualTo: 'xyz')).thenReturn(mockQuery);
      when(() =>
          mockQuery.where('usernameLower', isLessThan: 'xyzz')).thenReturn(mockQuery);
      when(() => mockQuery.limit(20)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([]);

      final result = await dataSource.searchByUsername('xyz');

      expect(result, isEmpty);
    });

    test('respects custom limit parameter', () async {
      when(() => mockCollection.where('usernameLower',
          isGreaterThanOrEqualTo: 'test')).thenReturn(mockQuery);
      when(() =>
          mockQuery.where('usernameLower', isLessThan: 'testz')).thenReturn(mockQuery);
      when(() => mockQuery.limit(5)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(() => mockQuerySnapshot.docs).thenReturn([]);

      await dataSource.searchByUsername('Test', limit: 5);

      verify(() => mockQuery.limit(5)).called(1);
    });

    test('throws ServerException on FirebaseException', () async {
      when(() => mockCollection.where('usernameLower',
          isGreaterThanOrEqualTo: 'test')).thenReturn(mockQuery);
      when(() =>
          mockQuery.where('usernameLower', isLessThan: 'testz')).thenReturn(mockQuery);
      when(() => mockQuery.limit(20)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Search failed'),
      );

      expect(
        () => dataSource.searchByUsername('Test'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // updateFcmToken
  // ===========================================================================

  group('updateFcmToken', () {
    test('calls doc.update with fcmToken and updatedAt', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.update(any())).thenAnswer((_) async {});

      await dataSource.updateFcmToken(_userId, 'new_fcm_token_123');

      final captured =
          verify(() => mockDocRef.update(captureAny())).captured;
      final writtenData = Map<String, dynamic>.from(
          captured.first as Map<Object, Object?>);

      expect(writtenData['fcmToken'], 'new_fcm_token_123');
      expect(writtenData['updatedAt'], isA<FieldValue>());
    });

    test('throws ServerException on FirebaseException', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.update(any())).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Token update failed'),
      );

      expect(
        () => dataSource.updateFcmToken(_userId, 'token'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // updateLastActive
  // ===========================================================================

  group('updateLastActive', () {
    test('calls doc.update with lastActiveAt server timestamp', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.update(any())).thenAnswer((_) async {});

      await dataSource.updateLastActive(_userId);

      final captured =
          verify(() => mockDocRef.update(captureAny())).captured;
      final writtenData = Map<String, dynamic>.from(
          captured.first as Map<Object, Object?>);

      expect(writtenData['lastActiveAt'], isA<FieldValue>());
      // Should only contain lastActiveAt, no other fields
      expect(writtenData.length, 1);
    });

    test('throws ServerException on FirebaseException', () async {
      when(() => mockCollection.doc(_userId)).thenReturn(mockDocRef);
      when(() => mockDocRef.update(any())).thenThrow(
        FirebaseException(
            plugin: 'firestore', message: 'Last active update failed'),
      );

      expect(
        () => dataSource.updateLastActive(_userId),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
