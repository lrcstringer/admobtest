// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupBuyModel {

 String get id; String get title; String get description; String? get linkedListingId; String? get organizerId; String? get organizerName; String? get communityId; int get targetAmount; int get currentAmount; int get minParticipants; int? get maxParticipants; DateTime get deadline; GroupBuyStatus get status; int get participantCount; String get sponsorType; String? get brandId; String? get brandName; String? get brandLogoUrl; int? get discountPercent; bool get createdByAdmin; GroupBuyType get type; GroupBuyFulfilmentType get fulfilmentType; List<String> get clusters; List<String> get addresses; List<String> get voucherCodes; String? get imageUrl; int? get originalPrice; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of GroupBuyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupBuyModelCopyWith<GroupBuyModel> get copyWith => _$GroupBuyModelCopyWithImpl<GroupBuyModel>(this as GroupBuyModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupBuyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.linkedListingId, linkedListingId) || other.linkedListingId == linkedListingId)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.sponsorType, sponsorType) || other.sponsorType == sponsorType)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.createdByAdmin, createdByAdmin) || other.createdByAdmin == createdByAdmin)&&(identical(other.type, type) || other.type == type)&&(identical(other.fulfilmentType, fulfilmentType) || other.fulfilmentType == fulfilmentType)&&const DeepCollectionEquality().equals(other.clusters, clusters)&&const DeepCollectionEquality().equals(other.addresses, addresses)&&const DeepCollectionEquality().equals(other.voucherCodes, voucherCodes)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,linkedListingId,organizerId,organizerName,communityId,targetAmount,currentAmount,minParticipants,maxParticipants,deadline,status,participantCount,sponsorType,brandId,brandName,brandLogoUrl,discountPercent,createdByAdmin,type,fulfilmentType,const DeepCollectionEquality().hash(clusters),const DeepCollectionEquality().hash(addresses),const DeepCollectionEquality().hash(voucherCodes),imageUrl,originalPrice,createdAt,updatedAt]);

