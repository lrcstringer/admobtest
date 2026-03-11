// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationModel {

 String get id; String get type; List<String> get participantIds; Map<String, Map<String, dynamic>> get participants;// Last message preview
 String? get lastMessageId; String? get lastMessageText; String? get lastMessageSenderId; String? get lastMessageSenderName; String? get lastMessageType; DateTime? get lastMessageAt;// Per-user state maps
 Map<String, int> get unreadCounts; Map<String, bool> get archived; Map<String, bool> get pinned; Map<String, bool> get muted;// E2EE: per-user encrypted last message previews
 Map<String, String> get lastMessageEncryptedPreviews;// Per-user chat cleared timestamps
 Map<String, DateTime> get chatClearedAt;// Per-user acceptance status (message request system)
 Map<String, bool> get accepted;// E2EE: per-user session reset requested flags
 Map<String, bool> get sessionResetRequested;// Token pool back-reference (for collection-type conversations)
 String? get tokenPoolId;// Pool title (denormalized for collection-type conversations)
 String? get poolTitle;// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
 String? get poolMode;// Marketplace back-reference (for marketplace-tagged conversations)
 String? get marketplaceListingId; String? get marketplaceListingTitle; String? get marketplaceListingThumbnailUrl; int? get marketplaceListingPrice; String? get marketplaceOrderId;// Disappearing messages duration in milliseconds (null = off)
 int? get disappearingMessagesDurationMs;// Timestamps
 DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of ConversationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationModelCopyWith<ConversationModel> get copyWith => _$ConversationModelCopyWithImpl<ConversationModel>(this as ConversationModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.participantIds, participantIds)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other.unreadCounts, unreadCounts)&&const DeepCollectionEquality().equals(other.archived, archived)&&const DeepCollectionEquality().equals(other.pinned, pinned)&&const DeepCollectionEquality().equals(other.muted, muted)&&const DeepCollectionEquality().equals(other.lastMessageEncryptedPreviews, lastMessageEncryptedPreviews)&&const DeepCollectionEquality().equals(other.chatClearedAt, chatClearedAt)&&const DeepCollectionEquality().equals(other.accepted, accepted)&&const DeepCollectionEquality().equals(other.sessionResetRequested, sessionResetRequested)&&(identical(other.tokenPoolId, tokenPoolId) || other.tokenPoolId == tokenPoolId)&&(identical(other.poolTitle, poolTitle) || other.poolTitle == poolTitle)&&(identical(other.poolMode, poolMode) || other.poolMode == poolMode)&&(identical(other.marketplaceListingId, marketplaceListingId) || other.marketplaceListingId == marketplaceListingId)&&(identical(other.marketplaceListingTitle, marketplaceListingTitle) || other.marketplaceListingTitle == marketplaceListingTitle)&&(identical(other.marketplaceListingThumbnailUrl, marketplaceListingThumbnailUrl) || other.marketplaceListingThumbnailUrl == marketplaceListingThumbnailUrl)&&(identical(other.marketplaceListingPrice, marketplaceListingPrice) || other.marketplaceListingPrice == marketplaceListingPrice)&&(identical(other.marketplaceOrderId, marketplaceOrderId) || other.marketplaceOrderId == marketplaceOrderId)&&(identical(other.disappearingMessagesDurationMs, disappearingMessagesDurationMs) || other.disappearingMessagesDurationMs == disappearingMessagesDurationMs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,type,const DeepCollectionEquality().hash(participantIds),const DeepCollectionEquality().hash(participants),lastMessageId,lastMessageText,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(unreadCounts),const DeepCollectionEquality().hash(archived),const DeepCollectionEquality().hash(pinned),const DeepCollectionEquality().hash(muted),const DeepCollectionEquality().hash(lastMessageEncryptedPreviews),const DeepCollectionEquality().hash(chatClearedAt),const DeepCollectionEquality().hash(accepted),const DeepCollectionEquality().hash(sessionResetRequested),tokenPoolId,poolTitle,poolMode,marketplaceListingId,marketplaceListingTitle,marketplaceListingThumbnailUrl,marketplaceListingPrice,marketplaceOrderId,disappearingMessagesDurationMs,createdAt,updatedAt]);

