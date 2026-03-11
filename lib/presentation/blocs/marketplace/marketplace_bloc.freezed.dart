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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadListings value)?  loadListings,TResult Function( _LoadMore value)?  loadMore,TResult Function( _SearchListings value)?  searchListings,TResult Function( _ClearSearch value)?  clearSearch,TResult Function( _SelectListing value)?  selectListing,TResult Function( _LoadProviderProfile value)?  loadProviderProfile,TResult Function( _LoadProviderVouches value)?  loadProviderVouches,TResult Function( _ReportListing value)?  reportListing,TResult Function( _ReportProvider value)?  reportProvider,TResult Function( _CreateListing value)?  createListing,TResult Function( _ClearMessages value)?  clearMessages,required TResult orElse(),}){
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
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadListings value)  loadListings,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _SearchListings value)  searchListings,required TResult Function( _ClearSearch value)  clearSearch,required TResult Function( _SelectListing value)  selectListing,required TResult Function( _LoadProviderProfile value)  loadProviderProfile,required TResult Function( _LoadProviderVouches value)  loadProviderVouches,required TResult Function( _ReportListing value)  reportListing,required TResult Function( _ReportProvider value)  reportProvider,required TResult Function( _CreateListing value)  createListing,required TResult Function( _ClearMessages value)  clearMessages,}){
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
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadListings value)?  loadListings,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _SearchListings value)?  searchListings,TResult? Function( _ClearSearch value)?  clearSearch,TResult? Function( _SelectListing value)?  selectListing,TResult? Function( _LoadProviderProfile value)?  loadProviderProfile,TResult? Function( _LoadProviderVouches value)?  loadProviderVouches,TResult? Function( _ReportListing value)?  reportListing,TResult? Function( _ReportProvider value)?  reportProvider,TResult? Function( _CreateListing value)?  createListing,TResult? Function( _ClearMessages value)?  clearMessages,}){
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
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? category,  String? communityId)?  loadListings,TResult Function()?  loadMore,TResult Function( String query)?  searchListings,TResult Function()?  clearSearch,TResult Function( String id)?  selectListing,TResult Function( String providerId)?  loadProviderProfile,TResult Function( String providerId)?  loadProviderVouches,TResult Function( String listingId,  String reason,  String? description)?  reportListing,TResult Function( String providerId,  String reason,  String? description)?  reportProvider,TResult Function( String title,  String description,  String category,  String? subCategory,  int priceTokens,  List<String> imageUrls,  String? location)?  createListing,TResult Function()?  clearMessages,required TResult orElse(),}) {final _that = this;
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
return clearMessages();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? category,  String? communityId)  loadListings,required TResult Function()  loadMore,required TResult Function( String query)  searchListings,required TResult Function()  clearSearch,required TResult Function( String id)  selectListing,required TResult Function( String providerId)  loadProviderProfile,required TResult Function( String providerId)  loadProviderVouches,required TResult Function( String listingId,  String reason,  String? description)  reportListing,required TResult Function( String providerId,  String reason,  String? description)  reportProvider,required TResult Function( String title,  String description,  String category,  String? subCategory,  int priceTokens,  List<String> imageUrls,  String? location)  createListing,required TResult Function()  clearMessages,}) {final _that = this;
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
return clearMessages();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? category,  String? communityId)?  loadListings,TResult? Function()?  loadMore,TResult? Function( String query)?  searchListings,TResult? Function()?  clearSearch,TResult? Function( String id)?  selectListing,TResult? Function( String providerId)?  loadProviderProfile,TResult? Function( String providerId)?  loadProviderVouches,TResult? Function( String listingId,  String reason,  String? description)?  reportListing,TResult? Function( String providerId,  String reason,  String? description)?  reportProvider,TResult? Function( String title,  String description,  String category,  String? subCategory,  int priceTokens,  List<String> imageUrls,  String? location)?  createListing,TResult? Function()?  clearMessages,}) {final _that = this;
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
return clearMessages();case _:
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
mixin _$MarketplaceState {

 bool get isLoading; bool get isLoadingMore; bool get isLoadingDetail; bool get isLoadingProvider; List<MarketplaceListing> get listings; List<MarketplaceListing> get filteredListings; bool get hasMore; MarketplaceListing? get selectedListing; MarketplaceProvider? get selectedProvider; List<Vouch> get providerVouches; bool get isSearching; String get searchQuery; String? get activeCategory; String? get activeCommunityId; bool get isCreating; bool get isReporting; String? get createSuccessId; String? get errorMessage; String? get reportSuccessMessage;
/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceStateCopyWith<MarketplaceState> get copyWith => _$MarketplaceStateCopyWithImpl<MarketplaceState>(this as MarketplaceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isLoadingProvider, isLoadingProvider) || other.isLoadingProvider == isLoadingProvider)&&const DeepCollectionEquality().equals(other.listings, listings)&&const DeepCollectionEquality().equals(other.filteredListings, filteredListings)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.selectedListing, selectedListing) || other.selectedListing == selectedListing)&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&const DeepCollectionEquality().equals(other.providerVouches, providerVouches)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.activeCategory, activeCategory) || other.activeCategory == activeCategory)&&(identical(other.activeCommunityId, activeCommunityId) || other.activeCommunityId == activeCommunityId)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isReporting, isReporting) || other.isReporting == isReporting)&&(identical(other.createSuccessId, createSuccessId) || other.createSuccessId == createSuccessId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.reportSuccessMessage, reportSuccessMessage) || other.reportSuccessMessage == reportSuccessMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,isLoadingMore,isLoadingDetail,isLoadingProvider,const DeepCollectionEquality().hash(listings),const DeepCollectionEquality().hash(filteredListings),hasMore,selectedListing,selectedProvider,const DeepCollectionEquality().hash(providerVouches),isSearching,searchQuery,activeCategory,activeCommunityId,isCreating,isReporting,createSuccessId,errorMessage,reportSuccessMessage]);

