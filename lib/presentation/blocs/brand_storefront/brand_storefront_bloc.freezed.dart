// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandStorefrontEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandStorefrontEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BrandStorefrontEvent()';
}


}

/// @nodoc
class $BrandStorefrontEventCopyWith<$Res>  {
$BrandStorefrontEventCopyWith(BrandStorefrontEvent _, $Res Function(BrandStorefrontEvent) __);
}


/// Adds pattern-matching-related methods to [BrandStorefrontEvent].
extension BrandStorefrontEventPatterns on BrandStorefrontEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadStorefront value)?  loadStorefront,TResult Function( _LoadProducts value)?  loadProducts,TResult Function( _LoadReviews value)?  loadReviews,TResult Function( _SubmitReview value)?  submitReview,TResult Function( _ClaimCoupon value)?  claimCoupon,TResult Function( _RecordView value)?  recordView,TResult Function( _ToggleFollow value)?  toggleFollow,TResult Function( _ResetReviewState value)?  resetReviewState,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadStorefront() when loadStorefront != null:
return loadStorefront(_that);case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _LoadReviews() when loadReviews != null:
return loadReviews(_that);case _SubmitReview() when submitReview != null:
return submitReview(_that);case _ClaimCoupon() when claimCoupon != null:
return claimCoupon(_that);case _RecordView() when recordView != null:
return recordView(_that);case _ToggleFollow() when toggleFollow != null:
return toggleFollow(_that);case _ResetReviewState() when resetReviewState != null:
return resetReviewState(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadStorefront value)  loadStorefront,required TResult Function( _LoadProducts value)  loadProducts,required TResult Function( _LoadReviews value)  loadReviews,required TResult Function( _SubmitReview value)  submitReview,required TResult Function( _ClaimCoupon value)  claimCoupon,required TResult Function( _RecordView value)  recordView,required TResult Function( _ToggleFollow value)  toggleFollow,required TResult Function( _ResetReviewState value)  resetReviewState,}){
final _that = this;
switch (_that) {
case _LoadStorefront():
return loadStorefront(_that);case _LoadProducts():
return loadProducts(_that);case _LoadReviews():
return loadReviews(_that);case _SubmitReview():
return submitReview(_that);case _ClaimCoupon():
return claimCoupon(_that);case _RecordView():
return recordView(_that);case _ToggleFollow():
return toggleFollow(_that);case _ResetReviewState():
return resetReviewState(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadStorefront value)?  loadStorefront,TResult? Function( _LoadProducts value)?  loadProducts,TResult? Function( _LoadReviews value)?  loadReviews,TResult? Function( _SubmitReview value)?  submitReview,TResult? Function( _ClaimCoupon value)?  claimCoupon,TResult? Function( _RecordView value)?  recordView,TResult? Function( _ToggleFollow value)?  toggleFollow,TResult? Function( _ResetReviewState value)?  resetReviewState,}){
final _that = this;
switch (_that) {
case _LoadStorefront() when loadStorefront != null:
return loadStorefront(_that);case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _LoadReviews() when loadReviews != null:
return loadReviews(_that);case _SubmitReview() when submitReview != null:
return submitReview(_that);case _ClaimCoupon() when claimCoupon != null:
return claimCoupon(_that);case _RecordView() when recordView != null:
return recordView(_that);case _ToggleFollow() when toggleFollow != null:
return toggleFollow(_that);case _ResetReviewState() when resetReviewState != null:
return resetReviewState(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String? orderId)?  loadStorefront,TResult Function( String brandId)?  loadProducts,TResult Function( String brandId)?  loadReviews,TResult Function( String brandId,  String orderId,  int qualityRating,  int valueRating,  int serviceRating,  String? comment)?  submitReview,TResult Function( String storefrontId,  String couponId,  String? couponCode)?  claimCoupon,TResult Function( String storefrontId)?  recordView,TResult Function( String brandId)?  toggleFollow,TResult Function()?  resetReviewState,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadStorefront() when loadStorefront != null:
return loadStorefront(_that.id,_that.orderId);case _LoadProducts() when loadProducts != null:
return loadProducts(_that.brandId);case _LoadReviews() when loadReviews != null:
return loadReviews(_that.brandId);case _SubmitReview() when submitReview != null:
return submitReview(_that.brandId,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.comment);case _ClaimCoupon() when claimCoupon != null:
return claimCoupon(_that.storefrontId,_that.couponId,_that.couponCode);case _RecordView() when recordView != null:
return recordView(_that.storefrontId);case _ToggleFollow() when toggleFollow != null:
return toggleFollow(_that.brandId);case _ResetReviewState() when resetReviewState != null:
return resetReviewState();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String? orderId)  loadStorefront,required TResult Function( String brandId)  loadProducts,required TResult Function( String brandId)  loadReviews,required TResult Function( String brandId,  String orderId,  int qualityRating,  int valueRating,  int serviceRating,  String? comment)  submitReview,required TResult Function( String storefrontId,  String couponId,  String? couponCode)  claimCoupon,required TResult Function( String storefrontId)  recordView,required TResult Function( String brandId)  toggleFollow,required TResult Function()  resetReviewState,}) {final _that = this;
switch (_that) {
case _LoadStorefront():
return loadStorefront(_that.id,_that.orderId);case _LoadProducts():
return loadProducts(_that.brandId);case _LoadReviews():
return loadReviews(_that.brandId);case _SubmitReview():
return submitReview(_that.brandId,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.comment);case _ClaimCoupon():
return claimCoupon(_that.storefrontId,_that.couponId,_that.couponCode);case _RecordView():
return recordView(_that.storefrontId);case _ToggleFollow():
return toggleFollow(_that.brandId);case _ResetReviewState():
return resetReviewState();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String? orderId)?  loadStorefront,TResult? Function( String brandId)?  loadProducts,TResult? Function( String brandId)?  loadReviews,TResult? Function( String brandId,  String orderId,  int qualityRating,  int valueRating,  int serviceRating,  String? comment)?  submitReview,TResult? Function( String storefrontId,  String couponId,  String? couponCode)?  claimCoupon,TResult? Function( String storefrontId)?  recordView,TResult? Function( String brandId)?  toggleFollow,TResult? Function()?  resetReviewState,}) {final _that = this;
switch (_that) {
case _LoadStorefront() when loadStorefront != null:
return loadStorefront(_that.id,_that.orderId);case _LoadProducts() when loadProducts != null:
return loadProducts(_that.brandId);case _LoadReviews() when loadReviews != null:
return loadReviews(_that.brandId);case _SubmitReview() when submitReview != null:
return submitReview(_that.brandId,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.comment);case _ClaimCoupon() when claimCoupon != null:
return claimCoupon(_that.storefrontId,_that.couponId,_that.couponCode);case _RecordView() when recordView != null:
return recordView(_that.storefrontId);case _ToggleFollow() when toggleFollow != null:
return toggleFollow(_that.brandId);case _ResetReviewState() when resetReviewState != null:
return resetReviewState();case _:
  return null;

}
}

}

