// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_pool_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenPoolModel {

 String get id; String get mode; String get status;// Organizer
 String get organizerId; String get organizerName;// Recipient (sasaza only)
 String? get recipientId; String? get recipientName;// Conversation link
 String get conversationId;// Pool content
 String get title; String get purpose; String get message; String get style;// Financial
 int get totalAmount; int get totalDistributed; int get contributionCount; int get contributorCount;// Per-user contributions (raw maps)
 Map<String, Map<String, dynamic>> get contributions;// Payout records (raw maps)
 List<Map<String, dynamic>> get payouts;// Gift delivery references
 String? get giftMessageId; String? get giftConversationId;// Invitees
 List<String> get inviteeIds;// Expiry
 DateTime? get expiresAt;// Timestamps
 DateTime get createdAt; DateTime get updatedAt; DateTime? get sentAt; DateTime? get openedAt; DateTime? get completedAt; DateTime? get cancelledAt;// Ledger reference
 String get groupAccountId;// Notification state
 bool get reminderSent;
/// Create a copy of TokenPoolModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenPoolModelCopyWith<TokenPoolModel> get copyWith => _$TokenPoolModelCopyWithImpl<TokenPoolModel>(this as TokenPoolModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenPoolModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalDistributed, totalDistributed) || other.totalDistributed == totalDistributed)&&(identical(other.contributionCount, contributionCount) || other.contributionCount == contributionCount)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other.contributions, contributions)&&const DeepCollectionEquality().equals(other.payouts, payouts)&&(identical(other.giftMessageId, giftMessageId) || other.giftMessageId == giftMessageId)&&(identical(other.giftConversationId, giftConversationId) || other.giftConversationId == giftConversationId)&&const DeepCollectionEquality().equals(other.inviteeIds, inviteeIds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.groupAccountId, groupAccountId) || other.groupAccountId == groupAccountId)&&(identical(other.reminderSent, reminderSent) || other.reminderSent == reminderSent));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,mode,status,organizerId,organizerName,recipientId,recipientName,conversationId,title,purpose,message,style,totalAmount,totalDistributed,contributionCount,contributorCount,const DeepCollectionEquality().hash(contributions),const DeepCollectionEquality().hash(payouts),giftMessageId,giftConversationId,const DeepCollectionEquality().hash(inviteeIds),expiresAt,createdAt,updatedAt,sentAt,openedAt,completedAt,cancelledAt,groupAccountId,reminderSent]);

@override
String toString() {
  return 'TokenPoolModel(id: $id, mode: $mode, status: $status, organizerId: $organizerId, organizerName: $organizerName, recipientId: $recipientId, recipientName: $recipientName, conversationId: $conversationId, title: $title, purpose: $purpose, message: $message, style: $style, totalAmount: $totalAmount, totalDistributed: $totalDistributed, contributionCount: $contributionCount, contributorCount: $contributorCount, contributions: $contributions, payouts: $payouts, giftMessageId: $giftMessageId, giftConversationId: $giftConversationId, inviteeIds: $inviteeIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, sentAt: $sentAt, openedAt: $openedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, groupAccountId: $groupAccountId, reminderSent: $reminderSent)';
}


}

