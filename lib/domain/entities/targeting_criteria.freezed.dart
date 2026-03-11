// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'targeting_criteria.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TargetingCriteria {

/// Filter by gender(s)
 List<String>? get genders;/// Minimum age (inclusive)
 int? get ageMin;/// Maximum age (inclusive)
 int? get ageMax;/// Filter by SA province(s)
 List<String>? get provinces;/// Filter by city/cities
 List<String>? get cities;/// Filter by preferred language(s) - ANY match
 List<String>? get languages;/// Filter by interest categories - ANY match
 List<String>? get interests;/// Filter by device platform (android/ios)
 List<String>? get devicePlatforms;/// Minimum account age in days
 int? get accountAgeMinDays;/// Maximum account age in days
 int? get accountAgeMaxDays;/// Filter by engagement level (new/active/dormant)
 List<String>? get engagementLevel;/// "include" = only returning users, "exclude" = only new users
 String? get previousBrandInteraction;/// Maximum unique users who can engage with this thread
 int? get maxAudience;
/// Create a copy of TargetingCriteria
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetingCriteriaCopyWith<TargetingCriteria> get copyWith => _$TargetingCriteriaCopyWithImpl<TargetingCriteria>(this as TargetingCriteria, _$identity);

  /// Serializes this TargetingCriteria to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetingCriteria&&const DeepCollectionEquality().equals(other.genders, genders)&&(identical(other.ageMin, ageMin) || other.ageMin == ageMin)&&(identical(other.ageMax, ageMax) || other.ageMax == ageMax)&&const DeepCollectionEquality().equals(other.provinces, provinces)&&const DeepCollectionEquality().equals(other.cities, cities)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.devicePlatforms, devicePlatforms)&&(identical(other.accountAgeMinDays, accountAgeMinDays) || other.accountAgeMinDays == accountAgeMinDays)&&(identical(other.accountAgeMaxDays, accountAgeMaxDays) || other.accountAgeMaxDays == accountAgeMaxDays)&&const DeepCollectionEquality().equals(other.engagementLevel, engagementLevel)&&(identical(other.previousBrandInteraction, previousBrandInteraction) || other.previousBrandInteraction == previousBrandInteraction)&&(identical(other.maxAudience, maxAudience) || other.maxAudience == maxAudience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(genders),ageMin,ageMax,const DeepCollectionEquality().hash(provinces),const DeepCollectionEquality().hash(cities),const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(devicePlatforms),accountAgeMinDays,accountAgeMaxDays,const DeepCollectionEquality().hash(engagementLevel),previousBrandInteraction,maxAudience);

@override
String toString() {
  return 'TargetingCriteria(genders: $genders, ageMin: $ageMin, ageMax: $ageMax, provinces: $provinces, cities: $cities, languages: $languages, interests: $interests, devicePlatforms: $devicePlatforms, accountAgeMinDays: $accountAgeMinDays, accountAgeMaxDays: $accountAgeMaxDays, engagementLevel: $engagementLevel, previousBrandInteraction: $previousBrandInteraction, maxAudience: $maxAudience)';
}


}

