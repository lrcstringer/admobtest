// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GiftModel {

 String get id; String get senderId; String get senderName; String get recipientId; String get recipientName; int get amount; String? get conversationId; String? get communityId; String get messageId; String get message; String get style; String get status; DateTime get createdAt; DateTime? get openedAt; DateTime? get claimedAt; DateTime get expiresAt; String? get debitTransactionId; String? get creditTransactionId;
/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftModelCopyWith<GiftModel> get copyWith => _$GiftModelCopyWithImpl<GiftModel>(this as GiftModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.debitTransactionId, debitTransactionId) || other.debitTransactionId == debitTransactionId)&&(identical(other.creditTransactionId, creditTransactionId) || other.creditTransactionId == creditTransactionId));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderName,recipientId,recipientName,amount,conversationId,communityId,messageId,message,style,status,createdAt,openedAt,claimedAt,expiresAt,debitTransactionId,creditTransactionId);

@override
String toString() {
  return 'GiftModel(id: $id, senderId: $senderId, senderName: $senderName, recipientId: $recipientId, recipientName: $recipientName, amount: $amount, conversationId: $conversationId, communityId: $communityId, messageId: $messageId, message: $message, style: $style, status: $status, createdAt: $createdAt, openedAt: $openedAt, claimedAt: $claimedAt, expiresAt: $expiresAt, debitTransactionId: $debitTransactionId, creditTransactionId: $creditTransactionId)';
}


}

/// @nodoc
abstract mixin class $GiftModelCopyWith<$Res>  {
  factory $GiftModelCopyWith(GiftModel value, $Res Function(GiftModel) _then) = _$GiftModelCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderName, String recipientId, String recipientName, int amount, String? conversationId, String? communityId, String messageId, String message, String style, String status, DateTime createdAt, DateTime? openedAt, DateTime? claimedAt, DateTime expiresAt, String? debitTransactionId, String? creditTransactionId
});




}
/// @nodoc
class _$GiftModelCopyWithImpl<$Res>
    implements $GiftModelCopyWith<$Res> {
  _$GiftModelCopyWithImpl(this._self, this._then);

  final GiftModel _self;
  final $Res Function(GiftModel) _then;

/// Create a copy of GiftModel
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
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,debitTransactionId: freezed == debitTransactionId ? _self.debitTransactionId : debitTransactionId // ignore: cast_nullable_to_non_nullable
as String?,creditTransactionId: freezed == creditTransactionId ? _self.creditTransactionId : creditTransactionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftModel].
extension GiftModelPatterns on GiftModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String recipientId,  String recipientName,  int amount,  String? conversationId,  String? communityId,  String messageId,  String message,  String style,  String status,  DateTime createdAt,  DateTime? openedAt,  DateTime? claimedAt,  DateTime expiresAt,  String? debitTransactionId,  String? creditTransactionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String recipientId,  String recipientName,  int amount,  String? conversationId,  String? communityId,  String messageId,  String message,  String style,  String status,  DateTime createdAt,  DateTime? openedAt,  DateTime? claimedAt,  DateTime expiresAt,  String? debitTransactionId,  String? creditTransactionId)  $default,) {final _that = this;
switch (_that) {
case _GiftModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderName,  String recipientId,  String recipientName,  int amount,  String? conversationId,  String? communityId,  String messageId,  String message,  String style,  String status,  DateTime createdAt,  DateTime? openedAt,  DateTime? claimedAt,  DateTime expiresAt,  String? debitTransactionId,  String? creditTransactionId)?  $default,) {final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.recipientId,_that.recipientName,_that.amount,_that.conversationId,_that.communityId,_that.messageId,_that.message,_that.style,_that.status,_that.createdAt,_that.openedAt,_that.claimedAt,_that.expiresAt,_that.debitTransactionId,_that.creditTransactionId);case _:
  return null;

}
}

}

/// @nodoc