/// @nodoc


class _LoadStorefront implements BrandStorefrontEvent {
  const _LoadStorefront(this.id, {this.orderId});
  

 final  String id;
 final  String? orderId;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadStorefrontCopyWith<_LoadStorefront> get copyWith => __$LoadStorefrontCopyWithImpl<_LoadStorefront>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadStorefront&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderId);

@override
String toString() {
  return 'BrandStorefrontEvent.loadStorefront(id: $id, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$LoadStorefrontCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$LoadStorefrontCopyWith(_LoadStorefront value, $Res Function(_LoadStorefront) _then) = __$LoadStorefrontCopyWithImpl;
@useResult
$Res call({
 String id, String? orderId
});




}
/// @nodoc
class __$LoadStorefrontCopyWithImpl<$Res>
    implements _$LoadStorefrontCopyWith<$Res> {
  __$LoadStorefrontCopyWithImpl(this._self, this._then);

  final _LoadStorefront _self;
  final $Res Function(_LoadStorefront) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = freezed,}) {
  return _then(_LoadStorefront(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadProducts implements BrandStorefrontEvent {
  const _LoadProducts(this.brandId);
  

 final  String brandId;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProductsCopyWith<_LoadProducts> get copyWith => __$LoadProductsCopyWithImpl<_LoadProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProducts&&(identical(other.brandId, brandId) || other.brandId == brandId));
}


@override
int get hashCode => Object.hash(runtimeType,brandId);

@override
String toString() {
  return 'BrandStorefrontEvent.loadProducts(brandId: $brandId)';
}


}

/// @nodoc
abstract mixin class _$LoadProductsCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$LoadProductsCopyWith(_LoadProducts value, $Res Function(_LoadProducts) _then) = __$LoadProductsCopyWithImpl;
@useResult
$Res call({
 String brandId
});




}
/// @nodoc
class __$LoadProductsCopyWithImpl<$Res>
    implements _$LoadProductsCopyWith<$Res> {
  __$LoadProductsCopyWithImpl(this._self, this._then);

  final _LoadProducts _self;
  final $Res Function(_LoadProducts) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brandId = null,}) {
  return _then(_LoadProducts(
null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadReviews implements BrandStorefrontEvent {
  const _LoadReviews(this.brandId);
  

 final  String brandId;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadReviewsCopyWith<_LoadReviews> get copyWith => __$LoadReviewsCopyWithImpl<_LoadReviews>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadReviews&&(identical(other.brandId, brandId) || other.brandId == brandId));
}


@override
int get hashCode => Object.hash(runtimeType,brandId);

@override
String toString() {
  return 'BrandStorefrontEvent.loadReviews(brandId: $brandId)';
}


}

/// @nodoc
abstract mixin class _$LoadReviewsCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$LoadReviewsCopyWith(_LoadReviews value, $Res Function(_LoadReviews) _then) = __$LoadReviewsCopyWithImpl;
@useResult
$Res call({
 String brandId
});




}
/// @nodoc
class __$LoadReviewsCopyWithImpl<$Res>
    implements _$LoadReviewsCopyWith<$Res> {
  __$LoadReviewsCopyWithImpl(this._self, this._then);

  final _LoadReviews _self;
  final $Res Function(_LoadReviews) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brandId = null,}) {
  return _then(_LoadReviews(
null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SubmitReview implements BrandStorefrontEvent {
  const _SubmitReview({required this.brandId, required this.orderId, required this.qualityRating, required this.valueRating, required this.serviceRating, this.comment});
  

 final  String brandId;
 final  String orderId;
 final  int qualityRating;
 final  int valueRating;
 final  int serviceRating;
 final  String? comment;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitReviewCopyWith<_SubmitReview> get copyWith => __$SubmitReviewCopyWithImpl<_SubmitReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitReview&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.qualityRating, qualityRating) || other.qualityRating == qualityRating)&&(identical(other.valueRating, valueRating) || other.valueRating == valueRating)&&(identical(other.serviceRating, serviceRating) || other.serviceRating == serviceRating)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,brandId,orderId,qualityRating,valueRating,serviceRating,comment);

@override
String toString() {
  return 'BrandStorefrontEvent.submitReview(brandId: $brandId, orderId: $orderId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$SubmitReviewCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$SubmitReviewCopyWith(_SubmitReview value, $Res Function(_SubmitReview) _then) = __$SubmitReviewCopyWithImpl;
@useResult
$Res call({
 String brandId, String orderId, int qualityRating, int valueRating, int serviceRating, String? comment
});




}
/// @nodoc
class __$SubmitReviewCopyWithImpl<$Res>
    implements _$SubmitReviewCopyWith<$Res> {
  __$SubmitReviewCopyWithImpl(this._self, this._then);

  final _SubmitReview _self;
  final $Res Function(_SubmitReview) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brandId = null,Object? orderId = null,Object? qualityRating = null,Object? valueRating = null,Object? serviceRating = null,Object? comment = freezed,}) {
  return _then(_SubmitReview(
brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,qualityRating: null == qualityRating ? _self.qualityRating : qualityRating // ignore: cast_nullable_to_non_nullable
as int,valueRating: null == valueRating ? _self.valueRating : valueRating // ignore: cast_nullable_to_non_nullable
as int,serviceRating: null == serviceRating ? _self.serviceRating : serviceRating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ClaimCoupon implements BrandStorefrontEvent {
  const _ClaimCoupon({required this.storefrontId, required this.couponId, this.couponCode});
  

 final  String storefrontId;
 final  String couponId;
 final  String? couponCode;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimCouponCopyWith<_ClaimCoupon> get copyWith => __$ClaimCouponCopyWithImpl<_ClaimCoupon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimCoupon&&(identical(other.storefrontId, storefrontId) || other.storefrontId == storefrontId)&&(identical(other.couponId, couponId) || other.couponId == couponId)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode));
}


@override
int get hashCode => Object.hash(runtimeType,storefrontId,couponId,couponCode);

@override
String toString() {
  return 'BrandStorefrontEvent.claimCoupon(storefrontId: $storefrontId, couponId: $couponId, couponCode: $couponCode)';
}


}

