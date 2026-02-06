// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'targeting_criteria.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TargetingCriteria _$TargetingCriteriaFromJson(Map<String, dynamic> json) {
  return _TargetingCriteria.fromJson(json);
}

/// @nodoc
mixin _$TargetingCriteria {
  /// Filter by gender(s)
  List<String>? get genders => throw _privateConstructorUsedError;

  /// Minimum age (inclusive)
  int? get ageMin => throw _privateConstructorUsedError;

  /// Maximum age (inclusive)
  int? get ageMax => throw _privateConstructorUsedError;

  /// Filter by SA province(s)
  List<String>? get provinces => throw _privateConstructorUsedError;

  /// Filter by city/cities
  List<String>? get cities => throw _privateConstructorUsedError;

  /// Filter by preferred language(s) - ANY match
  List<String>? get languages => throw _privateConstructorUsedError;

  /// Filter by interest categories - ANY match
  List<String>? get interests => throw _privateConstructorUsedError;

  /// Filter by device platform (android/ios)
  List<String>? get devicePlatforms => throw _privateConstructorUsedError;

  /// Minimum account age in days
  int? get accountAgeMinDays => throw _privateConstructorUsedError;

  /// Maximum account age in days
  int? get accountAgeMaxDays => throw _privateConstructorUsedError;

  /// Filter by engagement level (new/active/dormant)
  List<String>? get engagementLevel => throw _privateConstructorUsedError;

  /// "include" = only returning users, "exclude" = only new users
  String? get previousBrandInteraction => throw _privateConstructorUsedError;

  /// Maximum unique users who can engage with this thread
  int? get maxAudience => throw _privateConstructorUsedError;

  /// Serializes this TargetingCriteria to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TargetingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TargetingCriteriaCopyWith<TargetingCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetingCriteriaCopyWith<$Res> {
  factory $TargetingCriteriaCopyWith(
    TargetingCriteria value,
    $Res Function(TargetingCriteria) then,
  ) = _$TargetingCriteriaCopyWithImpl<$Res, TargetingCriteria>;
  @useResult
  $Res call({
    List<String>? genders,
    int? ageMin,
    int? ageMax,
    List<String>? provinces,
    List<String>? cities,
    List<String>? languages,
    List<String>? interests,
    List<String>? devicePlatforms,
    int? accountAgeMinDays,
    int? accountAgeMaxDays,
    List<String>? engagementLevel,
    String? previousBrandInteraction,
    int? maxAudience,
  });
}