@override
String toString() {
  return 'MarketplaceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isLoadingDetail: $isLoadingDetail, isLoadingProvider: $isLoadingProvider, listings: $listings, filteredListings: $filteredListings, hasMore: $hasMore, selectedListing: $selectedListing, selectedProvider: $selectedProvider, providerVouches: $providerVouches, isSearching: $isSearching, searchQuery: $searchQuery, activeCategory: $activeCategory, activeCommunityId: $activeCommunityId, isCreating: $isCreating, isReporting: $isReporting, createSuccessId: $createSuccessId, errorMessage: $errorMessage, reportSuccessMessage: $reportSuccessMessage)';
}


}

/// @nodoc
abstract mixin class $MarketplaceStateCopyWith<$Res>  {
  factory $MarketplaceStateCopyWith(MarketplaceState value, $Res Function(MarketplaceState) _then) = _$MarketplaceStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool isLoadingDetail, bool isLoadingProvider, List<MarketplaceListing> listings, List<MarketplaceListing> filteredListings, bool hasMore, MarketplaceListing? selectedListing, MarketplaceProvider? selectedProvider, List<Vouch> providerVouches, bool isSearching, String searchQuery, String? activeCategory, String? activeCommunityId, bool isCreating, bool isReporting, String? createSuccessId, String? errorMessage, String? reportSuccessMessage
});


