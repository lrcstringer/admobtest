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



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickAction&&(identical(other.label, label) || other.label == label)&&(identical(other.iconEmoji, iconEmoji) || other.iconEmoji == iconEmoji)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


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


class _QuickAction implements QuickAction {
  const _QuickAction({required this.label, required this.iconEmoji, required this.deepLink, this.sortOrder = 0});
  

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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickAction&&(identical(other.label, label) || other.label == label)&&(identical(other.iconEmoji, iconEmoji) || other.iconEmoji == iconEmoji)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


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



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontPromo&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink));
}


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


class _StorefrontPromo implements StorefrontPromo {
  const _StorefrontPromo({required this.title, this.description, this.expiresAt, this.deepLink});
  

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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontPromo&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deepLink, deepLink) || other.deepLink == deepLink));
}


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



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontSection&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}


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


class _StorefrontSection implements StorefrontSection {
  const _StorefrontSection({required this.type, this.title, final  Map<String, dynamic> data = const {}, this.sortOrder = 0, this.isVisible = true}): _data = data;
  

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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontSection&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}


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
mixin _$SectionSettings {

 SectionColourMode get colourMode; String? get customBgColor; String? get customTextColor; String? get headingOverride; bool get isVisible; String get contentAlignment; double get paddingTop; double get paddingBottom;
/// Create a copy of SectionSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionSettingsCopyWith<SectionSettings> get copyWith => _$SectionSettingsCopyWithImpl<SectionSettings>(this as SectionSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionSettings&&(identical(other.colourMode, colourMode) || other.colourMode == colourMode)&&(identical(other.customBgColor, customBgColor) || other.customBgColor == customBgColor)&&(identical(other.customTextColor, customTextColor) || other.customTextColor == customTextColor)&&(identical(other.headingOverride, headingOverride) || other.headingOverride == headingOverride)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.contentAlignment, contentAlignment) || other.contentAlignment == contentAlignment)&&(identical(other.paddingTop, paddingTop) || other.paddingTop == paddingTop)&&(identical(other.paddingBottom, paddingBottom) || other.paddingBottom == paddingBottom));
}


@override
int get hashCode => Object.hash(runtimeType,colourMode,customBgColor,customTextColor,headingOverride,isVisible,contentAlignment,paddingTop,paddingBottom);

@override
String toString() {
  return 'SectionSettings(colourMode: $colourMode, customBgColor: $customBgColor, customTextColor: $customTextColor, headingOverride: $headingOverride, isVisible: $isVisible, contentAlignment: $contentAlignment, paddingTop: $paddingTop, paddingBottom: $paddingBottom)';
}


}

/// @nodoc
abstract mixin class $SectionSettingsCopyWith<$Res>  {
  factory $SectionSettingsCopyWith(SectionSettings value, $Res Function(SectionSettings) _then) = _$SectionSettingsCopyWithImpl;
@useResult
$Res call({
 SectionColourMode colourMode, String? customBgColor, String? customTextColor, String? headingOverride, bool isVisible, String contentAlignment, double paddingTop, double paddingBottom
});




}
/// @nodoc
class _$SectionSettingsCopyWithImpl<$Res>
    implements $SectionSettingsCopyWith<$Res> {
  _$SectionSettingsCopyWithImpl(this._self, this._then);

  final SectionSettings _self;
  final $Res Function(SectionSettings) _then;

/// Create a copy of SectionSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colourMode = null,Object? customBgColor = freezed,Object? customTextColor = freezed,Object? headingOverride = freezed,Object? isVisible = null,Object? contentAlignment = null,Object? paddingTop = null,Object? paddingBottom = null,}) {
  return _then(_self.copyWith(
colourMode: null == colourMode ? _self.colourMode : colourMode // ignore: cast_nullable_to_non_nullable
as SectionColourMode,customBgColor: freezed == customBgColor ? _self.customBgColor : customBgColor // ignore: cast_nullable_to_non_nullable
as String?,customTextColor: freezed == customTextColor ? _self.customTextColor : customTextColor // ignore: cast_nullable_to_non_nullable
as String?,headingOverride: freezed == headingOverride ? _self.headingOverride : headingOverride // ignore: cast_nullable_to_non_nullable
as String?,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,contentAlignment: null == contentAlignment ? _self.contentAlignment : contentAlignment // ignore: cast_nullable_to_non_nullable
as String,paddingTop: null == paddingTop ? _self.paddingTop : paddingTop // ignore: cast_nullable_to_non_nullable
as double,paddingBottom: null == paddingBottom ? _self.paddingBottom : paddingBottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SectionSettings].
extension SectionSettingsPatterns on SectionSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectionSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectionSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectionSettings value)  $default,){
final _that = this;
switch (_that) {
case _SectionSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectionSettings value)?  $default,){
final _that = this;
switch (_that) {
case _SectionSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SectionColourMode colourMode,  String? customBgColor,  String? customTextColor,  String? headingOverride,  bool isVisible,  String contentAlignment,  double paddingTop,  double paddingBottom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectionSettings() when $default != null:
return $default(_that.colourMode,_that.customBgColor,_that.customTextColor,_that.headingOverride,_that.isVisible,_that.contentAlignment,_that.paddingTop,_that.paddingBottom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SectionColourMode colourMode,  String? customBgColor,  String? customTextColor,  String? headingOverride,  bool isVisible,  String contentAlignment,  double paddingTop,  double paddingBottom)  $default,) {final _that = this;
switch (_that) {
case _SectionSettings():
return $default(_that.colourMode,_that.customBgColor,_that.customTextColor,_that.headingOverride,_that.isVisible,_that.contentAlignment,_that.paddingTop,_that.paddingBottom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SectionColourMode colourMode,  String? customBgColor,  String? customTextColor,  String? headingOverride,  bool isVisible,  String contentAlignment,  double paddingTop,  double paddingBottom)?  $default,) {final _that = this;
switch (_that) {
case _SectionSettings() when $default != null:
return $default(_that.colourMode,_that.customBgColor,_that.customTextColor,_that.headingOverride,_that.isVisible,_that.contentAlignment,_that.paddingTop,_that.paddingBottom);case _:
  return null;

}
}

}

/// @nodoc


class _SectionSettings implements SectionSettings {
  const _SectionSettings({this.colourMode = SectionColourMode.brandLight, this.customBgColor, this.customTextColor, this.headingOverride, this.isVisible = true, this.contentAlignment = 'center', this.paddingTop = 16.0, this.paddingBottom = 16.0});
  

@override@JsonKey() final  SectionColourMode colourMode;
@override final  String? customBgColor;
@override final  String? customTextColor;
@override final  String? headingOverride;
@override@JsonKey() final  bool isVisible;
@override@JsonKey() final  String contentAlignment;
@override@JsonKey() final  double paddingTop;
@override@JsonKey() final  double paddingBottom;

/// Create a copy of SectionSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionSettingsCopyWith<_SectionSettings> get copyWith => __$SectionSettingsCopyWithImpl<_SectionSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionSettings&&(identical(other.colourMode, colourMode) || other.colourMode == colourMode)&&(identical(other.customBgColor, customBgColor) || other.customBgColor == customBgColor)&&(identical(other.customTextColor, customTextColor) || other.customTextColor == customTextColor)&&(identical(other.headingOverride, headingOverride) || other.headingOverride == headingOverride)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.contentAlignment, contentAlignment) || other.contentAlignment == contentAlignment)&&(identical(other.paddingTop, paddingTop) || other.paddingTop == paddingTop)&&(identical(other.paddingBottom, paddingBottom) || other.paddingBottom == paddingBottom));
}


@override
int get hashCode => Object.hash(runtimeType,colourMode,customBgColor,customTextColor,headingOverride,isVisible,contentAlignment,paddingTop,paddingBottom);

@override
String toString() {
  return 'SectionSettings(colourMode: $colourMode, customBgColor: $customBgColor, customTextColor: $customTextColor, headingOverride: $headingOverride, isVisible: $isVisible, contentAlignment: $contentAlignment, paddingTop: $paddingTop, paddingBottom: $paddingBottom)';
}


}

