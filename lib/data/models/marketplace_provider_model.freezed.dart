// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_provider_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketplaceProviderModel {

 String get id; String get userId; String get displayName; String? get bio; String? get photoUrl; String? get communityId; String? get servicesDescription; ProviderStatus get status; double get trustScore; int get vouchCount; int get completedOrders; bool get isVerified; bool? get isVerifiedOverride; List<String> get customerIds; DateTime get createdAt;// ── New fields (Spec §8.25) ──
 List<String> get categories; List<String>? get subCategories; SellerLevel get sellerLevel; double? get avgResponseTimeHrs; int get warningCount; int get reportCount; double get disputeRate; double get cancellationRate; String? get suspensionReason; String? get suspensionTrigger; DateTime? get suspendedAt; DateTime? get bannedAt; LocationData? get profileLocation; double get ratingSum;
/// Create a copy of MarketplaceProviderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceProviderModelCopyWith<MarketplaceProviderModel> get copyWith => _$MarketplaceProviderModelCopyWithImpl<MarketplaceProviderModel>(this as MarketplaceProviderModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceProviderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.status, status) || other.status == status)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.vouchCount, vouchCount) || other.vouchCount == vouchCount)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isVerifiedOverride, isVerifiedOverride) || other.isVerifiedOverride == isVerifiedOverride)&&const DeepCollectionEquality().equals(other.customerIds, customerIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.subCategories, subCategories)&&(identical(other.sellerLevel, sellerLevel) || other.sellerLevel == sellerLevel)&&(identical(other.avgResponseTimeHrs, avgResponseTimeHrs) || other.avgResponseTimeHrs == avgResponseTimeHrs)&&(identical(other.warningCount, warningCount) || other.warningCount == warningCount)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.disputeRate, disputeRate) || other.disputeRate == disputeRate)&&(identical(other.cancellationRate, cancellationRate) || other.cancellationRate == cancellationRate)&&(identical(other.suspensionReason, suspensionReason) || other.suspensionReason == suspensionReason)&&(identical(other.suspensionTrigger, suspensionTrigger) || other.suspensionTrigger == suspensionTrigger)&&(identical(other.suspendedAt, suspendedAt) || other.suspendedAt == suspendedAt)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.profileLocation, profileLocation) || other.profileLocation == profileLocation)&&(identical(other.ratingSum, ratingSum) || other.ratingSum == ratingSum));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,displayName,bio,photoUrl,communityId,servicesDescription,status,trustScore,vouchCount,completedOrders,isVerified,isVerifiedOverride,const DeepCollectionEquality().hash(customerIds),createdAt,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(subCategories),sellerLevel,avgResponseTimeHrs,warningCount,reportCount,disputeRate,cancellationRate,suspensionReason,suspensionTrigger,suspendedAt,bannedAt,profileLocation,ratingSum]);

@override
String toString() {
  return 'MarketplaceProviderModel(id: $id, userId: $userId, displayName: $displayName, bio: $bio, photoUrl: $photoUrl, communityId: $communityId, servicesDescription: $servicesDescription, status: $status, trustScore: $trustScore, vouchCount: $vouchCount, completedOrders: $completedOrders, isVerified: $isVerified, isVerifiedOverride: $isVerifiedOverride, customerIds: $customerIds, createdAt: $createdAt, categories: $categories, subCategories: $subCategories, sellerLevel: $sellerLevel, avgResponseTimeHrs: $avgResponseTimeHrs, warningCount: $warningCount, reportCount: $reportCount, disputeRate: $disputeRate, cancellationRate: $cancellationRate, suspensionReason: $suspensionReason, suspensionTrigger: $suspensionTrigger, suspendedAt: $suspendedAt, bannedAt: $bannedAt, profileLocation: $profileLocation, ratingSum: $ratingSum)';
}


}

/// @nodoc
abstract mixin class $MarketplaceProviderModelCopyWith<$Res>  {
  factory $MarketplaceProviderModelCopyWith(MarketplaceProviderModel value, $Res Function(MarketplaceProviderModel) _then) = _$MarketplaceProviderModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String displayName, String? bio, String? photoUrl, String? communityId, String? servicesDescription, ProviderStatus status, double trustScore, int vouchCount, int completedOrders, bool isVerified, bool? isVerifiedOverride, List<String> customerIds, DateTime createdAt, List<String> categories, List<String>? subCategories, SellerLevel sellerLevel, double? avgResponseTimeHrs, int warningCount, int reportCount, double disputeRate, double cancellationRate, String? suspensionReason, String? suspensionTrigger, DateTime? suspendedAt, DateTime? bannedAt, LocationData? profileLocation, double ratingSum
});


