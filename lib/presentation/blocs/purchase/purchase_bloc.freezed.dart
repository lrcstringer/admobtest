// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseEvent()';
}


}

/// @nodoc
class $PurchaseEventCopyWith<$Res>  {
$PurchaseEventCopyWith(PurchaseEvent _, $Res Function(PurchaseEvent) __);
}


/// Adds pattern-matching-related methods to [PurchaseEvent].
extension PurchaseEventPatterns on PurchaseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadProviders value)?  loadProviders,TResult Function( _LoadProvidersByCategory value)?  loadProvidersByCategory,TResult Function( _SelectCategory value)?  selectCategory,TResult Function( _SelectProvider value)?  selectProvider,TResult Function( _LoadProducts value)?  loadProducts,TResult Function( _SelectProduct value)?  selectProduct,TResult Function( _SetRecipientNumber value)?  setRecipientNumber,TResult Function( _ValidateRecipient value)?  validateRecipient,TResult Function( _MakePurchase value)?  makePurchase,TResult Function( _LoadHistory value)?  loadHistory,TResult Function( _LoadRecentRecipients value)?  loadRecentRecipients,TResult Function( _SelectRecentRecipient value)?  selectRecentRecipient,TResult Function( _ResetSelection value)?  resetSelection,TResult Function( _ClearError value)?  clearError,TResult Function( _ClearSuccess value)?  clearSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadProviders() when loadProviders != null:
return loadProviders(_that);case _LoadProvidersByCategory() when loadProvidersByCategory != null:
return loadProvidersByCategory(_that);case _SelectCategory() when selectCategory != null:
return selectCategory(_that);case _SelectProvider() when selectProvider != null:
return selectProvider(_that);case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _SelectProduct() when selectProduct != null:
return selectProduct(_that);case _SetRecipientNumber() when setRecipientNumber != null:
return setRecipientNumber(_that);case _ValidateRecipient() when validateRecipient != null:
return validateRecipient(_that);case _MakePurchase() when makePurchase != null:
return makePurchase(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _LoadRecentRecipients() when loadRecentRecipients != null:
return loadRecentRecipients(_that);case _SelectRecentRecipient() when selectRecentRecipient != null:
return selectRecentRecipient(_that);case _ResetSelection() when resetSelection != null:
return resetSelection(_that);case _ClearError() when clearError != null:
return clearError(_that);case _ClearSuccess() when clearSuccess != null:
return clearSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadProviders value)  loadProviders,required TResult Function( _LoadProvidersByCategory value)  loadProvidersByCategory,required TResult Function( _SelectCategory value)  selectCategory,required TResult Function( _SelectProvider value)  selectProvider,required TResult Function( _LoadProducts value)  loadProducts,required TResult Function( _SelectProduct value)  selectProduct,required TResult Function( _SetRecipientNumber value)  setRecipientNumber,required TResult Function( _ValidateRecipient value)  validateRecipient,required TResult Function( _MakePurchase value)  makePurchase,required TResult Function( _LoadHistory value)  loadHistory,required TResult Function( _LoadRecentRecipients value)  loadRecentRecipients,required TResult Function( _SelectRecentRecipient value)  selectRecentRecipient,required TResult Function( _ResetSelection value)  resetSelection,required TResult Function( _ClearError value)  clearError,required TResult Function( _ClearSuccess value)  clearSuccess,}){
final _that = this;
switch (_that) {
case _LoadProviders():
return loadProviders(_that);case _LoadProvidersByCategory():
return loadProvidersByCategory(_that);case _SelectCategory():
return selectCategory(_that);case _SelectProvider():
return selectProvider(_that);case _LoadProducts():
return loadProducts(_that);case _SelectProduct():
return selectProduct(_that);case _SetRecipientNumber():
return setRecipientNumber(_that);case _ValidateRecipient():
return validateRecipient(_that);case _MakePurchase():
return makePurchase(_that);case _LoadHistory():
return loadHistory(_that);case _LoadRecentRecipients():
return loadRecentRecipients(_that);case _SelectRecentRecipient():
return selectRecentRecipient(_that);case _ResetSelection():
return resetSelection(_that);case _ClearError():
return clearError(_that);case _ClearSuccess():
return clearSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadProviders value)?  loadProviders,TResult? Function( _LoadProvidersByCategory value)?  loadProvidersByCategory,TResult? Function( _SelectCategory value)?  selectCategory,TResult? Function( _SelectProvider value)?  selectProvider,TResult? Function( _LoadProducts value)?  loadProducts,TResult? Function( _SelectProduct value)?  selectProduct,TResult? Function( _SetRecipientNumber value)?  setRecipientNumber,TResult? Function( _ValidateRecipient value)?  validateRecipient,TResult? Function( _MakePurchase value)?  makePurchase,TResult? Function( _LoadHistory value)?  loadHistory,TResult? Function( _LoadRecentRecipients value)?  loadRecentRecipients,TResult? Function( _SelectRecentRecipient value)?  selectRecentRecipient,TResult? Function( _ResetSelection value)?  resetSelection,TResult? Function( _ClearError value)?  clearError,TResult? Function( _ClearSuccess value)?  clearSuccess,}){
final _that = this;
switch (_that) {
case _LoadProviders() when loadProviders != null:
return loadProviders(_that);case _LoadProvidersByCategory() when loadProvidersByCategory != null:
return loadProvidersByCategory(_that);case _SelectCategory() when selectCategory != null:
return selectCategory(_that);case _SelectProvider() when selectProvider != null:
return selectProvider(_that);case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _SelectProduct() when selectProduct != null:
return selectProduct(_that);case _SetRecipientNumber() when setRecipientNumber != null:
return setRecipientNumber(_that);case _ValidateRecipient() when validateRecipient != null:
return validateRecipient(_that);case _MakePurchase() when makePurchase != null:
return makePurchase(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _LoadRecentRecipients() when loadRecentRecipients != null:
return loadRecentRecipients(_that);case _SelectRecentRecipient() when selectRecentRecipient != null:
return selectRecentRecipient(_that);case _ResetSelection() when resetSelection != null:
return resetSelection(_that);case _ClearError() when clearError != null:
return clearError(_that);case _ClearSuccess() when clearSuccess != null:
return clearSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadProviders,TResult Function( PurchaseCategory category)?  loadProvidersByCategory,TResult Function( PurchaseCategory? category)?  selectCategory,TResult Function( ServiceProvider provider)?  selectProvider,TResult Function( String providerId)?  loadProducts,TResult Function( ServiceProduct product)?  selectProduct,TResult Function( String number)?  setRecipientNumber,TResult Function()?  validateRecipient,TResult Function( String? subAccountId)?  makePurchase,TResult Function( PurchaseCategory? category,  int? limit,  DateTime? startAfter)?  loadHistory,TResult Function( PurchaseCategory? category)?  loadRecentRecipients,TResult Function( String number)?  selectRecentRecipient,TResult Function()?  resetSelection,TResult Function()?  clearError,TResult Function()?  clearSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadProviders() when loadProviders != null:
return loadProviders();case _LoadProvidersByCategory() when loadProvidersByCategory != null:
return loadProvidersByCategory(_that.category);case _SelectCategory() when selectCategory != null:
return selectCategory(_that.category);case _SelectProvider() when selectProvider != null:
return selectProvider(_that.provider);case _LoadProducts() when loadProducts != null:
return loadProducts(_that.providerId);case _SelectProduct() when selectProduct != null:
return selectProduct(_that.product);case _SetRecipientNumber() when setRecipientNumber != null:
return setRecipientNumber(_that.number);case _ValidateRecipient() when validateRecipient != null:
return validateRecipient();case _MakePurchase() when makePurchase != null:
return makePurchase(_that.subAccountId);case _LoadHistory() when loadHistory != null:
return loadHistory(_that.category,_that.limit,_that.startAfter);case _LoadRecentRecipients() when loadRecentRecipients != null:
return loadRecentRecipients(_that.category);case _SelectRecentRecipient() when selectRecentRecipient != null:
return selectRecentRecipient(_that.number);case _ResetSelection() when resetSelection != null:
return resetSelection();case _ClearError() when clearError != null:
return clearError();case _ClearSuccess() when clearSuccess != null:
return clearSuccess();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadProviders,required TResult Function( PurchaseCategory category)  loadProvidersByCategory,required TResult Function( PurchaseCategory? category)  selectCategory,required TResult Function( ServiceProvider provider)  selectProvider,required TResult Function( String providerId)  loadProducts,required TResult Function( ServiceProduct product)  selectProduct,required TResult Function( String number)  setRecipientNumber,required TResult Function()  validateRecipient,required TResult Function( String? subAccountId)  makePurchase,required TResult Function( PurchaseCategory? category,  int? limit,  DateTime? startAfter)  loadHistory,required TResult Function( PurchaseCategory? category)  loadRecentRecipients,required TResult Function( String number)  selectRecentRecipient,required TResult Function()  resetSelection,required TResult Function()  clearError,required TResult Function()  clearSuccess,}) {final _that = this;
switch (_that) {
case _LoadProviders():
return loadProviders();case _LoadProvidersByCategory():
return loadProvidersByCategory(_that.category);case _SelectCategory():
return selectCategory(_that.category);case _SelectProvider():
return selectProvider(_that.provider);case _LoadProducts():
return loadProducts(_that.providerId);case _SelectProduct():
return selectProduct(_that.product);case _SetRecipientNumber():
return setRecipientNumber(_that.number);case _ValidateRecipient():
return validateRecipient();case _MakePurchase():
return makePurchase(_that.subAccountId);case _LoadHistory():
return loadHistory(_that.category,_that.limit,_that.startAfter);case _LoadRecentRecipients():
return loadRecentRecipients(_that.category);case _SelectRecentRecipient():
return selectRecentRecipient(_that.number);case _ResetSelection():
return resetSelection();case _ClearError():
return clearError();case _ClearSuccess():
return clearSuccess();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadProviders,TResult? Function( PurchaseCategory category)?  loadProvidersByCategory,TResult? Function( PurchaseCategory? category)?  selectCategory,TResult? Function( ServiceProvider provider)?  selectProvider,TResult? Function( String providerId)?  loadProducts,TResult? Function( ServiceProduct product)?  selectProduct,TResult? Function( String number)?  setRecipientNumber,TResult? Function()?  validateRecipient,TResult? Function( String? subAccountId)?  makePurchase,TResult? Function( PurchaseCategory? category,  int? limit,  DateTime? startAfter)?  loadHistory,TResult? Function( PurchaseCategory? category)?  loadRecentRecipients,TResult? Function( String number)?  selectRecentRecipient,TResult? Function()?  resetSelection,TResult? Function()?  clearError,TResult? Function()?  clearSuccess,}) {final _that = this;
switch (_that) {
case _LoadProviders() when loadProviders != null:
return loadProviders();case _LoadProvidersByCategory() when loadProvidersByCategory != null:
return loadProvidersByCategory(_that.category);case _SelectCategory() when selectCategory != null:
return selectCategory(_that.category);case _SelectProvider() when selectProvider != null:
return selectProvider(_that.provider);case _LoadProducts() when loadProducts != null:
return loadProducts(_that.providerId);case _SelectProduct() when selectProduct != null:
return selectProduct(_that.product);case _SetRecipientNumber() when setRecipientNumber != null:
return setRecipientNumber(_that.number);case _ValidateRecipient() when validateRecipient != null:
return validateRecipient();case _MakePurchase() when makePurchase != null:
return makePurchase(_that.subAccountId);case _LoadHistory() when loadHistory != null:
return loadHistory(_that.category,_that.limit,_that.startAfter);case _LoadRecentRecipients() when loadRecentRecipients != null:
return loadRecentRecipients(_that.category);case _SelectRecentRecipient() when selectRecentRecipient != null:
return selectRecentRecipient(_that.number);case _ResetSelection() when resetSelection != null:
return resetSelection();case _ClearError() when clearError != null:
return clearError();case _ClearSuccess() when clearSuccess != null:
return clearSuccess();case _:
  return null;

}
}

}

