// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Campaign {

 String get id; String get brandId; String get brandName; String get title; String get description; CampaignType get type; CampaignStatus get status; int get totalBudgetTokens; int get remainingBudgetTokens; int get rewardPerEngagement; DateTime get startDate; DateTime get endDate; DateTime get createdAt; String? get imageUrl; String? get videoUrl; Map<String, dynamic>? get targetingCriteria; int? get maxEngagementsPerUser; int? get totalEngagements; int? get uniqueUsers; double? get averageCompletionRate;
/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignCopyWith<Campaign> get copyWith => _$CampaignCopyWithImpl<Campaign>(this as Campaign, _$identity);

  /// Serializes this Campaign to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalBudgetTokens, totalBudgetTokens) || other.totalBudgetTokens == totalBudgetTokens)&&(identical(other.remainingBudgetTokens, remainingBudgetTokens) || other.remainingBudgetTokens == remainingBudgetTokens)&&(identical(other.rewardPerEngagement, rewardPerEngagement) || other.rewardPerEngagement == rewardPerEngagement)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other.targetingCriteria, targetingCriteria)&&(identical(other.maxEngagementsPerUser, maxEngagementsPerUser) || other.maxEngagementsPerUser == maxEngagementsPerUser)&&(identical(other.totalEngagements, totalEngagements) || other.totalEngagements == totalEngagements)&&(identical(other.uniqueUsers, uniqueUsers) || other.uniqueUsers == uniqueUsers)&&(identical(other.averageCompletionRate, averageCompletionRate) || other.averageCompletionRate == averageCompletionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,title,description,type,status,totalBudgetTokens,remainingBudgetTokens,rewardPerEngagement,startDate,endDate,createdAt,imageUrl,videoUrl,const DeepCollectionEquality().hash(targetingCriteria),maxEngagementsPerUser,totalEngagements,uniqueUsers,averageCompletionRate]);

@override
String toString() {
  return 'Campaign(id: $id, brandId: $brandId, brandName: $brandName, title: $title, description: $description, type: $type, status: $status, totalBudgetTokens: $totalBudgetTokens, remainingBudgetTokens: $remainingBudgetTokens, rewardPerEngagement: $rewardPerEngagement, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, imageUrl: $imageUrl, videoUrl: $videoUrl, targetingCriteria: $targetingCriteria, maxEngagementsPerUser: $maxEngagementsPerUser, totalEngagements: $totalEngagements, uniqueUsers: $uniqueUsers, averageCompletionRate: $averageCompletionRate)';
}


}

