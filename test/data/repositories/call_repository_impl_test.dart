import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/datasources/remote/call_remote_datasource.dart';
import 'package:imalichat/data/repositories/call_repository_impl.dart';
import 'package:imalichat/domain/enums/call_type.dart';
import 'package:mocktail/mocktail.dart';

class MockCallRemoteDatasource extends Mock implements CallRemoteDatasource {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  late MockCallRemoteDatasource mockDatasource;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocRef;
  late CallRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockCallRemoteDatasource();
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();
    repository = CallRepositoryImpl(mockDatasource, mockFirestore);

    when(() => mockFirestore.collection('calls')).thenReturn(mockCollection);
    when(() => mockCollection.doc(any())).thenReturn(mockDocRef);
  });

  group('CallRepositoryImpl', () {
    group('initiateCall', () {
      test('delegates to datasource with correct params', () async {
        when(() => mockDatasource.initiateCall(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              callType: any(named: 'callType'),
            )).thenAnswer((_) async => 'call_123');

        final result = await repository.initiateCall(
          conversationId: 'conv_1',
          recipientId: 'user_b',
          callType: CallType.voice,
        );

        expect(result, 'call_123');
        verify(() => mockDatasource.initiateCall(
              conversationId: 'conv_1',
              recipientId: 'user_b',
              callType: 'voice',
            )).called(1);
      });

      test('passes video callType as string', () async {
        when(() => mockDatasource.initiateCall(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              callType: any(named: 'callType'),
            )).thenAnswer((_) async => 'call_456');

        await repository.initiateCall(
          conversationId: 'conv_2',
          recipientId: 'user_c',
          callType: CallType.video,
        );

        verify(() => mockDatasource.initiateCall(
              conversationId: 'conv_2',
              recipientId: 'user_c',
              callType: 'video',
            )).called(1);
      });
    });

    group('answerCall', () {
      test('delegates to datasource', () async {
        when(() => mockDatasource.answerCall(any()))
            .thenAnswer((_) async {});

        await repository.answerCall('call_123');

        verify(() => mockDatasource.answerCall('call_123')).called(1);
      });
    });

    group('endCall', () {
      test('delegates to datasource with reason', () async {
        when(() => mockDatasource.endCall(any(),
            reason: any(named: 'reason'))).thenAnswer((_) async {});

        await repository.endCall('call_123', reason: 'declined');

        verify(() =>
                mockDatasource.endCall('call_123', reason: 'declined'))
            .called(1);
      });

      test('delegates to datasource without reason', () async {
        when(() => mockDatasource.endCall(any(),
            reason: any(named: 'reason'))).thenAnswer((_) async {});

        await repository.endCall('call_123');

        verify(() => mockDatasource.endCall('call_123')).called(1);
      });
    });

    group('getTurnCredentials', () {
      test('delegates to datasource', () async {
        when(() => mockDatasource.getTurnCredentials())
            .thenAnswer((_) async => {'iceServers': []});

        final result = await repository.getTurnCredentials();

        expect(result, {'iceServers': []});
        verify(() => mockDatasource.getTurnCredentials()).called(1);
      });
    });

    group('sendOffer', () {
      test('updates Firestore call document with offer', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.sendOffer('call_1', {
          'sdp': 'v=0\\r\\n...',
          'type': 'offer',
        });

        verify(() => mockDocRef.update({
              'offer': {'sdp': 'v=0\\r\\n...', 'type': 'offer'},
            })).called(1);
      });
    });

    group('sendAnswer', () {
      test('updates Firestore call document with answer', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.sendAnswer('call_1', {
          'sdp': 'v=0\\r\\n...',
          'type': 'answer',
        });

        verify(() => mockDocRef.update({
              'answer': {'sdp': 'v=0\\r\\n...', 'type': 'answer'},
            })).called(1);
      });
    });

    group('sendIceCandidate', () {
      late MockCollectionReference mockSubcollection;

      setUp(() {
        mockSubcollection = MockCollectionReference();
        when(() => mockDocRef.collection(any()))
            .thenReturn(mockSubcollection);
        when(() => mockSubcollection.add(any()))
            .thenAnswer((_) async => mockDocRef);
      });

      test('writes to callerCandidates when isCaller=true', () async {
        await repository.sendIceCandidate(
          'call_1',
          {
            'candidate': 'candidate:1 ...',
            'sdpMid': '0',
            'sdpMLineIndex': 0,
          },
          isCaller: true,
        );

        verify(() => mockDocRef.collection('callerCandidates')).called(1);
      });

      test('writes to calleeCandidates when isCaller=false', () async {
        await repository.sendIceCandidate(
          'call_1',
          {
            'candidate': 'candidate:1 ...',
            'sdpMid': '0',
            'sdpMLineIndex': 0,
          },
          isCaller: false,
        );

        verify(() => mockDocRef.collection('calleeCandidates')).called(1);
      });
    });

    group('sendHeartbeat', () {
      test('updates callerHeartbeat when isCaller=true', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.sendHeartbeat('call_1', isCaller: true);

        verify(() => mockDocRef.update({
              'callerHeartbeat': isA<FieldValue>(),
            })).called(1);
      });

      test('updates calleeHeartbeat when isCaller=false', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.sendHeartbeat('call_1', isCaller: false);

        verify(() => mockDocRef.update({
              'calleeHeartbeat': isA<FieldValue>(),
            })).called(1);
      });
    });

    group('requestVideoUpgrade', () {
      test('sets pending upgrade with requester', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.requestVideoUpgrade('call_1', 'caller');

        verify(() => mockDocRef.update({
              'videoUpgradeRequest': 'pending',
              'videoUpgradeRequesterId': 'caller',
            })).called(1);
      });
    });

    group('respondVideoUpgrade', () {
      test('sets accepted when true', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.respondVideoUpgrade('call_1', true);

        verify(() => mockDocRef.update({
              'videoUpgradeRequest': 'accepted',
            })).called(1);
      });

      test('sets declined when false', () async {
        when(() => mockDocRef.update(any())).thenAnswer((_) async {});

        await repository.respondVideoUpgrade('call_1', false);

        verify(() => mockDocRef.update({
              'videoUpgradeRequest': 'declined',
            })).called(1);
      });
    });
  });
}