/// @nodoc


class _LoadProviders implements PurchaseEvent {
  const _LoadProviders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProviders);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseEvent.loadProviders()';
}


}




/// @nodoc


class _LoadProvidersByCategory implements PurchaseEvent {
  const _LoadProvidersByCategory(this.category);
  

 final  PurchaseCategory category;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProvidersByCategoryCopyWith<_LoadProvidersByCategory> get copyWith => __$LoadProvidersByCategoryCopyWithImpl<_LoadProvidersByCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProvidersByCategory&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'PurchaseEvent.loadProvidersByCategory(category: $category)';
}


}

/// @nodoc
abstract mixin class _$LoadProvidersByCategoryCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$LoadProvidersByCategoryCopyWith(_LoadProvidersByCategory value, $Res Function(_LoadProvidersByCategory) _then) = __$LoadProvidersByCategoryCopyWithImpl;
@useResult
$Res call({
 PurchaseCategory category
});




}
/// @nodoc
class __$LoadProvidersByCategoryCopyWithImpl<$Res>
    implements _$LoadProvidersByCategoryCopyWith<$Res> {
  __$LoadProvidersByCategoryCopyWithImpl(this._self, this._then);

  final _LoadProvidersByCategory _self;
  final $Res Function(_LoadProvidersByCategory) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,}) {
  return _then(_LoadProvidersByCategory(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory,
  ));
}


}

