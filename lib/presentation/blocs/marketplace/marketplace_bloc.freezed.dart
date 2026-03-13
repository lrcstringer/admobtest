// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketplaceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent()';
}


}

/// @nodoc
class $MarketplaceEventCopyWith<$Res>  {
$MarketplaceEventCopyWith(MarketplaceEvent _, $Res Function(MarketplaceEvent) __);
}


/// Adds pattern-matching-related methods to [MarketplaceEvent].
extension MarketplaceEventPatterns on MarketplaceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadListings value)?  loadListings,TResult Function( _LoadMore value)?  loadMore,TResult Function( _SearchListings value)?  searchListings,TResult Function( _ClearSearch value)?  clearSearch,TResult Function( _SelectListing value)?  selectListing,TResult Function( _LoadProviderProfile value)?  loadProviderProfile,TResult Function( _LoadProviderVouches value)?  loadProviderVouches,TResult Function( _ReportListing value)?  reportListing,TResult Function( _ReportProvider value)?  reportProvider,TResult Function( _CreateListing value)?  createListing,TResult Function( _ClearMessages value)?  clearMessages,TResult Function( _UpdateListing value)?  updateListing,TResult Function( _ToggleListingStatus value)?  toggleListingStatus,TResult Function( _RenewListing value)?  renewListing,TResult Function( _MakeOffer value)?  makeOffer,TResult Function( _RespondToOffer value)?  respondToOffer,TResult Function( _SellerRefund value)?  sellerRefund,TResult Function( _LoadMyListings value)?  loadMyListings,TResult Function( _LoadSavedItems value)?  loadSavedItems,TResult Function( _LoadSellerPortal value)?  loadSellerPortal,TResult Function( _ToggleFavourite value)?  toggleFavourite,TResult Function( _UploadImages value)?  uploadImages,TResult Function( _RegisterProvider value)?  registerProvider,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadListings() when loadListings != null:
return loadListings(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _SearchListings() when searchListings != null:
return searchListings(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _SelectListing() when selectListing != null:
return selectListing(_that);case _LoadProviderProfile() when loadProviderProfile != null:
return loadProviderProfile(_that);case _LoadProviderVouches() when loadProviderVouches != null:
return loadProviderVouches(_that);case _ReportListing() when reportListing != null:
return reportListing(_that);case _ReportProvider() when reportProvider != null:
return reportProvider(_that);case _CreateListing() when createListing != null:
return createListing(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _UpdateListing() when updateListing != null:
return updateListing(_that);case _ToggleListingStatus() when toggleListingStatus != null:
return toggleListingStatus(_that);case _RenewListing() when renewListing != null:
return renewListing(_that);case _MakeOffer() when makeOffer != null:
return makeOffer(_that);case _RespondToOffer() when respondToOffer != null:
return respondToOffer(_that);case _SellerRefund() when sellerRefund != null:
return sellerRefund(_that);case _LoadMyListings() when loadMyListings != null:
return loadMyListings(_that);case _LoadSavedItems() when loadSavedItems != null:
return loadSavedItems(_that);case _LoadSellerPortal() when loadSellerPortal != null:
return loadSellerPortal(_that);case _ToggleFavourite() when toggleFavourite != null:
return toggleFavourite(_that);case _UploadImages() when uploadImages != null:
return uploadImages(_that);case _RegisterProvider() when registerProvider != null:
return registerProvider(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadListings value)  loadListings,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _SearchListings value)  searchListings,required TResult Function( _ClearSearch value)  clearSearch,required TResult Function( _SelectListing value)  selectListing,required TResult Function( _LoadProviderProfile value)  loadProviderProfile,required TResult Function( _LoadProviderVouches value)  loadProviderVouches,required TResult Function( _ReportListing value)  reportListing,required TResult Function( _ReportProvider value)  reportProvider,required TResult Function( _CreateListing value)  createListing,required TResult Function( _ClearMessages value)  clearMessages,required TResult Function( _UpdateListing value)  updateListing,required TResult Function( _ToggleListingStatus value)  toggleListingStatus,required TResult Function( _RenewListing value)  renewListing,required TResult Function( _MakeOffer value)  makeOffer,required TResult Function( _RespondToOffer value)  respondToOffer,required TResult Function( _SellerRefund value)  sellerRefund,required TResult Function( _LoadMyListings value)  loadMyListings,required TResult Function( _LoadSavedItems value)  loadSavedItems,required TResult Function( _LoadSellerPortal value)  loadSellerPortal,required TResult Function( _ToggleFavourite value)  toggleFavourite,required TResult Function( _UploadImages value)  uploadImages,required TResult Function( _RegisterProvider value)  registerProvider,}){
final _that = this;
switch (_that) {
case _LoadListings():
return loadListings(_that);case _LoadMore():
return loadMore(_that);case _SearchListings():
return searchListings(_that);case _ClearSearch():
return clearSearch(_that);case _SelectListing():
return selectListing(_that);case _LoadProviderProfile():
return loadProviderProfile(_that);case _LoadProviderVouches():
return loadProviderVouches(_that);case _ReportListing():
return reportListing(_that);case _ReportProvider():
return reportProvider(_that);case _CreateListing():
return createListing(_that);case _ClearMessages():
return clearMessages(_that);case _UpdateListing():
return updateListing(_that);case _ToggleListingStatus():
return toggleListingStatus(_that);case _RenewListing():
return renewListing(_that);case _MakeOffer():
return makeOffer(_that);case _RespondToOffer():
return respondToOffer(_that);case _SellerRefund():
return sellerRefund(_that);case _LoadMyListings():
return loadMyListings(_that);case _LoadSavedItems():
return loadSavedItems(_that);case _LoadSellerPortal():
return loadSellerPortal(_that);case _ToggleFavourite():
return toggleFavourite(_that);case _UploadImages():
return uploadImages(_that);case _RegisterProvider():
return registerProvider(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadListings value)?  loadListings,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _SearchListings value)?  searchListings,TResult? Function( _ClearSearch value)?  clearSearch,TResult? Function( _SelectListing value)?  selectListing,TResult? Function( _LoadProviderProfile value)?  loadProviderProfile,TResult? Function( _LoadProviderVouches value)?  loadProviderVouches,TResult? Function( _ReportListing value)?  reportListing,TResult? Function( _ReportProvider value)?  reportProvider,TResult? Function( _CreateListing value)?  createListing,TResult? Function( _ClearMessages value)?  clearMessages,TResult? Function( _UpdateListing value)?  updateListing,TResult? Function( _ToggleListingStatus value)?  toggleListingStatus,TResult? Function( _RenewListing value)?  renewListing,TResult? Function( _MakeOffer value)?  makeOffer,TResult? Function( _RespondToOffer value)?  respondToOffer,TResult? Function( _SellerRefund value)?  sellerRefund,TResult? Function( _LoadMyListings value)?  loadMyListings,TResult? Function( _LoadSavedItems value)?  loadSavedItems,TResult? Function( _LoadSellerPortal value)?  loadSellerPortal,TResult? Function( _ToggleFavourite value)?  toggleFavourite,TResult? Function( _UploadImages value)?  uploadImages,TResult? Function( _RegisterProvider value)?  registerProvider,}){
final _that = this;
switch (_that) {
case _LoadListings() when loadListings != null:
return loadListings(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _SearchListings() when searchListings != null:
return searchListings(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _SelectListing() when selectListing != null:
return selectListing(_that);case _LoadProviderProfile() when loadProviderProfile != null:
return loadProviderProfile(_that);case _LoadProviderVouches() when loadProviderVouches != null:
return loadProviderVouches(_that);case _ReportListing() when reportListing != null:
return reportListing(_that);case _ReportProvider() when reportProvider != null:
return reportProvider(_that);case _CreateListing() when createListing != null:
return createListing(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _UpdateListing() when updateListing != null:
return updateListing(_that);case _ToggleListingStatus() when toggleListingStatus != null:
return toggleListingStatus(_that);case _RenewListing() when renewListing != null:
return renewListing(_that);case _MakeOffer() when makeOffer != null:
return makeOffer(_that);case _RespondToOffer() when respondToOffer != null:
return respondToOffer(_that);case _SellerRefund() when sellerRefund != null:
return sellerRefund(_that);case _LoadMyListings() when loadMyListings != null:
return loadMyListings(_that);case _LoadSavedItems() when loadSavedItems != null:
return loadSavedItems(_that);case _LoadSellerPortal() when loadSellerPortal != null:
return loadSellerPortal(_that);case _ToggleFavourite() when toggleFavourite != null:
return toggleFavourite(_that);case _UploadImages() when uploadImages != null:
return uploadImages(_that);case _RegisterProvider() when registerProvider != null:
return registerProvider(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? category,  String? communityId)?  loadListings,TResult Function()?  loadMore,TResult Function( String query)?  searchListings,TResult Function()?  clearSearch,TResult Function( String id)?  selectListing,TResult Function( String providerId)?  loadProviderProfile,TResult Function( String providerId)?  loadProviderVouches,TResult Function( String listingId,  String reason,  String? description)?  reportListing,TResult Function( String providerId,  String reason,  String? description)?  reportProvider,TResult Function( String title,  String description,  String category,  String? subCategory,  int priceTokens,  List<String> imageUrls,  String? location)?  createListing,TResult Function()?  clearMessages,TResult Function( String listingId,  String? title,  String? description,  String? category,  int? priceTokens,  List<String>? imageUrls,  String? location)?  updateListing,TResult Function( String listingId,  String action)?  toggleListingStatus,TResult Function( String listingId)?  renewListing,TResult Function( String listingId,  int offerAmount,  String? message)?  makeOffer,TResult Function( String offerId,  String action,  int? counterAmount)?  respondToOffer,TResult Function( String orderId,  String? reason)?  sellerRefund,TResult Function()?  loadMyListings,TResult Function()?  loadSavedItems,TResult Function()?  loadSellerPortal,TResult Function( String listingId)?  toggleFavourite,TResult Function( List<Uint8List> imageData,  String listingId)?  uploadImages,TResult Function( String displayName,  String? bio,  String? photoUrl,  String? servicesDescription,  String? communityId,  String? category)?  registerProvider,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadListings() when loadListings != null:
return loadListings(_that.category,_that.communityId);case _LoadMore() when loadMore != null:
return loadMore();case _SearchListings() when searchListings != null:
return searchListings(_that.query);case _ClearSearch() when clearSearch != null:
return clearSearch();case _SelectListing() when selectListing != null:
return selectListing(_that.id);case _LoadProviderProfile() when loadProviderProfile != null:
return loadProviderProfile(_that.providerId);case _LoadProviderVouches() when loadProviderVouches != null:
return loadProviderVouches(_that.providerId);case _ReportListing() when reportListing != null:
return reportListing(_that.listingId,_that.reason,_that.description);case _ReportProvider() when reportProvider != null:
return reportProvider(_that.providerId,_that.reason,_that.description);case _CreateListing() when createListing != null:
return createListing(_that.title,_that.description,_that.category,_that.subCategory,_that.priceTokens,_that.imageUrls,_that.location);case _ClearMessages() when clearMessages != null:
return clearMessages();case _UpdateListing() when updateListing != null:
return updateListing(_that.listingId,_that.title,_that.description,_that.category,_that.priceTokens,_that.imageUrls,_that.location);case _ToggleListingStatus() when toggleListingStatus != null:
return toggleListingStatus(_that.listingId,_that.action);case _RenewListing() when renewListing != null:
return renewListing(_that.listingId);case _MakeOffer() when makeOffer != null:
return makeOffer(_that.listingId,_that.offerAmount,_that.message);case _RespondToOffer() when respondToOffer != null:
return respondToOffer(_that.offerId,_that.action,_that.counterAmount);case _SellerRefund() when sellerRefund != null:
return sellerRefund(_that.orderId,_that.reason);case _LoadMyListings() when loadMyListings != null:
return loadMyListings();case _LoadSavedItems() when loadSavedItems != null:
return loadSavedItems();case _LoadSellerPortal() when loadSellerPortal != null:
return loadSellerPortal();case _ToggleFavourite() when toggleFavourite != null:
return toggleFavourite(_that.listingId);case _UploadImages() when uploadImages != null:
return uploadImages(_that.imageData,_that.listingId);case _RegisterProvider() when registerProvider != null:
return registerProvider(_that.displayName,_that.bio,_that.photoUrl,_that.servicesDescription,_that.communityId,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? category,  String? communityId)  loadListings,required TResult Function()  loadMore,required TResult Function( String query)  searchListings,required TResult Function()  clearSearch,required TResult Function( String id)  selectListing,required TResult Function( String providerId)  loadProviderProfile,required TResult Function( String providerId)  loadProviderVouches,required TResult Function( String listingId,  String reason,  String? description)  reportListing,required TResult Function( String providerId,  String reason,  String? description)  reportProvider,required TResult Function( String title,  String description,  String category,  String? subCategory,  int priceTokens,  List<String> imageUrls,  String? location)  createListing,required TResult Function()  clearMessages,required TResult Function( String listingId,  String? title,  String? description,  String? category,  int? priceTokens,  List<String>? imageUrls,  String? location)  updateListing,required TResult Function( String listingId,  String action)  toggleListingStatus,required TResult Function( String listingId)  renewListing,required TResult Function( String listingId,  int offerAmount,  String? message)  makeOffer,required TResult Function( String offerId,  String action,  int? counterAmount)  respondToOffer,required TResult Function( String orderId,  String? reason)  sellerRefund,required TResult Function()  loadMyListings,required TResult Function()  loadSavedItems,required TResult Function()  loadSellerPortal,required TResult Function( String listingId)  toggleFavourite,required TResult Function( List<Uint8List> imageData,  String listingId)  uploadImages,required TResult Function( String displayName,  String? bio,  String? photoUrl,  String? servicesDescription,  String? communityId,  String? category)  registerProvider,}) {final _that = this;
switch (_that) {
case _LoadListings():
return loadListings(_that.category,_that.communityId);case _LoadMore():
return loadMore();case _SearchListings():
return searchListings(_that.query);case _ClearSearch():
return clearSearch();case _SelectListing():
return selectListing(_that.id);case _LoadProviderProfile():
return loadProviderProfile(_that.providerId);case _LoadProviderVouches():
return loadProviderVouches(_that.providerId);case _ReportListing():
return reportListing(_that.listingId,_that.reason,_that.description);case _ReportProvider():
return reportProvider(_that.providerId,_that.reason,_that.description);case _CreateListing():
return createListing(_that.title,_that.description,_that.category,_that.subCategory,_that.priceTokens,_that.imageUrls,_that.location);case _ClearMessages():
return clearMessages();case _UpdateListing():
return updateListing(_that.listingId,_that.title,_that.description,_that.category,_that.priceTokens,_that.imageUrls,_that.location);case _ToggleListingStatus():
return toggleListingStatus(_that.listingId,_that.action);case _RenewListing():
return renewListing(_that.listingId);case _MakeOffer():
return makeOffer(_that.listingId,_that.offerAmount,_that.message);case _RespondToOffer():
return respondToOffer(_that.offerId,_that.action,_that.counterAmount);case _SellerRefund():
return sellerRefund(_that.orderId,_that.reason);case _LoadMyListings():
return loadMyListings();case _LoadSavedItems():
return loadSavedItems();case _LoadSellerPortal():
return loadSellerPortal();case _ToggleFavourite():
return toggleFavourite(_that.listingId);case _UploadImages():
return uploadImages(_that.imageData,_that.listingId);case _RegisterProvider():
return registerProvider(_that.displayName,_that.bio,_that.photoUrl,_that.servicesDescription,_that.communityId,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? category,  String? communityId)?  loadListings,TResult? Function()?  loadMore,TResult? Function( String query)?  searchListings,TResult? Function()?  clearSearch,TResult? Function( String id)?  selectListing,TResult? Function( String providerId)?  loadProviderProfile,TResult? Function( String providerId)?  loadProviderVouches,TResult? Function( String listingId,  String reason,  String? description)?  reportListing,TResult? Function( String providerId,  String reason,  String? description)?  reportProvider,TResult? Function( String title,  String description,  String category,  String? subCategory,  int priceTokens,  List<String> imageUrls,  String? location)?  createListing,TResult? Function()?  clearMessages,TResult? Function( String listingId,  String? title,  String? description,  String? category,  int? priceTokens,  List<String>? imageUrls,  String? location)?  updateListing,TResult? Function( String listingId,  String action)?  toggleListingStatus,TResult? Function( String listingId)?  renewListing,TResult? Function( String listingId,  int offerAmount,  String? message)?  makeOffer,TResult? Function( String offerId,  String action,  int? counterAmount)?  respondToOffer,TResult? Function( String orderId,  String? reason)?  sellerRefund,TResult? Function()?  loadMyListings,TResult? Function()?  loadSavedItems,TResult? Function()?  loadSellerPortal,TResult? Function( String listingId)?  toggleFavourite,TResult? Function( List<Uint8List> imageData,  String listingId)?  uploadImages,TResult? Function( String displayName,  String? bio,  String? photoUrl,  String? servicesDescription,  String? communityId,  String? category)?  registerProvider,}) {final _that = this;
switch (_that) {
case _LoadListings() when loadListings != null:
return loadListings(_that.category,_that.communityId);case _LoadMore() when loadMore != null:
return loadMore();case _SearchListings() when searchListings != null:
return searchListings(_that.query);case _ClearSearch() when clearSearch != null:
return clearSearch();case _SelectListing() when selectListing != null:
return selectListing(_that.id);case _LoadProviderProfile() when loadProviderProfile != null:
return loadProviderProfile(_that.providerId);case _LoadProviderVouches() when loadProviderVouches != null:
return loadProviderVouches(_that.providerId);case _ReportListing() when reportListing != null:
return reportListing(_that.listingId,_that.reason,_that.description);case _ReportProvider() when reportProvider != null:
return reportProvider(_that.providerId,_that.reason,_that.description);case _CreateListing() when createListing != null:
return createListing(_that.title,_that.description,_that.category,_that.subCategory,_that.priceTokens,_that.imageUrls,_that.location);case _ClearMessages() when clearMessages != null:
return clearMessages();case _UpdateListing() when updateListing != null:
return updateListing(_that.listingId,_that.title,_that.description,_that.category,_that.priceTokens,_that.imageUrls,_that.location);case _ToggleListingStatus() when toggleListingStatus != null:
return toggleListingStatus(_that.listingId,_that.action);case _RenewListing() when renewListing != null:
return renewListing(_that.listingId);case _MakeOffer() when makeOffer != null:
return makeOffer(_that.listingId,_that.offerAmount,_that.message);case _RespondToOffer() when respondToOffer != null:
return respondToOffer(_that.offerId,_that.action,_that.counterAmount);case _SellerRefund() when sellerRefund != null:
return sellerRefund(_that.orderId,_that.reason);case _LoadMyListings() when loadMyListings != null:
return loadMyListings();case _LoadSavedItems() when loadSavedItems != null:
return loadSavedItems();case _LoadSellerPortal() when loadSellerPortal != null:
return loadSellerPortal();case _ToggleFavourite() when toggleFavourite != null:
return toggleFavourite(_that.listingId);case _UploadImages() when uploadImages != null:
return uploadImages(_that.imageData,_that.listingId);case _RegisterProvider() when registerProvider != null:
return registerProvider(_that.displayName,_that.bio,_that.photoUrl,_that.servicesDescription,_that.communityId,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _LoadListings implements MarketplaceEvent {
  const _LoadListings({this.category, this.communityId});
  

 final  String? category;
 final  String? communityId;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadListingsCopyWith<_LoadListings> get copyWith => __$LoadListingsCopyWithImpl<_LoadListings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadListings&&(identical(other.category, category) || other.category == category)&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,category,communityId);

@override
String toString() {
  return 'MarketplaceEvent.loadListings(category: $category, communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$LoadListingsCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$LoadListingsCopyWith(_LoadListings value, $Res Function(_LoadListings) _then) = __$LoadListingsCopyWithImpl;
@useResult
$Res call({
 String? category, String? communityId
});




}
/// @nodoc
class __$LoadListingsCopyWithImpl<$Res>
    implements _$LoadListingsCopyWith<$Res> {
  __$LoadListingsCopyWithImpl(this._self, this._then);

  final _LoadListings _self;
  final $Res Function(_LoadListings) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? communityId = freezed,}) {
  return _then(_LoadListings(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadMore implements MarketplaceEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent.loadMore()';
}


}




/// @nodoc


class _SearchListings implements MarketplaceEvent {
  const _SearchListings(this.query);
  

 final  String query;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchListingsCopyWith<_SearchListings> get copyWith => __$SearchListingsCopyWithImpl<_SearchListings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchListings&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'MarketplaceEvent.searchListings(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchListingsCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$SearchListingsCopyWith(_SearchListings value, $Res Function(_SearchListings) _then) = __$SearchListingsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchListingsCopyWithImpl<$Res>
    implements _$SearchListingsCopyWith<$Res> {
  __$SearchListingsCopyWithImpl(this._self, this._then);

  final _SearchListings _self;
  final $Res Function(_SearchListings) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchListings(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearSearch implements MarketplaceEvent {
  const _ClearSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent.clearSearch()';
}


}




/// @nodoc


class _SelectListing implements MarketplaceEvent {
  const _SelectListing(this.id);
  

 final  String id;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectListingCopyWith<_SelectListing> get copyWith => __$SelectListingCopyWithImpl<_SelectListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectListing&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'MarketplaceEvent.selectListing(id: $id)';
}


}

/// @nodoc
abstract mixin class _$SelectListingCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$SelectListingCopyWith(_SelectListing value, $Res Function(_SelectListing) _then) = __$SelectListingCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$SelectListingCopyWithImpl<$Res>
    implements _$SelectListingCopyWith<$Res> {
  __$SelectListingCopyWithImpl(this._self, this._then);

  final _SelectListing _self;
  final $Res Function(_SelectListing) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_SelectListing(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadProviderProfile implements MarketplaceEvent {
  const _LoadProviderProfile(this.providerId);
  

 final  String providerId;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProviderProfileCopyWith<_LoadProviderProfile> get copyWith => __$LoadProviderProfileCopyWithImpl<_LoadProviderProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProviderProfile&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,providerId);

@override
String toString() {
  return 'MarketplaceEvent.loadProviderProfile(providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class _$LoadProviderProfileCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$LoadProviderProfileCopyWith(_LoadProviderProfile value, $Res Function(_LoadProviderProfile) _then) = __$LoadProviderProfileCopyWithImpl;
@useResult
$Res call({
 String providerId
});




}
/// @nodoc
class __$LoadProviderProfileCopyWithImpl<$Res>
    implements _$LoadProviderProfileCopyWith<$Res> {
  __$LoadProviderProfileCopyWithImpl(this._self, this._then);

  final _LoadProviderProfile _self;
  final $Res Function(_LoadProviderProfile) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? providerId = null,}) {
  return _then(_LoadProviderProfile(
null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadProviderVouches implements MarketplaceEvent {
  const _LoadProviderVouches(this.providerId);
  

 final  String providerId;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProviderVouchesCopyWith<_LoadProviderVouches> get copyWith => __$LoadProviderVouchesCopyWithImpl<_LoadProviderVouches>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProviderVouches&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,providerId);

@override
String toString() {
  return 'MarketplaceEvent.loadProviderVouches(providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class _$LoadProviderVouchesCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$LoadProviderVouchesCopyWith(_LoadProviderVouches value, $Res Function(_LoadProviderVouches) _then) = __$LoadProviderVouchesCopyWithImpl;
@useResult
$Res call({
 String providerId
});




}
/// @nodoc
class __$LoadProviderVouchesCopyWithImpl<$Res>
    implements _$LoadProviderVouchesCopyWith<$Res> {
  __$LoadProviderVouchesCopyWithImpl(this._self, this._then);

  final _LoadProviderVouches _self;
  final $Res Function(_LoadProviderVouches) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? providerId = null,}) {
  return _then(_LoadProviderVouches(
null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ReportListing implements MarketplaceEvent {
  const _ReportListing({required this.listingId, required this.reason, this.description});
  

 final  String listingId;
 final  String reason;
 final  String? description;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportListingCopyWith<_ReportListing> get copyWith => __$ReportListingCopyWithImpl<_ReportListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportListing&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,reason,description);

@override
String toString() {
  return 'MarketplaceEvent.reportListing(listingId: $listingId, reason: $reason, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ReportListingCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$ReportListingCopyWith(_ReportListing value, $Res Function(_ReportListing) _then) = __$ReportListingCopyWithImpl;
@useResult
$Res call({
 String listingId, String reason, String? description
});




}
/// @nodoc
class __$ReportListingCopyWithImpl<$Res>
    implements _$ReportListingCopyWith<$Res> {
  __$ReportListingCopyWithImpl(this._self, this._then);

  final _ReportListing _self;
  final $Res Function(_ReportListing) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? reason = null,Object? description = freezed,}) {
  return _then(_ReportListing(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ReportProvider implements MarketplaceEvent {
  const _ReportProvider({required this.providerId, required this.reason, this.description});
  

 final  String providerId;
 final  String reason;
 final  String? description;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportProviderCopyWith<_ReportProvider> get copyWith => __$ReportProviderCopyWithImpl<_ReportProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportProvider&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,providerId,reason,description);

@override
String toString() {
  return 'MarketplaceEvent.reportProvider(providerId: $providerId, reason: $reason, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ReportProviderCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$ReportProviderCopyWith(_ReportProvider value, $Res Function(_ReportProvider) _then) = __$ReportProviderCopyWithImpl;
@useResult
$Res call({
 String providerId, String reason, String? description
});




}
/// @nodoc
class __$ReportProviderCopyWithImpl<$Res>
    implements _$ReportProviderCopyWith<$Res> {
  __$ReportProviderCopyWithImpl(this._self, this._then);

  final _ReportProvider _self;
  final $Res Function(_ReportProvider) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? reason = null,Object? description = freezed,}) {
  return _then(_ReportProvider(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CreateListing implements MarketplaceEvent {
  const _CreateListing({required this.title, required this.description, required this.category, this.subCategory, required this.priceTokens, required final  List<String> imageUrls, this.location}): _imageUrls = imageUrls;
  

 final  String title;
 final  String description;
 final  String category;
 final  String? subCategory;
 final  int priceTokens;
 final  List<String> _imageUrls;
 List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

 final  String? location;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateListingCopyWith<_CreateListing> get copyWith => __$CreateListingCopyWithImpl<_CreateListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateListing&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,category,subCategory,priceTokens,const DeepCollectionEquality().hash(_imageUrls),location);

@override
String toString() {
  return 'MarketplaceEvent.createListing(title: $title, description: $description, category: $category, subCategory: $subCategory, priceTokens: $priceTokens, imageUrls: $imageUrls, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CreateListingCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$CreateListingCopyWith(_CreateListing value, $Res Function(_CreateListing) _then) = __$CreateListingCopyWithImpl;
@useResult
$Res call({
 String title, String description, String category, String? subCategory, int priceTokens, List<String> imageUrls, String? location
});




}
/// @nodoc
class __$CreateListingCopyWithImpl<$Res>
    implements _$CreateListingCopyWith<$Res> {
  __$CreateListingCopyWithImpl(this._self, this._then);

  final _CreateListing _self;
  final $Res Function(_CreateListing) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? category = null,Object? subCategory = freezed,Object? priceTokens = null,Object? imageUrls = null,Object? location = freezed,}) {
  return _then(_CreateListing(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ClearMessages implements MarketplaceEvent {
  const _ClearMessages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearMessages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent.clearMessages()';
}


}




/// @nodoc


class _UpdateListing implements MarketplaceEvent {
  const _UpdateListing({required this.listingId, this.title, this.description, this.category, this.priceTokens, final  List<String>? imageUrls, this.location}): _imageUrls = imageUrls;
  

 final  String listingId;
 final  String? title;
 final  String? description;
 final  String? category;
 final  int? priceTokens;
 final  List<String>? _imageUrls;
 List<String>? get imageUrls {
  final value = _imageUrls;
  if (value == null) return null;
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  String? location;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateListingCopyWith<_UpdateListing> get copyWith => __$UpdateListingCopyWithImpl<_UpdateListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateListing&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,title,description,category,priceTokens,const DeepCollectionEquality().hash(_imageUrls),location);

@override
String toString() {
  return 'MarketplaceEvent.updateListing(listingId: $listingId, title: $title, description: $description, category: $category, priceTokens: $priceTokens, imageUrls: $imageUrls, location: $location)';
}


}

/// @nodoc
abstract mixin class _$UpdateListingCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$UpdateListingCopyWith(_UpdateListing value, $Res Function(_UpdateListing) _then) = __$UpdateListingCopyWithImpl;
@useResult
$Res call({
 String listingId, String? title, String? description, String? category, int? priceTokens, List<String>? imageUrls, String? location
});




}
/// @nodoc
class __$UpdateListingCopyWithImpl<$Res>
    implements _$UpdateListingCopyWith<$Res> {
  __$UpdateListingCopyWithImpl(this._self, this._then);

  final _UpdateListing _self;
  final $Res Function(_UpdateListing) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? title = freezed,Object? description = freezed,Object? category = freezed,Object? priceTokens = freezed,Object? imageUrls = freezed,Object? location = freezed,}) {
  return _then(_UpdateListing(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,priceTokens: freezed == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int?,imageUrls: freezed == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ToggleListingStatus implements MarketplaceEvent {
  const _ToggleListingStatus({required this.listingId, required this.action});
  

 final  String listingId;
 final  String action;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleListingStatusCopyWith<_ToggleListingStatus> get copyWith => __$ToggleListingStatusCopyWithImpl<_ToggleListingStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleListingStatus&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,action);

@override
String toString() {
  return 'MarketplaceEvent.toggleListingStatus(listingId: $listingId, action: $action)';
}


}

/// @nodoc
abstract mixin class _$ToggleListingStatusCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$ToggleListingStatusCopyWith(_ToggleListingStatus value, $Res Function(_ToggleListingStatus) _then) = __$ToggleListingStatusCopyWithImpl;
@useResult
$Res call({
 String listingId, String action
});




}
/// @nodoc
class __$ToggleListingStatusCopyWithImpl<$Res>
    implements _$ToggleListingStatusCopyWith<$Res> {
  __$ToggleListingStatusCopyWithImpl(this._self, this._then);

  final _ToggleListingStatus _self;
  final $Res Function(_ToggleListingStatus) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? action = null,}) {
  return _then(_ToggleListingStatus(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RenewListing implements MarketplaceEvent {
  const _RenewListing(this.listingId);
  

 final  String listingId;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RenewListingCopyWith<_RenewListing> get copyWith => __$RenewListingCopyWithImpl<_RenewListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RenewListing&&(identical(other.listingId, listingId) || other.listingId == listingId));
}


@override
int get hashCode => Object.hash(runtimeType,listingId);

@override
String toString() {
  return 'MarketplaceEvent.renewListing(listingId: $listingId)';
}


}

/// @nodoc
abstract mixin class _$RenewListingCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$RenewListingCopyWith(_RenewListing value, $Res Function(_RenewListing) _then) = __$RenewListingCopyWithImpl;
@useResult
$Res call({
 String listingId
});




}
/// @nodoc
class __$RenewListingCopyWithImpl<$Res>
    implements _$RenewListingCopyWith<$Res> {
  __$RenewListingCopyWithImpl(this._self, this._then);

  final _RenewListing _self;
  final $Res Function(_RenewListing) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,}) {
  return _then(_RenewListing(
null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MakeOffer implements MarketplaceEvent {
  const _MakeOffer({required this.listingId, required this.offerAmount, this.message});
  

 final  String listingId;
 final  int offerAmount;
 final  String? message;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MakeOfferCopyWith<_MakeOffer> get copyWith => __$MakeOfferCopyWithImpl<_MakeOffer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MakeOffer&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.offerAmount, offerAmount) || other.offerAmount == offerAmount)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,offerAmount,message);

@override
String toString() {
  return 'MarketplaceEvent.makeOffer(listingId: $listingId, offerAmount: $offerAmount, message: $message)';
}


}

/// @nodoc
abstract mixin class _$MakeOfferCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$MakeOfferCopyWith(_MakeOffer value, $Res Function(_MakeOffer) _then) = __$MakeOfferCopyWithImpl;
@useResult
$Res call({
 String listingId, int offerAmount, String? message
});




}
/// @nodoc
class __$MakeOfferCopyWithImpl<$Res>
    implements _$MakeOfferCopyWith<$Res> {
  __$MakeOfferCopyWithImpl(this._self, this._then);

  final _MakeOffer _self;
  final $Res Function(_MakeOffer) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? offerAmount = null,Object? message = freezed,}) {
  return _then(_MakeOffer(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,offerAmount: null == offerAmount ? _self.offerAmount : offerAmount // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RespondToOffer implements MarketplaceEvent {
  const _RespondToOffer({required this.offerId, required this.action, this.counterAmount});
  

 final  String offerId;
 final  String action;
 final  int? counterAmount;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RespondToOfferCopyWith<_RespondToOffer> get copyWith => __$RespondToOfferCopyWithImpl<_RespondToOffer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RespondToOffer&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.action, action) || other.action == action)&&(identical(other.counterAmount, counterAmount) || other.counterAmount == counterAmount));
}


@override
int get hashCode => Object.hash(runtimeType,offerId,action,counterAmount);

@override
String toString() {
  return 'MarketplaceEvent.respondToOffer(offerId: $offerId, action: $action, counterAmount: $counterAmount)';
}


}

/// @nodoc
abstract mixin class _$RespondToOfferCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$RespondToOfferCopyWith(_RespondToOffer value, $Res Function(_RespondToOffer) _then) = __$RespondToOfferCopyWithImpl;
@useResult
$Res call({
 String offerId, String action, int? counterAmount
});




}
/// @nodoc
class __$RespondToOfferCopyWithImpl<$Res>
    implements _$RespondToOfferCopyWith<$Res> {
  __$RespondToOfferCopyWithImpl(this._self, this._then);

  final _RespondToOffer _self;
  final $Res Function(_RespondToOffer) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? offerId = null,Object? action = null,Object? counterAmount = freezed,}) {
  return _then(_RespondToOffer(
offerId: null == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,counterAmount: freezed == counterAmount ? _self.counterAmount : counterAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _SellerRefund implements MarketplaceEvent {
  const _SellerRefund({required this.orderId, this.reason});
  

 final  String orderId;
 final  String? reason;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerRefundCopyWith<_SellerRefund> get copyWith => __$SellerRefundCopyWithImpl<_SellerRefund>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerRefund&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,reason);

@override
String toString() {
  return 'MarketplaceEvent.sellerRefund(orderId: $orderId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$SellerRefundCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$SellerRefundCopyWith(_SellerRefund value, $Res Function(_SellerRefund) _then) = __$SellerRefundCopyWithImpl;
@useResult
$Res call({
 String orderId, String? reason
});




}
/// @nodoc
class __$SellerRefundCopyWithImpl<$Res>
    implements _$SellerRefundCopyWith<$Res> {
  __$SellerRefundCopyWithImpl(this._self, this._then);

  final _SellerRefund _self;
  final $Res Function(_SellerRefund) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? reason = freezed,}) {
  return _then(_SellerRefund(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadMyListings implements MarketplaceEvent {
  const _LoadMyListings();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMyListings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent.loadMyListings()';
}


}




/// @nodoc


class _LoadSavedItems implements MarketplaceEvent {
  const _LoadSavedItems();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSavedItems);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent.loadSavedItems()';
}


}




/// @nodoc


class _LoadSellerPortal implements MarketplaceEvent {
  const _LoadSellerPortal();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSellerPortal);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MarketplaceEvent.loadSellerPortal()';
}


}




/// @nodoc


class _ToggleFavourite implements MarketplaceEvent {
  const _ToggleFavourite(this.listingId);
  

 final  String listingId;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleFavouriteCopyWith<_ToggleFavourite> get copyWith => __$ToggleFavouriteCopyWithImpl<_ToggleFavourite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleFavourite&&(identical(other.listingId, listingId) || other.listingId == listingId));
}


@override
int get hashCode => Object.hash(runtimeType,listingId);

@override
String toString() {
  return 'MarketplaceEvent.toggleFavourite(listingId: $listingId)';
}


}

/// @nodoc
abstract mixin class _$ToggleFavouriteCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$ToggleFavouriteCopyWith(_ToggleFavourite value, $Res Function(_ToggleFavourite) _then) = __$ToggleFavouriteCopyWithImpl;
@useResult
$Res call({
 String listingId
});




}
/// @nodoc
class __$ToggleFavouriteCopyWithImpl<$Res>
    implements _$ToggleFavouriteCopyWith<$Res> {
  __$ToggleFavouriteCopyWithImpl(this._self, this._then);

  final _ToggleFavourite _self;
  final $Res Function(_ToggleFavourite) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,}) {
  return _then(_ToggleFavourite(
null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UploadImages implements MarketplaceEvent {
  const _UploadImages({required final  List<Uint8List> imageData, required this.listingId}): _imageData = imageData;
  

 final  List<Uint8List> _imageData;
 List<Uint8List> get imageData {
  if (_imageData is EqualUnmodifiableListView) return _imageData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageData);
}

 final  String listingId;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadImagesCopyWith<_UploadImages> get copyWith => __$UploadImagesCopyWithImpl<_UploadImages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadImages&&const DeepCollectionEquality().equals(other._imageData, _imageData)&&(identical(other.listingId, listingId) || other.listingId == listingId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_imageData),listingId);

@override
String toString() {
  return 'MarketplaceEvent.uploadImages(imageData: $imageData, listingId: $listingId)';
}


}

/// @nodoc
abstract mixin class _$UploadImagesCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$UploadImagesCopyWith(_UploadImages value, $Res Function(_UploadImages) _then) = __$UploadImagesCopyWithImpl;
@useResult
$Res call({
 List<Uint8List> imageData, String listingId
});




}
/// @nodoc
class __$UploadImagesCopyWithImpl<$Res>
    implements _$UploadImagesCopyWith<$Res> {
  __$UploadImagesCopyWithImpl(this._self, this._then);

  final _UploadImages _self;
  final $Res Function(_UploadImages) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageData = null,Object? listingId = null,}) {
  return _then(_UploadImages(
imageData: null == imageData ? _self._imageData : imageData // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RegisterProvider implements MarketplaceEvent {
  const _RegisterProvider({required this.displayName, this.bio, this.photoUrl, this.servicesDescription, this.communityId, this.category});
  

 final  String displayName;
 final  String? bio;
 final  String? photoUrl;
 final  String? servicesDescription;
 final  String? communityId;
 final  String? category;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterProviderCopyWith<_RegisterProvider> get copyWith => __$RegisterProviderCopyWithImpl<_RegisterProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterProvider&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,bio,photoUrl,servicesDescription,communityId,category);

@override
String toString() {
  return 'MarketplaceEvent.registerProvider(displayName: $displayName, bio: $bio, photoUrl: $photoUrl, servicesDescription: $servicesDescription, communityId: $communityId, category: $category)';
}


}

/// @nodoc
abstract mixin class _$RegisterProviderCopyWith<$Res> implements $MarketplaceEventCopyWith<$Res> {
  factory _$RegisterProviderCopyWith(_RegisterProvider value, $Res Function(_RegisterProvider) _then) = __$RegisterProviderCopyWithImpl;
@useResult
$Res call({
 String displayName, String? bio, String? photoUrl, String? servicesDescription, String? communityId, String? category
});




}
/// @nodoc
class __$RegisterProviderCopyWithImpl<$Res>
    implements _$RegisterProviderCopyWith<$Res> {
  __$RegisterProviderCopyWithImpl(this._self, this._then);

  final _RegisterProvider _self;
  final $Res Function(_RegisterProvider) _then;

/// Create a copy of MarketplaceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? bio = freezed,Object? photoUrl = freezed,Object? servicesDescription = freezed,Object? communityId = freezed,Object? category = freezed,}) {
  return _then(_RegisterProvider(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,servicesDescription: freezed == servicesDescription ? _self.servicesDescription : servicesDescription // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$MarketplaceState {

 bool get isLoading; bool get isLoadingMore; bool get isLoadingDetail; bool get isLoadingProvider; List<MarketplaceListing> get listings; List<MarketplaceListing> get filteredListings; bool get hasMore; MarketplaceListing? get selectedListing; MarketplaceProvider? get selectedProvider;/// Vouches for the currently viewed provider profile
 List<Vouch> get providerVouches; bool get isSearching; String get searchQuery;/// Current category filter — used for pagination in loadMore
 String? get activeCategory;/// Current community filter — used for pagination in loadMore
 String? get activeCommunityId; bool get isCreating; bool get isReporting; bool get isUpdating; bool get isTogglingStatus; bool get isMakingOffer; bool get isRespondingToOffer; bool get isRefunding; bool get isRenewing; bool get isLoadingMyListings; bool get isLoadingSaved; bool get isLoadingSellerPortal; List<MarketplaceListing> get myListings; List<SavedListing> get savedItems; MarketplaceProvider? get currentSellerProfile; SellerDashboard? get sellerDashboard; String? get createSuccessId; String? get errorMessage; String? get reportSuccessMessage; String? get successMessage; bool get isUploadingImages; List<String> get uploadedImageUrls; bool get isRegistering;
/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceStateCopyWith<MarketplaceState> get copyWith => _$MarketplaceStateCopyWithImpl<MarketplaceState>(this as MarketplaceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isLoadingProvider, isLoadingProvider) || other.isLoadingProvider == isLoadingProvider)&&const DeepCollectionEquality().equals(other.listings, listings)&&const DeepCollectionEquality().equals(other.filteredListings, filteredListings)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.selectedListing, selectedListing) || other.selectedListing == selectedListing)&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&const DeepCollectionEquality().equals(other.providerVouches, providerVouches)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.activeCategory, activeCategory) || other.activeCategory == activeCategory)&&(identical(other.activeCommunityId, activeCommunityId) || other.activeCommunityId == activeCommunityId)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isReporting, isReporting) || other.isReporting == isReporting)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.isTogglingStatus, isTogglingStatus) || other.isTogglingStatus == isTogglingStatus)&&(identical(other.isMakingOffer, isMakingOffer) || other.isMakingOffer == isMakingOffer)&&(identical(other.isRespondingToOffer, isRespondingToOffer) || other.isRespondingToOffer == isRespondingToOffer)&&(identical(other.isRefunding, isRefunding) || other.isRefunding == isRefunding)&&(identical(other.isRenewing, isRenewing) || other.isRenewing == isRenewing)&&(identical(other.isLoadingMyListings, isLoadingMyListings) || other.isLoadingMyListings == isLoadingMyListings)&&(identical(other.isLoadingSaved, isLoadingSaved) || other.isLoadingSaved == isLoadingSaved)&&(identical(other.isLoadingSellerPortal, isLoadingSellerPortal) || other.isLoadingSellerPortal == isLoadingSellerPortal)&&const DeepCollectionEquality().equals(other.myListings, myListings)&&const DeepCollectionEquality().equals(other.savedItems, savedItems)&&(identical(other.currentSellerProfile, currentSellerProfile) || other.currentSellerProfile == currentSellerProfile)&&(identical(other.sellerDashboard, sellerDashboard) || other.sellerDashboard == sellerDashboard)&&(identical(other.createSuccessId, createSuccessId) || other.createSuccessId == createSuccessId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.reportSuccessMessage, reportSuccessMessage) || other.reportSuccessMessage == reportSuccessMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.isUploadingImages, isUploadingImages) || other.isUploadingImages == isUploadingImages)&&const DeepCollectionEquality().equals(other.uploadedImageUrls, uploadedImageUrls)&&(identical(other.isRegistering, isRegistering) || other.isRegistering == isRegistering));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,isLoadingMore,isLoadingDetail,isLoadingProvider,const DeepCollectionEquality().hash(listings),const DeepCollectionEquality().hash(filteredListings),hasMore,selectedListing,selectedProvider,const DeepCollectionEquality().hash(providerVouches),isSearching,searchQuery,activeCategory,activeCommunityId,isCreating,isReporting,isUpdating,isTogglingStatus,isMakingOffer,isRespondingToOffer,isRefunding,isRenewing,isLoadingMyListings,isLoadingSaved,isLoadingSellerPortal,const DeepCollectionEquality().hash(myListings),const DeepCollectionEquality().hash(savedItems),currentSellerProfile,sellerDashboard,createSuccessId,errorMessage,reportSuccessMessage,successMessage,isUploadingImages,const DeepCollectionEquality().hash(uploadedImageUrls),isRegistering]);

