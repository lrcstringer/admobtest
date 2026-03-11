// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandProductModel {

 String get id; String get brandId; String get name; String? get description; double get priceZar; int get priceTokens; String? get imageUrl; String? get category; bool get isActive; bool get isFeatured; int get sortOrder; int? get stockCount; FulfilmentType get fulfilmentType; String? get contactMethod; String? get voucherInstructions; String? get collectionAddress; String? get deliveryInfo; DateTime get createdAt;
/// Create a copy of BrandProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandProductModelCopyWith<BrandProductModel> get copyWith => _$BrandProductModelCopyWithImpl<BrandProductModel>(this as BrandProductModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.stockCount, stockCount) || other.stockCount == stockCount)&&(identical(other.fulfilmentType, fulfilmentType) || other.fulfilmentType == fulfilmentType)&&(identical(other.contactMethod, contactMethod) || other.contactMethod == contactMethod)&&(identical(other.voucherInstructions, voucherInstructions) || other.voucherInstructions == voucherInstructions)&&(identical(other.collectionAddress, collectionAddress) || other.collectionAddress == collectionAddress)&&(identical(other.deliveryInfo, deliveryInfo) || other.deliveryInfo == deliveryInfo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,name,description,priceZar,priceTokens,imageUrl,category,isActive,isFeatured,sortOrder,stockCount,fulfilmentType,contactMethod,voucherInstructions,collectionAddress,deliveryInfo,createdAt);