/// @nodoc


class _SelectCategory implements PurchaseEvent {
  const _SelectCategory(this.category);
  

 final  PurchaseCategory? category;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectCategoryCopyWith<_SelectCategory> get copyWith => __$SelectCategoryCopyWithImpl<_SelectCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectCategory&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'PurchaseEvent.selectCategory(category: $category)';
}


}

/// @nodoc
abstract mixin class _$SelectCategoryCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$SelectCategoryCopyWith(_SelectCategory value, $Res Function(_SelectCategory) _then) = __$SelectCategoryCopyWithImpl;
@useResult
$Res call({
 PurchaseCategory? category
});




}
/// @nodoc
class __$SelectCategoryCopyWithImpl<$Res>
    implements _$SelectCategoryCopyWith<$Res> {
  __$SelectCategoryCopyWithImpl(this._self, this._then);

  final _SelectCategory _self;
  final $Res Function(_SelectCategory) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = freezed,}) {
  return _then(_SelectCategory(
freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory?,
  ));
}


}

/// @nodoc


class _SelectProvider implements PurchaseEvent {
  const _SelectProvider(this.provider);
  

 final  ServiceProvider provider;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectProviderCopyWith<_SelectProvider> get copyWith => __$SelectProviderCopyWithImpl<_SelectProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectProvider&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'PurchaseEvent.selectProvider(provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$SelectProviderCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$SelectProviderCopyWith(_SelectProvider value, $Res Function(_SelectProvider) _then) = __$SelectProviderCopyWithImpl;
@useResult
$Res call({
 ServiceProvider provider
});


$ServiceProviderCopyWith<$Res> get provider;

}
/// @nodoc
class __$SelectProviderCopyWithImpl<$Res>
    implements _$SelectProviderCopyWith<$Res> {
  __$SelectProviderCopyWithImpl(this._self, this._then);

  final _SelectProvider _self;
  final $Res Function(_SelectProvider) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(_SelectProvider(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ServiceProvider,
  ));
}

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceProviderCopyWith<$Res> get provider {
  
  return $ServiceProviderCopyWith<$Res>(_self.provider, (value) {
    return _then(_self.copyWith(provider: value));
  });
}
}

