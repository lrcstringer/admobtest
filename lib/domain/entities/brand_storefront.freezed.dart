// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuickAction {

 String get label; String get iconEmoji; String get deepLink; int get sortOrder;
/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickActionCopyWith<QuickAction> get copyWith => _$QuickActionCopyWithImpl<QuickAction>(this as QuickAction, _$identity);

  /// Serializes this QuickAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickAction&&(identical(other.label, label) || other.label == label)&&(identical(other.iconEmoji, iconEmoji) || other.iconEmoji == iconEmoji)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,iconEmoji,deepLink,sortOrder);

@override
String toString() {
  return 'QuickAction(label: $label, iconEmoji: $iconEmoji, deepLink: $deepLink, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $QuickActionCopyWith<$Res>  {
  factory $QuickActionCopyWith(QuickAction value, $Res Function(QuickAction) _then) = _$QuickActionCopyWithImpl;
@useResult
$Res call({
 String label, String iconEmoji, String deepLink, int sortOrder
});




}
/// @nodoc
class _$QuickActionCopyWithImpl<$Res>
    implements $QuickActionCopyWith<$Res> {
  _$QuickActionCopyWithImpl(this._self, this._then);

  final QuickAction _self;
  final $Res Function(QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? iconEmoji = null,Object? deepLink = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,iconEmoji: null == iconEmoji ? _self.iconEmoji : iconEmoji // ignore: cast_nullable_to_non_nullable
as String,deepLink: null == deepLink ? _self.deepLink : deepLink // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickAction].
extension QuickActionPatterns on QuickAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickAction value)  $default,){
final _that = this;
switch (_that) {
case _QuickAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickAction value)?  $default,){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String iconEmoji,  String deepLink,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.label,_that.iconEmoji,_that.deepLink,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String iconEmoji,  String deepLink,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _QuickAction():
return $default(_that.label,_that.iconEmoji,_that.deepLink,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String iconEmoji,  String deepLink,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.label,_that.iconEmoji,_that.deepLink,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuickAction implements QuickAction {
  const _QuickAction({required this.label, required this.iconEmoji, required this.deepLink, this.sortOrder = 0});
  factory _QuickAction.fromJson(Map<String, dynamic> json) => _$QuickActionFromJson(json);

@override final  String label;
@override final  String iconEmoji;
@override final  String deepLink;
@override@JsonKey() final  int sortOrder;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickActionCopyWith<_QuickAction> get copyWith => __$QuickActionCopyWithImpl<_QuickAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuickActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickAction&&(identical(other.label, label) || other.label == label)&&(identical(other.iconEmoji, iconEmoji) || other.iconEmoji == iconEmoji)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,iconEmoji,deepLink,sortOrder);

@override
String toString() {
  return 'QuickAction(label: $label, iconEmoji: $iconEmoji, deepLink: $deepLink, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$QuickActionCopyWith<$Res> implements $QuickActionCopyWith<$Res> {
  factory _$QuickActionCopyWith(_QuickAction value, $Res Function(_QuickAction) _then) = __$QuickActionCopyWithImpl;
@override @useResult
$Res call({
 String label, String iconEmoji, String deepLink, int sortOrder
});




}
/// @nodoc
class __$QuickActionCopyWithImpl<$Res>
    implements _$QuickActionCopyWith<$Res> {
  __$QuickActionCopyWithImpl(this._self, this._then);

  final _QuickAction _self;
  final $Res Function(_QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? iconEmoji = null,Object? deepLink = null,Object? sortOrder = null,}) {
  return _then(_QuickAction(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,iconEmoji: null == iconEmoji ? _self.iconEmoji : iconEmoji // ignore: cast_nullable_to_non_nullable
as String,deepLink: null == deepLink ? _self.deepLink : deepLink // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StorefrontPromo {

 String get title; String? get description; DateTime? get expiresAt; String? get deepLink;
/// Create a copy of StorefrontPromo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontPromoCopyWith<StorefrontPromo> get copyWith => _$StorefrontPromoCopyWithImpl<StorefrontPromo>(this as StorefrontPromo, _$identity);

  /// Serializes this StorefrontPromo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontPromo&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,expiresAt,deepLink);

@override
String toString() {
  return 'StorefrontPromo(title: $title, description: $description, expiresAt: $expiresAt, deepLink: $deepLink)';
}


}

/// @nodoc
abstract mixin class $StorefrontPromoCopyWith<$Res>  {
  factory $StorefrontPromoCopyWith(StorefrontPromo value, $Res Function(StorefrontPromo) _then) = _$StorefrontPromoCopyWithImpl;
@useResult
$Res call({
 String title, String? description, DateTime? expiresAt, String? deepLink
});




}
/// @nodoc
class _$StorefrontPromoCopyWithImpl<$Res>
    implements $StorefrontPromoCopyWith<$Res> {
  _$StorefrontPromoCopyWithImpl(this._self, this._then);

  final StorefrontPromo _self;
  final $Res Function(StorefrontPromo) _then;

/// Create a copy of StorefrontPromo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? expiresAt = freezed,Object? deepLink = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deepLink: freezed == deepLink ? _self.deepLink : deepLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontPromo].
extension StorefrontPromoPatterns on StorefrontPromo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontPromo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontPromo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontPromo value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontPromo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontPromo value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontPromo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  DateTime? expiresAt,  String? deepLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontPromo() when $default != null:
return $default(_that.title,_that.description,_that.expiresAt,_that.deepLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  DateTime? expiresAt,  String? deepLink)  $default,) {final _that = this;
switch (_that) {
case _StorefrontPromo():
return $default(_that.title,_that.description,_that.expiresAt,_that.deepLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  DateTime? expiresAt,  String? deepLink)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontPromo() when $default != null:
return $default(_that.title,_that.description,_that.expiresAt,_that.deepLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontPromo implements StorefrontPromo {
  const _StorefrontPromo({required this.title, this.description, this.expiresAt, this.deepLink});
  factory _StorefrontPromo.fromJson(Map<String, dynamic> json) => _$StorefrontPromoFromJson(json);

@override final  String title;
@override final  String? description;
@override final  DateTime? expiresAt;
@override final  String? deepLink;

/// Create a copy of StorefrontPromo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontPromoCopyWith<_StorefrontPromo> get copyWith => __$StorefrontPromoCopyWithImpl<_StorefrontPromo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontPromoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontPromo&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,expiresAt,deepLink);

@override
String toString() {
  return 'StorefrontPromo(title: $title, description: $description, expiresAt: $expiresAt, deepLink: $deepLink)';
}


}

/// @nodoc
abstract mixin class _$StorefrontPromoCopyWith<$Res> implements $StorefrontPromoCopyWith<$Res> {
  factory _$StorefrontPromoCopyWith(_StorefrontPromo value, $Res Function(_StorefrontPromo) _then) = __$StorefrontPromoCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, DateTime? expiresAt, String? deepLink
});




}
/// @nodoc
class __$StorefrontPromoCopyWithImpl<$Res>
    implements _$StorefrontPromoCopyWith<$Res> {
  __$StorefrontPromoCopyWithImpl(this._self, this._then);

  final _StorefrontPromo _self;
  final $Res Function(_StorefrontPromo) _then;

/// Create a copy of StorefrontPromo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? expiresAt = freezed,Object? deepLink = freezed,}) {
  return _then(_StorefrontPromo(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deepLink: freezed == deepLink ? _self.deepLink : deepLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StorefrontSection {

 String get type; String? get title; Map<String, dynamic> get data; int get sortOrder; bool get isVisible;
/// Create a copy of StorefrontSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontSectionCopyWith<StorefrontSection> get copyWith => _$StorefrontSectionCopyWithImpl<StorefrontSection>(this as StorefrontSection, _$identity);

  /// Serializes this StorefrontSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontSection&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(data),sortOrder,isVisible);

@override
String toString() {
  return 'StorefrontSection(type: $type, title: $title, data: $data, sortOrder: $sortOrder, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class $StorefrontSectionCopyWith<$Res>  {
  factory $StorefrontSectionCopyWith(StorefrontSection value, $Res Function(StorefrontSection) _then) = _$StorefrontSectionCopyWithImpl;
@useResult
$Res call({
 String type, String? title, Map<String, dynamic> data, int sortOrder, bool isVisible
});




}
/// @nodoc
class _$StorefrontSectionCopyWithImpl<$Res>
    implements $StorefrontSectionCopyWith<$Res> {
  _$StorefrontSectionCopyWithImpl(this._self, this._then);

  final StorefrontSection _self;
  final $Res Function(StorefrontSection) _then;

/// Create a copy of StorefrontSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = freezed,Object? data = null,Object? sortOrder = null,Object? isVisible = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontSection].
extension StorefrontSectionPatterns on StorefrontSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontSection value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontSection value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String? title,  Map<String, dynamic> data,  int sortOrder,  bool isVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontSection() when $default != null:
return $default(_that.type,_that.title,_that.data,_that.sortOrder,_that.isVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String? title,  Map<String, dynamic> data,  int sortOrder,  bool isVisible)  $default,) {final _that = this;
switch (_that) {
case _StorefrontSection():
return $default(_that.type,_that.title,_that.data,_that.sortOrder,_that.isVisible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String? title,  Map<String, dynamic> data,  int sortOrder,  bool isVisible)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontSection() when $default != null:
return $default(_that.type,_that.title,_that.data,_that.sortOrder,_that.isVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontSection implements StorefrontSection {
  const _StorefrontSection({required this.type, this.title, final  Map<String, dynamic> data = const {}, this.sortOrder = 0, this.isVisible = true}): _data = data;
  factory _StorefrontSection.fromJson(Map<String, dynamic> json) => _$StorefrontSectionFromJson(json);

@override final  String type;
@override final  String? title;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isVisible;

/// Create a copy of StorefrontSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontSectionCopyWith<_StorefrontSection> get copyWith => __$StorefrontSectionCopyWithImpl<_StorefrontSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontSection&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(_data),sortOrder,isVisible);

@override
String toString() {
  return 'StorefrontSection(type: $type, title: $title, data: $data, sortOrder: $sortOrder, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class _$StorefrontSectionCopyWith<$Res> implements $StorefrontSectionCopyWith<$Res> {
  factory _$StorefrontSectionCopyWith(_StorefrontSection value, $Res Function(_StorefrontSection) _then) = __$StorefrontSectionCopyWithImpl;
@override @useResult
$Res call({
 String type, String? title, Map<String, dynamic> data, int sortOrder, bool isVisible
});




}
/// @nodoc
class __$StorefrontSectionCopyWithImpl<$Res>
    implements _$StorefrontSectionCopyWith<$Res> {
  __$StorefrontSectionCopyWithImpl(this._self, this._then);

  final _StorefrontSection _self;
  final $Res Function(_StorefrontSection) _then;

/// Create a copy of StorefrontSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = freezed,Object? data = null,Object? sortOrder = null,Object? isVisible = null,}) {
  return _then(_StorefrontSection(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BrandStorefront {

 String get id; String get brandId; String get brandName; String? get brandLogoUrl;/// Hex color for brand tinting (e.g. "#E60000" for Vodacom red)
 String? get brandColor; String? get coverImageUrl; String? get tagline; bool get isActive; bool get isPremium;/// Community IDs this storefront targets (empty = global)
 List<String> get communityIds;/// Legacy sections (old format — read for migration)
 List<StorefrontSection> get sections; DateTime? get createdAt;// ── Hero Section ──
 HeroStyle get heroStyle; String? get heroImageUrl; String? get heroVideoUrl; String? get accentColor; String? get secondaryColor; LogoPlacement get logoPlacement;// ── Visual Identity ──
 StorefrontFontStyle get fontStyle; StorefrontCornerStyle get cornerStyle; StorefrontThemePreference get themePreference;// ── Content ──
 String? get description; String? get bannerImageUrl; String? get bannerDeepLink; int? get establishedYear;/// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
 Map<String, String> get socialLinks;// ── Trust & Social Proof ──
 List<TrustBadge> get trustBadges; double? get averageRating; int? get ratingCount;// ── Quick Actions ──
 List<QuickAction> get quickActions;// ── Gallery ──
 List<String> get galleryImageUrls;// ── Promotions ──
 List<StorefrontPromo> get promotions;// ── Layout ──
/// Ordered list of section types to display. Sections not in list are hidden.
 List<StorefrontSectionType> get sectionOrder;
/// Create a copy of BrandStorefront
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandStorefrontCopyWith<BrandStorefront> get copyWith => _$BrandStorefrontCopyWithImpl<BrandStorefront>(this as BrandStorefront, _$identity);

  /// Serializes this BrandStorefront to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandStorefront&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.brandColor, brandColor) || other.brandColor == brandColor)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&const DeepCollectionEquality().equals(other.communityIds, communityIds)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.heroStyle, heroStyle) || other.heroStyle == heroStyle)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.heroVideoUrl, heroVideoUrl) || other.heroVideoUrl == heroVideoUrl)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoPlacement, logoPlacement) || other.logoPlacement == logoPlacement)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.cornerStyle, cornerStyle) || other.cornerStyle == cornerStyle)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&(identical(other.bannerDeepLink, bannerDeepLink) || other.bannerDeepLink == bannerDeepLink)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks)&&const DeepCollectionEquality().equals(other.trustBadges, trustBadges)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.quickActions, quickActions)&&const DeepCollectionEquality().equals(other.galleryImageUrls, galleryImageUrls)&&const DeepCollectionEquality().equals(other.promotions, promotions)&&const DeepCollectionEquality().equals(other.sectionOrder, sectionOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,brandLogoUrl,brandColor,coverImageUrl,tagline,isActive,isPremium,const DeepCollectionEquality().hash(communityIds),const DeepCollectionEquality().hash(sections),createdAt,heroStyle,heroImageUrl,heroVideoUrl,accentColor,secondaryColor,logoPlacement,fontStyle,cornerStyle,themePreference,description,bannerImageUrl,bannerDeepLink,establishedYear,const DeepCollectionEquality().hash(socialLinks),const DeepCollectionEquality().hash(trustBadges),averageRating,ratingCount,const DeepCollectionEquality().hash(quickActions),const DeepCollectionEquality().hash(galleryImageUrls),const DeepCollectionEquality().hash(promotions),const DeepCollectionEquality().hash(sectionOrder)]);

@override
String toString() {
  return 'BrandStorefront(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder)';
}


}

/// @nodoc
abstract mixin class $BrandStorefrontCopyWith<$Res>  {
  factory $BrandStorefrontCopyWith(BrandStorefront value, $Res Function(BrandStorefront) _then) = _$BrandStorefrontCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String brandName, String? brandLogoUrl, String? brandColor, String? coverImageUrl, String? tagline, bool isActive, bool isPremium, List<String> communityIds, List<StorefrontSection> sections, DateTime? createdAt, HeroStyle heroStyle, String? heroImageUrl, String? heroVideoUrl, String? accentColor, String? secondaryColor, LogoPlacement logoPlacement, StorefrontFontStyle fontStyle, StorefrontCornerStyle cornerStyle, StorefrontThemePreference themePreference, String? description, String? bannerImageUrl, String? bannerDeepLink, int? establishedYear, Map<String, String> socialLinks, List<TrustBadge> trustBadges, double? averageRating, int? ratingCount, List<QuickAction> quickActions, List<String> galleryImageUrls, List<StorefrontPromo> promotions, List<StorefrontSectionType> sectionOrder
});




}
/// @nodoc
class _$BrandStorefrontCopyWithImpl<$Res>
    implements $BrandStorefrontCopyWith<$Res> {
  _$BrandStorefrontCopyWithImpl(this._self, this._then);

  final BrandStorefront _self;
  final $Res Function(BrandStorefront) _then;

/// Create a copy of BrandStorefront
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? brandColor = freezed,Object? coverImageUrl = freezed,Object? tagline = freezed,Object? isActive = null,Object? isPremium = null,Object? communityIds = null,Object? sections = null,Object? createdAt = freezed,Object? heroStyle = null,Object? heroImageUrl = freezed,Object? heroVideoUrl = freezed,Object? accentColor = freezed,Object? secondaryColor = freezed,Object? logoPlacement = null,Object? fontStyle = null,Object? cornerStyle = null,Object? themePreference = null,Object? description = freezed,Object? bannerImageUrl = freezed,Object? bannerDeepLink = freezed,Object? establishedYear = freezed,Object? socialLinks = null,Object? trustBadges = null,Object? averageRating = freezed,Object? ratingCount = freezed,Object? quickActions = null,Object? galleryImageUrls = null,Object? promotions = null,Object? sectionOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,brandColor: freezed == brandColor ? _self.brandColor : brandColor // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,communityIds: null == communityIds ? _self.communityIds : communityIds // ignore: cast_nullable_to_non_nullable
as List<String>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<StorefrontSection>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,heroStyle: null == heroStyle ? _self.heroStyle : heroStyle // ignore: cast_nullable_to_non_nullable
as HeroStyle,heroImageUrl: freezed == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String?,heroVideoUrl: freezed == heroVideoUrl ? _self.heroVideoUrl : heroVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,accentColor: freezed == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String?,secondaryColor: freezed == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String?,logoPlacement: null == logoPlacement ? _self.logoPlacement : logoPlacement // ignore: cast_nullable_to_non_nullable
as LogoPlacement,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as StorefrontFontStyle,cornerStyle: null == cornerStyle ? _self.cornerStyle : cornerStyle // ignore: cast_nullable_to_non_nullable
as StorefrontCornerStyle,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as StorefrontThemePreference,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bannerImageUrl: freezed == bannerImageUrl ? _self.bannerImageUrl : bannerImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerDeepLink: freezed == bannerDeepLink ? _self.bannerDeepLink : bannerDeepLink // ignore: cast_nullable_to_non_nullable
as String?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,socialLinks: null == socialLinks ? _self.socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustBadges: null == trustBadges ? _self.trustBadges : trustBadges // ignore: cast_nullable_to_non_nullable
as List<TrustBadge>,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,quickActions: null == quickActions ? _self.quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,galleryImageUrls: null == galleryImageUrls ? _self.galleryImageUrls : galleryImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as List<StorefrontPromo>,sectionOrder: null == sectionOrder ? _self.sectionOrder : sectionOrder // ignore: cast_nullable_to_non_nullable
as List<StorefrontSectionType>,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandStorefront].
extension BrandStorefrontPatterns on BrandStorefront {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandStorefront value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandStorefront() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandStorefront value)  $default,){
final _that = this;
switch (_that) {
case _BrandStorefront():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandStorefront value)?  $default,){
final _that = this;
switch (_that) {
case _BrandStorefront() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandStorefront() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder)  $default,) {final _that = this;
switch (_that) {
case _BrandStorefront():
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder)?  $default,) {final _that = this;
switch (_that) {
case _BrandStorefront() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BrandStorefront extends BrandStorefront {
  const _BrandStorefront({required this.id, required this.brandId, required this.brandName, this.brandLogoUrl, this.brandColor, this.coverImageUrl, this.tagline, this.isActive = true, this.isPremium = false, final  List<String> communityIds = const [], final  List<StorefrontSection> sections = const [], this.createdAt, this.heroStyle = HeroStyle.gradient, this.heroImageUrl, this.heroVideoUrl, this.accentColor, this.secondaryColor, this.logoPlacement = LogoPlacement.centered, this.fontStyle = StorefrontFontStyle.modern, this.cornerStyle = StorefrontCornerStyle.rounded, this.themePreference = StorefrontThemePreference.auto, this.description, this.bannerImageUrl, this.bannerDeepLink, this.establishedYear, final  Map<String, String> socialLinks = const {}, final  List<TrustBadge> trustBadges = const [], this.averageRating, this.ratingCount, final  List<QuickAction> quickActions = const [], final  List<String> galleryImageUrls = const [], final  List<StorefrontPromo> promotions = const [], final  List<StorefrontSectionType> sectionOrder = const []}): _communityIds = communityIds,_sections = sections,_socialLinks = socialLinks,_trustBadges = trustBadges,_quickActions = quickActions,_galleryImageUrls = galleryImageUrls,_promotions = promotions,_sectionOrder = sectionOrder,super._();
  factory _BrandStorefront.fromJson(Map<String, dynamic> json) => _$BrandStorefrontFromJson(json);

@override final  String id;
@override final  String brandId;
@override final  String brandName;
@override final  String? brandLogoUrl;
/// Hex color for brand tinting (e.g. "#E60000" for Vodacom red)
@override final  String? brandColor;
@override final  String? coverImageUrl;
@override final  String? tagline;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isPremium;
/// Community IDs this storefront targets (empty = global)
 final  List<String> _communityIds;
/// Community IDs this storefront targets (empty = global)
@override@JsonKey() List<String> get communityIds {
  if (_communityIds is EqualUnmodifiableListView) return _communityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communityIds);
}

/// Legacy sections (old format — read for migration)
 final  List<StorefrontSection> _sections;
/// Legacy sections (old format — read for migration)
@override@JsonKey() List<StorefrontSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  DateTime? createdAt;
// ── Hero Section ──
@override@JsonKey() final  HeroStyle heroStyle;
@override final  String? heroImageUrl;
@override final  String? heroVideoUrl;
@override final  String? accentColor;
@override final  String? secondaryColor;
@override@JsonKey() final  LogoPlacement logoPlacement;
// ── Visual Identity ──
@override@JsonKey() final  StorefrontFontStyle fontStyle;
@override@JsonKey() final  StorefrontCornerStyle cornerStyle;
@override@JsonKey() final  StorefrontThemePreference themePreference;
// ── Content ──
@override final  String? description;
@override final  String? bannerImageUrl;
@override final  String? bannerDeepLink;
@override final  int? establishedYear;
/// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
 final  Map<String, String> _socialLinks;
/// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
@override@JsonKey() Map<String, String> get socialLinks {
  if (_socialLinks is EqualUnmodifiableMapView) return _socialLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_socialLinks);
}

// ── Trust & Social Proof ──
 final  List<TrustBadge> _trustBadges;
// ── Trust & Social Proof ──
@override@JsonKey() List<TrustBadge> get trustBadges {
  if (_trustBadges is EqualUnmodifiableListView) return _trustBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trustBadges);
}

@override final  double? averageRating;
@override final  int? ratingCount;
// ── Quick Actions ──
 final  List<QuickAction> _quickActions;
// ── Quick Actions ──
@override@JsonKey() List<QuickAction> get quickActions {
  if (_quickActions is EqualUnmodifiableListView) return _quickActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quickActions);
}

// ── Gallery ──
 final  List<String> _galleryImageUrls;
// ── Gallery ──
@override@JsonKey() List<String> get galleryImageUrls {
  if (_galleryImageUrls is EqualUnmodifiableListView) return _galleryImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_galleryImageUrls);
}

// ── Promotions ──
 final  List<StorefrontPromo> _promotions;
// ── Promotions ──
@override@JsonKey() List<StorefrontPromo> get promotions {
  if (_promotions is EqualUnmodifiableListView) return _promotions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_promotions);
}

// ── Layout ──
/// Ordered list of section types to display. Sections not in list are hidden.
 final  List<StorefrontSectionType> _sectionOrder;
// ── Layout ──
/// Ordered list of section types to display. Sections not in list are hidden.
@override@JsonKey() List<StorefrontSectionType> get sectionOrder {
  if (_sectionOrder is EqualUnmodifiableListView) return _sectionOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectionOrder);
}


/// Create a copy of BrandStorefront
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandStorefrontCopyWith<_BrandStorefront> get copyWith => __$BrandStorefrontCopyWithImpl<_BrandStorefront>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrandStorefrontToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandStorefront&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.brandColor, brandColor) || other.brandColor == brandColor)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&const DeepCollectionEquality().equals(other._communityIds, _communityIds)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.heroStyle, heroStyle) || other.heroStyle == heroStyle)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.heroVideoUrl, heroVideoUrl) || other.heroVideoUrl == heroVideoUrl)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoPlacement, logoPlacement) || other.logoPlacement == logoPlacement)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.cornerStyle, cornerStyle) || other.cornerStyle == cornerStyle)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&(identical(other.bannerDeepLink, bannerDeepLink) || other.bannerDeepLink == bannerDeepLink)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks)&&const DeepCollectionEquality().equals(other._trustBadges, _trustBadges)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other._quickActions, _quickActions)&&const DeepCollectionEquality().equals(other._galleryImageUrls, _galleryImageUrls)&&const DeepCollectionEquality().equals(other._promotions, _promotions)&&const DeepCollectionEquality().equals(other._sectionOrder, _sectionOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,brandLogoUrl,brandColor,coverImageUrl,tagline,isActive,isPremium,const DeepCollectionEquality().hash(_communityIds),const DeepCollectionEquality().hash(_sections),createdAt,heroStyle,heroImageUrl,heroVideoUrl,accentColor,secondaryColor,logoPlacement,fontStyle,cornerStyle,themePreference,description,bannerImageUrl,bannerDeepLink,establishedYear,const DeepCollectionEquality().hash(_socialLinks),const DeepCollectionEquality().hash(_trustBadges),averageRating,ratingCount,const DeepCollectionEquality().hash(_quickActions),const DeepCollectionEquality().hash(_galleryImageUrls),const DeepCollectionEquality().hash(_promotions),const DeepCollectionEquality().hash(_sectionOrder)]);