/// @nodoc
abstract mixin class $CampaignCopyWith<$Res>  {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) _then) = _$CampaignCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String brandName, String title, String description, CampaignType type, CampaignStatus status, int totalBudgetTokens, int remainingBudgetTokens, int rewardPerEngagement, DateTime startDate, DateTime endDate, DateTime createdAt, String? imageUrl, String? videoUrl, Map<String, dynamic>? targetingCriteria, int? maxEngagementsPerUser, int? totalEngagements, int? uniqueUsers, double? averageCompletionRate
});




}
/// @nodoc
class _$CampaignCopyWithImpl<$Res>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._self, this._then);

  final Campaign _self;
  final $Res Function(Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? title = null,Object? description = null,Object? type = null,Object? status = null,Object? totalBudgetTokens = null,Object? remainingBudgetTokens = null,Object? rewardPerEngagement = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,Object? imageUrl = freezed,Object? videoUrl = freezed,Object? targetingCriteria = freezed,Object? maxEngagementsPerUser = freezed,Object? totalEngagements = freezed,Object? uniqueUsers = freezed,Object? averageCompletionRate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CampaignType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,totalBudgetTokens: null == totalBudgetTokens ? _self.totalBudgetTokens : totalBudgetTokens // ignore: cast_nullable_to_non_nullable
as int,remainingBudgetTokens: null == remainingBudgetTokens ? _self.remainingBudgetTokens : remainingBudgetTokens // ignore: cast_nullable_to_non_nullable
as int,rewardPerEngagement: null == rewardPerEngagement ? _self.rewardPerEngagement : rewardPerEngagement // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,targetingCriteria: freezed == targetingCriteria ? _self.targetingCriteria : targetingCriteria // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,maxEngagementsPerUser: freezed == maxEngagementsPerUser ? _self.maxEngagementsPerUser : maxEngagementsPerUser // ignore: cast_nullable_to_non_nullable
as int?,totalEngagements: freezed == totalEngagements ? _self.totalEngagements : totalEngagements // ignore: cast_nullable_to_non_nullable
as int?,uniqueUsers: freezed == uniqueUsers ? _self.uniqueUsers : uniqueUsers // ignore: cast_nullable_to_non_nullable
as int?,averageCompletionRate: freezed == averageCompletionRate ? _self.averageCompletionRate : averageCompletionRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Campaign].
extension CampaignPatterns on Campaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Campaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Campaign value)  $default,){
final _that = this;
switch (_that) {
case _Campaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Campaign value)?  $default,){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String title,  String description,  CampaignType type,  CampaignStatus status,  int totalBudgetTokens,  int remainingBudgetTokens,  int rewardPerEngagement,  DateTime startDate,  DateTime endDate,  DateTime createdAt,  String? imageUrl,  String? videoUrl,  Map<String, dynamic>? targetingCriteria,  int? maxEngagementsPerUser,  int? totalEngagements,  int? uniqueUsers,  double? averageCompletionRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.title,_that.description,_that.type,_that.status,_that.totalBudgetTokens,_that.remainingBudgetTokens,_that.rewardPerEngagement,_that.startDate,_that.endDate,_that.createdAt,_that.imageUrl,_that.videoUrl,_that.targetingCriteria,_that.maxEngagementsPerUser,_that.totalEngagements,_that.uniqueUsers,_that.averageCompletionRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String title,  String description,  CampaignType type,  CampaignStatus status,  int totalBudgetTokens,  int remainingBudgetTokens,  int rewardPerEngagement,  DateTime startDate,  DateTime endDate,  DateTime createdAt,  String? imageUrl,  String? videoUrl,  Map<String, dynamic>? targetingCriteria,  int? maxEngagementsPerUser,  int? totalEngagements,  int? uniqueUsers,  double? averageCompletionRate)  $default,) {final _that = this;
switch (_that) {
case _Campaign():
return $default(_that.id,_that.brandId,_that.brandName,_that.title,_that.description,_that.type,_that.status,_that.totalBudgetTokens,_that.remainingBudgetTokens,_that.rewardPerEngagement,_that.startDate,_that.endDate,_that.createdAt,_that.imageUrl,_that.videoUrl,_that.targetingCriteria,_that.maxEngagementsPerUser,_that.totalEngagements,_that.uniqueUsers,_that.averageCompletionRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String brandName,  String title,  String description,  CampaignType type,  CampaignStatus status,  int totalBudgetTokens,  int remainingBudgetTokens,  int rewardPerEngagement,  DateTime startDate,  DateTime endDate,  DateTime createdAt,  String? imageUrl,  String? videoUrl,  Map<String, dynamic>? targetingCriteria,  int? maxEngagementsPerUser,  int? totalEngagements,  int? uniqueUsers,  double? averageCompletionRate)?  $default,) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.title,_that.description,_that.type,_that.status,_that.totalBudgetTokens,_that.remainingBudgetTokens,_that.rewardPerEngagement,_that.startDate,_that.endDate,_that.createdAt,_that.imageUrl,_that.videoUrl,_that.targetingCriteria,_that.maxEngagementsPerUser,_that.totalEngagements,_that.uniqueUsers,_that.averageCompletionRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Campaign implements Campaign {
  const _Campaign({required this.id, required this.brandId, required this.brandName, required this.title, required this.description, required this.type, required this.status, required this.totalBudgetTokens, required this.remainingBudgetTokens, required this.rewardPerEngagement, required this.startDate, required this.endDate, required this.createdAt, this.imageUrl, this.videoUrl, final  Map<String, dynamic>? targetingCriteria, this.maxEngagementsPerUser, this.totalEngagements, this.uniqueUsers, this.averageCompletionRate}): _targetingCriteria = targetingCriteria;
  factory _Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);

@override final  String id;
@override final  String brandId;
@override final  String brandName;
@override final  String title;
@override final  String description;
@override final  CampaignType type;
@override final  CampaignStatus status;
@override final  int totalBudgetTokens;
@override final  int remainingBudgetTokens;
@override final  int rewardPerEngagement;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  DateTime createdAt;
@override final  String? imageUrl;
@override final  String? videoUrl;
 final  Map<String, dynamic>? _targetingCriteria;
@override Map<String, dynamic>? get targetingCriteria {
  final value = _targetingCriteria;
  if (value == null) return null;
  if (_targetingCriteria is EqualUnmodifiableMapView) return _targetingCriteria;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  int? maxEngagementsPerUser;
@override final  int? totalEngagements;
@override final  int? uniqueUsers;
@override final  double? averageCompletionRate;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignCopyWith<_Campaign> get copyWith => __$CampaignCopyWithImpl<_Campaign>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalBudgetTokens, totalBudgetTokens) || other.totalBudgetTokens == totalBudgetTokens)&&(identical(other.remainingBudgetTokens, remainingBudgetTokens) || other.remainingBudgetTokens == remainingBudgetTokens)&&(identical(other.rewardPerEngagement, rewardPerEngagement) || other.rewardPerEngagement == rewardPerEngagement)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other._targetingCriteria, _targetingCriteria)&&(identical(other.maxEngagementsPerUser, maxEngagementsPerUser) || other.maxEngagementsPerUser == maxEngagementsPerUser)&&(identical(other.totalEngagements, totalEngagements) || other.totalEngagements == totalEngagements)&&(identical(other.uniqueUsers, uniqueUsers) || other.uniqueUsers == uniqueUsers)&&(identical(other.averageCompletionRate, averageCompletionRate) || other.averageCompletionRate == averageCompletionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,title,description,type,status,totalBudgetTokens,remainingBudgetTokens,rewardPerEngagement,startDate,endDate,createdAt,imageUrl,videoUrl,const DeepCollectionEquality().hash(_targetingCriteria),maxEngagementsPerUser,totalEngagements,uniqueUsers,averageCompletionRate]);

