// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeatureFlag {

 String get id; String get featureKey; bool get isEnabled; bool get isGlobal; List<String> get enabledCommunityIds; DateTime? get updatedAt;
/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagCopyWith<FeatureFlag> get copyWith => _$FeatureFlagCopyWithImpl<FeatureFlag>(this as FeatureFlag, _$identity);

  /// Serializes this FeatureFlag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlag&&(identical(other.id, id) || other.id == id)&&(identical(other.featureKey, featureKey) || other.featureKey == featureKey)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isGlobal, isGlobal) || other.isGlobal == isGlobal)&&const DeepCollectionEquality().equals(other.enabledCommunityIds, enabledCommunityIds)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,featureKey,isEnabled,isGlobal,const DeepCollectionEquality().hash(enabledCommunityIds),updatedAt);

@override
String toString() {
  return 'FeatureFlag(id: $id, featureKey: $featureKey, isEnabled: $isEnabled, isGlobal: $isGlobal, enabledCommunityIds: $enabledCommunityIds, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FeatureFlagCopyWith<$Res>  {
  factory $FeatureFlagCopyWith(FeatureFlag value, $Res Function(FeatureFlag) _then) = _$FeatureFlagCopyWithImpl;
@useResult
$Res call({
 String id, String featureKey, bool isEnabled, bool isGlobal, List<String> enabledCommunityIds, DateTime? updatedAt
});




}
/// @nodoc
class _$FeatureFlagCopyWithImpl<$Res>
    implements $FeatureFlagCopyWith<$Res> {
  _$FeatureFlagCopyWithImpl(this._self, this._then);

  final FeatureFlag _self;
  final $Res Function(FeatureFlag) _then;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureKey = null,Object? isEnabled = null,Object? isGlobal = null,Object? enabledCommunityIds = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureKey: null == featureKey ? _self.featureKey : featureKey // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isGlobal: null == isGlobal ? _self.isGlobal : isGlobal // ignore: cast_nullable_to_non_nullable
as bool,enabledCommunityIds: null == enabledCommunityIds ? _self.enabledCommunityIds : enabledCommunityIds // ignore: cast_nullable_to_non_nullable
as List<String>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeatureFlag].
extension FeatureFlagPatterns on FeatureFlag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeatureFlag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeatureFlag value)  $default,){
final _that = this;
switch (_that) {
case _FeatureFlag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeatureFlag value)?  $default,){
final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureKey,  bool isEnabled,  bool isGlobal,  List<String> enabledCommunityIds,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
return $default(_that.id,_that.featureKey,_that.isEnabled,_that.isGlobal,_that.enabledCommunityIds,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureKey,  bool isEnabled,  bool isGlobal,  List<String> enabledCommunityIds,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FeatureFlag():
return $default(_that.id,_that.featureKey,_that.isEnabled,_that.isGlobal,_that.enabledCommunityIds,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureKey,  bool isEnabled,  bool isGlobal,  List<String> enabledCommunityIds,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeatureFlag() when $default != null:
return $default(_that.id,_that.featureKey,_that.isEnabled,_that.isGlobal,_that.enabledCommunityIds,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeatureFlag extends FeatureFlag {
  const _FeatureFlag({required this.id, required this.featureKey, required this.isEnabled, required this.isGlobal, final  List<String> enabledCommunityIds = const [], this.updatedAt}): _enabledCommunityIds = enabledCommunityIds,super._();
  factory _FeatureFlag.fromJson(Map<String, dynamic> json) => _$FeatureFlagFromJson(json);

@override final  String id;
@override final  String featureKey;
@override final  bool isEnabled;
@override final  bool isGlobal;
 final  List<String> _enabledCommunityIds;
@override@JsonKey() List<String> get enabledCommunityIds {
  if (_enabledCommunityIds is EqualUnmodifiableListView) return _enabledCommunityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_enabledCommunityIds);
}

@override final  DateTime? updatedAt;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagCopyWith<_FeatureFlag> get copyWith => __$FeatureFlagCopyWithImpl<_FeatureFlag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeatureFlagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlag&&(identical(other.id, id) || other.id == id)&&(identical(other.featureKey, featureKey) || other.featureKey == featureKey)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isGlobal, isGlobal) || other.isGlobal == isGlobal)&&const DeepCollectionEquality().equals(other._enabledCommunityIds, _enabledCommunityIds)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,featureKey,isEnabled,isGlobal,const DeepCollectionEquality().hash(_enabledCommunityIds),updatedAt);

@override
String toString() {
  return 'FeatureFlag(id: $id, featureKey: $featureKey, isEnabled: $isEnabled, isGlobal: $isGlobal, enabledCommunityIds: $enabledCommunityIds, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagCopyWith<$Res> implements $FeatureFlagCopyWith<$Res> {
  factory _$FeatureFlagCopyWith(_FeatureFlag value, $Res Function(_FeatureFlag) _then) = __$FeatureFlagCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureKey, bool isEnabled, bool isGlobal, List<String> enabledCommunityIds, DateTime? updatedAt
});




}
/// @nodoc
class __$FeatureFlagCopyWithImpl<$Res>
    implements _$FeatureFlagCopyWith<$Res> {
  __$FeatureFlagCopyWithImpl(this._self, this._then);

  final _FeatureFlag _self;
  final $Res Function(_FeatureFlag) _then;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureKey = null,Object? isEnabled = null,Object? isGlobal = null,Object? enabledCommunityIds = null,Object? updatedAt = freezed,}) {
  return _then(_FeatureFlag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureKey: null == featureKey ? _self.featureKey : featureKey // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isGlobal: null == isGlobal ? _self.isGlobal : isGlobal // ignore: cast_nullable_to_non_nullable
as bool,enabledCommunityIds: null == enabledCommunityIds ? _self._enabledCommunityIds : enabledCommunityIds // ignore: cast_nullable_to_non_nullable
as List<String>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
