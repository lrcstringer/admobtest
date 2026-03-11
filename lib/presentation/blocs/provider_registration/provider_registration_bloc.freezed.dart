// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProviderRegistrationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderRegistrationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProviderRegistrationEvent()';
}


}

/// @nodoc
class $ProviderRegistrationEventCopyWith<$Res>  {
$ProviderRegistrationEventCopyWith(ProviderRegistrationEvent _, $Res Function(ProviderRegistrationEvent) __);
}


/// Adds pattern-matching-related methods to [ProviderRegistrationEvent].
extension ProviderRegistrationEventPatterns on ProviderRegistrationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UpdateName value)?  updateName,TResult Function( _UpdateBio value)?  updateBio,TResult Function( _UpdateServices value)?  updateServices,TResult Function( _UpdateCategory value)?  updateCategory,TResult Function( _SetPhoto value)?  setPhoto,TResult Function( _NextStep value)?  nextStep,TResult Function( _PreviousStep value)?  previousStep,TResult Function( _Submit value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateName() when updateName != null:
return updateName(_that);case _UpdateBio() when updateBio != null:
return updateBio(_that);case _UpdateServices() when updateServices != null:
return updateServices(_that);case _UpdateCategory() when updateCategory != null:
return updateCategory(_that);case _SetPhoto() when setPhoto != null:
return setPhoto(_that);case _NextStep() when nextStep != null:
return nextStep(_that);case _PreviousStep() when previousStep != null:
return previousStep(_that);case _Submit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UpdateName value)  updateName,required TResult Function( _UpdateBio value)  updateBio,required TResult Function( _UpdateServices value)  updateServices,required TResult Function( _UpdateCategory value)  updateCategory,required TResult Function( _SetPhoto value)  setPhoto,required TResult Function( _NextStep value)  nextStep,required TResult Function( _PreviousStep value)  previousStep,required TResult Function( _Submit value)  submit,}){
final _that = this;
switch (_that) {
case _UpdateName():
return updateName(_that);case _UpdateBio():
return updateBio(_that);case _UpdateServices():
return updateServices(_that);case _UpdateCategory():
return updateCategory(_that);case _SetPhoto():
return setPhoto(_that);case _NextStep():
return nextStep(_that);case _PreviousStep():
return previousStep(_that);case _Submit():
return submit(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UpdateName value)?  updateName,TResult? Function( _UpdateBio value)?  updateBio,TResult? Function( _UpdateServices value)?  updateServices,TResult? Function( _UpdateCategory value)?  updateCategory,TResult? Function( _SetPhoto value)?  setPhoto,TResult? Function( _NextStep value)?  nextStep,TResult? Function( _PreviousStep value)?  previousStep,TResult? Function( _Submit value)?  submit,}){
final _that = this;
switch (_that) {
case _UpdateName() when updateName != null:
return updateName(_that);case _UpdateBio() when updateBio != null:
return updateBio(_that);case _UpdateServices() when updateServices != null:
return updateServices(_that);case _UpdateCategory() when updateCategory != null:
return updateCategory(_that);case _SetPhoto() when setPhoto != null:
return setPhoto(_that);case _NextStep() when nextStep != null:
return nextStep(_that);case _PreviousStep() when previousStep != null:
return previousStep(_that);case _Submit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name)?  updateName,TResult Function( String bio)?  updateBio,TResult Function( String services)?  updateServices,TResult Function( MarketplaceCategory category)?  updateCategory,TResult Function( String photoPath)?  setPhoto,TResult Function()?  nextStep,TResult Function()?  previousStep,TResult Function()?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateName() when updateName != null:
return updateName(_that.name);case _UpdateBio() when updateBio != null:
return updateBio(_that.bio);case _UpdateServices() when updateServices != null:
return updateServices(_that.services);case _UpdateCategory() when updateCategory != null:
return updateCategory(_that.category);case _SetPhoto() when setPhoto != null:
return setPhoto(_that.photoPath);case _NextStep() when nextStep != null:
return nextStep();case _PreviousStep() when previousStep != null:
return previousStep();case _Submit() when submit != null:
return submit();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name)  updateName,required TResult Function( String bio)  updateBio,required TResult Function( String services)  updateServices,required TResult Function( MarketplaceCategory category)  updateCategory,required TResult Function( String photoPath)  setPhoto,required TResult Function()  nextStep,required TResult Function()  previousStep,required TResult Function()  submit,}) {final _that = this;
switch (_that) {
case _UpdateName():
return updateName(_that.name);case _UpdateBio():
return updateBio(_that.bio);case _UpdateServices():
return updateServices(_that.services);case _UpdateCategory():
return updateCategory(_that.category);case _SetPhoto():
return setPhoto(_that.photoPath);case _NextStep():
return nextStep();case _PreviousStep():
return previousStep();case _Submit():
return submit();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name)?  updateName,TResult? Function( String bio)?  updateBio,TResult? Function( String services)?  updateServices,TResult? Function( MarketplaceCategory category)?  updateCategory,TResult? Function( String photoPath)?  setPhoto,TResult? Function()?  nextStep,TResult? Function()?  previousStep,TResult? Function()?  submit,}) {final _that = this;
switch (_that) {
case _UpdateName() when updateName != null:
return updateName(_that.name);case _UpdateBio() when updateBio != null:
return updateBio(_that.bio);case _UpdateServices() when updateServices != null:
return updateServices(_that.services);case _UpdateCategory() when updateCategory != null:
return updateCategory(_that.category);case _SetPhoto() when setPhoto != null:
return setPhoto(_that.photoPath);case _NextStep() when nextStep != null:
return nextStep();case _PreviousStep() when previousStep != null:
return previousStep();case _Submit() when submit != null:
return submit();case _:
  return null;

}
}

}

