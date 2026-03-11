// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BuyCategoryModel {

 String get id; String get name; String get iconEmoji; int get sortOrder; bool get isActive; bool get isComingSoon; String? get purchaseCategoryMapping; String? get featureFlagKey; String? get logoUrl; String? get backgroundColor; List<BuySubcategory> get subcategories;
/// Create a copy of BuyCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyCategoryModelCopyWith<BuyCategoryModel> get copyWith => _$BuyCategoryModelCopyWithImpl<BuyCategoryModel>(this as BuyCategoryModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconEmoji, iconEmoji) || other.iconEmoji == iconEmoji)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isComingSoon, isComingSoon) || other.isComingSoon == isComingSoon)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping)&&(identical(other.featureFlagKey, featureFlagKey) || other.featureFlagKey == featureFlagKey)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other.subcategories, subcategories));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconEmoji,sortOrder,isActive,isComingSoon,purchaseCategoryMapping,featureFlagKey,logoUrl,backgroundColor,const DeepCollectionEquality().hash(subcategories));

@override
String toString() {
  return 'BuyCategoryModel(id: $id, name: $name, iconEmoji: $iconEmoji, sortOrder: $sortOrder, isActive: $isActive, isComingSoon: $isComingSoon, purchaseCategoryMapping: $purchaseCategoryMapping, featureFlagKey: $featureFlagKey, logoUrl: $logoUrl, backgroundColor: $backgroundColor, subcategories: $subcategories)';
}


}

/// @nodoc
abstract mixin class $BuyCategoryModelCopyWith<$Res>  {
  factory $BuyCategoryModelCopyWith(BuyCategoryModel value, $Res Function(BuyCategoryModel) _then) = _$BuyCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String iconEmoji, int sortOrder, bool isActive, bool isComingSoon, String? purchaseCategoryMapping, String? featureFlagKey, String? logoUrl, String? backgroundColor, List<BuySubcategory> subcategories
});




}
/// @nodoc
class _$BuyCategoryModelCopyWithImpl<$Res>
    implements $BuyCategoryModelCopyWith<$Res> {
  _$BuyCategoryModelCopyWithImpl(this._self, this._then);

  final BuyCategoryModel _self;
  final $Res Function(BuyCategoryModel) _then;

/// Create a copy of BuyCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? iconEmoji = null,Object? sortOrder = null,Object? isActive = null,Object? isComingSoon = null,Object? purchaseCategoryMapping = freezed,Object? featureFlagKey = freezed,Object? logoUrl = freezed,Object? backgroundColor = freezed,Object? subcategories = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconEmoji: null == iconEmoji ? _self.iconEmoji : iconEmoji // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isComingSoon: null == isComingSoon ? _self.isComingSoon : isComingSoon // ignore: cast_nullable_to_non_nullable
as bool,purchaseCategoryMapping: freezed == purchaseCategoryMapping ? _self.purchaseCategoryMapping : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
as String?,featureFlagKey: freezed == featureFlagKey ? _self.featureFlagKey : featureFlagKey // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,subcategories: null == subcategories ? _self.subcategories : subcategories // ignore: cast_nullable_to_non_nullable
as List<BuySubcategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [BuyCategoryModel].
extension BuyCategoryModelPatterns on BuyCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuyCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuyCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuyCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _BuyCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuyCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BuyCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String iconEmoji,  int sortOrder,  bool isActive,  bool isComingSoon,  String? purchaseCategoryMapping,  String? featureFlagKey,  String? logoUrl,  String? backgroundColor,  List<BuySubcategory> subcategories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.iconEmoji,_that.sortOrder,_that.isActive,_that.isComingSoon,_that.purchaseCategoryMapping,_that.featureFlagKey,_that.logoUrl,_that.backgroundColor,_that.subcategories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String iconEmoji,  int sortOrder,  bool isActive,  bool isComingSoon,  String? purchaseCategoryMapping,  String? featureFlagKey,  String? logoUrl,  String? backgroundColor,  List<BuySubcategory> subcategories)  $default,) {final _that = this;
switch (_that) {
case _BuyCategoryModel():
return $default(_that.id,_that.name,_that.iconEmoji,_that.sortOrder,_that.isActive,_that.isComingSoon,_that.purchaseCategoryMapping,_that.featureFlagKey,_that.logoUrl,_that.backgroundColor,_that.subcategories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String iconEmoji,  int sortOrder,  bool isActive,  bool isComingSoon,  String? purchaseCategoryMapping,  String? featureFlagKey,  String? logoUrl,  String? backgroundColor,  List<BuySubcategory> subcategories)?  $default,) {final _that = this;
switch (_that) {
case _BuyCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.iconEmoji,_that.sortOrder,_that.isActive,_that.isComingSoon,_that.purchaseCategoryMapping,_that.featureFlagKey,_that.logoUrl,_that.backgroundColor,_that.subcategories);case _:
  return null;

}
}

}

