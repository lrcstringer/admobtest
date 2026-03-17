// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunitySettingsModel {

 int get maxMembers; bool get allowMemberInvites; bool get onlyAdminsPost; bool get membersCanShareMedia; bool get enableFinancials; int get requireApprovalAbove; bool get allowMemberWithdrawals; String get contributionCycle; int get contributionAmount; int get penaltyPercentage;
/// Create a copy of CommunitySettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunitySettingsModelCopyWith<CommunitySettingsModel> get copyWith => _$CommunitySettingsModelCopyWithImpl<CommunitySettingsModel>(this as CommunitySettingsModel, _$identity);

  /// Serializes this CommunitySettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunitySettingsModel&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.allowMemberInvites, allowMemberInvites) || other.allowMemberInvites == allowMemberInvites)&&(identical(other.onlyAdminsPost, onlyAdminsPost) || other.onlyAdminsPost == onlyAdminsPost)&&(identical(other.membersCanShareMedia, membersCanShareMedia) || other.membersCanShareMedia == membersCanShareMedia)&&(identical(other.enableFinancials, enableFinancials) || other.enableFinancials == enableFinancials)&&(identical(other.requireApprovalAbove, requireApprovalAbove) || other.requireApprovalAbove == requireApprovalAbove)&&(identical(other.allowMemberWithdrawals, allowMemberWithdrawals) || other.allowMemberWithdrawals == allowMemberWithdrawals)&&(identical(other.contributionCycle, contributionCycle) || other.contributionCycle == contributionCycle)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.penaltyPercentage, penaltyPercentage) || other.penaltyPercentage == penaltyPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxMembers,allowMemberInvites,onlyAdminsPost,membersCanShareMedia,enableFinancials,requireApprovalAbove,allowMemberWithdrawals,contributionCycle,contributionAmount,penaltyPercentage);

@override
String toString() {
  return 'CommunitySettingsModel(maxMembers: $maxMembers, allowMemberInvites: $allowMemberInvites, onlyAdminsPost: $onlyAdminsPost, membersCanShareMedia: $membersCanShareMedia, enableFinancials: $enableFinancials, requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
}


}

