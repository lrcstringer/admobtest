// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageModel implements DiagnosticableTreeMixin {

 String get id;// Sender
 String get senderId; String get senderName; String? get senderAvatarUrl;// Content
 String get type; String get status; String? get textContent;// Token operations
 int? get tokenAmount; String? get recipientId; String? get ledgerJournalId;// Media
 Map<String, dynamic>? get media;// Interactions
 Map<String, List<String>> get reactions; Map<String, dynamic>? get replyTo;// Read receipts & forwarding
 Map<String, DateTime> get readBy; Map<String, dynamic>? get forwardedFrom;// Gift, spray & group gift embedded data
 Map<String, dynamic>? get gift; Map<String, dynamic>? get tokenSpray; Map<String, dynamic>? get groupGift;// Community-specific
 String? get communityId; String? get systemEventType; Map<String, dynamic>? get systemEventData;// E2EE (null when plaintext / E2EE not yet enabled)
 String? get ciphertext; Map<String, dynamic>? get e2ee; Map<String, dynamic>? get x3dhHeader;// Timestamps
 DateTime get createdAt; DateTime? get expiresAt; DateTime? get actionedAt; DateTime? get deletedAt;// Deletion
 List<String> get deletedFor; bool get deletedForEveryone;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MessageModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderName', senderName))..add(DiagnosticsProperty('senderAvatarUrl', senderAvatarUrl))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('textContent', textContent))..add(DiagnosticsProperty('tokenAmount', tokenAmount))..add(DiagnosticsProperty('recipientId', recipientId))..add(DiagnosticsProperty('ledgerJournalId', ledgerJournalId))..add(DiagnosticsProperty('media', media))..add(DiagnosticsProperty('reactions', reactions))..add(DiagnosticsProperty('replyTo', replyTo))..add(DiagnosticsProperty('readBy', readBy))..add(DiagnosticsProperty('forwardedFrom', forwardedFrom))..add(DiagnosticsProperty('gift', gift))..add(DiagnosticsProperty('tokenSpray', tokenSpray))..add(DiagnosticsProperty('groupGift', groupGift))..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('systemEventType', systemEventType))..add(DiagnosticsProperty('systemEventData', systemEventData))..add(DiagnosticsProperty('ciphertext', ciphertext))..add(DiagnosticsProperty('e2ee', e2ee))..add(DiagnosticsProperty('x3dhHeader', x3dhHeader))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('expiresAt', expiresAt))..add(DiagnosticsProperty('actionedAt', actionedAt))..add(DiagnosticsProperty('deletedAt', deletedAt))..add(DiagnosticsProperty('deletedFor', deletedFor))..add(DiagnosticsProperty('deletedForEveryone', deletedForEveryone));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.ledgerJournalId, ledgerJournalId) || other.ledgerJournalId == ledgerJournalId)&&const DeepCollectionEquality().equals(other.media, media)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&const DeepCollectionEquality().equals(other.replyTo, replyTo)&&const DeepCollectionEquality().equals(other.readBy, readBy)&&const DeepCollectionEquality().equals(other.forwardedFrom, forwardedFrom)&&const DeepCollectionEquality().equals(other.gift, gift)&&const DeepCollectionEquality().equals(other.tokenSpray, tokenSpray)&&const DeepCollectionEquality().equals(other.groupGift, groupGift)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.systemEventType, systemEventType) || other.systemEventType == systemEventType)&&const DeepCollectionEquality().equals(other.systemEventData, systemEventData)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&const DeepCollectionEquality().equals(other.e2ee, e2ee)&&const DeepCollectionEquality().equals(other.x3dhHeader, x3dhHeader)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&const DeepCollectionEquality().equals(other.deletedFor, deletedFor)&&(identical(other.deletedForEveryone, deletedForEveryone) || other.deletedForEveryone == deletedForEveryone));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,senderId,senderName,senderAvatarUrl,type,status,textContent,tokenAmount,recipientId,ledgerJournalId,const DeepCollectionEquality().hash(media),const DeepCollectionEquality().hash(reactions),const DeepCollectionEquality().hash(replyTo),const DeepCollectionEquality().hash(readBy),const DeepCollectionEquality().hash(forwardedFrom),const DeepCollectionEquality().hash(gift),const DeepCollectionEquality().hash(tokenSpray),const DeepCollectionEquality().hash(groupGift),communityId,systemEventType,const DeepCollectionEquality().hash(systemEventData),ciphertext,const DeepCollectionEquality().hash(e2ee),const DeepCollectionEquality().hash(x3dhHeader),createdAt,expiresAt,actionedAt,deletedAt,const DeepCollectionEquality().hash(deletedFor),deletedForEveryone]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MessageModel(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, recipientId: $recipientId, ledgerJournalId: $ledgerJournalId, media: $media, reactions: $reactions, replyTo: $replyTo, readBy: $readBy, forwardedFrom: $forwardedFrom, gift: $gift, tokenSpray: $tokenSpray, groupGift: $groupGift, communityId: $communityId, systemEventType: $systemEventType, systemEventData: $systemEventData, ciphertext: $ciphertext, e2ee: $e2ee, x3dhHeader: $x3dhHeader, createdAt: $createdAt, expiresAt: $expiresAt, actionedAt: $actionedAt, deletedAt: $deletedAt, deletedFor: $deletedFor, deletedForEveryone: $deletedForEveryone)';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderName, String? senderAvatarUrl, String type, String status, String? textContent, int? tokenAmount, String? recipientId, String? ledgerJournalId, Map<String, dynamic>? media, Map<String, List<String>> reactions, Map<String, dynamic>? replyTo, Map<String, DateTime> readBy, Map<String, dynamic>? forwardedFrom, Map<String, dynamic>? gift, Map<String, dynamic>? tokenSpray, Map<String, dynamic>? groupGift, String? communityId, String? systemEventType, Map<String, dynamic>? systemEventData, String? ciphertext, Map<String, dynamic>? e2ee, Map<String, dynamic>? x3dhHeader, DateTime createdAt, DateTime? expiresAt, DateTime? actionedAt, DateTime? deletedAt, List<String> deletedFor, bool deletedForEveryone
});




}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? senderAvatarUrl = freezed,Object? type = null,Object? status = null,Object? textContent = freezed,Object? tokenAmount = freezed,Object? recipientId = freezed,Object? ledgerJournalId = freezed,Object? media = freezed,Object? reactions = null,Object? replyTo = freezed,Object? readBy = null,Object? forwardedFrom = freezed,Object? gift = freezed,Object? tokenSpray = freezed,Object? groupGift = freezed,Object? communityId = freezed,Object? systemEventType = freezed,Object? systemEventData = freezed,Object? ciphertext = freezed,Object? e2ee = freezed,Object? x3dhHeader = freezed,Object? createdAt = null,Object? expiresAt = freezed,Object? actionedAt = freezed,Object? deletedAt = freezed,Object? deletedFor = null,Object? deletedForEveryone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,tokenAmount: freezed == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int?,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,ledgerJournalId: freezed == ledgerJournalId ? _self.ledgerJournalId : ledgerJournalId // ignore: cast_nullable_to_non_nullable
as String?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,readBy: null == readBy ? _self.readBy : readBy // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,forwardedFrom: freezed == forwardedFrom ? _self.forwardedFrom : forwardedFrom // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,gift: freezed == gift ? _self.gift : gift // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,tokenSpray: freezed == tokenSpray ? _self.tokenSpray : tokenSpray // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,groupGift: freezed == groupGift ? _self.groupGift : groupGift // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,systemEventType: freezed == systemEventType ? _self.systemEventType : systemEventType // ignore: cast_nullable_to_non_nullable
as String?,systemEventData: freezed == systemEventData ? _self.systemEventData : systemEventData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ciphertext: freezed == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String?,e2ee: freezed == e2ee ? _self.e2ee : e2ee // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,x3dhHeader: freezed == x3dhHeader ? _self.x3dhHeader : x3dhHeader // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedFor: null == deletedFor ? _self.deletedFor : deletedFor // ignore: cast_nullable_to_non_nullable
as List<String>,deletedForEveryone: null == deletedForEveryone ? _self.deletedForEveryone : deletedForEveryone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String? senderAvatarUrl,  String type,  String status,  String? textContent,  int? tokenAmount,  String? recipientId,  String? ledgerJournalId,  Map<String, dynamic>? media,  Map<String, List<String>> reactions,  Map<String, dynamic>? replyTo,  Map<String, DateTime> readBy,  Map<String, dynamic>? forwardedFrom,  Map<String, dynamic>? gift,  Map<String, dynamic>? tokenSpray,  Map<String, dynamic>? groupGift,  String? communityId,  String? systemEventType,  Map<String, dynamic>? systemEventData,  String? ciphertext,  Map<String, dynamic>? e2ee,  Map<String, dynamic>? x3dhHeader,  DateTime createdAt,  DateTime? expiresAt,  DateTime? actionedAt,  DateTime? deletedAt,  List<String> deletedFor,  bool deletedForEveryone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatarUrl,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.recipientId,_that.ledgerJournalId,_that.media,_that.reactions,_that.replyTo,_that.readBy,_that.forwardedFrom,_that.gift,_that.tokenSpray,_that.groupGift,_that.communityId,_that.systemEventType,_that.systemEventData,_that.ciphertext,_that.e2ee,_that.x3dhHeader,_that.createdAt,_that.expiresAt,_that.actionedAt,_that.deletedAt,_that.deletedFor,_that.deletedForEveryone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String? senderAvatarUrl,  String type,  String status,  String? textContent,  int? tokenAmount,  String? recipientId,  String? ledgerJournalId,  Map<String, dynamic>? media,  Map<String, List<String>> reactions,  Map<String, dynamic>? replyTo,  Map<String, DateTime> readBy,  Map<String, dynamic>? forwardedFrom,  Map<String, dynamic>? gift,  Map<String, dynamic>? tokenSpray,  Map<String, dynamic>? groupGift,  String? communityId,  String? systemEventType,  Map<String, dynamic>? systemEventData,  String? ciphertext,  Map<String, dynamic>? e2ee,  Map<String, dynamic>? x3dhHeader,  DateTime createdAt,  DateTime? expiresAt,  DateTime? actionedAt,  DateTime? deletedAt,  List<String> deletedFor,  bool deletedForEveryone)  $default,) {final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatarUrl,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.recipientId,_that.ledgerJournalId,_that.media,_that.reactions,_that.replyTo,_that.readBy,_that.forwardedFrom,_that.gift,_that.tokenSpray,_that.groupGift,_that.communityId,_that.systemEventType,_that.systemEventData,_that.ciphertext,_that.e2ee,_that.x3dhHeader,_that.createdAt,_that.expiresAt,_that.actionedAt,_that.deletedAt,_that.deletedFor,_that.deletedForEveryone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderName,  String? senderAvatarUrl,  String type,  String status,  String? textContent,  int? tokenAmount,  String? recipientId,  String? ledgerJournalId,  Map<String, dynamic>? media,  Map<String, List<String>> reactions,  Map<String, dynamic>? replyTo,  Map<String, DateTime> readBy,  Map<String, dynamic>? forwardedFrom,  Map<String, dynamic>? gift,  Map<String, dynamic>? tokenSpray,  Map<String, dynamic>? groupGift,  String? communityId,  String? systemEventType,  Map<String, dynamic>? systemEventData,  String? ciphertext,  Map<String, dynamic>? e2ee,  Map<String, dynamic>? x3dhHeader,  DateTime createdAt,  DateTime? expiresAt,  DateTime? actionedAt,  DateTime? deletedAt,  List<String> deletedFor,  bool deletedForEveryone)?  $default,) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatarUrl,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.recipientId,_that.ledgerJournalId,_that.media,_that.reactions,_that.replyTo,_that.readBy,_that.forwardedFrom,_that.gift,_that.tokenSpray,_that.groupGift,_that.communityId,_that.systemEventType,_that.systemEventData,_that.ciphertext,_that.e2ee,_that.x3dhHeader,_that.createdAt,_that.expiresAt,_that.actionedAt,_that.deletedAt,_that.deletedFor,_that.deletedForEveryone);case _:
  return null;

}
}

}