$MarketplaceListingCopyWith<$Res>? get selectedListing;$MarketplaceProviderCopyWith<$Res>? get selectedProvider;

}
/// @nodoc
class _$MarketplaceStateCopyWithImpl<$Res>
    implements $MarketplaceStateCopyWith<$Res> {
  _$MarketplaceStateCopyWithImpl(this._self, this._then);

  final MarketplaceState _self;
  final $Res Function(MarketplaceState) _then;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isLoadingDetail = null,Object? isLoadingProvider = null,Object? listings = null,Object? filteredListings = null,Object? hasMore = null,Object? selectedListing = freezed,Object? selectedProvider = freezed,Object? providerVouches = null,Object? isSearching = null,Object? searchQuery = null,Object? activeCategory = freezed,Object? activeCommunityId = freezed,Object? isCreating = null,Object? isReporting = null,Object? createSuccessId = freezed,Object? errorMessage = freezed,Object? reportSuccessMessage = freezed,}) {
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
as bool,createSuccessId: freezed == createSuccessId ? _self.createSuccessId : createSuccessId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,reportSuccessMessage: freezed == reportSuccessMessage ? _self.reportSuccessMessage : reportSuccessMessage // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool isLoadingDetail,  bool isLoadingProvider,  List<MarketplaceListing> listings,  List<MarketplaceListing> filteredListings,  bool hasMore,  MarketplaceListing? selectedListing,  MarketplaceProvider? selectedProvider,  List<Vouch> providerVouches,  bool isSearching,  String searchQuery,  String? activeCategory,  String? activeCommunityId,  bool isCreating,  bool isReporting,  String? createSuccessId,  String? errorMessage,  String? reportSuccessMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.isLoadingDetail,_that.isLoadingProvider,_that.listings,_that.filteredListings,_that.hasMore,_that.selectedListing,_that.selectedProvider,_that.providerVouches,_that.isSearching,_that.searchQuery,_that.activeCategory,_that.activeCommunityId,_that.isCreating,_that.isReporting,_that.createSuccessId,_that.errorMessage,_that.reportSuccessMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool isLoadingDetail,  bool isLoadingProvider,  List<MarketplaceListing> listings,  List<MarketplaceListing> filteredListings,  bool hasMore,  MarketplaceListing? selectedListing,  MarketplaceProvider? selectedProvider,  List<Vouch> providerVouches,  bool isSearching,  String searchQuery,  String? activeCategory,  String? activeCommunityId,  bool isCreating,  bool isReporting,  String? createSuccessId,  String? errorMessage,  String? reportSuccessMessage)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceState():
return $default(_that.isLoading,_that.isLoadingMore,_that.isLoadingDetail,_that.isLoadingProvider,_that.listings,_that.filteredListings,_that.hasMore,_that.selectedListing,_that.selectedProvider,_that.providerVouches,_that.isSearching,_that.searchQuery,_that.activeCategory,_that.activeCommunityId,_that.isCreating,_that.isReporting,_that.createSuccessId,_that.errorMessage,_that.reportSuccessMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  bool isLoadingDetail,  bool isLoadingProvider,  List<MarketplaceListing> listings,  List<MarketplaceListing> filteredListings,  bool hasMore,  MarketplaceListing? selectedListing,  MarketplaceProvider? selectedProvider,  List<Vouch> providerVouches,  bool isSearching,  String searchQuery,  String? activeCategory,  String? activeCommunityId,  bool isCreating,  bool isReporting,  String? createSuccessId,  String? errorMessage,  String? reportSuccessMessage)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.isLoadingDetail,_that.isLoadingProvider,_that.listings,_that.filteredListings,_that.hasMore,_that.selectedListing,_that.selectedProvider,_that.providerVouches,_that.isSearching,_that.searchQuery,_that.activeCategory,_that.activeCommunityId,_that.isCreating,_that.isReporting,_that.createSuccessId,_that.errorMessage,_that.reportSuccessMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MarketplaceState implements MarketplaceState {
  const _MarketplaceState({this.isLoading = false, this.isLoadingMore = false, this.isLoadingDetail = false, this.isLoadingProvider = false, final  List<MarketplaceListing> listings = const [], final  List<MarketplaceListing> filteredListings = const [], this.hasMore = true, this.selectedListing, this.selectedProvider, final  List<Vouch> providerVouches = const [], this.isSearching = false, this.searchQuery = '', this.activeCategory, this.activeCommunityId, this.isCreating = false, this.isReporting = false, this.createSuccessId, this.errorMessage, this.reportSuccessMessage}): _listings = listings,_filteredListings = filteredListings,_providerVouches = providerVouches;
  

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
 final  List<Vouch> _providerVouches;
@override@JsonKey() List<Vouch> get providerVouches {
  if (_providerVouches is EqualUnmodifiableListView) return _providerVouches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providerVouches);
}

@override@JsonKey() final  bool isSearching;
@override@JsonKey() final  String searchQuery;
@override final  String? activeCategory;
@override final  String? activeCommunityId;
@override@JsonKey() final  bool isCreating;
@override@JsonKey() final  bool isReporting;
@override final  String? createSuccessId;
@override final  String? errorMessage;
@override final  String? reportSuccessMessage;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceStateCopyWith<_MarketplaceState> get copyWith => __$MarketplaceStateCopyWithImpl<_MarketplaceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isLoadingProvider, isLoadingProvider) || other.isLoadingProvider == isLoadingProvider)&&const DeepCollectionEquality().equals(other._listings, _listings)&&const DeepCollectionEquality().equals(other._filteredListings, _filteredListings)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.selectedListing, selectedListing) || other.selectedListing == selectedListing)&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&const DeepCollectionEquality().equals(other._providerVouches, _providerVouches)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.activeCategory, activeCategory) || other.activeCategory == activeCategory)&&(identical(other.activeCommunityId, activeCommunityId) || other.activeCommunityId == activeCommunityId)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isReporting, isReporting) || other.isReporting == isReporting)&&(identical(other.createSuccessId, createSuccessId) || other.createSuccessId == createSuccessId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.reportSuccessMessage, reportSuccessMessage) || other.reportSuccessMessage == reportSuccessMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,isLoadingMore,isLoadingDetail,isLoadingProvider,const DeepCollectionEquality().hash(_listings),const DeepCollectionEquality().hash(_filteredListings),hasMore,selectedListing,selectedProvider,const DeepCollectionEquality().hash(_providerVouches),isSearching,searchQuery,activeCategory,activeCommunityId,isCreating,isReporting,createSuccessId,errorMessage,reportSuccessMessage]);