@override
String toString() {
  return 'ConversationModel(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessageId: $lastMessageId, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, archived: $archived, pinned: $pinned, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, chatClearedAt: $chatClearedAt, accepted: $accepted, sessionResetRequested: $sessionResetRequested, tokenPoolId: $tokenPoolId, poolTitle: $poolTitle, poolMode: $poolMode, marketplaceListingId: $marketplaceListingId, marketplaceListingTitle: $marketplaceListingTitle, marketplaceListingThumbnailUrl: $marketplaceListingThumbnailUrl, marketplaceListingPrice: $marketplaceListingPrice, marketplaceOrderId: $marketplaceOrderId, disappearingMessagesDurationMs: $disappearingMessagesDurationMs, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ConversationModelCopyWith<$Res>  {
  factory $ConversationModelCopyWith(ConversationModel value, $Res Function(ConversationModel) _then) = _$ConversationModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, List<String> participantIds, Map<String, Map<String, dynamic>> participants, String? lastMessageId, String? lastMessageText, String? lastMessageSenderId, String? lastMessageSenderName, String? lastMessageType, DateTime? lastMessageAt, Map<String, int> unreadCounts, Map<String, bool> archived, Map<String, bool> pinned, Map<String, bool> muted, Map<String, String> lastMessageEncryptedPreviews, Map<String, DateTime> chatClearedAt, Map<String, bool> accepted, Map<String, bool> sessionResetRequested, String? tokenPoolId, String? poolTitle, String? poolMode, String? marketplaceListingId, String? marketplaceListingTitle, String? marketplaceListingThumbnailUrl, int? marketplaceListingPrice, String? marketplaceOrderId, int? disappearingMessagesDurationMs, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ConversationModelCopyWithImpl<$Res>
    implements $ConversationModelCopyWith<$Res> {
  _$ConversationModelCopyWithImpl(this._self, this._then);

  final ConversationModel _self;
  final $Res Function(ConversationModel) _then;

/// Create a copy of ConversationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? participantIds = null,Object? participants = null,Object? lastMessageId = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = freezed,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = null,Object? archived = null,Object? pinned = null,Object? muted = null,Object? lastMessageEncryptedPreviews = null,Object? chatClearedAt = null,Object? accepted = null,Object? sessionResetRequested = null,Object? tokenPoolId = freezed,Object? poolTitle = freezed,Object? poolMode = freezed,Object? marketplaceListingId = freezed,Object? marketplaceListingTitle = freezed,Object? marketplaceListingThumbnailUrl = freezed,Object? marketplaceListingPrice = freezed,Object? marketplaceOrderId = freezed,Object? disappearingMessagesDurationMs = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
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
as String?,disappearingMessagesDurationMs: freezed == disappearingMessagesDurationMs ? _self.disappearingMessagesDurationMs : disappearingMessagesDurationMs // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationModel].
extension ConversationModelPatterns on ConversationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationModel value)  $default,){
final _that = this;
switch (_that) {
case _ConversationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  List<String> participantIds,  Map<String, Map<String, dynamic>> participants,  String? lastMessageId,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType,  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> archived,  Map<String, bool> pinned,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews,  Map<String, DateTime> chatClearedAt,  Map<String, bool> accepted,  Map<String, bool> sessionResetRequested,  String? tokenPoolId,  String? poolTitle,  String? poolMode,  String? marketplaceListingId,  String? marketplaceListingTitle,  String? marketplaceListingThumbnailUrl,  int? marketplaceListingPrice,  String? marketplaceOrderId,  int? disappearingMessagesDurationMs,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationModel() when $default != null:
return $default(_that.id,_that.type,_that.participantIds,_that.participants,_that.lastMessageId,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.archived,_that.pinned,_that.muted,_that.lastMessageEncryptedPreviews,_that.chatClearedAt,_that.accepted,_that.sessionResetRequested,_that.tokenPoolId,_that.poolTitle,_that.poolMode,_that.marketplaceListingId,_that.marketplaceListingTitle,_that.marketplaceListingThumbnailUrl,_that.marketplaceListingPrice,_that.marketplaceOrderId,_that.disappearingMessagesDurationMs,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  List<String> participantIds,  Map<String, Map<String, dynamic>> participants,  String? lastMessageId,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType,  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> archived,  Map<String, bool> pinned,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews,  Map<String, DateTime> chatClearedAt,  Map<String, bool> accepted,  Map<String, bool> sessionResetRequested,  String? tokenPoolId,  String? poolTitle,  String? poolMode,  String? marketplaceListingId,  String? marketplaceListingTitle,  String? marketplaceListingThumbnailUrl,  int? marketplaceListingPrice,  String? marketplaceOrderId,  int? disappearingMessagesDurationMs,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ConversationModel():
return $default(_that.id,_that.type,_that.participantIds,_that.participants,_that.lastMessageId,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.archived,_that.pinned,_that.muted,_that.lastMessageEncryptedPreviews,_that.chatClearedAt,_that.accepted,_that.sessionResetRequested,_that.tokenPoolId,_that.poolTitle,_that.poolMode,_that.marketplaceListingId,_that.marketplaceListingTitle,_that.marketplaceListingThumbnailUrl,_that.marketplaceListingPrice,_that.marketplaceOrderId,_that.disappearingMessagesDurationMs,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  List<String> participantIds,  Map<String, Map<String, dynamic>> participants,  String? lastMessageId,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType,  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> archived,  Map<String, bool> pinned,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews,  Map<String, DateTime> chatClearedAt,  Map<String, bool> accepted,  Map<String, bool> sessionResetRequested,  String? tokenPoolId,  String? poolTitle,  String? poolMode,  String? marketplaceListingId,  String? marketplaceListingTitle,  String? marketplaceListingThumbnailUrl,  int? marketplaceListingPrice,  String? marketplaceOrderId,  int? disappearingMessagesDurationMs,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ConversationModel() when $default != null:
return $default(_that.id,_that.type,_that.participantIds,_that.participants,_that.lastMessageId,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.archived,_that.pinned,_that.muted,_that.lastMessageEncryptedPreviews,_that.chatClearedAt,_that.accepted,_that.sessionResetRequested,_that.tokenPoolId,_that.poolTitle,_that.poolMode,_that.marketplaceListingId,_that.marketplaceListingTitle,_that.marketplaceListingThumbnailUrl,_that.marketplaceListingPrice,_that.marketplaceOrderId,_that.disappearingMessagesDurationMs,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationModel extends ConversationModel {
  const _ConversationModel({required this.id, required this.type, required final  List<String> participantIds, required final  Map<String, Map<String, dynamic>> participants, this.lastMessageId, this.lastMessageText, this.lastMessageSenderId, this.lastMessageSenderName, this.lastMessageType, this.lastMessageAt, required final  Map<String, int> unreadCounts, required final  Map<String, bool> archived, required final  Map<String, bool> pinned, required final  Map<String, bool> muted, final  Map<String, String> lastMessageEncryptedPreviews = const {}, final  Map<String, DateTime> chatClearedAt = const {}, final  Map<String, bool> accepted = const {}, final  Map<String, bool> sessionResetRequested = const {}, this.tokenPoolId, this.poolTitle, this.poolMode, this.marketplaceListingId, this.marketplaceListingTitle, this.marketplaceListingThumbnailUrl, this.marketplaceListingPrice, this.marketplaceOrderId, this.disappearingMessagesDurationMs, required this.createdAt, this.updatedAt}): _participantIds = participantIds,_participants = participants,_unreadCounts = unreadCounts,_archived = archived,_pinned = pinned,_muted = muted,_lastMessageEncryptedPreviews = lastMessageEncryptedPreviews,_chatClearedAt = chatClearedAt,_accepted = accepted,_sessionResetRequested = sessionResetRequested,super._();
  

@override final  String id;
@override final  String type;
 final  List<String> _participantIds;
@override List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}

 final  Map<String, Map<String, dynamic>> _participants;
@override Map<String, Map<String, dynamic>> get participants {
  if (_participants is EqualUnmodifiableMapView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_participants);
}

// Last message preview
@override final  String? lastMessageId;
@override final  String? lastMessageText;
@override final  String? lastMessageSenderId;
@override final  String? lastMessageSenderName;
@override final  String? lastMessageType;
@override final  DateTime? lastMessageAt;
// Per-user state maps
 final  Map<String, int> _unreadCounts;
// Per-user state maps
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

// Token pool back-reference (for collection-type conversations)
@override final  String? tokenPoolId;
// Pool title (denormalized for collection-type conversations)
@override final  String? poolTitle;
// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
@override final  String? poolMode;
// Marketplace back-reference (for marketplace-tagged conversations)
@override final  String? marketplaceListingId;
@override final  String? marketplaceListingTitle;
@override final  String? marketplaceListingThumbnailUrl;
@override final  int? marketplaceListingPrice;
@override final  String? marketplaceOrderId;
// Disappearing messages duration in milliseconds (null = off)
@override final  int? disappearingMessagesDurationMs;
// Timestamps
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ConversationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationModelCopyWith<_ConversationModel> get copyWith => __$ConversationModelCopyWithImpl<_ConversationModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other._unreadCounts, _unreadCounts)&&const DeepCollectionEquality().equals(other._archived, _archived)&&const DeepCollectionEquality().equals(other._pinned, _pinned)&&const DeepCollectionEquality().equals(other._muted, _muted)&&const DeepCollectionEquality().equals(other._lastMessageEncryptedPreviews, _lastMessageEncryptedPreviews)&&const DeepCollectionEquality().equals(other._chatClearedAt, _chatClearedAt)&&const DeepCollectionEquality().equals(other._accepted, _accepted)&&const DeepCollectionEquality().equals(other._sessionResetRequested, _sessionResetRequested)&&(identical(other.tokenPoolId, tokenPoolId) || other.tokenPoolId == tokenPoolId)&&(identical(other.poolTitle, poolTitle) || other.poolTitle == poolTitle)&&(identical(other.poolMode, poolMode) || other.poolMode == poolMode)&&(identical(other.marketplaceListingId, marketplaceListingId) || other.marketplaceListingId == marketplaceListingId)&&(identical(other.marketplaceListingTitle, marketplaceListingTitle) || other.marketplaceListingTitle == marketplaceListingTitle)&&(identical(other.marketplaceListingThumbnailUrl, marketplaceListingThumbnailUrl) || other.marketplaceListingThumbnailUrl == marketplaceListingThumbnailUrl)&&(identical(other.marketplaceListingPrice, marketplaceListingPrice) || other.marketplaceListingPrice == marketplaceListingPrice)&&(identical(other.marketplaceOrderId, marketplaceOrderId) || other.marketplaceOrderId == marketplaceOrderId)&&(identical(other.disappearingMessagesDurationMs, disappearingMessagesDurationMs) || other.disappearingMessagesDurationMs == disappearingMessagesDurationMs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,type,const DeepCollectionEquality().hash(_participantIds),const DeepCollectionEquality().hash(_participants),lastMessageId,lastMessageText,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(_unreadCounts),const DeepCollectionEquality().hash(_archived),const DeepCollectionEquality().hash(_pinned),const DeepCollectionEquality().hash(_muted),const DeepCollectionEquality().hash(_lastMessageEncryptedPreviews),const DeepCollectionEquality().hash(_chatClearedAt),const DeepCollectionEquality().hash(_accepted),const DeepCollectionEquality().hash(_sessionResetRequested),tokenPoolId,poolTitle,poolMode,marketplaceListingId,marketplaceListingTitle,marketplaceListingThumbnailUrl,marketplaceListingPrice,marketplaceOrderId,disappearingMessagesDurationMs,createdAt,updatedAt]);

@override
String toString() {
  return 'ConversationModel(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessageId: $lastMessageId, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, archived: $archived, pinned: $pinned, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, chatClearedAt: $chatClearedAt, accepted: $accepted, sessionResetRequested: $sessionResetRequested, tokenPoolId: $tokenPoolId, poolTitle: $poolTitle, poolMode: $poolMode, marketplaceListingId: $marketplaceListingId, marketplaceListingTitle: $marketplaceListingTitle, marketplaceListingThumbnailUrl: $marketplaceListingThumbnailUrl, marketplaceListingPrice: $marketplaceListingPrice, marketplaceOrderId: $marketplaceOrderId, disappearingMessagesDurationMs: $disappearingMessagesDurationMs, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ConversationModelCopyWith<$Res> implements $ConversationModelCopyWith<$Res> {
  factory _$ConversationModelCopyWith(_ConversationModel value, $Res Function(_ConversationModel) _then) = __$ConversationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, List<String> participantIds, Map<String, Map<String, dynamic>> participants, String? lastMessageId, String? lastMessageText, String? lastMessageSenderId, String? lastMessageSenderName, String? lastMessageType, DateTime? lastMessageAt, Map<String, int> unreadCounts, Map<String, bool> archived, Map<String, bool> pinned, Map<String, bool> muted, Map<String, String> lastMessageEncryptedPreviews, Map<String, DateTime> chatClearedAt, Map<String, bool> accepted, Map<String, bool> sessionResetRequested, String? tokenPoolId, String? poolTitle, String? poolMode, String? marketplaceListingId, String? marketplaceListingTitle, String? marketplaceListingThumbnailUrl, int? marketplaceListingPrice, String? marketplaceOrderId, int? disappearingMessagesDurationMs, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ConversationModelCopyWithImpl<$Res>
    implements _$ConversationModelCopyWith<$Res> {
  __$ConversationModelCopyWithImpl(this._self, this._then);

  final _ConversationModel _self;
  final $Res Function(_ConversationModel) _then;

/// Create a copy of ConversationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? participantIds = null,Object? participants = null,Object? lastMessageId = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = freezed,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = null,Object? archived = null,Object? pinned = null,Object? muted = null,Object? lastMessageEncryptedPreviews = null,Object? chatClearedAt = null,Object? accepted = null,Object? sessionResetRequested = null,Object? tokenPoolId = freezed,Object? poolTitle = freezed,Object? poolMode = freezed,Object? marketplaceListingId = freezed,Object? marketplaceListingTitle = freezed,Object? marketplaceListingThumbnailUrl = freezed,Object? marketplaceListingPrice = freezed,Object? marketplaceOrderId = freezed,Object? disappearingMessagesDurationMs = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_ConversationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
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
as String?,disappearingMessagesDurationMs: freezed == disappearingMessagesDurationMs ? _self.disappearingMessagesDurationMs : disappearingMessagesDurationMs // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
