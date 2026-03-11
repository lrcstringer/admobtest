// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Contact {

 String get id; String get userId; String get contactUserId; String get displayName; String? get username; String? get avatarUrl; String? get avatarColor; String? get phoneNumber; ContactStatus get status; bool get isFavorite; String? get nickname; String? get notes; DateTime get createdAt; DateTime? get lastInteractionAt;
/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactCopyWith<Contact> get copyWith => _$ContactCopyWithImpl<Contact>(this as Contact, _$identity);

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Contact&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,contactUserId,displayName,username,avatarUrl,avatarColor,phoneNumber,status,isFavorite,nickname,notes,createdAt,lastInteractionAt);

@override
String toString() {
  return 'Contact(id: $id, userId: $userId, contactUserId: $contactUserId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, phoneNumber: $phoneNumber, status: $status, isFavorite: $isFavorite, nickname: $nickname, notes: $notes, createdAt: $createdAt, lastInteractionAt: $lastInteractionAt)';
}


}

/// @nodoc
abstract mixin class $ContactCopyWith<$Res>  {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) _then) = _$ContactCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String contactUserId, String displayName, String? username, String? avatarUrl, String? avatarColor, String? phoneNumber, ContactStatus status, bool isFavorite, String? nickname, String? notes, DateTime createdAt, DateTime? lastInteractionAt
});




}
/// @nodoc
class _$ContactCopyWithImpl<$Res>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._self, this._then);

  final Contact _self;
  final $Res Function(Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? contactUserId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? phoneNumber = freezed,Object? status = null,Object? isFavorite = null,Object? nickname = freezed,Object? notes = freezed,Object? createdAt = null,Object? lastInteractionAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,contactUserId: null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContactStatus,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Contact].
extension ContactPatterns on Contact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Contact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Contact value)  $default,){
final _that = this;
switch (_that) {
case _Contact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Contact value)?  $default,){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String contactUserId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String? phoneNumber,  ContactStatus status,  bool isFavorite,  String? nickname,  String? notes,  DateTime createdAt,  DateTime? lastInteractionAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.id,_that.userId,_that.contactUserId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.phoneNumber,_that.status,_that.isFavorite,_that.nickname,_that.notes,_that.createdAt,_that.lastInteractionAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String contactUserId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String? phoneNumber,  ContactStatus status,  bool isFavorite,  String? nickname,  String? notes,  DateTime createdAt,  DateTime? lastInteractionAt)  $default,) {final _that = this;
switch (_that) {
case _Contact():
return $default(_that.id,_that.userId,_that.contactUserId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.phoneNumber,_that.status,_that.isFavorite,_that.nickname,_that.notes,_that.createdAt,_that.lastInteractionAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String contactUserId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String? phoneNumber,  ContactStatus status,  bool isFavorite,  String? nickname,  String? notes,  DateTime createdAt,  DateTime? lastInteractionAt)?  $default,) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.id,_that.userId,_that.contactUserId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.phoneNumber,_that.status,_that.isFavorite,_that.nickname,_that.notes,_that.createdAt,_that.lastInteractionAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Contact extends Contact {
  const _Contact({required this.id, required this.userId, required this.contactUserId, required this.displayName, this.username, this.avatarUrl, this.avatarColor, this.phoneNumber, required this.status, required this.isFavorite, this.nickname, this.notes, required this.createdAt, this.lastInteractionAt}): super._();
  factory _Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String contactUserId;
@override final  String displayName;
@override final  String? username;
@override final  String? avatarUrl;
@override final  String? avatarColor;
@override final  String? phoneNumber;
@override final  ContactStatus status;
@override final  bool isFavorite;
@override final  String? nickname;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime? lastInteractionAt;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactCopyWith<_Contact> get copyWith => __$ContactCopyWithImpl<_Contact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contact&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,contactUserId,displayName,username,avatarUrl,avatarColor,phoneNumber,status,isFavorite,nickname,notes,createdAt,lastInteractionAt);

@override
String toString() {
  return 'Contact(id: $id, userId: $userId, contactUserId: $contactUserId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, phoneNumber: $phoneNumber, status: $status, isFavorite: $isFavorite, nickname: $nickname, notes: $notes, createdAt: $createdAt, lastInteractionAt: $lastInteractionAt)';
}


}

/// @nodoc
abstract mixin class _$ContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$ContactCopyWith(_Contact value, $Res Function(_Contact) _then) = __$ContactCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String contactUserId, String displayName, String? username, String? avatarUrl, String? avatarColor, String? phoneNumber, ContactStatus status, bool isFavorite, String? nickname, String? notes, DateTime createdAt, DateTime? lastInteractionAt
});




}
/// @nodoc
class __$ContactCopyWithImpl<$Res>
    implements _$ContactCopyWith<$Res> {
  __$ContactCopyWithImpl(this._self, this._then);

  final _Contact _self;
  final $Res Function(_Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? contactUserId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? phoneNumber = freezed,Object? status = null,Object? isFavorite = null,Object? nickname = freezed,Object? notes = freezed,Object? createdAt = null,Object? lastInteractionAt = freezed,}) {
  return _then(_Contact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,contactUserId: null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContactStatus,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