$LocationDataCopyWith<$Res>? get profileLocation;

}
/// @nodoc
class _$MarketplaceProviderModelCopyWithImpl<$Res>
    implements $MarketplaceProviderModelCopyWith<$Res> {
  _$MarketplaceProviderModelCopyWithImpl(this._self, this._then);

  final MarketplaceProviderModel _self;
  final $Res Function(MarketplaceProviderModel) _then;

/// Create a copy of MarketplaceProviderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? bio = freezed,Object? photoUrl = freezed,Object? communityId = freezed,Object? servicesDescription = freezed,Object? status = null,Object? trustScore = null,Object? vouchCount = null,Object? completedOrders = null,Object? isVerified = null,Object? isVerifiedOverride = freezed,Object? customerIds = null,Object? createdAt = null,Object? categories = null,Object? subCategories = freezed,Object? sellerLevel = null,Object? avgResponseTimeHrs = freezed,Object? warningCount = null,Object? reportCount = null,Object? disputeRate = null,Object? cancellationRate = null,Object? suspensionReason = freezed,Object? suspensionTrigger = freezed,Object? suspendedAt = freezed,Object? bannedAt = freezed,Object? profileLocation = freezed,Object? ratingSum = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,servicesDescription: freezed == servicesDescription ? _self.servicesDescription : servicesDescription // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProviderStatus,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,vouchCount: null == vouchCount ? _self.vouchCount : vouchCount // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,isVerifiedOverride: freezed == isVerifiedOverride ? _self.isVerifiedOverride : isVerifiedOverride // ignore: cast_nullable_to_non_nullable
as bool?,customerIds: null == customerIds ? _self.customerIds : customerIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,subCategories: freezed == subCategories ? _self.subCategories : subCategories // ignore: cast_nullable_to_non_nullable
as List<String>?,sellerLevel: null == sellerLevel ? _self.sellerLevel : sellerLevel // ignore: cast_nullable_to_non_nullable
as SellerLevel,avgResponseTimeHrs: freezed == avgResponseTimeHrs ? _self.avgResponseTimeHrs : avgResponseTimeHrs // ignore: cast_nullable_to_non_nullable
as double?,warningCount: null == warningCount ? _self.warningCount : warningCount // ignore: cast_nullable_to_non_nullable
as int,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,disputeRate: null == disputeRate ? _self.disputeRate : disputeRate // ignore: cast_nullable_to_non_nullable
as double,cancellationRate: null == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double,suspensionReason: freezed == suspensionReason ? _self.suspensionReason : suspensionReason // ignore: cast_nullable_to_non_nullable
as String?,suspensionTrigger: freezed == suspensionTrigger ? _self.suspensionTrigger : suspensionTrigger // ignore: cast_nullable_to_non_nullable
as String?,suspendedAt: freezed == suspendedAt ? _self.suspendedAt : suspendedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,profileLocation: freezed == profileLocation ? _self.profileLocation : profileLocation // ignore: cast_nullable_to_non_nullable
as LocationData?,ratingSum: null == ratingSum ? _self.ratingSum : ratingSum // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of MarketplaceProviderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res>? get profileLocation {
    if (_self.profileLocation == null) {
    return null;
  }

  return $LocationDataCopyWith<$Res>(_self.profileLocation!, (value) {
    return _then(_self.copyWith(profileLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarketplaceProviderModel].
extension MarketplaceProviderModelPatterns on MarketplaceProviderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceProviderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceProviderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceProviderModel value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceProviderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceProviderModel value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceProviderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? bio,  String? photoUrl,  String? communityId,  String? servicesDescription,  ProviderStatus status,  double trustScore,  int vouchCount,  int completedOrders,  bool isVerified,  bool? isVerifiedOverride,  List<String> customerIds,  DateTime createdAt,  List<String> categories,  List<String>? subCategories,  SellerLevel sellerLevel,  double? avgResponseTimeHrs,  int warningCount,  int reportCount,  double disputeRate,  double cancellationRate,  String? suspensionReason,  String? suspensionTrigger,  DateTime? suspendedAt,  DateTime? bannedAt,  LocationData? profileLocation,  double ratingSum)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceProviderModel() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.photoUrl,_that.communityId,_that.servicesDescription,_that.status,_that.trustScore,_that.vouchCount,_that.completedOrders,_that.isVerified,_that.isVerifiedOverride,_that.customerIds,_that.createdAt,_that.categories,_that.subCategories,_that.sellerLevel,_that.avgResponseTimeHrs,_that.warningCount,_that.reportCount,_that.disputeRate,_that.cancellationRate,_that.suspensionReason,_that.suspensionTrigger,_that.suspendedAt,_that.bannedAt,_that.profileLocation,_that.ratingSum);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? bio,  String? photoUrl,  String? communityId,  String? servicesDescription,  ProviderStatus status,  double trustScore,  int vouchCount,  int completedOrders,  bool isVerified,  bool? isVerifiedOverride,  List<String> customerIds,  DateTime createdAt,  List<String> categories,  List<String>? subCategories,  SellerLevel sellerLevel,  double? avgResponseTimeHrs,  int warningCount,  int reportCount,  double disputeRate,  double cancellationRate,  String? suspensionReason,  String? suspensionTrigger,  DateTime? suspendedAt,  DateTime? bannedAt,  LocationData? profileLocation,  double ratingSum)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceProviderModel():
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.photoUrl,_that.communityId,_that.servicesDescription,_that.status,_that.trustScore,_that.vouchCount,_that.completedOrders,_that.isVerified,_that.isVerifiedOverride,_that.customerIds,_that.createdAt,_that.categories,_that.subCategories,_that.sellerLevel,_that.avgResponseTimeHrs,_that.warningCount,_that.reportCount,_that.disputeRate,_that.cancellationRate,_that.suspensionReason,_that.suspensionTrigger,_that.suspendedAt,_that.bannedAt,_that.profileLocation,_that.ratingSum);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String displayName,  String? bio,  String? photoUrl,  String? communityId,  String? servicesDescription,  ProviderStatus status,  double trustScore,  int vouchCount,  int completedOrders,  bool isVerified,  bool? isVerifiedOverride,  List<String> customerIds,  DateTime createdAt,  List<String> categories,  List<String>? subCategories,  SellerLevel sellerLevel,  double? avgResponseTimeHrs,  int warningCount,  int reportCount,  double disputeRate,  double cancellationRate,  String? suspensionReason,  String? suspensionTrigger,  DateTime? suspendedAt,  DateTime? bannedAt,  LocationData? profileLocation,  double ratingSum)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceProviderModel() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.photoUrl,_that.communityId,_that.servicesDescription,_that.status,_that.trustScore,_that.vouchCount,_that.completedOrders,_that.isVerified,_that.isVerifiedOverride,_that.customerIds,_that.createdAt,_that.categories,_that.subCategories,_that.sellerLevel,_that.avgResponseTimeHrs,_that.warningCount,_that.reportCount,_that.disputeRate,_that.cancellationRate,_that.suspensionReason,_that.suspensionTrigger,_that.suspendedAt,_that.bannedAt,_that.profileLocation,_that.ratingSum);case _:
  return null;

}
}

}

