// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InboxClient {

 String get clientId; String get clientName; String? get clientAvatarImage; String? get clientAvatarColor; bool get isPinned; bool get isFeatured; int get activeThreadCount; List<InboxThread> get threads;
/// Create a copy of InboxClient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxClientCopyWith<InboxClient> get copyWith => _$InboxClientCopyWithImpl<InboxClient>(this as InboxClient, _$identity);

  /// Serializes this InboxClient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxClient&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.activeThreadCount, activeThreadCount) || other.activeThreadCount == activeThreadCount)&&const DeepCollectionEquality().equals(other.threads, threads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,clientName,clientAvatarImage,clientAvatarColor,isPinned,isFeatured,activeThreadCount,const DeepCollectionEquality().hash(threads));

@override
String toString() {
  return 'InboxClient(clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, isPinned: $isPinned, isFeatured: $isFeatured, activeThreadCount: $activeThreadCount, threads: $threads)';
}


}

/// @nodoc
abstract mixin class $InboxClientCopyWith<$Res>  {
  factory $InboxClientCopyWith(InboxClient value, $Res Function(InboxClient) _then) = _$InboxClientCopyWithImpl;
@useResult
$Res call({
 String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, bool isPinned, bool isFeatured, int activeThreadCount, List<InboxThread> threads
});




}
/// @nodoc
class _$InboxClientCopyWithImpl<$Res>
    implements $InboxClientCopyWith<$Res> {
  _$InboxClientCopyWithImpl(this._self, this._then);

  final InboxClient _self;
  final $Res Function(InboxClient) _then;

/// Create a copy of InboxClient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? clientName = null,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? isPinned = null,Object? isFeatured = null,Object? activeThreadCount = null,Object? threads = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,activeThreadCount: null == activeThreadCount ? _self.activeThreadCount : activeThreadCount // ignore: cast_nullable_to_non_nullable
as int,threads: null == threads ? _self.threads : threads // ignore: cast_nullable_to_non_nullable
as List<InboxThread>,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxClient].
extension InboxClientPatterns on InboxClient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxClient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxClient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxClient value)  $default,){
final _that = this;
switch (_that) {
case _InboxClient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxClient value)?  $default,){
final _that = this;
switch (_that) {
case _InboxClient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  bool isPinned,  bool isFeatured,  int activeThreadCount,  List<InboxThread> threads)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxClient() when $default != null:
return $default(_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.isPinned,_that.isFeatured,_that.activeThreadCount,_that.threads);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  bool isPinned,  bool isFeatured,  int activeThreadCount,  List<InboxThread> threads)  $default,) {final _that = this;
switch (_that) {
case _InboxClient():
return $default(_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.isPinned,_that.isFeatured,_that.activeThreadCount,_that.threads);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  bool isPinned,  bool isFeatured,  int activeThreadCount,  List<InboxThread> threads)?  $default,) {final _that = this;
switch (_that) {
case _InboxClient() when $default != null:
return $default(_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.isPinned,_that.isFeatured,_that.activeThreadCount,_that.threads);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InboxClient extends InboxClient {
  const _InboxClient({required this.clientId, required this.clientName, this.clientAvatarImage, this.clientAvatarColor, required this.isPinned, required this.isFeatured, required this.activeThreadCount, required final  List<InboxThread> threads}): _threads = threads,super._();
  factory _InboxClient.fromJson(Map<String, dynamic> json) => _$InboxClientFromJson(json);

@override final  String clientId;
@override final  String clientName;
@override final  String? clientAvatarImage;
@override final  String? clientAvatarColor;
@override final  bool isPinned;
@override final  bool isFeatured;
@override final  int activeThreadCount;
 final  List<InboxThread> _threads;
@override List<InboxThread> get threads {
  if (_threads is EqualUnmodifiableListView) return _threads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_threads);
}


/// Create a copy of InboxClient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxClientCopyWith<_InboxClient> get copyWith => __$InboxClientCopyWithImpl<_InboxClient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InboxClientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxClient&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.activeThreadCount, activeThreadCount) || other.activeThreadCount == activeThreadCount)&&const DeepCollectionEquality().equals(other._threads, _threads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,clientName,clientAvatarImage,clientAvatarColor,isPinned,isFeatured,activeThreadCount,const DeepCollectionEquality().hash(_threads));

@override
String toString() {
  return 'InboxClient(clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, isPinned: $isPinned, isFeatured: $isFeatured, activeThreadCount: $activeThreadCount, threads: $threads)';
}


}

/// @nodoc
abstract mixin class _$InboxClientCopyWith<$Res> implements $InboxClientCopyWith<$Res> {
  factory _$InboxClientCopyWith(_InboxClient value, $Res Function(_InboxClient) _then) = __$InboxClientCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, bool isPinned, bool isFeatured, int activeThreadCount, List<InboxThread> threads
});




}
/// @nodoc
class __$InboxClientCopyWithImpl<$Res>
    implements _$InboxClientCopyWith<$Res> {
  __$InboxClientCopyWithImpl(this._self, this._then);

  final _InboxClient _self;
  final $Res Function(_InboxClient) _then;

/// Create a copy of InboxClient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? clientName = null,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? isPinned = null,Object? isFeatured = null,Object? activeThreadCount = null,Object? threads = null,}) {
  return _then(_InboxClient(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,activeThreadCount: null == activeThreadCount ? _self.activeThreadCount : activeThreadCount // ignore: cast_nullable_to_non_nullable
as int,threads: null == threads ? _self._threads : threads // ignore: cast_nullable_to_non_nullable
as List<InboxThread>,
  ));
}


}

// dart format on
