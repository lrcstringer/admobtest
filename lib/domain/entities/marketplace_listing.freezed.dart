// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketplaceListing {

 String get id; String get title; String get description; MarketplaceCategory get category; String? get subCategory; int get priceTokens; double get priceZar; List<String> get images; String? get thumbnailUrl; String get providerId; String get providerName; String? get providerPhotoUrl; double? get providerTrustScore; bool? get providerIsVerified; String? get communityId; String? get location; ListingStatus get status; int get viewCount; int get reportCount; DateTime? get expiresAt; DateTime get createdAt;// ── New fields (Spec §8.25) ──
 LocationData? get locationData; ServiceAreaType get serviceAreaType; DeliveryMethod get deliveryMethod; int? get deliveryFee; String? get geohash; int get favouriteCount; int get renewalCount; int get totalPausedDays; DateTime? get pausedAt;
/// Create a copy of MarketplaceListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceListingCopyWith<MarketplaceListing> get copyWith => _$MarketplaceListingCopyWithImpl<MarketplaceListing>(this as MarketplaceListing, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceListing&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerPhotoUrl, providerPhotoUrl) || other.providerPhotoUrl == providerPhotoUrl)&&(identical(other.providerTrustScore, providerTrustScore) || other.providerTrustScore == providerTrustScore)&&(identical(other.providerIsVerified, providerIsVerified) || other.providerIsVerified == providerIsVerified)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.locationData, locationData) || other.locationData == locationData)&&(identical(other.serviceAreaType, serviceAreaType) || other.serviceAreaType == serviceAreaType)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.geohash, geohash) || other.geohash == geohash)&&(identical(other.favouriteCount, favouriteCount) || other.favouriteCount == favouriteCount)&&(identical(other.renewalCount, renewalCount) || other.renewalCount == renewalCount)&&(identical(other.totalPausedDays, totalPausedDays) || other.totalPausedDays == totalPausedDays)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,category,subCategory,priceTokens,priceZar,const DeepCollectionEquality().hash(images),thumbnailUrl,providerId,providerName,providerPhotoUrl,providerTrustScore,providerIsVerified,communityId,location,status,viewCount,reportCount,expiresAt,createdAt,locationData,serviceAreaType,deliveryMethod,deliveryFee,geohash,favouriteCount,renewalCount,totalPausedDays,pausedAt]);

@override
String toString() {
  return 'MarketplaceListing(id: $id, title: $title, description: $description, category: $category, subCategory: $subCategory, priceTokens: $priceTokens, priceZar: $priceZar, images: $images, thumbnailUrl: $thumbnailUrl, providerId: $providerId, providerName: $providerName, providerPhotoUrl: $providerPhotoUrl, providerTrustScore: $providerTrustScore, providerIsVerified: $providerIsVerified, communityId: $communityId, location: $location, status: $status, viewCount: $viewCount, reportCount: $reportCount, expiresAt: $expiresAt, createdAt: $createdAt, locationData: $locationData, serviceAreaType: $serviceAreaType, deliveryMethod: $deliveryMethod, deliveryFee: $deliveryFee, geohash: $geohash, favouriteCount: $favouriteCount, renewalCount: $renewalCount, totalPausedDays: $totalPausedDays, pausedAt: $pausedAt)';
}


}

/// @nodoc
abstract mixin class $MarketplaceListingCopyWith<$Res>  {
  factory $MarketplaceListingCopyWith(MarketplaceListing value, $Res Function(MarketplaceListing) _then) = _$MarketplaceListingCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, MarketplaceCategory category, String? subCategory, int priceTokens, double priceZar, List<String> images, String? thumbnailUrl, String providerId, String providerName, String? providerPhotoUrl, double? providerTrustScore, bool? providerIsVerified, String? communityId, String? location, ListingStatus status, int viewCount, int reportCount, DateTime? expiresAt, DateTime createdAt, LocationData? locationData, ServiceAreaType serviceAreaType, DeliveryMethod deliveryMethod, int? deliveryFee, String? geohash, int favouriteCount, int renewalCount, int totalPausedDays, DateTime? pausedAt
});