/// @nodoc


class _MarketplaceProviderModel extends MarketplaceProviderModel {
  const _MarketplaceProviderModel({required this.id, required this.userId, required this.displayName, this.bio, this.photoUrl, this.communityId, this.servicesDescription, required this.status, this.trustScore = 0.0, this.vouchCount = 0, this.completedOrders = 0, this.isVerified = false, this.isVerifiedOverride, final  List<String> customerIds = const [], required this.createdAt, final  List<String> categories = const [], final  List<String>? subCategories, this.sellerLevel = SellerLevel.newSeller, this.avgResponseTimeHrs, this.warningCount = 0, this.reportCount = 0, this.disputeRate = 0.0, this.cancellationRate = 0.0, this.suspensionReason, this.suspensionTrigger, this.suspendedAt, this.bannedAt, this.profileLocation, this.ratingSum = 0}): _customerIds = customerIds,_categories = categories,_subCategories = subCategories,super._();
  

@override final  String id;
@override final  String userId;
@override final  String displayName;
@override final  String? bio;
@override final  String? photoUrl;
@override final  String? communityId;
@override final  String? servicesDescription;
@override final  ProviderStatus status;
@override@JsonKey() final  double trustScore;
@override@JsonKey() final  int vouchCount;
@override@JsonKey() final  int completedOrders;
@override@JsonKey() final  bool isVerified;
@override final  bool? isVerifiedOverride;
 final  List<String> _customerIds;
@override@JsonKey() List<String> get customerIds {
  if (_customerIds is EqualUnmodifiableListView) return _customerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customerIds);
}