/// @nodoc
abstract mixin class $CommunitySettingsModelCopyWith<$Res>  {
  factory $CommunitySettingsModelCopyWith(CommunitySettingsModel value, $Res Function(CommunitySettingsModel) _then) = _$CommunitySettingsModelCopyWithImpl;
@useResult
$Res call({
 int maxMembers, bool allowMemberInvites, bool onlyAdminsPost, bool membersCanShareMedia, bool enableFinancials, int requireApprovalAbove, bool allowMemberWithdrawals, String contributionCycle, int contributionAmount, int penaltyPercentage
});




}
/// @nodoc
class _$CommunitySettingsModelCopyWithImpl<$Res>
    implements $CommunitySettingsModelCopyWith<$Res> {
  _$CommunitySettingsModelCopyWithImpl(this._self, this._then);

  final CommunitySettingsModel _self;
  final $Res Function(CommunitySettingsModel) _then;

/// Create a copy of CommunitySettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxMembers = null,Object? allowMemberInvites = null,Object? onlyAdminsPost = null,Object? membersCanShareMedia = null,Object? enableFinancials = null,Object? requireApprovalAbove = null,Object? allowMemberWithdrawals = null,Object? contributionCycle = null,Object? contributionAmount = null,Object? penaltyPercentage = null,}) {
  return _then(_self.copyWith(
maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,allowMemberInvites: null == allowMemberInvites ? _self.allowMemberInvites : allowMemberInvites // ignore: cast_nullable_to_non_nullable
as bool,onlyAdminsPost: null == onlyAdminsPost ? _self.onlyAdminsPost : onlyAdminsPost // ignore: cast_nullable_to_non_nullable
as bool,membersCanShareMedia: null == membersCanShareMedia ? _self.membersCanShareMedia : membersCanShareMedia // ignore: cast_nullable_to_non_nullable
as bool,enableFinancials: null == enableFinancials ? _self.enableFinancials : enableFinancials // ignore: cast_nullable_to_non_nullable
as bool,requireApprovalAbove: null == requireApprovalAbove ? _self.requireApprovalAbove : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
as int,allowMemberWithdrawals: null == allowMemberWithdrawals ? _self.allowMemberWithdrawals : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
as bool,contributionCycle: null == contributionCycle ? _self.contributionCycle : contributionCycle // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,penaltyPercentage: null == penaltyPercentage ? _self.penaltyPercentage : penaltyPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunitySettingsModel].
extension CommunitySettingsModelPatterns on CommunitySettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunitySettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunitySettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunitySettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _CommunitySettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunitySettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommunitySettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxMembers,  bool allowMemberInvites,  bool onlyAdminsPost,  bool membersCanShareMedia,  bool enableFinancials,  int requireApprovalAbove,  bool allowMemberWithdrawals,  String contributionCycle,  int contributionAmount,  int penaltyPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunitySettingsModel() when $default != null:
return $default(_that.maxMembers,_that.allowMemberInvites,_that.onlyAdminsPost,_that.membersCanShareMedia,_that.enableFinancials,_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxMembers,  bool allowMemberInvites,  bool onlyAdminsPost,  bool membersCanShareMedia,  bool enableFinancials,  int requireApprovalAbove,  bool allowMemberWithdrawals,  String contributionCycle,  int contributionAmount,  int penaltyPercentage)  $default,) {final _that = this;
switch (_that) {
case _CommunitySettingsModel():
return $default(_that.maxMembers,_that.allowMemberInvites,_that.onlyAdminsPost,_that.membersCanShareMedia,_that.enableFinancials,_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxMembers,  bool allowMemberInvites,  bool onlyAdminsPost,  bool membersCanShareMedia,  bool enableFinancials,  int requireApprovalAbove,  bool allowMemberWithdrawals,  String contributionCycle,  int contributionAmount,  int penaltyPercentage)?  $default,) {final _that = this;
switch (_that) {
case _CommunitySettingsModel() when $default != null:
return $default(_that.maxMembers,_that.allowMemberInvites,_that.onlyAdminsPost,_that.membersCanShareMedia,_that.enableFinancials,_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunitySettingsModel extends CommunitySettingsModel {
  const _CommunitySettingsModel({this.maxMembers = 100, this.allowMemberInvites = true, this.onlyAdminsPost = false, this.membersCanShareMedia = true, this.enableFinancials = false, this.requireApprovalAbove = 5000, this.allowMemberWithdrawals = false, this.contributionCycle = 'none', this.contributionAmount = 0, this.penaltyPercentage = 0}): super._();
  factory _CommunitySettingsModel.fromJson(Map<String, dynamic> json) => _$CommunitySettingsModelFromJson(json);

@override@JsonKey() final  int maxMembers;
@override@JsonKey() final  bool allowMemberInvites;
@override@JsonKey() final  bool onlyAdminsPost;
@override@JsonKey() final  bool membersCanShareMedia;
@override@JsonKey() final  bool enableFinancials;
@override@JsonKey() final  int requireApprovalAbove;
@override@JsonKey() final  bool allowMemberWithdrawals;
@override@JsonKey() final  String contributionCycle;
@override@JsonKey() final  int contributionAmount;
@override@JsonKey() final  int penaltyPercentage;

/// Create a copy of CommunitySettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunitySettingsModelCopyWith<_CommunitySettingsModel> get copyWith => __$CommunitySettingsModelCopyWithImpl<_CommunitySettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunitySettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunitySettingsModel&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.allowMemberInvites, allowMemberInvites) || other.allowMemberInvites == allowMemberInvites)&&(identical(other.onlyAdminsPost, onlyAdminsPost) || other.onlyAdminsPost == onlyAdminsPost)&&(identical(other.membersCanShareMedia, membersCanShareMedia) || other.membersCanShareMedia == membersCanShareMedia)&&(identical(other.enableFinancials, enableFinancials) || other.enableFinancials == enableFinancials)&&(identical(other.requireApprovalAbove, requireApprovalAbove) || other.requireApprovalAbove == requireApprovalAbove)&&(identical(other.allowMemberWithdrawals, allowMemberWithdrawals) || other.allowMemberWithdrawals == allowMemberWithdrawals)&&(identical(other.contributionCycle, contributionCycle) || other.contributionCycle == contributionCycle)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.penaltyPercentage, penaltyPercentage) || other.penaltyPercentage == penaltyPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxMembers,allowMemberInvites,onlyAdminsPost,membersCanShareMedia,enableFinancials,requireApprovalAbove,allowMemberWithdrawals,contributionCycle,contributionAmount,penaltyPercentage);

@override
String toString() {
  return 'CommunitySettingsModel(maxMembers: $maxMembers, allowMemberInvites: $allowMemberInvites, onlyAdminsPost: $onlyAdminsPost, membersCanShareMedia: $membersCanShareMedia, enableFinancials: $enableFinancials, requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
}


}

/// @nodoc
abstract mixin class _$CommunitySettingsModelCopyWith<$Res> implements $CommunitySettingsModelCopyWith<$Res> {
  factory _$CommunitySettingsModelCopyWith(_CommunitySettingsModel value, $Res Function(_CommunitySettingsModel) _then) = __$CommunitySettingsModelCopyWithImpl;
@override @useResult
$Res call({
 int maxMembers, bool allowMemberInvites, bool onlyAdminsPost, bool membersCanShareMedia, bool enableFinancials, int requireApprovalAbove, bool allowMemberWithdrawals, String contributionCycle, int contributionAmount, int penaltyPercentage
});




}
/// @nodoc
class __$CommunitySettingsModelCopyWithImpl<$Res>
    implements _$CommunitySettingsModelCopyWith<$Res> {
  __$CommunitySettingsModelCopyWithImpl(this._self, this._then);

  final _CommunitySettingsModel _self;
  final $Res Function(_CommunitySettingsModel) _then;

/// Create a copy of CommunitySettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxMembers = null,Object? allowMemberInvites = null,Object? onlyAdminsPost = null,Object? membersCanShareMedia = null,Object? enableFinancials = null,Object? requireApprovalAbove = null,Object? allowMemberWithdrawals = null,Object? contributionCycle = null,Object? contributionAmount = null,Object? penaltyPercentage = null,}) {
  return _then(_CommunitySettingsModel(
maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,allowMemberInvites: null == allowMemberInvites ? _self.allowMemberInvites : allowMemberInvites // ignore: cast_nullable_to_non_nullable
as bool,onlyAdminsPost: null == onlyAdminsPost ? _self.onlyAdminsPost : onlyAdminsPost // ignore: cast_nullable_to_non_nullable
as bool,membersCanShareMedia: null == membersCanShareMedia ? _self.membersCanShareMedia : membersCanShareMedia // ignore: cast_nullable_to_non_nullable
as bool,enableFinancials: null == enableFinancials ? _self.enableFinancials : enableFinancials // ignore: cast_nullable_to_non_nullable
as bool,requireApprovalAbove: null == requireApprovalAbove ? _self.requireApprovalAbove : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
as int,allowMemberWithdrawals: null == allowMemberWithdrawals ? _self.allowMemberWithdrawals : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
as bool,contributionCycle: null == contributionCycle ? _self.contributionCycle : contributionCycle // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,penaltyPercentage: null == penaltyPercentage ? _self.penaltyPercentage : penaltyPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommunityModel {

 String get id; String get type; String get name; String? get description; String? get avatarUrl; String get ownerId; List<String> get memberIds; List<String> get adminIds; int get memberCount; int get totalBalance; String get status; CommunitySettingsModel get settings; StokvelSettingsModel? get stokvelSettings;// Last message preview (flat fields — mapped from nested Firestore lastMessage)
 String? get lastMessageText; String? get lastMessageSenderId; String? get lastMessageSenderName; String? get lastMessageType;@NullableTimestampConverter() DateTime? get lastMessageAt;// Per-user state
 Map<String, int> get unreadCounts; Map<String, bool> get muted;// E2EE: per-user encrypted last message previews
 Map<String, String> get lastMessageEncryptedPreviews;// Timestamps
@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityModelCopyWith<CommunityModel> get copyWith => _$CommunityModelCopyWithImpl<CommunityModel>(this as CommunityModel, _$identity);

  /// Serializes this CommunityModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&const DeepCollectionEquality().equals(other.adminIds, adminIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stokvelSettings, stokvelSettings) || other.stokvelSettings == stokvelSettings)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other.unreadCounts, unreadCounts)&&const DeepCollectionEquality().equals(other.muted, muted)&&const DeepCollectionEquality().equals(other.lastMessageEncryptedPreviews, lastMessageEncryptedPreviews)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,name,description,avatarUrl,ownerId,const DeepCollectionEquality().hash(memberIds),const DeepCollectionEquality().hash(adminIds),memberCount,totalBalance,status,settings,stokvelSettings,lastMessageText,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(unreadCounts),const DeepCollectionEquality().hash(muted),const DeepCollectionEquality().hash(lastMessageEncryptedPreviews),createdAt,updatedAt]);

@override
String toString() {
  return 'CommunityModel(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, adminIds: $adminIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityModelCopyWith<$Res>  {
  factory $CommunityModelCopyWith(CommunityModel value, $Res Function(CommunityModel) _then) = _$CommunityModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String name, String? description, String? avatarUrl, String ownerId, List<String> memberIds, List<String> adminIds, int memberCount, int totalBalance, String status, CommunitySettingsModel settings, StokvelSettingsModel? stokvelSettings, String? lastMessageText, String? lastMessageSenderId, String? lastMessageSenderName, String? lastMessageType,@NullableTimestampConverter() DateTime? lastMessageAt, Map<String, int> unreadCounts, Map<String, bool> muted, Map<String, String> lastMessageEncryptedPreviews,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt
});


$CommunitySettingsModelCopyWith<$Res> get settings;$StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;

}
/// @nodoc
class _$CommunityModelCopyWithImpl<$Res>
    implements $CommunityModelCopyWith<$Res> {
  _$CommunityModelCopyWithImpl(this._self, this._then);

  final CommunityModel _self;
  final $Res Function(CommunityModel) _then;

/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = null,Object? description = freezed,Object? avatarUrl = freezed,Object? ownerId = null,Object? memberIds = null,Object? adminIds = null,Object? memberCount = null,Object? totalBalance = null,Object? status = null,Object? settings = null,Object? stokvelSettings = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = freezed,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = null,Object? muted = null,Object? lastMessageEncryptedPreviews = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,adminIds: null == adminIds ? _self.adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as CommunitySettingsModel,stokvelSettings: freezed == stokvelSettings ? _self.stokvelSettings : stokvelSettings // ignore: cast_nullable_to_non_nullable
as StokvelSettingsModel?,lastMessageText: freezed == lastMessageText ? _self.lastMessageText : lastMessageText // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderName: freezed == lastMessageSenderName ? _self.lastMessageSenderName : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
as String?,lastMessageType: freezed == lastMessageType ? _self.lastMessageType : lastMessageType // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCounts: null == unreadCounts ? _self.unreadCounts : unreadCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews ? _self.lastMessageEncryptedPreviews : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
as Map<String, String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunitySettingsModelCopyWith<$Res> get settings {
  
  return $CommunitySettingsModelCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StokvelSettingsModelCopyWith<$Res>? get stokvelSettings {
    if (_self.stokvelSettings == null) {
    return null;
  }

  return $StokvelSettingsModelCopyWith<$Res>(_self.stokvelSettings!, (value) {
    return _then(_self.copyWith(stokvelSettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityModel].
extension CommunityModelPatterns on CommunityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityModel value)  $default,){
final _that = this;
switch (_that) {
case _CommunityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String name,  String? description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  List<String> adminIds,  int memberCount,  int totalBalance,  String status,  CommunitySettingsModel settings,  StokvelSettingsModel? stokvelSettings,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType, @NullableTimestampConverter()  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityModel() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.adminIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.muted,_that.lastMessageEncryptedPreviews,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String name,  String? description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  List<String> adminIds,  int memberCount,  int totalBalance,  String status,  CommunitySettingsModel settings,  StokvelSettingsModel? stokvelSettings,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType, @NullableTimestampConverter()  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityModel():
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.adminIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.muted,_that.lastMessageEncryptedPreviews,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String name,  String? description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  List<String> adminIds,  int memberCount,  int totalBalance,  String status,  CommunitySettingsModel settings,  StokvelSettingsModel? stokvelSettings,  String? lastMessageText,  String? lastMessageSenderId,  String? lastMessageSenderName,  String? lastMessageType, @NullableTimestampConverter()  DateTime? lastMessageAt,  Map<String, int> unreadCounts,  Map<String, bool> muted,  Map<String, String> lastMessageEncryptedPreviews, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityModel() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.adminIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.lastMessageText,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.unreadCounts,_that.muted,_that.lastMessageEncryptedPreviews,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityModel extends CommunityModel {
  const _CommunityModel({required this.id, required this.type, required this.name, this.description, this.avatarUrl, required this.ownerId, required final  List<String> memberIds, required final  List<String> adminIds, required this.memberCount, this.totalBalance = 0, required this.status, required this.settings, this.stokvelSettings, this.lastMessageText, this.lastMessageSenderId, this.lastMessageSenderName, this.lastMessageType, @NullableTimestampConverter() this.lastMessageAt, final  Map<String, int> unreadCounts = const {}, final  Map<String, bool> muted = const {}, final  Map<String, String> lastMessageEncryptedPreviews = const {}, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.updatedAt}): _memberIds = memberIds,_adminIds = adminIds,_unreadCounts = unreadCounts,_muted = muted,_lastMessageEncryptedPreviews = lastMessageEncryptedPreviews,super._();
  factory _CommunityModel.fromJson(Map<String, dynamic> json) => _$CommunityModelFromJson(json);

@override final  String id;
@override final  String type;
@override final  String name;
@override final  String? description;
@override final  String? avatarUrl;
@override final  String ownerId;
 final  List<String> _memberIds;
@override List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

 final  List<String> _adminIds;
@override List<String> get adminIds {
  if (_adminIds is EqualUnmodifiableListView) return _adminIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_adminIds);
}

@override final  int memberCount;
@override@JsonKey() final  int totalBalance;
@override final  String status;
@override final  CommunitySettingsModel settings;
@override final  StokvelSettingsModel? stokvelSettings;
// Last message preview (flat fields — mapped from nested Firestore lastMessage)
@override final  String? lastMessageText;
@override final  String? lastMessageSenderId;
@override final  String? lastMessageSenderName;
@override final  String? lastMessageType;
@override@NullableTimestampConverter() final  DateTime? lastMessageAt;
// Per-user state
 final  Map<String, int> _unreadCounts;
// Per-user state
@override@JsonKey() Map<String, int> get unreadCounts {
  if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unreadCounts);
}

 final  Map<String, bool> _muted;
@override@JsonKey() Map<String, bool> get muted {
  if (_muted is EqualUnmodifiableMapView) return _muted;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_muted);
}

// E2EE: per-user encrypted last message previews
 final  Map<String, String> _lastMessageEncryptedPreviews;
// E2EE: per-user encrypted last message previews
@override@JsonKey() Map<String, String> get lastMessageEncryptedPreviews {
  if (_lastMessageEncryptedPreviews is EqualUnmodifiableMapView) return _lastMessageEncryptedPreviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastMessageEncryptedPreviews);
}

// Timestamps
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityModelCopyWith<_CommunityModel> get copyWith => __$CommunityModelCopyWithImpl<_CommunityModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&const DeepCollectionEquality().equals(other._adminIds, _adminIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stokvelSettings, stokvelSettings) || other.stokvelSettings == stokvelSettings)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other._unreadCounts, _unreadCounts)&&const DeepCollectionEquality().equals(other._muted, _muted)&&const DeepCollectionEquality().equals(other._lastMessageEncryptedPreviews, _lastMessageEncryptedPreviews)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,name,description,avatarUrl,ownerId,const DeepCollectionEquality().hash(_memberIds),const DeepCollectionEquality().hash(_adminIds),memberCount,totalBalance,status,settings,stokvelSettings,lastMessageText,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(_unreadCounts),const DeepCollectionEquality().hash(_muted),const DeepCollectionEquality().hash(_lastMessageEncryptedPreviews),createdAt,updatedAt]);

@override
String toString() {
  return 'CommunityModel(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, adminIds: $adminIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityModelCopyWith<$Res> implements $CommunityModelCopyWith<$Res> {
  factory _$CommunityModelCopyWith(_CommunityModel value, $Res Function(_CommunityModel) _then) = __$CommunityModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String name, String? description, String? avatarUrl, String ownerId, List<String> memberIds, List<String> adminIds, int memberCount, int totalBalance, String status, CommunitySettingsModel settings, StokvelSettingsModel? stokvelSettings, String? lastMessageText, String? lastMessageSenderId, String? lastMessageSenderName, String? lastMessageType,@NullableTimestampConverter() DateTime? lastMessageAt, Map<String, int> unreadCounts, Map<String, bool> muted, Map<String, String> lastMessageEncryptedPreviews,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt
});


@override $CommunitySettingsModelCopyWith<$Res> get settings;@override $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;

}
/// @nodoc
class __$CommunityModelCopyWithImpl<$Res>
    implements _$CommunityModelCopyWith<$Res> {
  __$CommunityModelCopyWithImpl(this._self, this._then);

  final _CommunityModel _self;
  final $Res Function(_CommunityModel) _then;

/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? name = null,Object? description = freezed,Object? avatarUrl = freezed,Object? ownerId = null,Object? memberIds = null,Object? adminIds = null,Object? memberCount = null,Object? totalBalance = null,Object? status = null,Object? settings = null,Object? stokvelSettings = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = freezed,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = null,Object? muted = null,Object? lastMessageEncryptedPreviews = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_CommunityModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,adminIds: null == adminIds ? _self._adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as CommunitySettingsModel,stokvelSettings: freezed == stokvelSettings ? _self.stokvelSettings : stokvelSettings // ignore: cast_nullable_to_non_nullable
as StokvelSettingsModel?,lastMessageText: freezed == lastMessageText ? _self.lastMessageText : lastMessageText // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderName: freezed == lastMessageSenderName ? _self.lastMessageSenderName : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
as String?,lastMessageType: freezed == lastMessageType ? _self.lastMessageType : lastMessageType // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCounts: null == unreadCounts ? _self._unreadCounts : unreadCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,muted: null == muted ? _self._muted : muted // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews ? _self._lastMessageEncryptedPreviews : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
as Map<String, String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunitySettingsModelCopyWith<$Res> get settings {
  
  return $CommunitySettingsModelCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of CommunityModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StokvelSettingsModelCopyWith<$Res>? get stokvelSettings {
    if (_self.stokvelSettings == null) {
    return null;
  }

  return $StokvelSettingsModelCopyWith<$Res>(_self.stokvelSettings!, (value) {
    return _then(_self.copyWith(stokvelSettings: value));
  });
}
}

// dart format on
