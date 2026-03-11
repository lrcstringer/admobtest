// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParticipantInfo {

 String get displayName; String? get avatarUrl;
/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantInfoCopyWith<ParticipantInfo> get copyWith => _$ParticipantInfoCopyWithImpl<ParticipantInfo>(this as ParticipantInfo, _$identity);

  /// Serializes this ParticipantInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantInfo&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,avatarUrl);

@override
String toString() {
  return 'ParticipantInfo(displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $ParticipantInfoCopyWith<$Res>  {
  factory $ParticipantInfoCopyWith(ParticipantInfo value, $Res Function(ParticipantInfo) _then) = _$ParticipantInfoCopyWithImpl;
@useResult
$Res call({
 String displayName, String? avatarUrl
});




}
/// @nodoc
class _$ParticipantInfoCopyWithImpl<$Res>
    implements $ParticipantInfoCopyWith<$Res> {
  _$ParticipantInfoCopyWithImpl(this._self, this._then);

  final ParticipantInfo _self;
  final $Res Function(ParticipantInfo) _then;

/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantInfo].
extension ParticipantInfoPatterns on ParticipantInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantInfo value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
return $default(_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _ParticipantInfo():
return $default(_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
return $default(_that.displayName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParticipantInfo implements ParticipantInfo {
  const _ParticipantInfo({required this.displayName, this.avatarUrl});
  factory _ParticipantInfo.fromJson(Map<String, dynamic> json) => _$ParticipantInfoFromJson(json);

@override final  String displayName;
@override final  String? avatarUrl;

/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantInfoCopyWith<_ParticipantInfo> get copyWith => __$ParticipantInfoCopyWithImpl<_ParticipantInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParticipantInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantInfo&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,avatarUrl);

@override
String toString() {
  return 'ParticipantInfo(displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ParticipantInfoCopyWith<$Res> implements $ParticipantInfoCopyWith<$Res> {
  factory _$ParticipantInfoCopyWith(_ParticipantInfo value, $Res Function(_ParticipantInfo) _then) = __$ParticipantInfoCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String? avatarUrl
});




}
/// @nodoc
class __$ParticipantInfoCopyWithImpl<$Res>
    implements _$ParticipantInfoCopyWith<$Res> {
  __$ParticipantInfoCopyWithImpl(this._self, this._then);

  final _ParticipantInfo _self;
  final $Res Function(_ParticipantInfo) _then;

/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? avatarUrl = freezed,}) {
  return _then(_ParticipantInfo(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Conversation {

 String get id; ConversationType get type; List<String> get participantIds; Map<String, ParticipantInfo> get participants;// Last message preview (for inbox list)
 String? get lastMessageId; String? get lastMessageText; String? get lastMessageSenderId; String? get lastMessageSenderName; String? get lastMessageType; DateTime? get lastMessageAt;// Per-user state
 Map<String, int> get unreadCounts; Map<String, bool> get archived; Map<String, bool> get pinned; Map<String, bool> get muted;// E2EE: per-user encrypted last message previews
 Map<String, String> get lastMessageEncryptedPreviews;// Per-user chat cleared timestamps
 Map<String, DateTime> get chatClearedAt;// Per-user acceptance status (message request system)
 Map<String, bool> get accepted;// E2EE: per-user session reset requested flags
 Map<String, bool> get sessionResetRequested;/// Token pool ID (for collection-type conversations)
 String? get tokenPoolId;/// Pool title (denormalized for collection-type conversations)
 String? get poolTitle;/// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
 String? get poolMode;/// Marketplace listing ID (for marketplace-tagged conversations)
 String? get marketplaceListingId;/// Marketplace listing title (denormalized for display)
 String? get marketplaceListingTitle;/// Marketplace listing thumbnail URL (denormalized for display)
 String? get marketplaceListingThumbnailUrl;/// Marketplace listing price in tokens (denormalized for display)
 int? get marketplaceListingPrice;/// Marketplace order ID (linked after order is placed)
 String? get marketplaceOrderId;/// Disappearing messages duration. Null means off.
 Duration? get disappearingMessagesDuration;// Timestamps
 DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<Conversation> get copyWith => _$ConversationCopyWithImpl<Conversation>(this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.participantIds, participantIds)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other.unreadCounts, unreadCounts)&&const DeepCollectionEquality().equals(other.archived, archived)&&const DeepCollectionEquality().equals(other.pinned, pinned)&&const DeepCollectionEquality().equals(other.muted, muted)&&const DeepCollectionEquality().equals(other.lastMessageEncryptedPreviews, lastMessageEncryptedPreviews)&&const DeepCollectionEquality().equals(other.chatClearedAt, chatClearedAt)&&const DeepCollectionEquality().equals(other.accepted, accepted)&&const DeepCollectionEquality().equals(other.sessionResetRequested, sessionResetRequested)&&(identical(other.tokenPoolId, tokenPoolId) || other.tokenPoolId == tokenPoolId)&&(identical(other.poolTitle, poolTitle) || other.poolTitle == poolTitle)&&(identical(other.poolMode, poolMode) || other.poolMode == poolMode)&&(identical(other.marketplaceListingId, marketplaceListingId) || other.marketplaceListingId == marketplaceListingId)&&(identical(other.marketplaceListingTitle, marketplaceListingTitle) || other.marketplaceListingTitle == marketplaceListingTitle)&&(identical(other.marketplaceListingThumbnailUrl, marketplaceListingThumbnailUrl) || other.marketplaceListingThumbnailUrl == marketplaceListingThumbnailUrl)&&(identical(other.marketplaceListingPrice, marketplaceListingPrice) || other.marketplaceListingPrice == marketplaceListingPrice)&&(identical(other.marketplaceOrderId, marketplaceOrderId) || other.marketplaceOrderId == marketplaceOrderId)&&(identical(other.disappearingMessagesDuration, disappearingMessagesDuration) || other.disappearingMessagesDuration == disappearingMessagesDuration)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,const DeepCollectionEquality().hash(participantIds),const DeepCollectionEquality().hash(participants),lastMessageId,lastMessageText,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(unreadCounts),const DeepCollectionEquality().hash(archived),const DeepCollectionEquality().hash(pinned),const DeepCollectionEquality().hash(muted),const DeepCollectionEquality().hash(lastMessageEncryptedPreviews),const DeepCollectionEquality().hash(chatClearedAt),const DeepCollectionEquality().hash(accepted),const DeepCollectionEquality().hash(sessionResetRequested),tokenPoolId,poolTitle,poolMode,marketplaceListingId,marketplaceListingTitle,marketplaceListingThumbnailUrl,marketplaceListingPrice,marketplaceOrderId,disappearingMessagesDuration,createdAt,updatedAt]);

@override
String toString() {
  return 'Conversation(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessageId: $lastMessageId, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, archived: $archived, pinned: $pinned, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, chatClearedAt: $chatClearedAt, accepted: $accepted, sessionResetRequested: $sessionResetRequested, tokenPoolId: $tokenPoolId, poolTitle: $poolTitle, poolMode: $poolMode, marketplaceListingId: $marketplaceListingId, marketplaceListingTitle: $marketplaceListingTitle, marketplaceListingThumbnailUrl: $marketplaceListingThumbnailUrl, marketplaceListingPrice: $marketplaceListingPrice, marketplaceOrderId: $marketplaceOrderId, disappearingMessagesDuration: $disappearingMessagesDuration, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res>  {
  factory $ConversationCopyWith(Conversation value, $Res Function(Conversation) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 String id, ConversationType type, List<String> participantIds, Map<String, ParticipantInfo> participants, String? lastMessageId, String? lastMessageText, String? lastMessageSenderId, String? lastMessageSenderName, String? lastMessageType, DateTime? lastMessageAt, Map<String, int> unreadCounts, Map<String, bool> archived, Map<String, bool> pinned, Map<String, bool> muted, Map<String, String> lastMessageEncryptedPreviews, Map<String, DateTime> chatClearedAt, Map<String, bool> accepted, Map<String, bool> sessionResetRequested, String? tokenPoolId, String? poolTitle, String? poolMode, String? marketplaceListingId, String? marketplaceListingTitle, String? marketplaceListingThumbnailUrl, int? marketplaceListingPrice, String? marketplaceOrderId, Duration? disappearingMessagesDuration, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ConversationCopyWithImpl<$Res>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? participantIds = null,Object? participants = null,Object? lastMessageId = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = freezed,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = null,Object? archived = null,Object? pinned = null,Object? muted = null,Object? lastMessageEncryptedPreviews = null,Object? chatClearedAt = null,Object? accepted = null,Object? sessionResetRequested = null,Object? tokenPoolId = freezed,Object? poolTitle = freezed,Object? poolMode = freezed,Object? marketplaceListingId = freezed,Object? marketplaceListingTitle = freezed,Object? marketplaceListingThumbnailUrl = freezed,Object? marketplaceListingPrice = freezed,Object? marketplaceOrderId = freezed,Object? disappearingMessagesDuration = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConversationType,participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as Map<String, ParticipantInfo>,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageText: freezed == lastMessageText ? _self.lastMessageText : lastMessageText // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderName: freezed == lastMessageSenderName ? _self.lastMessageSenderName : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
as String?,lastMessageType: freezed == lastMessageType ? _self.lastMessageType : lastMessageType // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCounts: null == unreadCounts ? _self.unreadCounts : unreadCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews ? _self.lastMessageEncryptedPreviews : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
as Map<String, String>,chatClearedAt: null == chatClearedAt ? _self.chatClearedAt : chatClearedAt // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,accepted: null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,sessionResetRequested: null == sessionResetRequested ? _self.sessionResetRequested : sessionResetRequested // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,tokenPoolId: freezed == tokenPoolId ? _self.tokenPoolId : tokenPoolId // ignore: cast_nullable_to_non_nullable
as String?,poolTitle: freezed == poolTitle ? _self.poolTitle : poolTitle // ignore: cast_nullable_to_non_nullable
as String?,poolMode: freezed == poolMode ? _self.poolMode : poolMode // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingId: freezed == marketplaceListingId ? _self.marketplaceListingId : marketplaceListingId // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingTitle: freezed == marketplaceListingTitle ? _self.marketplaceListingTitle : marketplaceListingTitle // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingThumbnailUrl: freezed == marketplaceListingThumbnailUrl ? _self.marketplaceListingThumbnailUrl : marketplaceListingThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingPrice: freezed == marketplaceListingPrice ? _self.marketplaceListingPrice : marketplaceListingPrice // ignore: cast_nullable_to_non_nullable
as int?,marketplaceOrderId: freezed == marketplaceOrderId ? _self.marketplaceOrderId : marketplaceOrderId // ignore: cast_nullable_to_non_nullable
as String?,disappearingMessagesDuration: freezed == disappearingMessagesDuration ? _self.disappearingMessagesDuration : disappearingMessagesDuration // ignore: cast_nullable_to_non_nullable
as Duration?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ConversationType type,  List<String> participantIds,  Map<String, ParticipantInfo> participants,  String? lastMessageId,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType,  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> archived,  Map<String, bool> pinned,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews,  Map<String, DateTime> chatClearedAt,  Map<String, bool> accepted,  Map<String, bool> sessionResetRequested,  String? tokenPoolId,  String? poolTitle,  String? poolMode,  String? marketplaceListingId,  String? marketplaceListingTitle,  String? marketplaceListingThumbnailUrl,  int? marketplaceListingPrice,  String? marketplaceOrderId,  Duration? disappearingMessagesDuration,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.type,_that.participantIds,_that.participants,_that.lastMessageId,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.archived,_that.pinned,_that.muted,_that.lastMessageEncryptedPreviews,_that.chatClearedAt,_that.accepted,_that.sessionResetRequested,_that.tokenPoolId,_that.poolTitle,_that.poolMode,_that.marketplaceListingId,_that.marketplaceListingTitle,_that.marketplaceListingThumbnailUrl,_that.marketplaceListingPrice,_that.marketplaceOrderId,_that.disappearingMessagesDuration,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ConversationType type,  List<String> participantIds,  Map<String, ParticipantInfo> participants,  String? lastMessageId,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType,  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> archived,  Map<String, bool> pinned,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews,  Map<String, DateTime> chatClearedAt,  Map<String, bool> accepted,  Map<String, bool> sessionResetRequested,  String? tokenPoolId,  String? poolTitle,  String? poolMode,  String? marketplaceListingId,  String? marketplaceListingTitle,  String? marketplaceListingThumbnailUrl,  int? marketplaceListingPrice,  String? marketplaceOrderId,  Duration? disappearingMessagesDuration,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.type,_that.participantIds,_that.participants,_that.lastMessageId,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.archived,_that.pinned,_that.muted,_that.lastMessageEncryptedPreviews,_that.chatClearedAt,_that.accepted,_that.sessionResetRequested,_that.tokenPoolId,_that.poolTitle,_that.poolMode,_that.marketplaceListingId,_that.marketplaceListingTitle,_that.marketplaceListingThumbnailUrl,_that.marketplaceListingPrice,_that.marketplaceOrderId,_that.disappearingMessagesDuration,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ConversationType type,  List<String> participantIds,  Map<String, ParticipantInfo> participants,  String? lastMessageId,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType,  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> archived,  Map<String, bool> pinned,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews,  Map<String, DateTime> chatClearedAt,  Map<String, bool> accepted,  Map<String, bool> sessionResetRequested,  String? tokenPoolId,  String? poolTitle,  String? poolMode,  String? marketplaceListingId,  String? marketplaceListingTitle,  String? marketplaceListingThumbnailUrl,  int? marketplaceListingPrice,  String? marketplaceOrderId,  Duration? disappearingMessagesDuration,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.type,_that.participantIds,_that.participants,_that.lastMessageId,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.archived,_that.pinned,_that.muted,_that.lastMessageEncryptedPreviews,_that.chatClearedAt,_that.accepted,_that.sessionResetRequested,_that.tokenPoolId,_that.poolTitle,_that.poolMode,_that.marketplaceListingId,_that.marketplaceListingTitle,_that.marketplaceListingThumbnailUrl,_that.marketplaceListingPrice,_that.marketplaceOrderId,_that.disappearingMessagesDuration,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Conversation extends Conversation {
  const _Conversation({required this.id, required this.type, required final  List<String> participantIds, required final  Map<String, ParticipantInfo> participants, this.lastMessageId, this.lastMessageText, this.lastMessageSenderId, this.lastMessageSenderName, this.lastMessageType, this.lastMessageAt, required final  Map<String, int> unreadCounts, required final  Map<String, bool> archived, required final  Map<String, bool> pinned, required final  Map<String, bool> muted, final  Map<String, String> lastMessageEncryptedPreviews = const {}, final  Map<String, DateTime> chatClearedAt = const {}, final  Map<String, bool> accepted = const {}, final  Map<String, bool> sessionResetRequested = const {}, this.tokenPoolId, this.poolTitle, this.poolMode, this.marketplaceListingId, this.marketplaceListingTitle, this.marketplaceListingThumbnailUrl, this.marketplaceListingPrice, this.marketplaceOrderId, this.disappearingMessagesDuration, required this.createdAt, this.updatedAt}): _participantIds = participantIds,_participants = participants,_unreadCounts = unreadCounts,_archived = archived,_pinned = pinned,_muted = muted,_lastMessageEncryptedPreviews = lastMessageEncryptedPreviews,_chatClearedAt = chatClearedAt,_accepted = accepted,_sessionResetRequested = sessionResetRequested,super._();
  factory _Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

@override final  String id;
@override final  ConversationType type;
 final  List<String> _participantIds;
@override List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}

 final  Map<String, ParticipantInfo> _participants;
@override Map<String, ParticipantInfo> get participants {
  if (_participants is EqualUnmodifiableMapView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_participants);
}

// Last message preview (for inbox list)
@override final  String? lastMessageId;
@override final  String? lastMessageText;
@override final  String? lastMessageSenderId;
@override final  String? lastMessageSenderName;
@override final  String? lastMessageType;
@override final  DateTime? lastMessageAt;
// Per-user state
 final  Map<String, int> _unreadCounts;
// Per-user state
@override Map<String, int> get unreadCounts {
  if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unreadCounts);
}

 final  Map<String, bool> _archived;
@override Map<String, bool> get archived {
  if (_archived is EqualUnmodifiableMapView) return _archived;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_archived);
}

 final  Map<String, bool> _pinned;
@override Map<String, bool> get pinned {
  if (_pinned is EqualUnmodifiableMapView) return _pinned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pinned);
}

 final  Map<String, bool> _muted;