@override
String toString() {
  return 'MarketplaceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isLoadingDetail: $isLoadingDetail, isLoadingProvider: $isLoadingProvider, listings: $listings, filteredListings: $filteredListings, hasMore: $hasMore, selectedListing: $selectedListing, selectedProvider: $selectedProvider, providerVouches: $providerVouches, isSearching: $isSearching, searchQuery: $searchQuery, activeCategory: $activeCategory, activeCommunityId: $activeCommunityId, isCreating: $isCreating, isReporting: $isReporting, createSuccessId: $createSuccessId, errorMessage: $errorMessage, reportSuccessMessage: $reportSuccessMessage)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceStateCopyWith<$Res> implements $MarketplaceStateCopyWith<$Res> {
  factory _$MarketplaceStateCopyWith(_MarketplaceState value, $Res Function(_MarketplaceState) _then) = __$MarketplaceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool isLoadingDetail, bool isLoadingProvider, List<MarketplaceListing> listings, List<MarketplaceListing> filteredListings, bool hasMore, MarketplaceListing? selectedListing, MarketplaceProvider? selectedProvider, List<Vouch> providerVouches, bool isSearching, String searchQuery, String? activeCategory, String? activeCommunityId, bool isCreating, bool isReporting, String? createSuccessId, String? errorMessage, String? reportSuccessMessage
});


@override $MarketplaceListingCopyWith<$Res>? get selectedListing;@override $MarketplaceProviderCopyWith<$Res>? get selectedProvider;

}
/// @nodoc
class __$MarketplaceStateCopyWithImpl<$Res>
    implements _$MarketplaceStateCopyWith<$Res> {
  __$MarketplaceStateCopyWithImpl(this._self, this._then);

  final _MarketplaceState _self;
  final $Res Function(_MarketplaceState) _then;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isLoadingDetail = null,Object? isLoadingProvider = null,Object? listings = null,Object? filteredListings = null,Object? hasMore = null,Object? selectedListing = freezed,Object? selectedProvider = freezed,Object? providerVouches = null,Object? isSearching = null,Object? searchQuery = null,Object? activeCategory = freezed,Object? activeCommunityId = freezed,Object? isCreating = null,Object? isReporting = null,Object? createSuccessId = freezed,Object? errorMessage = freezed,Object? reportSuccessMessage = freezed,}) {
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
as bool,createSuccessId: freezed == createSuccessId ? _self.createSuccessId : createSuccessId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,reportSuccessMessage: freezed == reportSuccessMessage ? _self.reportSuccessMessage : reportSuccessMessage // ignore: cast_nullable_to_non_nullable
as String?,
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
}
}

// dart format on
