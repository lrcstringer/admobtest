import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../../domain/enums/message_type.dart';
import '../../domain/enums/gift_style.dart';
import '../../domain/enums/spray_occasion.dart';
import '../../domain/enums/community_type.dart';

@lazySingleton
class ChatAnalyticsService {
  final FirebaseAnalytics _analytics;

  ChatAnalyticsService(this._analytics);

  Future<void> trackMessageSent({
    required MessageType type,
    required bool isConversation,
  }) async {
    await _analytics.logEvent(
      name: 'message_sent',
      parameters: {
        'type': type.name,
        'is_conversation': isConversation.toString(),
      },
    );
  }

  Future<void> trackGiftSent({
    required int amount,
    required GiftStyle style,
  }) async {
    await _analytics.logEvent(
      name: 'gift_sent',
      parameters: {
        'amount': amount,
        'style': style.name,
      },
    );
  }

  Future<void> trackGiftClaimed({required int amount}) async {
    await _analytics.logEvent(
      name: 'gift_claimed',
      parameters: {'amount': amount},
    );
  }

  Future<void> trackSprayCreated({
    required SprayOccasion occasion,
    int? targetAmount,
  }) async {
    await _analytics.logEvent(
      name: 'spray_created',
      parameters: {
        'occasion': occasion.name,
        if (targetAmount != null) 'target_amount': targetAmount,
      },
    );
  }

  Future<void> trackSprayContribution({required int amount}) async {
    await _analytics.logEvent(
      name: 'spray_contribution',
      parameters: {'amount': amount},
    );
  }

  Future<void> trackCommunityCreated({required CommunityType type}) async {
    await _analytics.logEvent(
      name: 'community_created',
      parameters: {'type': type.name},
    );
  }

  Future<void> trackCommunityJoined() async {
    await _analytics.logEvent(name: 'community_joined');
  }

  Future<void> trackTokensSent({required int amount}) async {
    await _analytics.logEvent(
      name: 'tokens_sent',
      parameters: {'amount': amount},
    );
  }

  Future<void> trackQrScanned({required String type}) async {
    await _analytics.logEvent(
      name: 'qr_scanned',
      parameters: {'type': type},
    );
  }

  Future<void> trackShareAction({required String contentType}) async {
    await _analytics.logEvent(
      name: 'share_action',
      parameters: {'content_type': contentType},
    );
  }
}