@override Map<String, bool> get muted {
  if (_muted is EqualUnmodifiableMapView) return _muted;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_muted);
}

// E2EE: per-user encrypted last message previews
 final  Map<String, String> _lastMessageEncryptedPreviews;
// E2EE: per-user encrypted last message previews
@override@JsonKey() Map<String, String> get lastMessageEncryptedPreviews {
  if (_lastMessageEncryptedPreviews is EqualUnmodifiableMapView) return _lastMessageEncryptedPreviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastMessageEncryptedPreviews);
}

// Per-user chat cleared timestamps
 final  Map<String, DateTime> _chatClearedAt;
// Per-user chat cleared timestamps
@override@JsonKey() Map<String, DateTime> get chatClearedAt {
  if (_chatClearedAt is EqualUnmodifiableMapView) return _chatClearedAt;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_chatClearedAt);
}

// Per-user acceptance status (message request system)
 final  Map<String, bool> _accepted;
// Per-user acceptance status (message request system)
@override@JsonKey() Map<String, bool> get accepted {
  if (_accepted is EqualUnmodifiableMapView) return _accepted;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_accepted);
}

// E2EE: per-user session reset requested flags
 final  Map<String, bool> _sessionResetRequested;
// E2EE: per-user session reset requested flags
@override@JsonKey() Map<String, bool> get sessionResetRequested {
  if (_sessionResetRequested is EqualUnmodifiableMapView) return _sessionResetRequested;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sessionResetRequested);
}

