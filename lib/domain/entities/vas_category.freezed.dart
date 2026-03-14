// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vas_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VasCategory {

 String get id; String get name; String get iconName; int get sortOrder; bool get isActive; String get purchaseCategoryMapping;
/// Create a copy of VasCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VasCategoryCopyWith<VasCategory> get copyWith => _$VasCategoryCopyWithImpl<VasCategory>(this as VasCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VasCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconName,sortOrder,isActive,purchaseCategoryMapping);

@override
String toString() {
  return 'VasCategory(id: $id, name: $name, iconName: $iconName, sortOrder: $sortOrder, isActive: $isActive, purchaseCategoryMapping: $purchaseCategoryMapping)';
}


}

/// @nodoc
abstract mixin class $VasCategoryCopyWith<$Res>  {
  factory $VasCategoryCopyWith(VasCategory value, $Res Function(VasCategory) _then) = _$VasCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String iconName, int sortOrder, bool isActive, String purchaseCategoryMapping
});




}
/// @nodoc
class _$VasCategoryCopyWithImpl<$Res>
    implements $VasCategoryCopyWith<$Res> {
  _$VasCategoryCopyWithImpl(this._self, this._then);

  final VasCategory _self;
  final $Res Function(VasCategory) _then;

/// Create a copy of VasCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? iconName = null,Object? sortOrder = null,Object? isActive = null,Object? purchaseCategoryMapping = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,purchaseCategoryMapping: null == purchaseCategoryMapping ? _self.purchaseCategoryMapping : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VasCategory].
extension VasCategoryPatterns on VasCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VasCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VasCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VasCategory value)  $default,){
final _that = this;
switch (_that) {
case _VasCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VasCategory value)?  $default,){
final _that = this;
switch (_that) {
case _VasCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String iconName,  int sortOrder,  bool isActive,  String purchaseCategoryMapping)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VasCategory() when $default != null:
return $default(_that.id,_that.name,_that.iconName,_that.sortOrder,_that.isActive,_that.purchaseCategoryMapping);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String iconName,  int sortOrder,  bool isActive,  String purchaseCategoryMapping)  $default,) {final _that = this;
switch (_that) {
case _VasCategory():
return $default(_that.id,_that.name,_that.iconName,_that.sortOrder,_that.isActive,_that.purchaseCategoryMapping);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String iconName,  int sortOrder,  bool isActive,  String purchaseCategoryMapping)?  $default,) {final _that = this;
switch (_that) {
case _VasCategory() when $default != null:
return $default(_that.id,_that.name,_that.iconName,_that.sortOrder,_that.isActive,_that.purchaseCategoryMapping);case _:
  return null;

}
}

}

/// @nodoc


class _VasCategory extends VasCategory {
  const _VasCategory({required this.id, required this.name, required this.iconName, required this.sortOrder, required this.isActive, required this.purchaseCategoryMapping}): super._();
  

@override final  String id;
@override final  String name;
@override final  String iconName;
@override final  int sortOrder;
@override final  bool isActive;
@override final  String purchaseCategoryMapping;

/// Create a copy of VasCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VasCategoryCopyWith<_VasCategory> get copyWith => __$VasCategoryCopyWithImpl<_VasCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VasCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconName,sortOrder,isActive,purchaseCategoryMapping);

@override
String toString() {
  return 'VasCategory(id: $id, name: $name, iconName: $iconName, sortOrder: $sortOrder, isActive: $isActive, purchaseCategoryMapping: $purchaseCategoryMapping)';
}


}

/// @nodoc
abstract mixin class _$VasCategoryCopyWith<$Res> implements $VasCategoryCopyWith<$Res> {
  factory _$VasCategoryCopyWith(_VasCategory value, $Res Function(_VasCategory) _then) = __$VasCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String iconName, int sortOrder, bool isActive, String purchaseCategoryMapping
});




}
/// @nodoc
class __$VasCategoryCopyWithImpl<$Res>
    implements _$VasCategoryCopyWith<$Res> {
  __$VasCategoryCopyWithImpl(this._self, this._then);

  final _VasCategory _self;
  final $Res Function(_VasCategory) _then;

/// Create a copy of VasCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconName = null,Object? sortOrder = null,Object? isActive = null,Object? purchaseCategoryMapping = null,}) {
  return _then(_VasCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,purchaseCategoryMapping: null == purchaseCategoryMapping ? _self.purchaseCategoryMapping : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
