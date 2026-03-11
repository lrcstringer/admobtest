// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Gift {

 String get id; String get senderId; String get senderName; String get recipientId; String get recipientName; int get amount; String? get conversationId; String? get communityId; String get messageId; String get message; GiftStyle get style; GiftStatus get status; DateTime get createdAt; DateTime? get openedAt; DateTime? get claimedAt; DateTime get expiresAt; String? get debitTransactionId; String? get creditTransactionId;
/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCopyWith<Gift> get copyWith => _$GiftCopyWithImpl<Gift>(this as Gift, _$identity);

  /// Serializes this Gift to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Gift&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.debitTransactionId, debitTransactionId) || other.debitTransactionId == debitTransactionId)&&(identical(other.creditTransactionId, creditTransactionId) || other.creditTransactionId == creditTransactionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderName,recipientId,recipientName,amount,conversationId,communityId,messageId,message,style,status,createdAt,openedAt,claimedAt,expiresAt,debitTransactionId,creditTransactionId);

@override
String toString() {
  return 'Gift(id: $id, senderId: $senderId, senderName: $senderName, recipientId: $recipientId, recipientName: $recipientName, amount: $amount, conversationId: $conversationId, communityId: $communityId, messageId: $messageId, message: $message, style: $style, status: $status, createdAt: $createdAt, openedAt: $openedAt, claimedAt: $claimedAt, expiresAt: $expiresAt, debitTransactionId: $debitTransactionId, creditTransactionId: $creditTransactionId)';
}


}

/// @nodoc
abstract mixin class $GiftCopyWith<$Res>  {
  factory $GiftCopyWith(Gift value, $Res Function(Gift) _then) = _$GiftCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderName, String recipientId, String recipientName, int amount, String? conversationId, String? communityId, String messageId, String message, GiftStyle style, GiftStatus status, DateTime createdAt, DateTime? openedAt, DateTime? claimedAt, DateTime expiresAt, String? debitTransactionId, String? creditTransactionId
});




}
/// @nodoc
class _$GiftCopyWithImpl<$Res>
    implements $GiftCopyWith<$Res> {
  _$GiftCopyWithImpl(this._self, this._then);

  final Gift _self;
  final $Res Function(Gift) _then;

/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? recipientId = null,Object? recipientName = null,Object? amount = null,Object? conversationId = freezed,Object? communityId = freezed,Object? messageId = null,Object? message = null,Object? style = null,Object? status = null,Object? createdAt = null,Object? openedAt = freezed,Object? claimedAt = freezed,Object? expiresAt = null,Object? debitTransactionId = freezed,Object? creditTransactionId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GiftStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,debitTransactionId: freezed == debitTransactionId ? _self.debitTransactionId : debitTransactionId // ignore: cast_nullable_to_non_nullable
as String?,creditTransactionId: freezed == creditTransactionId ? _self.creditTransactionId : creditTransactionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Gift].
extension GiftPatterns on Gift {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Gift value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Gift() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Gift value)  $default,){
final _that = this;
switch (_that) {
case _Gift():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Gift value)?  $default,){
final _that = this;
switch (_that) {
case _Gift() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String recipientId,  String recipientName,  int amount,  String? conversationId,  String? communityId,  String messageId,  String message,  GiftStyle style,  GiftStatus status,  DateTime createdAt,  DateTime? openedAt,  DateTime? claimedAt,  DateTime expiresAt,  String? debitTransactionId,  String? creditTransactionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Gift() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.recipientId,_that.recipientName,_that.amount,_that.conversationId,_that.communityId,_that.messageId,_that.message,_that.style,_that.status,_that.createdAt,_that.openedAt,_that.claimedAt,_that.expiresAt,_that.debitTransactionId,_that.creditTransactionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String recipientId,  String recipientName,  int amount,  String? conversationId,  String? communityId,  String messageId,  String message,  GiftStyle style,  GiftStatus status,  DateTime createdAt,  DateTime? openedAt,  DateTime? claimedAt,  DateTime expiresAt,  String? debitTransactionId,  String? creditTransactionId)  $default,) {final _that = this;
switch (_that) {
case _Gift():
return $default(_that.id,_that.senderId,_that.senderName,_that.recipientId,_that.recipientName,_that.amount,_that.conversationId,_that.communityId,_that.messageId,_that.message,_that.style,_that.status,_that.createdAt,_that.openedAt,_that.claimedAt,_that.expiresAt,_that.debitTransactionId,_that.creditTransactionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderName,  String recipientId,  String recipientName,  int amount,  String? conversationId,  String? communityId,  String messageId,  String message,  GiftStyle style,  GiftStatus status,  DateTime createdAt,  DateTime? openedAt,  DateTime? claimedAt,  DateTime expiresAt,  String? debitTransactionId,  String? creditTransactionId)?  $default,) {final _that = this;
switch (_that) {
case _Gift() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.recipientId,_that.recipientName,_that.amount,_that.conversationId,_that.communityId,_that.messageId,_that.message,_that.style,_that.status,_that.createdAt,_that.openedAt,_that.claimedAt,_that.expiresAt,_that.debitTransactionId,_that.creditTransactionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Gift extends Gift {
  const _Gift({required this.id, required this.senderId, required this.senderName, required this.recipientId, required this.recipientName, required this.amount, this.conversationId, this.communityId, required this.messageId, required this.message, required this.style, required this.status, required this.createdAt, this.openedAt, this.claimedAt, required this.expiresAt, this.debitTransactionId, this.creditTransactionId}): super._();
  factory _Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);

@override final  String id;
@override final  String senderId;
@override final  String senderName;
@override final  String recipientId;
@override final  String recipientName;
@override final  int amount;
@override final  String? conversationId;
@override final  String? communityId;
@override final  String messageId;
@override final  String message;
@override final  GiftStyle style;
@override final  GiftStatus status;
@override final  DateTime createdAt;
@override final  DateTime? openedAt;
@override final  DateTime? claimedAt;
@override final  DateTime expiresAt;
@override final  String? debitTransactionId;
@override final  String? creditTransactionId;

/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCopyWith<_Gift> get copyWith => __$GiftCopyWithImpl<_Gift>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Gift&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.debitTransactionId, debitTransactionId) || other.debitTransactionId == debitTransactionId)&&(identical(other.creditTransactionId, creditTransactionId) || other.creditTransactionId == creditTransactionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderName,recipientId,recipientName,amount,conversationId,communityId,messageId,message,style,status,createdAt,openedAt,claimedAt,expiresAt,debitTransactionId,creditTransactionId);

@override
String toString() {
  return 'Gift(id: $id, senderId: $senderId, senderName: $senderName, recipientId: $recipientId, recipientName: $recipientName, amount: $amount, conversationId: $conversationId, communityId: $communityId, messageId: $messageId, message: $message, style: $style, status: $status, createdAt: $createdAt, openedAt: $openedAt, claimedAt: $claimedAt, expiresAt: $expiresAt, debitTransactionId: $debitTransactionId, creditTransactionId: $creditTransactionId)';
}


}