/// Token pool ID (for collection-type conversations)
@override final  String? tokenPoolId;
/// Pool title (denormalized for collection-type conversations)
@override final  String? poolTitle;
/// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
@override final  String? poolMode;
/// Marketplace listing ID (for marketplace-tagged conversations)
@override final  String? marketplaceListingId;
/// Marketplace listing title (denormalized for display)
@override final  String? marketplaceListingTitle;
/// Marketplace listing thumbnail URL (denormalized for display)
@override final  String? marketplaceListingThumbnailUrl;
/// Marketplace listing price in tokens (denormalized for display)
@override final  int? marketplaceListingPrice;
/// Marketplace order ID (linked after order is placed)
@override final  String? marketplaceOrderId;
/// Disappearing messages duration. Null means off.
@override final  Duration? disappearingMessagesDuration;
// Timestamps
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<_Conversation> get copyWith => __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other._unreadCounts, _unreadCounts)&&const DeepCollectionEquality().equals(other._archived, _archived)&&const DeepCollectionEquality().equals(other._pinned, _pinned)&&const DeepCollectionEquality().equals(other._muted, _muted)&&const DeepCollectionEquality().equals(other._lastMessageEncryptedPreviews, _lastMessageEncryptedPreviews)&&const DeepCollectionEquality().equals(other._chatClearedAt, _chatClearedAt)&&const DeepCollectionEquality().equals(other._accepted, _accepted)&&const DeepCollectionEquality().equals(other._sessionResetRequested, _sessionResetRequested)&&(identical(other.tokenPoolId, tokenPoolId) || other.tokenPoolId == tokenPoolId)&&(identical(other.poolTitle, poolTitle) || other.poolTitle == poolTitle)&&(identical(other.poolMode, poolMode) || other.poolMode == poolMode)&&(identical(other.marketplaceListingId, marketplaceListingId) || other.marketplaceListingId == marketplaceListingId)&&(identical(other.marketplaceListingTitle, marketplaceListingTitle) || other.marketplaceListingTitle == marketplaceListingTitle)&&(identical(other.marketplaceListingThumbnailUrl, marketplaceListingThumbnailUrl) || other.marketplaceListingThumbnailUrl == marketplaceListingThumbnailUrl)&&(identical(other.marketplaceListingPrice, marketplaceListingPrice) || other.marketplaceListingPrice == marketplaceListingPrice)&&(identical(other.marketplaceOrderId, marketplaceOrderId) || other.marketplaceOrderId == marketplaceOrderId)&&(identical(other.disappearingMessagesDuration, disappearingMessagesDuration) || other.disappearingMessagesDuration == disappearingMessagesDuration)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,const DeepCollectionEquality().hash(_participantIds),const DeepCollectionEquality().hash(_participants),lastMessageId,lastMessageText,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(_unreadCounts),const DeepCollectionEquality().hash(_archived),const DeepCollectionEquality().hash(_pinned),const DeepCollectionEquality().hash(_muted),const DeepCollectionEquality().hash(_lastMessageEncryptedPreviews),const DeepCollectionEquality().hash(_chatClearedAt),const DeepCollectionEquality().hash(_accepted),const DeepCollectionEquality().hash(_sessionResetRequested),tokenPoolId,poolTitle,poolMode,marketplaceListingId,marketplaceListingTitle,marketplaceListingThumbnailUrl,marketplaceListingPrice,marketplaceOrderId,disappearingMessagesDuration,createdAt,updatedAt]);