@override
String toString() {
  return 'MarketplaceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isLoadingDetail: $isLoadingDetail, isLoadingProvider: $isLoadingProvider, listings: $listings, filteredListings: $filteredListings, hasMore: $hasMore, selectedListing: $selectedListing, selectedProvider: $selectedProvider, providerVouches: $providerVouches, isSearching: $isSearching, searchQuery: $searchQuery, activeCategory: $activeCategory, activeCommunityId: $activeCommunityId, isCreating: $isCreating, isReporting: $isReporting, isUpdating: $isUpdating, isTogglingStatus: $isTogglingStatus, isMakingOffer: $isMakingOffer, isRespondingToOffer: $isRespondingToOffer, isRefunding: $isRefunding, isRenewing: $isRenewing, isLoadingMyListings: $isLoadingMyListings, isLoadingSaved: $isLoadingSaved, isLoadingSellerPortal: $isLoadingSellerPortal, myListings: $myListings, savedItems: $savedItems, currentSellerProfile: $currentSellerProfile, sellerDashboard: $sellerDashboard, createSuccessId: $createSuccessId, errorMessage: $errorMessage, reportSuccessMessage: $reportSuccessMessage, successMessage: $successMessage, isUploadingImages: $isUploadingImages, uploadedImageUrls: $uploadedImageUrls, isRegistering: $isRegistering)';
}


}