/// @nodoc
abstract mixin class _$ClaimCouponCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$ClaimCouponCopyWith(_ClaimCoupon value, $Res Function(_ClaimCoupon) _then) = __$ClaimCouponCopyWithImpl;
@useResult
$Res call({
 String storefrontId, String couponId, String? couponCode
});




}
/// @nodoc
class __$ClaimCouponCopyWithImpl<$Res>
    implements _$ClaimCouponCopyWith<$Res> {
  __$ClaimCouponCopyWithImpl(this._self, this._then);

  final _ClaimCoupon _self;
  final $Res Function(_ClaimCoupon) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storefrontId = null,Object? couponId = null,Object? couponCode = freezed,}) {
  return _then(_ClaimCoupon(
storefrontId: null == storefrontId ? _self.storefrontId : storefrontId // ignore: cast_nullable_to_non_nullable
as String,couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as String,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RecordView implements BrandStorefrontEvent {
  const _RecordView(this.storefrontId);
  

 final  String storefrontId;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordViewCopyWith<_RecordView> get copyWith => __$RecordViewCopyWithImpl<_RecordView>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordView&&(identical(other.storefrontId, storefrontId) || other.storefrontId == storefrontId));
}


@override
int get hashCode => Object.hash(runtimeType,storefrontId);

@override
String toString() {
  return 'BrandStorefrontEvent.recordView(storefrontId: $storefrontId)';
}


}

/// @nodoc
abstract mixin class _$RecordViewCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$RecordViewCopyWith(_RecordView value, $Res Function(_RecordView) _then) = __$RecordViewCopyWithImpl;
@useResult
$Res call({
 String storefrontId
});




}
/// @nodoc
class __$RecordViewCopyWithImpl<$Res>
    implements _$RecordViewCopyWith<$Res> {
  __$RecordViewCopyWithImpl(this._self, this._then);

  final _RecordView _self;
  final $Res Function(_RecordView) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storefrontId = null,}) {
  return _then(_RecordView(
null == storefrontId ? _self.storefrontId : storefrontId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleFollow implements BrandStorefrontEvent {
  const _ToggleFollow(this.brandId);
  

 final  String brandId;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleFollowCopyWith<_ToggleFollow> get copyWith => __$ToggleFollowCopyWithImpl<_ToggleFollow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleFollow&&(identical(other.brandId, brandId) || other.brandId == brandId));
}


@override
int get hashCode => Object.hash(runtimeType,brandId);

@override
String toString() {
  return 'BrandStorefrontEvent.toggleFollow(brandId: $brandId)';
}


}

/// @nodoc
abstract mixin class _$ToggleFollowCopyWith<$Res> implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$ToggleFollowCopyWith(_ToggleFollow value, $Res Function(_ToggleFollow) _then) = __$ToggleFollowCopyWithImpl;
@useResult
$Res call({
 String brandId
});




}
/// @nodoc
class __$ToggleFollowCopyWithImpl<$Res>
    implements _$ToggleFollowCopyWith<$Res> {
  __$ToggleFollowCopyWithImpl(this._self, this._then);

  final _ToggleFollow _self;
  final $Res Function(_ToggleFollow) _then;

/// Create a copy of BrandStorefrontEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brandId = null,}) {
  return _then(_ToggleFollow(
null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetReviewState implements BrandStorefrontEvent {
  const _ResetReviewState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetReviewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BrandStorefrontEvent.resetReviewState()';
}


}




/// @nodoc
mixin _$BrandStorefrontState {

 bool get isLoading; BrandStorefront? get storefront; List<BrandProduct> get products; List<BrandReview> get reviews; bool get isLoadingProducts; bool get isLoadingReviews; bool get isSubmittingReview; bool get reviewSubmitSuccess; bool get isClaimingCoupon; Set<String> get claimedCouponIds; String? get lastClaimedCouponCode; bool get isFollowing; DateTime? get followedAt; bool get isTogglingFollow; String? get errorMessage; String? get eligibleReviewOrderId;
/// Create a copy of BrandStorefrontState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandStorefrontStateCopyWith<BrandStorefrontState> get copyWith => _$BrandStorefrontStateCopyWithImpl<BrandStorefrontState>(this as BrandStorefrontState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandStorefrontState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.storefront, storefront) || other.storefront == storefront)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.isLoadingProducts, isLoadingProducts) || other.isLoadingProducts == isLoadingProducts)&&(identical(other.isLoadingReviews, isLoadingReviews) || other.isLoadingReviews == isLoadingReviews)&&(identical(other.isSubmittingReview, isSubmittingReview) || other.isSubmittingReview == isSubmittingReview)&&(identical(other.reviewSubmitSuccess, reviewSubmitSuccess) || other.reviewSubmitSuccess == reviewSubmitSuccess)&&(identical(other.isClaimingCoupon, isClaimingCoupon) || other.isClaimingCoupon == isClaimingCoupon)&&const DeepCollectionEquality().equals(other.claimedCouponIds, claimedCouponIds)&&(identical(other.lastClaimedCouponCode, lastClaimedCouponCode) || other.lastClaimedCouponCode == lastClaimedCouponCode)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.isTogglingFollow, isTogglingFollow) || other.isTogglingFollow == isTogglingFollow)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.eligibleReviewOrderId, eligibleReviewOrderId) || other.eligibleReviewOrderId == eligibleReviewOrderId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,storefront,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(reviews),isLoadingProducts,isLoadingReviews,isSubmittingReview,reviewSubmitSuccess,isClaimingCoupon,const DeepCollectionEquality().hash(claimedCouponIds),lastClaimedCouponCode,isFollowing,followedAt,isTogglingFollow,errorMessage,eligibleReviewOrderId);

@override
String toString() {
  return 'BrandStorefrontState(isLoading: $isLoading, storefront: $storefront, products: $products, reviews: $reviews, isLoadingProducts: $isLoadingProducts, isLoadingReviews: $isLoadingReviews, isSubmittingReview: $isSubmittingReview, reviewSubmitSuccess: $reviewSubmitSuccess, isClaimingCoupon: $isClaimingCoupon, claimedCouponIds: $claimedCouponIds, lastClaimedCouponCode: $lastClaimedCouponCode, isFollowing: $isFollowing, followedAt: $followedAt, isTogglingFollow: $isTogglingFollow, errorMessage: $errorMessage, eligibleReviewOrderId: $eligibleReviewOrderId)';
}


}

/// @nodoc
abstract mixin class $BrandStorefrontStateCopyWith<$Res>  {
  factory $BrandStorefrontStateCopyWith(BrandStorefrontState value, $Res Function(BrandStorefrontState) _then) = _$BrandStorefrontStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, BrandStorefront? storefront, List<BrandProduct> products, List<BrandReview> reviews, bool isLoadingProducts, bool isLoadingReviews, bool isSubmittingReview, bool reviewSubmitSuccess, bool isClaimingCoupon, Set<String> claimedCouponIds, String? lastClaimedCouponCode, bool isFollowing, DateTime? followedAt, bool isTogglingFollow, String? errorMessage, String? eligibleReviewOrderId
});


$BrandStorefrontCopyWith<$Res>? get storefront;

}
/// @nodoc
class _$BrandStorefrontStateCopyWithImpl<$Res>
    implements $BrandStorefrontStateCopyWith<$Res> {
  _$BrandStorefrontStateCopyWithImpl(this._self, this._then);

  final BrandStorefrontState _self;
  final $Res Function(BrandStorefrontState) _then;

/// Create a copy of BrandStorefrontState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? storefront = freezed,Object? products = null,Object? reviews = null,Object? isLoadingProducts = null,Object? isLoadingReviews = null,Object? isSubmittingReview = null,Object? reviewSubmitSuccess = null,Object? isClaimingCoupon = null,Object? claimedCouponIds = null,Object? lastClaimedCouponCode = freezed,Object? isFollowing = null,Object? followedAt = freezed,Object? isTogglingFollow = null,Object? errorMessage = freezed,Object? eligibleReviewOrderId = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,storefront: freezed == storefront ? _self.storefront : storefront // ignore: cast_nullable_to_non_nullable
as BrandStorefront?,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<BrandProduct>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<BrandReview>,isLoadingProducts: null == isLoadingProducts ? _self.isLoadingProducts : isLoadingProducts // ignore: cast_nullable_to_non_nullable
as bool,isLoadingReviews: null == isLoadingReviews ? _self.isLoadingReviews : isLoadingReviews // ignore: cast_nullable_to_non_nullable
as bool,isSubmittingReview: null == isSubmittingReview ? _self.isSubmittingReview : isSubmittingReview // ignore: cast_nullable_to_non_nullable
as bool,reviewSubmitSuccess: null == reviewSubmitSuccess ? _self.reviewSubmitSuccess : reviewSubmitSuccess // ignore: cast_nullable_to_non_nullable
as bool,isClaimingCoupon: null == isClaimingCoupon ? _self.isClaimingCoupon : isClaimingCoupon // ignore: cast_nullable_to_non_nullable
as bool,claimedCouponIds: null == claimedCouponIds ? _self.claimedCouponIds : claimedCouponIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lastClaimedCouponCode: freezed == lastClaimedCouponCode ? _self.lastClaimedCouponCode : lastClaimedCouponCode // ignore: cast_nullable_to_non_nullable
as String?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,followedAt: freezed == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isTogglingFollow: null == isTogglingFollow ? _self.isTogglingFollow : isTogglingFollow // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,eligibleReviewOrderId: freezed == eligibleReviewOrderId ? _self.eligibleReviewOrderId : eligibleReviewOrderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BrandStorefrontState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandStorefrontCopyWith<$Res>? get storefront {
    if (_self.storefront == null) {
    return null;
  }

  return $BrandStorefrontCopyWith<$Res>(_self.storefront!, (value) {
    return _then(_self.copyWith(storefront: value));
  });
}
}


