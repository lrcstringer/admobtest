// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_campaign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardCampaignModel {

 String get id; String get clientId; String? get clientName; String? get clientAvatarImage; String? get clientAvatarColor; String get name; String? get description; String get rewardType; String get status; int get totalQuantity; int get remainingQuantity; int get allocatedQuantity; int get redeemedQuantity; int get maxPerUser; DateTime get startsAt; DateTime get endsAt; DateTime? get itemExpiresAt; String? get displayImageUrl; int get displayPriority; Map<String, dynamic> get metadata; List<String> get linkedOpportunityIds; DateTime get createdAt;
/// Create a copy of RewardCampaignModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardCampaignModelCopyWith<RewardCampaignModel> get copyWith => _$RewardCampaignModelCopyWithImpl<RewardCampaignModel>(this as RewardCampaignModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardCampaignModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&(identical(other.allocatedQuantity, allocatedQuantity) || other.allocatedQuantity == allocatedQuantity)&&(identical(other.redeemedQuantity, redeemedQuantity) || other.redeemedQuantity == redeemedQuantity)&&(identical(other.maxPerUser, maxPerUser) || other.maxPerUser == maxPerUser)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.itemExpiresAt, itemExpiresAt) || other.itemExpiresAt == itemExpiresAt)&&(identical(other.displayImageUrl, displayImageUrl) || other.displayImageUrl == displayImageUrl)&&(identical(other.displayPriority, displayPriority) || other.displayPriority == displayPriority)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.linkedOpportunityIds, linkedOpportunityIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,clientName,clientAvatarImage,clientAvatarColor,name,description,rewardType,status,totalQuantity,remainingQuantity,allocatedQuantity,redeemedQuantity,maxPerUser,startsAt,endsAt,itemExpiresAt,displayImageUrl,displayPriority,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(linkedOpportunityIds),createdAt]);