/// @nodoc
abstract mixin class $TargetingCriteriaCopyWith<$Res>  {
  factory $TargetingCriteriaCopyWith(TargetingCriteria value, $Res Function(TargetingCriteria) _then) = _$TargetingCriteriaCopyWithImpl;
@useResult
$Res call({
 List<String>? genders, int? ageMin, int? ageMax, List<String>? provinces, List<String>? cities, List<String>? languages, List<String>? interests, List<String>? devicePlatforms, int? accountAgeMinDays, int? accountAgeMaxDays, List<String>? engagementLevel, String? previousBrandInteraction, int? maxAudience
});




}
/// @nodoc
class _$TargetingCriteriaCopyWithImpl<$Res>
    implements $TargetingCriteriaCopyWith<$Res> {
  _$TargetingCriteriaCopyWithImpl(this._self, this._then);

  final TargetingCriteria _self;
  final $Res Function(TargetingCriteria) _then;

/// Create a copy of TargetingCriteria
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? genders = freezed,Object? ageMin = freezed,Object? ageMax = freezed,Object? provinces = freezed,Object? cities = freezed,Object? languages = freezed,Object? interests = freezed,Object? devicePlatforms = freezed,Object? accountAgeMinDays = freezed,Object? accountAgeMaxDays = freezed,Object? engagementLevel = freezed,Object? previousBrandInteraction = freezed,Object? maxAudience = freezed,}) {
  return _then(_self.copyWith(
genders: freezed == genders ? _self.genders : genders // ignore: cast_nullable_to_non_nullable
as List<String>?,ageMin: freezed == ageMin ? _self.ageMin : ageMin // ignore: cast_nullable_to_non_nullable
as int?,ageMax: freezed == ageMax ? _self.ageMax : ageMax // ignore: cast_nullable_to_non_nullable
as int?,provinces: freezed == provinces ? _self.provinces : provinces // ignore: cast_nullable_to_non_nullable
as List<String>?,cities: freezed == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<String>?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,devicePlatforms: freezed == devicePlatforms ? _self.devicePlatforms : devicePlatforms // ignore: cast_nullable_to_non_nullable
as List<String>?,accountAgeMinDays: freezed == accountAgeMinDays ? _self.accountAgeMinDays : accountAgeMinDays // ignore: cast_nullable_to_non_nullable
as int?,accountAgeMaxDays: freezed == accountAgeMaxDays ? _self.accountAgeMaxDays : accountAgeMaxDays // ignore: cast_nullable_to_non_nullable
as int?,engagementLevel: freezed == engagementLevel ? _self.engagementLevel : engagementLevel // ignore: cast_nullable_to_non_nullable
as List<String>?,previousBrandInteraction: freezed == previousBrandInteraction ? _self.previousBrandInteraction : previousBrandInteraction // ignore: cast_nullable_to_non_nullable
as String?,maxAudience: freezed == maxAudience ? _self.maxAudience : maxAudience // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TargetingCriteria].
extension TargetingCriteriaPatterns on TargetingCriteria {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TargetingCriteria value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TargetingCriteria() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TargetingCriteria value)  $default,){
final _that = this;
switch (_that) {
case _TargetingCriteria():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TargetingCriteria value)?  $default,){
final _that = this;
switch (_that) {
case _TargetingCriteria() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String>? genders,  int? ageMin,  int? ageMax,  List<String>? provinces,  List<String>? cities,  List<String>? languages,  List<String>? interests,  List<String>? devicePlatforms,  int? accountAgeMinDays,  int? accountAgeMaxDays,  List<String>? engagementLevel,  String? previousBrandInteraction,  int? maxAudience)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetingCriteria() when $default != null:
return $default(_that.genders,_that.ageMin,_that.ageMax,_that.provinces,_that.cities,_that.languages,_that.interests,_that.devicePlatforms,_that.accountAgeMinDays,_that.accountAgeMaxDays,_that.engagementLevel,_that.previousBrandInteraction,_that.maxAudience);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String>? genders,  int? ageMin,  int? ageMax,  List<String>? provinces,  List<String>? cities,  List<String>? languages,  List<String>? interests,  List<String>? devicePlatforms,  int? accountAgeMinDays,  int? accountAgeMaxDays,  List<String>? engagementLevel,  String? previousBrandInteraction,  int? maxAudience)  $default,) {final _that = this;
switch (_that) {
case _TargetingCriteria():
return $default(_that.genders,_that.ageMin,_that.ageMax,_that.provinces,_that.cities,_that.languages,_that.interests,_that.devicePlatforms,_that.accountAgeMinDays,_that.accountAgeMaxDays,_that.engagementLevel,_that.previousBrandInteraction,_that.maxAudience);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String>? genders,  int? ageMin,  int? ageMax,  List<String>? provinces,  List<String>? cities,  List<String>? languages,  List<String>? interests,  List<String>? devicePlatforms,  int? accountAgeMinDays,  int? accountAgeMaxDays,  List<String>? engagementLevel,  String? previousBrandInteraction,  int? maxAudience)?  $default,) {final _that = this;
switch (_that) {
case _TargetingCriteria() when $default != null:
return $default(_that.genders,_that.ageMin,_that.ageMax,_that.provinces,_that.cities,_that.languages,_that.interests,_that.devicePlatforms,_that.accountAgeMinDays,_that.accountAgeMaxDays,_that.engagementLevel,_that.previousBrandInteraction,_that.maxAudience);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TargetingCriteria extends TargetingCriteria {
  const _TargetingCriteria({final  List<String>? genders, this.ageMin, this.ageMax, final  List<String>? provinces, final  List<String>? cities, final  List<String>? languages, final  List<String>? interests, final  List<String>? devicePlatforms, this.accountAgeMinDays, this.accountAgeMaxDays, final  List<String>? engagementLevel, this.previousBrandInteraction, this.maxAudience}): _genders = genders,_provinces = provinces,_cities = cities,_languages = languages,_interests = interests,_devicePlatforms = devicePlatforms,_engagementLevel = engagementLevel,super._();
  factory _TargetingCriteria.fromJson(Map<String, dynamic> json) => _$TargetingCriteriaFromJson(json);

/// Filter by gender(s)
 final  List<String>? _genders;
/// Filter by gender(s)
@override List<String>? get genders {
  final value = _genders;
  if (value == null) return null;
  if (_genders is EqualUnmodifiableListView) return _genders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Minimum age (inclusive)
@override final  int? ageMin;
/// Maximum age (inclusive)
@override final  int? ageMax;
/// Filter by SA province(s)
 final  List<String>? _provinces;
/// Filter by SA province(s)
@override List<String>? get provinces {
  final value = _provinces;
  if (value == null) return null;
  if (_provinces is EqualUnmodifiableListView) return _provinces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Filter by city/cities
 final  List<String>? _cities;
/// Filter by city/cities
@override List<String>? get cities {
  final value = _cities;
  if (value == null) return null;
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Filter by preferred language(s) - ANY match
 final  List<String>? _languages;
/// Filter by preferred language(s) - ANY match
@override List<String>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Filter by interest categories - ANY match
 final  List<String>? _interests;
/// Filter by interest categories - ANY match
@override List<String>? get interests {
  final value = _interests;
  if (value == null) return null;
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Filter by device platform (android/ios)
 final  List<String>? _devicePlatforms;
/// Filter by device platform (android/ios)
@override List<String>? get devicePlatforms {
  final value = _devicePlatforms;
  if (value == null) return null;
  if (_devicePlatforms is EqualUnmodifiableListView) return _devicePlatforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Minimum account age in days
@override final  int? accountAgeMinDays;
/// Maximum account age in days
@override final  int? accountAgeMaxDays;
/// Filter by engagement level (new/active/dormant)
 final  List<String>? _engagementLevel;
/// Filter by engagement level (new/active/dormant)
@override List<String>? get engagementLevel {
  final value = _engagementLevel;
  if (value == null) return null;
  if (_engagementLevel is EqualUnmodifiableListView) return _engagementLevel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// "include" = only returning users, "exclude" = only new users
@override final  String? previousBrandInteraction;
/// Maximum unique users who can engage with this thread
@override final  int? maxAudience;

/// Create a copy of TargetingCriteria
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TargetingCriteriaCopyWith<_TargetingCriteria> get copyWith => __$TargetingCriteriaCopyWithImpl<_TargetingCriteria>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TargetingCriteriaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetingCriteria&&const DeepCollectionEquality().equals(other._genders, _genders)&&(identical(other.ageMin, ageMin) || other.ageMin == ageMin)&&(identical(other.ageMax, ageMax) || other.ageMax == ageMax)&&const DeepCollectionEquality().equals(other._provinces, _provinces)&&const DeepCollectionEquality().equals(other._cities, _cities)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._devicePlatforms, _devicePlatforms)&&(identical(other.accountAgeMinDays, accountAgeMinDays) || other.accountAgeMinDays == accountAgeMinDays)&&(identical(other.accountAgeMaxDays, accountAgeMaxDays) || other.accountAgeMaxDays == accountAgeMaxDays)&&const DeepCollectionEquality().equals(other._engagementLevel, _engagementLevel)&&(identical(other.previousBrandInteraction, previousBrandInteraction) || other.previousBrandInteraction == previousBrandInteraction)&&(identical(other.maxAudience, maxAudience) || other.maxAudience == maxAudience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_genders),ageMin,ageMax,const DeepCollectionEquality().hash(_provinces),const DeepCollectionEquality().hash(_cities),const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_devicePlatforms),accountAgeMinDays,accountAgeMaxDays,const DeepCollectionEquality().hash(_engagementLevel),previousBrandInteraction,maxAudience);

@override
String toString() {
  return 'TargetingCriteria(genders: $genders, ageMin: $ageMin, ageMax: $ageMax, provinces: $provinces, cities: $cities, languages: $languages, interests: $interests, devicePlatforms: $devicePlatforms, accountAgeMinDays: $accountAgeMinDays, accountAgeMaxDays: $accountAgeMaxDays, engagementLevel: $engagementLevel, previousBrandInteraction: $previousBrandInteraction, maxAudience: $maxAudience)';
}


}

/// @nodoc
abstract mixin class _$TargetingCriteriaCopyWith<$Res> implements $TargetingCriteriaCopyWith<$Res> {
  factory _$TargetingCriteriaCopyWith(_TargetingCriteria value, $Res Function(_TargetingCriteria) _then) = __$TargetingCriteriaCopyWithImpl;
@override @useResult
$Res call({
 List<String>? genders, int? ageMin, int? ageMax, List<String>? provinces, List<String>? cities, List<String>? languages, List<String>? interests, List<String>? devicePlatforms, int? accountAgeMinDays, int? accountAgeMaxDays, List<String>? engagementLevel, String? previousBrandInteraction, int? maxAudience
});




}
/// @nodoc
class __$TargetingCriteriaCopyWithImpl<$Res>
    implements _$TargetingCriteriaCopyWith<$Res> {
  __$TargetingCriteriaCopyWithImpl(this._self, this._then);

  final _TargetingCriteria _self;
  final $Res Function(_TargetingCriteria) _then;

/// Create a copy of TargetingCriteria
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? genders = freezed,Object? ageMin = freezed,Object? ageMax = freezed,Object? provinces = freezed,Object? cities = freezed,Object? languages = freezed,Object? interests = freezed,Object? devicePlatforms = freezed,Object? accountAgeMinDays = freezed,Object? accountAgeMaxDays = freezed,Object? engagementLevel = freezed,Object? previousBrandInteraction = freezed,Object? maxAudience = freezed,}) {
  return _then(_TargetingCriteria(
genders: freezed == genders ? _self._genders : genders // ignore: cast_nullable_to_non_nullable
as List<String>?,ageMin: freezed == ageMin ? _self.ageMin : ageMin // ignore: cast_nullable_to_non_nullable
as int?,ageMax: freezed == ageMax ? _self.ageMax : ageMax // ignore: cast_nullable_to_non_nullable
as int?,provinces: freezed == provinces ? _self._provinces : provinces // ignore: cast_nullable_to_non_nullable
as List<String>?,cities: freezed == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<String>?,languages: freezed == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,interests: freezed == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,devicePlatforms: freezed == devicePlatforms ? _self._devicePlatforms : devicePlatforms // ignore: cast_nullable_to_non_nullable
as List<String>?,accountAgeMinDays: freezed == accountAgeMinDays ? _self.accountAgeMinDays : accountAgeMinDays // ignore: cast_nullable_to_non_nullable
as int?,accountAgeMaxDays: freezed == accountAgeMaxDays ? _self.accountAgeMaxDays : accountAgeMaxDays // ignore: cast_nullable_to_non_nullable
as int?,engagementLevel: freezed == engagementLevel ? _self._engagementLevel : engagementLevel // ignore: cast_nullable_to_non_nullable
as List<String>?,previousBrandInteraction: freezed == previousBrandInteraction ? _self.previousBrandInteraction : previousBrandInteraction // ignore: cast_nullable_to_non_nullable
as String?,maxAudience: freezed == maxAudience ? _self.maxAudience : maxAudience // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
