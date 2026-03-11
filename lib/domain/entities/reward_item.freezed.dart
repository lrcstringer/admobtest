// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardItem {

 String get id; String get campaignId;// Denormalized campaign info (for list display without extra reads)
 String? get campaignName; String? get clientName; String? get clientAvatarImage; String? get clientAvatarColor; RewardType? get rewardType; RewardItemStatus get status;// Only populated on detail fetch (decrypted server-side)
 String? get codeValue; DateTime? get allocatedAt; DateTime? get redeemedAt; DateTime? get expiresAt; String? get redemptionLocation;// Campaign-level metadata (instructions, terms, etc.)
 Map<String, dynamic> get campaignMetadata;// Item-level metadata (batch, face value, etc.)
 Map<String, dynamic> get itemMetadata;
/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardItemCopyWith<RewardItem> get copyWith => _$RewardItemCopyWithImpl<RewardItem>(this as RewardItem, _$identity);

  /// Serializes this RewardItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardItem&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.status, status) || other.status == status)&&(identical(other.codeValue, codeValue) || other.codeValue == codeValue)&&(identical(other.allocatedAt, allocatedAt) || other.allocatedAt == allocatedAt)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.redemptionLocation, redemptionLocation) || other.redemptionLocation == redemptionLocation)&&const DeepCollectionEquality().equals(other.campaignMetadata, campaignMetadata)&&const DeepCollectionEquality().equals(other.itemMetadata, itemMetadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,clientName,clientAvatarImage,clientAvatarColor,rewardType,status,codeValue,allocatedAt,redeemedAt,expiresAt,redemptionLocation,const DeepCollectionEquality().hash(campaignMetadata),const DeepCollectionEquality().hash(itemMetadata));

@override
String toString() {
  return 'RewardItem(id: $id, campaignId: $campaignId, campaignName: $campaignName, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, rewardType: $rewardType, status: $status, codeValue: $codeValue, allocatedAt: $allocatedAt, redeemedAt: $redeemedAt, expiresAt: $expiresAt, redemptionLocation: $redemptionLocation, campaignMetadata: $campaignMetadata, itemMetadata: $itemMetadata)';
}


}

/// @nodoc
abstract mixin class $RewardItemCopyWith<$Res>  {
  factory $RewardItemCopyWith(RewardItem value, $Res Function(RewardItem) _then) = _$RewardItemCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String? campaignName, String? clientName, String? clientAvatarImage, String? clientAvatarColor, RewardType? rewardType, RewardItemStatus status, String? codeValue, DateTime? allocatedAt, DateTime? redeemedAt, DateTime? expiresAt, String? redemptionLocation, Map<String, dynamic> campaignMetadata, Map<String, dynamic> itemMetadata
});




}
/// @nodoc
class _$RewardItemCopyWithImpl<$Res>
    implements $RewardItemCopyWith<$Res> {
  _$RewardItemCopyWithImpl(this._self, this._then);

  final RewardItem _self;
  final $Res Function(RewardItem) _then;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = freezed,Object? clientName = freezed,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? rewardType = freezed,Object? status = null,Object? codeValue = freezed,Object? allocatedAt = freezed,Object? redeemedAt = freezed,Object? expiresAt = freezed,Object? redemptionLocation = freezed,Object? campaignMetadata = null,Object? itemMetadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: freezed == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RewardItemStatus,codeValue: freezed == codeValue ? _self.codeValue : codeValue // ignore: cast_nullable_to_non_nullable
as String?,allocatedAt: freezed == allocatedAt ? _self.allocatedAt : allocatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redemptionLocation: freezed == redemptionLocation ? _self.redemptionLocation : redemptionLocation // ignore: cast_nullable_to_non_nullable
as String?,campaignMetadata: null == campaignMetadata ? _self.campaignMetadata : campaignMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,itemMetadata: null == itemMetadata ? _self.itemMetadata : itemMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardItem].
extension RewardItemPatterns on RewardItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardItem value)  $default,){
final _that = this;
switch (_that) {
case _RewardItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardItem value)?  $default,){
final _that = this;
switch (_that) {
case _RewardItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String? campaignName,  String? clientName,  String? clientAvatarImage,  String? clientAvatarColor,  RewardType? rewardType,  RewardItemStatus status,  String? codeValue,  DateTime? allocatedAt,  DateTime? redeemedAt,  DateTime? expiresAt,  String? redemptionLocation,  Map<String, dynamic> campaignMetadata,  Map<String, dynamic> itemMetadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardItem() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.rewardType,_that.status,_that.codeValue,_that.allocatedAt,_that.redeemedAt,_that.expiresAt,_that.redemptionLocation,_that.campaignMetadata,_that.itemMetadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String? campaignName,  String? clientName,  String? clientAvatarImage,  String? clientAvatarColor,  RewardType? rewardType,  RewardItemStatus status,  String? codeValue,  DateTime? allocatedAt,  DateTime? redeemedAt,  DateTime? expiresAt,  String? redemptionLocation,  Map<String, dynamic> campaignMetadata,  Map<String, dynamic> itemMetadata)  $default,) {final _that = this;
switch (_that) {
case _RewardItem():
return $default(_that.id,_that.campaignId,_that.campaignName,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.rewardType,_that.status,_that.codeValue,_that.allocatedAt,_that.redeemedAt,_that.expiresAt,_that.redemptionLocation,_that.campaignMetadata,_that.itemMetadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String? campaignName,  String? clientName,  String? clientAvatarImage,  String? clientAvatarColor,  RewardType? rewardType,  RewardItemStatus status,  String? codeValue,  DateTime? allocatedAt,  DateTime? redeemedAt,  DateTime? expiresAt,  String? redemptionLocation,  Map<String, dynamic> campaignMetadata,  Map<String, dynamic> itemMetadata)?  $default,) {final _that = this;
switch (_that) {
case _RewardItem() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.rewardType,_that.status,_that.codeValue,_that.allocatedAt,_that.redeemedAt,_that.expiresAt,_that.redemptionLocation,_that.campaignMetadata,_that.itemMetadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardItem extends RewardItem {
  const _RewardItem({required this.id, required this.campaignId, this.campaignName, this.clientName, this.clientAvatarImage, this.clientAvatarColor, this.rewardType, required this.status, this.codeValue, this.allocatedAt, this.redeemedAt, this.expiresAt, this.redemptionLocation, final  Map<String, dynamic> campaignMetadata = const {}, final  Map<String, dynamic> itemMetadata = const {}}): _campaignMetadata = campaignMetadata,_itemMetadata = itemMetadata,super._();
  factory _RewardItem.fromJson(Map<String, dynamic> json) => _$RewardItemFromJson(json);

@override final  String id;
@override final  String campaignId;
// Denormalized campaign info (for list display without extra reads)
@override final  String? campaignName;
@override final  String? clientName;
@override final  String? clientAvatarImage;
@override final  String? clientAvatarColor;
@override final  RewardType? rewardType;
@override final  RewardItemStatus status;
// Only populated on detail fetch (decrypted server-side)
@override final  String? codeValue;
@override final  DateTime? allocatedAt;
@override final  DateTime? redeemedAt;
@override final  DateTime? expiresAt;
@override final  String? redemptionLocation;
// Campaign-level metadata (instructions, terms, etc.)
 final  Map<String, dynamic> _campaignMetadata;
// Campaign-level metadata (instructions, terms, etc.)
@override@JsonKey() Map<String, dynamic> get campaignMetadata {
  if (_campaignMetadata is EqualUnmodifiableMapView) return _campaignMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_campaignMetadata);
}

// Item-level metadata (batch, face value, etc.)
 final  Map<String, dynamic> _itemMetadata;
// Item-level metadata (batch, face value, etc.)
@override@JsonKey() Map<String, dynamic> get itemMetadata {
  if (_itemMetadata is EqualUnmodifiableMapView) return _itemMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_itemMetadata);
}


/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardItemCopyWith<_RewardItem> get copyWith => __$RewardItemCopyWithImpl<_RewardItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardItem&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.status, status) || other.status == status)&&(identical(other.codeValue, codeValue) || other.codeValue == codeValue)&&(identical(other.allocatedAt, allocatedAt) || other.allocatedAt == allocatedAt)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.redemptionLocation, redemptionLocation) || other.redemptionLocation == redemptionLocation)&&const DeepCollectionEquality().equals(other._campaignMetadata, _campaignMetadata)&&const DeepCollectionEquality().equals(other._itemMetadata, _itemMetadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,clientName,clientAvatarImage,clientAvatarColor,rewardType,status,codeValue,allocatedAt,redeemedAt,expiresAt,redemptionLocation,const DeepCollectionEquality().hash(_campaignMetadata),const DeepCollectionEquality().hash(_itemMetadata));