/// @nodoc
abstract mixin class _$GiftCopyWith<$Res> implements $GiftCopyWith<$Res> {
  factory _$GiftCopyWith(_Gift value, $Res Function(_Gift) _then) = __$GiftCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderName, String recipientId, String recipientName, int amount, String? conversationId, String? communityId, String messageId, String message, GiftStyle style, GiftStatus status, DateTime createdAt, DateTime? openedAt, DateTime? claimedAt, DateTime expiresAt, String? debitTransactionId, String? creditTransactionId
});




}
/// @nodoc
class __$GiftCopyWithImpl<$Res>
    implements _$GiftCopyWith<$Res> {
  __$GiftCopyWithImpl(this._self, this._then);

  final _Gift _self;
  final $Res Function(_Gift) _then;

/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? recipientId = null,Object? recipientName = null,Object? amount = null,Object? conversationId = freezed,Object? communityId = freezed,Object? messageId = null,Object? message = null,Object? style = null,Object? status = null,Object? createdAt = null,Object? openedAt = freezed,Object? claimedAt = freezed,Object? expiresAt = null,Object? debitTransactionId = freezed,Object? creditTransactionId = freezed,}) {
  return _then(_Gift(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GiftStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,debitTransactionId: freezed == debitTransactionId ? _self.debitTransactionId : debitTransactionId // ignore: cast_nullable_to_non_nullable
as String?,creditTransactionId: freezed == creditTransactionId ? _self.creditTransactionId : creditTransactionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GiftStats {

 int get totalSent; int get totalReceived; int get totalAmountSent; int get totalAmountReceived;
/// Create a copy of GiftStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftStatsCopyWith<GiftStats> get copyWith => _$GiftStatsCopyWithImpl<GiftStats>(this as GiftStats, _$identity);

  /// Serializes this GiftStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftStats&&(identical(other.totalSent, totalSent) || other.totalSent == totalSent)&&(identical(other.totalReceived, totalReceived) || other.totalReceived == totalReceived)&&(identical(other.totalAmountSent, totalAmountSent) || other.totalAmountSent == totalAmountSent)&&(identical(other.totalAmountReceived, totalAmountReceived) || other.totalAmountReceived == totalAmountReceived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSent,totalReceived,totalAmountSent,totalAmountReceived);

@override
String toString() {
  return 'GiftStats(totalSent: $totalSent, totalReceived: $totalReceived, totalAmountSent: $totalAmountSent, totalAmountReceived: $totalAmountReceived)';
}


}

/// @nodoc
abstract mixin class $GiftStatsCopyWith<$Res>  {
  factory $GiftStatsCopyWith(GiftStats value, $Res Function(GiftStats) _then) = _$GiftStatsCopyWithImpl;
@useResult
$Res call({
 int totalSent, int totalReceived, int totalAmountSent, int totalAmountReceived
});




}
/// @nodoc
class _$GiftStatsCopyWithImpl<$Res>
    implements $GiftStatsCopyWith<$Res> {
  _$GiftStatsCopyWithImpl(this._self, this._then);

  final GiftStats _self;
  final $Res Function(GiftStats) _then;

/// Create a copy of GiftStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSent = null,Object? totalReceived = null,Object? totalAmountSent = null,Object? totalAmountReceived = null,}) {
  return _then(_self.copyWith(
totalSent: null == totalSent ? _self.totalSent : totalSent // ignore: cast_nullable_to_non_nullable
as int,totalReceived: null == totalReceived ? _self.totalReceived : totalReceived // ignore: cast_nullable_to_non_nullable
as int,totalAmountSent: null == totalAmountSent ? _self.totalAmountSent : totalAmountSent // ignore: cast_nullable_to_non_nullable
as int,totalAmountReceived: null == totalAmountReceived ? _self.totalAmountReceived : totalAmountReceived // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftStats].
extension GiftStatsPatterns on GiftStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftStats value)  $default,){
final _that = this;
switch (_that) {
case _GiftStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftStats value)?  $default,){
final _that = this;
switch (_that) {
case _GiftStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSent,  int totalReceived,  int totalAmountSent,  int totalAmountReceived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftStats() when $default != null:
return $default(_that.totalSent,_that.totalReceived,_that.totalAmountSent,_that.totalAmountReceived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSent,  int totalReceived,  int totalAmountSent,  int totalAmountReceived)  $default,) {final _that = this;
switch (_that) {
case _GiftStats():
return $default(_that.totalSent,_that.totalReceived,_that.totalAmountSent,_that.totalAmountReceived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSent,  int totalReceived,  int totalAmountSent,  int totalAmountReceived)?  $default,) {final _that = this;
switch (_that) {
case _GiftStats() when $default != null:
return $default(_that.totalSent,_that.totalReceived,_that.totalAmountSent,_that.totalAmountReceived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftStats implements GiftStats {
  const _GiftStats({required this.totalSent, required this.totalReceived, required this.totalAmountSent, required this.totalAmountReceived});
  factory _GiftStats.fromJson(Map<String, dynamic> json) => _$GiftStatsFromJson(json);

@override final  int totalSent;
@override final  int totalReceived;
@override final  int totalAmountSent;
@override final  int totalAmountReceived;

/// Create a copy of GiftStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftStatsCopyWith<_GiftStats> get copyWith => __$GiftStatsCopyWithImpl<_GiftStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftStats&&(identical(other.totalSent, totalSent) || other.totalSent == totalSent)&&(identical(other.totalReceived, totalReceived) || other.totalReceived == totalReceived)&&(identical(other.totalAmountSent, totalAmountSent) || other.totalAmountSent == totalAmountSent)&&(identical(other.totalAmountReceived, totalAmountReceived) || other.totalAmountReceived == totalAmountReceived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSent,totalReceived,totalAmountSent,totalAmountReceived);

@override
String toString() {
  return 'GiftStats(totalSent: $totalSent, totalReceived: $totalReceived, totalAmountSent: $totalAmountSent, totalAmountReceived: $totalAmountReceived)';
}


}

/// @nodoc
abstract mixin class _$GiftStatsCopyWith<$Res> implements $GiftStatsCopyWith<$Res> {
  factory _$GiftStatsCopyWith(_GiftStats value, $Res Function(_GiftStats) _then) = __$GiftStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalSent, int totalReceived, int totalAmountSent, int totalAmountReceived
});




}
/// @nodoc
class __$GiftStatsCopyWithImpl<$Res>
    implements _$GiftStatsCopyWith<$Res> {
  __$GiftStatsCopyWithImpl(this._self, this._then);

  final _GiftStats _self;
  final $Res Function(_GiftStats) _then;

/// Create a copy of GiftStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSent = null,Object? totalReceived = null,Object? totalAmountSent = null,Object? totalAmountReceived = null,}) {
  return _then(_GiftStats(
totalSent: null == totalSent ? _self.totalSent : totalSent // ignore: cast_nullable_to_non_nullable
as int,totalReceived: null == totalReceived ? _self.totalReceived : totalReceived // ignore: cast_nullable_to_non_nullable
as int,totalAmountSent: null == totalAmountSent ? _self.totalAmountSent : totalAmountSent // ignore: cast_nullable_to_non_nullable
as int,totalAmountReceived: null == totalAmountReceived ? _self.totalAmountReceived : totalAmountReceived // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