/// @nodoc
abstract mixin class $MarketplaceStateCopyWith<$Res>  {
  factory $MarketplaceStateCopyWith(MarketplaceState value, $Res Function(MarketplaceState) _then) = _$MarketplaceStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool isLoadingDetail, bool isLoadingProvider, List<MarketplaceListing> listings, List<MarketplaceListing> filteredListings, bool hasMore, MarketplaceListing? selectedListing, MarketplaceProvider? selectedProvider, List<Vouch> providerVouches, bool isSearching, String searchQuery, String? activeCategory, String? activeCommunityId, bool isCreating, bool isReporting, bool isUpdating, bool isTogglingStatus, bool isMakingOffer, bool isRespondingToOffer, bool isRefunding, bool isRenewing, bool isLoadingMyListings, bool isLoadingSaved, bool isLoadingSellerPortal, List<MarketplaceListing> myListings, List<SavedListing> savedItems, MarketplaceProvider? currentSellerProfile, SellerDashboard? sellerDashboard, String? createSuccessId, String? errorMessage, String? reportSuccessMessage, String? successMessage, bool isUploadingImages, List<String> uploadedImageUrls, bool isRegistering
});


$MarketplaceListingCopyWith<$Res>? get selectedListing;$MarketplaceProviderCopyWith<$Res>? get selectedProvider;$MarketplaceProviderCopyWith<$Res>? get currentSellerProfile;$SellerDashboardCopyWith<$Res>? get sellerDashboard;

}
/// @nodoc
class _$MarketplaceStateCopyWithImpl<$Res>
    implements $MarketplaceStateCopyWith<$Res> {
  _$MarketplaceStateCopyWithImpl(this._self, this._then);

  final MarketplaceState _self;
  final $Res Function(MarketplaceState) _then;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isLoadingDetail = null,Object? isLoadingProvider = null,Object? listings = null,Object? filteredListings = null,Object? hasMore = null,Object? selectedListing = freezed,Object? selectedProvider = freezed,Object? providerVouches = null,Object? isSearching = null,Object? searchQuery = null,Object? activeCategory = freezed,Object? activeCommunityId = freezed,Object? isCreating = null,Object? isReporting = null,Object? isUpdating = null,Object? isTogglingStatus = null,Object? isMakingOffer = null,Object? isRespondingToOffer = null,Object? isRefunding = null,Object? isRenewing = null,Object? isLoadingMyListings = null,Object? isLoadingSaved = null,Object? isLoadingSellerPortal = null,Object? myListings = null,Object? savedItems = null,Object? currentSellerProfile = freezed,Object? sellerDashboard = freezed,Object? createSuccessId = freezed,Object? errorMessage = freezed,Object? reportSuccessMessage = freezed,Object? successMessage = freezed,Object? isUploadingImages = null,Object? uploadedImageUrls = null,Object? isRegistering = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isLoadingProvider: null == isLoadingProvider ? _self.isLoadingProvider : isLoadingProvider // ignore: cast_nullable_to_non_nullable
as bool,listings: null == listings ? _self.listings : listings // ignore: cast_nullable_to_non_nullable
as List<MarketplaceListing>,filteredListings: null == filteredListings ? _self.filteredListings : filteredListings // ignore: cast_nullable_to_non_nullable
as List<MarketplaceListing>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,selectedListing: freezed == selectedListing ? _self.selectedListing : selectedListing // ignore: cast_nullable_to_non_nullable
as MarketplaceListing?,selectedProvider: freezed == selectedProvider ? _self.selectedProvider : selectedProvider // ignore: cast_nullable_to_non_nullable
as MarketplaceProvider?,providerVouches: null == providerVouches ? _self.providerVouches : providerVouches // ignore: cast_nullable_to_non_nullable
as List<Vouch>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,activeCategory: freezed == activeCategory ? _self.activeCategory : activeCategory // ignore: cast_nullable_to_non_nullable
as String?,activeCommunityId: freezed == activeCommunityId ? _self.activeCommunityId : activeCommunityId // ignore: cast_nullable_to_non_nullable
as String?,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isReporting: null == isReporting ? _self.isReporting : isReporting // ignore: cast_nullable_to_non_nullable
as bool,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,isTogglingStatus: null == isTogglingStatus ? _self.isTogglingStatus : isTogglingStatus // ignore: cast_nullable_to_non_nullable
as bool,isMakingOffer: null == isMakingOffer ? _self.isMakingOffer : isMakingOffer // ignore: cast_nullable_to_non_nullable
as bool,isRespondingToOffer: null == isRespondingToOffer ? _self.isRespondingToOffer : isRespondingToOffer // ignore: cast_nullable_to_non_nullable
as bool,isRefunding: null == isRefunding ? _self.isRefunding : isRefunding // ignore: cast_nullable_to_non_nullable
as bool,isRenewing: null == isRenewing ? _self.isRenewing : isRenewing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMyListings: null == isLoadingMyListings ? _self.isLoadingMyListings : isLoadingMyListings // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSaved: null == isLoadingSaved ? _self.isLoadingSaved : isLoadingSaved // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSellerPortal: null == isLoadingSellerPortal ? _self.isLoadingSellerPortal : isLoadingSellerPortal // ignore: cast_nullable_to_non_nullable
as bool,myListings: null == myListings ? _self.myListings : myListings // ignore: cast_nullable_to_non_nullable
as List<MarketplaceListing>,savedItems: null == savedItems ? _self.savedItems : savedItems // ignore: cast_nullable_to_non_nullable
as List<SavedListing>,currentSellerProfile: freezed == currentSellerProfile ? _self.currentSellerProfile : currentSellerProfile // ignore: cast_nullable_to_non_nullable
as MarketplaceProvider?,sellerDashboard: freezed == sellerDashboard ? _self.sellerDashboard : sellerDashboard // ignore: cast_nullable_to_non_nullable
as SellerDashboard?,createSuccessId: freezed == createSuccessId ? _self.createSuccessId : createSuccessId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,reportSuccessMessage: freezed == reportSuccessMessage ? _self.reportSuccessMessage : reportSuccessMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,isUploadingImages: null == isUploadingImages ? _self.isUploadingImages : isUploadingImages // ignore: cast_nullable_to_non_nullable
as bool,uploadedImageUrls: null == uploadedImageUrls ? _self.uploadedImageUrls : uploadedImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isRegistering: null == isRegistering ? _self.isRegistering : isRegistering // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceListingCopyWith<$Res>? get selectedListing {
    if (_self.selectedListing == null) {
    return null;
  }

  return $MarketplaceListingCopyWith<$Res>(_self.selectedListing!, (value) {
    return _then(_self.copyWith(selectedListing: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceProviderCopyWith<$Res>? get selectedProvider {
    if (_self.selectedProvider == null) {
    return null;
  }

  return $MarketplaceProviderCopyWith<$Res>(_self.selectedProvider!, (value) {
    return _then(_self.copyWith(selectedProvider: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceProviderCopyWith<$Res>? get currentSellerProfile {
    if (_self.currentSellerProfile == null) {
    return null;
  }

  return $MarketplaceProviderCopyWith<$Res>(_self.currentSellerProfile!, (value) {
    return _then(_self.copyWith(currentSellerProfile: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerDashboardCopyWith<$Res>? get sellerDashboard {
    if (_self.sellerDashboard == null) {
    return null;
  }

  return $SellerDashboardCopyWith<$Res>(_self.sellerDashboard!, (value) {
    return _then(_self.copyWith(sellerDashboard: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarketplaceState].
extension MarketplaceStatePatterns on MarketplaceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceState value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceState value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool isLoadingDetail,  bool isLoadingProvider,  List<MarketplaceListing> listings,  List<MarketplaceListing> filteredListings,  bool hasMore,  MarketplaceListing? selectedListing,  MarketplaceProvider? selectedProvider,  List<Vouch> providerVouches,  bool isSearching,  String searchQuery,  String? activeCategory,  String? activeCommunityId,  bool isCreating,  bool isReporting,  bool isUpdating,  bool isTogglingStatus,  bool isMakingOffer,  bool isRespondingToOffer,  bool isRefunding,  bool isRenewing,  bool isLoadingMyListings,  bool isLoadingSaved,  bool isLoadingSellerPortal,  List<MarketplaceListing> myListings,  List<SavedListing> savedItems,  MarketplaceProvider? currentSellerProfile,  SellerDashboard? sellerDashboard,  String? createSuccessId,  String? errorMessage,  String? reportSuccessMessage,  String? successMessage,  bool isUploadingImages,  List<String> uploadedImageUrls,  bool isRegistering)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.isLoadingDetail,_that.isLoadingProvider,_that.listings,_that.filteredListings,_that.hasMore,_that.selectedListing,_that.selectedProvider,_that.providerVouches,_that.isSearching,_that.searchQuery,_that.activeCategory,_that.activeCommunityId,_that.isCreating,_that.isReporting,_that.isUpdating,_that.isTogglingStatus,_that.isMakingOffer,_that.isRespondingToOffer,_that.isRefunding,_that.isRenewing,_that.isLoadingMyListings,_that.isLoadingSaved,_that.isLoadingSellerPortal,_that.myListings,_that.savedItems,_that.currentSellerProfile,_that.sellerDashboard,_that.createSuccessId,_that.errorMessage,_that.reportSuccessMessage,_that.successMessage,_that.isUploadingImages,_that.uploadedImageUrls,_that.isRegistering);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool isLoadingDetail,  bool isLoadingProvider,  List<MarketplaceListing> listings,  List<MarketplaceListing> filteredListings,  bool hasMore,  MarketplaceListing? selectedListing,  MarketplaceProvider? selectedProvider,  List<Vouch> providerVouches,  bool isSearching,  String searchQuery,  String? activeCategory,  String? activeCommunityId,  bool isCreating,  bool isReporting,  bool isUpdating,  bool isTogglingStatus,  bool isMakingOffer,  bool isRespondingToOffer,  bool isRefunding,  bool isRenewing,  bool isLoadingMyListings,  bool isLoadingSaved,  bool isLoadingSellerPortal,  List<MarketplaceListing> myListings,  List<SavedListing> savedItems,  MarketplaceProvider? currentSellerProfile,  SellerDashboard? sellerDashboard,  String? createSuccessId,  String? errorMessage,  String? reportSuccessMessage,  String? successMessage,  bool isUploadingImages,  List<String> uploadedImageUrls,  bool isRegistering)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceState():
return $default(_that.isLoading,_that.isLoadingMore,_that.isLoadingDetail,_that.isLoadingProvider,_that.listings,_that.filteredListings,_that.hasMore,_that.selectedListing,_that.selectedProvider,_that.providerVouches,_that.isSearching,_that.searchQuery,_that.activeCategory,_that.activeCommunityId,_that.isCreating,_that.isReporting,_that.isUpdating,_that.isTogglingStatus,_that.isMakingOffer,_that.isRespondingToOffer,_that.isRefunding,_that.isRenewing,_that.isLoadingMyListings,_that.isLoadingSaved,_that.isLoadingSellerPortal,_that.myListings,_that.savedItems,_that.currentSellerProfile,_that.sellerDashboard,_that.createSuccessId,_that.errorMessage,_that.reportSuccessMessage,_that.successMessage,_that.isUploadingImages,_that.uploadedImageUrls,_that.isRegistering);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  bool isLoadingDetail,  bool isLoadingProvider,  List<MarketplaceListing> listings,  List<MarketplaceListing> filteredListings,  bool hasMore,  MarketplaceListing? selectedListing,  MarketplaceProvider? selectedProvider,  List<Vouch> providerVouches,  bool isSearching,  String searchQuery,  String? activeCategory,  String? activeCommunityId,  bool isCreating,  bool isReporting,  bool isUpdating,  bool isTogglingStatus,  bool isMakingOffer,  bool isRespondingToOffer,  bool isRefunding,  bool isRenewing,  bool isLoadingMyListings,  bool isLoadingSaved,  bool isLoadingSellerPortal,  List<MarketplaceListing> myListings,  List<SavedListing> savedItems,  MarketplaceProvider? currentSellerProfile,  SellerDashboard? sellerDashboard,  String? createSuccessId,  String? errorMessage,  String? reportSuccessMessage,  String? successMessage,  bool isUploadingImages,  List<String> uploadedImageUrls,  bool isRegistering)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.isLoadingDetail,_that.isLoadingProvider,_that.listings,_that.filteredListings,_that.hasMore,_that.selectedListing,_that.selectedProvider,_that.providerVouches,_that.isSearching,_that.searchQuery,_that.activeCategory,_that.activeCommunityId,_that.isCreating,_that.isReporting,_that.isUpdating,_that.isTogglingStatus,_that.isMakingOffer,_that.isRespondingToOffer,_that.isRefunding,_that.isRenewing,_that.isLoadingMyListings,_that.isLoadingSaved,_that.isLoadingSellerPortal,_that.myListings,_that.savedItems,_that.currentSellerProfile,_that.sellerDashboard,_that.createSuccessId,_that.errorMessage,_that.reportSuccessMessage,_that.successMessage,_that.isUploadingImages,_that.uploadedImageUrls,_that.isRegistering);case _:
  return null;

}
}

}

/// @nodoc


class _MarketplaceState implements MarketplaceState {
  const _MarketplaceState({this.isLoading = false, this.isLoadingMore = false, this.isLoadingDetail = false, this.isLoadingProvider = false, final  List<MarketplaceListing> listings = const [], final  List<MarketplaceListing> filteredListings = const [], this.hasMore = true, this.selectedListing, this.selectedProvider, final  List<Vouch> providerVouches = const [], this.isSearching = false, this.searchQuery = '', this.activeCategory, this.activeCommunityId, this.isCreating = false, this.isReporting = false, this.isUpdating = false, this.isTogglingStatus = false, this.isMakingOffer = false, this.isRespondingToOffer = false, this.isRefunding = false, this.isRenewing = false, this.isLoadingMyListings = false, this.isLoadingSaved = false, this.isLoadingSellerPortal = false, final  List<MarketplaceListing> myListings = const [], final  List<SavedListing> savedItems = const [], this.currentSellerProfile, this.sellerDashboard, this.createSuccessId, this.errorMessage, this.reportSuccessMessage, this.successMessage, this.isUploadingImages = false, final  List<String> uploadedImageUrls = const [], this.isRegistering = false}): _listings = listings,_filteredListings = filteredListings,_providerVouches = providerVouches,_myListings = myListings,_savedItems = savedItems,_uploadedImageUrls = uploadedImageUrls;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isLoadingDetail;
@override@JsonKey() final  bool isLoadingProvider;
 final  List<MarketplaceListing> _listings;
@override@JsonKey() List<MarketplaceListing> get listings {
  if (_listings is EqualUnmodifiableListView) return _listings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listings);
}

 final  List<MarketplaceListing> _filteredListings;
@override@JsonKey() List<MarketplaceListing> get filteredListings {
  if (_filteredListings is EqualUnmodifiableListView) return _filteredListings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredListings);
}

@override@JsonKey() final  bool hasMore;
@override final  MarketplaceListing? selectedListing;
@override final  MarketplaceProvider? selectedProvider;
/// Vouches for the currently viewed provider profile
 final  List<Vouch> _providerVouches;
/// Vouches for the currently viewed provider profile
@override@JsonKey() List<Vouch> get providerVouches {
  if (_providerVouches is EqualUnmodifiableListView) return _providerVouches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providerVouches);
}

@override@JsonKey() final  bool isSearching;
@override@JsonKey() final  String searchQuery;
/// Current category filter — used for pagination in loadMore
@override final  String? activeCategory;
/// Current community filter — used for pagination in loadMore
@override final  String? activeCommunityId;
@override@JsonKey() final  bool isCreating;
@override@JsonKey() final  bool isReporting;
@override@JsonKey() final  bool isUpdating;
@override@JsonKey() final  bool isTogglingStatus;
@override@JsonKey() final  bool isMakingOffer;
@override@JsonKey() final  bool isRespondingToOffer;
@override@JsonKey() final  bool isRefunding;
@override@JsonKey() final  bool isRenewing;
@override@JsonKey() final  bool isLoadingMyListings;
@override@JsonKey() final  bool isLoadingSaved;
@override@JsonKey() final  bool isLoadingSellerPortal;
 final  List<MarketplaceListing> _myListings;
@override@JsonKey() List<MarketplaceListing> get myListings {
  if (_myListings is EqualUnmodifiableListView) return _myListings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_myListings);
}

 final  List<SavedListing> _savedItems;
@override@JsonKey() List<SavedListing> get savedItems {
  if (_savedItems is EqualUnmodifiableListView) return _savedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedItems);
}

@override final  MarketplaceProvider? currentSellerProfile;
@override final  SellerDashboard? sellerDashboard;
@override final  String? createSuccessId;
@override final  String? errorMessage;
@override final  String? reportSuccessMessage;
@override final  String? successMessage;
@override@JsonKey() final  bool isUploadingImages;
 final  List<String> _uploadedImageUrls;
@override@JsonKey() List<String> get uploadedImageUrls {
  if (_uploadedImageUrls is EqualUnmodifiableListView) return _uploadedImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadedImageUrls);
}

@override@JsonKey() final  bool isRegistering;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceStateCopyWith<_MarketplaceState> get copyWith => __$MarketplaceStateCopyWithImpl<_MarketplaceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isLoadingProvider, isLoadingProvider) || other.isLoadingProvider == isLoadingProvider)&&const DeepCollectionEquality().equals(other._listings, _listings)&&const DeepCollectionEquality().equals(other._filteredListings, _filteredListings)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.selectedListing, selectedListing) || other.selectedListing == selectedListing)&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&const DeepCollectionEquality().equals(other._providerVouches, _providerVouches)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.activeCategory, activeCategory) || other.activeCategory == activeCategory)&&(identical(other.activeCommunityId, activeCommunityId) || other.activeCommunityId == activeCommunityId)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isReporting, isReporting) || other.isReporting == isReporting)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.isTogglingStatus, isTogglingStatus) || other.isTogglingStatus == isTogglingStatus)&&(identical(other.isMakingOffer, isMakingOffer) || other.isMakingOffer == isMakingOffer)&&(identical(other.isRespondingToOffer, isRespondingToOffer) || other.isRespondingToOffer == isRespondingToOffer)&&(identical(other.isRefunding, isRefunding) || other.isRefunding == isRefunding)&&(identical(other.isRenewing, isRenewing) || other.isRenewing == isRenewing)&&(identical(other.isLoadingMyListings, isLoadingMyListings) || other.isLoadingMyListings == isLoadingMyListings)&&(identical(other.isLoadingSaved, isLoadingSaved) || other.isLoadingSaved == isLoadingSaved)&&(identical(other.isLoadingSellerPortal, isLoadingSellerPortal) || other.isLoadingSellerPortal == isLoadingSellerPortal)&&const DeepCollectionEquality().equals(other._myListings, _myListings)&&const DeepCollectionEquality().equals(other._savedItems, _savedItems)&&(identical(other.currentSellerProfile, currentSellerProfile) || other.currentSellerProfile == currentSellerProfile)&&(identical(other.sellerDashboard, sellerDashboard) || other.sellerDashboard == sellerDashboard)&&(identical(other.createSuccessId, createSuccessId) || other.createSuccessId == createSuccessId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.reportSuccessMessage, reportSuccessMessage) || other.reportSuccessMessage == reportSuccessMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.isUploadingImages, isUploadingImages) || other.isUploadingImages == isUploadingImages)&&const DeepCollectionEquality().equals(other._uploadedImageUrls, _uploadedImageUrls)&&(identical(other.isRegistering, isRegistering) || other.isRegistering == isRegistering));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,isLoadingMore,isLoadingDetail,isLoadingProvider,const DeepCollectionEquality().hash(_listings),const DeepCollectionEquality().hash(_filteredListings),hasMore,selectedListing,selectedProvider,const DeepCollectionEquality().hash(_providerVouches),isSearching,searchQuery,activeCategory,activeCommunityId,isCreating,isReporting,isUpdating,isTogglingStatus,isMakingOffer,isRespondingToOffer,isRefunding,isRenewing,isLoadingMyListings,isLoadingSaved,isLoadingSellerPortal,const DeepCollectionEquality().hash(_myListings),const DeepCollectionEquality().hash(_savedItems),currentSellerProfile,sellerDashboard,createSuccessId,errorMessage,reportSuccessMessage,successMessage,isUploadingImages,const DeepCollectionEquality().hash(_uploadedImageUrls),isRegistering]);

