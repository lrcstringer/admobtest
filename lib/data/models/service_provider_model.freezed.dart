// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_provider_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceProviderModel {

 String get id; String get name; String get code; String get category; String? get logoUrl; String? get description; bool get isActive; List<ServiceProductModel> get products; int? get sortOrder; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of ServiceProviderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProviderModelCopyWith<ServiceProviderModel> get copyWith => _$ServiceProviderModelCopyWithImpl<ServiceProviderModel>(this as ServiceProviderModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProviderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.category, category) || other.category == category)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,code,category,logoUrl,description,isActive,const DeepCollectionEquality().hash(products),sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceProviderModel(id: $id, name: $name, code: $code, category: $category, logoUrl: $logoUrl, description: $description, isActive: $isActive, products: $products, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ServiceProviderModelCopyWith<$Res>  {
  factory $ServiceProviderModelCopyWith(ServiceProviderModel value, $Res Function(ServiceProviderModel) _then) = _$ServiceProviderModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, String category, String? logoUrl, String? description, bool isActive, List<ServiceProductModel> products, int? sortOrder, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ServiceProviderModelCopyWithImpl<$Res>
    implements $ServiceProviderModelCopyWith<$Res> {
  _$ServiceProviderModelCopyWithImpl(this._self, this._then);

  final ServiceProviderModel _self;
  final $Res Function(ServiceProviderModel) _then;

/// Create a copy of ServiceProviderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? category = null,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = null,Object? products = null,Object? sortOrder = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ServiceProductModel>,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProviderModel].
extension ServiceProviderModelPatterns on ServiceProviderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProviderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProviderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProviderModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProviderModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String category,  String? logoUrl,  String? description,  bool isActive,  List<ServiceProductModel> products,  int? sortOrder,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProviderModel() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.category,_that.logoUrl,_that.description,_that.isActive,_that.products,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String category,  String? logoUrl,  String? description,  bool isActive,  List<ServiceProductModel> products,  int? sortOrder,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderModel():
return $default(_that.id,_that.name,_that.code,_that.category,_that.logoUrl,_that.description,_that.isActive,_that.products,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  String category,  String? logoUrl,  String? description,  bool isActive,  List<ServiceProductModel> products,  int? sortOrder,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderModel() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.category,_that.logoUrl,_that.description,_that.isActive,_that.products,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceProviderModel extends ServiceProviderModel {
  const _ServiceProviderModel({required this.id, required this.name, required this.code, required this.category, this.logoUrl, this.description, required this.isActive, required final  List<ServiceProductModel> products, this.sortOrder, required this.createdAt, this.updatedAt}): _products = products,super._();
  

@override final  String id;
@override final  String name;
@override final  String code;
@override final  String category;
@override final  String? logoUrl;
@override final  String? description;
@override final  bool isActive;
 final  List<ServiceProductModel> _products;
@override List<ServiceProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  int? sortOrder;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ServiceProviderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProviderModelCopyWith<_ServiceProviderModel> get copyWith => __$ServiceProviderModelCopyWithImpl<_ServiceProviderModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProviderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.category, category) || other.category == category)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,code,category,logoUrl,description,isActive,const DeepCollectionEquality().hash(_products),sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'ServiceProviderModel(id: $id, name: $name, code: $code, category: $category, logoUrl: $logoUrl, description: $description, isActive: $isActive, products: $products, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ServiceProviderModelCopyWith<$Res> implements $ServiceProviderModelCopyWith<$Res> {
  factory _$ServiceProviderModelCopyWith(_ServiceProviderModel value, $Res Function(_ServiceProviderModel) _then) = __$ServiceProviderModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, String category, String? logoUrl, String? description, bool isActive, List<ServiceProductModel> products, int? sortOrder, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ServiceProviderModelCopyWithImpl<$Res>
    implements _$ServiceProviderModelCopyWith<$Res> {
  __$ServiceProviderModelCopyWithImpl(this._self, this._then);

  final _ServiceProviderModel _self;
  final $Res Function(_ServiceProviderModel) _then;

/// Create a copy of ServiceProviderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? category = null,Object? logoUrl = freezed,Object? description = freezed,Object? isActive = null,Object? products = null,Object? sortOrder = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_ServiceProviderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ServiceProductModel>,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ServiceProductModel {

 String get id; String get providerId; String get name; String get code; int get priceTokens; double get priceZar; String? get description; String? get validity; bool get isActive; int? get sortOrder; Map<String, dynamic>? get metadata;
/// Create a copy of ServiceProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProductModelCopyWith<ServiceProductModel> get copyWith => _$ServiceProductModelCopyWithImpl<ServiceProductModel>(this as ServiceProductModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&(identical(other.description, description) || other.description == description)&&(identical(other.validity, validity) || other.validity == validity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,providerId,name,code,priceTokens,priceZar,description,validity,isActive,sortOrder,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ServiceProductModel(id: $id, providerId: $providerId, name: $name, code: $code, priceTokens: $priceTokens, priceZar: $priceZar, description: $description, validity: $validity, isActive: $isActive, sortOrder: $sortOrder, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ServiceProductModelCopyWith<$Res>  {
  factory $ServiceProductModelCopyWith(ServiceProductModel value, $Res Function(ServiceProductModel) _then) = _$ServiceProductModelCopyWithImpl;
@useResult
$Res call({
 String id, String providerId, String name, String code, int priceTokens, double priceZar, String? description, String? validity, bool isActive, int? sortOrder, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ServiceProductModelCopyWithImpl<$Res>
    implements $ServiceProductModelCopyWith<$Res> {
  _$ServiceProductModelCopyWithImpl(this._self, this._then);

  final ServiceProductModel _self;
  final $Res Function(ServiceProductModel) _then;

/// Create a copy of ServiceProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerId = null,Object? name = null,Object? code = null,Object? priceTokens = null,Object? priceZar = null,Object? description = freezed,Object? validity = freezed,Object? isActive = null,Object? sortOrder = freezed,Object? metadata = freezed,}) {
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
as bool,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProductModel].
extension ServiceProductModelPatterns on ServiceProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String providerId,  String name,  String code,  int priceTokens,  double priceZar,  String? description,  String? validity,  bool isActive,  int? sortOrder,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProductModel() when $default != null:
return $default(_that.id,_that.providerId,_that.name,_that.code,_that.priceTokens,_that.priceZar,_that.description,_that.validity,_that.isActive,_that.sortOrder,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String providerId,  String name,  String code,  int priceTokens,  double priceZar,  String? description,  String? validity,  bool isActive,  int? sortOrder,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _ServiceProductModel():
return $default(_that.id,_that.providerId,_that.name,_that.code,_that.priceTokens,_that.priceZar,_that.description,_that.validity,_that.isActive,_that.sortOrder,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String providerId,  String name,  String code,  int priceTokens,  double priceZar,  String? description,  String? validity,  bool isActive,  int? sortOrder,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProductModel() when $default != null:
return $default(_that.id,_that.providerId,_that.name,_that.code,_that.priceTokens,_that.priceZar,_that.description,_that.validity,_that.isActive,_that.sortOrder,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceProductModel extends ServiceProductModel {
  const _ServiceProductModel({required this.id, required this.providerId, required this.name, required this.code, required this.priceTokens, required this.priceZar, this.description, this.validity, required this.isActive, this.sortOrder, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  

@override final  String id;
@override final  String providerId;
@override final  String name;
@override final  String code;
@override final  int priceTokens;
@override final  double priceZar;
@override final  String? description;
@override final  String? validity;
@override final  bool isActive;
@override final  int? sortOrder;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ServiceProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProductModelCopyWith<_ServiceProductModel> get copyWith => __$ServiceProductModelCopyWithImpl<_ServiceProductModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&(identical(other.description, description) || other.description == description)&&(identical(other.validity, validity) || other.validity == validity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,providerId,name,code,priceTokens,priceZar,description,validity,isActive,sortOrder,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ServiceProductModel(id: $id, providerId: $providerId, name: $name, code: $code, priceTokens: $priceTokens, priceZar: $priceZar, description: $description, validity: $validity, isActive: $isActive, sortOrder: $sortOrder, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ServiceProductModelCopyWith<$Res> implements $ServiceProductModelCopyWith<$Res> {
  factory _$ServiceProductModelCopyWith(_ServiceProductModel value, $Res Function(_ServiceProductModel) _then) = __$ServiceProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerId, String name, String code, int priceTokens, double priceZar, String? description, String? validity, bool isActive, int? sortOrder, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ServiceProductModelCopyWithImpl<$Res>
    implements _$ServiceProductModelCopyWith<$Res> {
  __$ServiceProductModelCopyWithImpl(this._self, this._then);

  final _ServiceProductModel _self;
  final $Res Function(_ServiceProductModel) _then;

/// Create a copy of ServiceProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerId = null,Object? name = null,Object? code = null,Object? priceTokens = null,Object? priceZar = null,Object? description = freezed,Object? validity = freezed,Object? isActive = null,Object? sortOrder = freezed,Object? metadata = freezed,}) {
  return _then(_ServiceProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,validity: freezed == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