@override
String toString() {
  return 'BrandProductModel(id: $id, brandId: $brandId, name: $name, description: $description, priceZar: $priceZar, priceTokens: $priceTokens, imageUrl: $imageUrl, category: $category, isActive: $isActive, isFeatured: $isFeatured, sortOrder: $sortOrder, stockCount: $stockCount, fulfilmentType: $fulfilmentType, contactMethod: $contactMethod, voucherInstructions: $voucherInstructions, collectionAddress: $collectionAddress, deliveryInfo: $deliveryInfo, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BrandProductModelCopyWith<$Res>  {
  factory $BrandProductModelCopyWith(BrandProductModel value, $Res Function(BrandProductModel) _then) = _$BrandProductModelCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String name, String? description, double priceZar, int priceTokens, String? imageUrl, String? category, bool isActive, bool isFeatured, int sortOrder, int? stockCount, FulfilmentType fulfilmentType, String? contactMethod, String? voucherInstructions, String? collectionAddress, String? deliveryInfo, DateTime createdAt
});




}
/// @nodoc
class _$BrandProductModelCopyWithImpl<$Res>
    implements $BrandProductModelCopyWith<$Res> {
  _$BrandProductModelCopyWithImpl(this._self, this._then);

  final BrandProductModel _self;
  final $Res Function(BrandProductModel) _then;

/// Create a copy of BrandProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? name = null,Object? description = freezed,Object? priceZar = null,Object? priceTokens = null,Object? imageUrl = freezed,Object? category = freezed,Object? isActive = null,Object? isFeatured = null,Object? sortOrder = null,Object? stockCount = freezed,Object? fulfilmentType = null,Object? contactMethod = freezed,Object? voucherInstructions = freezed,Object? collectionAddress = freezed,Object? deliveryInfo = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,stockCount: freezed == stockCount ? _self.stockCount : stockCount // ignore: cast_nullable_to_non_nullable
as int?,fulfilmentType: null == fulfilmentType ? _self.fulfilmentType : fulfilmentType // ignore: cast_nullable_to_non_nullable
as FulfilmentType,contactMethod: freezed == contactMethod ? _self.contactMethod : contactMethod // ignore: cast_nullable_to_non_nullable
as String?,voucherInstructions: freezed == voucherInstructions ? _self.voucherInstructions : voucherInstructions // ignore: cast_nullable_to_non_nullable
as String?,collectionAddress: freezed == collectionAddress ? _self.collectionAddress : collectionAddress // ignore: cast_nullable_to_non_nullable
as String?,deliveryInfo: freezed == deliveryInfo ? _self.deliveryInfo : deliveryInfo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandProductModel].
extension BrandProductModelPatterns on BrandProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandProductModel value)  $default,){
final _that = this;
switch (_that) {
case _BrandProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _BrandProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String name,  String? description,  double priceZar,  int priceTokens,  String? imageUrl,  String? category,  bool isActive,  bool isFeatured,  int sortOrder,  int? stockCount,  FulfilmentType fulfilmentType,  String? contactMethod,  String? voucherInstructions,  String? collectionAddress,  String? deliveryInfo,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandProductModel() when $default != null:
return $default(_that.id,_that.brandId,_that.name,_that.description,_that.priceZar,_that.priceTokens,_that.imageUrl,_that.category,_that.isActive,_that.isFeatured,_that.sortOrder,_that.stockCount,_that.fulfilmentType,_that.contactMethod,_that.voucherInstructions,_that.collectionAddress,_that.deliveryInfo,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String name,  String? description,  double priceZar,  int priceTokens,  String? imageUrl,  String? category,  bool isActive,  bool isFeatured,  int sortOrder,  int? stockCount,  FulfilmentType fulfilmentType,  String? contactMethod,  String? voucherInstructions,  String? collectionAddress,  String? deliveryInfo,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BrandProductModel():
return $default(_that.id,_that.brandId,_that.name,_that.description,_that.priceZar,_that.priceTokens,_that.imageUrl,_that.category,_that.isActive,_that.isFeatured,_that.sortOrder,_that.stockCount,_that.fulfilmentType,_that.contactMethod,_that.voucherInstructions,_that.collectionAddress,_that.deliveryInfo,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String name,  String? description,  double priceZar,  int priceTokens,  String? imageUrl,  String? category,  bool isActive,  bool isFeatured,  int sortOrder,  int? stockCount,  FulfilmentType fulfilmentType,  String? contactMethod,  String? voucherInstructions,  String? collectionAddress,  String? deliveryInfo,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BrandProductModel() when $default != null:
return $default(_that.id,_that.brandId,_that.name,_that.description,_that.priceZar,_that.priceTokens,_that.imageUrl,_that.category,_that.isActive,_that.isFeatured,_that.sortOrder,_that.stockCount,_that.fulfilmentType,_that.contactMethod,_that.voucherInstructions,_that.collectionAddress,_that.deliveryInfo,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _BrandProductModel extends BrandProductModel {
  const _BrandProductModel({required this.id, required this.brandId, required this.name, this.description, required this.priceZar, required this.priceTokens, this.imageUrl, this.category, this.isActive = true, this.isFeatured = false, this.sortOrder = 0, this.stockCount, required this.fulfilmentType, this.contactMethod, this.voucherInstructions, this.collectionAddress, this.deliveryInfo, required this.createdAt}): super._();
  

@override final  String id;
@override final  String brandId;
@override final  String name;
@override final  String? description;
@override final  double priceZar;
@override final  int priceTokens;
@override final  String? imageUrl;
@override final  String? category;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isFeatured;
@override@JsonKey() final  int sortOrder;
@override final  int? stockCount;
@override final  FulfilmentType fulfilmentType;
@override final  String? contactMethod;
@override final  String? voucherInstructions;
@override final  String? collectionAddress;
@override final  String? deliveryInfo;
@override final  DateTime createdAt;

/// Create a copy of BrandProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandProductModelCopyWith<_BrandProductModel> get copyWith => __$BrandProductModelCopyWithImpl<_BrandProductModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.stockCount, stockCount) || other.stockCount == stockCount)&&(identical(other.fulfilmentType, fulfilmentType) || other.fulfilmentType == fulfilmentType)&&(identical(other.contactMethod, contactMethod) || other.contactMethod == contactMethod)&&(identical(other.voucherInstructions, voucherInstructions) || other.voucherInstructions == voucherInstructions)&&(identical(other.collectionAddress, collectionAddress) || other.collectionAddress == collectionAddress)&&(identical(other.deliveryInfo, deliveryInfo) || other.deliveryInfo == deliveryInfo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,name,description,priceZar,priceTokens,imageUrl,category,isActive,isFeatured,sortOrder,stockCount,fulfilmentType,contactMethod,voucherInstructions,collectionAddress,deliveryInfo,createdAt);

@override
String toString() {
  return 'BrandProductModel(id: $id, brandId: $brandId, name: $name, description: $description, priceZar: $priceZar, priceTokens: $priceTokens, imageUrl: $imageUrl, category: $category, isActive: $isActive, isFeatured: $isFeatured, sortOrder: $sortOrder, stockCount: $stockCount, fulfilmentType: $fulfilmentType, contactMethod: $contactMethod, voucherInstructions: $voucherInstructions, collectionAddress: $collectionAddress, deliveryInfo: $deliveryInfo, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BrandProductModelCopyWith<$Res> implements $BrandProductModelCopyWith<$Res> {
  factory _$BrandProductModelCopyWith(_BrandProductModel value, $Res Function(_BrandProductModel) _then) = __$BrandProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String name, String? description, double priceZar, int priceTokens, String? imageUrl, String? category, bool isActive, bool isFeatured, int sortOrder, int? stockCount, FulfilmentType fulfilmentType, String? contactMethod, String? voucherInstructions, String? collectionAddress, String? deliveryInfo, DateTime createdAt
});




}
/// @nodoc
class __$BrandProductModelCopyWithImpl<$Res>
    implements _$BrandProductModelCopyWith<$Res> {
  __$BrandProductModelCopyWithImpl(this._self, this._then);

  final _BrandProductModel _self;
  final $Res Function(_BrandProductModel) _then;

/// Create a copy of BrandProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? name = null,Object? description = freezed,Object? priceZar = null,Object? priceTokens = null,Object? imageUrl = freezed,Object? category = freezed,Object? isActive = null,Object? isFeatured = null,Object? sortOrder = null,Object? stockCount = freezed,Object? fulfilmentType = null,Object? contactMethod = freezed,Object? voucherInstructions = freezed,Object? collectionAddress = freezed,Object? deliveryInfo = freezed,Object? createdAt = null,}) {
  return _then(_BrandProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,stockCount: freezed == stockCount ? _self.stockCount : stockCount // ignore: cast_nullable_to_non_nullable
as int?,fulfilmentType: null == fulfilmentType ? _self.fulfilmentType : fulfilmentType // ignore: cast_nullable_to_non_nullable
as FulfilmentType,contactMethod: freezed == contactMethod ? _self.contactMethod : contactMethod // ignore: cast_nullable_to_non_nullable
as String?,voucherInstructions: freezed == voucherInstructions ? _self.voucherInstructions : voucherInstructions // ignore: cast_nullable_to_non_nullable
as String?,collectionAddress: freezed == collectionAddress ? _self.collectionAddress : collectionAddress // ignore: cast_nullable_to_non_nullable
as String?,deliveryInfo: freezed == deliveryInfo ? _self.deliveryInfo : deliveryInfo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