/// Adds pattern-matching-related methods to [BrandStorefrontState].
extension BrandStorefrontStatePatterns on BrandStorefrontState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandStorefrontState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandStorefrontState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandStorefrontState value)  $default,){
final _that = this;
switch (_that) {
case _BrandStorefrontState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandStorefrontState value)?  $default,){
final _that = this;
switch (_that) {
case _BrandStorefrontState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  BrandStorefront? storefront,  List<BrandProduct> products,  List<BrandReview> reviews,  bool isLoadingProducts,  bool isLoadingReviews,  bool isSubmittingReview,  bool reviewSubmitSuccess,  bool isClaimingCoupon,  Set<String> claimedCouponIds,  String? lastClaimedCouponCode,  bool isFollowing,  DateTime? followedAt,  bool isTogglingFollow,  String? errorMessage,  String? eligibleReviewOrderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandStorefrontState() when $default != null:
return $default(_that.isLoading,_that.storefront,_that.products,_that.reviews,_that.isLoadingProducts,_that.isLoadingReviews,_that.isSubmittingReview,_that.reviewSubmitSuccess,_that.isClaimingCoupon,_that.claimedCouponIds,_that.lastClaimedCouponCode,_that.isFollowing,_that.followedAt,_that.isTogglingFollow,_that.errorMessage,_that.eligibleReviewOrderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  BrandStorefront? storefront,  List<BrandProduct> products,  List<BrandReview> reviews,  bool isLoadingProducts,  bool isLoadingReviews,  bool isSubmittingReview,  bool reviewSubmitSuccess,  bool isClaimingCoupon,  Set<String> claimedCouponIds,  String? lastClaimedCouponCode,  bool isFollowing,  DateTime? followedAt,  bool isTogglingFollow,  String? errorMessage,  String? eligibleReviewOrderId)  $default,) {final _that = this;
switch (_that) {
case _BrandStorefrontState():
return $default(_that.isLoading,_that.storefront,_that.products,_that.reviews,_that.isLoadingProducts,_that.isLoadingReviews,_that.isSubmittingReview,_that.reviewSubmitSuccess,_that.isClaimingCoupon,_that.claimedCouponIds,_that.lastClaimedCouponCode,_that.isFollowing,_that.followedAt,_that.isTogglingFollow,_that.errorMessage,_that.eligibleReviewOrderId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  BrandStorefront? storefront,  List<BrandProduct> products,  List<BrandReview> reviews,  bool isLoadingProducts,  bool isLoadingReviews,  bool isSubmittingReview,  bool reviewSubmitSuccess,  bool isClaimingCoupon,  Set<String> claimedCouponIds,  String? lastClaimedCouponCode,  bool isFollowing,  DateTime? followedAt,  bool isTogglingFollow,  String? errorMessage,  String? eligibleReviewOrderId)?  $default,) {final _that = this;
switch (_that) {
case _BrandStorefrontState() when $default != null:
return $default(_that.isLoading,_that.storefront,_that.products,_that.reviews,_that.isLoadingProducts,_that.isLoadingReviews,_that.isSubmittingReview,_that.reviewSubmitSuccess,_that.isClaimingCoupon,_that.claimedCouponIds,_that.lastClaimedCouponCode,_that.isFollowing,_that.followedAt,_that.isTogglingFollow,_that.errorMessage,_that.eligibleReviewOrderId);case _:
  return null;

}
}

}

/// @nodoc


class _BrandStorefrontState implements BrandStorefrontState {
  const _BrandStorefrontState({this.isLoading = false, this.storefront, final  List<BrandProduct> products = const [], final  List<BrandReview> reviews = const [], this.isLoadingProducts = false, this.isLoadingReviews = false, this.isSubmittingReview = false, this.reviewSubmitSuccess = false, this.isClaimingCoupon = false, final  Set<String> claimedCouponIds = const {}, this.lastClaimedCouponCode, this.isFollowing = false, this.followedAt, this.isTogglingFollow = false, this.errorMessage, this.eligibleReviewOrderId}): _products = products,_reviews = reviews,_claimedCouponIds = claimedCouponIds;
  

@override@JsonKey() final  bool isLoading;
@override final  BrandStorefront? storefront;
 final  List<BrandProduct> _products;
@override@JsonKey() List<BrandProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<BrandReview> _reviews;
@override@JsonKey() List<BrandReview> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override@JsonKey() final  bool isLoadingProducts;
@override@JsonKey() final  bool isLoadingReviews;
@override@JsonKey() final  bool isSubmittingReview;
@override@JsonKey() final  bool reviewSubmitSuccess;
@override@JsonKey() final  bool isClaimingCoupon;
 final  Set<String> _claimedCouponIds;
@override@JsonKey() Set<String> get claimedCouponIds {
  if (_claimedCouponIds is EqualUnmodifiableSetView) return _claimedCouponIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_claimedCouponIds);
}

@override final  String? lastClaimedCouponCode;
@override@JsonKey() final  bool isFollowing;
@override final  DateTime? followedAt;
@override@JsonKey() final  bool isTogglingFollow;
@override final  String? errorMessage;
@override final  String? eligibleReviewOrderId;

/// Create a copy of BrandStorefrontState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandStorefrontStateCopyWith<_BrandStorefrontState> get copyWith => __$BrandStorefrontStateCopyWithImpl<_BrandStorefrontState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandStorefrontState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.storefront, storefront) || other.storefront == storefront)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.isLoadingProducts, isLoadingProducts) || other.isLoadingProducts == isLoadingProducts)&&(identical(other.isLoadingReviews, isLoadingReviews) || other.isLoadingReviews == isLoadingReviews)&&(identical(other.isSubmittingReview, isSubmittingReview) || other.isSubmittingReview == isSubmittingReview)&&(identical(other.reviewSubmitSuccess, reviewSubmitSuccess) || other.reviewSubmitSuccess == reviewSubmitSuccess)&&(identical(other.isClaimingCoupon, isClaimingCoupon) || other.isClaimingCoupon == isClaimingCoupon)&&const DeepCollectionEquality().equals(other._claimedCouponIds, _claimedCouponIds)&&(identical(other.lastClaimedCouponCode, lastClaimedCouponCode) || other.lastClaimedCouponCode == lastClaimedCouponCode)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.isTogglingFollow, isTogglingFollow) || other.isTogglingFollow == isTogglingFollow)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.eligibleReviewOrderId, eligibleReviewOrderId) || other.eligibleReviewOrderId == eligibleReviewOrderId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,storefront,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_reviews),isLoadingProducts,isLoadingReviews,isSubmittingReview,reviewSubmitSuccess,isClaimingCoupon,const DeepCollectionEquality().hash(_claimedCouponIds),lastClaimedCouponCode,isFollowing,followedAt,isTogglingFollow,errorMessage,eligibleReviewOrderId);

@override
String toString() {
  return 'BrandStorefrontState(isLoading: $isLoading, storefront: $storefront, products: $products, reviews: $reviews, isLoadingProducts: $isLoadingProducts, isLoadingReviews: $isLoadingReviews, isSubmittingReview: $isSubmittingReview, reviewSubmitSuccess: $reviewSubmitSuccess, isClaimingCoupon: $isClaimingCoupon, claimedCouponIds: $claimedCouponIds, lastClaimedCouponCode: $lastClaimedCouponCode, isFollowing: $isFollowing, followedAt: $followedAt, isTogglingFollow: $isTogglingFollow, errorMessage: $errorMessage, eligibleReviewOrderId: $eligibleReviewOrderId)';
}


}