/// @nodoc
abstract mixin class _$SectionSettingsCopyWith<$Res> implements $SectionSettingsCopyWith<$Res> {
  factory _$SectionSettingsCopyWith(_SectionSettings value, $Res Function(_SectionSettings) _then) = __$SectionSettingsCopyWithImpl;
@override @useResult
$Res call({
 SectionColourMode colourMode, String? customBgColor, String? customTextColor, String? headingOverride, bool isVisible, String contentAlignment, double paddingTop, double paddingBottom
});




}
/// @nodoc
class __$SectionSettingsCopyWithImpl<$Res>
    implements _$SectionSettingsCopyWith<$Res> {
  __$SectionSettingsCopyWithImpl(this._self, this._then);

  final _SectionSettings _self;
  final $Res Function(_SectionSettings) _then;

/// Create a copy of SectionSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colourMode = null,Object? customBgColor = freezed,Object? customTextColor = freezed,Object? headingOverride = freezed,Object? isVisible = null,Object? contentAlignment = null,Object? paddingTop = null,Object? paddingBottom = null,}) {
  return _then(_SectionSettings(
colourMode: null == colourMode ? _self.colourMode : colourMode // ignore: cast_nullable_to_non_nullable
as SectionColourMode,customBgColor: freezed == customBgColor ? _self.customBgColor : customBgColor // ignore: cast_nullable_to_non_nullable
as String?,customTextColor: freezed == customTextColor ? _self.customTextColor : customTextColor // ignore: cast_nullable_to_non_nullable
as String?,headingOverride: freezed == headingOverride ? _self.headingOverride : headingOverride // ignore: cast_nullable_to_non_nullable
as String?,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,contentAlignment: null == contentAlignment ? _self.contentAlignment : contentAlignment // ignore: cast_nullable_to_non_nullable
as String,paddingTop: null == paddingTop ? _self.paddingTop : paddingTop // ignore: cast_nullable_to_non_nullable
as double,paddingBottom: null == paddingBottom ? _self.paddingBottom : paddingBottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ShowcaseVideo {

 String get url; String? get thumbnailUrl; String? get title; int get sortOrder;
/// Create a copy of ShowcaseVideo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowcaseVideoCopyWith<ShowcaseVideo> get copyWith => _$ShowcaseVideoCopyWithImpl<ShowcaseVideo>(this as ShowcaseVideo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowcaseVideo&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,url,thumbnailUrl,title,sortOrder);

@override
String toString() {
  return 'ShowcaseVideo(url: $url, thumbnailUrl: $thumbnailUrl, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ShowcaseVideoCopyWith<$Res>  {
  factory $ShowcaseVideoCopyWith(ShowcaseVideo value, $Res Function(ShowcaseVideo) _then) = _$ShowcaseVideoCopyWithImpl;
@useResult
$Res call({
 String url, String? thumbnailUrl, String? title, int sortOrder
});




}
/// @nodoc
class _$ShowcaseVideoCopyWithImpl<$Res>
    implements $ShowcaseVideoCopyWith<$Res> {
  _$ShowcaseVideoCopyWithImpl(this._self, this._then);

  final ShowcaseVideo _self;
  final $Res Function(ShowcaseVideo) _then;

/// Create a copy of ShowcaseVideo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? thumbnailUrl = freezed,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShowcaseVideo].
extension ShowcaseVideoPatterns on ShowcaseVideo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShowcaseVideo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShowcaseVideo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShowcaseVideo value)  $default,){
final _that = this;
switch (_that) {
case _ShowcaseVideo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShowcaseVideo value)?  $default,){
final _that = this;
switch (_that) {
case _ShowcaseVideo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? thumbnailUrl,  String? title,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShowcaseVideo() when $default != null:
return $default(_that.url,_that.thumbnailUrl,_that.title,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? thumbnailUrl,  String? title,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ShowcaseVideo():
return $default(_that.url,_that.thumbnailUrl,_that.title,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? thumbnailUrl,  String? title,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ShowcaseVideo() when $default != null:
return $default(_that.url,_that.thumbnailUrl,_that.title,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _ShowcaseVideo implements ShowcaseVideo {
  const _ShowcaseVideo({required this.url, this.thumbnailUrl, this.title, this.sortOrder = 0});
  

@override final  String url;
@override final  String? thumbnailUrl;
@override final  String? title;
@override@JsonKey() final  int sortOrder;

/// Create a copy of ShowcaseVideo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShowcaseVideoCopyWith<_ShowcaseVideo> get copyWith => __$ShowcaseVideoCopyWithImpl<_ShowcaseVideo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowcaseVideo&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,url,thumbnailUrl,title,sortOrder);

@override
String toString() {
  return 'ShowcaseVideo(url: $url, thumbnailUrl: $thumbnailUrl, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ShowcaseVideoCopyWith<$Res> implements $ShowcaseVideoCopyWith<$Res> {
  factory _$ShowcaseVideoCopyWith(_ShowcaseVideo value, $Res Function(_ShowcaseVideo) _then) = __$ShowcaseVideoCopyWithImpl;
@override @useResult
$Res call({
 String url, String? thumbnailUrl, String? title, int sortOrder
});




}
/// @nodoc
class __$ShowcaseVideoCopyWithImpl<$Res>
    implements _$ShowcaseVideoCopyWith<$Res> {
  __$ShowcaseVideoCopyWithImpl(this._self, this._then);

  final _ShowcaseVideo _self;
  final $Res Function(_ShowcaseVideo) _then;

/// Create a copy of ShowcaseVideo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? thumbnailUrl = freezed,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_ShowcaseVideo(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StorefrontCoupon {

 String get id; String get code; String get title; String? get description; int? get maxClaims; int get claimCount; DateTime? get expiresAt; bool get isActive;
/// Create a copy of StorefrontCoupon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontCouponCopyWith<StorefrontCoupon> get copyWith => _$StorefrontCouponCopyWithImpl<StorefrontCoupon>(this as StorefrontCoupon, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontCoupon&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.maxClaims, maxClaims) || other.maxClaims == maxClaims)&&(identical(other.claimCount, claimCount) || other.claimCount == claimCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,title,description,maxClaims,claimCount,expiresAt,isActive);

@override
String toString() {
  return 'StorefrontCoupon(id: $id, code: $code, title: $title, description: $description, maxClaims: $maxClaims, claimCount: $claimCount, expiresAt: $expiresAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $StorefrontCouponCopyWith<$Res>  {
  factory $StorefrontCouponCopyWith(StorefrontCoupon value, $Res Function(StorefrontCoupon) _then) = _$StorefrontCouponCopyWithImpl;
@useResult
$Res call({
 String id, String code, String title, String? description, int? maxClaims, int claimCount, DateTime? expiresAt, bool isActive
});




}
/// @nodoc
class _$StorefrontCouponCopyWithImpl<$Res>
    implements $StorefrontCouponCopyWith<$Res> {
  _$StorefrontCouponCopyWithImpl(this._self, this._then);

  final StorefrontCoupon _self;
  final $Res Function(StorefrontCoupon) _then;

/// Create a copy of StorefrontCoupon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? title = null,Object? description = freezed,Object? maxClaims = freezed,Object? claimCount = null,Object? expiresAt = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,maxClaims: freezed == maxClaims ? _self.maxClaims : maxClaims // ignore: cast_nullable_to_non_nullable
as int?,claimCount: null == claimCount ? _self.claimCount : claimCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontCoupon].
extension StorefrontCouponPatterns on StorefrontCoupon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontCoupon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontCoupon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontCoupon value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontCoupon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontCoupon value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontCoupon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String title,  String? description,  int? maxClaims,  int claimCount,  DateTime? expiresAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontCoupon() when $default != null:
return $default(_that.id,_that.code,_that.title,_that.description,_that.maxClaims,_that.claimCount,_that.expiresAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String title,  String? description,  int? maxClaims,  int claimCount,  DateTime? expiresAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _StorefrontCoupon():
return $default(_that.id,_that.code,_that.title,_that.description,_that.maxClaims,_that.claimCount,_that.expiresAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String title,  String? description,  int? maxClaims,  int claimCount,  DateTime? expiresAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontCoupon() when $default != null:
return $default(_that.id,_that.code,_that.title,_that.description,_that.maxClaims,_that.claimCount,_that.expiresAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _StorefrontCoupon implements StorefrontCoupon {
  const _StorefrontCoupon({required this.id, required this.code, required this.title, this.description, this.maxClaims, this.claimCount = 0, this.expiresAt, this.isActive = true});
  

@override final  String id;
@override final  String code;
@override final  String title;
@override final  String? description;
@override final  int? maxClaims;
@override@JsonKey() final  int claimCount;
@override final  DateTime? expiresAt;
@override@JsonKey() final  bool isActive;

/// Create a copy of StorefrontCoupon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontCouponCopyWith<_StorefrontCoupon> get copyWith => __$StorefrontCouponCopyWithImpl<_StorefrontCoupon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontCoupon&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.maxClaims, maxClaims) || other.maxClaims == maxClaims)&&(identical(other.claimCount, claimCount) || other.claimCount == claimCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,title,description,maxClaims,claimCount,expiresAt,isActive);

@override
String toString() {
  return 'StorefrontCoupon(id: $id, code: $code, title: $title, description: $description, maxClaims: $maxClaims, claimCount: $claimCount, expiresAt: $expiresAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$StorefrontCouponCopyWith<$Res> implements $StorefrontCouponCopyWith<$Res> {
  factory _$StorefrontCouponCopyWith(_StorefrontCoupon value, $Res Function(_StorefrontCoupon) _then) = __$StorefrontCouponCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String title, String? description, int? maxClaims, int claimCount, DateTime? expiresAt, bool isActive
});




}
/// @nodoc
class __$StorefrontCouponCopyWithImpl<$Res>
    implements _$StorefrontCouponCopyWith<$Res> {
  __$StorefrontCouponCopyWithImpl(this._self, this._then);

  final _StorefrontCoupon _self;
  final $Res Function(_StorefrontCoupon) _then;

/// Create a copy of StorefrontCoupon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? title = null,Object? description = freezed,Object? maxClaims = freezed,Object? claimCount = null,Object? expiresAt = freezed,Object? isActive = null,}) {
  return _then(_StorefrontCoupon(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,maxClaims: freezed == maxClaims ? _self.maxClaims : maxClaims // ignore: cast_nullable_to_non_nullable
as int?,claimCount: null == claimCount ? _self.claimCount : claimCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$FaqItem {

 String get question; String get answer; int get sortOrder;
/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaqItemCopyWith<FaqItem> get copyWith => _$FaqItemCopyWithImpl<FaqItem>(this as FaqItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaqItem&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,question,answer,sortOrder);

@override
String toString() {
  return 'FaqItem(question: $question, answer: $answer, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $FaqItemCopyWith<$Res>  {
  factory $FaqItemCopyWith(FaqItem value, $Res Function(FaqItem) _then) = _$FaqItemCopyWithImpl;
@useResult
$Res call({
 String question, String answer, int sortOrder
});




}
/// @nodoc
class _$FaqItemCopyWithImpl<$Res>
    implements $FaqItemCopyWith<$Res> {
  _$FaqItemCopyWithImpl(this._self, this._then);

  final FaqItem _self;
  final $Res Function(FaqItem) _then;

/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FaqItem].
extension FaqItemPatterns on FaqItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaqItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaqItem value)  $default,){
final _that = this;
switch (_that) {
case _FaqItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaqItem value)?  $default,){
final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  String answer,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
return $default(_that.question,_that.answer,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  String answer,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _FaqItem():
return $default(_that.question,_that.answer,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  String answer,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
return $default(_that.question,_that.answer,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _FaqItem implements FaqItem {
  const _FaqItem({required this.question, required this.answer, this.sortOrder = 0});
  

@override final  String question;
@override final  String answer;
@override@JsonKey() final  int sortOrder;

/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaqItemCopyWith<_FaqItem> get copyWith => __$FaqItemCopyWithImpl<_FaqItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaqItem&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,question,answer,sortOrder);

@override
String toString() {
  return 'FaqItem(question: $question, answer: $answer, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$FaqItemCopyWith<$Res> implements $FaqItemCopyWith<$Res> {
  factory _$FaqItemCopyWith(_FaqItem value, $Res Function(_FaqItem) _then) = __$FaqItemCopyWithImpl;
@override @useResult
$Res call({
 String question, String answer, int sortOrder
});




}
/// @nodoc
class __$FaqItemCopyWithImpl<$Res>
    implements _$FaqItemCopyWith<$Res> {
  __$FaqItemCopyWithImpl(this._self, this._then);

  final _FaqItem _self;
  final $Res Function(_FaqItem) _then;

/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,Object? sortOrder = null,}) {
  return _then(_FaqItem(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BrandLocation {

 String get name; String get address; double? get latitude; double? get longitude; String? get phone; String? get hours;
/// Create a copy of BrandLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandLocationCopyWith<BrandLocation> get copyWith => _$BrandLocationCopyWithImpl<BrandLocation>(this as BrandLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.hours, hours) || other.hours == hours));
}


@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,phone,hours);

@override
String toString() {
  return 'BrandLocation(name: $name, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, hours: $hours)';
}


}

/// @nodoc
abstract mixin class $BrandLocationCopyWith<$Res>  {
  factory $BrandLocationCopyWith(BrandLocation value, $Res Function(BrandLocation) _then) = _$BrandLocationCopyWithImpl;
@useResult
$Res call({
 String name, String address, double? latitude, double? longitude, String? phone, String? hours
});




}
/// @nodoc
class _$BrandLocationCopyWithImpl<$Res>
    implements $BrandLocationCopyWith<$Res> {
  _$BrandLocationCopyWithImpl(this._self, this._then);

  final BrandLocation _self;
  final $Res Function(BrandLocation) _then;

/// Create a copy of BrandLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? address = null,Object? latitude = freezed,Object? longitude = freezed,Object? phone = freezed,Object? hours = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,hours: freezed == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandLocation].
extension BrandLocationPatterns on BrandLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandLocation value)  $default,){
final _that = this;
switch (_that) {
case _BrandLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandLocation value)?  $default,){
final _that = this;
switch (_that) {
case _BrandLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String address,  double? latitude,  double? longitude,  String? phone,  String? hours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandLocation() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.phone,_that.hours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String address,  double? latitude,  double? longitude,  String? phone,  String? hours)  $default,) {final _that = this;
switch (_that) {
case _BrandLocation():
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.phone,_that.hours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String address,  double? latitude,  double? longitude,  String? phone,  String? hours)?  $default,) {final _that = this;
switch (_that) {
case _BrandLocation() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.phone,_that.hours);case _:
  return null;

}
}

}

/// @nodoc


class _BrandLocation implements BrandLocation {
  const _BrandLocation({required this.name, required this.address, this.latitude, this.longitude, this.phone, this.hours});
  

@override final  String name;
@override final  String address;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? phone;
@override final  String? hours;

/// Create a copy of BrandLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandLocationCopyWith<_BrandLocation> get copyWith => __$BrandLocationCopyWithImpl<_BrandLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.hours, hours) || other.hours == hours));
}


@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,phone,hours);

@override
String toString() {
  return 'BrandLocation(name: $name, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, hours: $hours)';
}


}

/// @nodoc
abstract mixin class _$BrandLocationCopyWith<$Res> implements $BrandLocationCopyWith<$Res> {
  factory _$BrandLocationCopyWith(_BrandLocation value, $Res Function(_BrandLocation) _then) = __$BrandLocationCopyWithImpl;
@override @useResult
$Res call({
 String name, String address, double? latitude, double? longitude, String? phone, String? hours
});




}
/// @nodoc
class __$BrandLocationCopyWithImpl<$Res>
    implements _$BrandLocationCopyWith<$Res> {
  __$BrandLocationCopyWithImpl(this._self, this._then);

  final _BrandLocation _self;
  final $Res Function(_BrandLocation) _then;

/// Create a copy of BrandLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? address = null,Object? latitude = freezed,Object? longitude = freezed,Object? phone = freezed,Object? hours = freezed,}) {
  return _then(_BrandLocation(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,hours: freezed == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as String?,
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
 List<StorefrontSectionType> get sectionOrder;// ── New fields (Spec §4.14) ──
 bool get isDraft; DateTime? get publishedAt; String get tier; double get heroFocalPointX; double get heroFocalPointY; bool get showChatButton; String? get bannerVideoUrl;// Announcement bar
 String? get announcementText; String? get announcementDeepLink; bool get announcementDismissible;// New content sections
 List<ShowcaseVideo> get showcaseVideos; List<StorefrontCoupon> get coupons; List<FaqItem> get faqItems; List<String> get testimonialReviewIds; List<BrandLocation> get locations;// Rich text blocks keyed by section instance ID
 Map<String, String> get richTextBlocks;// Per-section settings keyed by section type or instance ID
 Map<String, SectionSettings> get sectionSettings; int get totalViews;
/// Create a copy of BrandStorefront
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandStorefrontCopyWith<BrandStorefront> get copyWith => _$BrandStorefrontCopyWithImpl<BrandStorefront>(this as BrandStorefront, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandStorefront&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.brandColor, brandColor) || other.brandColor == brandColor)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&const DeepCollectionEquality().equals(other.communityIds, communityIds)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.heroStyle, heroStyle) || other.heroStyle == heroStyle)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.heroVideoUrl, heroVideoUrl) || other.heroVideoUrl == heroVideoUrl)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoPlacement, logoPlacement) || other.logoPlacement == logoPlacement)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.cornerStyle, cornerStyle) || other.cornerStyle == cornerStyle)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&(identical(other.bannerDeepLink, bannerDeepLink) || other.bannerDeepLink == bannerDeepLink)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks)&&const DeepCollectionEquality().equals(other.trustBadges, trustBadges)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.quickActions, quickActions)&&const DeepCollectionEquality().equals(other.galleryImageUrls, galleryImageUrls)&&const DeepCollectionEquality().equals(other.promotions, promotions)&&const DeepCollectionEquality().equals(other.sectionOrder, sectionOrder)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.heroFocalPointX, heroFocalPointX) || other.heroFocalPointX == heroFocalPointX)&&(identical(other.heroFocalPointY, heroFocalPointY) || other.heroFocalPointY == heroFocalPointY)&&(identical(other.showChatButton, showChatButton) || other.showChatButton == showChatButton)&&(identical(other.bannerVideoUrl, bannerVideoUrl) || other.bannerVideoUrl == bannerVideoUrl)&&(identical(other.announcementText, announcementText) || other.announcementText == announcementText)&&(identical(other.announcementDeepLink, announcementDeepLink) || other.announcementDeepLink == announcementDeepLink)&&(identical(other.announcementDismissible, announcementDismissible) || other.announcementDismissible == announcementDismissible)&&const DeepCollectionEquality().equals(other.showcaseVideos, showcaseVideos)&&const DeepCollectionEquality().equals(other.coupons, coupons)&&const DeepCollectionEquality().equals(other.faqItems, faqItems)&&const DeepCollectionEquality().equals(other.testimonialReviewIds, testimonialReviewIds)&&const DeepCollectionEquality().equals(other.locations, locations)&&const DeepCollectionEquality().equals(other.richTextBlocks, richTextBlocks)&&const DeepCollectionEquality().equals(other.sectionSettings, sectionSettings)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,brandLogoUrl,brandColor,coverImageUrl,tagline,isActive,isPremium,const DeepCollectionEquality().hash(communityIds),const DeepCollectionEquality().hash(sections),createdAt,heroStyle,heroImageUrl,heroVideoUrl,accentColor,secondaryColor,logoPlacement,fontStyle,cornerStyle,themePreference,description,bannerImageUrl,bannerDeepLink,establishedYear,const DeepCollectionEquality().hash(socialLinks),const DeepCollectionEquality().hash(trustBadges),averageRating,ratingCount,const DeepCollectionEquality().hash(quickActions),const DeepCollectionEquality().hash(galleryImageUrls),const DeepCollectionEquality().hash(promotions),const DeepCollectionEquality().hash(sectionOrder),isDraft,publishedAt,tier,heroFocalPointX,heroFocalPointY,showChatButton,bannerVideoUrl,announcementText,announcementDeepLink,announcementDismissible,const DeepCollectionEquality().hash(showcaseVideos),const DeepCollectionEquality().hash(coupons),const DeepCollectionEquality().hash(faqItems),const DeepCollectionEquality().hash(testimonialReviewIds),const DeepCollectionEquality().hash(locations),const DeepCollectionEquality().hash(richTextBlocks),const DeepCollectionEquality().hash(sectionSettings),totalViews]);

@override
String toString() {
  return 'BrandStorefront(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder, isDraft: $isDraft, publishedAt: $publishedAt, tier: $tier, heroFocalPointX: $heroFocalPointX, heroFocalPointY: $heroFocalPointY, showChatButton: $showChatButton, bannerVideoUrl: $bannerVideoUrl, announcementText: $announcementText, announcementDeepLink: $announcementDeepLink, announcementDismissible: $announcementDismissible, showcaseVideos: $showcaseVideos, coupons: $coupons, faqItems: $faqItems, testimonialReviewIds: $testimonialReviewIds, locations: $locations, richTextBlocks: $richTextBlocks, sectionSettings: $sectionSettings, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class $BrandStorefrontCopyWith<$Res>  {
  factory $BrandStorefrontCopyWith(BrandStorefront value, $Res Function(BrandStorefront) _then) = _$BrandStorefrontCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String brandName, String? brandLogoUrl, String? brandColor, String? coverImageUrl, String? tagline, bool isActive, bool isPremium, List<String> communityIds, List<StorefrontSection> sections, DateTime? createdAt, HeroStyle heroStyle, String? heroImageUrl, String? heroVideoUrl, String? accentColor, String? secondaryColor, LogoPlacement logoPlacement, StorefrontFontStyle fontStyle, StorefrontCornerStyle cornerStyle, StorefrontThemePreference themePreference, String? description, String? bannerImageUrl, String? bannerDeepLink, int? establishedYear, Map<String, String> socialLinks, List<TrustBadge> trustBadges, double? averageRating, int? ratingCount, List<QuickAction> quickActions, List<String> galleryImageUrls, List<StorefrontPromo> promotions, List<StorefrontSectionType> sectionOrder, bool isDraft, DateTime? publishedAt, String tier, double heroFocalPointX, double heroFocalPointY, bool showChatButton, String? bannerVideoUrl, String? announcementText, String? announcementDeepLink, bool announcementDismissible, List<ShowcaseVideo> showcaseVideos, List<StorefrontCoupon> coupons, List<FaqItem> faqItems, List<String> testimonialReviewIds, List<BrandLocation> locations, Map<String, String> richTextBlocks, Map<String, SectionSettings> sectionSettings, int totalViews
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? brandColor = freezed,Object? coverImageUrl = freezed,Object? tagline = freezed,Object? isActive = null,Object? isPremium = null,Object? communityIds = null,Object? sections = null,Object? createdAt = freezed,Object? heroStyle = null,Object? heroImageUrl = freezed,Object? heroVideoUrl = freezed,Object? accentColor = freezed,Object? secondaryColor = freezed,Object? logoPlacement = null,Object? fontStyle = null,Object? cornerStyle = null,Object? themePreference = null,Object? description = freezed,Object? bannerImageUrl = freezed,Object? bannerDeepLink = freezed,Object? establishedYear = freezed,Object? socialLinks = null,Object? trustBadges = null,Object? averageRating = freezed,Object? ratingCount = freezed,Object? quickActions = null,Object? galleryImageUrls = null,Object? promotions = null,Object? sectionOrder = null,Object? isDraft = null,Object? publishedAt = freezed,Object? tier = null,Object? heroFocalPointX = null,Object? heroFocalPointY = null,Object? showChatButton = null,Object? bannerVideoUrl = freezed,Object? announcementText = freezed,Object? announcementDeepLink = freezed,Object? announcementDismissible = null,Object? showcaseVideos = null,Object? coupons = null,Object? faqItems = null,Object? testimonialReviewIds = null,Object? locations = null,Object? richTextBlocks = null,Object? sectionSettings = null,Object? totalViews = null,}) {
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
as List<StorefrontSectionType>,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,heroFocalPointX: null == heroFocalPointX ? _self.heroFocalPointX : heroFocalPointX // ignore: cast_nullable_to_non_nullable
as double,heroFocalPointY: null == heroFocalPointY ? _self.heroFocalPointY : heroFocalPointY // ignore: cast_nullable_to_non_nullable
as double,showChatButton: null == showChatButton ? _self.showChatButton : showChatButton // ignore: cast_nullable_to_non_nullable
as bool,bannerVideoUrl: freezed == bannerVideoUrl ? _self.bannerVideoUrl : bannerVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,announcementText: freezed == announcementText ? _self.announcementText : announcementText // ignore: cast_nullable_to_non_nullable
as String?,announcementDeepLink: freezed == announcementDeepLink ? _self.announcementDeepLink : announcementDeepLink // ignore: cast_nullable_to_non_nullable
as String?,announcementDismissible: null == announcementDismissible ? _self.announcementDismissible : announcementDismissible // ignore: cast_nullable_to_non_nullable
as bool,showcaseVideos: null == showcaseVideos ? _self.showcaseVideos : showcaseVideos // ignore: cast_nullable_to_non_nullable
as List<ShowcaseVideo>,coupons: null == coupons ? _self.coupons : coupons // ignore: cast_nullable_to_non_nullable
as List<StorefrontCoupon>,faqItems: null == faqItems ? _self.faqItems : faqItems // ignore: cast_nullable_to_non_nullable
as List<FaqItem>,testimonialReviewIds: null == testimonialReviewIds ? _self.testimonialReviewIds : testimonialReviewIds // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<BrandLocation>,richTextBlocks: null == richTextBlocks ? _self.richTextBlocks : richTextBlocks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,sectionSettings: null == sectionSettings ? _self.sectionSettings : sectionSettings // ignore: cast_nullable_to_non_nullable
as Map<String, SectionSettings>,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder,  bool isDraft,  DateTime? publishedAt,  String tier,  double heroFocalPointX,  double heroFocalPointY,  bool showChatButton,  String? bannerVideoUrl,  String? announcementText,  String? announcementDeepLink,  bool announcementDismissible,  List<ShowcaseVideo> showcaseVideos,  List<StorefrontCoupon> coupons,  List<FaqItem> faqItems,  List<String> testimonialReviewIds,  List<BrandLocation> locations,  Map<String, String> richTextBlocks,  Map<String, SectionSettings> sectionSettings,  int totalViews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandStorefront() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder,_that.isDraft,_that.publishedAt,_that.tier,_that.heroFocalPointX,_that.heroFocalPointY,_that.showChatButton,_that.bannerVideoUrl,_that.announcementText,_that.announcementDeepLink,_that.announcementDismissible,_that.showcaseVideos,_that.coupons,_that.faqItems,_that.testimonialReviewIds,_that.locations,_that.richTextBlocks,_that.sectionSettings,_that.totalViews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder,  bool isDraft,  DateTime? publishedAt,  String tier,  double heroFocalPointX,  double heroFocalPointY,  bool showChatButton,  String? bannerVideoUrl,  String? announcementText,  String? announcementDeepLink,  bool announcementDismissible,  List<ShowcaseVideo> showcaseVideos,  List<StorefrontCoupon> coupons,  List<FaqItem> faqItems,  List<String> testimonialReviewIds,  List<BrandLocation> locations,  Map<String, String> richTextBlocks,  Map<String, SectionSettings> sectionSettings,  int totalViews)  $default,) {final _that = this;
switch (_that) {
case _BrandStorefront():
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder,_that.isDraft,_that.publishedAt,_that.tier,_that.heroFocalPointX,_that.heroFocalPointY,_that.showChatButton,_that.bannerVideoUrl,_that.announcementText,_that.announcementDeepLink,_that.announcementDismissible,_that.showcaseVideos,_that.coupons,_that.faqItems,_that.testimonialReviewIds,_that.locations,_that.richTextBlocks,_that.sectionSettings,_that.totalViews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder,  bool isDraft,  DateTime? publishedAt,  String tier,  double heroFocalPointX,  double heroFocalPointY,  bool showChatButton,  String? bannerVideoUrl,  String? announcementText,  String? announcementDeepLink,  bool announcementDismissible,  List<ShowcaseVideo> showcaseVideos,  List<StorefrontCoupon> coupons,  List<FaqItem> faqItems,  List<String> testimonialReviewIds,  List<BrandLocation> locations,  Map<String, String> richTextBlocks,  Map<String, SectionSettings> sectionSettings,  int totalViews)?  $default,) {final _that = this;
switch (_that) {
case _BrandStorefront() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder,_that.isDraft,_that.publishedAt,_that.tier,_that.heroFocalPointX,_that.heroFocalPointY,_that.showChatButton,_that.bannerVideoUrl,_that.announcementText,_that.announcementDeepLink,_that.announcementDismissible,_that.showcaseVideos,_that.coupons,_that.faqItems,_that.testimonialReviewIds,_that.locations,_that.richTextBlocks,_that.sectionSettings,_that.totalViews);case _:
  return null;

}
}

}