@override
String toString() {
  return 'MarketplaceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isLoadingDetail: $isLoadingDetail, isLoadingProvider: $isLoadingProvider, listings: $listings, filteredListings: $filteredListings, hasMore: $hasMore, selectedListing: $selectedListing, selectedProvider: $selectedProvider, providerVouches: $providerVouches, isSearching: $isSearching, searchQuery: $searchQuery, activeCategory: $activeCategory, activeCommunityId: $activeCommunityId, isCreating: $isCreating, isReporting: $isReporting, isUpdating: $isUpdating, isTogglingStatus: $isTogglingStatus, isMakingOffer: $isMakingOffer, isRespondingToOffer: $isRespondingToOffer, isRefunding: $isRefunding, isRenewing: $isRenewing, isLoadingMyListings: $isLoadingMyListings, isLoadingSaved: $isLoadingSaved, isLoadingSellerPortal: $isLoadingSellerPortal, myListings: $myListings, savedItems: $savedItems, currentSellerProfile: $currentSellerProfile, sellerDashboard: $sellerDashboard, createSuccessId: $createSuccessId, errorMessage: $errorMessage, reportSuccessMessage: $reportSuccessMessage, successMessage: $successMessage, isUploadingImages: $isUploadingImages, uploadedImageUrls: $uploadedImageUrls, isRegistering: $isRegistering)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceStateCopyWith<$Res> implements $MarketplaceStateCopyWith<$Res> {
  factory _$MarketplaceStateCopyWith(_MarketplaceState value, $Res Function(_MarketplaceState) _then) = __$MarketplaceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool isLoadingDetail, bool isLoadingProvider, List<MarketplaceListing> listings, List<MarketplaceListing> filteredListings, bool hasMore, MarketplaceListing? selectedListing, MarketplaceProvider? selectedProvider, List<Vouch> providerVouches, bool isSearching, String searchQuery, String? activeCategory, String? activeCommunityId, bool isCreating, bool isReporting, bool isUpdating, bool isTogglingStatus, bool isMakingOffer, bool isRespondingToOffer, bool isRefunding, bool isRenewing, bool isLoadingMyListings, bool isLoadingSaved, bool isLoadingSellerPortal, List<MarketplaceListing> myListings, List<SavedListing> savedItems, MarketplaceProvider? currentSellerProfile, SellerDashboard? sellerDashboard, String? createSuccessId, String? errorMessage, String? reportSuccessMessage, String? successMessage, bool isUploadingImages, List<String> uploadedImageUrls, bool isRegistering
});