/// @nodoc


class _MessageModel extends MessageModel with DiagnosticableTreeMixin {
  const _MessageModel({required this.id, required this.senderId, required this.senderName, this.senderAvatarUrl, required this.type, required this.status, this.textContent, this.tokenAmount, this.recipientId, this.ledgerJournalId, final  Map<String, dynamic>? media, final  Map<String, List<String>> reactions = const {}, final  Map<String, dynamic>? replyTo, final  Map<String, DateTime> readBy = const {}, final  Map<String, dynamic>? forwardedFrom, final  Map<String, dynamic>? gift, final  Map<String, dynamic>? tokenSpray, final  Map<String, dynamic>? groupGift, this.communityId, this.systemEventType, final  Map<String, dynamic>? systemEventData, this.ciphertext, final  Map<String, dynamic>? e2ee, final  Map<String, dynamic>? x3dhHeader, required this.createdAt, this.expiresAt, this.actionedAt, this.deletedAt, final  List<String> deletedFor = const [], this.deletedForEveryone = false}): _media = media,_reactions = reactions,_replyTo = replyTo,_readBy = readBy,_forwardedFrom = forwardedFrom,_gift = gift,_tokenSpray = tokenSpray,_groupGift = groupGift,_systemEventData = systemEventData,_e2ee = e2ee,_x3dhHeader = x3dhHeader,_deletedFor = deletedFor,super._();
  

@override final  String id;
// Sender
@override final  String senderId;
@override final  String senderName;
@override final  String? senderAvatarUrl;
// Content
@override final  String type;
@override final  String status;
@override final  String? textContent;
// Token operations
@override final  int? tokenAmount;
@override final  String? recipientId;
@override final  String? ledgerJournalId;
// Media
 final  Map<String, dynamic>? _media;
// Media
@override Map<String, dynamic>? get media {
  final value = _media;
  if (value == null) return null;
  if (_media is EqualUnmodifiableMapView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Interactions
 final  Map<String, List<String>> _reactions;
// Interactions
@override@JsonKey() Map<String, List<String>> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

 final  Map<String, dynamic>? _replyTo;
@override Map<String, dynamic>? get replyTo {
  final value = _replyTo;
  if (value == null) return null;
  if (_replyTo is EqualUnmodifiableMapView) return _replyTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Read receipts & forwarding
 final  Map<String, DateTime> _readBy;
// Read receipts & forwarding
@override@JsonKey() Map<String, DateTime> get readBy {
  if (_readBy is EqualUnmodifiableMapView) return _readBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_readBy);
}

 final  Map<String, dynamic>? _forwardedFrom;
@override Map<String, dynamic>? get forwardedFrom {
  final value = _forwardedFrom;
  if (value == null) return null;
  if (_forwardedFrom is EqualUnmodifiableMapView) return _forwardedFrom;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Gift, spray & group gift embedded data
 final  Map<String, dynamic>? _gift;
// Gift, spray & group gift embedded data
@override Map<String, dynamic>? get gift {
  final value = _gift;
  if (value == null) return null;
  if (_gift is EqualUnmodifiableMapView) return _gift;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _tokenSpray;
@override Map<String, dynamic>? get tokenSpray {
  final value = _tokenSpray;
  if (value == null) return null;
  if (_tokenSpray is EqualUnmodifiableMapView) return _tokenSpray;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _groupGift;
@override Map<String, dynamic>? get groupGift {
  final value = _groupGift;
  if (value == null) return null;
  if (_groupGift is EqualUnmodifiableMapView) return _groupGift;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Community-specific
@override final  String? communityId;
@override final  String? systemEventType;
 final  Map<String, dynamic>? _systemEventData;
@override Map<String, dynamic>? get systemEventData {
  final value = _systemEventData;
  if (value == null) return null;
  if (_systemEventData is EqualUnmodifiableMapView) return _systemEventData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// E2EE (null when plaintext / E2EE not yet enabled)
@override final  String? ciphertext;
 final  Map<String, dynamic>? _e2ee;
@override Map<String, dynamic>? get e2ee {
  final value = _e2ee;
  if (value == null) return null;
  if (_e2ee is EqualUnmodifiableMapView) return _e2ee;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _x3dhHeader;
@override Map<String, dynamic>? get x3dhHeader {
  final value = _x3dhHeader;
  if (value == null) return null;
  if (_x3dhHeader is EqualUnmodifiableMapView) return _x3dhHeader;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Timestamps
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;
@override final  DateTime? actionedAt;
@override final  DateTime? deletedAt;
// Deletion
 final  List<String> _deletedFor;
// Deletion
@override@JsonKey() List<String> get deletedFor {
  if (_deletedFor is EqualUnmodifiableListView) return _deletedFor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deletedFor);
}

@override@JsonKey() final  bool deletedForEveryone;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageModelCopyWith<_MessageModel> get copyWith => __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MessageModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderName', senderName))..add(DiagnosticsProperty('senderAvatarUrl', senderAvatarUrl))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('textContent', textContent))..add(DiagnosticsProperty('tokenAmount', tokenAmount))..add(DiagnosticsProperty('recipientId', recipientId))..add(DiagnosticsProperty('ledgerJournalId', ledgerJournalId))..add(DiagnosticsProperty('media', media))..add(DiagnosticsProperty('reactions', reactions))..add(DiagnosticsProperty('replyTo', replyTo))..add(DiagnosticsProperty('readBy', readBy))..add(DiagnosticsProperty('forwardedFrom', forwardedFrom))..add(DiagnosticsProperty('gift', gift))..add(DiagnosticsProperty('tokenSpray', tokenSpray))..add(DiagnosticsProperty('groupGift', groupGift))..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('systemEventType', systemEventType))..add(DiagnosticsProperty('systemEventData', systemEventData))..add(DiagnosticsProperty('ciphertext', ciphertext))..add(DiagnosticsProperty('e2ee', e2ee))..add(DiagnosticsProperty('x3dhHeader', x3dhHeader))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('expiresAt', expiresAt))..add(DiagnosticsProperty('actionedAt', actionedAt))..add(DiagnosticsProperty('deletedAt', deletedAt))..add(DiagnosticsProperty('deletedFor', deletedFor))..add(DiagnosticsProperty('deletedForEveryone', deletedForEveryone));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.ledgerJournalId, ledgerJournalId) || other.ledgerJournalId == ledgerJournalId)&&const DeepCollectionEquality().equals(other._media, _media)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._replyTo, _replyTo)&&const DeepCollectionEquality().equals(other._readBy, _readBy)&&const DeepCollectionEquality().equals(other._forwardedFrom, _forwardedFrom)&&const DeepCollectionEquality().equals(other._gift, _gift)&&const DeepCollectionEquality().equals(other._tokenSpray, _tokenSpray)&&const DeepCollectionEquality().equals(other._groupGift, _groupGift)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.systemEventType, systemEventType) || other.systemEventType == systemEventType)&&const DeepCollectionEquality().equals(other._systemEventData, _systemEventData)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&const DeepCollectionEquality().equals(other._e2ee, _e2ee)&&const DeepCollectionEquality().equals(other._x3dhHeader, _x3dhHeader)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&const DeepCollectionEquality().equals(other._deletedFor, _deletedFor)&&(identical(other.deletedForEveryone, deletedForEveryone) || other.deletedForEveryone == deletedForEveryone));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,senderId,senderName,senderAvatarUrl,type,status,textContent,tokenAmount,recipientId,ledgerJournalId,const DeepCollectionEquality().hash(_media),const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_replyTo),const DeepCollectionEquality().hash(_readBy),const DeepCollectionEquality().hash(_forwardedFrom),const DeepCollectionEquality().hash(_gift),const DeepCollectionEquality().hash(_tokenSpray),const DeepCollectionEquality().hash(_groupGift),communityId,systemEventType,const DeepCollectionEquality().hash(_systemEventData),ciphertext,const DeepCollectionEquality().hash(_e2ee),const DeepCollectionEquality().hash(_x3dhHeader),createdAt,expiresAt,actionedAt,deletedAt,const DeepCollectionEquality().hash(_deletedFor),deletedForEveryone]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MessageModel(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, recipientId: $recipientId, ledgerJournalId: $ledgerJournalId, media: $media, reactions: $reactions, replyTo: $replyTo, readBy: $readBy, forwardedFrom: $forwardedFrom, gift: $gift, tokenSpray: $tokenSpray, groupGift: $groupGift, communityId: $communityId, systemEventType: $systemEventType, systemEventData: $systemEventData, ciphertext: $ciphertext, e2ee: $e2ee, x3dhHeader: $x3dhHeader, createdAt: $createdAt, expiresAt: $expiresAt, actionedAt: $actionedAt, deletedAt: $deletedAt, deletedFor: $deletedFor, deletedForEveryone: $deletedForEveryone)';
}


}

/// @nodoc
abstract mixin class _$MessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(_MessageModel value, $Res Function(_MessageModel) _then) = __$MessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderName, String? senderAvatarUrl, String type, String status, String? textContent, int? tokenAmount, String? recipientId, String? ledgerJournalId, Map<String, dynamic>? media, Map<String, List<String>> reactions, Map<String, dynamic>? replyTo, Map<String, DateTime> readBy, Map<String, dynamic>? forwardedFrom, Map<String, dynamic>? gift, Map<String, dynamic>? tokenSpray, Map<String, dynamic>? groupGift, String? communityId, String? systemEventType, Map<String, dynamic>? systemEventData, String? ciphertext, Map<String, dynamic>? e2ee, Map<String, dynamic>? x3dhHeader, DateTime createdAt, DateTime? expiresAt, DateTime? actionedAt, DateTime? deletedAt, List<String> deletedFor, bool deletedForEveryone
});




}
/// @nodoc
class __$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(this._self, this._then);

  final _MessageModel _self;
  final $Res Function(_MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? senderAvatarUrl = freezed,Object? type = null,Object? status = null,Object? textContent = freezed,Object? tokenAmount = freezed,Object? recipientId = freezed,Object? ledgerJournalId = freezed,Object? media = freezed,Object? reactions = null,Object? replyTo = freezed,Object? readBy = null,Object? forwardedFrom = freezed,Object? gift = freezed,Object? tokenSpray = freezed,Object? groupGift = freezed,Object? communityId = freezed,Object? systemEventType = freezed,Object? systemEventData = freezed,Object? ciphertext = freezed,Object? e2ee = freezed,Object? x3dhHeader = freezed,Object? createdAt = null,Object? expiresAt = freezed,Object? actionedAt = freezed,Object? deletedAt = freezed,Object? deletedFor = null,Object? deletedForEveryone = null,}) {
  return _then(_MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,tokenAmount: freezed == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int?,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,ledgerJournalId: freezed == ledgerJournalId ? _self.ledgerJournalId : ledgerJournalId // ignore: cast_nullable_to_non_nullable
as String?,media: freezed == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,replyTo: freezed == replyTo ? _self._replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,readBy: null == readBy ? _self._readBy : readBy // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,forwardedFrom: freezed == forwardedFrom ? _self._forwardedFrom : forwardedFrom // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,gift: freezed == gift ? _self._gift : gift // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,tokenSpray: freezed == tokenSpray ? _self._tokenSpray : tokenSpray // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,groupGift: freezed == groupGift ? _self._groupGift : groupGift // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,systemEventType: freezed == systemEventType ? _self.systemEventType : systemEventType // ignore: cast_nullable_to_non_nullable
as String?,systemEventData: freezed == systemEventData ? _self._systemEventData : systemEventData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ciphertext: freezed == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String?,e2ee: freezed == e2ee ? _self._e2ee : e2ee // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,x3dhHeader: freezed == x3dhHeader ? _self._x3dhHeader : x3dhHeader // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedFor: null == deletedFor ? _self._deletedFor : deletedFor // ignore: cast_nullable_to_non_nullable
as List<String>,deletedForEveryone: null == deletedForEveryone ? _self.deletedForEveryone : deletedForEveryone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
