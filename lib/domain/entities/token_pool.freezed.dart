// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PoolContribution {

 String get userId; String get displayName; int get totalAmount; int get contributionCount; bool get anonymous; DateTime get lastContributedAt;
/// Create a copy of PoolContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoolContributionCopyWith<PoolContribution> get copyWith => _$PoolContributionCopyWithImpl<PoolContribution>(this as PoolContribution, _$identity);

  /// Serializes this PoolContribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoolContribution&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.contributionCount, contributionCount) || other.contributionCount == contributionCount)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.lastContributedAt, lastContributedAt) || other.lastContributedAt == lastContributedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,totalAmount,contributionCount,anonymous,lastContributedAt);

@override
String toString() {
  return 'PoolContribution(userId: $userId, displayName: $displayName, totalAmount: $totalAmount, contributionCount: $contributionCount, anonymous: $anonymous, lastContributedAt: $lastContributedAt)';
}


}

/// @nodoc
abstract mixin class $PoolContributionCopyWith<$Res>  {
  factory $PoolContributionCopyWith(PoolContribution value, $Res Function(PoolContribution) _then) = _$PoolContributionCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, int totalAmount, int contributionCount, bool anonymous, DateTime lastContributedAt
});




}
/// @nodoc
class _$PoolContributionCopyWithImpl<$Res>
    implements $PoolContributionCopyWith<$Res> {
  _$PoolContributionCopyWithImpl(this._self, this._then);

  final PoolContribution _self;
  final $Res Function(PoolContribution) _then;

/// Create a copy of PoolContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? totalAmount = null,Object? contributionCount = null,Object? anonymous = null,Object? lastContributedAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,contributionCount: null == contributionCount ? _self.contributionCount : contributionCount // ignore: cast_nullable_to_non_nullable
as int,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,lastContributedAt: null == lastContributedAt ? _self.lastContributedAt : lastContributedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PoolContribution].
extension PoolContributionPatterns on PoolContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoolContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoolContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoolContribution value)  $default,){
final _that = this;
switch (_that) {
case _PoolContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoolContribution value)?  $default,){
final _that = this;
switch (_that) {
case _PoolContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  int totalAmount,  int contributionCount,  bool anonymous,  DateTime lastContributedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoolContribution() when $default != null:
return $default(_that.userId,_that.displayName,_that.totalAmount,_that.contributionCount,_that.anonymous,_that.lastContributedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  int totalAmount,  int contributionCount,  bool anonymous,  DateTime lastContributedAt)  $default,) {final _that = this;
switch (_that) {
case _PoolContribution():
return $default(_that.userId,_that.displayName,_that.totalAmount,_that.contributionCount,_that.anonymous,_that.lastContributedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  int totalAmount,  int contributionCount,  bool anonymous,  DateTime lastContributedAt)?  $default,) {final _that = this;
switch (_that) {
case _PoolContribution() when $default != null:
return $default(_that.userId,_that.displayName,_that.totalAmount,_that.contributionCount,_that.anonymous,_that.lastContributedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PoolContribution implements PoolContribution {
  const _PoolContribution({required this.userId, required this.displayName, required this.totalAmount, required this.contributionCount, required this.anonymous, required this.lastContributedAt});
  factory _PoolContribution.fromJson(Map<String, dynamic> json) => _$PoolContributionFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  int totalAmount;
@override final  int contributionCount;
@override final  bool anonymous;
@override final  DateTime lastContributedAt;

/// Create a copy of PoolContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoolContributionCopyWith<_PoolContribution> get copyWith => __$PoolContributionCopyWithImpl<_PoolContribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoolContributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoolContribution&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.contributionCount, contributionCount) || other.contributionCount == contributionCount)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.lastContributedAt, lastContributedAt) || other.lastContributedAt == lastContributedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,totalAmount,contributionCount,anonymous,lastContributedAt);

@override
String toString() {
  return 'PoolContribution(userId: $userId, displayName: $displayName, totalAmount: $totalAmount, contributionCount: $contributionCount, anonymous: $anonymous, lastContributedAt: $lastContributedAt)';
}


}

/// @nodoc
abstract mixin class _$PoolContributionCopyWith<$Res> implements $PoolContributionCopyWith<$Res> {
  factory _$PoolContributionCopyWith(_PoolContribution value, $Res Function(_PoolContribution) _then) = __$PoolContributionCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, int totalAmount, int contributionCount, bool anonymous, DateTime lastContributedAt
});




}
/// @nodoc
class __$PoolContributionCopyWithImpl<$Res>
    implements _$PoolContributionCopyWith<$Res> {
  __$PoolContributionCopyWithImpl(this._self, this._then);

  final _PoolContribution _self;
  final $Res Function(_PoolContribution) _then;

/// Create a copy of PoolContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? totalAmount = null,Object? contributionCount = null,Object? anonymous = null,Object? lastContributedAt = null,}) {
  return _then(_PoolContribution(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,contributionCount: null == contributionCount ? _self.contributionCount : contributionCount // ignore: cast_nullable_to_non_nullable
as int,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,lastContributedAt: null == lastContributedAt ? _self.lastContributedAt : lastContributedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PoolPayout {

 String get userId; String get displayName; int get amount;
/// Create a copy of PoolPayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoolPayoutCopyWith<PoolPayout> get copyWith => _$PoolPayoutCopyWithImpl<PoolPayout>(this as PoolPayout, _$identity);

  /// Serializes this PoolPayout to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoolPayout&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,amount);

@override
String toString() {
  return 'PoolPayout(userId: $userId, displayName: $displayName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PoolPayoutCopyWith<$Res>  {
  factory $PoolPayoutCopyWith(PoolPayout value, $Res Function(PoolPayout) _then) = _$PoolPayoutCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, int amount
});




}
/// @nodoc
class _$PoolPayoutCopyWithImpl<$Res>
    implements $PoolPayoutCopyWith<$Res> {
  _$PoolPayoutCopyWithImpl(this._self, this._then);

  final PoolPayout _self;
  final $Res Function(PoolPayout) _then;

/// Create a copy of PoolPayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? amount = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PoolPayout].
extension PoolPayoutPatterns on PoolPayout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoolPayout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoolPayout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoolPayout value)  $default,){
final _that = this;
switch (_that) {
case _PoolPayout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoolPayout value)?  $default,){
final _that = this;
switch (_that) {
case _PoolPayout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoolPayout() when $default != null:
return $default(_that.userId,_that.displayName,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  int amount)  $default,) {final _that = this;
switch (_that) {
case _PoolPayout():
return $default(_that.userId,_that.displayName,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  int amount)?  $default,) {final _that = this;
switch (_that) {
case _PoolPayout() when $default != null:
return $default(_that.userId,_that.displayName,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PoolPayout implements PoolPayout {
  const _PoolPayout({required this.userId, required this.displayName, required this.amount});
  factory _PoolPayout.fromJson(Map<String, dynamic> json) => _$PoolPayoutFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  int amount;

/// Create a copy of PoolPayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoolPayoutCopyWith<_PoolPayout> get copyWith => __$PoolPayoutCopyWithImpl<_PoolPayout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoolPayoutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoolPayout&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,amount);

@override
String toString() {
  return 'PoolPayout(userId: $userId, displayName: $displayName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$PoolPayoutCopyWith<$Res> implements $PoolPayoutCopyWith<$Res> {
  factory _$PoolPayoutCopyWith(_PoolPayout value, $Res Function(_PoolPayout) _then) = __$PoolPayoutCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, int amount
});




}
/// @nodoc
class __$PoolPayoutCopyWithImpl<$Res>
    implements _$PoolPayoutCopyWith<$Res> {
  __$PoolPayoutCopyWithImpl(this._self, this._then);

  final _PoolPayout _self;
  final $Res Function(_PoolPayout) _then;

/// Create a copy of PoolPayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? amount = null,}) {
  return _then(_PoolPayout(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TokenPool {

 String get id; PoolMode get mode; PoolStatus get status;// Organizer
 String get organizerId; String get organizerName;// Recipient (sasaza mode only)
 String? get recipientId; String? get recipientName;// Conversation link
 String get conversationId;// Pool content
 String get title; String get purpose; String get message; GiftStyle get style;// Financial summary
 int get totalAmount; int get totalDistributed; int get contributionCount; int get contributorCount;// Per-user contributions
 Map<String, PoolContribution> get contributions;// Payout records (populated on distribute)
 List<PoolPayout> get payouts;// Gift delivery references (sasaza mode, after send)
 String? get giftMessageId; String? get giftConversationId;// Invitees
 List<String> get inviteeIds;// Expiry
 DateTime? get expiresAt;// Timestamps
 DateTime get createdAt; DateTime get updatedAt; DateTime? get sentAt; DateTime? get openedAt; DateTime? get completedAt; DateTime? get cancelledAt;// Ledger reference
 String get groupAccountId;// Notification state
 bool get reminderSent;
/// Create a copy of TokenPool
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenPoolCopyWith<TokenPool> get copyWith => _$TokenPoolCopyWithImpl<TokenPool>(this as TokenPool, _$identity);

  /// Serializes this TokenPool to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenPool&&(identical(other.id, id) || other.id == id)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalDistributed, totalDistributed) || other.totalDistributed == totalDistributed)&&(identical(other.contributionCount, contributionCount) || other.contributionCount == contributionCount)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other.contributions, contributions)&&const DeepCollectionEquality().equals(other.payouts, payouts)&&(identical(other.giftMessageId, giftMessageId) || other.giftMessageId == giftMessageId)&&(identical(other.giftConversationId, giftConversationId) || other.giftConversationId == giftConversationId)&&const DeepCollectionEquality().equals(other.inviteeIds, inviteeIds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.groupAccountId, groupAccountId) || other.groupAccountId == groupAccountId)&&(identical(other.reminderSent, reminderSent) || other.reminderSent == reminderSent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,mode,status,organizerId,organizerName,recipientId,recipientName,conversationId,title,purpose,message,style,totalAmount,totalDistributed,contributionCount,contributorCount,const DeepCollectionEquality().hash(contributions),const DeepCollectionEquality().hash(payouts),giftMessageId,giftConversationId,const DeepCollectionEquality().hash(inviteeIds),expiresAt,createdAt,updatedAt,sentAt,openedAt,completedAt,cancelledAt,groupAccountId,reminderSent]);

@override
String toString() {
  return 'TokenPool(id: $id, mode: $mode, status: $status, organizerId: $organizerId, organizerName: $organizerName, recipientId: $recipientId, recipientName: $recipientName, conversationId: $conversationId, title: $title, purpose: $purpose, message: $message, style: $style, totalAmount: $totalAmount, totalDistributed: $totalDistributed, contributionCount: $contributionCount, contributorCount: $contributorCount, contributions: $contributions, payouts: $payouts, giftMessageId: $giftMessageId, giftConversationId: $giftConversationId, inviteeIds: $inviteeIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, sentAt: $sentAt, openedAt: $openedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, groupAccountId: $groupAccountId, reminderSent: $reminderSent)';
}


}

/// @nodoc
abstract mixin class $TokenPoolCopyWith<$Res>  {
  factory $TokenPoolCopyWith(TokenPool value, $Res Function(TokenPool) _then) = _$TokenPoolCopyWithImpl;
@useResult
$Res call({
 String id, PoolMode mode, PoolStatus status, String organizerId, String organizerName, String? recipientId, String? recipientName, String conversationId, String title, String purpose, String message, GiftStyle style, int totalAmount, int totalDistributed, int contributionCount, int contributorCount, Map<String, PoolContribution> contributions, List<PoolPayout> payouts, String? giftMessageId, String? giftConversationId, List<String> inviteeIds, DateTime? expiresAt, DateTime createdAt, DateTime updatedAt, DateTime? sentAt, DateTime? openedAt, DateTime? completedAt, DateTime? cancelledAt, String groupAccountId, bool reminderSent
});




}
/// @nodoc
class _$TokenPoolCopyWithImpl<$Res>
    implements $TokenPoolCopyWith<$Res> {
  _$TokenPoolCopyWithImpl(this._self, this._then);

  final TokenPool _self;
  final $Res Function(TokenPool) _then;

/// Create a copy of TokenPool
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mode = null,Object? status = null,Object? organizerId = null,Object? organizerName = null,Object? recipientId = freezed,Object? recipientName = freezed,Object? conversationId = null,Object? title = null,Object? purpose = null,Object? message = null,Object? style = null,Object? totalAmount = null,Object? totalDistributed = null,Object? contributionCount = null,Object? contributorCount = null,Object? contributions = null,Object? payouts = null,Object? giftMessageId = freezed,Object? giftConversationId = freezed,Object? inviteeIds = null,Object? expiresAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? sentAt = freezed,Object? openedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? groupAccountId = null,Object? reminderSent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PoolMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PoolStatus,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,totalDistributed: null == totalDistributed ? _self.totalDistributed : totalDistributed // ignore: cast_nullable_to_non_nullable
as int,contributionCount: null == contributionCount ? _self.contributionCount : contributionCount // ignore: cast_nullable_to_non_nullable
as int,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, PoolContribution>,payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<PoolPayout>,giftMessageId: freezed == giftMessageId ? _self.giftMessageId : giftMessageId // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [TokenPool].
extension TokenPoolPatterns on TokenPool {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenPool value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenPool() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenPool value)  $default,){
final _that = this;
switch (_that) {
case _TokenPool():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenPool value)?  $default,){
final _that = this;
switch (_that) {
case _TokenPool() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PoolMode mode,  PoolStatus status,  String organizerId,  String organizerName,  String? recipientId,  String? recipientName,  String conversationId,  String title,  String purpose,  String message,  GiftStyle style,  int totalAmount,  int totalDistributed,  int contributionCount,  int contributorCount,  Map<String, PoolContribution> contributions,  List<PoolPayout> payouts,  String? giftMessageId,  String? giftConversationId,  List<String> inviteeIds,  DateTime? expiresAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? sentAt,  DateTime? openedAt,  DateTime? completedAt,  DateTime? cancelledAt,  String groupAccountId,  bool reminderSent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenPool() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PoolMode mode,  PoolStatus status,  String organizerId,  String organizerName,  String? recipientId,  String? recipientName,  String conversationId,  String title,  String purpose,  String message,  GiftStyle style,  int totalAmount,  int totalDistributed,  int contributionCount,  int contributorCount,  Map<String, PoolContribution> contributions,  List<PoolPayout> payouts,  String? giftMessageId,  String? giftConversationId,  List<String> inviteeIds,  DateTime? expiresAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? sentAt,  DateTime? openedAt,  DateTime? completedAt,  DateTime? cancelledAt,  String groupAccountId,  bool reminderSent)  $default,) {final _that = this;
switch (_that) {
case _TokenPool():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PoolMode mode,  PoolStatus status,  String organizerId,  String organizerName,  String? recipientId,  String? recipientName,  String conversationId,  String title,  String purpose,  String message,  GiftStyle style,  int totalAmount,  int totalDistributed,  int contributionCount,  int contributorCount,  Map<String, PoolContribution> contributions,  List<PoolPayout> payouts,  String? giftMessageId,  String? giftConversationId,  List<String> inviteeIds,  DateTime? expiresAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? sentAt,  DateTime? openedAt,  DateTime? completedAt,  DateTime? cancelledAt,  String groupAccountId,  bool reminderSent)?  $default,) {final _that = this;
switch (_that) {
case _TokenPool() when $default != null:
return $default(_that.id,_that.mode,_that.status,_that.organizerId,_that.organizerName,_that.recipientId,_that.recipientName,_that.conversationId,_that.title,_that.purpose,_that.message,_that.style,_that.totalAmount,_that.totalDistributed,_that.contributionCount,_that.contributorCount,_that.contributions,_that.payouts,_that.giftMessageId,_that.giftConversationId,_that.inviteeIds,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.sentAt,_that.openedAt,_that.completedAt,_that.cancelledAt,_that.groupAccountId,_that.reminderSent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenPool extends TokenPool {
  const _TokenPool({required this.id, required this.mode, required this.status, required this.organizerId, required this.organizerName, this.recipientId, this.recipientName, required this.conversationId, required this.title, this.purpose = '', this.message = '', required this.style, this.totalAmount = 0, this.totalDistributed = 0, this.contributionCount = 0, this.contributorCount = 0, final  Map<String, PoolContribution> contributions = const {}, final  List<PoolPayout> payouts = const [], this.giftMessageId, this.giftConversationId, final  List<String> inviteeIds = const [], this.expiresAt, required this.createdAt, required this.updatedAt, this.sentAt, this.openedAt, this.completedAt, this.cancelledAt, required this.groupAccountId, this.reminderSent = false}): _contributions = contributions,_payouts = payouts,_inviteeIds = inviteeIds,super._();
  factory _TokenPool.fromJson(Map<String, dynamic> json) => _$TokenPoolFromJson(json);

@override final  String id;
@override final  PoolMode mode;
@override final  PoolStatus status;
// Organizer
@override final  String organizerId;
@override final  String organizerName;
// Recipient (sasaza mode only)
@override final  String? recipientId;
@override final  String? recipientName;
// Conversation link
@override final  String conversationId;
// Pool content
@override final  String title;
@override@JsonKey() final  String purpose;
@override@JsonKey() final  String message;
@override final  GiftStyle style;
// Financial summary
@override@JsonKey() final  int totalAmount;
@override@JsonKey() final  int totalDistributed;
@override@JsonKey() final  int contributionCount;
@override@JsonKey() final  int contributorCount;
// Per-user contributions
 final  Map<String, PoolContribution> _contributions;
// Per-user contributions
@override@JsonKey() Map<String, PoolContribution> get contributions {
  if (_contributions is EqualUnmodifiableMapView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contributions);
}

// Payout records (populated on distribute)
 final  List<PoolPayout> _payouts;
// Payout records (populated on distribute)
@override@JsonKey() List<PoolPayout> get payouts {
  if (_payouts is EqualUnmodifiableListView) return _payouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payouts);
}

// Gift delivery references (sasaza mode, after send)
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

/// Create a copy of TokenPool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenPoolCopyWith<_TokenPool> get copyWith => __$TokenPoolCopyWithImpl<_TokenPool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenPoolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenPool&&(identical(other.id, id) || other.id == id)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalDistributed, totalDistributed) || other.totalDistributed == totalDistributed)&&(identical(other.contributionCount, contributionCount) || other.contributionCount == contributionCount)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other._contributions, _contributions)&&const DeepCollectionEquality().equals(other._payouts, _payouts)&&(identical(other.giftMessageId, giftMessageId) || other.giftMessageId == giftMessageId)&&(identical(other.giftConversationId, giftConversationId) || other.giftConversationId == giftConversationId)&&const DeepCollectionEquality().equals(other._inviteeIds, _inviteeIds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.groupAccountId, groupAccountId) || other.groupAccountId == groupAccountId)&&(identical(other.reminderSent, reminderSent) || other.reminderSent == reminderSent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,mode,status,organizerId,organizerName,recipientId,recipientName,conversationId,title,purpose,message,style,totalAmount,totalDistributed,contributionCount,contributorCount,const DeepCollectionEquality().hash(_contributions),const DeepCollectionEquality().hash(_payouts),giftMessageId,giftConversationId,const DeepCollectionEquality().hash(_inviteeIds),expiresAt,createdAt,updatedAt,sentAt,openedAt,completedAt,cancelledAt,groupAccountId,reminderSent]);

@override
String toString() {
  return 'TokenPool(id: $id, mode: $mode, status: $status, organizerId: $organizerId, organizerName: $organizerName, recipientId: $recipientId, recipientName: $recipientName, conversationId: $conversationId, title: $title, purpose: $purpose, message: $message, style: $style, totalAmount: $totalAmount, totalDistributed: $totalDistributed, contributionCount: $contributionCount, contributorCount: $contributorCount, contributions: $contributions, payouts: $payouts, giftMessageId: $giftMessageId, giftConversationId: $giftConversationId, inviteeIds: $inviteeIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, sentAt: $sentAt, openedAt: $openedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, groupAccountId: $groupAccountId, reminderSent: $reminderSent)';
}


}

/// @nodoc
abstract mixin class _$TokenPoolCopyWith<$Res> implements $TokenPoolCopyWith<$Res> {
  factory _$TokenPoolCopyWith(_TokenPool value, $Res Function(_TokenPool) _then) = __$TokenPoolCopyWithImpl;
@override @useResult
$Res call({
 String id, PoolMode mode, PoolStatus status, String organizerId, String organizerName, String? recipientId, String? recipientName, String conversationId, String title, String purpose, String message, GiftStyle style, int totalAmount, int totalDistributed, int contributionCount, int contributorCount, Map<String, PoolContribution> contributions, List<PoolPayout> payouts, String? giftMessageId, String? giftConversationId, List<String> inviteeIds, DateTime? expiresAt, DateTime createdAt, DateTime updatedAt, DateTime? sentAt, DateTime? openedAt, DateTime? completedAt, DateTime? cancelledAt, String groupAccountId, bool reminderSent
});




}
/// @nodoc
class __$TokenPoolCopyWithImpl<$Res>
    implements _$TokenPoolCopyWith<$Res> {
  __$TokenPoolCopyWithImpl(this._self, this._then);

  final _TokenPool _self;
  final $Res Function(_TokenPool) _then;

/// Create a copy of TokenPool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mode = null,Object? status = null,Object? organizerId = null,Object? organizerName = null,Object? recipientId = freezed,Object? recipientName = freezed,Object? conversationId = null,Object? title = null,Object? purpose = null,Object? message = null,Object? style = null,Object? totalAmount = null,Object? totalDistributed = null,Object? contributionCount = null,Object? contributorCount = null,Object? contributions = null,Object? payouts = null,Object? giftMessageId = freezed,Object? giftConversationId = freezed,Object? inviteeIds = null,Object? expiresAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? sentAt = freezed,Object? openedAt = freezed,Object? completedAt = freezed,Object? cancelledAt = freezed,Object? groupAccountId = null,Object? reminderSent = null,}) {
  return _then(_TokenPool(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PoolMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PoolStatus,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,totalDistributed: null == totalDistributed ? _self.totalDistributed : totalDistributed // ignore: cast_nullable_to_non_nullable
as int,contributionCount: null == contributionCount ? _self.contributionCount : contributionCount // ignore: cast_nullable_to_non_nullable
as int,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, PoolContribution>,payouts: null == payouts ? _self._payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<PoolPayout>,giftMessageId: freezed == giftMessageId ? _self.giftMessageId : giftMessageId // ignore: cast_nullable_to_non_nullable
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