/// @nodoc
abstract mixin class _$BrandStorefrontStateCopyWith<$Res> implements $BrandStorefrontStateCopyWith<$Res> {
  factory _$BrandStorefrontStateCopyWith(_BrandStorefrontState value, $Res Function(_BrandStorefrontState) _then) = __$BrandStorefrontStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, BrandStorefront? storefront, List<BrandProduct> products, List<BrandReview> reviews, bool isLoadingProducts, bool isLoadingReviews, bool isSubmittingReview, bool reviewSubmitSuccess, bool isClaimingCoupon, Set<String> claimedCouponIds, String? lastClaimedCouponCode, bool isFollowing, DateTime? followedAt, bool isTogglingFollow, String? errorMessage, String? eligibleReviewOrderId
});


@override $BrandStorefrontCopyWith<$Res>? get storefront;

}
/// @nodoc
class __$BrandStorefrontStateCopyWithImpl<$Res>
    implements _$BrandStorefrontStateCopyWith<$Res> {
  __$BrandStorefrontStateCopyWithImpl(this._self, this._then);

  final _BrandStorefrontState _self;
  final $Res Function(_BrandStorefrontState) _then;

/// Create a copy of BrandStorefrontState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? storefront = freezed,Object? products = null,Object? reviews = null,Object? isLoadingProducts = null,Object? isLoadingReviews = null,Object? isSubmittingReview = null,Object? reviewSubmitSuccess = null,Object? isClaimingCoupon = null,Object? claimedCouponIds = null,Object? lastClaimedCouponCode = freezed,Object? isFollowing = null,Object? followedAt = freezed,Object? isTogglingFollow = null,Object? errorMessage = freezed,Object? eligibleReviewOrderId = freezed,}) {
  return _then(_BrandStorefrontState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,storefront: freezed == storefront ? _self.storefront : storefront // ignore: cast_nullable_to_non_nullable
as BrandStorefront?,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<BrandProduct>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<BrandReview>,isLoadingProducts: null == isLoadingProducts ? _self.isLoadingProducts : isLoadingProducts // ignore: cast_nullable_to_non_nullable
as bool,isLoadingReviews: null == isLoadingReviews ? _self.isLoadingReviews : isLoadingReviews // ignore: cast_nullable_to_non_nullable
as bool,isSubmittingReview: null == isSubmittingReview ? _self.isSubmittingReview : isSubmittingReview // ignore: cast_nullable_to_non_nullable
as bool,reviewSubmitSuccess: null == reviewSubmitSuccess ? _self.reviewSubmitSuccess : reviewSubmitSuccess // ignore: cast_nullable_to_non_nullable
as bool,isClaimingCoupon: null == isClaimingCoupon ? _self.isClaimingCoupon : isClaimingCoupon // ignore: cast_nullable_to_non_nullable
as bool,claimedCouponIds: null == claimedCouponIds ? _self._claimedCouponIds : claimedCouponIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lastClaimedCouponCode: freezed == lastClaimedCouponCode ? _self.lastClaimedCouponCode : lastClaimedCouponCode // ignore: cast_nullable_to_non_nullable
as String?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,followedAt: freezed == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isTogglingFollow: null == isTogglingFollow ? _self.isTogglingFollow : isTogglingFollow // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,eligibleReviewOrderId: freezed == eligibleReviewOrderId ? _self.eligibleReviewOrderId : eligibleReviewOrderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BrandStorefrontState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandStorefrontCopyWith<$Res>? get storefront {
    if (_self.storefront == null) {
    return null;
  }

  return $BrandStorefrontCopyWith<$Res>(_self.storefront!, (value) {
    return _then(_self.copyWith(storefront: value));
  });
}
}

// dart format on