/// @nodoc


class _LoadProducts implements PurchaseEvent {
  const _LoadProducts(this.providerId);
  

 final  String providerId;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProductsCopyWith<_LoadProducts> get copyWith => __$LoadProductsCopyWithImpl<_LoadProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProducts&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,providerId);

@override
String toString() {
  return 'PurchaseEvent.loadProducts(providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class _$LoadProductsCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$LoadProductsCopyWith(_LoadProducts value, $Res Function(_LoadProducts) _then) = __$LoadProductsCopyWithImpl;
@useResult
$Res call({
 String providerId
});




}
/// @nodoc
class __$LoadProductsCopyWithImpl<$Res>
    implements _$LoadProductsCopyWith<$Res> {
  __$LoadProductsCopyWithImpl(this._self, this._then);

  final _LoadProducts _self;
  final $Res Function(_LoadProducts) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? providerId = null,}) {
  return _then(_LoadProducts(
null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelectProduct implements PurchaseEvent {
  const _SelectProduct(this.product);
  

 final  ServiceProduct product;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectProductCopyWith<_SelectProduct> get copyWith => __$SelectProductCopyWithImpl<_SelectProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectProduct&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'PurchaseEvent.selectProduct(product: $product)';
}


}

/// @nodoc
abstract mixin class _$SelectProductCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$SelectProductCopyWith(_SelectProduct value, $Res Function(_SelectProduct) _then) = __$SelectProductCopyWithImpl;
@useResult
$Res call({
 ServiceProduct product
});


$ServiceProductCopyWith<$Res> get product;

}
/// @nodoc
class __$SelectProductCopyWithImpl<$Res>
    implements _$SelectProductCopyWith<$Res> {
  __$SelectProductCopyWithImpl(this._self, this._then);

  final _SelectProduct _self;
  final $Res Function(_SelectProduct) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(_SelectProduct(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ServiceProduct,
  ));
}

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceProductCopyWith<$Res> get product {
  
  return $ServiceProductCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc


class _SetRecipientNumber implements PurchaseEvent {
  const _SetRecipientNumber(this.number);
  

 final  String number;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetRecipientNumberCopyWith<_SetRecipientNumber> get copyWith => __$SetRecipientNumberCopyWithImpl<_SetRecipientNumber>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetRecipientNumber&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,number);

@override
String toString() {
  return 'PurchaseEvent.setRecipientNumber(number: $number)';
}


}

/// @nodoc
abstract mixin class _$SetRecipientNumberCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$SetRecipientNumberCopyWith(_SetRecipientNumber value, $Res Function(_SetRecipientNumber) _then) = __$SetRecipientNumberCopyWithImpl;
@useResult
$Res call({
 String number
});




}
/// @nodoc
class __$SetRecipientNumberCopyWithImpl<$Res>
    implements _$SetRecipientNumberCopyWith<$Res> {
  __$SetRecipientNumberCopyWithImpl(this._self, this._then);

  final _SetRecipientNumber _self;
  final $Res Function(_SetRecipientNumber) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? number = null,}) {
  return _then(_SetRecipientNumber(
null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ValidateRecipient implements PurchaseEvent {
  const _ValidateRecipient();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateRecipient);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseEvent.validateRecipient()';
}


}




/// @nodoc


class _MakePurchase implements PurchaseEvent {
  const _MakePurchase({this.subAccountId});
  

 final  String? subAccountId;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MakePurchaseCopyWith<_MakePurchase> get copyWith => __$MakePurchaseCopyWithImpl<_MakePurchase>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MakePurchase&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,subAccountId);

@override
String toString() {
  return 'PurchaseEvent.makePurchase(subAccountId: $subAccountId)';
}


}

/// @nodoc
abstract mixin class _$MakePurchaseCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$MakePurchaseCopyWith(_MakePurchase value, $Res Function(_MakePurchase) _then) = __$MakePurchaseCopyWithImpl;
@useResult
$Res call({
 String? subAccountId
});




}
/// @nodoc
class __$MakePurchaseCopyWithImpl<$Res>
    implements _$MakePurchaseCopyWith<$Res> {
  __$MakePurchaseCopyWithImpl(this._self, this._then);

  final _MakePurchase _self;
  final $Res Function(_MakePurchase) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subAccountId = freezed,}) {
  return _then(_MakePurchase(
subAccountId: freezed == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadHistory implements PurchaseEvent {
  const _LoadHistory({this.category, this.limit, this.startAfter});
  

 final  PurchaseCategory? category;
 final  int? limit;
 final  DateTime? startAfter;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadHistoryCopyWith<_LoadHistory> get copyWith => __$LoadHistoryCopyWithImpl<_LoadHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadHistory&&(identical(other.category, category) || other.category == category)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.startAfter, startAfter) || other.startAfter == startAfter));
}


@override
int get hashCode => Object.hash(runtimeType,category,limit,startAfter);

@override
String toString() {
  return 'PurchaseEvent.loadHistory(category: $category, limit: $limit, startAfter: $startAfter)';
}


}