/// @nodoc
abstract mixin class $TokenPoolModelCopyWith<$Res>  {
  factory $TokenPoolModelCopyWith(TokenPoolModel value, $Res Function(TokenPoolModel) _then) = _$TokenPoolModelCopyWithImpl;
@useResult
$Res call({
 String id, String mode, String status, String organizerId, String organizerName, String? recipientId, String? recipientName, String conversationId, String title, String purpose, String message, String style, int totalAmount, int totalDistributed, int contributionCount, int contributorCount, Map<String, Map<String, dynamic>> contributions, List<Map<String, dynamic>> payouts, String? giftMessageId, String? giftConversationId, List<String> inviteeIds, DateTime? expiresAt, DateTime createdAt, DateTime updatedAt, DateTime? sentAt, DateTime? openedAt, DateTime? completedAt, DateTime? cancelledAt, String groupAccountId, bool reminderSent
});




}
/// @nodoc
class _$TokenPoolModelCopyWithImpl<$Res>
    implements $TokenPoolModelCopyWith<$Res> {
  _$TokenPoolModelCopyWithImpl(this._self, this._then);

  final TokenPoolModel _self;
  final $Res Function(TokenPoolModel) _then;

/// Create a copy of TokenPoolModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mode = null,Object? status = null,Object? organizerId = null,Object? organizerName = null,Object? recipientId = freezed,Object? recipientName = freezed,Object? conversationId = null,Object? title = null,Object? purpose = null,Object? message = null,Object? style = null,Object? totalAmount = null,Object? totalDistributed = null,Object? contributionCount = null,Object? contributorCount = null,Object? contributions = null,Object? payouts = null,Object? giftMessageId = freezed,Object? giftConversationId = freezed,Object? inviteeIds = null,Object? expiresAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? sentAt = freezed,Object? openedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? groupAccountId = null,Object? reminderSent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,totalDistributed: null == totalDistributed ? _self.totalDistributed : totalDistributed // ignore: cast_nullable_to_non_nullable
as int,contributionCount: null == contributionCount ? _self.contributionCount : contributionCount // ignore: cast_nullable_to_non_nullable
as int,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,giftMessageId: freezed == giftMessageId ? _self.giftMessageId : giftMessageId // ignore: cast_nullable_to_non_nullable
as String?,giftConversationId: freezed == giftConversationId ? _self.giftConversationId : giftConversationId // ignore: cast_nullable_to_non_nullable
as String?,inviteeIds: null == inviteeIds ? _self.inviteeIds : inviteeIds // ignore: cast_nullable_to_non_nullable
as List<String>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,groupAccountId: null == groupAccountId ? _self.groupAccountId : groupAccountId // ignore: cast_nullable_to_non_nullable
as String,reminderSent: null == reminderSent ? _self.reminderSent : reminderSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenPoolModel].
extension TokenPoolModelPatterns on TokenPoolModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenPoolModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenPoolModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenPoolModel value)  $default,){
final _that = this;
switch (_that) {
case _TokenPoolModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenPoolModel value)?  $default,){
final _that = this;
switch (_that) {
case _TokenPoolModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mode,  String status,  String organizerId,  String organizerName,  String? recipientId,  String? recipientName,  String conversationId,  String title,  String purpose,  String message,  String style,  int totalAmount,  int totalDistributed,  int contributionCount,  int contributorCount,  Map<String, Map<String, dynamic>> contributions,  List<Map<String, dynamic>> payouts,  String? giftMessageId,  String? giftConversationId,  List<String> inviteeIds,  DateTime? expiresAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? sentAt,  DateTime? openedAt,  DateTime? completedAt,  DateTime? cancelledAt,  String groupAccountId,  bool reminderSent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenPoolModel() when $default != null:
return $default(_that.id,_that.mode,_that.status,_that.organizerId,_that.organizerName,_that.recipientId,_that.recipientName,_that.conversationId,_that.title,_that.purpose,_that.message,_that.style,_that.totalAmount,_that.totalDistributed,_that.contributionCount,_that.contributorCount,_that.contributions,_that.payouts,_that.giftMessageId,_that.giftConversationId,_that.inviteeIds,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.sentAt,_that.openedAt,_that.completedAt,_that.cancelledAt,_that.groupAccountId,_that.reminderSent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mode,  String status,  String organizerId,  String organizerName,  String? recipientId,  String? recipientName,  String conversationId,  String title,  String purpose,  String message,  String style,  int totalAmount,  int totalDistributed,  int contributionCount,  int contributorCount,  Map<String, Map<String, dynamic>> contributions,  List<Map<String, dynamic>> payouts,  String? giftMessageId,  String? giftConversationId,  List<String> inviteeIds,  DateTime? expiresAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? sentAt,  DateTime? openedAt,  DateTime? completedAt,  DateTime? cancelledAt,  String groupAccountId,  bool reminderSent)  $default,) {final _that = this;
switch (_that) {
case _TokenPoolModel():
return $default(_that.id,_that.mode,_that.status,_that.organizerId,_that.organizerName,_that.recipientId,_that.recipientName,_that.conversationId,_that.title,_that.purpose,_that.message,_that.style,_that.totalAmount,_that.totalDistributed,_that.contributionCount,_that.contributorCount,_that.contributions,_that.payouts,_that.giftMessageId,_that.giftConversationId,_that.inviteeIds,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.sentAt,_that.openedAt,_that.completedAt,_that.cancelledAt,_that.groupAccountId,_that.reminderSent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mode,  String status,  String organizerId,  String organizerName,  String? recipientId,  String? recipientName,  String conversationId,  String title,  String purpose,  String message,  String style,  int totalAmount,  int totalDistributed,  int contributionCount,  int contributorCount,  Map<String, Map<String, dynamic>> contributions,  List<Map<String, dynamic>> payouts,  String? giftMessageId,  String? giftConversationId,  List<String> inviteeIds,  DateTime? expiresAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? sentAt,  DateTime? openedAt,  DateTime? completedAt,  DateTime? cancelledAt,  String groupAccountId,  bool reminderSent)?  $default,) {final _that = this;
switch (_that) {
case _TokenPoolModel() when $default != null:
return $default(_that.id,_that.mode,_that.status,_that.organizerId,_that.organizerName,_that.recipientId,_that.recipientName,_that.conversationId,_that.title,_that.purpose,_that.message,_that.style,_that.totalAmount,_that.totalDistributed,_that.contributionCount,_that.contributorCount,_that.contributions,_that.payouts,_that.giftMessageId,_that.giftConversationId,_that.inviteeIds,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.sentAt,_that.openedAt,_that.completedAt,_that.cancelledAt,_that.groupAccountId,_that.reminderSent);case _:
  return null;

}
}

}

/// @nodoc


class _TokenPoolModel extends TokenPoolModel {
  const _TokenPoolModel({required this.id, required this.mode, required this.status, required this.organizerId, required this.organizerName, this.recipientId, this.recipientName, required this.conversationId, required this.title, this.purpose = '', this.message = '', required this.style, this.totalAmount = 0, this.totalDistributed = 0, this.contributionCount = 0, this.contributorCount = 0, final  Map<String, Map<String, dynamic>> contributions = const {}, final  List<Map<String, dynamic>> payouts = const [], this.giftMessageId, this.giftConversationId, final  List<String> inviteeIds = const [], this.expiresAt, required this.createdAt, required this.updatedAt, this.sentAt, this.openedAt, this.completedAt, this.cancelledAt, required this.groupAccountId, this.reminderSent = false}): _contributions = contributions,_payouts = payouts,_inviteeIds = inviteeIds,super._();
  

@override final  String id;
@override final  String mode;
@override final  String status;
// Organizer
@override final  String organizerId;
@override final  String organizerName;
// Recipient (sasaza only)
@override final  String? recipientId;
@override final  String? recipientName;
// Conversation link
@override final  String conversationId;
// Pool content
@override final  String title;
@override@JsonKey() final  String purpose;
@override@JsonKey() final  String message;
@override final  String style;
// Financial
@override@JsonKey() final  int totalAmount;
@override@JsonKey() final  int totalDistributed;
@override@JsonKey() final  int contributionCount;
@override@JsonKey() final  int contributorCount;
// Per-user contributions (raw maps)
 final  Map<String, Map<String, dynamic>> _contributions;
// Per-user contributions (raw maps)
@override@JsonKey() Map<String, Map<String, dynamic>> get contributions {
  if (_contributions is EqualUnmodifiableMapView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contributions);
}

// Payout records (raw maps)
 final  List<Map<String, dynamic>> _payouts;
// Payout records (raw maps)
@override@JsonKey() List<Map<String, dynamic>> get payouts {
  if (_payouts is EqualUnmodifiableListView) return _payouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payouts);
}

// Gift delivery references
@override final  String? giftMessageId;
@override final  String? giftConversationId;
// Invitees
 final  List<String> _inviteeIds;
// Invitees
@override@JsonKey() List<String> get inviteeIds {
  if (_inviteeIds is EqualUnmodifiableListView) return _inviteeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inviteeIds);
}