@override final  DateTime createdAt;
// ── New fields (Spec §8.25) ──
 final  List<String> _categories;
// ── New fields (Spec §8.25) ──
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String>? _subCategories;
@override List<String>? get subCategories {
  final value = _subCategories;
  if (value == null) return null;
  if (_subCategories is EqualUnmodifiableListView) return _subCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  SellerLevel sellerLevel;
@override final  double? avgResponseTimeHrs;
@override@JsonKey() final  int warningCount;
@override@JsonKey() final  int reportCount;
@override@JsonKey() final  double disputeRate;
@override@JsonKey() final  double cancellationRate;
@override final  String? suspensionReason;
@override final  String? suspensionTrigger;
@override final  DateTime? suspendedAt;
@override final  DateTime? bannedAt;
@override final  LocationData? profileLocation;
@override@JsonKey() final  double ratingSum;

/// Create a copy of MarketplaceProviderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceProviderModelCopyWith<_MarketplaceProviderModel> get copyWith => __$MarketplaceProviderModelCopyWithImpl<_MarketplaceProviderModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceProviderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.status, status) || other.status == status)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.vouchCount, vouchCount) || other.vouchCount == vouchCount)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isVerifiedOverride, isVerifiedOverride) || other.isVerifiedOverride == isVerifiedOverride)&&const DeepCollectionEquality().equals(other._customerIds, _customerIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._subCategories, _subCategories)&&(identical(other.sellerLevel, sellerLevel) || other.sellerLevel == sellerLevel)&&(identical(other.avgResponseTimeHrs, avgResponseTimeHrs) || other.avgResponseTimeHrs == avgResponseTimeHrs)&&(identical(other.warningCount, warningCount) || other.warningCount == warningCount)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.disputeRate, disputeRate) || other.disputeRate == disputeRate)&&(identical(other.cancellationRate, cancellationRate) || other.cancellationRate == cancellationRate)&&(identical(other.suspensionReason, suspensionReason) || other.suspensionReason == suspensionReason)&&(identical(other.suspensionTrigger, suspensionTrigger) || other.suspensionTrigger == suspensionTrigger)&&(identical(other.suspendedAt, suspendedAt) || other.suspendedAt == suspendedAt)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.profileLocation, profileLocation) || other.profileLocation == profileLocation)&&(identical(other.ratingSum, ratingSum) || other.ratingSum == ratingSum));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,displayName,bio,photoUrl,communityId,servicesDescription,status,trustScore,vouchCount,completedOrders,isVerified,isVerifiedOverride,const DeepCollectionEquality().hash(_customerIds),createdAt,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_subCategories),sellerLevel,avgResponseTimeHrs,warningCount,reportCount,disputeRate,cancellationRate,suspensionReason,suspensionTrigger,suspendedAt,bannedAt,profileLocation,ratingSum]);

@override
String toString() {
  return 'MarketplaceProviderModel(id: $id, userId: $userId, displayName: $displayName, bio: $bio, photoUrl: $photoUrl, communityId: $communityId, servicesDescription: $servicesDescription, status: $status, trustScore: $trustScore, vouchCount: $vouchCount, completedOrders: $completedOrders, isVerified: $isVerified, isVerifiedOverride: $isVerifiedOverride, customerIds: $customerIds, createdAt: $createdAt, categories: $categories, subCategories: $subCategories, sellerLevel: $sellerLevel, avgResponseTimeHrs: $avgResponseTimeHrs, warningCount: $warningCount, reportCount: $reportCount, disputeRate: $disputeRate, cancellationRate: $cancellationRate, suspensionReason: $suspensionReason, suspensionTrigger: $suspensionTrigger, suspendedAt: $suspendedAt, bannedAt: $bannedAt, profileLocation: $profileLocation, ratingSum: $ratingSum)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceProviderModelCopyWith<$Res> implements $MarketplaceProviderModelCopyWith<$Res> {
  factory _$MarketplaceProviderModelCopyWith(_MarketplaceProviderModel value, $Res Function(_MarketplaceProviderModel) _then) = __$MarketplaceProviderModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String displayName, String? bio, String? photoUrl, String? communityId, String? servicesDescription, ProviderStatus status, double trustScore, int vouchCount, int completedOrders, bool isVerified, bool? isVerifiedOverride, List<String> customerIds, DateTime createdAt, List<String> categories, List<String>? subCategories, SellerLevel sellerLevel, double? avgResponseTimeHrs, int warningCount, int reportCount, double disputeRate, double cancellationRate, String? suspensionReason, String? suspensionTrigger, DateTime? suspendedAt, DateTime? bannedAt, LocationData? profileLocation, double ratingSum
});