$LocationDataCopyWith<$Res>? get locationData;

}
/// @nodoc
class _$MarketplaceListingCopyWithImpl<$Res>
    implements $MarketplaceListingCopyWith<$Res> {
  _$MarketplaceListingCopyWithImpl(this._self, this._then);

  final MarketplaceListing _self;
  final $Res Function(MarketplaceListing) _then;

/// Create a copy of MarketplaceListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? subCategory = freezed,Object? priceTokens = null,Object? priceZar = null,Object? images = null,Object? thumbnailUrl = freezed,Object? providerId = null,Object? providerName = null,Object? providerPhotoUrl = freezed,Object? providerTrustScore = freezed,Object? providerIsVerified = freezed,Object? communityId = freezed,Object? location = freezed,Object? status = null,Object? viewCount = null,Object? reportCount = null,Object? expiresAt = freezed,Object? createdAt = null,Object? locationData = freezed,Object? serviceAreaType = null,Object? deliveryMethod = null,Object? deliveryFee = freezed,Object? geohash = freezed,Object? favouriteCount = null,Object? renewalCount = null,Object? totalPausedDays = null,Object? pausedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MarketplaceCategory,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,providerPhotoUrl: freezed == providerPhotoUrl ? _self.providerPhotoUrl : providerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,providerTrustScore: freezed == providerTrustScore ? _self.providerTrustScore : providerTrustScore // ignore: cast_nullable_to_non_nullable
as double?,providerIsVerified: freezed == providerIsVerified ? _self.providerIsVerified : providerIsVerified // ignore: cast_nullable_to_non_nullable
as bool?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationData: freezed == locationData ? _self.locationData : locationData // ignore: cast_nullable_to_non_nullable
as LocationData?,serviceAreaType: null == serviceAreaType ? _self.serviceAreaType : serviceAreaType // ignore: cast_nullable_to_non_nullable
as ServiceAreaType,deliveryMethod: null == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as DeliveryMethod,deliveryFee: freezed == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as int?,geohash: freezed == geohash ? _self.geohash : geohash // ignore: cast_nullable_to_non_nullable
as String?,favouriteCount: null == favouriteCount ? _self.favouriteCount : favouriteCount // ignore: cast_nullable_to_non_nullable
as int,renewalCount: null == renewalCount ? _self.renewalCount : renewalCount // ignore: cast_nullable_to_non_nullable
as int,totalPausedDays: null == totalPausedDays ? _self.totalPausedDays : totalPausedDays // ignore: cast_nullable_to_non_nullable
as int,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of MarketplaceListing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res>? get locationData {
    if (_self.locationData == null) {
    return null;
  }

  return $LocationDataCopyWith<$Res>(_self.locationData!, (value) {
    return _then(_self.copyWith(locationData: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarketplaceListing].
extension MarketplaceListingPatterns on MarketplaceListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceListing value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceListing value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  MarketplaceCategory category,  String? subCategory,  int priceTokens,  double priceZar,  List<String> images,  String? thumbnailUrl,  String providerId,  String providerName,  String? providerPhotoUrl,  double? providerTrustScore,  bool? providerIsVerified,  String? communityId,  String? location,  ListingStatus status,  int viewCount,  int reportCount,  DateTime? expiresAt,  DateTime createdAt,  LocationData? locationData,  ServiceAreaType serviceAreaType,  DeliveryMethod deliveryMethod,  int? deliveryFee,  String? geohash,  int favouriteCount,  int renewalCount,  int totalPausedDays,  DateTime? pausedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceListing() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.subCategory,_that.priceTokens,_that.priceZar,_that.images,_that.thumbnailUrl,_that.providerId,_that.providerName,_that.providerPhotoUrl,_that.providerTrustScore,_that.providerIsVerified,_that.communityId,_that.location,_that.status,_that.viewCount,_that.reportCount,_that.expiresAt,_that.createdAt,_that.locationData,_that.serviceAreaType,_that.deliveryMethod,_that.deliveryFee,_that.geohash,_that.favouriteCount,_that.renewalCount,_that.totalPausedDays,_that.pausedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  MarketplaceCategory category,  String? subCategory,  int priceTokens,  double priceZar,  List<String> images,  String? thumbnailUrl,  String providerId,  String providerName,  String? providerPhotoUrl,  double? providerTrustScore,  bool? providerIsVerified,  String? communityId,  String? location,  ListingStatus status,  int viewCount,  int reportCount,  DateTime? expiresAt,  DateTime createdAt,  LocationData? locationData,  ServiceAreaType serviceAreaType,  DeliveryMethod deliveryMethod,  int? deliveryFee,  String? geohash,  int favouriteCount,  int renewalCount,  int totalPausedDays,  DateTime? pausedAt)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceListing():
return $default(_that.id,_that.title,_that.description,_that.category,_that.subCategory,_that.priceTokens,_that.priceZar,_that.images,_that.thumbnailUrl,_that.providerId,_that.providerName,_that.providerPhotoUrl,_that.providerTrustScore,_that.providerIsVerified,_that.communityId,_that.location,_that.status,_that.viewCount,_that.reportCount,_that.expiresAt,_that.createdAt,_that.locationData,_that.serviceAreaType,_that.deliveryMethod,_that.deliveryFee,_that.geohash,_that.favouriteCount,_that.renewalCount,_that.totalPausedDays,_that.pausedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  MarketplaceCategory category,  String? subCategory,  int priceTokens,  double priceZar,  List<String> images,  String? thumbnailUrl,  String providerId,  String providerName,  String? providerPhotoUrl,  double? providerTrustScore,  bool? providerIsVerified,  String? communityId,  String? location,  ListingStatus status,  int viewCount,  int reportCount,  DateTime? expiresAt,  DateTime createdAt,  LocationData? locationData,  ServiceAreaType serviceAreaType,  DeliveryMethod deliveryMethod,  int? deliveryFee,  String? geohash,  int favouriteCount,  int renewalCount,  int totalPausedDays,  DateTime? pausedAt)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceListing() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.subCategory,_that.priceTokens,_that.priceZar,_that.images,_that.thumbnailUrl,_that.providerId,_that.providerName,_that.providerPhotoUrl,_that.providerTrustScore,_that.providerIsVerified,_that.communityId,_that.location,_that.status,_that.viewCount,_that.reportCount,_that.expiresAt,_that.createdAt,_that.locationData,_that.serviceAreaType,_that.deliveryMethod,_that.deliveryFee,_that.geohash,_that.favouriteCount,_that.renewalCount,_that.totalPausedDays,_that.pausedAt);case _:
  return null;

}
}

}

