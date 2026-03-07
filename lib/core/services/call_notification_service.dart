import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart'
    as callkit;
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../domain/enums/call_type.dart';
import '../../presentation/blocs/call/call_bloc.dart';

/// Handles incoming call notifications via FlutterCallkitIncoming.
///
/// Responsibilities:
/// - Listen for CallKit events (accept/decline/missed)
/// - Route accepted calls to the CallBloc + navigation
/// - Register/update VoIP push tokens in Firestore
/// - Show incoming call UI on Android (foreground FCM data messages)
///
/// Starts listening for CallKit events immediately on construction. Events
/// that arrive before [configure] is called are queued and replayed once
/// the router and bloc are available. This handles the cold-start accept
/// race where the user taps Accept in CallKit before the app has fully
/// initialised.
@lazySingleton
class CallNotificationService {
  GoRouter? _router;
  CallBloc? _callBloc;
  StreamSubscription<callkit.CallEvent?>? _callKitSub;

  /// Events received before [configure] was called.
  final List<callkit.CallEvent> _pendingEvents = [];

  CallNotificationService() {
    // Start listening immediately so cold-start accepts are not lost
    _listenCallKitEvents();
  }

  /// Set the router and bloc for navigation and event dispatch.
  /// Replays any CallKit events that arrived before this was called.
  void configure({required GoRouter router, required CallBloc callBloc}) {
    _router = router;
    _callBloc = callBloc;

    // Replay queued events from cold-start
    if (_pendingEvents.isNotEmpty) {
      debugPrint('CallNotification: replaying ${_pendingEvents.length} '
          'queued CallKit event(s)');
      for (final event in _pendingEvents) {
        _handleCallKitEvent(event);
      }
      _pendingEvents.clear();
    }
  }

  /// Show incoming call UI using FlutterCallkitIncoming (Android foreground).
  ///
  /// On iOS, the VoIP push handler in AppDelegate.swift shows CallKit directly.
  /// This method is for Android foreground FCM data messages.
  Future<void> showIncomingCall({
    required String callId,
    required String callerName,
    String? callerAvatarUrl,
    required String callType,
    required String conversationId,
    required String callerId,
  }) async {
    final hasVideo = callType == 'video';

    final params = callkit.CallKitParams(
      id: callId,
      nameCaller: callerName,
      avatar: callerAvatarUrl,
      type: hasVideo ? 1 : 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      duration: 30000, // 30s ring timeout
      extra: <String, dynamic>{
        'callId': callId,
        'conversationId': conversationId,
        'callerId': callerId,
        'callerName': callerName,
        'callerAvatarUrl': callerAvatarUrl ?? '',
        'callType': callType,
      },
      android: const callkit.AndroidParams(
        isCustomNotification: false,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        actionColor: '#4CAF50',
        isShowFullLockedScreen: true,
      ),
      ios: const callkit.IOSParams(
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);

    // Immediately notify BLoC so Firestore listener starts — this ensures
    // we detect caller cancellation even before the user taps Accept/Decline.
    final ct = callType == 'video' ? CallType.video : CallType.voice;
    _callBloc?.add(CallEvent.incomingCall(
      callId: callId,
      callerName: callerName,
      callerAvatarUrl: callerAvatarUrl,
      callType: ct,
      conversationId: conversationId,
      callerId: callerId,
    ));
  }

  /// Listen for CallKit events: accepted, declined, missed, ended.
  void _listenCallKitEvents() {
    _callKitSub?.cancel();
    _callKitSub = FlutterCallkitIncoming.onEvent.listen((event) {
      if (event == null) return;
      debugPrint('CallNotification: CallKit event: ${event.event}');

      // If not yet configured (cold-start), queue for replay
      if (_callBloc == null) {
        debugPrint('CallNotification: bloc not ready — queuing event');
        _pendingEvents.add(event);
        return;
      }

      _handleCallKitEvent(event);
    });
  }

  /// Process a single CallKit event. Called both for live events and replayed
  /// queued events.
  void _handleCallKitEvent(callkit.CallEvent event) {
    final extra = event.body['extra'] as Map<dynamic, dynamic>? ?? {};
    final callId = extra['callId'] as String? ?? '';
    final conversationId = extra['conversationId'] as String? ?? '';
    final callerId = extra['callerId'] as String? ?? '';
    final callerName = extra['callerName'] as String? ?? 'Unknown';
    final callerAvatarUrl = extra['callerAvatarUrl'] as String?;
    final callTypeStr = extra['callType'] as String? ?? 'voice';
    final callType =
        callTypeStr == 'video' ? CallType.video : CallType.voice;

    switch (event.event) {
      case callkit.Event.actionCallAccept:
        _callBloc?.add(CallEvent.incomingCall(
          callId: callId,
          callerName: callerName,
          callerAvatarUrl: callerAvatarUrl,
          callType: callType,
          conversationId: conversationId,
          callerId: callerId,
        ));
        // BLoC processes events sequentially — acceptCall won't start
        // until incomingCall handler completes. No delay needed.
        _callBloc?.add(const CallEvent.acceptCall());
        _router?.push(
          '/chat/conversation/$conversationId/call/$callId',
          extra: {'isVideo': callType == CallType.video},
        );

      case callkit.Event.actionCallDecline:
        // User declined — notify the bloc to send declined reason
        _callBloc?.add(CallEvent.incomingCall(
          callId: callId,
          callerName: callerName,
          callerAvatarUrl: callerAvatarUrl,
          callType: callType,
          conversationId: conversationId,
          callerId: callerId,
        ));
        _callBloc?.add(const CallEvent.rejectCall());

      case callkit.Event.actionCallTimeout:
        // Ring timeout — notify BLoC to end the call as missed
        debugPrint('CallNotification: call timed out: $callId');
        _callBloc?.add(const CallEvent.endCall());

      case callkit.Event.actionCallEnded:
        // CallKit ended the call (e.g., via system UI)
        _callBloc?.add(const CallEvent.endCall());

      default:
        break;
    }
  }

  /// Save or update the VoIP push token in Firestore for incoming call push.
  Future<void> saveVoipToken() async {
    try {
      final token = await FlutterCallkitIncoming.getDevicePushTokenVoIP();
      if (token == null || token.isEmpty) return;

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'voipToken': token,
        'voipTokenUpdatedAt': FieldValue.serverTimestamp(),
      });
      debugPrint('CallNotification: VoIP token saved');
    } catch (e) {
      debugPrint('CallNotification: saveVoipToken error: $e');
    }
  }

  void dispose() {
    _callKitSub?.cancel();
    _callKitSub = null;
    _pendingEvents.clear();
  }
}
