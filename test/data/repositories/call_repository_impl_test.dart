import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/datasources/remote/call_remote_datasource.dart';
import 'package:imalichat/data/repositories/call_repository_impl.dart';
import 'package:imalichat/domain/enums/call_type.dart';
import 'package:mocktail/mocktail.dart';

class MockCallRemoteDatasource extends Mock implements CallRemoteDatasource {}

void main() {
  late MockCallRemoteDatasource mockDatasource;
  late CallRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockCallRemoteDatasource();
    repository = CallRepositoryImpl(mockDatasource);
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
  });
}