/// @nodoc
abstract mixin class _$LoadHistoryCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$LoadHistoryCopyWith(_LoadHistory value, $Res Function(_LoadHistory) _then) = __$LoadHistoryCopyWithImpl;
@useResult
$Res call({
 PurchaseCategory? category, int? limit, DateTime? startAfter
});




}
/// @nodoc
class __$LoadHistoryCopyWithImpl<$Res>
    implements _$LoadHistoryCopyWith<$Res> {
  __$LoadHistoryCopyWithImpl(this._self, this._then);

  final _LoadHistory _self;
  final $Res Function(_LoadHistory) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? limit = freezed,Object? startAfter = freezed,}) {
  return _then(_LoadHistory(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,startAfter: freezed == startAfter ? _self.startAfter : startAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _LoadRecentRecipients implements PurchaseEvent {
  const _LoadRecentRecipients({this.category});
  

 final  PurchaseCategory? category;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadRecentRecipientsCopyWith<_LoadRecentRecipients> get copyWith => __$LoadRecentRecipientsCopyWithImpl<_LoadRecentRecipients>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadRecentRecipients&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'PurchaseEvent.loadRecentRecipients(category: $category)';
}


}

/// @nodoc
abstract mixin class _$LoadRecentRecipientsCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$LoadRecentRecipientsCopyWith(_LoadRecentRecipients value, $Res Function(_LoadRecentRecipients) _then) = __$LoadRecentRecipientsCopyWithImpl;
@useResult
$Res call({
 PurchaseCategory? category
});




}
/// @nodoc
class __$LoadRecentRecipientsCopyWithImpl<$Res>
    implements _$LoadRecentRecipientsCopyWith<$Res> {
  __$LoadRecentRecipientsCopyWithImpl(this._self, this._then);

  final _LoadRecentRecipients _self;
  final $Res Function(_LoadRecentRecipients) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = freezed,}) {
  return _then(_LoadRecentRecipients(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory?,
  ));
}


}

/// @nodoc


class _SelectRecentRecipient implements PurchaseEvent {
  const _SelectRecentRecipient(this.number);
  

 final  String number;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectRecentRecipientCopyWith<_SelectRecentRecipient> get copyWith => __$SelectRecentRecipientCopyWithImpl<_SelectRecentRecipient>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectRecentRecipient&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,number);

@override
String toString() {
  return 'PurchaseEvent.selectRecentRecipient(number: $number)';
}


}

/// @nodoc
abstract mixin class _$SelectRecentRecipientCopyWith<$Res> implements $PurchaseEventCopyWith<$Res> {
  factory _$SelectRecentRecipientCopyWith(_SelectRecentRecipient value, $Res Function(_SelectRecentRecipient) _then) = __$SelectRecentRecipientCopyWithImpl;
@useResult
$Res call({
 String number
});




}
/// @nodoc
class __$SelectRecentRecipientCopyWithImpl<$Res>
    implements _$SelectRecentRecipientCopyWith<$Res> {
  __$SelectRecentRecipientCopyWithImpl(this._self, this._then);

  final _SelectRecentRecipient _self;
  final $Res Function(_SelectRecentRecipient) _then;

/// Create a copy of PurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? number = null,}) {
  return _then(_SelectRecentRecipient(
null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetSelection implements PurchaseEvent {
  const _ResetSelection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetSelection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseEvent.resetSelection()';
}


}




/// @nodoc


class _ClearError implements PurchaseEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseEvent.clearError()';
}


}




/// @nodoc


class _ClearSuccess implements PurchaseEvent {
  const _ClearSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseEvent.clearSuccess()';
}


}




/// @nodoc
mixin _$PurchaseState {

 bool get isLoadingProviders; bool get isLoadingProducts; bool get isLoadingHistory; bool get isPurchasing; bool get isValidating; List<ServiceProvider> get providers; List<ServiceProduct> get products; List<Purchase> get history; List<String> get recentRecipients; PurchaseCategory? get selectedCategory; ServiceProvider? get selectedProvider; ServiceProduct? get selectedProduct; String? get recipientNumber; bool? get isRecipientValid; Purchase? get lastPurchase; bool get hasMoreHistory; String? get errorMessage; String? get successMessage;
/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseStateCopyWith<PurchaseState> get copyWith => _$PurchaseStateCopyWithImpl<PurchaseState>(this as PurchaseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseState&&(identical(other.isLoadingProviders, isLoadingProviders) || other.isLoadingProviders == isLoadingProviders)&&(identical(other.isLoadingProducts, isLoadingProducts) || other.isLoadingProducts == isLoadingProducts)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.isPurchasing, isPurchasing) || other.isPurchasing == isPurchasing)&&(identical(other.isValidating, isValidating) || other.isValidating == isValidating)&&const DeepCollectionEquality().equals(other.providers, providers)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.history, history)&&const DeepCollectionEquality().equals(other.recentRecipients, recentRecipients)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.recipientNumber, recipientNumber) || other.recipientNumber == recipientNumber)&&(identical(other.isRecipientValid, isRecipientValid) || other.isRecipientValid == isRecipientValid)&&(identical(other.lastPurchase, lastPurchase) || other.lastPurchase == lastPurchase)&&(identical(other.hasMoreHistory, hasMoreHistory) || other.hasMoreHistory == hasMoreHistory)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingProviders,isLoadingProducts,isLoadingHistory,isPurchasing,isValidating,const DeepCollectionEquality().hash(providers),const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(history),const DeepCollectionEquality().hash(recentRecipients),selectedCategory,selectedProvider,selectedProduct,recipientNumber,isRecipientValid,lastPurchase,hasMoreHistory,errorMessage,successMessage);

