import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/enums/call_status.dart';

void main() {
  group('CallStatus', () {
    test('has all expected values', () {
      expect(CallStatus.values, hasLength(11));
      expect(CallStatus.values, contains(CallStatus.idle));
      expect(CallStatus.values, contains(CallStatus.ringing));
      expect(CallStatus.values, contains(CallStatus.connecting));
      expect(CallStatus.values, contains(CallStatus.active));
      expect(CallStatus.values, contains(CallStatus.reconnecting));
      expect(CallStatus.values, contains(CallStatus.ended));
      expect(CallStatus.values, contains(CallStatus.missed));
      expect(CallStatus.values, contains(CallStatus.declined));
      expect(CallStatus.values, contains(CallStatus.cancelled));
      expect(CallStatus.values, contains(CallStatus.failed));
      expect(CallStatus.values, contains(CallStatus.busy));
    });

    test('terminalCallStatuses contains correct statuses', () {
      expect(terminalCallStatuses, contains(CallStatus.ended));
      expect(terminalCallStatuses, contains(CallStatus.missed));
      expect(terminalCallStatuses, contains(CallStatus.declined));
      expect(terminalCallStatuses, contains(CallStatus.cancelled));
      expect(terminalCallStatuses, contains(CallStatus.failed));
      expect(terminalCallStatuses, contains(CallStatus.busy));
    });

    test('terminalCallStatuses does not contain active statuses', () {
      expect(terminalCallStatuses, isNot(contains(CallStatus.idle)));
      expect(terminalCallStatuses, isNot(contains(CallStatus.ringing)));
      expect(terminalCallStatuses, isNot(contains(CallStatus.connecting)));
      expect(terminalCallStatuses, isNot(contains(CallStatus.active)));
      expect(terminalCallStatuses, isNot(contains(CallStatus.reconnecting)));
    });
  });
}