class _GiftModel extends GiftModel {
  const _GiftModel({required this.id, required this.senderId, required this.senderName, required this.recipientId, required this.recipientName, required this.amount, this.conversationId, this.communityId, required this.messageId, required this.message, required this.style, required this.status, required this.createdAt, this.openedAt, this.claimedAt, required this.expiresAt, this.debitTransactionId, this.creditTransactionId}): super._();
  

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
@override final  String style;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime? openedAt;
@override final  DateTime? claimedAt;
@override final  DateTime expiresAt;
@override final  String? debitTransactionId;
@override final  String? creditTransactionId;

/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftModelCopyWith<_GiftModel> get copyWith => __$GiftModelCopyWithImpl<_GiftModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.debitTransactionId, debitTransactionId) || other.debitTransactionId == debitTransactionId)&&(identical(other.creditTransactionId, creditTransactionId) || other.creditTransactionId == creditTransactionId));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderName,recipientId,recipientName,amount,conversationId,communityId,messageId,message,style,status,createdAt,openedAt,claimedAt,expiresAt,debitTransactionId,creditTransactionId);

@override
String toString() {
  return 'GiftModel(id: $id, senderId: $senderId, senderName: $senderName, recipientId: $recipientId, recipientName: $recipientName, amount: $amount, conversationId: $conversationId, communityId: $communityId, messageId: $messageId, message: $message, style: $style, status: $status, createdAt: $createdAt, openedAt: $openedAt, claimedAt: $claimedAt, expiresAt: $expiresAt, debitTransactionId: $debitTransactionId, creditTransactionId: $creditTransactionId)';
}


}

/// @nodoc
abstract mixin class _$GiftModelCopyWith<$Res> implements $GiftModelCopyWith<$Res> {
  factory _$GiftModelCopyWith(_GiftModel value, $Res Function(_GiftModel) _then) = __$GiftModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderName, String recipientId, String recipientName, int amount, String? conversationId, String? communityId, String messageId, String message, String style, String status, DateTime createdAt, DateTime? openedAt, DateTime? claimedAt, DateTime expiresAt, String? debitTransactionId, String? creditTransactionId
});




}
/// @nodoc
class __$GiftModelCopyWithImpl<$Res>
    implements _$GiftModelCopyWith<$Res> {
  __$GiftModelCopyWithImpl(this._self, this._then);

  final _GiftModel _self;
  final $Res Function(_GiftModel) _then;

/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? recipientId = null,Object? recipientName = null,Object? amount = null,Object? conversationId = freezed,Object? communityId = freezed,Object? messageId = null,Object? message = null,Object? style = null,Object? status = null,Object? createdAt = null,Object? openedAt = freezed,Object? claimedAt = freezed,Object? expiresAt = null,Object? debitTransactionId = freezed,Object? creditTransactionId = freezed,}) {
  return _then(_GiftModel(
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
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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
mixin _$GiftStatsModel {

 int get totalSent; int get totalReceived; int get totalAmountSent; int get totalAmountReceived;
/// Create a copy of GiftStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftStatsModelCopyWith<GiftStatsModel> get copyWith => _$GiftStatsModelCopyWithImpl<GiftStatsModel>(this as GiftStatsModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftStatsModel&&(identical(other.totalSent, totalSent) || other.totalSent == totalSent)&&(identical(other.totalReceived, totalReceived) || other.totalReceived == totalReceived)&&(identical(other.totalAmountSent, totalAmountSent) || other.totalAmountSent == totalAmountSent)&&(identical(other.totalAmountReceived, totalAmountReceived) || other.totalAmountReceived == totalAmountReceived));
}


@override
int get hashCode => Object.hash(runtimeType,totalSent,totalReceived,totalAmountSent,totalAmountReceived);

@override
String toString() {
  return 'GiftStatsModel(totalSent: $totalSent, totalReceived: $totalReceived, totalAmountSent: $totalAmountSent, totalAmountReceived: $totalAmountReceived)';
}


}

/// @nodoc
abstract mixin class $GiftStatsModelCopyWith<$Res>  {
  factory $GiftStatsModelCopyWith(GiftStatsModel value, $Res Function(GiftStatsModel) _then) = _$GiftStatsModelCopyWithImpl;
@useResult
$Res call({
 int totalSent, int totalReceived, int totalAmountSent, int totalAmountReceived
});




}
/// @nodoc
class _$GiftStatsModelCopyWithImpl<$Res>
    implements $GiftStatsModelCopyWith<$Res> {
  _$GiftStatsModelCopyWithImpl(this._self, this._then);

  final GiftStatsModel _self;
  final $Res Function(GiftStatsModel) _then;

/// Create a copy of GiftStatsModel
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


/// Adds pattern-matching-related methods to [GiftStatsModel].
extension GiftStatsModelPatterns on GiftStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftStatsModel() when $default != null:
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
case _GiftStatsModel() when $default != null:
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
case _GiftStatsModel():
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
case _GiftStatsModel() when $default != null:
return $default(_that.totalSent,_that.totalReceived,_that.totalAmountSent,_that.totalAmountReceived);case _:
  return null;

}
}

}

