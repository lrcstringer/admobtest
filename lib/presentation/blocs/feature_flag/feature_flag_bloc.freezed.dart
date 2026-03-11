// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeatureFlagEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlagEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeatureFlagEvent()';
}


}

/// @nodoc
class $FeatureFlagEventCopyWith<$Res>  {
$FeatureFlagEventCopyWith(FeatureFlagEvent _, $Res Function(FeatureFlagEvent) __);
}


/// Adds pattern-matching-related methods to [FeatureFlagEvent].
extension FeatureFlagEventPatterns on FeatureFlagEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadFeatureFlags value)?  loadFeatureFlags,TResult Function( _CheckFeature value)?  checkFeature,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadFeatureFlags() when loadFeatureFlags != null:
return loadFeatureFlags(_that);case _CheckFeature() when checkFeature != null:
return checkFeature(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadFeatureFlags value)  loadFeatureFlags,required TResult Function( _CheckFeature value)  checkFeature,}){
final _that = this;
switch (_that) {
case _LoadFeatureFlags():
return loadFeatureFlags(_that);case _CheckFeature():
return checkFeature(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadFeatureFlags value)?  loadFeatureFlags,TResult? Function( _CheckFeature value)?  checkFeature,}){
final _that = this;
switch (_that) {
case _LoadFeatureFlags() when loadFeatureFlags != null:
return loadFeatureFlags(_that);case _CheckFeature() when checkFeature != null:
return checkFeature(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadFeatureFlags,TResult Function( String featureKey,  String? communityId)?  checkFeature,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadFeatureFlags() when loadFeatureFlags != null:
return loadFeatureFlags();case _CheckFeature() when checkFeature != null:
return checkFeature(_that.featureKey,_that.communityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadFeatureFlags,required TResult Function( String featureKey,  String? communityId)  checkFeature,}) {final _that = this;
switch (_that) {
case _LoadFeatureFlags():
return loadFeatureFlags();case _CheckFeature():
return checkFeature(_that.featureKey,_that.communityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadFeatureFlags,TResult? Function( String featureKey,  String? communityId)?  checkFeature,}) {final _that = this;
switch (_that) {
case _LoadFeatureFlags() when loadFeatureFlags != null:
return loadFeatureFlags();case _CheckFeature() when checkFeature != null:
return checkFeature(_that.featureKey,_that.communityId);case _:
  return null;

}
}

}

/// @nodoc


class _LoadFeatureFlags implements FeatureFlagEvent {
  const _LoadFeatureFlags();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadFeatureFlags);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeatureFlagEvent.loadFeatureFlags()';
}


}




/// @nodoc


class _CheckFeature implements FeatureFlagEvent {
  const _CheckFeature({required this.featureKey, this.communityId});
  