@override
String toString() {
  return 'GroupBuyModel(id: $id, title: $title, description: $description, linkedListingId: $linkedListingId, organizerId: $organizerId, organizerName: $organizerName, communityId: $communityId, targetAmount: $targetAmount, currentAmount: $currentAmount, minParticipants: $minParticipants, maxParticipants: $maxParticipants, deadline: $deadline, status: $status, participantCount: $participantCount, sponsorType: $sponsorType, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, discountPercent: $discountPercent, createdByAdmin: $createdByAdmin, type: $type, fulfilmentType: $fulfilmentType, clusters: $clusters, addresses: $addresses, voucherCodes: $voucherCodes, imageUrl: $imageUrl, originalPrice: $originalPrice, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GroupBuyModelCopyWith<$Res>  {
  factory $GroupBuyModelCopyWith(GroupBuyModel value, $Res Function(GroupBuyModel) _then) = _$GroupBuyModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String? linkedListingId, String? organizerId, String? organizerName, String? communityId, int targetAmount, int currentAmount, int minParticipants, int? maxParticipants, DateTime deadline, GroupBuyStatus status, int participantCount, String sponsorType, String? brandId, String? brandName, String? brandLogoUrl, int? discountPercent, bool createdByAdmin, GroupBuyType type, GroupBuyFulfilmentType fulfilmentType, List<String> clusters, List<String> addresses, List<String> voucherCodes, String? imageUrl, int? originalPrice, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$GroupBuyModelCopyWithImpl<$Res>
    implements $GroupBuyModelCopyWith<$Res> {
  _$GroupBuyModelCopyWithImpl(this._self, this._then);

  final GroupBuyModel _self;
  final $Res Function(GroupBuyModel) _then;

/// Create a copy of GroupBuyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? linkedListingId = freezed,Object? organizerId = freezed,Object? organizerName = freezed,Object? communityId = freezed,Object? targetAmount = null,Object? currentAmount = null,Object? minParticipants = null,Object? maxParticipants = freezed,Object? deadline = null,Object? status = null,Object? participantCount = null,Object? sponsorType = null,Object? brandId = freezed,Object? brandName = freezed,Object? brandLogoUrl = freezed,Object? discountPercent = freezed,Object? createdByAdmin = null,Object? type = null,Object? fulfilmentType = null,Object? clusters = null,Object? addresses = null,Object? voucherCodes = null,Object? imageUrl = freezed,Object? originalPrice = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,linkedListingId: freezed == linkedListingId ? _self.linkedListingId : linkedListingId // ignore: cast_nullable_to_non_nullable
as String?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,organizerName: freezed == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,targetAmount: null == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as int,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupBuyStatus,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,sponsorType: null == sponsorType ? _self.sponsorType : sponsorType // ignore: cast_nullable_to_non_nullable
as String,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,createdByAdmin: null == createdByAdmin ? _self.createdByAdmin : createdByAdmin // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GroupBuyType,fulfilmentType: null == fulfilmentType ? _self.fulfilmentType : fulfilmentType // ignore: cast_nullable_to_non_nullable
as GroupBuyFulfilmentType,clusters: null == clusters ? _self.clusters : clusters // ignore: cast_nullable_to_non_nullable
as List<String>,addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>,voucherCodes: null == voucherCodes ? _self.voucherCodes : voucherCodes // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupBuyModel].
extension GroupBuyModelPatterns on GroupBuyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupBuyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupBuyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupBuyModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupBuyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupBuyModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupBuyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String? linkedListingId,  String? organizerId,  String? organizerName,  String? communityId,  int targetAmount,  int currentAmount,  int minParticipants,  int? maxParticipants,  DateTime deadline,  GroupBuyStatus status,  int participantCount,  String sponsorType,  String? brandId,  String? brandName,  String? brandLogoUrl,  int? discountPercent,  bool createdByAdmin,  GroupBuyType type,  GroupBuyFulfilmentType fulfilmentType,  List<String> clusters,  List<String> addresses,  List<String> voucherCodes,  String? imageUrl,  int? originalPrice,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupBuyModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.linkedListingId,_that.organizerId,_that.organizerName,_that.communityId,_that.targetAmount,_that.currentAmount,_that.minParticipants,_that.maxParticipants,_that.deadline,_that.status,_that.participantCount,_that.sponsorType,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.discountPercent,_that.createdByAdmin,_that.type,_that.fulfilmentType,_that.clusters,_that.addresses,_that.voucherCodes,_that.imageUrl,_that.originalPrice,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String? linkedListingId,  String? organizerId,  String? organizerName,  String? communityId,  int targetAmount,  int currentAmount,  int minParticipants,  int? maxParticipants,  DateTime deadline,  GroupBuyStatus status,  int participantCount,  String sponsorType,  String? brandId,  String? brandName,  String? brandLogoUrl,  int? discountPercent,  bool createdByAdmin,  GroupBuyType type,  GroupBuyFulfilmentType fulfilmentType,  List<String> clusters,  List<String> addresses,  List<String> voucherCodes,  String? imageUrl,  int? originalPrice,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupBuyModel():
return $default(_that.id,_that.title,_that.description,_that.linkedListingId,_that.organizerId,_that.organizerName,_that.communityId,_that.targetAmount,_that.currentAmount,_that.minParticipants,_that.maxParticipants,_that.deadline,_that.status,_that.participantCount,_that.sponsorType,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.discountPercent,_that.createdByAdmin,_that.type,_that.fulfilmentType,_that.clusters,_that.addresses,_that.voucherCodes,_that.imageUrl,_that.originalPrice,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String? linkedListingId,  String? organizerId,  String? organizerName,  String? communityId,  int targetAmount,  int currentAmount,  int minParticipants,  int? maxParticipants,  DateTime deadline,  GroupBuyStatus status,  int participantCount,  String sponsorType,  String? brandId,  String? brandName,  String? brandLogoUrl,  int? discountPercent,  bool createdByAdmin,  GroupBuyType type,  GroupBuyFulfilmentType fulfilmentType,  List<String> clusters,  List<String> addresses,  List<String> voucherCodes,  String? imageUrl,  int? originalPrice,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupBuyModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.linkedListingId,_that.organizerId,_that.organizerName,_that.communityId,_that.targetAmount,_that.currentAmount,_that.minParticipants,_that.maxParticipants,_that.deadline,_that.status,_that.participantCount,_that.sponsorType,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.discountPercent,_that.createdByAdmin,_that.type,_that.fulfilmentType,_that.clusters,_that.addresses,_that.voucherCodes,_that.imageUrl,_that.originalPrice,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _GroupBuyModel extends GroupBuyModel {
  const _GroupBuyModel({required this.id, required this.title, required this.description, this.linkedListingId, this.organizerId, this.organizerName, this.communityId, required this.targetAmount, this.currentAmount = 0, this.minParticipants = 1, this.maxParticipants, required this.deadline, required this.status, this.participantCount = 0, this.sponsorType = 'community', this.brandId, this.brandName, this.brandLogoUrl, this.discountPercent, this.createdByAdmin = false, this.type = GroupBuyType.digital, this.fulfilmentType = GroupBuyFulfilmentType.digital, final  List<String> clusters = const [], final  List<String> addresses = const [], final  List<String> voucherCodes = const [], this.imageUrl, this.originalPrice, required this.createdAt, this.updatedAt}): _clusters = clusters,_addresses = addresses,_voucherCodes = voucherCodes,super._();
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String? linkedListingId;
@override final  String? organizerId;
@override final  String? organizerName;
@override final  String? communityId;
@override final  int targetAmount;
@override@JsonKey() final  int currentAmount;
@override@JsonKey() final  int minParticipants;
@override final  int? maxParticipants;
@override final  DateTime deadline;
@override final  GroupBuyStatus status;
@override@JsonKey() final  int participantCount;
@override@JsonKey() final  String sponsorType;
@override final  String? brandId;
@override final  String? brandName;
@override final  String? brandLogoUrl;
@override final  int? discountPercent;
@override@JsonKey() final  bool createdByAdmin;
@override@JsonKey() final  GroupBuyType type;
@override@JsonKey() final  GroupBuyFulfilmentType fulfilmentType;
 final  List<String> _clusters;
@override@JsonKey() List<String> get clusters {
  if (_clusters is EqualUnmodifiableListView) return _clusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clusters);
}

 final  List<String> _addresses;
@override@JsonKey() List<String> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

 final  List<String> _voucherCodes;
@override@JsonKey() List<String> get voucherCodes {
  if (_voucherCodes is EqualUnmodifiableListView) return _voucherCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_voucherCodes);
}

@override final  String? imageUrl;
@override final  int? originalPrice;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of GroupBuyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupBuyModelCopyWith<_GroupBuyModel> get copyWith => __$GroupBuyModelCopyWithImpl<_GroupBuyModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupBuyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.linkedListingId, linkedListingId) || other.linkedListingId == linkedListingId)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.sponsorType, sponsorType) || other.sponsorType == sponsorType)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.createdByAdmin, createdByAdmin) || other.createdByAdmin == createdByAdmin)&&(identical(other.type, type) || other.type == type)&&(identical(other.fulfilmentType, fulfilmentType) || other.fulfilmentType == fulfilmentType)&&const DeepCollectionEquality().equals(other._clusters, _clusters)&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&const DeepCollectionEquality().equals(other._voucherCodes, _voucherCodes)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,linkedListingId,organizerId,organizerName,communityId,targetAmount,currentAmount,minParticipants,maxParticipants,deadline,status,participantCount,sponsorType,brandId,brandName,brandLogoUrl,discountPercent,createdByAdmin,type,fulfilmentType,const DeepCollectionEquality().hash(_clusters),const DeepCollectionEquality().hash(_addresses),const DeepCollectionEquality().hash(_voucherCodes),imageUrl,originalPrice,createdAt,updatedAt]);