/// @nodoc


class _BuyCategoryModel extends BuyCategoryModel {
  const _BuyCategoryModel({required this.id, required this.name, required this.iconEmoji, required this.sortOrder, required this.isActive, this.isComingSoon = false, this.purchaseCategoryMapping, this.featureFlagKey, this.logoUrl, this.backgroundColor, final  List<BuySubcategory> subcategories = const []}): _subcategories = subcategories,super._();
  

@override final  String id;
@override final  String name;
@override final  String iconEmoji;
@override final  int sortOrder;
@override final  bool isActive;
@override@JsonKey() final  bool isComingSoon;
@override final  String? purchaseCategoryMapping;
@override final  String? featureFlagKey;
@override final  String? logoUrl;
@override final  String? backgroundColor;
 final  List<BuySubcategory> _subcategories;
@override@JsonKey() List<BuySubcategory> get subcategories {
  if (_subcategories is EqualUnmodifiableListView) return _subcategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subcategories);
}


/// Create a copy of BuyCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyCategoryModelCopyWith<_BuyCategoryModel> get copyWith => __$BuyCategoryModelCopyWithImpl<_BuyCategoryModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconEmoji, iconEmoji) || other.iconEmoji == iconEmoji)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isComingSoon, isComingSoon) || other.isComingSoon == isComingSoon)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping)&&(identical(other.featureFlagKey, featureFlagKey) || other.featureFlagKey == featureFlagKey)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other._subcategories, _subcategories));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconEmoji,sortOrder,isActive,isComingSoon,purchaseCategoryMapping,featureFlagKey,logoUrl,backgroundColor,const DeepCollectionEquality().hash(_subcategories));

@override
String toString() {
  return 'BuyCategoryModel(id: $id, name: $name, iconEmoji: $iconEmoji, sortOrder: $sortOrder, isActive: $isActive, isComingSoon: $isComingSoon, purchaseCategoryMapping: $purchaseCategoryMapping, featureFlagKey: $featureFlagKey, logoUrl: $logoUrl, backgroundColor: $backgroundColor, subcategories: $subcategories)';
}


}

/// @nodoc
abstract mixin class _$BuyCategoryModelCopyWith<$Res> implements $BuyCategoryModelCopyWith<$Res> {
  factory _$BuyCategoryModelCopyWith(_BuyCategoryModel value, $Res Function(_BuyCategoryModel) _then) = __$BuyCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String iconEmoji, int sortOrder, bool isActive, bool isComingSoon, String? purchaseCategoryMapping, String? featureFlagKey, String? logoUrl, String? backgroundColor, List<BuySubcategory> subcategories
});




}
/// @nodoc
class __$BuyCategoryModelCopyWithImpl<$Res>
    implements _$BuyCategoryModelCopyWith<$Res> {
  __$BuyCategoryModelCopyWithImpl(this._self, this._then);

  final _BuyCategoryModel _self;
  final $Res Function(_BuyCategoryModel) _then;

/// Create a copy of BuyCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconEmoji = null,Object? sortOrder = null,Object? isActive = null,Object? isComingSoon = null,Object? purchaseCategoryMapping = freezed,Object? featureFlagKey = freezed,Object? logoUrl = freezed,Object? backgroundColor = freezed,Object? subcategories = null,}) {
  return _then(_BuyCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconEmoji: null == iconEmoji ? _self.iconEmoji : iconEmoji // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isComingSoon: null == isComingSoon ? _self.isComingSoon : isComingSoon // ignore: cast_nullable_to_non_nullable
as bool,purchaseCategoryMapping: freezed == purchaseCategoryMapping ? _self.purchaseCategoryMapping : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
as String?,featureFlagKey: freezed == featureFlagKey ? _self.featureFlagKey : featureFlagKey // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,subcategories: null == subcategories ? _self._subcategories : subcategories // ignore: cast_nullable_to_non_nullable
as List<BuySubcategory>,
  ));
}


}

// dart format on