// Expiry
@override final  DateTime? expiresAt;
// Timestamps
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? sentAt;
@override final  DateTime? openedAt;
@override final  DateTime? completedAt;
@override final  DateTime? cancelledAt;
// Ledger reference
@override final  String groupAccountId;
// Notification state
@override@JsonKey() final  bool reminderSent;

/// Create a copy of TokenPoolModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenPoolModelCopyWith<_TokenPoolModel> get copyWith => __$TokenPoolModelCopyWithImpl<_TokenPoolModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenPoolModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalDistributed, totalDistributed) || other.totalDistributed == totalDistributed)&&(identical(other.contributionCount, contributionCount) || other.contributionCount == contributionCount)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other._contributions, _contributions)&&const DeepCollectionEquality().equals(other._payouts, _payouts)&&(identical(other.giftMessageId, giftMessageId) || other.giftMessageId == giftMessageId)&&(identical(other.giftConversationId, giftConversationId) || other.giftConversationId == giftConversationId)&&const DeepCollectionEquality().equals(other._inviteeIds, _inviteeIds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.groupAccountId, groupAccountId) || other.groupAccountId == groupAccountId)&&(identical(other.reminderSent, reminderSent) || other.reminderSent == reminderSent));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,mode,status,organizerId,organizerName,recipientId,recipientName,conversationId,title,purpose,message,style,totalAmount,totalDistributed,contributionCount,contributorCount,const DeepCollectionEquality().hash(_contributions),const DeepCollectionEquality().hash(_payouts),giftMessageId,giftConversationId,const DeepCollectionEquality().hash(_inviteeIds),expiresAt,createdAt,updatedAt,sentAt,openedAt,completedAt,cancelledAt,groupAccountId,reminderSent]);