@override
String toString() {
  return 'Campaign(id: $id, brandId: $brandId, brandName: $brandName, title: $title, description: $description, type: $type, status: $status, totalBudgetTokens: $totalBudgetTokens, remainingBudgetTokens: $remainingBudgetTokens, rewardPerEngagement: $rewardPerEngagement, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, imageUrl: $imageUrl, videoUrl: $videoUrl, targetingCriteria: $targetingCriteria, maxEngagementsPerUser: $maxEngagementsPerUser, totalEngagements: $totalEngagements, uniqueUsers: $uniqueUsers, averageCompletionRate: $averageCompletionRate)';
}


}

/// @nodoc
abstract mixin class _$CampaignCopyWith<$Res> implements $CampaignCopyWith<$Res> {
  factory _$CampaignCopyWith(_Campaign value, $Res Function(_Campaign) _then) = __$CampaignCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String brandName, String title, String description, CampaignType type, CampaignStatus status, int totalBudgetTokens, int remainingBudgetTokens, int rewardPerEngagement, DateTime startDate, DateTime endDate, DateTime createdAt, String? imageUrl, String? videoUrl, Map<String, dynamic>? targetingCriteria, int? maxEngagementsPerUser, int? totalEngagements, int? uniqueUsers, double? averageCompletionRate
});




}
/// @nodoc
class __$CampaignCopyWithImpl<$Res>
    implements _$CampaignCopyWith<$Res> {
  __$CampaignCopyWithImpl(this._self, this._then);

  final _Campaign _self;
  final $Res Function(_Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? title = null,Object? description = null,Object? type = null,Object? status = null,Object? totalBudgetTokens = null,Object? remainingBudgetTokens = null,Object? rewardPerEngagement = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,Object? imageUrl = freezed,Object? videoUrl = freezed,Object? targetingCriteria = freezed,Object? maxEngagementsPerUser = freezed,Object? totalEngagements = freezed,Object? uniqueUsers = freezed,Object? averageCompletionRate = freezed,}) {
  return _then(_Campaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CampaignType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,totalBudgetTokens: null == totalBudgetTokens ? _self.totalBudgetTokens : totalBudgetTokens // ignore: cast_nullable_to_non_nullable
as int,remainingBudgetTokens: null == remainingBudgetTokens ? _self.remainingBudgetTokens : remainingBudgetTokens // ignore: cast_nullable_to_non_nullable
as int,rewardPerEngagement: null == rewardPerEngagement ? _self.rewardPerEngagement : rewardPerEngagement // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,targetingCriteria: freezed == targetingCriteria ? _self._targetingCriteria : targetingCriteria // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,maxEngagementsPerUser: freezed == maxEngagementsPerUser ? _self.maxEngagementsPerUser : maxEngagementsPerUser // ignore: cast_nullable_to_non_nullable
as int?,totalEngagements: freezed == totalEngagements ? _self.totalEngagements : totalEngagements // ignore: cast_nullable_to_non_nullable
as int?,uniqueUsers: freezed == uniqueUsers ? _self.uniqueUsers : uniqueUsers // ignore: cast_nullable_to_non_nullable
as int?,averageCompletionRate: freezed == averageCompletionRate ? _self.averageCompletionRate : averageCompletionRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