/// @nodoc


class _BrandStorefront extends BrandStorefront {
  const _BrandStorefront({required this.id, required this.brandId, required this.brandName, this.brandLogoUrl, this.brandColor, this.coverImageUrl, this.tagline, this.isActive = true, this.isPremium = false, final  List<String> communityIds = const [], final  List<StorefrontSection> sections = const [], this.createdAt, this.heroStyle = HeroStyle.gradient, this.heroImageUrl, this.heroVideoUrl, this.accentColor, this.secondaryColor, this.logoPlacement = LogoPlacement.centered, this.fontStyle = StorefrontFontStyle.modern, this.cornerStyle = StorefrontCornerStyle.rounded, this.themePreference = StorefrontThemePreference.auto, this.description, this.bannerImageUrl, this.bannerDeepLink, this.establishedYear, final  Map<String, String> socialLinks = const {}, final  List<TrustBadge> trustBadges = const [], this.averageRating, this.ratingCount, final  List<QuickAction> quickActions = const [], final  List<String> galleryImageUrls = const [], final  List<StorefrontPromo> promotions = const [], final  List<StorefrontSectionType> sectionOrder = const [], this.isDraft = true, this.publishedAt, this.tier = 'standard', this.heroFocalPointX = 0.5, this.heroFocalPointY = 0.5, this.showChatButton = false, this.bannerVideoUrl, this.announcementText, this.announcementDeepLink, this.announcementDismissible = true, final  List<ShowcaseVideo> showcaseVideos = const [], final  List<StorefrontCoupon> coupons = const [], final  List<FaqItem> faqItems = const [], final  List<String> testimonialReviewIds = const [], final  List<BrandLocation> locations = const [], final  Map<String, String> richTextBlocks = const {}, final  Map<String, SectionSettings> sectionSettings = const {}, this.totalViews = 0}): _communityIds = communityIds,_sections = sections,_socialLinks = socialLinks,_trustBadges = trustBadges,_quickActions = quickActions,_galleryImageUrls = galleryImageUrls,_promotions = promotions,_sectionOrder = sectionOrder,_showcaseVideos = showcaseVideos,_coupons = coupons,_faqItems = faqItems,_testimonialReviewIds = testimonialReviewIds,_locations = locations,_richTextBlocks = richTextBlocks,_sectionSettings = sectionSettings,super._();
  

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

// ── New fields (Spec §4.14) ──
@override@JsonKey() final  bool isDraft;
@override final  DateTime? publishedAt;
@override@JsonKey() final  String tier;
@override@JsonKey() final  double heroFocalPointX;
@override@JsonKey() final  double heroFocalPointY;
@override@JsonKey() final  bool showChatButton;
@override final  String? bannerVideoUrl;
// Announcement bar
@override final  String? announcementText;
@override final  String? announcementDeepLink;
@override@JsonKey() final  bool announcementDismissible;
// New content sections
 final  List<ShowcaseVideo> _showcaseVideos;
// New content sections
@override@JsonKey() List<ShowcaseVideo> get showcaseVideos {
  if (_showcaseVideos is EqualUnmodifiableListView) return _showcaseVideos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_showcaseVideos);
}

 final  List<StorefrontCoupon> _coupons;
