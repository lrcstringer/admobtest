import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'call_notification_service.dart';

/// Notification channel IDs matching the Cloud Functions payload.
const _chatChannelId = 'chat_messages';
const _chatChannelName = 'Chat Messages';
const _chatChannelDesc = 'Notifications for new chat messages';

const _communityChannelId = 'community_messages';
const _communityChannelName = 'Community Messages';
const _communityChannelDesc = 'Notifications for new community messages';

const _defaultChannelId = 'high_importance_channel';
const _defaultChannelName = 'General';
const _defaultChannelDesc = 'General notifications';

@lazySingleton
class NotificationService {
  GoRouter? _router;
  CallNotificationService? _callNotificationService;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Whether [initialize] has already completed.
  bool _initialized = false;

  /// The conversation/community ID currently open on screen.
  /// Set by the BLoC/screen when a chat is opened, cleared when closed.
  /// Used to suppress foreground notifications for the active chat.
  String? activeConversationId;

  /// Set the router for deep link navigation from notification taps
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Set the call notification service for incoming call handling
  void setCallNotificationService(CallNotificationService service) {
    _callNotificationService = service;
  }

  /// Initialize FCM + local notifications: request permission, save token,
  /// set up listeners, create Android notification channels.
  ///
  /// Idempotent — safe to call multiple times (e.g. on auth state changes).
  /// The FCM token is always re-saved to keep it fresh.
  Future<void> initialize() async {
    // Always save the latest FCM token (may rotate between sessions)
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await _saveTokenToFirestore(token);

    // Only set up listeners and channels once
    if (_initialized) return;
    _initialized = true;

    await _initLocalNotifications();
    await _requestPermission();
    FirebaseMessaging.instance.onTokenRefresh.listen(_saveTokenToFirestore);
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle notification that launched the app
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  // ===========================================================================
  // LOCAL NOTIFICATIONS SETUP
  // ===========================================================================

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create Android notification channels
    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _chatChannelId,
          _chatChannelName,
          description: _chatChannelDesc,
          importance: Importance.high,
        ),
      );
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _communityChannelId,
          _communityChannelName,
          description: _communityChannelDesc,
          importance: Importance.high,
        ),
      );
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _defaultChannelId,
          _defaultChannelName,
          description: _defaultChannelDesc,
          importance: Importance.high,
        ),
      );
    }
  }

  // ===========================================================================
  // LAUNCHER ICON BADGE
  // ===========================================================================

  static final FlutterLocalNotificationsPlugin _badgePlugin =
      FlutterLocalNotificationsPlugin();

  /// Notification ID reserved for the silent badge-count notification.
  static const _badgeNotificationId = 0;

  /// Update the launcher icon badge count. On Android, the badge is driven
  /// by the `number` field on an active notification. We maintain a single
  /// silent, zero-priority notification whose sole purpose is carrying the
  /// unread count for launchers that display it (Samsung, Xiaomi, etc.).
  static Future<void> updateBadgeCount(int count) async {
    try {
      if (count > 0) {
        await _badgePlugin.show(
          _badgeNotificationId,
          null, // no title — silent
          null, // no body — silent
          NotificationDetails(
            android: AndroidNotificationDetails(
              _defaultChannelId,
              _defaultChannelName,
              channelDescription: _defaultChannelDesc,
              importance: Importance.min,
              priority: Priority.min,
              number: count,
              playSound: false,
              enableVibration: false,
              ongoing: false,
              onlyAlertOnce: true,
              showWhen: false,
              // Make notification invisible but still carry badge count
              visibility: NotificationVisibility.secret,
            ),
          ),
        );
      } else {
        await _badgePlugin.cancel(_badgeNotificationId);
      }
    } catch (e) {
      debugPrint('NotificationService: Badge update failed: $e');
    }
  }

  // ===========================================================================
  // FCM HANDLERS
  // ===========================================================================

  Future<void> _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _saveTokenToFirestore(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'fcmToken': token,
      'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Handle FCM messages that arrive while the app is in the foreground.
  /// Shows a local notification banner so the user sees it.
  void _handleForegroundMessage(RemoteMessage message) {
    final type = message.data['type'] as String?;

    // Handle incoming call data messages (no notification payload)
    if (type == 'incoming_call') {
      _callNotificationService?.showIncomingCall(
        callId: message.data['callId'] as String? ?? '',
        callerName: message.data['callerName'] as String? ?? 'Unknown',
        callerAvatarUrl: message.data['callerAvatarUrl'] as String?,
        callType: message.data['callType'] as String? ?? 'voice',
        conversationId: message.data['conversationId'] as String? ?? '',
        callerId: message.data['callerId'] as String? ?? '',
      );
      return;
    }

    final notification = message.notification;
    if (notification == null) return;

    // Suppress notification if the user is currently viewing this conversation
    final conversationId = message.data['conversationId'] as String?;
    final communityId = message.data['communityId'] as String?;

    final relevantId = conversationId ?? communityId;
    if (relevantId != null && relevantId == activeConversationId) {
      return; // User is already looking at this chat
    }

    // Pick the correct channel based on notification type
    String channelId;
    String channelName;
    switch (type) {
      case 'new_message':
      case 'gift_received':
        channelId = _chatChannelId;
        channelName = _chatChannelName;
      case 'new_community_message':
      case 'token_spray_received':
      case 'token_spray_contribution':
      case 'community_invite':
      case 'community_invite_accepted':
      case 'stokvel_contribution_due':
      case 'stokvel_payout':
        channelId = _communityChannelId;
        channelName = _communityChannelName;
      default:
        channelId = _defaultChannelId;
        channelName = _defaultChannelName;
    }

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  /// Handle tap on a local notification (shown via flutter_local_notifications).
  void _onLocalNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null) return;

    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _routeFromData(data);
    } catch (_) {}
  }

  /// Handle tap on an FCM notification (system tray notification from Firebase).
  void _handleNotificationTap(RemoteMessage message) {
    _routeFromData(message.data);
  }

  /// Route to the appropriate screen based on notification data payload.
  void _routeFromData(Map<String, dynamic> data) {
    final router = _router;
    if (router == null) return;

    final type = data['type'] as String?;
    switch (type) {
      case 'new_message':
        final conversationId = data['conversationId'] as String?;
        if (conversationId != null) {
          router.go('/chat/conversation/$conversationId');
        }
      case 'new_community_message':
        final communityId = data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      case 'gift_received':
        final conversationId = data['conversationId'] as String?;
        if (conversationId != null) {
          router.go('/chat/conversation/$conversationId');
        }
      case 'token_spray_received':
      case 'token_spray_contribution':
        final communityId = data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      case 'community_invite':
        router.go('/chat');
      case 'community_invite_accepted':
        final communityId = data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      case 'stokvel_contribution_due':
      case 'stokvel_payout':
        final communityId = data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      default:
        router.go('/chat');
    }
  }
}