 final  String featureKey;
 final  String? communityId;

/// Create a copy of FeatureFlagEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckFeatureCopyWith<_CheckFeature> get copyWith => __$CheckFeatureCopyWithImpl<_CheckFeature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckFeature&&(identical(other.featureKey, featureKey) || other.featureKey == featureKey)&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,featureKey,communityId);

@override
String toString() {
  return 'FeatureFlagEvent.checkFeature(featureKey: $featureKey, communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$CheckFeatureCopyWith<$Res> implements $FeatureFlagEventCopyWith<$Res> {
  factory _$CheckFeatureCopyWith(_CheckFeature value, $Res Function(_CheckFeature) _then) = __$CheckFeatureCopyWithImpl;
@useResult
$Res call({
 String featureKey, String? communityId
});




}
/// @nodoc
class __$CheckFeatureCopyWithImpl<$Res>
    implements _$CheckFeatureCopyWith<$Res> {
  __$CheckFeatureCopyWithImpl(this._self, this._then);

  final _CheckFeature _self;
  final $Res Function(_CheckFeature) _then;

/// Create a copy of FeatureFlagEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? featureKey = null,Object? communityId = freezed,}) {
  return _then(_CheckFeature(
featureKey: null == featureKey ? _self.featureKey : featureKey // ignore: cast_nullable_to_non_nullable
as String,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FeatureFlagState {

 bool get isLoading; List<FeatureFlag> get flags; Map<String, FeatureFlag> get flagMap; Map<String, bool> get featureChecks; String? get errorMessage;
/// Create a copy of FeatureFlagState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagStateCopyWith<FeatureFlagState> get copyWith => _$FeatureFlagStateCopyWithImpl<FeatureFlagState>(this as FeatureFlagState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlagState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.flags, flags)&&const DeepCollectionEquality().equals(other.flagMap, flagMap)&&const DeepCollectionEquality().equals(other.featureChecks, featureChecks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(flags),const DeepCollectionEquality().hash(flagMap),const DeepCollectionEquality().hash(featureChecks),errorMessage);

@override
String toString() {
  return 'FeatureFlagState(isLoading: $isLoading, flags: $flags, flagMap: $flagMap, featureChecks: $featureChecks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FeatureFlagStateCopyWith<$Res>  {
  factory $FeatureFlagStateCopyWith(FeatureFlagState value, $Res Function(FeatureFlagState) _then) = _$FeatureFlagStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<FeatureFlag> flags, Map<String, FeatureFlag> flagMap, Map<String, bool> featureChecks, String? errorMessage
});




}
/// @nodoc
class _$FeatureFlagStateCopyWithImpl<$Res>
    implements $FeatureFlagStateCopyWith<$Res> {
  _$FeatureFlagStateCopyWithImpl(this._self, this._then);

  final FeatureFlagState _self;
  final $Res Function(FeatureFlagState) _then;

/// Create a copy of FeatureFlagState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? flags = null,Object? flagMap = null,Object? featureChecks = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<FeatureFlag>,flagMap: null == flagMap ? _self.flagMap : flagMap // ignore: cast_nullable_to_non_nullable
as Map<String, FeatureFlag>,featureChecks: null == featureChecks ? _self.featureChecks : featureChecks // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeatureFlagState].
extension FeatureFlagStatePatterns on FeatureFlagState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeatureFlagState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeatureFlagState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeatureFlagState value)  $default,){
final _that = this;
switch (_that) {
case _FeatureFlagState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeatureFlagState value)?  $default,){
final _that = this;
switch (_that) {
case _FeatureFlagState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<FeatureFlag> flags,  Map<String, FeatureFlag> flagMap,  Map<String, bool> featureChecks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureFlagState() when $default != null:
return $default(_that.isLoading,_that.flags,_that.flagMap,_that.featureChecks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<FeatureFlag> flags,  Map<String, FeatureFlag> flagMap,  Map<String, bool> featureChecks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _FeatureFlagState():
return $default(_that.isLoading,_that.flags,_that.flagMap,_that.featureChecks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<FeatureFlag> flags,  Map<String, FeatureFlag> flagMap,  Map<String, bool> featureChecks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _FeatureFlagState() when $default != null:
return $default(_that.isLoading,_that.flags,_that.flagMap,_that.featureChecks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _FeatureFlagState implements FeatureFlagState {
  const _FeatureFlagState({this.isLoading = false, final  List<FeatureFlag> flags = const [], final  Map<String, FeatureFlag> flagMap = const {}, final  Map<String, bool> featureChecks = const {}, this.errorMessage}): _flags = flags,_flagMap = flagMap,_featureChecks = featureChecks;
  

@override@JsonKey() final  bool isLoading;
 final  List<FeatureFlag> _flags;
@override@JsonKey() List<FeatureFlag> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}

 final  Map<String, FeatureFlag> _flagMap;
@override@JsonKey() Map<String, FeatureFlag> get flagMap {
  if (_flagMap is EqualUnmodifiableMapView) return _flagMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_flagMap);
}

 final  Map<String, bool> _featureChecks;
@override@JsonKey() Map<String, bool> get featureChecks {
  if (_featureChecks is EqualUnmodifiableMapView) return _featureChecks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_featureChecks);
}

@override final  String? errorMessage;

/// Create a copy of FeatureFlagState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagStateCopyWith<_FeatureFlagState> get copyWith => __$FeatureFlagStateCopyWithImpl<_FeatureFlagState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlagState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._flags, _flags)&&const DeepCollectionEquality().equals(other._flagMap, _flagMap)&&const DeepCollectionEquality().equals(other._featureChecks, _featureChecks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_flags),const DeepCollectionEquality().hash(_flagMap),const DeepCollectionEquality().hash(_featureChecks),errorMessage);

@override
String toString() {
  return 'FeatureFlagState(isLoading: $isLoading, flags: $flags, flagMap: $flagMap, featureChecks: $featureChecks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagStateCopyWith<$Res> implements $FeatureFlagStateCopyWith<$Res> {
  factory _$FeatureFlagStateCopyWith(_FeatureFlagState value, $Res Function(_FeatureFlagState) _then) = __$FeatureFlagStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<FeatureFlag> flags, Map<String, FeatureFlag> flagMap, Map<String, bool> featureChecks, String? errorMessage
});




}
/// @nodoc
class __$FeatureFlagStateCopyWithImpl<$Res>
    implements _$FeatureFlagStateCopyWith<$Res> {
  __$FeatureFlagStateCopyWithImpl(this._self, this._then);

  final _FeatureFlagState _self;
  final $Res Function(_FeatureFlagState) _then;

/// Create a copy of FeatureFlagState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? flags = null,Object? flagMap = null,Object? featureChecks = null,Object? errorMessage = freezed,}) {
  return _then(_FeatureFlagState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<FeatureFlag>,flagMap: null == flagMap ? _self._flagMap : flagMap // ignore: cast_nullable_to_non_nullable
as Map<String, FeatureFlag>,featureChecks: null == featureChecks ? _self._featureChecks : featureChecks // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