@override
String toString() {
  return 'PurchaseState(isLoadingProviders: $isLoadingProviders, isLoadingProducts: $isLoadingProducts, isLoadingHistory: $isLoadingHistory, isPurchasing: $isPurchasing, isValidating: $isValidating, providers: $providers, products: $products, history: $history, recentRecipients: $recentRecipients, selectedCategory: $selectedCategory, selectedProvider: $selectedProvider, selectedProduct: $selectedProduct, recipientNumber: $recipientNumber, isRecipientValid: $isRecipientValid, lastPurchase: $lastPurchase, hasMoreHistory: $hasMoreHistory, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $PurchaseStateCopyWith<$Res>  {
  factory $PurchaseStateCopyWith(PurchaseState value, $Res Function(PurchaseState) _then) = _$PurchaseStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingProviders, bool isLoadingProducts, bool isLoadingHistory, bool isPurchasing, bool isValidating, List<ServiceProvider> providers, List<ServiceProduct> products, List<Purchase> history, List<String> recentRecipients, PurchaseCategory? selectedCategory, ServiceProvider? selectedProvider, ServiceProduct? selectedProduct, String? recipientNumber, bool? isRecipientValid, Purchase? lastPurchase, bool hasMoreHistory, String? errorMessage, String? successMessage
});


$ServiceProviderCopyWith<$Res>? get selectedProvider;$ServiceProductCopyWith<$Res>? get selectedProduct;$PurchaseCopyWith<$Res>? get lastPurchase;

}
/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._self, this._then);

  final PurchaseState _self;
  final $Res Function(PurchaseState) _then;

/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingProviders = null,Object? isLoadingProducts = null,Object? isLoadingHistory = null,Object? isPurchasing = null,Object? isValidating = null,Object? providers = null,Object? products = null,Object? history = null,Object? recentRecipients = null,Object? selectedCategory = freezed,Object? selectedProvider = freezed,Object? selectedProduct = freezed,Object? recipientNumber = freezed,Object? isRecipientValid = freezed,Object? lastPurchase = freezed,Object? hasMoreHistory = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoadingProviders: null == isLoadingProviders ? _self.isLoadingProviders : isLoadingProviders // ignore: cast_nullable_to_non_nullable
as bool,isLoadingProducts: null == isLoadingProducts ? _self.isLoadingProducts : isLoadingProducts // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,isPurchasing: null == isPurchasing ? _self.isPurchasing : isPurchasing // ignore: cast_nullable_to_non_nullable
as bool,isValidating: null == isValidating ? _self.isValidating : isValidating // ignore: cast_nullable_to_non_nullable
as bool,providers: null == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<ServiceProvider>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ServiceProduct>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<Purchase>,recentRecipients: null == recentRecipients ? _self.recentRecipients : recentRecipients // ignore: cast_nullable_to_non_nullable
as List<String>,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as PurchaseCategory?,selectedProvider: freezed == selectedProvider ? _self.selectedProvider : selectedProvider // ignore: cast_nullable_to_non_nullable
as ServiceProvider?,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as ServiceProduct?,recipientNumber: freezed == recipientNumber ? _self.recipientNumber : recipientNumber // ignore: cast_nullable_to_non_nullable
as String?,isRecipientValid: freezed == isRecipientValid ? _self.isRecipientValid : isRecipientValid // ignore: cast_nullable_to_non_nullable
as bool?,lastPurchase: freezed == lastPurchase ? _self.lastPurchase : lastPurchase // ignore: cast_nullable_to_non_nullable
as Purchase?,hasMoreHistory: null == hasMoreHistory ? _self.hasMoreHistory : hasMoreHistory // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceProviderCopyWith<$Res>? get selectedProvider {
    if (_self.selectedProvider == null) {
    return null;
  }

  return $ServiceProviderCopyWith<$Res>(_self.selectedProvider!, (value) {
    return _then(_self.copyWith(selectedProvider: value));
  });
}/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceProductCopyWith<$Res>? get selectedProduct {
    if (_self.selectedProduct == null) {
    return null;
  }

  return $ServiceProductCopyWith<$Res>(_self.selectedProduct!, (value) {
    return _then(_self.copyWith(selectedProduct: value));
  });
}/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseCopyWith<$Res>? get lastPurchase {
    if (_self.lastPurchase == null) {
    return null;
  }

  return $PurchaseCopyWith<$Res>(_self.lastPurchase!, (value) {
    return _then(_self.copyWith(lastPurchase: value));
  });
}
}


