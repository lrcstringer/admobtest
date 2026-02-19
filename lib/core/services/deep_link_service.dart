import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// Handles deep links and converts URI paths into GoRouter navigation.
///
/// Supported deep link formats:
/// - `https://imalichat.app/join?ref=CODE`          → referral sign-up
/// - `https://imalichat.app/join/community/ID`       → community join
/// - `https://imalichat.app/chat/USER_ID`            → open conversation
/// - `imali://user/USER_ID`                          → open conversation (QR)
/// - `imali://community/COMMUNITY_ID`                → open community (QR)
@lazySingleton
class DeepLinkService {
  GoRouter? _router;

  /// Attach the GoRouter instance (called once during app init).
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Parse and handle an incoming deep link URI string.
  /// Returns true if the link was handled, false otherwise.
  bool handleDeepLink(String link) {
    final uri = Uri.tryParse(link);
    if (uri == null) return false;

    debugPrint('[DeepLinkService] Handling: $link');

    // Custom scheme: imali://
    if (uri.scheme == 'imali') {
      return _handleCustomScheme(uri);
    }

    // HTTPS links: imalichat.app
    if (uri.host == 'imalichat.app' || uri.host == 'www.imalichat.app') {
      return _handleWebLink(uri);
    }

    return false;
  }

  bool _handleCustomScheme(Uri uri) {
    final path = uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
    final segments = path.split('/');

    if (segments.isEmpty) return false;

    switch (uri.host) {
      case 'user':
        // imali://user/USER_ID → open conversation with that user
        if (segments.isNotEmpty) {
          _navigateToConversation(segments.first);
          return true;
        }
      case 'community':
        // imali://community/COMMUNITY_ID → open community
        if (segments.isNotEmpty) {
          _navigateToCommunity(segments.first);
          return true;
        }
    }

    return false;
  }

  bool _handleWebLink(Uri uri) {
    final segments = uri.pathSegments;
    if (segments.isEmpty) return false;

    switch (segments.first) {
      case 'join':
        if (segments.length >= 3 && segments[1] == 'community') {
          // /join/community/ID
          final communityId = segments[2];
          _navigateToCommunity(communityId);
          return true;
        }
        // /join?ref=CODE — handled by auth flow, store referral code
        final ref = uri.queryParameters['ref'];
        if (ref != null) {
          _storeReferralCode(ref);
        }
        return true;

      case 'chat':
        if (segments.length >= 2) {
          // /chat/USER_ID
          _navigateToConversation(segments[1]);
          return true;
        }
    }

    return false;
  }

  void _navigateToConversation(String participantId) {
    if (_router == null) {
      debugPrint('[DeepLinkService] Router not set, cannot navigate');
      return;
    }
    // Navigate to the conversation detail screen.
    // The ConversationBloc handles getOrCreate for the participant.
    _router!.go('/chat/conversation/$participantId');
  }

  void _navigateToCommunity(String communityId) {
    if (_router == null) {
      debugPrint('[DeepLinkService] Router not set, cannot navigate');
      return;
    }
    _router!.go('/chat/community/$communityId');
  }

  /// Store referral code for later use during sign-up.
  String? _pendingReferralCode;

  void _storeReferralCode(String code) {
    _pendingReferralCode = code;
    debugPrint('[DeepLinkService] Stored referral code: $code');
  }

  /// Retrieve and clear the pending referral code (used by sign-up flow).
  String? consumeReferralCode() {
    final code = _pendingReferralCode;
    _pendingReferralCode = null;
    return code;
  }
}
