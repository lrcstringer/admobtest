import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationService {
  GoRouter? _router;

  /// Set the router for deep link navigation from notification taps
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Initialize FCM: request permission, save token, set up listeners
  Future<void> initialize() async {
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

  void _handleForegroundMessage(RemoteMessage message) {
    // Foreground messages are handled by the OS notification system
    // or can be shown as in-app banners via a separate UI layer
  }

  void _handleNotificationTap(RemoteMessage message) {
    final router = _router;
    if (router == null) return;

    final type = message.data['type'] as String?;
    switch (type) {
      case 'new_message':
        final conversationId = message.data['conversationId'] as String?;
        if (conversationId != null) {
          router.go('/chat/conversation/$conversationId');
        }
      case 'new_community_message':
        final communityId = message.data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      case 'gift_received':
        final conversationId = message.data['conversationId'] as String?;
        if (conversationId != null) {
          router.go('/chat/conversation/$conversationId');
        }
      case 'token_spray_received':
      case 'token_spray_contribution':
        final communityId = message.data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      case 'community_invite':
        router.go('/chat');
      case 'stokvel_contribution_due':
      case 'stokvel_payout':
        final communityId = message.data['communityId'] as String?;
        if (communityId != null) {
          router.go('/chat/community/$communityId');
        }
      default:
        router.go('/chat');
    }
  }
}