/// @nodoc


class _GiftStatsModel extends GiftStatsModel {
  const _GiftStatsModel({this.totalSent = 0, this.totalReceived = 0, this.totalAmountSent = 0, this.totalAmountReceived = 0}): super._();
  

@override@JsonKey() final  int totalSent;
@override@JsonKey() final  int totalReceived;
@override@JsonKey() final  int totalAmountSent;
@override@JsonKey() final  int totalAmountReceived;

/// Create a copy of GiftStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftStatsModelCopyWith<_GiftStatsModel> get copyWith => __$GiftStatsModelCopyWithImpl<_GiftStatsModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftStatsModel&&(identical(other.totalSent, totalSent) || other.totalSent == totalSent)&&(identical(other.totalReceived, totalReceived) || other.totalReceived == totalReceived)&&(identical(other.totalAmountSent, totalAmountSent) || other.totalAmountSent == totalAmountSent)&&(identical(other.totalAmountReceived, totalAmountReceived) || other.totalAmountReceived == totalAmountReceived));
}


@override
int get hashCode => Object.hash(runtimeType,totalSent,totalReceived,totalAmountSent,totalAmountReceived);

@override
String toString() {
  return 'GiftStatsModel(totalSent: $totalSent, totalReceived: $totalReceived, totalAmountSent: $totalAmountSent, totalAmountReceived: $totalAmountReceived)';
}


}

/// @nodoc
abstract mixin class _$GiftStatsModelCopyWith<$Res> implements $GiftStatsModelCopyWith<$Res> {
  factory _$GiftStatsModelCopyWith(_GiftStatsModel value, $Res Function(_GiftStatsModel) _then) = __$GiftStatsModelCopyWithImpl;
@override @useResult
$Res call({
 int totalSent, int totalReceived, int totalAmountSent, int totalAmountReceived
});




}
/// @nodoc
class __$GiftStatsModelCopyWithImpl<$Res>
    implements _$GiftStatsModelCopyWith<$Res> {
  __$GiftStatsModelCopyWithImpl(this._self, this._then);

  final _GiftStatsModel _self;
  final $Res Function(_GiftStatsModel) _then;

/// Create a copy of GiftStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSent = null,Object? totalReceived = null,Object? totalAmountSent = null,Object? totalAmountReceived = null,}) {
  return _then(_GiftStatsModel(
totalSent: null == totalSent ? _self.totalSent : totalSent // ignore: cast_nullable_to_non_nullable
as int,totalReceived: null == totalReceived ? _self.totalReceived : totalReceived // ignore: cast_nullable_to_non_nullable
as int,totalAmountSent: null == totalAmountSent ? _self.totalAmountSent : totalAmountSent // ignore: cast_nullable_to_non_nullable
as int,totalAmountReceived: null == totalAmountReceived ? _self.totalAmountReceived : totalAmountReceived // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
