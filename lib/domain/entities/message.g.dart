// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageMedia _$MessageMediaFromJson(Map<String, dynamic> json) =>
    _MessageMedia(
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      fileName: json['fileName'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      mimeType: json['mimeType'] as String,
      duration: (json['duration'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      mediaKey: json['mediaKey'] as String?,
      thumbKey: json['thumbKey'] as String?,
    );

Map<String, dynamic> _$MessageMediaToJson(_MessageMedia instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'duration': instance.duration,
      'width': instance.width,
      'height': instance.height,
      'mediaKey': instance.mediaKey,
      'thumbKey': instance.thumbKey,
    };

_MessageReply _$MessageReplyFromJson(Map<String, dynamic> json) =>
    _MessageReply(
      messageId: json['messageId'] as String,
      senderName: json['senderName'] as String,
      text: json['text'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$MessageReplyToJson(_MessageReply instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderName': instance.senderName,
      'text': instance.text,
      'type': instance.type,
    };

_GiftMessageData _$GiftMessageDataFromJson(Map<String, dynamic> json) =>
    _GiftMessageData(
      giftId: json['giftId'] as String,
      amount: (json['amount'] as num).toInt(),
      message: json['message'] as String,
      style: $enumDecode(_$GiftStyleEnumMap, json['style']),
      status: $enumDecode(_$GiftStatusEnumMap, json['status']),
      recipientId: json['recipientId'] as String?,
      recipientName: json['recipientName'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$GiftMessageDataToJson(_GiftMessageData instance) =>
    <String, dynamic>{
      'giftId': instance.giftId,
      'amount': instance.amount,
      'message': instance.message,
      'style': _$GiftStyleEnumMap[instance.style]!,
      'status': _$GiftStatusEnumMap[instance.status]!,
      'recipientId': instance.recipientId,
      'recipientName': instance.recipientName,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

const _$GiftStyleEnumMap = {
  GiftStyle.ndlovukazi: 'ndlovukazi',
  GiftStyle.celebration: 'celebration',
  GiftStyle.love: 'love',
  GiftStyle.birthday: 'birthday',
  GiftStyle.professional: 'professional',
};

const _$GiftStatusEnumMap = {
  GiftStatus.pending: 'pending',
  GiftStatus.opened: 'opened',
  GiftStatus.claimed: 'claimed',
  GiftStatus.expired: 'expired',
};

_TokenSprayMessageData _$TokenSprayMessageDataFromJson(
  Map<String, dynamic> json,
) => _TokenSprayMessageData(
  sprayId: json['sprayId'] as String,
  recipientId: json['recipientId'] as String,
  recipientName: json['recipientName'] as String,
  occasion: json['occasion'] as String,
  currentTotal: (json['currentTotal'] as num).toInt(),
  contributorCount: (json['contributorCount'] as num).toInt(),
  status: $enumDecode(_$SprayStatusEnumMap, json['status']),
  targetAmount: (json['targetAmount'] as num?)?.toInt(),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$TokenSprayMessageDataToJson(
  _TokenSprayMessageData instance,
) => <String, dynamic>{
  'sprayId': instance.sprayId,
  'recipientId': instance.recipientId,
  'recipientName': instance.recipientName,
  'occasion': instance.occasion,
  'currentTotal': instance.currentTotal,
  'contributorCount': instance.contributorCount,
  'status': _$SprayStatusEnumMap[instance.status]!,
  'targetAmount': instance.targetAmount,
  'expiresAt': instance.expiresAt.toIso8601String(),
};

const _$SprayStatusEnumMap = {
  SprayStatus.active: 'active',
  SprayStatus.closed: 'closed',
  SprayStatus.claimed: 'claimed',
  SprayStatus.expired: 'expired',
};

_GroupGiftMessageData _$GroupGiftMessageDataFromJson(
  Map<String, dynamic> json,
) => _GroupGiftMessageData(
  poolId: json['poolId'] as String,
  amount: (json['amount'] as num).toInt(),
  message: json['message'] as String,
  style: $enumDecode(_$GiftStyleEnumMap, json['style']),
  organizerId: json['organizerId'] as String,
  organizerName: json['organizerName'] as String,
  contributorCount: (json['contributorCount'] as num).toInt(),
  visibleContributorNames:
      (json['visibleContributorNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  anonymousCount: (json['anonymousCount'] as num?)?.toInt() ?? 0,
  status: $enumDecode(_$PoolStatusEnumMap, json['status']),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$GroupGiftMessageDataToJson(
  _GroupGiftMessageData instance,
) => <String, dynamic>{
  'poolId': instance.poolId,
  'amount': instance.amount,
  'message': instance.message,
  'style': _$GiftStyleEnumMap[instance.style]!,
  'organizerId': instance.organizerId,
  'organizerName': instance.organizerName,
  'contributorCount': instance.contributorCount,
  'visibleContributorNames': instance.visibleContributorNames,
  'anonymousCount': instance.anonymousCount,
  'status': _$PoolStatusEnumMap[instance.status]!,
  'expiresAt': instance.expiresAt?.toIso8601String(),
};

const _$PoolStatusEnumMap = {
  PoolStatus.collecting: 'collecting',
  PoolStatus.sent: 'sent',
  PoolStatus.completed: 'completed',
  PoolStatus.cancelled: 'cancelled',
  PoolStatus.expired: 'expired',
};

_ForwardedFrom _$ForwardedFromFromJson(Map<String, dynamic> json) =>
    _ForwardedFrom(
      messageId: json['messageId'] as String,
      conversationId: json['conversationId'] as String,
      senderName: json['senderName'] as String,
    );

Map<String, dynamic> _$ForwardedFromToJson(_ForwardedFrom instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
      'senderName': instance.senderName,
    };

_E2eeMetadata _$E2eeMetadataFromJson(Map<String, dynamic> json) =>
    _E2eeMetadata(
      protocol: json['protocol'] as String,
      senderKeyChainId: json['senderKeyChainId'] as String?,
      messageNumber: (json['messageNumber'] as num?)?.toInt(),
      dhPublicKey: json['dhPublicKey'] as String?,
      previousChainLength: (json['previousChainLength'] as num?)?.toInt(),
      signature: json['signature'] as String?,
    );

Map<String, dynamic> _$E2eeMetadataToJson(_E2eeMetadata instance) =>
    <String, dynamic>{
      'protocol': instance.protocol,
      'senderKeyChainId': instance.senderKeyChainId,
      'messageNumber': instance.messageNumber,
      'dhPublicKey': instance.dhPublicKey,
      'previousChainLength': instance.previousChainLength,
      'signature': instance.signature,
    };

_X3dhHeader _$X3dhHeaderFromJson(Map<String, dynamic> json) => _X3dhHeader(
  identityKey: json['identityKey'] as String,
  ephemeralKey: json['ephemeralKey'] as String,
  oneTimePreKeyId: (json['oneTimePreKeyId'] as num?)?.toInt(),
  signedPreKeyId: (json['signedPreKeyId'] as num?)?.toInt(),
);

Map<String, dynamic> _$X3dhHeaderToJson(_X3dhHeader instance) =>
    <String, dynamic>{
      'identityKey': instance.identityKey,
      'ephemeralKey': instance.ephemeralKey,
      'oneTimePreKeyId': instance.oneTimePreKeyId,
      'signedPreKeyId': instance.signedPreKeyId,
    };

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  senderName: json['senderName'] as String,
  senderAvatarUrl: json['senderAvatarUrl'] as String?,
  type: $enumDecode(_$MessageTypeEnumMap, json['type']),
  status: $enumDecode(_$MessageStatusEnumMap, json['status']),
  textContent: json['textContent'] as String?,
  tokenAmount: (json['tokenAmount'] as num?)?.toInt(),
  recipientId: json['recipientId'] as String?,
  ledgerJournalId: json['ledgerJournalId'] as String?,
  media: json['media'] == null
      ? null
      : MessageMedia.fromJson(json['media'] as Map<String, dynamic>),
  reactions:
      (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  replyTo: json['replyTo'] == null
      ? null
      : MessageReply.fromJson(json['replyTo'] as Map<String, dynamic>),
  readBy:
      (json['readBy'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, DateTime.parse(e as String)),
      ) ??
      const {},
  forwardedFrom: json['forwardedFrom'] == null
      ? null
      : ForwardedFrom.fromJson(json['forwardedFrom'] as Map<String, dynamic>),
  gift: json['gift'] == null
      ? null
      : GiftMessageData.fromJson(json['gift'] as Map<String, dynamic>),
  groupGift: json['groupGift'] == null
      ? null
      : GroupGiftMessageData.fromJson(
          json['groupGift'] as Map<String, dynamic>,
        ),
  tokenSpray: json['tokenSpray'] == null
      ? null
      : TokenSprayMessageData.fromJson(
          json['tokenSpray'] as Map<String, dynamic>,
        ),
  communityId: json['communityId'] as String?,
  systemEventType: json['systemEventType'] as String?,
  systemEventData: json['systemEventData'] as Map<String, dynamic>?,
  ciphertext: json['ciphertext'] as String?,
  e2ee: json['e2ee'] == null
      ? null
      : E2eeMetadata.fromJson(json['e2ee'] as Map<String, dynamic>),
  x3dhHeader: json['x3dhHeader'] == null
      ? null
      : X3dhHeader.fromJson(json['x3dhHeader'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  actionedAt: json['actionedAt'] == null
      ? null
      : DateTime.parse(json['actionedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
  deletedFor:
      (json['deletedFor'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  deletedForEveryone: json['deletedForEveryone'] as bool? ?? false,
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'senderName': instance.senderName,
  'senderAvatarUrl': instance.senderAvatarUrl,
  'type': _$MessageTypeEnumMap[instance.type]!,
  'status': _$MessageStatusEnumMap[instance.status]!,
  'textContent': instance.textContent,
  'tokenAmount': instance.tokenAmount,
  'recipientId': instance.recipientId,
  'ledgerJournalId': instance.ledgerJournalId,
  'media': instance.media,
  'reactions': instance.reactions,
  'replyTo': instance.replyTo,
  'readBy': instance.readBy.map((k, e) => MapEntry(k, e.toIso8601String())),
  'forwardedFrom': instance.forwardedFrom,
  'gift': instance.gift,
  'groupGift': instance.groupGift,
  'tokenSpray': instance.tokenSpray,
  'communityId': instance.communityId,
  'systemEventType': instance.systemEventType,
  'systemEventData': instance.systemEventData,
  'ciphertext': instance.ciphertext,
  'e2ee': instance.e2ee,
  'x3dhHeader': instance.x3dhHeader,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'actionedAt': instance.actionedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'deletedFor': instance.deletedFor,
  'deletedForEveryone': instance.deletedForEveryone,
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.voice: 'voice',
  MessageType.document: 'document',
  MessageType.video: 'video',
  MessageType.tokenSend: 'tokenSend',
  MessageType.tokenRequest: 'tokenRequest',
  MessageType.gift: 'gift',
  MessageType.tokenSpray: 'tokenSpray',
  MessageType.system: 'system',
  MessageType.groupGift: 'groupGift',
  MessageType.marketplaceShare: 'marketplaceShare',
  MessageType.groupBuyShare: 'groupBuyShare',
  MessageType.gooiGooiInvite: 'gooiGooiInvite',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.read: 'read',
  MessageStatus.pending: 'pending',
  MessageStatus.failed: 'failed',
  MessageStatus.paid: 'paid',
  MessageStatus.declined: 'declined',
  MessageStatus.expired: 'expired',
};
