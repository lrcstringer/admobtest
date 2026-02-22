import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/message.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/gift_style.dart';
import '../../domain/enums/gift_status.dart';
import '../../domain/enums/spray_status.dart';

part 'message_model.freezed.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,

    // Sender
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,

    // Content
    required String type,
    required String status,
    String? textContent,

    // Token operations
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,

    // Media
    Map<String, dynamic>? media,

    // Interactions
    @Default({}) Map<String, List<String>> reactions,
    Map<String, dynamic>? replyTo,

    // Gift & spray embedded data
    Map<String, dynamic>? gift,
    Map<String, dynamic>? tokenSpray,

    // Community-specific
    String? communityId,
    String? systemEventType,
    Map<String, dynamic>? systemEventData,

    // E2EE (null when plaintext / E2EE not yet enabled)
    String? ciphertext,
    Map<String, dynamic>? e2ee,
    Map<String, dynamic>? x3dhHeader,

    // Timestamps
    required DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,

    // Deletion
    @Default([]) List<String> deletedFor,
    @Default(false) bool deletedForEveryone,
  }) = _MessageModel;

  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final expiresAt = json['expiresAt'];
    final actionedAt = json['actionedAt'];
    final deletedAt = json['deletedAt'];
    final deletedFor = json['deletedFor'];

    return MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String? ?? 'Unknown',
      senderAvatarUrl: json['senderAvatarUrl'] as String?,
      type: json['type'] as String? ?? 'text',
      status: json['status'] as String? ?? 'sent',
      textContent: json['textContent'] as String?,
      tokenAmount: json['tokenAmount'] as int?,
      recipientId: json['recipientId'] as String?,
      ledgerJournalId: json['ledgerJournalId'] as String?,
      media: json['media'] is Map
          ? Map<String, dynamic>.from(json['media'] as Map)
          : null,
      reactions: _parseReactions(json['reactions']),
      replyTo: json['replyTo'] is Map
          ? Map<String, dynamic>.from(json['replyTo'] as Map)
          : null,
      gift: json['gift'] is Map
          ? Map<String, dynamic>.from(json['gift'] as Map)
          : null,
      tokenSpray: json['tokenSpray'] is Map
          ? Map<String, dynamic>.from(json['tokenSpray'] as Map)
          : null,
      communityId: json['communityId'] as String?,
      systemEventType: json['systemEventType'] as String?,
      systemEventData: json['systemEventData'] is Map
          ? Map<String, dynamic>.from(json['systemEventData'] as Map)
          : null,
      ciphertext: json['ciphertext'] as String?,
      e2ee: json['e2ee'] is Map
          ? Map<String, dynamic>.from(json['e2ee'] as Map)
          : null,
      x3dhHeader: json['x3dhHeader'] is Map
          ? Map<String, dynamic>.from(json['x3dhHeader'] as Map)
          : null,
      createdAt: _parseDateTimeRequired(createdAt),
      expiresAt: _parseDateTime(expiresAt),
      actionedAt: _parseDateTime(actionedAt),
      deletedAt: _parseDateTime(deletedAt),
      deletedFor: deletedFor is List ? List<String>.from(deletedFor) : [],
      deletedForEveryone: json['deletedForEveryone'] as bool? ?? false,
    );
  }

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return MessageModel.fromJson({...data, 'id': doc.id});
  }

  Message toEntity() {
    return Message(
      id: id,
      senderId: senderId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      type: _parseMessageType(type),
      status: _parseMessageStatus(status),
      textContent: textContent,
      tokenAmount: tokenAmount,
      recipientId: recipientId,
      ledgerJournalId: ledgerJournalId,
      media: _parseMedia(media),
      reactions: reactions,
      replyTo: _parseReply(replyTo),
      gift: _parseGiftData(gift),
      tokenSpray: _parseSprayData(tokenSpray),
      communityId: communityId,
      systemEventType: systemEventType,
      systemEventData: systemEventData,
      ciphertext: ciphertext,
      e2ee: _parseE2eeMetadata(e2ee),
      x3dhHeader: _parseX3dhHeader(x3dhHeader),
      createdAt: createdAt,
      expiresAt: expiresAt,
      actionedAt: actionedAt,
      deletedAt: deletedAt,
      deletedFor: deletedFor,
      deletedForEveryone: deletedForEveryone,
    );
  }

  /// Create an optimistic local message for immediate UI display
  factory MessageModel.optimistic({
    required String localId,
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required String type,
    String? textContent,
    int? tokenAmount,
    String? recipientId,
    Map<String, dynamic>? media,
    Map<String, dynamic>? replyTo,
    String? communityId,
  }) {
    return MessageModel(
      id: localId,
      senderId: senderId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      type: type,
      status: 'sending',
      textContent: textContent,
      tokenAmount: tokenAmount,
      recipientId: recipientId,
      media: media,
      replyTo: replyTo,
      communityId: communityId,
      createdAt: DateTime.now(),
    );
  }

  // =========================================================================
  // PARSE HELPERS
  // =========================================================================

  static MessageType _parseMessageType(String type) {
    switch (type) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'voice':
        return MessageType.voice;
      case 'tokenSend':
        return MessageType.tokenSend;
      case 'tokenRequest':
        return MessageType.tokenRequest;
      case 'gift':
        return MessageType.gift;
      case 'tokenSpray':
        return MessageType.tokenSpray;
      case 'system':
        return MessageType.system;
      default:
        return MessageType.text;
    }
  }

  static MessageStatus _parseMessageStatus(String status) {
    switch (status) {
      case 'sending':
        return MessageStatus.sending;
      case 'sent':
        return MessageStatus.sent;
      case 'pending':
        return MessageStatus.pending;
      case 'failed':
        return MessageStatus.failed;
      case 'paid':
        return MessageStatus.paid;
      case 'declined':
        return MessageStatus.declined;
      default:
        return MessageStatus.sent;
    }
  }

  static MessageMedia? _parseMedia(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    return MessageMedia(
      url: raw['url'] as String? ?? '',
      thumbnailUrl: raw['thumbnailUrl'] as String?,
      fileName: raw['fileName'] as String? ?? '',
      fileSize: raw['fileSize'] as int? ?? 0,
      mimeType: raw['mimeType'] as String? ?? '',
      duration: raw['duration'] as int?,
      width: raw['width'] as int?,
      height: raw['height'] as int?,
      mediaKey: raw['mediaKey'] as String?,
      thumbKey: raw['thumbKey'] as String?,
    );
  }

  static MessageReply? _parseReply(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    return MessageReply(
      messageId: raw['messageId'] as String? ?? '',
      senderName: raw['senderName'] as String? ?? '',
      text: raw['text'] as String? ?? '',
      type: raw['type'] as String? ?? 'text',
    );
  }

  static GiftMessageData? _parseGiftData(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    return GiftMessageData(
      giftId: raw['giftId'] as String? ?? '',
      amount: raw['amount'] as int? ?? 0,
      message: raw['message'] as String? ?? '',
      style: _parseGiftStyle(raw['style'] as String?),
      status: _parseGiftStatus(raw['status'] as String?),
      recipientId: raw['recipientId'] as String?,
      recipientName: raw['recipientName'] as String?,
    );
  }

  static TokenSprayMessageData? _parseSprayData(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    return TokenSprayMessageData(
      sprayId: raw['sprayId'] as String? ?? '',
      recipientId: raw['recipientId'] as String? ?? '',
      recipientName: raw['recipientName'] as String? ?? '',
      occasion: raw['occasion'] as String? ?? '',
      currentTotal: raw['currentTotal'] as int? ?? 0,
      contributorCount: raw['contributorCount'] as int? ?? 0,
      status: _parseSprayStatus(raw['status'] as String?),
      targetAmount: raw['targetAmount'] as int?,
      expiresAt: _parseDateTimeRequired(raw['expiresAt']),
    );
  }

  static E2eeMetadata? _parseE2eeMetadata(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    return E2eeMetadata(
      protocol: raw['protocol'] as String? ?? 'signal',
      senderKeyChainId: raw['senderKeyChainId'] as String?,
      // Firestore can return numbers as double (especially on web / nested maps).
      // Using (as num?)?.toInt() handles both int and double safely.
      messageNumber: (raw['messageNumber'] as num?)?.toInt(),
      dhPublicKey: raw['dhPublicKey'] as String?,
    );
  }

  static X3dhHeader? _parseX3dhHeader(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    return X3dhHeader(
      identityKey: raw['identityKey'] as String? ?? '',
      ephemeralKey: raw['ephemeralKey'] as String? ?? '',
      oneTimePreKeyId: (raw['oneTimePreKeyId'] as num?)?.toInt(),
      oneTimePreKeyPublicKey: raw['oneTimePreKeyPublicKey'] as String?,
    );
  }

  static GiftStyle _parseGiftStyle(String? style) {
    switch (style) {
      case 'ndlovukazi':
        return GiftStyle.ndlovukazi;
      case 'celebration':
        return GiftStyle.celebration;
      case 'love':
        return GiftStyle.love;
      case 'birthday':
        return GiftStyle.birthday;
      case 'professional':
        return GiftStyle.professional;
      default:
        return GiftStyle.celebration;
    }
  }

  static GiftStatus _parseGiftStatus(String? status) {
    switch (status) {
      case 'pending':
        return GiftStatus.pending;
      case 'opened':
        return GiftStatus.opened;
      case 'claimed':
        return GiftStatus.claimed;
      case 'expired':
        return GiftStatus.expired;
      default:
        return GiftStatus.pending;
    }
  }

  static SprayStatus _parseSprayStatus(String? status) {
    switch (status) {
      case 'active':
        return SprayStatus.active;
      case 'closed':
        return SprayStatus.closed;
      case 'claimed':
        return SprayStatus.claimed;
      case 'expired':
        return SprayStatus.expired;
      default:
        return SprayStatus.active;
    }
  }

  static Map<String, List<String>> _parseReactions(dynamic raw) {
    if (raw == null) return {};
    if (raw is! Map) return {};
    return raw.map((key, value) {
      final userIds =
          value is List ? List<String>.from(value) : <String>[];
      return MapEntry(key.toString(), userIds);
    });
  }

  static DateTime _parseDateTimeRequired(dynamic raw) {
    if (raw is Timestamp) return raw.toDate();
    if (raw is String) return DateTime.parse(raw);
    if (raw is DateTime) return raw;
    return DateTime.now();
  }

  static DateTime? _parseDateTime(dynamic raw) {
    if (raw == null) return null;
    if (raw is Timestamp) return raw.toDate();
    if (raw is String) return DateTime.parse(raw);
    if (raw is DateTime) return raw;
    return null;
  }
}