@override
String toString() {
  return 'BrandStorefront(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder)';
}


}

/// @nodoc
abstract mixin class _$BrandStorefrontCopyWith<$Res> implements $BrandStorefrontCopyWith<$Res> {
  factory _$BrandStorefrontCopyWith(_BrandStorefront value, $Res Function(_BrandStorefront) _then) = __$BrandStorefrontCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String brandName, String? brandLogoUrl, String? brandColor, String? coverImageUrl, String? tagline, bool isActive, bool isPremium, List<String> communityIds, List<StorefrontSection> sections, DateTime? createdAt, HeroStyle heroStyle, String? heroImageUrl, String? heroVideoUrl, String? accentColor, String? secondaryColor, LogoPlacement logoPlacement, StorefrontFontStyle fontStyle, StorefrontCornerStyle cornerStyle, StorefrontThemePreference themePreference, String? description, String? bannerImageUrl, String? bannerDeepLink, int? establishedYear, Map<String, String> socialLinks, List<TrustBadge> trustBadges, double? averageRating, int? ratingCount, List<QuickAction> quickActions, List<String> galleryImageUrls, List<StorefrontPromo> promotions, List<StorefrontSectionType> sectionOrder
});




}
/// @nodoc
class __$BrandStorefrontCopyWithImpl<$Res>
    implements _$BrandStorefrontCopyWith<$Res> {
  __$BrandStorefrontCopyWithImpl(this._self, this._then);

  final _BrandStorefront _self;
  final $Res Function(_BrandStorefront) _then;

/// Create a copy of BrandStorefront
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? brandColor = freezed,Object? coverImageUrl = freezed,Object? tagline = freezed,Object? isActive = null,Object? isPremium = null,Object? communityIds = null,Object? sections = null,Object? createdAt = freezed,Object? heroStyle = null,Object? heroImageUrl = freezed,Object? heroVideoUrl = freezed,Object? accentColor = freezed,Object? secondaryColor = freezed,Object? logoPlacement = null,Object? fontStyle = null,Object? cornerStyle = null,Object? themePreference = null,Object? description = freezed,Object? bannerImageUrl = freezed,Object? bannerDeepLink = freezed,Object? establishedYear = freezed,Object? socialLinks = null,Object? trustBadges = null,Object? averageRating = freezed,Object? ratingCount = freezed,Object? quickActions = null,Object? galleryImageUrls = null,Object? promotions = null,Object? sectionOrder = null,}) {
  return _then(_BrandStorefront(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,brandColor: freezed == brandColor ? _self.brandColor : brandColor // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,communityIds: null == communityIds ? _self._communityIds : communityIds // ignore: cast_nullable_to_non_nullable
as List<String>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<StorefrontSection>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,heroStyle: null == heroStyle ? _self.heroStyle : heroStyle // ignore: cast_nullable_to_non_nullable
as HeroStyle,heroImageUrl: freezed == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String?,heroVideoUrl: freezed == heroVideoUrl ? _self.heroVideoUrl : heroVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,accentColor: freezed == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String?,secondaryColor: freezed == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String?,logoPlacement: null == logoPlacement ? _self.logoPlacement : logoPlacement // ignore: cast_nullable_to_non_nullable
as LogoPlacement,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as StorefrontFontStyle,cornerStyle: null == cornerStyle ? _self.cornerStyle : cornerStyle // ignore: cast_nullable_to_non_nullable
as StorefrontCornerStyle,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as StorefrontThemePreference,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bannerImageUrl: freezed == bannerImageUrl ? _self.bannerImageUrl : bannerImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerDeepLink: freezed == bannerDeepLink ? _self.bannerDeepLink : bannerDeepLink // ignore: cast_nullable_to_non_nullable
as String?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,socialLinks: null == socialLinks ? _self._socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustBadges: null == trustBadges ? _self._trustBadges : trustBadges // ignore: cast_nullable_to_non_nullable
as List<TrustBadge>,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,quickActions: null == quickActions ? _self._quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,galleryImageUrls: null == galleryImageUrls ? _self._galleryImageUrls : galleryImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,promotions: null == promotions ? _self._promotions : promotions // ignore: cast_nullable_to_non_nullable
as List<StorefrontPromo>,sectionOrder: null == sectionOrder ? _self._sectionOrder : sectionOrder // ignore: cast_nullable_to_non_nullable
as List<StorefrontSectionType>,
  ));
}


}

// dart format on