/// @nodoc


class _MarketplaceListing extends MarketplaceListing {
  const _MarketplaceListing({required this.id, required this.title, required this.description, required this.category, this.subCategory, required this.priceTokens, required this.priceZar, final  List<String> images = const [], this.thumbnailUrl, required this.providerId, required this.providerName, this.providerPhotoUrl, this.providerTrustScore, this.providerIsVerified, this.communityId, this.location, required this.status, this.viewCount = 0, this.reportCount = 0, this.expiresAt, required this.createdAt, this.locationData, this.serviceAreaType = ServiceAreaType.myLocationOnly, this.deliveryMethod = DeliveryMethod.collection, this.deliveryFee, this.geohash, this.favouriteCount = 0, this.renewalCount = 0, this.totalPausedDays = 0, this.pausedAt}): _images = images,super._();
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  MarketplaceCategory category;
@override final  String? subCategory;
@override final  int priceTokens;
@override final  double priceZar;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  String? thumbnailUrl;
@override final  String providerId;
@override final  String providerName;
@override final  String? providerPhotoUrl;
@override final  double? providerTrustScore;
@override final  bool? providerIsVerified;
@override final  String? communityId;
@override final  String? location;
@override final  ListingStatus status;
@override@JsonKey() final  int viewCount;
@override@JsonKey() final  int reportCount;
@override final  DateTime? expiresAt;
@override final  DateTime createdAt;
// ── New fields (Spec §8.25) ──
@override final  LocationData? locationData;
@override@JsonKey() final  ServiceAreaType serviceAreaType;
@override@JsonKey() final  DeliveryMethod deliveryMethod;
@override final  int? deliveryFee;
@override final  String? geohash;
@override@JsonKey() final  int favouriteCount;
@override@JsonKey() final  int renewalCount;
@override@JsonKey() final  int totalPausedDays;
@override final  DateTime? pausedAt;

/// Create a copy of MarketplaceListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceListingCopyWith<_MarketplaceListing> get copyWith => __$MarketplaceListingCopyWithImpl<_MarketplaceListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceListing&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.priceTokens, priceTokens) || other.priceTokens == priceTokens)&&(identical(other.priceZar, priceZar) || other.priceZar == priceZar)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerPhotoUrl, providerPhotoUrl) || other.providerPhotoUrl == providerPhotoUrl)&&(identical(other.providerTrustScore, providerTrustScore) || other.providerTrustScore == providerTrustScore)&&(identical(other.providerIsVerified, providerIsVerified) || other.providerIsVerified == providerIsVerified)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.locationData, locationData) || other.locationData == locationData)&&(identical(other.serviceAreaType, serviceAreaType) || other.serviceAreaType == serviceAreaType)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.geohash, geohash) || other.geohash == geohash)&&(identical(other.favouriteCount, favouriteCount) || other.favouriteCount == favouriteCount)&&(identical(other.renewalCount, renewalCount) || other.renewalCount == renewalCount)&&(identical(other.totalPausedDays, totalPausedDays) || other.totalPausedDays == totalPausedDays)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,category,subCategory,priceTokens,priceZar,const DeepCollectionEquality().hash(_images),thumbnailUrl,providerId,providerName,providerPhotoUrl,providerTrustScore,providerIsVerified,communityId,location,status,viewCount,reportCount,expiresAt,createdAt,locationData,serviceAreaType,deliveryMethod,deliveryFee,geohash,favouriteCount,renewalCount,totalPausedDays,pausedAt]);

@override
String toString() {
  return 'MarketplaceListing(id: $id, title: $title, description: $description, category: $category, subCategory: $subCategory, priceTokens: $priceTokens, priceZar: $priceZar, images: $images, thumbnailUrl: $thumbnailUrl, providerId: $providerId, providerName: $providerName, providerPhotoUrl: $providerPhotoUrl, providerTrustScore: $providerTrustScore, providerIsVerified: $providerIsVerified, communityId: $communityId, location: $location, status: $status, viewCount: $viewCount, reportCount: $reportCount, expiresAt: $expiresAt, createdAt: $createdAt, locationData: $locationData, serviceAreaType: $serviceAreaType, deliveryMethod: $deliveryMethod, deliveryFee: $deliveryFee, geohash: $geohash, favouriteCount: $favouriteCount, renewalCount: $renewalCount, totalPausedDays: $totalPausedDays, pausedAt: $pausedAt)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceListingCopyWith<$Res> implements $MarketplaceListingCopyWith<$Res> {
  factory _$MarketplaceListingCopyWith(_MarketplaceListing value, $Res Function(_MarketplaceListing) _then) = __$MarketplaceListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, MarketplaceCategory category, String? subCategory, int priceTokens, double priceZar, List<String> images, String? thumbnailUrl, String providerId, String providerName, String? providerPhotoUrl, double? providerTrustScore, bool? providerIsVerified, String? communityId, String? location, ListingStatus status, int viewCount, int reportCount, DateTime? expiresAt, DateTime createdAt, LocationData? locationData, ServiceAreaType serviceAreaType, DeliveryMethod deliveryMethod, int? deliveryFee, String? geohash, int favouriteCount, int renewalCount, int totalPausedDays, DateTime? pausedAt
});