@override
String toString() {
  return 'TokenPoolModel(id: $id, mode: $mode, status: $status, organizerId: $organizerId, organizerName: $organizerName, recipientId: $recipientId, recipientName: $recipientName, conversationId: $conversationId, title: $title, purpose: $purpose, message: $message, style: $style, totalAmount: $totalAmount, totalDistributed: $totalDistributed, contributionCount: $contributionCount, contributorCount: $contributorCount, contributions: $contributions, payouts: $payouts, giftMessageId: $giftMessageId, giftConversationId: $giftConversationId, inviteeIds: $inviteeIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, sentAt: $sentAt, openedAt: $openedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, groupAccountId: $groupAccountId, reminderSent: $reminderSent)';
}


}

/// @nodoc
abstract mixin class _$TokenPoolModelCopyWith<$Res> implements $TokenPoolModelCopyWith<$Res> {
  factory _$TokenPoolModelCopyWith(_TokenPoolModel value, $Res Function(_TokenPoolModel) _then) = __$TokenPoolModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String mode, String status, String organizerId, String organizerName, String? recipientId, String? recipientName, String conversationId, String title, String purpose, String message, String style, int totalAmount, int totalDistributed, int contributionCount, int contributorCount, Map<String, Map<String, dynamic>> contributions, List<Map<String, dynamic>> payouts, String? giftMessageId, String? giftConversationId, List<String> inviteeIds, DateTime? expiresAt, DateTime createdAt, DateTime updatedAt, DateTime? sentAt, DateTime? openedAt, DateTime? completedAt, DateTime? cancelledAt, String groupAccountId, bool reminderSent
});




}
/// @nodoc
class __$TokenPoolModelCopyWithImpl<$Res>
    implements _$TokenPoolModelCopyWith<$Res> {
  __$TokenPoolModelCopyWithImpl(this._self, this._then);

  final _TokenPoolModel _self;
  final $Res Function(_TokenPoolModel) _then;

/// Create a copy of TokenPoolModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mode = null,Object? status = null,Object? organizerId = null,Object? organizerName = null,Object? recipientId = freezed,Object? recipientName = freezed,Object? conversationId = null,Object? title = null,Object? purpose = null,Object? message = null,Object? style = null,Object? totalAmount = null,Object? totalDistributed = null,Object? contributionCount = null,Object? contributorCount = null,Object? contributions = null,Object? payouts = null,Object? giftMessageId = freezed,Object? giftConversationId = freezed,Object? inviteeIds = null,Object? expiresAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? sentAt = freezed,Object? openedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? groupAccountId = null,Object? reminderSent = null,}) {
  return _then(_TokenPoolModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,totalDistributed: null == totalDistributed ? _self.totalDistributed : totalDistributed // ignore: cast_nullable_to_non_nullable
as int,contributionCount: null == contributionCount ? _self.contributionCount : contributionCount // ignore: cast_nullable_to_non_nullable
as int,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,payouts: null == payouts ? _self._payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,giftMessageId: freezed == giftMessageId ? _self.giftMessageId : giftMessageId // ignore: cast_nullable_to_non_nullable
as String?,giftConversationId: freezed == giftConversationId ? _self.giftConversationId : giftConversationId // ignore: cast_nullable_to_non_nullable
as String?,inviteeIds: null == inviteeIds ? _self._inviteeIds : inviteeIds // ignore: cast_nullable_to_non_nullable
as List<String>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,groupAccountId: null == groupAccountId ? _self.groupAccountId : groupAccountId // ignore: cast_nullable_to_non_nullable
as String,reminderSent: null == reminderSent ? _self.reminderSent : reminderSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
