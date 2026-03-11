// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_thread_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatThreadModel {

 String get id; String get type; List<String> get participantIds; String get displayName; String? get avatarUrl; String? get avatarColor; String? get lastMessagePreview; DateTime? get lastMessageAt; int get unreadCount; bool get isPinned; bool get isMuted; bool get isArchived; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of ChatThreadModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadModelCopyWith<ChatThreadModel> get copyWith => _$ChatThreadModelCopyWithImpl<ChatThreadModel>(this as ChatThreadModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.participantIds, participantIds)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(participantIds),displayName,avatarUrl,avatarColor,lastMessagePreview,lastMessageAt,unreadCount,isPinned,isMuted,isArchived,createdAt,updatedAt);

@override
String toString() {
  return 'ChatThreadModel(id: $id, type: $type, participantIds: $participantIds, displayName: $displayName, avatarUrl: $avatarUrl, avatarColor: $avatarColor, lastMessagePreview: $lastMessagePreview, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, isPinned: $isPinned, isMuted: $isMuted, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ChatThreadModelCopyWith<$Res>  {
  factory $ChatThreadModelCopyWith(ChatThreadModel value, $Res Function(ChatThreadModel) _then) = _$ChatThreadModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, List<String> participantIds, String displayName, String? avatarUrl, String? avatarColor, String? lastMessagePreview, DateTime? lastMessageAt, int unreadCount, bool isPinned, bool isMuted, bool isArchived, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ChatThreadModelCopyWithImpl<$Res>
    implements $ChatThreadModelCopyWith<$Res> {
  _$ChatThreadModelCopyWithImpl(this._self, this._then);

  final ChatThreadModel _self;
  final $Res Function(ChatThreadModel) _then;

/// Create a copy of ChatThreadModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? participantIds = null,Object? displayName = null,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? lastMessagePreview = freezed,Object? lastMessageAt = freezed,Object? unreadCount = null,Object? isPinned = null,Object? isMuted = null,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,lastMessagePreview: freezed == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatThreadModel].
extension ChatThreadModelPatterns on ChatThreadModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatThreadModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatThreadModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatThreadModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatThreadModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatThreadModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatThreadModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  List<String> participantIds,  String displayName,  String? avatarUrl,  String? avatarColor,  String? lastMessagePreview,  DateTime? lastMessageAt,  int unreadCount,  bool isPinned,  bool isMuted,  bool isArchived,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatThreadModel() when $default != null:
return $default(_that.id,_that.type,_that.participantIds,_that.displayName,_that.avatarUrl,_that.avatarColor,_that.lastMessagePreview,_that.lastMessageAt,_that.unreadCount,_that.isPinned,_that.isMuted,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  List<String> participantIds,  String displayName,  String? avatarUrl,  String? avatarColor,  String? lastMessagePreview,  DateTime? lastMessageAt,  int unreadCount,  bool isPinned,  bool isMuted,  bool isArchived,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatThreadModel():
return $default(_that.id,_that.type,_that.participantIds,_that.displayName,_that.avatarUrl,_that.avatarColor,_that.lastMessagePreview,_that.lastMessageAt,_that.unreadCount,_that.isPinned,_that.isMuted,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  List<String> participantIds,  String displayName,  String? avatarUrl,  String? avatarColor,  String? lastMessagePreview,  DateTime? lastMessageAt,  int unreadCount,  bool isPinned,  bool isMuted,  bool isArchived,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatThreadModel() when $default != null:
return $default(_that.id,_that.type,_that.participantIds,_that.displayName,_that.avatarUrl,_that.avatarColor,_that.lastMessagePreview,_that.lastMessageAt,_that.unreadCount,_that.isPinned,_that.isMuted,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ChatThreadModel extends ChatThreadModel {
  const _ChatThreadModel({required this.id, required this.type, required final  List<String> participantIds, required this.displayName, this.avatarUrl, this.avatarColor, this.lastMessagePreview, this.lastMessageAt, required this.unreadCount, required this.isPinned, required this.isMuted, required this.isArchived, required this.createdAt, this.updatedAt}): _participantIds = participantIds,super._();
  

@override final  String id;
@override final  String type;
 final  List<String> _participantIds;
@override List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}

@override final  String displayName;
@override final  String? avatarUrl;
@override final  String? avatarColor;
@override final  String? lastMessagePreview;
@override final  DateTime? lastMessageAt;
@override final  int unreadCount;
@override final  bool isPinned;
@override final  bool isMuted;
@override final  bool isArchived;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ChatThreadModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThreadModelCopyWith<_ChatThreadModel> get copyWith => __$ChatThreadModelCopyWithImpl<_ChatThreadModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatThreadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_participantIds),displayName,avatarUrl,avatarColor,lastMessagePreview,lastMessageAt,unreadCount,isPinned,isMuted,isArchived,createdAt,updatedAt);

@override
String toString() {
  return 'ChatThreadModel(id: $id, type: $type, participantIds: $participantIds, displayName: $displayName, avatarUrl: $avatarUrl, avatarColor: $avatarColor, lastMessagePreview: $lastMessagePreview, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, isPinned: $isPinned, isMuted: $isMuted, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatThreadModelCopyWith<$Res> implements $ChatThreadModelCopyWith<$Res> {
  factory _$ChatThreadModelCopyWith(_ChatThreadModel value, $Res Function(_ChatThreadModel) _then) = __$ChatThreadModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, List<String> participantIds, String displayName, String? avatarUrl, String? avatarColor, String? lastMessagePreview, DateTime? lastMessageAt, int unreadCount, bool isPinned, bool isMuted, bool isArchived, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ChatThreadModelCopyWithImpl<$Res>
    implements _$ChatThreadModelCopyWith<$Res> {
  __$ChatThreadModelCopyWithImpl(this._self, this._then);

  final _ChatThreadModel _self;
  final $Res Function(_ChatThreadModel) _then;

/// Create a copy of ChatThreadModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? participantIds = null,Object? displayName = null,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? lastMessagePreview = freezed,Object? lastMessageAt = freezed,Object? unreadCount = null,Object? isPinned = null,Object? isMuted = null,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_ChatThreadModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,lastMessagePreview: freezed == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