@override $LocationDataCopyWith<$Res>? get locationData;

}
/// @nodoc
class __$MarketplaceListingCopyWithImpl<$Res>
    implements _$MarketplaceListingCopyWith<$Res> {
  __$MarketplaceListingCopyWithImpl(this._self, this._then);

  final _MarketplaceListing _self;
  final $Res Function(_MarketplaceListing) _then;

/// Create a copy of MarketplaceListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? subCategory = freezed,Object? priceTokens = null,Object? priceZar = null,Object? images = null,Object? thumbnailUrl = freezed,Object? providerId = null,Object? providerName = null,Object? providerPhotoUrl = freezed,Object? providerTrustScore = freezed,Object? providerIsVerified = freezed,Object? communityId = freezed,Object? location = freezed,Object? status = null,Object? viewCount = null,Object? reportCount = null,Object? expiresAt = freezed,Object? createdAt = null,Object? locationData = freezed,Object? serviceAreaType = null,Object? deliveryMethod = null,Object? deliveryFee = freezed,Object? geohash = freezed,Object? favouriteCount = null,Object? renewalCount = null,Object? totalPausedDays = null,Object? pausedAt = freezed,}) {
  return _then(_MarketplaceListing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MarketplaceCategory,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,priceTokens: null == priceTokens ? _self.priceTokens : priceTokens // ignore: cast_nullable_to_non_nullable
as int,priceZar: null == priceZar ? _self.priceZar : priceZar // ignore: cast_nullable_to_non_nullable
as double,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,providerPhotoUrl: freezed == providerPhotoUrl ? _self.providerPhotoUrl : providerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,providerTrustScore: freezed == providerTrustScore ? _self.providerTrustScore : providerTrustScore // ignore: cast_nullable_to_non_nullable
as double?,providerIsVerified: freezed == providerIsVerified ? _self.providerIsVerified : providerIsVerified // ignore: cast_nullable_to_non_nullable
as bool?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationData: freezed == locationData ? _self.locationData : locationData // ignore: cast_nullable_to_non_nullable
as LocationData?,serviceAreaType: null == serviceAreaType ? _self.serviceAreaType : serviceAreaType // ignore: cast_nullable_to_non_nullable
as ServiceAreaType,deliveryMethod: null == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as DeliveryMethod,deliveryFee: freezed == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as int?,geohash: freezed == geohash ? _self.geohash : geohash // ignore: cast_nullable_to_non_nullable
as String?,favouriteCount: null == favouriteCount ? _self.favouriteCount : favouriteCount // ignore: cast_nullable_to_non_nullable
as int,renewalCount: null == renewalCount ? _self.renewalCount : renewalCount // ignore: cast_nullable_to_non_nullable
as int,totalPausedDays: null == totalPausedDays ? _self.totalPausedDays : totalPausedDays // ignore: cast_nullable_to_non_nullable
as int,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of MarketplaceListing
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res>? get locationData {
    if (_self.locationData == null) {
    return null;
  }

  return $LocationDataCopyWith<$Res>(_self.locationData!, (value) {
    return _then(_self.copyWith(locationData: value));
  });
}
}

// dart format on