/// @nodoc


class _UpdateName implements ProviderRegistrationEvent {
  const _UpdateName(this.name);
  

 final  String name;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNameCopyWith<_UpdateName> get copyWith => __$UpdateNameCopyWithImpl<_UpdateName>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateName&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'ProviderRegistrationEvent.updateName(name: $name)';
}


}

/// @nodoc
abstract mixin class _$UpdateNameCopyWith<$Res> implements $ProviderRegistrationEventCopyWith<$Res> {
  factory _$UpdateNameCopyWith(_UpdateName value, $Res Function(_UpdateName) _then) = __$UpdateNameCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$UpdateNameCopyWithImpl<$Res>
    implements _$UpdateNameCopyWith<$Res> {
  __$UpdateNameCopyWithImpl(this._self, this._then);

  final _UpdateName _self;
  final $Res Function(_UpdateName) _then;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_UpdateName(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateBio implements ProviderRegistrationEvent {
  const _UpdateBio(this.bio);
  

 final  String bio;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateBioCopyWith<_UpdateBio> get copyWith => __$UpdateBioCopyWithImpl<_UpdateBio>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateBio&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode => Object.hash(runtimeType,bio);

@override
String toString() {
  return 'ProviderRegistrationEvent.updateBio(bio: $bio)';
}


}

/// @nodoc
abstract mixin class _$UpdateBioCopyWith<$Res> implements $ProviderRegistrationEventCopyWith<$Res> {
  factory _$UpdateBioCopyWith(_UpdateBio value, $Res Function(_UpdateBio) _then) = __$UpdateBioCopyWithImpl;
@useResult
$Res call({
 String bio
});




}
/// @nodoc
class __$UpdateBioCopyWithImpl<$Res>
    implements _$UpdateBioCopyWith<$Res> {
  __$UpdateBioCopyWithImpl(this._self, this._then);

  final _UpdateBio _self;
  final $Res Function(_UpdateBio) _then;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bio = null,}) {
  return _then(_UpdateBio(
null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateServices implements ProviderRegistrationEvent {
  const _UpdateServices(this.services);
  

 final  String services;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateServicesCopyWith<_UpdateServices> get copyWith => __$UpdateServicesCopyWithImpl<_UpdateServices>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateServices&&(identical(other.services, services) || other.services == services));
}


@override
int get hashCode => Object.hash(runtimeType,services);

@override
String toString() {
  return 'ProviderRegistrationEvent.updateServices(services: $services)';
}


}

/// @nodoc
abstract mixin class _$UpdateServicesCopyWith<$Res> implements $ProviderRegistrationEventCopyWith<$Res> {
  factory _$UpdateServicesCopyWith(_UpdateServices value, $Res Function(_UpdateServices) _then) = __$UpdateServicesCopyWithImpl;
@useResult
$Res call({
 String services
});




}
/// @nodoc
class __$UpdateServicesCopyWithImpl<$Res>
    implements _$UpdateServicesCopyWith<$Res> {
  __$UpdateServicesCopyWithImpl(this._self, this._then);

  final _UpdateServices _self;
  final $Res Function(_UpdateServices) _then;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? services = null,}) {
  return _then(_UpdateServices(
null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateCategory implements ProviderRegistrationEvent {
  const _UpdateCategory(this.category);
  

 final  MarketplaceCategory category;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCategoryCopyWith<_UpdateCategory> get copyWith => __$UpdateCategoryCopyWithImpl<_UpdateCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCategory&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'ProviderRegistrationEvent.updateCategory(category: $category)';
}


}

/// @nodoc
abstract mixin class _$UpdateCategoryCopyWith<$Res> implements $ProviderRegistrationEventCopyWith<$Res> {
  factory _$UpdateCategoryCopyWith(_UpdateCategory value, $Res Function(_UpdateCategory) _then) = __$UpdateCategoryCopyWithImpl;
@useResult
$Res call({
 MarketplaceCategory category
});




}
/// @nodoc
class __$UpdateCategoryCopyWithImpl<$Res>
    implements _$UpdateCategoryCopyWith<$Res> {
  __$UpdateCategoryCopyWithImpl(this._self, this._then);

  final _UpdateCategory _self;
  final $Res Function(_UpdateCategory) _then;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,}) {
  return _then(_UpdateCategory(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MarketplaceCategory,
  ));
}


}

/// @nodoc


class _SetPhoto implements ProviderRegistrationEvent {
  const _SetPhoto(this.photoPath);
  

 final  String photoPath;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetPhotoCopyWith<_SetPhoto> get copyWith => __$SetPhotoCopyWithImpl<_SetPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetPhoto&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}


@override
int get hashCode => Object.hash(runtimeType,photoPath);

@override
String toString() {
  return 'ProviderRegistrationEvent.setPhoto(photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$SetPhotoCopyWith<$Res> implements $ProviderRegistrationEventCopyWith<$Res> {
  factory _$SetPhotoCopyWith(_SetPhoto value, $Res Function(_SetPhoto) _then) = __$SetPhotoCopyWithImpl;
@useResult
$Res call({
 String photoPath
});




}
/// @nodoc
class __$SetPhotoCopyWithImpl<$Res>
    implements _$SetPhotoCopyWith<$Res> {
  __$SetPhotoCopyWithImpl(this._self, this._then);

  final _SetPhoto _self;
  final $Res Function(_SetPhoto) _then;

/// Create a copy of ProviderRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photoPath = null,}) {
  return _then(_SetPhoto(
null == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NextStep implements ProviderRegistrationEvent {
  const _NextStep();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProviderRegistrationEvent.nextStep()';
}


}




/// @nodoc


class _PreviousStep implements ProviderRegistrationEvent {
  const _PreviousStep();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviousStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProviderRegistrationEvent.previousStep()';
}


}




/// @nodoc


class _Submit implements ProviderRegistrationEvent {
  const _Submit();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProviderRegistrationEvent.submit()';
}


}




/// @nodoc
mixin _$ProviderRegistrationState {

 int get currentStep; String get displayName; String get bio; String get servicesDescription; MarketplaceCategory? get selectedCategory; String? get photoPath; bool get isSubmitting; bool get isComplete; String? get errorMessage; String? get successMessage;
/// Create a copy of ProviderRegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderRegistrationStateCopyWith<ProviderRegistrationState> get copyWith => _$ProviderRegistrationStateCopyWithImpl<ProviderRegistrationState>(this as ProviderRegistrationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderRegistrationState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isComplete, isComplete) || other.isComplete == isComplete)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,displayName,bio,servicesDescription,selectedCategory,photoPath,isSubmitting,isComplete,errorMessage,successMessage);

@override
String toString() {
  return 'ProviderRegistrationState(currentStep: $currentStep, displayName: $displayName, bio: $bio, servicesDescription: $servicesDescription, selectedCategory: $selectedCategory, photoPath: $photoPath, isSubmitting: $isSubmitting, isComplete: $isComplete, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $ProviderRegistrationStateCopyWith<$Res>  {
  factory $ProviderRegistrationStateCopyWith(ProviderRegistrationState value, $Res Function(ProviderRegistrationState) _then) = _$ProviderRegistrationStateCopyWithImpl;
@useResult
$Res call({
 int currentStep, String displayName, String bio, String servicesDescription, MarketplaceCategory? selectedCategory, String? photoPath, bool isSubmitting, bool isComplete, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$ProviderRegistrationStateCopyWithImpl<$Res>
    implements $ProviderRegistrationStateCopyWith<$Res> {
  _$ProviderRegistrationStateCopyWithImpl(this._self, this._then);

  final ProviderRegistrationState _self;
  final $Res Function(ProviderRegistrationState) _then;

/// Create a copy of ProviderRegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? displayName = null,Object? bio = null,Object? servicesDescription = null,Object? selectedCategory = freezed,Object? photoPath = freezed,Object? isSubmitting = null,Object? isComplete = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,servicesDescription: null == servicesDescription ? _self.servicesDescription : servicesDescription // ignore: cast_nullable_to_non_nullable
as String,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as MarketplaceCategory?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isComplete: null == isComplete ? _self.isComplete : isComplete // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderRegistrationState].
extension ProviderRegistrationStatePatterns on ProviderRegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderRegistrationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderRegistrationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderRegistrationState value)  $default,){
final _that = this;
switch (_that) {
case _ProviderRegistrationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderRegistrationState value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderRegistrationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  String displayName,  String bio,  String servicesDescription,  MarketplaceCategory? selectedCategory,  String? photoPath,  bool isSubmitting,  bool isComplete,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderRegistrationState() when $default != null:
return $default(_that.currentStep,_that.displayName,_that.bio,_that.servicesDescription,_that.selectedCategory,_that.photoPath,_that.isSubmitting,_that.isComplete,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  String displayName,  String bio,  String servicesDescription,  MarketplaceCategory? selectedCategory,  String? photoPath,  bool isSubmitting,  bool isComplete,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _ProviderRegistrationState():
return $default(_that.currentStep,_that.displayName,_that.bio,_that.servicesDescription,_that.selectedCategory,_that.photoPath,_that.isSubmitting,_that.isComplete,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  String displayName,  String bio,  String servicesDescription,  MarketplaceCategory? selectedCategory,  String? photoPath,  bool isSubmitting,  bool isComplete,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProviderRegistrationState() when $default != null:
return $default(_that.currentStep,_that.displayName,_that.bio,_that.servicesDescription,_that.selectedCategory,_that.photoPath,_that.isSubmitting,_that.isComplete,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderRegistrationState implements ProviderRegistrationState {
  const _ProviderRegistrationState({this.currentStep = 0, this.displayName = '', this.bio = '', this.servicesDescription = '', this.selectedCategory, this.photoPath, this.isSubmitting = false, this.isComplete = false, this.errorMessage, this.successMessage});
  

@override@JsonKey() final  int currentStep;
@override@JsonKey() final  String displayName;
@override@JsonKey() final  String bio;
@override@JsonKey() final  String servicesDescription;
@override final  MarketplaceCategory? selectedCategory;
@override final  String? photoPath;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isComplete;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of ProviderRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderRegistrationStateCopyWith<_ProviderRegistrationState> get copyWith => __$ProviderRegistrationStateCopyWithImpl<_ProviderRegistrationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderRegistrationState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isComplete, isComplete) || other.isComplete == isComplete)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,displayName,bio,servicesDescription,selectedCategory,photoPath,isSubmitting,isComplete,errorMessage,successMessage);

@override
String toString() {
  return 'ProviderRegistrationState(currentStep: $currentStep, displayName: $displayName, bio: $bio, servicesDescription: $servicesDescription, selectedCategory: $selectedCategory, photoPath: $photoPath, isSubmitting: $isSubmitting, isComplete: $isComplete, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$ProviderRegistrationStateCopyWith<$Res> implements $ProviderRegistrationStateCopyWith<$Res> {
  factory _$ProviderRegistrationStateCopyWith(_ProviderRegistrationState value, $Res Function(_ProviderRegistrationState) _then) = __$ProviderRegistrationStateCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, String displayName, String bio, String servicesDescription, MarketplaceCategory? selectedCategory, String? photoPath, bool isSubmitting, bool isComplete, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$ProviderRegistrationStateCopyWithImpl<$Res>
    implements _$ProviderRegistrationStateCopyWith<$Res> {
  __$ProviderRegistrationStateCopyWithImpl(this._self, this._then);

  final _ProviderRegistrationState _self;
  final $Res Function(_ProviderRegistrationState) _then;

/// Create a copy of ProviderRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? displayName = null,Object? bio = null,Object? servicesDescription = null,Object? selectedCategory = freezed,Object? photoPath = freezed,Object? isSubmitting = null,Object? isComplete = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_ProviderRegistrationState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,servicesDescription: null == servicesDescription ? _self.servicesDescription : servicesDescription // ignore: cast_nullable_to_non_nullable
as String,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as MarketplaceCategory?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isComplete: null == isComplete ? _self.isComplete : isComplete // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