@override
String toString() {
  return 'Conversation(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessageId: $lastMessageId, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, archived: $archived, pinned: $pinned, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, chatClearedAt: $chatClearedAt, accepted: $accepted, sessionResetRequested: $sessionResetRequested, tokenPoolId: $tokenPoolId, poolTitle: $poolTitle, poolMode: $poolMode, marketplaceListingId: $marketplaceListingId, marketplaceListingTitle: $marketplaceListingTitle, marketplaceListingThumbnailUrl: $marketplaceListingThumbnailUrl, marketplaceListingPrice: $marketplaceListingPrice, marketplaceOrderId: $marketplaceOrderId, disappearingMessagesDuration: $disappearingMessagesDuration, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res> implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(_Conversation value, $Res Function(_Conversation) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 String id, ConversationType type, List<String> participantIds, Map<String, ParticipantInfo> participants, String? lastMessageId, String? lastMessageText, String? lastMessageSenderId, String? lastMessageSenderName, String? lastMessageType, DateTime? lastMessageAt, Map<String, int> unreadCounts, Map<String, bool> archived, Map<String, bool> pinned, Map<String, bool> muted, Map<String, String> lastMessageEncryptedPreviews, Map<String, DateTime> chatClearedAt, Map<String, bool> accepted, Map<String, bool> sessionResetRequested, String? tokenPoolId, String? poolTitle, String? poolMode, String? marketplaceListingId, String? marketplaceListingTitle, String? marketplaceListingThumbnailUrl, int? marketplaceListingPrice, String? marketplaceOrderId, Duration? disappearingMessagesDuration, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? participantIds = null,Object? participants = null,Object? lastMessageId = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = freezed,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = null,Object? archived = null,Object? pinned = null,Object? muted = null,Object? lastMessageEncryptedPreviews = null,Object? chatClearedAt = null,Object? accepted = null,Object? sessionResetRequested = null,Object? tokenPoolId = freezed,Object? poolTitle = freezed,Object? poolMode = freezed,Object? marketplaceListingId = freezed,Object? marketplaceListingTitle = freezed,Object? marketplaceListingThumbnailUrl = freezed,Object? marketplaceListingPrice = freezed,Object? marketplaceOrderId = freezed,Object? disappearingMessagesDuration = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConversationType,participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as Map<String, ParticipantInfo>,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageText: freezed == lastMessageText ? _self.lastMessageText : lastMessageText // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderName: freezed == lastMessageSenderName ? _self.lastMessageSenderName : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
as String?,lastMessageType: freezed == lastMessageType ? _self.lastMessageType : lastMessageType // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCounts: null == unreadCounts ? _self._unreadCounts : unreadCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,archived: null == archived ? _self._archived : archived // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,pinned: null == pinned ? _self._pinned : pinned // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,muted: null == muted ? _self._muted : muted // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews ? _self._lastMessageEncryptedPreviews : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
as Map<String, String>,chatClearedAt: null == chatClearedAt ? _self._chatClearedAt : chatClearedAt // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,accepted: null == accepted ? _self._accepted : accepted // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,sessionResetRequested: null == sessionResetRequested ? _self._sessionResetRequested : sessionResetRequested // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,tokenPoolId: freezed == tokenPoolId ? _self.tokenPoolId : tokenPoolId // ignore: cast_nullable_to_non_nullable
as String?,poolTitle: freezed == poolTitle ? _self.poolTitle : poolTitle // ignore: cast_nullable_to_non_nullable
as String?,poolMode: freezed == poolMode ? _self.poolMode : poolMode // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingId: freezed == marketplaceListingId ? _self.marketplaceListingId : marketplaceListingId // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingTitle: freezed == marketplaceListingTitle ? _self.marketplaceListingTitle : marketplaceListingTitle // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingThumbnailUrl: freezed == marketplaceListingThumbnailUrl ? _self.marketplaceListingThumbnailUrl : marketplaceListingThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,marketplaceListingPrice: freezed == marketplaceListingPrice ? _self.marketplaceListingPrice : marketplaceListingPrice // ignore: cast_nullable_to_non_nullable
as int?,marketplaceOrderId: freezed == marketplaceOrderId ? _self.marketplaceOrderId : marketplaceOrderId // ignore: cast_nullable_to_non_nullable
as String?,disappearingMessagesDuration: freezed == disappearingMessagesDuration ? _self.disappearingMessagesDuration : disappearingMessagesDuration // ignore: cast_nullable_to_non_nullable
as Duration?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