@override
String toString() {
  return 'RewardItem(id: $id, campaignId: $campaignId, campaignName: $campaignName, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, rewardType: $rewardType, status: $status, codeValue: $codeValue, allocatedAt: $allocatedAt, redeemedAt: $redeemedAt, expiresAt: $expiresAt, redemptionLocation: $redemptionLocation, campaignMetadata: $campaignMetadata, itemMetadata: $itemMetadata)';
}


}

/// @nodoc
abstract mixin class _$RewardItemCopyWith<$Res> implements $RewardItemCopyWith<$Res> {
  factory _$RewardItemCopyWith(_RewardItem value, $Res Function(_RewardItem) _then) = __$RewardItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String? campaignName, String? clientName, String? clientAvatarImage, String? clientAvatarColor, RewardType? rewardType, RewardItemStatus status, String? codeValue, DateTime? allocatedAt, DateTime? redeemedAt, DateTime? expiresAt, String? redemptionLocation, Map<String, dynamic> campaignMetadata, Map<String, dynamic> itemMetadata
});




}
/// @nodoc
class __$RewardItemCopyWithImpl<$Res>
    implements _$RewardItemCopyWith<$Res> {
  __$RewardItemCopyWithImpl(this._self, this._then);

  final _RewardItem _self;
  final $Res Function(_RewardItem) _then;

/// Create a copy of RewardItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = freezed,Object? clientName = freezed,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? rewardType = freezed,Object? status = null,Object? codeValue = freezed,Object? allocatedAt = freezed,Object? redeemedAt = freezed,Object? expiresAt = freezed,Object? redemptionLocation = freezed,Object? campaignMetadata = null,Object? itemMetadata = null,}) {
  return _then(_RewardItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: freezed == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as RewardType?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RewardItemStatus,codeValue: freezed == codeValue ? _self.codeValue : codeValue // ignore: cast_nullable_to_non_nullable
as String?,allocatedAt: freezed == allocatedAt ? _self.allocatedAt : allocatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redemptionLocation: freezed == redemptionLocation ? _self.redemptionLocation : redemptionLocation // ignore: cast_nullable_to_non_nullable
as String?,campaignMetadata: null == campaignMetadata ? _self._campaignMetadata : campaignMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,itemMetadata: null == itemMetadata ? _self._itemMetadata : itemMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
