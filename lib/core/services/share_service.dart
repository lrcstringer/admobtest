import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

/// Handles sharing achievements, community invite links, and referral codes
/// to external platforms via the device's native share sheet.
@lazySingleton
class ShareService {
  final FirebaseAuth _auth;

  ShareService(this._auth);

  String? get _currentUserId => _auth.currentUser?.uid;

  /// Share an achievement (earn completion, gift sent, etc.) with a referral link.
  Future<void> shareAchievement({
    required String achievement,
    required int amount,
    String? referralCode,
  }) async {
    final refParam = referralCode != null ? '?ref=$referralCode' : '';
    final text = '''
I just earned $amount tokens on iMaliChat!
$achievement

Join me and start earning rewards:
https://imalichat.app/join$refParam
''';
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: 'Check out what I earned on iMaliChat!',
      ),
    );
  }

  /// Share a community invite link.
  Future<void> shareCommunityInvite({
    required String communityId,
    required String communityName,
  }) async {
    final userId = _currentUserId ?? '';
    final link =
        'https://imalichat.app/join/community/$communityId?inviter=$userId';
    final text = '''
Join "$communityName" on iMaliChat!

$link
''';
    await SharePlus.instance.share(
      ShareParams(text: text, subject: 'Join $communityName on iMaliChat'),
    );
  }

  /// Share a generic referral link.
  Future<void> shareReferralLink({
    required String referralCode,
    String? customMessage,
  }) async {
    final link = 'https://imalichat.app/join?ref=$referralCode';
    final text = customMessage ??
        '''
Join me on iMaliChat and earn tokens!
Use my referral code: $referralCode

$link
''';
    await SharePlus.instance.share(
      ShareParams(text: text, subject: 'Join iMaliChat'),
    );
  }

  /// Share a user's QR code page link for starting a conversation.
  Future<void> shareUserProfile({
    required String displayName,
  }) async {
    final userId = _currentUserId ?? '';
    final link = 'https://imalichat.app/chat/$userId';
    final text = '''
Chat with me on iMaliChat!
$displayName

$link
''';
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: 'Chat with $displayName on iMaliChat',
      ),
    );
  }
}