@override@JsonKey() List<StorefrontCoupon> get coupons {
  if (_coupons is EqualUnmodifiableListView) return _coupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coupons);
}

 final  List<FaqItem> _faqItems;
@override@JsonKey() List<FaqItem> get faqItems {
  if (_faqItems is EqualUnmodifiableListView) return _faqItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faqItems);
}

 final  List<String> _testimonialReviewIds;
@override@JsonKey() List<String> get testimonialReviewIds {
  if (_testimonialReviewIds is EqualUnmodifiableListView) return _testimonialReviewIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_testimonialReviewIds);
}

 final  List<BrandLocation> _locations;
@override@JsonKey() List<BrandLocation> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

// Rich text blocks keyed by section instance ID
 final  Map<String, String> _richTextBlocks;
// Rich text blocks keyed by section instance ID
@override@JsonKey() Map<String, String> get richTextBlocks {
  if (_richTextBlocks is EqualUnmodifiableMapView) return _richTextBlocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_richTextBlocks);
}

// Per-section settings keyed by section type or instance ID
 final  Map<String, SectionSettings> _sectionSettings;
// Per-section settings keyed by section type or instance ID
@override@JsonKey() Map<String, SectionSettings> get sectionSettings {
  if (_sectionSettings is EqualUnmodifiableMapView) return _sectionSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sectionSettings);
}

