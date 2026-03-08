import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/security/play_integrity_service.dart';
import 'package:imalichat/data/datasources/remote/token_pool_remote_datasource.dart';
import 'package:imalichat/data/models/token_pool_model.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockPlayIntegrityService extends Mock implements PlayIntegrityService {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock
    implements HttpsCallableResult<Map<String, dynamic>> {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

// Concrete subclass so we can instantiate the @protected constructor.
class TestFirebaseFunctionsException extends FirebaseFunctionsException {
  TestFirebaseFunctionsException({
    required super.code,
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// ==================== FIXTURES ====================

final _now = DateTime(2024, 6, 1);

/// Minimal valid pool JSON that TokenPoolModel.fromJson can parse.
Map<String, dynamic> _poolResponseJson({String id = 'pool_1'}) => {
      'id': id,
      'mode': 'sasaza',
      'status': 'collecting',
      'organizerId': 'user123',
      'organizerName': 'Test User',
      'recipientId': 'user456',
      'recipientName': 'Recipient',
      'conversationId': 'conv_1',
      'title': 'Birthday Gift',
      'message': 'Happy birthday!',
      'style': 'birthday',
      'totalAmount': 500,
      'contributionCount': 2,
      'contributorCount': 2,
      'inviteeIds': ['user123', 'user789'],
      'createdAt': _now.toIso8601String(),
      'updatedAt': _now.toIso8601String(),
      'groupAccountId': 'group:pool_1',
    };

/// CF response wraps pool in a 'pool' key.
Map<String, dynamic> _cfResponse({String id = 'pool_1'}) => {
      'pool': _poolResponseJson(id: id),
    };

// ==================== TESTS ====================

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFunctions mockFunctions;
  late MockPlayIntegrityService mockPlayIntegrity;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockResult;
  late MockFirebaseUser mockUser;
  late MockCollectionReference mockCollection;
  late TokenPoolRemoteDataSourceImpl dataSource;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockFunctions = MockFirebaseFunctions();
    mockPlayIntegrity = MockPlayIntegrityService();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();
    mockUser = MockFirebaseUser();
    mockCollection = MockCollectionReference();

    dataSource = TokenPoolRemoteDataSourceImpl(
      mockFirestore,
      mockAuth,
      mockFunctions,
      mockPlayIntegrity,
    );

    // Default: user is authenticated
    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('user123');

    // Default: Play Integrity returns null (non-Android / cache miss)
    when(() => mockPlayIntegrity.getIntegrityToken())
        .thenAnswer((_) async => null);

    // Default: Firestore collection
    when(() => mockFirestore.collection('tokenPools'))
        .thenReturn(mockCollection);
  });

  // ===========================================================================
  // Helper to set up CF callable mock for a given function name
  // ===========================================================================

  void setUpCallable(String functionName) {
    when(() => mockFunctions.httpsCallable(functionName))
        .thenReturn(mockCallable);
    when(() => mockResult.data).thenReturn(_cfResponse());
    when(() => mockCallable.call<Map<String, dynamic>>(any()))
        .thenAnswer((_) async => mockResult);
  }

  // ===========================================================================
  // createPool
  // ===========================================================================

  group('createPool', () {
    setUp(() => setUpCallable('createTokenPool'));

    test('calls httpsCallable with correct params and returns model', () async {
      final result = await dataSource.createPool(
        mode: 'sasaza',
        title: 'Birthday Gift',
        message: 'Happy birthday!',
        style: 'birthday',
        recipientId: 'user456',
        inviteeIds: ['user789'],
        communityId: 'comm_1',
        purpose: 'Celebrate!',
      );

      expect(result, isA<TokenPoolModel>());
      expect(result.id, 'pool_1');
      verify(() => mockFunctions.httpsCallable('createTokenPool')).called(1);
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'mode': 'sasaza',
          'title': 'Birthday Gift',
          'message': 'Happy birthday!',
          'style': 'birthday',
          'recipientId': 'user456',
          'inviteeIds': ['user789'],
          'communityId': 'comm_1',
          'purpose': 'Celebrate!',
        }),
      ).called(1);
    });

    test('omits optional null/empty params', () async {
      await dataSource.createPool(
        mode: 'save',
        title: 'Savings',
        message: 'Let us save',
        style: 'celebration',
        inviteeIds: ['user789'],
      );

      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'mode': 'save',
          'title': 'Savings',
          'message': 'Let us save',
          'style': 'celebration',
          'inviteeIds': ['user789'],
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'invalid-argument',
          message: 'Title is required',
        ),
      );

      expect(
        () => dataSource.createPool(
          mode: 'sasaza',
          title: '',
          message: 'msg',
          style: 'celebration',
          inviteeIds: [],
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Title is required',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('network error'));

      expect(
        () => dataSource.createPool(
          mode: 'sasaza',
          title: 'T',
          message: 'M',
          style: 'celebration',
          inviteeIds: [],
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          contains('network error'),
        )),
      );
    });
  });

  // ===========================================================================
  // contribute
  // ===========================================================================

  group('contribute', () {
    setUp(() => setUpCallable('contributeToPool'));

    test('calls httpsCallable with correct params (no integrity token)',
        () async {
      final result = await dataSource.contribute(
        poolId: 'pool_1',
        amount: 100,
        anonymous: false,
      );

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
          'amount': 100,
          'anonymous': false,
        }),
      ).called(1);
    });

    test('includes integrityToken when available', () async {
      when(() => mockPlayIntegrity.getIntegrityToken())
          .thenAnswer((_) async => 'integrity_abc');

      await dataSource.contribute(
        poolId: 'pool_1',
        amount: 200,
        anonymous: true,
      );

      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
          'amount': 200,
          'anonymous': true,
          'integrityToken': 'integrity_abc',
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Pool is no longer collecting',
        ),
      );

      expect(
        () => dataSource.contribute(
          poolId: 'pool_1',
          amount: 100,
          anonymous: false,
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Pool is no longer collecting',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('timeout'));

      expect(
        () => dataSource.contribute(
          poolId: 'pool_1',
          amount: 100,
          anonymous: false,
        ),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // sendGroupGift
  // ===========================================================================

  group('sendGroupGift', () {
    setUp(() => setUpCallable('sendGroupGift'));

    test('calls httpsCallable with poolId and returns model', () async {
      final result = await dataSource.sendGroupGift('pool_1');

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'permission-denied',
          message: 'Only organizer can send',
        ),
      );

      expect(
        () => dataSource.sendGroupGift('pool_1'),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Only organizer can send',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('error'));

      expect(
        () => dataSource.sendGroupGift('pool_1'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // distributePool
  // ===========================================================================

  group('distributePool', () {
    setUp(() => setUpCallable('distributePool'));

    test('calls httpsCallable with correct params', () async {
      final payouts = [
        {'userId': 'user789', 'amount': 250},
        {'userId': 'user123', 'amount': 250},
      ];

      final result = await dataSource.distributePool(
        poolId: 'pool_1',
        payouts: payouts,
        keepOpen: true,
      );

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
          'payouts': payouts,
          'keepOpen': true,
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Pool has no funds',
        ),
      );

      expect(
        () => dataSource.distributePool(
          poolId: 'pool_1',
          payouts: [],
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Pool has no funds',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('error'));

      expect(
        () => dataSource.distributePool(poolId: 'pool_1', payouts: []),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // requestWithdrawal
  // ===========================================================================

  group('requestWithdrawal', () {
    setUp(() => setUpCallable('requestPoolWithdrawal'));

    test('calls httpsCallable with poolId and amount', () async {
      final result = await dataSource.requestWithdrawal(
        poolId: 'pool_1',
        amount: 100,
      );

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
          'amount': 100,
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Insufficient pool balance',
        ),
      );

      expect(
        () => dataSource.requestWithdrawal(poolId: 'pool_1', amount: 100),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Insufficient pool balance',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('error'));

      expect(
        () => dataSource.requestWithdrawal(poolId: 'pool_1', amount: 100),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // cancelPool
  // ===========================================================================

  group('cancelPool', () {
    setUp(() => setUpCallable('cancelPool'));

    test('calls httpsCallable with poolId and returns model', () async {
      final result = await dataSource.cancelPool('pool_1');

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Cannot cancel completed pool',
        ),
      );

      expect(
        () => dataSource.cancelPool('pool_1'),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Cannot cancel completed pool',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('error'));

      expect(
        () => dataSource.cancelPool('pool_1'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // openGroupGift
  // ===========================================================================

  group('openGroupGift', () {
    setUp(() => setUpCallable('openGroupGift'));

    test('calls httpsCallable with poolId (no integrity token)', () async {
      final result = await dataSource.openGroupGift('pool_1');

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
        }),
      ).called(1);
      // openGroupGift does NOT call Play Integrity
      verifyNever(() => mockPlayIntegrity.getIntegrityToken());
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'permission-denied',
          message: 'Only recipient can open',
        ),
      );

      expect(
        () => dataSource.openGroupGift('pool_1'),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Only recipient can open',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('error'));

      expect(
        () => dataSource.openGroupGift('pool_1'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // claimGroupGift
  // ===========================================================================

  group('claimGroupGift', () {
    setUp(() => setUpCallable('claimGroupGift'));

    test('calls httpsCallable with poolId and returns model', () async {
      final result = await dataSource.claimGroupGift('pool_1');

      expect(result, isA<TokenPoolModel>());
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'poolId': 'pool_1',
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Gift must be opened first',
        ),
      );

      expect(
        () => dataSource.claimGroupGift('pool_1'),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Gift must be opened first',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('error'));

      expect(
        () => dataSource.claimGroupGift('pool_1'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // getPool
  // ===========================================================================

  group('getPool', () {
    late MockDocumentReference mockDocRef;
    late MockDocumentSnapshot mockDocSnapshot;

    setUp(() {
      mockDocRef = MockDocumentReference();
      mockDocSnapshot = MockDocumentSnapshot();
      when(() => mockCollection.doc('pool_1')).thenReturn(mockDocRef);
      when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
    });

    test('throws AuthException when user not authenticated', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      expect(
        () => dataSource.getPool('pool_1'),
        throwsA(isA<AuthException>()),
      );
    });

    test('returns TokenPoolModel when doc exists', () async {
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocSnapshot.id).thenReturn('pool_1');
      when(() => mockDocSnapshot.data()).thenReturn(_poolResponseJson());

      final result = await dataSource.getPool('pool_1');

      expect(result, isA<TokenPoolModel>());
      expect(result!.id, 'pool_1');
      expect(result.title, 'Birthday Gift');
    });

    test('returns null when doc does not exist', () async {
      when(() => mockDocSnapshot.exists).thenReturn(false);

      final result = await dataSource.getPool('pool_1');

      expect(result, isNull);
    });

    test('throws ServerException on Firestore error', () async {
      when(() => mockDocRef.get())
          .thenThrow(FirebaseException(plugin: 'firestore'));

      expect(
        () => dataSource.getPool('pool_1'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  // ===========================================================================
  // watchPool
  // ===========================================================================

  group('watchPool', () {
    late MockDocumentReference mockDocRef;

    setUp(() {
      mockDocRef = MockDocumentReference();
      when(() => mockCollection.doc('pool_1')).thenReturn(mockDocRef);
    });

    test('throws AuthException when user not authenticated', () {
      when(() => mockAuth.currentUser).thenReturn(null);

      expect(
        () => dataSource.watchPool('pool_1'),
        throwsA(isA<AuthException>()),
      );
    });

    test('emits TokenPoolModel for existing docs', () async {
      final mockSnapshot1 = MockDocumentSnapshot();
      when(() => mockSnapshot1.exists).thenReturn(true);
      when(() => mockSnapshot1.id).thenReturn('pool_1');
      when(() => mockSnapshot1.data()).thenReturn(_poolResponseJson());

      when(() => mockDocRef.snapshots())
          .thenAnswer((_) => Stream.value(mockSnapshot1));

      final result = await dataSource.watchPool('pool_1').first;

      expect(result, isA<TokenPoolModel>());
      expect(result.id, 'pool_1');
    });

    test('filters out non-existent doc snapshots', () async {
      final existingSnapshot = MockDocumentSnapshot();
      when(() => existingSnapshot.exists).thenReturn(true);
      when(() => existingSnapshot.id).thenReturn('pool_1');
      when(() => existingSnapshot.data()).thenReturn(_poolResponseJson());

      final deletedSnapshot = MockDocumentSnapshot();
      when(() => deletedSnapshot.exists).thenReturn(false);

      when(() => mockDocRef.snapshots()).thenAnswer(
        (_) => Stream.fromIterable([deletedSnapshot, existingSnapshot]),
      );

      final results = await dataSource.watchPool('pool_1').toList();

      expect(results.length, 1);
      expect(results.first.id, 'pool_1');
    });
  });

  // ===========================================================================
  // getMyPools
  // ===========================================================================

  group('getMyPools', () {
    late MockQuery mockOrganizerQuery;
    late MockQuery mockInviteeQuery;
    late MockQuery mockRecipientQuery;
    late MockQuerySnapshot mockOrganizerSnapshot;
    late MockQuerySnapshot mockInviteeSnapshot;
    late MockQuerySnapshot mockRecipientSnapshot;

    setUp(() {
      mockOrganizerQuery = MockQuery();
      mockInviteeQuery = MockQuery();
      mockRecipientQuery = MockQuery();
      mockOrganizerSnapshot = MockQuerySnapshot();
      mockInviteeSnapshot = MockQuerySnapshot();
      mockRecipientSnapshot = MockQuerySnapshot();

      // organizerFuture
      when(() => mockCollection.where('organizerId', isEqualTo: 'user123'))
          .thenReturn(mockOrganizerQuery);
      when(() =>
              mockOrganizerQuery.orderBy('createdAt', descending: true))
          .thenReturn(mockOrganizerQuery);
      when(() => mockOrganizerQuery.get())
          .thenAnswer((_) async => mockOrganizerSnapshot);

      // inviteeFuture
      when(() =>
              mockCollection.where('inviteeIds', arrayContains: 'user123'))
          .thenReturn(mockInviteeQuery);
      when(() => mockInviteeQuery.orderBy('createdAt', descending: true))
          .thenReturn(mockInviteeQuery);
      when(() => mockInviteeQuery.get())
          .thenAnswer((_) async => mockInviteeSnapshot);

      // recipientFuture
      when(() => mockCollection.where('recipientId', isEqualTo: 'user123'))
          .thenReturn(mockRecipientQuery);
      when(() =>
              mockRecipientQuery.orderBy('createdAt', descending: true))
          .thenReturn(mockRecipientQuery);
      when(() => mockRecipientQuery.get())
          .thenAnswer((_) async => mockRecipientSnapshot);

      // Default: empty results
      when(() => mockOrganizerSnapshot.docs).thenReturn([]);
      when(() => mockInviteeSnapshot.docs).thenReturn([]);
      when(() => mockRecipientSnapshot.docs).thenReturn([]);
    });

    test('throws AuthException when user not authenticated', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      expect(
        () => dataSource.getMyPools(),
        throwsA(isA<AuthException>()),
      );
    });

    test('returns empty list when no pools found', () async {
      final result = await dataSource.getMyPools();

      expect(result, isEmpty);
    });

    test('merges results from all three queries', () async {
      final doc1 = MockQueryDocumentSnapshot();
      when(() => doc1.id).thenReturn('pool_1');
      when(() => doc1.data()).thenReturn(_poolResponseJson(id: 'pool_1'));

      final doc2 = MockQueryDocumentSnapshot();
      final pool2Json = _poolResponseJson(id: 'pool_2');
      pool2Json['createdAt'] =
          _now.subtract(const Duration(hours: 1)).toIso8601String();
      when(() => doc2.id).thenReturn('pool_2');
      when(() => doc2.data()).thenReturn(pool2Json);

      when(() => mockOrganizerSnapshot.docs).thenReturn([doc1]);
      when(() => mockInviteeSnapshot.docs).thenReturn([doc2]);

      final result = await dataSource.getMyPools();

      expect(result.length, 2);
      // Sorted by createdAt descending — pool_1 is newer
      expect(result[0].id, 'pool_1');
      expect(result[1].id, 'pool_2');
    });

    test('deduplicates pools that appear in multiple queries', () async {
      final doc1Org = MockQueryDocumentSnapshot();
      when(() => doc1Org.id).thenReturn('pool_1');
      when(() => doc1Org.data()).thenReturn(_poolResponseJson(id: 'pool_1'));

      final doc1Inv = MockQueryDocumentSnapshot();
      when(() => doc1Inv.id).thenReturn('pool_1');
      when(() => doc1Inv.data()).thenReturn(_poolResponseJson(id: 'pool_1'));

      when(() => mockOrganizerSnapshot.docs).thenReturn([doc1Org]);
      when(() => mockInviteeSnapshot.docs).thenReturn([doc1Inv]);

      final result = await dataSource.getMyPools();

      expect(result.length, 1);
      expect(result.first.id, 'pool_1');
    });

    test('throws ServerException on Firestore error', () async {
      when(() => mockOrganizerQuery.get())
          .thenThrow(FirebaseException(plugin: 'firestore'));

      expect(
        () => dataSource.getMyPools(),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