/// Adds pattern-matching-related methods to [PurchaseState].
extension PurchaseStatePatterns on PurchaseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseState value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseState value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoadingProviders,  bool isLoadingProducts,  bool isLoadingHistory,  bool isPurchasing,  bool isValidating,  List<ServiceProvider> providers,  List<ServiceProduct> products,  List<Purchase> history,  List<String> recentRecipients,  PurchaseCategory? selectedCategory,  ServiceProvider? selectedProvider,  ServiceProduct? selectedProduct,  String? recipientNumber,  bool? isRecipientValid,  Purchase? lastPurchase,  bool hasMoreHistory,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseState() when $default != null:
return $default(_that.isLoadingProviders,_that.isLoadingProducts,_that.isLoadingHistory,_that.isPurchasing,_that.isValidating,_that.providers,_that.products,_that.history,_that.recentRecipients,_that.selectedCategory,_that.selectedProvider,_that.selectedProduct,_that.recipientNumber,_that.isRecipientValid,_that.lastPurchase,_that.hasMoreHistory,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoadingProviders,  bool isLoadingProducts,  bool isLoadingHistory,  bool isPurchasing,  bool isValidating,  List<ServiceProvider> providers,  List<ServiceProduct> products,  List<Purchase> history,  List<String> recentRecipients,  PurchaseCategory? selectedCategory,  ServiceProvider? selectedProvider,  ServiceProduct? selectedProduct,  String? recipientNumber,  bool? isRecipientValid,  Purchase? lastPurchase,  bool hasMoreHistory,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _PurchaseState():
return $default(_that.isLoadingProviders,_that.isLoadingProducts,_that.isLoadingHistory,_that.isPurchasing,_that.isValidating,_that.providers,_that.products,_that.history,_that.recentRecipients,_that.selectedCategory,_that.selectedProvider,_that.selectedProduct,_that.recipientNumber,_that.isRecipientValid,_that.lastPurchase,_that.hasMoreHistory,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoadingProviders,  bool isLoadingProducts,  bool isLoadingHistory,  bool isPurchasing,  bool isValidating,  List<ServiceProvider> providers,  List<ServiceProduct> products,  List<Purchase> history,  List<String> recentRecipients,  PurchaseCategory? selectedCategory,  ServiceProvider? selectedProvider,  ServiceProduct? selectedProduct,  String? recipientNumber,  bool? isRecipientValid,  Purchase? lastPurchase,  bool hasMoreHistory,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseState() when $default != null:
return $default(_that.isLoadingProviders,_that.isLoadingProducts,_that.isLoadingHistory,_that.isPurchasing,_that.isValidating,_that.providers,_that.products,_that.history,_that.recentRecipients,_that.selectedCategory,_that.selectedProvider,_that.selectedProduct,_that.recipientNumber,_that.isRecipientValid,_that.lastPurchase,_that.hasMoreHistory,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseState implements PurchaseState {
  const _PurchaseState({this.isLoadingProviders = false, this.isLoadingProducts = false, this.isLoadingHistory = false, this.isPurchasing = false, this.isValidating = false, final  List<ServiceProvider> providers = const [], final  List<ServiceProduct> products = const [], final  List<Purchase> history = const [], final  List<String> recentRecipients = const [], this.selectedCategory, this.selectedProvider, this.selectedProduct, this.recipientNumber, this.isRecipientValid, this.lastPurchase, this.hasMoreHistory = false, this.errorMessage, this.successMessage}): _providers = providers,_products = products,_history = history,_recentRecipients = recentRecipients;
  

@override@JsonKey() final  bool isLoadingProviders;
@override@JsonKey() final  bool isLoadingProducts;
@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool isPurchasing;
@override@JsonKey() final  bool isValidating;
 final  List<ServiceProvider> _providers;
@override@JsonKey() List<ServiceProvider> get providers {
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providers);
}

 final  List<ServiceProduct> _products;
@override@JsonKey() List<ServiceProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<Purchase> _history;
@override@JsonKey() List<Purchase> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

 final  List<String> _recentRecipients;
@override@JsonKey() List<String> get recentRecipients {
  if (_recentRecipients is EqualUnmodifiableListView) return _recentRecipients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentRecipients);
}

@override final  PurchaseCategory? selectedCategory;
@override final  ServiceProvider? selectedProvider;
@override final  ServiceProduct? selectedProduct;
@override final  String? recipientNumber;
@override final  bool? isRecipientValid;
@override final  Purchase? lastPurchase;
@override@JsonKey() final  bool hasMoreHistory;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseStateCopyWith<_PurchaseState> get copyWith => __$PurchaseStateCopyWithImpl<_PurchaseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseState&&(identical(other.isLoadingProviders, isLoadingProviders) || other.isLoadingProviders == isLoadingProviders)&&(identical(other.isLoadingProducts, isLoadingProducts) || other.isLoadingProducts == isLoadingProducts)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.isPurchasing, isPurchasing) || other.isPurchasing == isPurchasing)&&(identical(other.isValidating, isValidating) || other.isValidating == isValidating)&&const DeepCollectionEquality().equals(other._providers, _providers)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._history, _history)&&const DeepCollectionEquality().equals(other._recentRecipients, _recentRecipients)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.recipientNumber, recipientNumber) || other.recipientNumber == recipientNumber)&&(identical(other.isRecipientValid, isRecipientValid) || other.isRecipientValid == isRecipientValid)&&(identical(other.lastPurchase, lastPurchase) || other.lastPurchase == lastPurchase)&&(identical(other.hasMoreHistory, hasMoreHistory) || other.hasMoreHistory == hasMoreHistory)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingProviders,isLoadingProducts,isLoadingHistory,isPurchasing,isValidating,const DeepCollectionEquality().hash(_providers),const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(_recentRecipients),selectedCategory,selectedProvider,selectedProduct,recipientNumber,isRecipientValid,lastPurchase,hasMoreHistory,errorMessage,successMessage);

