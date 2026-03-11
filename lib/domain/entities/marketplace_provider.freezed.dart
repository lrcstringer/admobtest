// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketplaceProvider {

 String get id; String get userId; String get displayName; String? get bio; String? get photoUrl; String? get communityId; String? get servicesDescription; ProviderStatus get status; double get trustScore; int get vouchCount; int get completedOrders; bool get isVerified; bool? get isVerifiedOverride; List<String> get customerIds; DateTime get createdAt;
/// Create a copy of MarketplaceProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceProviderCopyWith<MarketplaceProvider> get copyWith => _$MarketplaceProviderCopyWithImpl<MarketplaceProvider>(this as MarketplaceProvider, _$identity);

  /// Serializes this MarketplaceProvider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.status, status) || other.status == status)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.vouchCount, vouchCount) || other.vouchCount == vouchCount)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isVerifiedOverride, isVerifiedOverride) || other.isVerifiedOverride == isVerifiedOverride)&&const DeepCollectionEquality().equals(other.customerIds, customerIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,displayName,bio,photoUrl,communityId,servicesDescription,status,trustScore,vouchCount,completedOrders,isVerified,isVerifiedOverride,const DeepCollectionEquality().hash(customerIds),createdAt);

@override
String toString() {
  return 'MarketplaceProvider(id: $id, userId: $userId, displayName: $displayName, bio: $bio, photoUrl: $photoUrl, communityId: $communityId, servicesDescription: $servicesDescription, status: $status, trustScore: $trustScore, vouchCount: $vouchCount, completedOrders: $completedOrders, isVerified: $isVerified, isVerifiedOverride: $isVerifiedOverride, customerIds: $customerIds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MarketplaceProviderCopyWith<$Res>  {
  factory $MarketplaceProviderCopyWith(MarketplaceProvider value, $Res Function(MarketplaceProvider) _then) = _$MarketplaceProviderCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String displayName, String? bio, String? photoUrl, String? communityId, String? servicesDescription, ProviderStatus status, double trustScore, int vouchCount, int completedOrders, bool isVerified, bool? isVerifiedOverride, List<String> customerIds, DateTime createdAt
});




}
/// @nodoc
class _$MarketplaceProviderCopyWithImpl<$Res>
    implements $MarketplaceProviderCopyWith<$Res> {
  _$MarketplaceProviderCopyWithImpl(this._self, this._then);

  final MarketplaceProvider _self;
  final $Res Function(MarketplaceProvider) _then;

/// Create a copy of MarketplaceProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? bio = freezed,Object? photoUrl = freezed,Object? communityId = freezed,Object? servicesDescription = freezed,Object? status = null,Object? trustScore = null,Object? vouchCount = null,Object? completedOrders = null,Object? isVerified = null,Object? isVerifiedOverride = freezed,Object? customerIds = null,Object? createdAt = null,}) {
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
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketplaceProvider].
extension MarketplaceProviderPatterns on MarketplaceProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceProvider value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceProvider value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? bio,  String? photoUrl,  String? communityId,  String? servicesDescription,  ProviderStatus status,  double trustScore,  int vouchCount,  int completedOrders,  bool isVerified,  bool? isVerifiedOverride,  List<String> customerIds,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceProvider() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.photoUrl,_that.communityId,_that.servicesDescription,_that.status,_that.trustScore,_that.vouchCount,_that.completedOrders,_that.isVerified,_that.isVerifiedOverride,_that.customerIds,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? bio,  String? photoUrl,  String? communityId,  String? servicesDescription,  ProviderStatus status,  double trustScore,  int vouchCount,  int completedOrders,  bool isVerified,  bool? isVerifiedOverride,  List<String> customerIds,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceProvider():
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.photoUrl,_that.communityId,_that.servicesDescription,_that.status,_that.trustScore,_that.vouchCount,_that.completedOrders,_that.isVerified,_that.isVerifiedOverride,_that.customerIds,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String displayName,  String? bio,  String? photoUrl,  String? communityId,  String? servicesDescription,  ProviderStatus status,  double trustScore,  int vouchCount,  int completedOrders,  bool isVerified,  bool? isVerifiedOverride,  List<String> customerIds,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceProvider() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.photoUrl,_that.communityId,_that.servicesDescription,_that.status,_that.trustScore,_that.vouchCount,_that.completedOrders,_that.isVerified,_that.isVerifiedOverride,_that.customerIds,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketplaceProvider extends MarketplaceProvider {
  const _MarketplaceProvider({required this.id, required this.userId, required this.displayName, this.bio, this.photoUrl, this.communityId, this.servicesDescription, required this.status, this.trustScore = 0.0, this.vouchCount = 0, this.completedOrders = 0, this.isVerified = false, this.isVerifiedOverride, final  List<String> customerIds = const [], required this.createdAt}): _customerIds = customerIds,super._();
  factory _MarketplaceProvider.fromJson(Map<String, dynamic> json) => _$MarketplaceProviderFromJson(json);

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

/// Create a copy of MarketplaceProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceProviderCopyWith<_MarketplaceProvider> get copyWith => __$MarketplaceProviderCopyWithImpl<_MarketplaceProvider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketplaceProviderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.servicesDescription, servicesDescription) || other.servicesDescription == servicesDescription)&&(identical(other.status, status) || other.status == status)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.vouchCount, vouchCount) || other.vouchCount == vouchCount)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isVerifiedOverride, isVerifiedOverride) || other.isVerifiedOverride == isVerifiedOverride)&&const DeepCollectionEquality().equals(other._customerIds, _customerIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,displayName,bio,photoUrl,communityId,servicesDescription,status,trustScore,vouchCount,completedOrders,isVerified,isVerifiedOverride,const DeepCollectionEquality().hash(_customerIds),createdAt);

@override
String toString() {
  return 'MarketplaceProvider(id: $id, userId: $userId, displayName: $displayName, bio: $bio, photoUrl: $photoUrl, communityId: $communityId, servicesDescription: $servicesDescription, status: $status, trustScore: $trustScore, vouchCount: $vouchCount, completedOrders: $completedOrders, isVerified: $isVerified, isVerifiedOverride: $isVerifiedOverride, customerIds: $customerIds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceProviderCopyWith<$Res> implements $MarketplaceProviderCopyWith<$Res> {
  factory _$MarketplaceProviderCopyWith(_MarketplaceProvider value, $Res Function(_MarketplaceProvider) _then) = __$MarketplaceProviderCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String displayName, String? bio, String? photoUrl, String? communityId, String? servicesDescription, ProviderStatus status, double trustScore, int vouchCount, int completedOrders, bool isVerified, bool? isVerifiedOverride, List<String> customerIds, DateTime createdAt
});




}
/// @nodoc
class __$MarketplaceProviderCopyWithImpl<$Res>
    implements _$MarketplaceProviderCopyWith<$Res> {
  __$MarketplaceProviderCopyWithImpl(this._self, this._then);

  final _MarketplaceProvider _self;
  final $Res Function(_MarketplaceProvider) _then;

/// Create a copy of MarketplaceProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? bio = freezed,Object? photoUrl = freezed,Object? communityId = freezed,Object? servicesDescription = freezed,Object? status = null,Object? trustScore = null,Object? vouchCount = null,Object? completedOrders = null,Object? isVerified = null,Object? isVerifiedOverride = freezed,Object? customerIds = null,Object? createdAt = null,}) {
  return _then(_MarketplaceProvider(
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
as DateTime,
  ));
}


}

// dart format on
