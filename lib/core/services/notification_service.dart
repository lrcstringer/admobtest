import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

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

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// The conversation/community ID currently open on screen.
  /// Set by the BLoC/screen when a chat is opened, cleared when closed.
  /// Used to suppress foreground notifications for the active chat.
  String? activeConversationId;

  /// Set the router for deep link navigation from notification taps
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Initialize FCM + local notifications: request permission, save token,
  /// set up listeners, create Android notification channels.
  Future<void> initialize() async {
    await _initLocalNotifications();
    await _requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await _saveTokenToFirestore(token);
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

  /// Update the launcher icon badge count. Call whenever unread count changes.
  static Future<void> updateBadgeCount(int count) async {
    try {
      if (count > 0) {
        await FlutterAppBadger.updateBadgeCount(count);
      } else {
        await FlutterAppBadger.removeBadge();
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
    final notification = message.notification;
    if (notification == null) return;

    // Suppress notification if the user is currently viewing this conversation
    final type = message.data['type'] as String?;
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
