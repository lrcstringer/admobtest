// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceProvider {

 String get id; String get name; String get code; PurchaseCategory get category; String? get logoUrl; String? get description; bool get isActive; bool get isDeleted; List<ServiceProduct> get products; int? get sortOrder; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of ServiceProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProviderCopyWith<ServiceProvider> get copyWith => _$ServiceProviderCopyWithImpl<ServiceProvider>(this as ServiceProvider, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.category, category) || other.category == category)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,code,category,logoUrl,description,isActive,isDeleted,const DeepCollectionEquality().hash(products),sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceProvider(id: $id, name: $name, code: $code, category: $category, logoUrl: $logoUrl, description: $description, isActive: $isActive, isDeleted: $isDeleted, products: $products, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ServiceProviderCopyWith<$Res>  {
  factory $ServiceProviderCopyWith(ServiceProvider value, $Res Function(ServiceProvider) _then) = _$ServiceProviderCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, PurchaseCategory category, String? logoUrl, String? description, bool isActive, bool isDeleted, List<ServiceProduct> products, int? sortOrder, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ServiceProviderCopyWithImpl<$Res>
    implements $ServiceProviderCopyWith<$Res> {
  _$ServiceProviderCopyWithImpl(this._self, this._then);

  final ServiceProvider _self;
  final $Res Function(ServiceProvider) _then;

/// Create a copy of ServiceProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? category = null,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = null,Object? isDeleted = null,Object? products = null,Object? sortOrder = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ServiceProduct>,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProvider].
extension ServiceProviderPatterns on ServiceProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProvider value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProvider value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  PurchaseCategory category,  String? logoUrl,  String? description,  bool isActive,  bool isDeleted,  List<ServiceProduct> products,  int? sortOrder,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProvider() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.category,_that.logoUrl,_that.description,_that.isActive,_that.isDeleted,_that.products,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  PurchaseCategory category,  String? logoUrl,  String? description,  bool isActive,  bool isDeleted,  List<ServiceProduct> products,  int? sortOrder,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ServiceProvider():
return $default(_that.id,_that.name,_that.code,_that.category,_that.logoUrl,_that.description,_that.isActive,_that.isDeleted,_that.products,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  PurchaseCategory category,  String? logoUrl,  String? description,  bool isActive,  bool isDeleted,  List<ServiceProduct> products,  int? sortOrder,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProvider() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.category,_that.logoUrl,_that.description,_that.isActive,_that.isDeleted,_that.products,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceProvider extends ServiceProvider {
  const _ServiceProvider({required this.id, required this.name, required this.code, required this.category, this.logoUrl, this.description, required this.isActive, this.isDeleted = false, required final  List<ServiceProduct> products, this.sortOrder, required this.createdAt, this.updatedAt}): _products = products,super._();
  

@override final  String id;
@override final  String name;
@override final  String code;
@override final  PurchaseCategory category;
@override final  String? logoUrl;
@override final  String? description;
@override final  bool isActive;
@override@JsonKey() final  bool isDeleted;
 final  List<ServiceProduct> _products;
@override List<ServiceProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  int? sortOrder;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ServiceProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProviderCopyWith<_ServiceProvider> get copyWith => __$ServiceProviderCopyWithImpl<_ServiceProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.category, category) || other.category == category)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,code,category,logoUrl,description,isActive,isDeleted,const DeepCollectionEquality().hash(_products),sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceProvider(id: $id, name: $name, code: $code, category: $category, logoUrl: $logoUrl, description: $description, isActive: $isActive, isDeleted: $isDeleted, products: $products, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceProviderCopyWith<$Res> implements $ServiceProviderCopyWith<$Res> {
  factory _$ServiceProviderCopyWith(_ServiceProvider value, $Res Function(_ServiceProvider) _then) = __$ServiceProviderCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, PurchaseCategory category, String? logoUrl, String? description, bool isActive, bool isDeleted, List<ServiceProduct> products, int? sortOrder, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ServiceProviderCopyWithImpl<$Res>
    implements _$ServiceProviderCopyWith<$Res> {
  __$ServiceProviderCopyWithImpl(this._self, this._then);

  final _ServiceProvider _self;
  final $Res Function(_ServiceProvider) _then;

/// Create a copy of ServiceProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? category = null,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = null,Object? isDeleted = null,Object? products = null,Object? sortOrder = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_ServiceProvider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ServiceProduct>,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ServiceProduct {

 String get id; String get providerId; String get name; String get code; int get priceTokens; double get priceZar; String? get description; String? get validity; bool get isActive; bool get isDeleted; int? get sortOrder; Map<String, dynamic>? get metadata;
/// Create a copy of ServiceProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProductCopyWith<ServiceProduct> get copyWith => _$ServiceProductCopyWithImpl<ServiceProduct>(this as ServiceProduct, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&(identical(other.description, description) || other.description == description)&&(identical(other.validity, validity) || other.validity == validity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,providerId,name,code,priceTokens,priceZar,description,validity,isActive,isDeleted,sortOrder,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ServiceProduct(id: $id, providerId: $providerId, name: $name, code: $code, priceTokens: $priceTokens, priceZar: $priceZar, description: $description, validity: $validity, isActive: $isActive, isDeleted: $isDeleted, sortOrder: $sortOrder, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ServiceProductCopyWith<$Res>  {
  factory $ServiceProductCopyWith(ServiceProduct value, $Res Function(ServiceProduct) _then) = _$ServiceProductCopyWithImpl;
@useResult
$Res call({
 String id, String providerId, String name, String code, int priceTokens, double priceZar, String? description, String? validity, bool isActive, bool isDeleted, int? sortOrder, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ServiceProductCopyWithImpl<$Res>
    implements $ServiceProductCopyWith<$Res> {
  _$ServiceProductCopyWithImpl(this._self, this._then);

  final ServiceProduct _self;
  final $Res Function(ServiceProduct) _then;

/// Create a copy of ServiceProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerId = null,Object? name = null,Object? code = null,Object? priceTokens = null,Object? priceZar = null,Object? description = freezed,Object? validity = freezed,Object? isActive = null,Object? isDeleted = null,Object? sortOrder = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,validity: freezed == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProduct].
extension ServiceProductPatterns on ServiceProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProduct value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProduct value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String providerId,  String name,  String code,  int priceTokens,  double priceZar,  String? description,  String? validity,  bool isActive,  bool isDeleted,  int? sortOrder,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProduct() when $default != null:
return $default(_that.id,_that.providerId,_that.name,_that.code,_that.priceTokens,_that.priceZar,_that.description,_that.validity,_that.isActive,_that.isDeleted,_that.sortOrder,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String providerId,  String name,  String code,  int priceTokens,  double priceZar,  String? description,  String? validity,  bool isActive,  bool isDeleted,  int? sortOrder,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _ServiceProduct():
return $default(_that.id,_that.providerId,_that.name,_that.code,_that.priceTokens,_that.priceZar,_that.description,_that.validity,_that.isActive,_that.isDeleted,_that.sortOrder,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String providerId,  String name,  String code,  int priceTokens,  double priceZar,  String? description,  String? validity,  bool isActive,  bool isDeleted,  int? sortOrder,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProduct() when $default != null:
return $default(_that.id,_that.providerId,_that.name,_that.code,_that.priceTokens,_that.priceZar,_that.description,_that.validity,_that.isActive,_that.isDeleted,_that.sortOrder,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceProduct extends ServiceProduct {
  const _ServiceProduct({required this.id, required this.providerId, required this.name, required this.code, required this.priceTokens, required this.priceZar, this.description, this.validity, required this.isActive, this.isDeleted = false, this.sortOrder, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  

@override final  String id;
@override final  String providerId;
@override final  String name;
@override final  String code;
@override final  int priceTokens;
@override final  double priceZar;
@override final  String? description;
@override final  String? validity;
@override final  bool isActive;
@override@JsonKey() final  bool isDeleted;
@override final  int? sortOrder;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ServiceProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProductCopyWith<_ServiceProduct> get copyWith => __$ServiceProductCopyWithImpl<_ServiceProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&(identical(other.description, description) || other.description == description)&&(identical(other.validity, validity) || other.validity == validity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,providerId,name,code,priceTokens,priceZar,description,validity,isActive,isDeleted,sortOrder,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ServiceProduct(id: $id, providerId: $providerId, name: $name, code: $code, priceTokens: $priceTokens, priceZar: $priceZar, description: $description, validity: $validity, isActive: $isActive, isDeleted: $isDeleted, sortOrder: $sortOrder, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ServiceProductCopyWith<$Res> implements $ServiceProductCopyWith<$Res> {
  factory _$ServiceProductCopyWith(_ServiceProduct value, $Res Function(_ServiceProduct) _then) = __$ServiceProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerId, String name, String code, int priceTokens, double priceZar, String? description, String? validity, bool isActive, bool isDeleted, int? sortOrder, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ServiceProductCopyWithImpl<$Res>
    implements _$ServiceProductCopyWith<$Res> {
  __$ServiceProductCopyWithImpl(this._self, this._then);

  final _ServiceProduct _self;
  final $Res Function(_ServiceProduct) _then;

/// Create a copy of ServiceProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerId = null,Object? name = null,Object? code = null,Object? priceTokens = null,Object? priceZar = null,Object? description = freezed,Object? validity = freezed,Object? isActive = null,Object? isDeleted = null,Object? sortOrder = freezed,Object? metadata = freezed,}) {
  return _then(_ServiceProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,validity: freezed == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