@override@JsonKey() final  int totalViews;

/// Create a copy of BrandStorefront
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandStorefrontCopyWith<_BrandStorefront> get copyWith => __$BrandStorefrontCopyWithImpl<_BrandStorefront>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandStorefront&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.brandColor, brandColor) || other.brandColor == brandColor)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&const DeepCollectionEquality().equals(other._communityIds, _communityIds)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.heroStyle, heroStyle) || other.heroStyle == heroStyle)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.heroVideoUrl, heroVideoUrl) || other.heroVideoUrl == heroVideoUrl)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoPlacement, logoPlacement) || other.logoPlacement == logoPlacement)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.cornerStyle, cornerStyle) || other.cornerStyle == cornerStyle)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&(identical(other.bannerDeepLink, bannerDeepLink) || other.bannerDeepLink == bannerDeepLink)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks)&&const DeepCollectionEquality().equals(other._trustBadges, _trustBadges)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other._quickActions, _quickActions)&&const DeepCollectionEquality().equals(other._galleryImageUrls, _galleryImageUrls)&&const DeepCollectionEquality().equals(other._promotions, _promotions)&&const DeepCollectionEquality().equals(other._sectionOrder, _sectionOrder)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.heroFocalPointX, heroFocalPointX) || other.heroFocalPointX == heroFocalPointX)&&(identical(other.heroFocalPointY, heroFocalPointY) || other.heroFocalPointY == heroFocalPointY)&&(identical(other.showChatButton, showChatButton) || other.showChatButton == showChatButton)&&(identical(other.bannerVideoUrl, bannerVideoUrl) || other.bannerVideoUrl == bannerVideoUrl)&&(identical(other.announcementText, announcementText) || other.announcementText == announcementText)&&(identical(other.announcementDeepLink, announcementDeepLink) || other.announcementDeepLink == announcementDeepLink)&&(identical(other.announcementDismissible, announcementDismissible) || other.announcementDismissible == announcementDismissible)&&const DeepCollectionEquality().equals(other._showcaseVideos, _showcaseVideos)&&const DeepCollectionEquality().equals(other._coupons, _coupons)&&const DeepCollectionEquality().equals(other._faqItems, _faqItems)&&const DeepCollectionEquality().equals(other._testimonialReviewIds, _testimonialReviewIds)&&const DeepCollectionEquality().equals(other._locations, _locations)&&const DeepCollectionEquality().equals(other._richTextBlocks, _richTextBlocks)&&const DeepCollectionEquality().equals(other._sectionSettings, _sectionSettings)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,brandLogoUrl,brandColor,coverImageUrl,tagline,isActive,isPremium,const DeepCollectionEquality().hash(_communityIds),const DeepCollectionEquality().hash(_sections),createdAt,heroStyle,heroImageUrl,heroVideoUrl,accentColor,secondaryColor,logoPlacement,fontStyle,cornerStyle,themePreference,description,bannerImageUrl,bannerDeepLink,establishedYear,const DeepCollectionEquality().hash(_socialLinks),const DeepCollectionEquality().hash(_trustBadges),averageRating,ratingCount,const DeepCollectionEquality().hash(_quickActions),const DeepCollectionEquality().hash(_galleryImageUrls),const DeepCollectionEquality().hash(_promotions),const DeepCollectionEquality().hash(_sectionOrder),isDraft,publishedAt,tier,heroFocalPointX,heroFocalPointY,showChatButton,bannerVideoUrl,announcementText,announcementDeepLink,announcementDismissible,const DeepCollectionEquality().hash(_showcaseVideos),const DeepCollectionEquality().hash(_coupons),const DeepCollectionEquality().hash(_faqItems),const DeepCollectionEquality().hash(_testimonialReviewIds),const DeepCollectionEquality().hash(_locations),const DeepCollectionEquality().hash(_richTextBlocks),const DeepCollectionEquality().hash(_sectionSettings),totalViews]);