@override
String toString() {
  return 'GroupBuyModel(id: $id, title: $title, description: $description, linkedListingId: $linkedListingId, organizerId: $organizerId, organizerName: $organizerName, communityId: $communityId, targetAmount: $targetAmount, currentAmount: $currentAmount, minParticipants: $minParticipants, maxParticipants: $maxParticipants, deadline: $deadline, status: $status, participantCount: $participantCount, sponsorType: $sponsorType, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, discountPercent: $discountPercent, createdByAdmin: $createdByAdmin, type: $type, fulfilmentType: $fulfilmentType, clusters: $clusters, addresses: $addresses, voucherCodes: $voucherCodes, imageUrl: $imageUrl, originalPrice: $originalPrice, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupBuyModelCopyWith<$Res> implements $GroupBuyModelCopyWith<$Res> {
  factory _$GroupBuyModelCopyWith(_GroupBuyModel value, $Res Function(_GroupBuyModel) _then) = __$GroupBuyModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String? linkedListingId, String? organizerId, String? organizerName, String? communityId, int targetAmount, int currentAmount, int minParticipants, int? maxParticipants, DateTime deadline, GroupBuyStatus status, int participantCount, String sponsorType, String? brandId, String? brandName, String? brandLogoUrl, int? discountPercent, bool createdByAdmin, GroupBuyType type, GroupBuyFulfilmentType fulfilmentType, List<String> clusters, List<String> addresses, List<String> voucherCodes, String? imageUrl, int? originalPrice, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$GroupBuyModelCopyWithImpl<$Res>
    implements _$GroupBuyModelCopyWith<$Res> {
  __$GroupBuyModelCopyWithImpl(this._self, this._then);

  final _GroupBuyModel _self;
  final $Res Function(_GroupBuyModel) _then;

/// Create a copy of GroupBuyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? linkedListingId = freezed,Object? organizerId = freezed,Object? organizerName = freezed,Object? communityId = freezed,Object? targetAmount = null,Object? currentAmount = null,Object? minParticipants = null,Object? maxParticipants = freezed,Object? deadline = null,Object? status = null,Object? participantCount = null,Object? sponsorType = null,Object? brandId = freezed,Object? brandName = freezed,Object? brandLogoUrl = freezed,Object? discountPercent = freezed,Object? createdByAdmin = null,Object? type = null,Object? fulfilmentType = null,Object? clusters = null,Object? addresses = null,Object? voucherCodes = null,Object? imageUrl = freezed,Object? originalPrice = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_GroupBuyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,linkedListingId: freezed == linkedListingId ? _self.linkedListingId : linkedListingId // ignore: cast_nullable_to_non_nullable
as String?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,organizerName: freezed == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,targetAmount: null == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as int,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupBuyStatus,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,sponsorType: null == sponsorType ? _self.sponsorType : sponsorType // ignore: cast_nullable_to_non_nullable
as String,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,createdByAdmin: null == createdByAdmin ? _self.createdByAdmin : createdByAdmin // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GroupBuyType,fulfilmentType: null == fulfilmentType ? _self.fulfilmentType : fulfilmentType // ignore: cast_nullable_to_non_nullable
as GroupBuyFulfilmentType,clusters: null == clusters ? _self._clusters : clusters // ignore: cast_nullable_to_non_nullable
as List<String>,addresses: null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>,voucherCodes: null == voucherCodes ? _self._voucherCodes : voucherCodes // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
