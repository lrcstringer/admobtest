// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProviderRegistrationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderRegistrationEventCopyWith<$Res> {
  factory $ProviderRegistrationEventCopyWith(
    ProviderRegistrationEvent value,
    $Res Function(ProviderRegistrationEvent) then,
  ) = _$ProviderRegistrationEventCopyWithImpl<$Res, ProviderRegistrationEvent>;
}

/// @nodoc
class _$ProviderRegistrationEventCopyWithImpl<
  $Res,
  $Val extends ProviderRegistrationEvent
>
    implements $ProviderRegistrationEventCopyWith<$Res> {
  _$ProviderRegistrationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UpdateNameImplCopyWith<$Res> {
  factory _$$UpdateNameImplCopyWith(
    _$UpdateNameImpl value,
    $Res Function(_$UpdateNameImpl) then,
  ) = __$$UpdateNameImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$UpdateNameImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$UpdateNameImpl>
    implements _$$UpdateNameImplCopyWith<$Res> {
  __$$UpdateNameImplCopyWithImpl(
    _$UpdateNameImpl _value,
    $Res Function(_$UpdateNameImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$UpdateNameImpl(
        null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateNameImpl implements _UpdateName {
  const _$UpdateNameImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'ProviderRegistrationEvent.updateName(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateNameImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateNameImplCopyWith<_$UpdateNameImpl> get copyWith =>
      __$$UpdateNameImplCopyWithImpl<_$UpdateNameImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return updateName(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return updateName?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (updateName != null) {
      return updateName(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return updateName(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return updateName?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (updateName != null) {
      return updateName(this);
    }
    return orElse();
  }
}

abstract class _UpdateName implements ProviderRegistrationEvent {
  const factory _UpdateName(final String name) = _$UpdateNameImpl;

  String get name;

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateNameImplCopyWith<_$UpdateNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateBioImplCopyWith<$Res> {
  factory _$$UpdateBioImplCopyWith(
    _$UpdateBioImpl value,
    $Res Function(_$UpdateBioImpl) then,
  ) = __$$UpdateBioImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String bio});
}

/// @nodoc
class __$$UpdateBioImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$UpdateBioImpl>
    implements _$$UpdateBioImplCopyWith<$Res> {
  __$$UpdateBioImplCopyWithImpl(
    _$UpdateBioImpl _value,
    $Res Function(_$UpdateBioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bio = null}) {
    return _then(
      _$UpdateBioImpl(
        null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateBioImpl implements _UpdateBio {
  const _$UpdateBioImpl(this.bio);

  @override
  final String bio;

  @override
  String toString() {
    return 'ProviderRegistrationEvent.updateBio(bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBioImpl &&
            (identical(other.bio, bio) || other.bio == bio));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bio);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBioImplCopyWith<_$UpdateBioImpl> get copyWith =>
      __$$UpdateBioImplCopyWithImpl<_$UpdateBioImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return updateBio(bio);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return updateBio?.call(bio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (updateBio != null) {
      return updateBio(bio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return updateBio(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return updateBio?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (updateBio != null) {
      return updateBio(this);
    }
    return orElse();
  }
}

abstract class _UpdateBio implements ProviderRegistrationEvent {
  const factory _UpdateBio(final String bio) = _$UpdateBioImpl;

  String get bio;

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBioImplCopyWith<_$UpdateBioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateServicesImplCopyWith<$Res> {
  factory _$$UpdateServicesImplCopyWith(
    _$UpdateServicesImpl value,
    $Res Function(_$UpdateServicesImpl) then,
  ) = __$$UpdateServicesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String services});
}

/// @nodoc
class __$$UpdateServicesImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$UpdateServicesImpl>
    implements _$$UpdateServicesImplCopyWith<$Res> {
  __$$UpdateServicesImplCopyWithImpl(
    _$UpdateServicesImpl _value,
    $Res Function(_$UpdateServicesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? services = null}) {
    return _then(
      _$UpdateServicesImpl(
        null == services
            ? _value.services
            : services // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateServicesImpl implements _UpdateServices {
  const _$UpdateServicesImpl(this.services);

  @override
  final String services;

  @override
  String toString() {
    return 'ProviderRegistrationEvent.updateServices(services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateServicesImpl &&
            (identical(other.services, services) ||
                other.services == services));
  }

  @override
  int get hashCode => Object.hash(runtimeType, services);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateServicesImplCopyWith<_$UpdateServicesImpl> get copyWith =>
      __$$UpdateServicesImplCopyWithImpl<_$UpdateServicesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return updateServices(services);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return updateServices?.call(services);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (updateServices != null) {
      return updateServices(services);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return updateServices(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return updateServices?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (updateServices != null) {
      return updateServices(this);
    }
    return orElse();
  }
}

abstract class _UpdateServices implements ProviderRegistrationEvent {
  const factory _UpdateServices(final String services) = _$UpdateServicesImpl;

  String get services;

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateServicesImplCopyWith<_$UpdateServicesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCategoryImplCopyWith<$Res> {
  factory _$$UpdateCategoryImplCopyWith(
    _$UpdateCategoryImpl value,
    $Res Function(_$UpdateCategoryImpl) then,
  ) = __$$UpdateCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MarketplaceCategory category});
}

/// @nodoc
class __$$UpdateCategoryImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$UpdateCategoryImpl>
    implements _$$UpdateCategoryImplCopyWith<$Res> {
  __$$UpdateCategoryImplCopyWithImpl(
    _$UpdateCategoryImpl _value,
    $Res Function(_$UpdateCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = null}) {
    return _then(
      _$UpdateCategoryImpl(
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as MarketplaceCategory,
      ),
    );
  }
}

/// @nodoc

class _$UpdateCategoryImpl implements _UpdateCategory {
  const _$UpdateCategoryImpl(this.category);

  @override
  final MarketplaceCategory category;

  @override
  String toString() {
    return 'ProviderRegistrationEvent.updateCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      __$$UpdateCategoryImplCopyWithImpl<_$UpdateCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return updateCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return updateCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return updateCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return updateCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(this);
    }
    return orElse();
  }
}

abstract class _UpdateCategory implements ProviderRegistrationEvent {
  const factory _UpdateCategory(final MarketplaceCategory category) =
      _$UpdateCategoryImpl;

  MarketplaceCategory get category;

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetPhotoImplCopyWith<$Res> {
  factory _$$SetPhotoImplCopyWith(
    _$SetPhotoImpl value,
    $Res Function(_$SetPhotoImpl) then,
  ) = __$$SetPhotoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String photoPath});
}

/// @nodoc
class __$$SetPhotoImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$SetPhotoImpl>
    implements _$$SetPhotoImplCopyWith<$Res> {
  __$$SetPhotoImplCopyWithImpl(
    _$SetPhotoImpl _value,
    $Res Function(_$SetPhotoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? photoPath = null}) {
    return _then(
      _$SetPhotoImpl(
        null == photoPath
            ? _value.photoPath
            : photoPath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SetPhotoImpl implements _SetPhoto {
  const _$SetPhotoImpl(this.photoPath);

  @override
  final String photoPath;

  @override
  String toString() {
    return 'ProviderRegistrationEvent.setPhoto(photoPath: $photoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetPhotoImpl &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, photoPath);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetPhotoImplCopyWith<_$SetPhotoImpl> get copyWith =>
      __$$SetPhotoImplCopyWithImpl<_$SetPhotoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return setPhoto(photoPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return setPhoto?.call(photoPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (setPhoto != null) {
      return setPhoto(photoPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return setPhoto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return setPhoto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (setPhoto != null) {
      return setPhoto(this);
    }
    return orElse();
  }
}

abstract class _SetPhoto implements ProviderRegistrationEvent {
  const factory _SetPhoto(final String photoPath) = _$SetPhotoImpl;

  String get photoPath;

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetPhotoImplCopyWith<_$SetPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NextStepImplCopyWith<$Res> {
  factory _$$NextStepImplCopyWith(
    _$NextStepImpl value,
    $Res Function(_$NextStepImpl) then,
  ) = __$$NextStepImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NextStepImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$NextStepImpl>
    implements _$$NextStepImplCopyWith<$Res> {
  __$$NextStepImplCopyWithImpl(
    _$NextStepImpl _value,
    $Res Function(_$NextStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NextStepImpl implements _NextStep {
  const _$NextStepImpl();

  @override
  String toString() {
    return 'ProviderRegistrationEvent.nextStep()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NextStepImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return nextStep();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return nextStep?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (nextStep != null) {
      return nextStep();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return nextStep(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return nextStep?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (nextStep != null) {
      return nextStep(this);
    }
    return orElse();
  }
}

abstract class _NextStep implements ProviderRegistrationEvent {
  const factory _NextStep() = _$NextStepImpl;
}

/// @nodoc
abstract class _$$PreviousStepImplCopyWith<$Res> {
  factory _$$PreviousStepImplCopyWith(
    _$PreviousStepImpl value,
    $Res Function(_$PreviousStepImpl) then,
  ) = __$$PreviousStepImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PreviousStepImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$PreviousStepImpl>
    implements _$$PreviousStepImplCopyWith<$Res> {
  __$$PreviousStepImplCopyWithImpl(
    _$PreviousStepImpl _value,
    $Res Function(_$PreviousStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PreviousStepImpl implements _PreviousStep {
  const _$PreviousStepImpl();

  @override
  String toString() {
    return 'ProviderRegistrationEvent.previousStep()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PreviousStepImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return previousStep();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return previousStep?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (previousStep != null) {
      return previousStep();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return previousStep(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return previousStep?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (previousStep != null) {
      return previousStep(this);
    }
    return orElse();
  }
}

abstract class _PreviousStep implements ProviderRegistrationEvent {
  const factory _PreviousStep() = _$PreviousStepImpl;
}

/// @nodoc
abstract class _$$SubmitImplCopyWith<$Res> {
  factory _$$SubmitImplCopyWith(
    _$SubmitImpl value,
    $Res Function(_$SubmitImpl) then,
  ) = __$$SubmitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitImplCopyWithImpl<$Res>
    extends _$ProviderRegistrationEventCopyWithImpl<$Res, _$SubmitImpl>
    implements _$$SubmitImplCopyWith<$Res> {
  __$$SubmitImplCopyWithImpl(
    _$SubmitImpl _value,
    $Res Function(_$SubmitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitImpl implements _Submit {
  const _$SubmitImpl();

  @override
  String toString() {
    return 'ProviderRegistrationEvent.submit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) updateName,
    required TResult Function(String bio) updateBio,
    required TResult Function(String services) updateServices,
    required TResult Function(MarketplaceCategory category) updateCategory,
    required TResult Function(String photoPath) setPhoto,
    required TResult Function() nextStep,
    required TResult Function() previousStep,
    required TResult Function() submit,
  }) {
    return submit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? updateName,
    TResult? Function(String bio)? updateBio,
    TResult? Function(String services)? updateServices,
    TResult? Function(MarketplaceCategory category)? updateCategory,
    TResult? Function(String photoPath)? setPhoto,
    TResult? Function()? nextStep,
    TResult? Function()? previousStep,
    TResult? Function()? submit,
  }) {
    return submit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? updateName,
    TResult Function(String bio)? updateBio,
    TResult Function(String services)? updateServices,
    TResult Function(MarketplaceCategory category)? updateCategory,
    TResult Function(String photoPath)? setPhoto,
    TResult Function()? nextStep,
    TResult Function()? previousStep,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateName value) updateName,
    required TResult Function(_UpdateBio value) updateBio,
    required TResult Function(_UpdateServices value) updateServices,
    required TResult Function(_UpdateCategory value) updateCategory,
    required TResult Function(_SetPhoto value) setPhoto,
    required TResult Function(_NextStep value) nextStep,
    required TResult Function(_PreviousStep value) previousStep,
    required TResult Function(_Submit value) submit,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdateName value)? updateName,
    TResult? Function(_UpdateBio value)? updateBio,
    TResult? Function(_UpdateServices value)? updateServices,
    TResult? Function(_UpdateCategory value)? updateCategory,
    TResult? Function(_SetPhoto value)? setPhoto,
    TResult? Function(_NextStep value)? nextStep,
    TResult? Function(_PreviousStep value)? previousStep,
    TResult? Function(_Submit value)? submit,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateName value)? updateName,
    TResult Function(_UpdateBio value)? updateBio,
    TResult Function(_UpdateServices value)? updateServices,
    TResult Function(_UpdateCategory value)? updateCategory,
    TResult Function(_SetPhoto value)? setPhoto,
    TResult Function(_NextStep value)? nextStep,
    TResult Function(_PreviousStep value)? previousStep,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class _Submit implements ProviderRegistrationEvent {
  const factory _Submit() = _$SubmitImpl;
}

/// @nodoc
mixin _$ProviderRegistrationState {
  int get currentStep => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String get servicesDescription => throw _privateConstructorUsedError;
  MarketplaceCategory? get selectedCategory =>
      throw _privateConstructorUsedError;
  String? get photoPath => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of ProviderRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProviderRegistrationStateCopyWith<ProviderRegistrationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderRegistrationStateCopyWith<$Res> {
  factory $ProviderRegistrationStateCopyWith(
    ProviderRegistrationState value,
    $Res Function(ProviderRegistrationState) then,
  ) = _$ProviderRegistrationStateCopyWithImpl<$Res, ProviderRegistrationState>;
  @useResult
  $Res call({
    int currentStep,
    String displayName,
    String bio,
    String servicesDescription,
    MarketplaceCategory? selectedCategory,
    String? photoPath,
    bool isSubmitting,
    bool isComplete,
    String? errorMessage,
    String? successMessage,
  });
}

/// @nodoc
class _$ProviderRegistrationStateCopyWithImpl<
  $Res,
  $Val extends ProviderRegistrationState
>
    implements $ProviderRegistrationStateCopyWith<$Res> {
  _$ProviderRegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProviderRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? displayName = null,
    Object? bio = null,
    Object? servicesDescription = null,
    Object? selectedCategory = freezed,
    Object? photoPath = freezed,
    Object? isSubmitting = null,
    Object? isComplete = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: null == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String,
            servicesDescription: null == servicesDescription
                ? _value.servicesDescription
                : servicesDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedCategory: freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as MarketplaceCategory?,
            photoPath: freezed == photoPath
                ? _value.photoPath
                : photoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            isComplete: null == isComplete
                ? _value.isComplete
                : isComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProviderRegistrationStateImplCopyWith<$Res>
    implements $ProviderRegistrationStateCopyWith<$Res> {
  factory _$$ProviderRegistrationStateImplCopyWith(
    _$ProviderRegistrationStateImpl value,
    $Res Function(_$ProviderRegistrationStateImpl) then,
  ) = __$$ProviderRegistrationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentStep,
    String displayName,
    String bio,
    String servicesDescription,
    MarketplaceCategory? selectedCategory,
    String? photoPath,
    bool isSubmitting,
    bool isComplete,
    String? errorMessage,
    String? successMessage,
  });
}

/// @nodoc
class __$$ProviderRegistrationStateImplCopyWithImpl<$Res>
    extends
        _$ProviderRegistrationStateCopyWithImpl<
          $Res,
          _$ProviderRegistrationStateImpl
        >
    implements _$$ProviderRegistrationStateImplCopyWith<$Res> {
  __$$ProviderRegistrationStateImplCopyWithImpl(
    _$ProviderRegistrationStateImpl _value,
    $Res Function(_$ProviderRegistrationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? displayName = null,
    Object? bio = null,
    Object? servicesDescription = null,
    Object? selectedCategory = freezed,
    Object? photoPath = freezed,
    Object? isSubmitting = null,
    Object? isComplete = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$ProviderRegistrationStateImpl(
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
        servicesDescription: null == servicesDescription
            ? _value.servicesDescription
            : servicesDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as MarketplaceCategory?,
        photoPath: freezed == photoPath
            ? _value.photoPath
            : photoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        isComplete: null == isComplete
            ? _value.isComplete
            : isComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ProviderRegistrationStateImpl implements _ProviderRegistrationState {
  const _$ProviderRegistrationStateImpl({
    this.currentStep = 0,
    this.displayName = '',
    this.bio = '',
    this.servicesDescription = '',
    this.selectedCategory,
    this.photoPath,
    this.isSubmitting = false,
    this.isComplete = false,
    this.errorMessage,
    this.successMessage,
  });

  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String bio;
  @override
  @JsonKey()
  final String servicesDescription;
  @override
  final MarketplaceCategory? selectedCategory;
  @override
  final String? photoPath;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isComplete;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'ProviderRegistrationState(currentStep: $currentStep, displayName: $displayName, bio: $bio, servicesDescription: $servicesDescription, selectedCategory: $selectedCategory, photoPath: $photoPath, isSubmitting: $isSubmitting, isComplete: $isComplete, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderRegistrationStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.servicesDescription, servicesDescription) ||
                other.servicesDescription == servicesDescription) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentStep,
    displayName,
    bio,
    servicesDescription,
    selectedCategory,
    photoPath,
    isSubmitting,
    isComplete,
    errorMessage,
    successMessage,
  );

  /// Create a copy of ProviderRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderRegistrationStateImplCopyWith<_$ProviderRegistrationStateImpl>
  get copyWith =>
      __$$ProviderRegistrationStateImplCopyWithImpl<
        _$ProviderRegistrationStateImpl
      >(this, _$identity);
}

abstract class _ProviderRegistrationState implements ProviderRegistrationState {
  const factory _ProviderRegistrationState({
    final int currentStep,
    final String displayName,
    final String bio,
    final String servicesDescription,
    final MarketplaceCategory? selectedCategory,
    final String? photoPath,
    final bool isSubmitting,
    final bool isComplete,
    final String? errorMessage,
    final String? successMessage,
  }) = _$ProviderRegistrationStateImpl;

  @override
  int get currentStep;
  @override
  String get displayName;
  @override
  String get bio;
  @override
  String get servicesDescription;
  @override
  MarketplaceCategory? get selectedCategory;
  @override
  String? get photoPath;
  @override
  bool get isSubmitting;
  @override
  bool get isComplete;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of ProviderRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProviderRegistrationStateImplCopyWith<_$ProviderRegistrationStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
