// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vas_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VasCategoryModel {

 String get id; String get name; String get iconName; int get sortOrder; bool get isActive; String get purchaseCategoryMapping;
/// Create a copy of VasCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VasCategoryModelCopyWith<VasCategoryModel> get copyWith => _$VasCategoryModelCopyWithImpl<VasCategoryModel>(this as VasCategoryModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VasCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconName,sortOrder,isActive,purchaseCategoryMapping);

@override
String toString() {
  return 'VasCategoryModel(id: $id, name: $name, iconName: $iconName, sortOrder: $sortOrder, isActive: $isActive, purchaseCategoryMapping: $purchaseCategoryMapping)';
}


}

/// @nodoc
abstract mixin class $VasCategoryModelCopyWith<$Res>  {
  factory $VasCategoryModelCopyWith(VasCategoryModel value, $Res Function(VasCategoryModel) _then) = _$VasCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String iconName, int sortOrder, bool isActive, String purchaseCategoryMapping
});




}
/// @nodoc
class _$VasCategoryModelCopyWithImpl<$Res>
    implements $VasCategoryModelCopyWith<$Res> {
  _$VasCategoryModelCopyWithImpl(this._self, this._then);

  final VasCategoryModel _self;
  final $Res Function(VasCategoryModel) _then;

/// Create a copy of VasCategoryModel
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


/// Adds pattern-matching-related methods to [VasCategoryModel].
extension VasCategoryModelPatterns on VasCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VasCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VasCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VasCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _VasCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VasCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _VasCategoryModel() when $default != null:
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
case _VasCategoryModel() when $default != null:
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
case _VasCategoryModel():
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
case _VasCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.iconName,_that.sortOrder,_that.isActive,_that.purchaseCategoryMapping);case _:
  return null;

}
}

}

/// @nodoc


class _VasCategoryModel extends VasCategoryModel {
  const _VasCategoryModel({required this.id, required this.name, required this.iconName, required this.sortOrder, required this.isActive, required this.purchaseCategoryMapping}): super._();
  

@override final  String id;
@override final  String name;
@override final  String iconName;
@override final  int sortOrder;
@override final  bool isActive;
@override final  String purchaseCategoryMapping;

/// Create a copy of VasCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VasCategoryModelCopyWith<_VasCategoryModel> get copyWith => __$VasCategoryModelCopyWithImpl<_VasCategoryModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VasCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconName,sortOrder,isActive,purchaseCategoryMapping);

@override
String toString() {
  return 'VasCategoryModel(id: $id, name: $name, iconName: $iconName, sortOrder: $sortOrder, isActive: $isActive, purchaseCategoryMapping: $purchaseCategoryMapping)';
}


}

/// @nodoc
abstract mixin class _$VasCategoryModelCopyWith<$Res> implements $VasCategoryModelCopyWith<$Res> {
  factory _$VasCategoryModelCopyWith(_VasCategoryModel value, $Res Function(_VasCategoryModel) _then) = __$VasCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String iconName, int sortOrder, bool isActive, String purchaseCategoryMapping
});




}
/// @nodoc
class __$VasCategoryModelCopyWithImpl<$Res>
    implements _$VasCategoryModelCopyWith<$Res> {
  __$VasCategoryModelCopyWithImpl(this._self, this._then);

  final _VasCategoryModel _self;
  final $Res Function(_VasCategoryModel) _then;

/// Create a copy of VasCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconName = null,Object? sortOrder = null,Object? isActive = null,Object? purchaseCategoryMapping = null,}) {
  return _then(_VasCategoryModel(
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