@override
String toString() {
  return 'PurchaseState(isLoadingProviders: $isLoadingProviders, isLoadingProducts: $isLoadingProducts, isLoadingHistory: $isLoadingHistory, isPurchasing: $isPurchasing, isValidating: $isValidating, providers: $providers, products: $products, history: $history, recentRecipients: $recentRecipients, selectedCategory: $selectedCategory, selectedProvider: $selectedProvider, selectedProduct: $selectedProduct, recipientNumber: $recipientNumber, isRecipientValid: $isRecipientValid, lastPurchase: $lastPurchase, hasMoreHistory: $hasMoreHistory, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$PurchaseStateCopyWith<$Res> implements $PurchaseStateCopyWith<$Res> {
  factory _$PurchaseStateCopyWith(_PurchaseState value, $Res Function(_PurchaseState) _then) = __$PurchaseStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingProviders, bool isLoadingProducts, bool isLoadingHistory, bool isPurchasing, bool isValidating, List<ServiceProvider> providers, List<ServiceProduct> products, List<Purchase> history, List<String> recentRecipients, PurchaseCategory? selectedCategory, ServiceProvider? selectedProvider, ServiceProduct? selectedProduct, String? recipientNumber, bool? isRecipientValid, Purchase? lastPurchase, bool hasMoreHistory, String? errorMessage, String? successMessage
});


@override $ServiceProviderCopyWith<$Res>? get selectedProvider;@override $ServiceProductCopyWith<$Res>? get selectedProduct;@override $PurchaseCopyWith<$Res>? get lastPurchase;

}
/// @nodoc
class __$PurchaseStateCopyWithImpl<$Res>
    implements _$PurchaseStateCopyWith<$Res> {
  __$PurchaseStateCopyWithImpl(this._self, this._then);

  final _PurchaseState _self;
  final $Res Function(_PurchaseState) _then;

/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingProviders = null,Object? isLoadingProducts = null,Object? isLoadingHistory = null,Object? isPurchasing = null,Object? isValidating = null,Object? providers = null,Object? products = null,Object? history = null,Object? recentRecipients = null,Object? selectedCategory = freezed,Object? selectedProvider = freezed,Object? selectedProduct = freezed,Object? recipientNumber = freezed,Object? isRecipientValid = freezed,Object? lastPurchase = freezed,Object? hasMoreHistory = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_PurchaseState(
isLoadingProviders: null == isLoadingProviders ? _self.isLoadingProviders : isLoadingProviders // ignore: cast_nullable_to_non_nullable
as bool,isLoadingProducts: null == isLoadingProducts ? _self.isLoadingProducts : isLoadingProducts // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,isPurchasing: null == isPurchasing ? _self.isPurchasing : isPurchasing // ignore: cast_nullable_to_non_nullable
as bool,isValidating: null == isValidating ? _self.isValidating : isValidating // ignore: cast_nullable_to_non_nullable
as bool,providers: null == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<ServiceProvider>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ServiceProduct>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<Purchase>,recentRecipients: null == recentRecipients ? _self._recentRecipients : recentRecipients // ignore: cast_nullable_to_non_nullable
as List<String>,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as PurchaseCategory?,selectedProvider: freezed == selectedProvider ? _self.selectedProvider : selectedProvider // ignore: cast_nullable_to_non_nullable
as ServiceProvider?,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as ServiceProduct?,recipientNumber: freezed == recipientNumber ? _self.recipientNumber : recipientNumber // ignore: cast_nullable_to_non_nullable
as String?,isRecipientValid: freezed == isRecipientValid ? _self.isRecipientValid : isRecipientValid // ignore: cast_nullable_to_non_nullable
as bool?,lastPurchase: freezed == lastPurchase ? _self.lastPurchase : lastPurchase // ignore: cast_nullable_to_non_nullable
as Purchase?,hasMoreHistory: null == hasMoreHistory ? _self.hasMoreHistory : hasMoreHistory // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceProviderCopyWith<$Res>? get selectedProvider {
    if (_self.selectedProvider == null) {
    return null;
  }

  return $ServiceProviderCopyWith<$Res>(_self.selectedProvider!, (value) {
    return _then(_self.copyWith(selectedProvider: value));
  });
}/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceProductCopyWith<$Res>? get selectedProduct {
    if (_self.selectedProduct == null) {
    return null;
  }

  return $ServiceProductCopyWith<$Res>(_self.selectedProduct!, (value) {
    return _then(_self.copyWith(selectedProduct: value));
  });
}/// Create a copy of PurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseCopyWith<$Res>? get lastPurchase {
    if (_self.lastPurchase == null) {
    return null;
  }

  return $PurchaseCopyWith<$Res>(_self.lastPurchase!, (value) {
    return _then(_self.copyWith(lastPurchase: value));
  });
}
}

// dart format on