/// @nodoc
class _$TargetingCriteriaCopyWithImpl<$Res, $Val extends TargetingCriteria>
    implements $TargetingCriteriaCopyWith<$Res> {
  _$TargetingCriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TargetingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genders = freezed,
    Object? ageMin = freezed,
    Object? ageMax = freezed,
    Object? provinces = freezed,
    Object? cities = freezed,
    Object? languages = freezed,
    Object? interests = freezed,
    Object? devicePlatforms = freezed,
    Object? accountAgeMinDays = freezed,
    Object? accountAgeMaxDays = freezed,
    Object? engagementLevel = freezed,
    Object? previousBrandInteraction = freezed,
    Object? maxAudience = freezed,
  }) {
    return _then(
      _value.copyWith(
            genders: freezed == genders
                ? _value.genders
                : genders // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            ageMin: freezed == ageMin
                ? _value.ageMin
                : ageMin // ignore: cast_nullable_to_non_nullable
                      as int?,
            ageMax: freezed == ageMax
                ? _value.ageMax
                : ageMax // ignore: cast_nullable_to_non_nullable
                      as int?,
            provinces: freezed == provinces
                ? _value.provinces
                : provinces // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            cities: freezed == cities
                ? _value.cities
                : cities // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            languages: freezed == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            interests: freezed == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            devicePlatforms: freezed == devicePlatforms
                ? _value.devicePlatforms
                : devicePlatforms // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            accountAgeMinDays: freezed == accountAgeMinDays
                ? _value.accountAgeMinDays
                : accountAgeMinDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            accountAgeMaxDays: freezed == accountAgeMaxDays
                ? _value.accountAgeMaxDays
                : accountAgeMaxDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            engagementLevel: freezed == engagementLevel
                ? _value.engagementLevel
                : engagementLevel // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            previousBrandInteraction: freezed == previousBrandInteraction
                ? _value.previousBrandInteraction
                : previousBrandInteraction // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxAudience: freezed == maxAudience
                ? _value.maxAudience
                : maxAudience // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TargetingCriteriaImplCopyWith<$Res>
    implements $TargetingCriteriaCopyWith<$Res> {
  factory _$$TargetingCriteriaImplCopyWith(
    _$TargetingCriteriaImpl value,
    $Res Function(_$TargetingCriteriaImpl) then,
  ) = __$$TargetingCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String>? genders,
    int? ageMin,
    int? ageMax,
    List<String>? provinces,
    List<String>? cities,
    List<String>? languages,
    List<String>? interests,
    List<String>? devicePlatforms,
    int? accountAgeMinDays,
    int? accountAgeMaxDays,
    List<String>? engagementLevel,
    String? previousBrandInteraction,
    int? maxAudience,
  });
}

/// @nodoc
class __$$TargetingCriteriaImplCopyWithImpl<$Res>
    extends _$TargetingCriteriaCopyWithImpl<$Res, _$TargetingCriteriaImpl>
    implements _$$TargetingCriteriaImplCopyWith<$Res> {
  __$$TargetingCriteriaImplCopyWithImpl(
    _$TargetingCriteriaImpl _value,
    $Res Function(_$TargetingCriteriaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TargetingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genders = freezed,
    Object? ageMin = freezed,
    Object? ageMax = freezed,
    Object? provinces = freezed,
    Object? cities = freezed,
    Object? languages = freezed,
    Object? interests = freezed,
    Object? devicePlatforms = freezed,
    Object? accountAgeMinDays = freezed,
    Object? accountAgeMaxDays = freezed,
    Object? engagementLevel = freezed,
    Object? previousBrandInteraction = freezed,
    Object? maxAudience = freezed,
  }) {
    return _then(
      _$TargetingCriteriaImpl(
        genders: freezed == genders
            ? _value._genders
            : genders // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        ageMin: freezed == ageMin
            ? _value.ageMin
            : ageMin // ignore: cast_nullable_to_non_nullable
                  as int?,
        ageMax: freezed == ageMax
            ? _value.ageMax
            : ageMax // ignore: cast_nullable_to_non_nullable
                  as int?,
        provinces: freezed == provinces
            ? _value._provinces
            : provinces // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        cities: freezed == cities
            ? _value._cities
            : cities // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        languages: freezed == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        interests: freezed == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        devicePlatforms: freezed == devicePlatforms
            ? _value._devicePlatforms
            : devicePlatforms // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        accountAgeMinDays: freezed == accountAgeMinDays
            ? _value.accountAgeMinDays
            : accountAgeMinDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        accountAgeMaxDays: freezed == accountAgeMaxDays
            ? _value.accountAgeMaxDays
            : accountAgeMaxDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        engagementLevel: freezed == engagementLevel
            ? _value._engagementLevel
            : engagementLevel // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        previousBrandInteraction: freezed == previousBrandInteraction
            ? _value.previousBrandInteraction
            : previousBrandInteraction // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxAudience: freezed == maxAudience
            ? _value.maxAudience
            : maxAudience // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetingCriteriaImpl extends _TargetingCriteria {
  const _$TargetingCriteriaImpl({
    final List<String>? genders,
    this.ageMin,
    this.ageMax,
    final List<String>? provinces,
    final List<String>? cities,
    final List<String>? languages,
    final List<String>? interests,
    final List<String>? devicePlatforms,
    this.accountAgeMinDays,
    this.accountAgeMaxDays,
    final List<String>? engagementLevel,
    this.previousBrandInteraction,
    this.maxAudience,
  }) : _genders = genders,
       _provinces = provinces,
       _cities = cities,
       _languages = languages,
       _interests = interests,
       _devicePlatforms = devicePlatforms,
       _engagementLevel = engagementLevel,
       super._();

  factory _$TargetingCriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetingCriteriaImplFromJson(json);

  /// Filter by gender(s)
  final List<String>? _genders;

  /// Filter by gender(s)
  @override
  List<String>? get genders {
    final value = _genders;
    if (value == null) return null;
    if (_genders is EqualUnmodifiableListView) return _genders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Minimum age (inclusive)
  @override
  final int? ageMin;

  /// Maximum age (inclusive)
  @override
  final int? ageMax;

  /// Filter by SA province(s)
  final List<String>? _provinces;

  /// Filter by SA province(s)
  @override
  List<String>? get provinces {
    final value = _provinces;
    if (value == null) return null;
    if (_provinces is EqualUnmodifiableListView) return _provinces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Filter by city/cities
  final List<String>? _cities;

  /// Filter by city/cities
  @override
  List<String>? get cities {
    final value = _cities;
    if (value == null) return null;
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Filter by preferred language(s) - ANY match
  final List<String>? _languages;

  /// Filter by preferred language(s) - ANY match
  @override
  List<String>? get languages {
    final value = _languages;
    if (value == null) return null;
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Filter by interest categories - ANY match
  final List<String>? _interests;

  /// Filter by interest categories - ANY match
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Filter by device platform (android/ios)
  final List<String>? _devicePlatforms;

  /// Filter by device platform (android/ios)
  @override
  List<String>? get devicePlatforms {
    final value = _devicePlatforms;
    if (value == null) return null;
    if (_devicePlatforms is EqualUnmodifiableListView) return _devicePlatforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Minimum account age in days
  @override
  final int? accountAgeMinDays;

  /// Maximum account age in days
  @override
  final int? accountAgeMaxDays;

  /// Filter by engagement level (new/active/dormant)
  final List<String>? _engagementLevel;

  /// Filter by engagement level (new/active/dormant)
  @override
  List<String>? get engagementLevel {
    final value = _engagementLevel;
    if (value == null) return null;
    if (_engagementLevel is EqualUnmodifiableListView) return _engagementLevel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// "include" = only returning users, "exclude" = only new users
  @override
  final String? previousBrandInteraction;

  /// Maximum unique users who can engage with this thread
  @override
  final int? maxAudience;

  @override
  String toString() {
    return 'TargetingCriteria(genders: $genders, ageMin: $ageMin, ageMax: $ageMax, provinces: $provinces, cities: $cities, languages: $languages, interests: $interests, devicePlatforms: $devicePlatforms, accountAgeMinDays: $accountAgeMinDays, accountAgeMaxDays: $accountAgeMaxDays, engagementLevel: $engagementLevel, previousBrandInteraction: $previousBrandInteraction, maxAudience: $maxAudience)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetingCriteriaImpl &&
            const DeepCollectionEquality().equals(other._genders, _genders) &&
            (identical(other.ageMin, ageMin) || other.ageMin == ageMin) &&
            (identical(other.ageMax, ageMax) || other.ageMax == ageMax) &&
            const DeepCollectionEquality().equals(
              other._provinces,
              _provinces,
            ) &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            const DeepCollectionEquality().equals(
              other._devicePlatforms,
              _devicePlatforms,
            ) &&
            (identical(other.accountAgeMinDays, accountAgeMinDays) ||
                other.accountAgeMinDays == accountAgeMinDays) &&
            (identical(other.accountAgeMaxDays, accountAgeMaxDays) ||
                other.accountAgeMaxDays == accountAgeMaxDays) &&
            const DeepCollectionEquality().equals(
              other._engagementLevel,
              _engagementLevel,
            ) &&
            (identical(
                  other.previousBrandInteraction,
                  previousBrandInteraction,
                ) ||
                other.previousBrandInteraction == previousBrandInteraction) &&
            (identical(other.maxAudience, maxAudience) ||
                other.maxAudience == maxAudience));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_genders),
    ageMin,
    ageMax,
    const DeepCollectionEquality().hash(_provinces),
    const DeepCollectionEquality().hash(_cities),
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_interests),
    const DeepCollectionEquality().hash(_devicePlatforms),
    accountAgeMinDays,
    accountAgeMaxDays,
    const DeepCollectionEquality().hash(_engagementLevel),
    previousBrandInteraction,
    maxAudience,
  );

  /// Create a copy of TargetingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetingCriteriaImplCopyWith<_$TargetingCriteriaImpl> get copyWith =>
      __$$TargetingCriteriaImplCopyWithImpl<_$TargetingCriteriaImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetingCriteriaImplToJson(this);
  }
}

abstract class _TargetingCriteria extends TargetingCriteria {
  const factory _TargetingCriteria({
    final List<String>? genders,
    final int? ageMin,
    final int? ageMax,
    final List<String>? provinces,
    final List<String>? cities,
    final List<String>? languages,
    final List<String>? interests,
    final List<String>? devicePlatforms,
    final int? accountAgeMinDays,
    final int? accountAgeMaxDays,
    final List<String>? engagementLevel,
    final String? previousBrandInteraction,
    final int? maxAudience,
  }) = _$TargetingCriteriaImpl;
  const _TargetingCriteria._() : super._();

  factory _TargetingCriteria.fromJson(Map<String, dynamic> json) =
      _$TargetingCriteriaImpl.fromJson;

  /// Filter by gender(s)
  @override
  List<String>? get genders;

  /// Minimum age (inclusive)
  @override
  int? get ageMin;

  /// Maximum age (inclusive)
  @override
  int? get ageMax;

  /// Filter by SA province(s)
  @override
  List<String>? get provinces;

  /// Filter by city/cities
  @override
  List<String>? get cities;

  /// Filter by preferred language(s) - ANY match
  @override
  List<String>? get languages;

  /// Filter by interest categories - ANY match
  @override
  List<String>? get interests;

  /// Filter by device platform (android/ios)
  @override
  List<String>? get devicePlatforms;

  /// Minimum account age in days
  @override
  int? get accountAgeMinDays;

  /// Maximum account age in days
  @override
  int? get accountAgeMaxDays;

  /// Filter by engagement level (new/active/dormant)
  @override
  List<String>? get engagementLevel;

  /// "include" = only returning users, "exclude" = only new users
  @override
  String? get previousBrandInteraction;

  /// Maximum unique users who can engage with this thread
  @override
  int? get maxAudience;

  /// Create a copy of TargetingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TargetingCriteriaImplCopyWith<_$TargetingCriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