@override $MarketplaceListingCopyWith<$Res>? get selectedListing;@override $MarketplaceProviderCopyWith<$Res>? get selectedProvider;@override $MarketplaceProviderCopyWith<$Res>? get currentSellerProfile;@override $SellerDashboardCopyWith<$Res>? get sellerDashboard;

}
/// @nodoc
class __$MarketplaceStateCopyWithImpl<$Res>
    implements _$MarketplaceStateCopyWith<$Res> {
  __$MarketplaceStateCopyWithImpl(this._self, this._then);

  final _MarketplaceState _self;
  final $Res Function(_MarketplaceState) _then;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isLoadingDetail = null,Object? isLoadingProvider = null,Object? listings = null,Object? filteredListings = null,Object? hasMore = null,Object? selectedListing = freezed,Object? selectedProvider = freezed,Object? providerVouches = null,Object? isSearching = null,Object? searchQuery = null,Object? activeCategory = freezed,Object? activeCommunityId = freezed,Object? isCreating = null,Object? isReporting = null,Object? isUpdating = null,Object? isTogglingStatus = null,Object? isMakingOffer = null,Object? isRespondingToOffer = null,Object? isRefunding = null,Object? isRenewing = null,Object? isLoadingMyListings = null,Object? isLoadingSaved = null,Object? isLoadingSellerPortal = null,Object? myListings = null,Object? savedItems = null,Object? currentSellerProfile = freezed,Object? sellerDashboard = freezed,Object? createSuccessId = freezed,Object? errorMessage = freezed,Object? reportSuccessMessage = freezed,Object? successMessage = freezed,Object? isUploadingImages = null,Object? uploadedImageUrls = null,Object? isRegistering = null,}) {
  return _then(_MarketplaceState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isLoadingProvider: null == isLoadingProvider ? _self.isLoadingProvider : isLoadingProvider // ignore: cast_nullable_to_non_nullable
as bool,listings: null == listings ? _self._listings : listings // ignore: cast_nullable_to_non_nullable
as List<MarketplaceListing>,filteredListings: null == filteredListings ? _self._filteredListings : filteredListings // ignore: cast_nullable_to_non_nullable
as List<MarketplaceListing>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,selectedListing: freezed == selectedListing ? _self.selectedListing : selectedListing // ignore: cast_nullable_to_non_nullable
as MarketplaceListing?,selectedProvider: freezed == selectedProvider ? _self.selectedProvider : selectedProvider // ignore: cast_nullable_to_non_nullable
as MarketplaceProvider?,providerVouches: null == providerVouches ? _self._providerVouches : providerVouches // ignore: cast_nullable_to_non_nullable
as List<Vouch>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,activeCategory: freezed == activeCategory ? _self.activeCategory : activeCategory // ignore: cast_nullable_to_non_nullable
as String?,activeCommunityId: freezed == activeCommunityId ? _self.activeCommunityId : activeCommunityId // ignore: cast_nullable_to_non_nullable
as String?,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isReporting: null == isReporting ? _self.isReporting : isReporting // ignore: cast_nullable_to_non_nullable
as bool,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,isTogglingStatus: null == isTogglingStatus ? _self.isTogglingStatus : isTogglingStatus // ignore: cast_nullable_to_non_nullable
as bool,isMakingOffer: null == isMakingOffer ? _self.isMakingOffer : isMakingOffer // ignore: cast_nullable_to_non_nullable
as bool,isRespondingToOffer: null == isRespondingToOffer ? _self.isRespondingToOffer : isRespondingToOffer // ignore: cast_nullable_to_non_nullable
as bool,isRefunding: null == isRefunding ? _self.isRefunding : isRefunding // ignore: cast_nullable_to_non_nullable
as bool,isRenewing: null == isRenewing ? _self.isRenewing : isRenewing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMyListings: null == isLoadingMyListings ? _self.isLoadingMyListings : isLoadingMyListings // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSaved: null == isLoadingSaved ? _self.isLoadingSaved : isLoadingSaved // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSellerPortal: null == isLoadingSellerPortal ? _self.isLoadingSellerPortal : isLoadingSellerPortal // ignore: cast_nullable_to_non_nullable
as bool,myListings: null == myListings ? _self._myListings : myListings // ignore: cast_nullable_to_non_nullable
as List<MarketplaceListing>,savedItems: null == savedItems ? _self._savedItems : savedItems // ignore: cast_nullable_to_non_nullable
as List<SavedListing>,currentSellerProfile: freezed == currentSellerProfile ? _self.currentSellerProfile : currentSellerProfile // ignore: cast_nullable_to_non_nullable
as MarketplaceProvider?,sellerDashboard: freezed == sellerDashboard ? _self.sellerDashboard : sellerDashboard // ignore: cast_nullable_to_non_nullable
as SellerDashboard?,createSuccessId: freezed == createSuccessId ? _self.createSuccessId : createSuccessId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,reportSuccessMessage: freezed == reportSuccessMessage ? _self.reportSuccessMessage : reportSuccessMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,isUploadingImages: null == isUploadingImages ? _self.isUploadingImages : isUploadingImages // ignore: cast_nullable_to_non_nullable
as bool,uploadedImageUrls: null == uploadedImageUrls ? _self._uploadedImageUrls : uploadedImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isRegistering: null == isRegistering ? _self.isRegistering : isRegistering // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceListingCopyWith<$Res>? get selectedListing {
    if (_self.selectedListing == null) {
    return null;
  }

  return $MarketplaceListingCopyWith<$Res>(_self.selectedListing!, (value) {
    return _then(_self.copyWith(selectedListing: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceProviderCopyWith<$Res>? get selectedProvider {
    if (_self.selectedProvider == null) {
    return null;
  }

  return $MarketplaceProviderCopyWith<$Res>(_self.selectedProvider!, (value) {
    return _then(_self.copyWith(selectedProvider: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceProviderCopyWith<$Res>? get currentSellerProfile {
    if (_self.currentSellerProfile == null) {
    return null;
  }

  return $MarketplaceProviderCopyWith<$Res>(_self.currentSellerProfile!, (value) {
    return _then(_self.copyWith(currentSellerProfile: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerDashboardCopyWith<$Res>? get sellerDashboard {
    if (_self.sellerDashboard == null) {
    return null;
  }

  return $SellerDashboardCopyWith<$Res>(_self.sellerDashboard!, (value) {
    return _then(_self.copyWith(sellerDashboard: value));
  });
}
}

// dart format on