@override
String toString() {
  return 'BrandStorefront(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder, isDraft: $isDraft, publishedAt: $publishedAt, tier: $tier, heroFocalPointX: $heroFocalPointX, heroFocalPointY: $heroFocalPointY, showChatButton: $showChatButton, bannerVideoUrl: $bannerVideoUrl, announcementText: $announcementText, announcementDeepLink: $announcementDeepLink, announcementDismissible: $announcementDismissible, showcaseVideos: $showcaseVideos, coupons: $coupons, faqItems: $faqItems, testimonialReviewIds: $testimonialReviewIds, locations: $locations, richTextBlocks: $richTextBlocks, sectionSettings: $sectionSettings, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class _$BrandStorefrontCopyWith<$Res> implements $BrandStorefrontCopyWith<$Res> {
  factory _$BrandStorefrontCopyWith(_BrandStorefront value, $Res Function(_BrandStorefront) _then) = __$BrandStorefrontCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String brandName, String? brandLogoUrl, String? brandColor, String? coverImageUrl, String? tagline, bool isActive, bool isPremium, List<String> communityIds, List<StorefrontSection> sections, DateTime? createdAt, HeroStyle heroStyle, String? heroImageUrl, String? heroVideoUrl, String? accentColor, String? secondaryColor, LogoPlacement logoPlacement, StorefrontFontStyle fontStyle, StorefrontCornerStyle cornerStyle, StorefrontThemePreference themePreference, String? description, String? bannerImageUrl, String? bannerDeepLink, int? establishedYear, Map<String, String> socialLinks, List<TrustBadge> trustBadges, double? averageRating, int? ratingCount, List<QuickAction> quickActions, List<String> galleryImageUrls, List<StorefrontPromo> promotions, List<StorefrontSectionType> sectionOrder, bool isDraft, DateTime? publishedAt, String tier, double heroFocalPointX, double heroFocalPointY, bool showChatButton, String? bannerVideoUrl, String? announcementText, String? announcementDeepLink, bool announcementDismissible, List<ShowcaseVideo> showcaseVideos, List<StorefrontCoupon> coupons, List<FaqItem> faqItems, List<String> testimonialReviewIds, List<BrandLocation> locations, Map<String, String> richTextBlocks, Map<String, SectionSettings> sectionSettings, int totalViews
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? brandColor = freezed,Object? coverImageUrl = freezed,Object? tagline = freezed,Object? isActive = null,Object? isPremium = null,Object? communityIds = null,Object? sections = null,Object? createdAt = freezed,Object? heroStyle = null,Object? heroImageUrl = freezed,Object? heroVideoUrl = freezed,Object? accentColor = freezed,Object? secondaryColor = freezed,Object? logoPlacement = null,Object? fontStyle = null,Object? cornerStyle = null,Object? themePreference = null,Object? description = freezed,Object? bannerImageUrl = freezed,Object? bannerDeepLink = freezed,Object? establishedYear = freezed,Object? socialLinks = null,Object? trustBadges = null,Object? averageRating = freezed,Object? ratingCount = freezed,Object? quickActions = null,Object? galleryImageUrls = null,Object? promotions = null,Object? sectionOrder = null,Object? isDraft = null,Object? publishedAt = freezed,Object? tier = null,Object? heroFocalPointX = null,Object? heroFocalPointY = null,Object? showChatButton = null,Object? bannerVideoUrl = freezed,Object? announcementText = freezed,Object? announcementDeepLink = freezed,Object? announcementDismissible = null,Object? showcaseVideos = null,Object? coupons = null,Object? faqItems = null,Object? testimonialReviewIds = null,Object? locations = null,Object? richTextBlocks = null,Object? sectionSettings = null,Object? totalViews = null,}) {
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
as List<StorefrontSectionType>,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,heroFocalPointX: null == heroFocalPointX ? _self.heroFocalPointX : heroFocalPointX // ignore: cast_nullable_to_non_nullable
as double,heroFocalPointY: null == heroFocalPointY ? _self.heroFocalPointY : heroFocalPointY // ignore: cast_nullable_to_non_nullable
as double,showChatButton: null == showChatButton ? _self.showChatButton : showChatButton // ignore: cast_nullable_to_non_nullable
as bool,bannerVideoUrl: freezed == bannerVideoUrl ? _self.bannerVideoUrl : bannerVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,announcementText: freezed == announcementText ? _self.announcementText : announcementText // ignore: cast_nullable_to_non_nullable
as String?,announcementDeepLink: freezed == announcementDeepLink ? _self.announcementDeepLink : announcementDeepLink // ignore: cast_nullable_to_non_nullable
as String?,announcementDismissible: null == announcementDismissible ? _self.announcementDismissible : announcementDismissible // ignore: cast_nullable_to_non_nullable
as bool,showcaseVideos: null == showcaseVideos ? _self._showcaseVideos : showcaseVideos // ignore: cast_nullable_to_non_nullable
as List<ShowcaseVideo>,coupons: null == coupons ? _self._coupons : coupons // ignore: cast_nullable_to_non_nullable
as List<StorefrontCoupon>,faqItems: null == faqItems ? _self._faqItems : faqItems // ignore: cast_nullable_to_non_nullable
as List<FaqItem>,testimonialReviewIds: null == testimonialReviewIds ? _self._testimonialReviewIds : testimonialReviewIds // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<BrandLocation>,richTextBlocks: null == richTextBlocks ? _self._richTextBlocks : richTextBlocks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,sectionSettings: null == sectionSettings ? _self._sectionSettings : sectionSettings // ignore: cast_nullable_to_non_nullable
as Map<String, SectionSettings>,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