@override
String toString() {
  return 'RewardCampaignModel(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, name: $name, description: $description, rewardType: $rewardType, status: $status, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, allocatedQuantity: $allocatedQuantity, redeemedQuantity: $redeemedQuantity, maxPerUser: $maxPerUser, startsAt: $startsAt, endsAt: $endsAt, itemExpiresAt: $itemExpiresAt, displayImageUrl: $displayImageUrl, displayPriority: $displayPriority, metadata: $metadata, linkedOpportunityIds: $linkedOpportunityIds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RewardCampaignModelCopyWith<$Res>  {
  factory $RewardCampaignModelCopyWith(RewardCampaignModel value, $Res Function(RewardCampaignModel) _then) = _$RewardCampaignModelCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String? clientName, String? clientAvatarImage, String? clientAvatarColor, String name, String? description, String rewardType, String status, int totalQuantity, int remainingQuantity, int allocatedQuantity, int redeemedQuantity, int maxPerUser, DateTime startsAt, DateTime endsAt, DateTime? itemExpiresAt, String? displayImageUrl, int displayPriority, Map<String, dynamic> metadata, List<String> linkedOpportunityIds, DateTime createdAt
});




}
/// @nodoc
class _$RewardCampaignModelCopyWithImpl<$Res>
    implements $RewardCampaignModelCopyWith<$Res> {
  _$RewardCampaignModelCopyWithImpl(this._self, this._then);

  final RewardCampaignModel _self;
  final $Res Function(RewardCampaignModel) _then;

/// Create a copy of RewardCampaignModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? clientName = freezed,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? name = null,Object? description = freezed,Object? rewardType = null,Object? status = null,Object? totalQuantity = null,Object? remainingQuantity = null,Object? allocatedQuantity = null,Object? redeemedQuantity = null,Object? maxPerUser = null,Object? startsAt = null,Object? endsAt = null,Object? itemExpiresAt = freezed,Object? displayImageUrl = freezed,Object? displayPriority = null,Object? metadata = null,Object? linkedOpportunityIds = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,remainingQuantity: null == remainingQuantity ? _self.remainingQuantity : remainingQuantity // ignore: cast_nullable_to_non_nullable
as int,allocatedQuantity: null == allocatedQuantity ? _self.allocatedQuantity : allocatedQuantity // ignore: cast_nullable_to_non_nullable
as int,redeemedQuantity: null == redeemedQuantity ? _self.redeemedQuantity : redeemedQuantity // ignore: cast_nullable_to_non_nullable
as int,maxPerUser: null == maxPerUser ? _self.maxPerUser : maxPerUser // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,itemExpiresAt: freezed == itemExpiresAt ? _self.itemExpiresAt : itemExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayImageUrl: freezed == displayImageUrl ? _self.displayImageUrl : displayImageUrl // ignore: cast_nullable_to_non_nullable
as String?,displayPriority: null == displayPriority ? _self.displayPriority : displayPriority // ignore: cast_nullable_to_non_nullable
as int,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,linkedOpportunityIds: null == linkedOpportunityIds ? _self.linkedOpportunityIds : linkedOpportunityIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardCampaignModel].
extension RewardCampaignModelPatterns on RewardCampaignModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardCampaignModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardCampaignModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardCampaignModel value)  $default,){
final _that = this;
switch (_that) {
case _RewardCampaignModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardCampaignModel value)?  $default,){
final _that = this;
switch (_that) {
case _RewardCampaignModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String? clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String name,  String? description,  String rewardType,  String status,  int totalQuantity,  int remainingQuantity,  int allocatedQuantity,  int redeemedQuantity,  int maxPerUser,  DateTime startsAt,  DateTime endsAt,  DateTime? itemExpiresAt,  String? displayImageUrl,  int displayPriority,  Map<String, dynamic> metadata,  List<String> linkedOpportunityIds,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardCampaignModel() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.name,_that.description,_that.rewardType,_that.status,_that.totalQuantity,_that.remainingQuantity,_that.allocatedQuantity,_that.redeemedQuantity,_that.maxPerUser,_that.startsAt,_that.endsAt,_that.itemExpiresAt,_that.displayImageUrl,_that.displayPriority,_that.metadata,_that.linkedOpportunityIds,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String? clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String name,  String? description,  String rewardType,  String status,  int totalQuantity,  int remainingQuantity,  int allocatedQuantity,  int redeemedQuantity,  int maxPerUser,  DateTime startsAt,  DateTime endsAt,  DateTime? itemExpiresAt,  String? displayImageUrl,  int displayPriority,  Map<String, dynamic> metadata,  List<String> linkedOpportunityIds,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RewardCampaignModel():
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.name,_that.description,_that.rewardType,_that.status,_that.totalQuantity,_that.remainingQuantity,_that.allocatedQuantity,_that.redeemedQuantity,_that.maxPerUser,_that.startsAt,_that.endsAt,_that.itemExpiresAt,_that.displayImageUrl,_that.displayPriority,_that.metadata,_that.linkedOpportunityIds,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String? clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String name,  String? description,  String rewardType,  String status,  int totalQuantity,  int remainingQuantity,  int allocatedQuantity,  int redeemedQuantity,  int maxPerUser,  DateTime startsAt,  DateTime endsAt,  DateTime? itemExpiresAt,  String? displayImageUrl,  int displayPriority,  Map<String, dynamic> metadata,  List<String> linkedOpportunityIds,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RewardCampaignModel() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.name,_that.description,_that.rewardType,_that.status,_that.totalQuantity,_that.remainingQuantity,_that.allocatedQuantity,_that.redeemedQuantity,_that.maxPerUser,_that.startsAt,_that.endsAt,_that.itemExpiresAt,_that.displayImageUrl,_that.displayPriority,_that.metadata,_that.linkedOpportunityIds,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _RewardCampaignModel extends RewardCampaignModel {
  const _RewardCampaignModel({required this.id, required this.clientId, this.clientName, this.clientAvatarImage, this.clientAvatarColor, required this.name, this.description, required this.rewardType, required this.status, required this.totalQuantity, required this.remainingQuantity, this.allocatedQuantity = 0, this.redeemedQuantity = 0, this.maxPerUser = 1, required this.startsAt, required this.endsAt, this.itemExpiresAt, this.displayImageUrl, this.displayPriority = 0, final  Map<String, dynamic> metadata = const {}, final  List<String> linkedOpportunityIds = const [], required this.createdAt}): _metadata = metadata,_linkedOpportunityIds = linkedOpportunityIds,super._();
  

@override final  String id;
@override final  String clientId;
@override final  String? clientName;
@override final  String? clientAvatarImage;
@override final  String? clientAvatarColor;
@override final  String name;
@override final  String? description;
@override final  String rewardType;
@override final  String status;
@override final  int totalQuantity;
@override final  int remainingQuantity;
@override@JsonKey() final  int allocatedQuantity;
@override@JsonKey() final  int redeemedQuantity;
@override@JsonKey() final  int maxPerUser;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  DateTime? itemExpiresAt;
@override final  String? displayImageUrl;
@override@JsonKey() final  int displayPriority;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

 final  List<String> _linkedOpportunityIds;
@override@JsonKey() List<String> get linkedOpportunityIds {
  if (_linkedOpportunityIds is EqualUnmodifiableListView) return _linkedOpportunityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_linkedOpportunityIds);
}

@override final  DateTime createdAt;

/// Create a copy of RewardCampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardCampaignModelCopyWith<_RewardCampaignModel> get copyWith => __$RewardCampaignModelCopyWithImpl<_RewardCampaignModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardCampaignModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&(identical(other.allocatedQuantity, allocatedQuantity) || other.allocatedQuantity == allocatedQuantity)&&(identical(other.redeemedQuantity, redeemedQuantity) || other.redeemedQuantity == redeemedQuantity)&&(identical(other.maxPerUser, maxPerUser) || other.maxPerUser == maxPerUser)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.itemExpiresAt, itemExpiresAt) || other.itemExpiresAt == itemExpiresAt)&&(identical(other.displayImageUrl, displayImageUrl) || other.displayImageUrl == displayImageUrl)&&(identical(other.displayPriority, displayPriority) || other.displayPriority == displayPriority)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._linkedOpportunityIds, _linkedOpportunityIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,clientName,clientAvatarImage,clientAvatarColor,name,description,rewardType,status,totalQuantity,remainingQuantity,allocatedQuantity,redeemedQuantity,maxPerUser,startsAt,endsAt,itemExpiresAt,displayImageUrl,displayPriority,const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_linkedOpportunityIds),createdAt]);

@override
String toString() {
  return 'RewardCampaignModel(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, name: $name, description: $description, rewardType: $rewardType, status: $status, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, allocatedQuantity: $allocatedQuantity, redeemedQuantity: $redeemedQuantity, maxPerUser: $maxPerUser, startsAt: $startsAt, endsAt: $endsAt, itemExpiresAt: $itemExpiresAt, displayImageUrl: $displayImageUrl, displayPriority: $displayPriority, metadata: $metadata, linkedOpportunityIds: $linkedOpportunityIds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RewardCampaignModelCopyWith<$Res> implements $RewardCampaignModelCopyWith<$Res> {
  factory _$RewardCampaignModelCopyWith(_RewardCampaignModel value, $Res Function(_RewardCampaignModel) _then) = __$RewardCampaignModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String? clientName, String? clientAvatarImage, String? clientAvatarColor, String name, String? description, String rewardType, String status, int totalQuantity, int remainingQuantity, int allocatedQuantity, int redeemedQuantity, int maxPerUser, DateTime startsAt, DateTime endsAt, DateTime? itemExpiresAt, String? displayImageUrl, int displayPriority, Map<String, dynamic> metadata, List<String> linkedOpportunityIds, DateTime createdAt
});




}
/// @nodoc
class __$RewardCampaignModelCopyWithImpl<$Res>
    implements _$RewardCampaignModelCopyWith<$Res> {
  __$RewardCampaignModelCopyWithImpl(this._self, this._then);

  final _RewardCampaignModel _self;
  final $Res Function(_RewardCampaignModel) _then;

/// Create a copy of RewardCampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? clientName = freezed,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? name = null,Object? description = freezed,Object? rewardType = null,Object? status = null,Object? totalQuantity = null,Object? remainingQuantity = null,Object? allocatedQuantity = null,Object? redeemedQuantity = null,Object? maxPerUser = null,Object? startsAt = null,Object? endsAt = null,Object? itemExpiresAt = freezed,Object? displayImageUrl = freezed,Object? displayPriority = null,Object? metadata = null,Object? linkedOpportunityIds = null,Object? createdAt = null,}) {
  return _then(_RewardCampaignModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,remainingQuantity: null == remainingQuantity ? _self.remainingQuantity : remainingQuantity // ignore: cast_nullable_to_non_nullable
as int,allocatedQuantity: null == allocatedQuantity ? _self.allocatedQuantity : allocatedQuantity // ignore: cast_nullable_to_non_nullable
as int,redeemedQuantity: null == redeemedQuantity ? _self.redeemedQuantity : redeemedQuantity // ignore: cast_nullable_to_non_nullable
as int,maxPerUser: null == maxPerUser ? _self.maxPerUser : maxPerUser // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,itemExpiresAt: freezed == itemExpiresAt ? _self.itemExpiresAt : itemExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayImageUrl: freezed == displayImageUrl ? _self.displayImageUrl : displayImageUrl // ignore: cast_nullable_to_non_nullable
as String?,displayPriority: null == displayPriority ? _self.displayPriority : displayPriority // ignore: cast_nullable_to_non_nullable
as int,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,linkedOpportunityIds: null == linkedOpportunityIds ? _self._linkedOpportunityIds : linkedOpportunityIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