@override $LocationDataCopyWith<$Res>? get profileLocation;

}
/// @nodoc
class __$MarketplaceProviderModelCopyWithImpl<$Res>
    implements _$MarketplaceProviderModelCopyWith<$Res> {
  __$MarketplaceProviderModelCopyWithImpl(this._self, this._then);

  final _MarketplaceProviderModel _self;
  final $Res Function(_MarketplaceProviderModel) _then;

/// Create a copy of MarketplaceProviderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? bio = freezed,Object? photoUrl = freezed,Object? communityId = freezed,Object? servicesDescription = freezed,Object? status = null,Object? trustScore = null,Object? vouchCount = null,Object? completedOrders = null,Object? isVerified = null,Object? isVerifiedOverride = freezed,Object? customerIds = null,Object? createdAt = null,Object? categories = null,Object? subCategories = freezed,Object? sellerLevel = null,Object? avgResponseTimeHrs = freezed,Object? warningCount = null,Object? reportCount = null,Object? disputeRate = null,Object? cancellationRate = null,Object? suspensionReason = freezed,Object? suspensionTrigger = freezed,Object? suspendedAt = freezed,Object? bannedAt = freezed,Object? profileLocation = freezed,Object? ratingSum = null,}) {
  return _then(_MarketplaceProviderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,servicesDescription: freezed == servicesDescription ? _self.servicesDescription : servicesDescription // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProviderStatus,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,vouchCount: null == vouchCount ? _self.vouchCount : vouchCount // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,isVerifiedOverride: freezed == isVerifiedOverride ? _self.isVerifiedOverride : isVerifiedOverride // ignore: cast_nullable_to_non_nullable
as bool?,customerIds: null == customerIds ? _self._customerIds : customerIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,subCategories: freezed == subCategories ? _self._subCategories : subCategories // ignore: cast_nullable_to_non_nullable
as List<String>?,sellerLevel: null == sellerLevel ? _self.sellerLevel : sellerLevel // ignore: cast_nullable_to_non_nullable
as SellerLevel,avgResponseTimeHrs: freezed == avgResponseTimeHrs ? _self.avgResponseTimeHrs : avgResponseTimeHrs // ignore: cast_nullable_to_non_nullable
as double?,warningCount: null == warningCount ? _self.warningCount : warningCount // ignore: cast_nullable_to_non_nullable
as int,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,disputeRate: null == disputeRate ? _self.disputeRate : disputeRate // ignore: cast_nullable_to_non_nullable
as double,cancellationRate: null == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double,suspensionReason: freezed == suspensionReason ? _self.suspensionReason : suspensionReason // ignore: cast_nullable_to_non_nullable
as String?,suspensionTrigger: freezed == suspensionTrigger ? _self.suspensionTrigger : suspensionTrigger // ignore: cast_nullable_to_non_nullable
as String?,suspendedAt: freezed == suspendedAt ? _self.suspendedAt : suspendedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,profileLocation: freezed == profileLocation ? _self.profileLocation : profileLocation // ignore: cast_nullable_to_non_nullable
as LocationData?,ratingSum: null == ratingSum ? _self.ratingSum : ratingSum // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of MarketplaceProviderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res>? get profileLocation {
    if (_self.profileLocation == null) {
    return null;
  }

  return $LocationDataCopyWith<$Res>(_self.profileLocation!, (value) {
    return _then(_self.copyWith(profileLocation: value));
  });
}
}

// dart format on
