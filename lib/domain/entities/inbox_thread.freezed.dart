// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InboxThread {

 String get id; String get title; String? get description; String? get threadImage; bool get isPinned; bool get isFeatured; DateTime? get activeTo; int get availableOpportunities; int get completedByUser; int get totalTokenReward; List<String> get rewardTypes; List<String> get earningTypes; int get estimatedDurationSeconds; List<String> get opportunityIds; bool get hasRewardCampaign; DateTime? get soonestExpiry;
/// Create a copy of InboxThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxThreadCopyWith<InboxThread> get copyWith => _$InboxThreadCopyWithImpl<InboxThread>(this as InboxThread, _$identity);

  /// Serializes this InboxThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxThread&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.activeTo, activeTo) || other.activeTo == activeTo)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities)&&(identical(other.completedByUser, completedByUser) || other.completedByUser == completedByUser)&&(identical(other.totalTokenReward, totalTokenReward) || other.totalTokenReward == totalTokenReward)&&const DeepCollectionEquality().equals(other.rewardTypes, rewardTypes)&&const DeepCollectionEquality().equals(other.earningTypes, earningTypes)&&(identical(other.estimatedDurationSeconds, estimatedDurationSeconds) || other.estimatedDurationSeconds == estimatedDurationSeconds)&&const DeepCollectionEquality().equals(other.opportunityIds, opportunityIds)&&(identical(other.hasRewardCampaign, hasRewardCampaign) || other.hasRewardCampaign == hasRewardCampaign)&&(identical(other.soonestExpiry, soonestExpiry) || other.soonestExpiry == soonestExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,threadImage,isPinned,isFeatured,activeTo,availableOpportunities,completedByUser,totalTokenReward,const DeepCollectionEquality().hash(rewardTypes),const DeepCollectionEquality().hash(earningTypes),estimatedDurationSeconds,const DeepCollectionEquality().hash(opportunityIds),hasRewardCampaign,soonestExpiry);

@override
String toString() {
  return 'InboxThread(id: $id, title: $title, description: $description, threadImage: $threadImage, isPinned: $isPinned, isFeatured: $isFeatured, activeTo: $activeTo, availableOpportunities: $availableOpportunities, completedByUser: $completedByUser, totalTokenReward: $totalTokenReward, rewardTypes: $rewardTypes, earningTypes: $earningTypes, estimatedDurationSeconds: $estimatedDurationSeconds, opportunityIds: $opportunityIds, hasRewardCampaign: $hasRewardCampaign, soonestExpiry: $soonestExpiry)';
}


}

/// @nodoc
abstract mixin class $InboxThreadCopyWith<$Res>  {
  factory $InboxThreadCopyWith(InboxThread value, $Res Function(InboxThread) _then) = _$InboxThreadCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? threadImage, bool isPinned, bool isFeatured, DateTime? activeTo, int availableOpportunities, int completedByUser, int totalTokenReward, List<String> rewardTypes, List<String> earningTypes, int estimatedDurationSeconds, List<String> opportunityIds, bool hasRewardCampaign, DateTime? soonestExpiry
});




}
/// @nodoc
class _$InboxThreadCopyWithImpl<$Res>
    implements $InboxThreadCopyWith<$Res> {
  _$InboxThreadCopyWithImpl(this._self, this._then);

  final InboxThread _self;
  final $Res Function(InboxThread) _then;

/// Create a copy of InboxThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? threadImage = freezed,Object? isPinned = null,Object? isFeatured = null,Object? activeTo = freezed,Object? availableOpportunities = null,Object? completedByUser = null,Object? totalTokenReward = null,Object? rewardTypes = null,Object? earningTypes = null,Object? estimatedDurationSeconds = null,Object? opportunityIds = null,Object? hasRewardCampaign = null,Object? soonestExpiry = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,activeTo: freezed == activeTo ? _self.activeTo : activeTo // ignore: cast_nullable_to_non_nullable
as DateTime?,availableOpportunities: null == availableOpportunities ? _self.availableOpportunities : availableOpportunities // ignore: cast_nullable_to_non_nullable
as int,completedByUser: null == completedByUser ? _self.completedByUser : completedByUser // ignore: cast_nullable_to_non_nullable
as int,totalTokenReward: null == totalTokenReward ? _self.totalTokenReward : totalTokenReward // ignore: cast_nullable_to_non_nullable
as int,rewardTypes: null == rewardTypes ? _self.rewardTypes : rewardTypes // ignore: cast_nullable_to_non_nullable
as List<String>,earningTypes: null == earningTypes ? _self.earningTypes : earningTypes // ignore: cast_nullable_to_non_nullable
as List<String>,estimatedDurationSeconds: null == estimatedDurationSeconds ? _self.estimatedDurationSeconds : estimatedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,opportunityIds: null == opportunityIds ? _self.opportunityIds : opportunityIds // ignore: cast_nullable_to_non_nullable
as List<String>,hasRewardCampaign: null == hasRewardCampaign ? _self.hasRewardCampaign : hasRewardCampaign // ignore: cast_nullable_to_non_nullable
as bool,soonestExpiry: freezed == soonestExpiry ? _self.soonestExpiry : soonestExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxThread].
extension InboxThreadPatterns on InboxThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxThread value)  $default,){
final _that = this;
switch (_that) {
case _InboxThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxThread value)?  $default,){
final _that = this;
switch (_that) {
case _InboxThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? threadImage,  bool isPinned,  bool isFeatured,  DateTime? activeTo,  int availableOpportunities,  int completedByUser,  int totalTokenReward,  List<String> rewardTypes,  List<String> earningTypes,  int estimatedDurationSeconds,  List<String> opportunityIds,  bool hasRewardCampaign,  DateTime? soonestExpiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxThread() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.threadImage,_that.isPinned,_that.isFeatured,_that.activeTo,_that.availableOpportunities,_that.completedByUser,_that.totalTokenReward,_that.rewardTypes,_that.earningTypes,_that.estimatedDurationSeconds,_that.opportunityIds,_that.hasRewardCampaign,_that.soonestExpiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? threadImage,  bool isPinned,  bool isFeatured,  DateTime? activeTo,  int availableOpportunities,  int completedByUser,  int totalTokenReward,  List<String> rewardTypes,  List<String> earningTypes,  int estimatedDurationSeconds,  List<String> opportunityIds,  bool hasRewardCampaign,  DateTime? soonestExpiry)  $default,) {final _that = this;
switch (_that) {
case _InboxThread():
return $default(_that.id,_that.title,_that.description,_that.threadImage,_that.isPinned,_that.isFeatured,_that.activeTo,_that.availableOpportunities,_that.completedByUser,_that.totalTokenReward,_that.rewardTypes,_that.earningTypes,_that.estimatedDurationSeconds,_that.opportunityIds,_that.hasRewardCampaign,_that.soonestExpiry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? threadImage,  bool isPinned,  bool isFeatured,  DateTime? activeTo,  int availableOpportunities,  int completedByUser,  int totalTokenReward,  List<String> rewardTypes,  List<String> earningTypes,  int estimatedDurationSeconds,  List<String> opportunityIds,  bool hasRewardCampaign,  DateTime? soonestExpiry)?  $default,) {final _that = this;
switch (_that) {
case _InboxThread() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.threadImage,_that.isPinned,_that.isFeatured,_that.activeTo,_that.availableOpportunities,_that.completedByUser,_that.totalTokenReward,_that.rewardTypes,_that.earningTypes,_that.estimatedDurationSeconds,_that.opportunityIds,_that.hasRewardCampaign,_that.soonestExpiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InboxThread extends InboxThread {
  const _InboxThread({required this.id, required this.title, this.description, this.threadImage, required this.isPinned, required this.isFeatured, this.activeTo, required this.availableOpportunities, this.completedByUser = 0, required this.totalTokenReward, final  List<String> rewardTypes = const [], final  List<String> earningTypes = const [], this.estimatedDurationSeconds = 0, final  List<String> opportunityIds = const [], this.hasRewardCampaign = false, this.soonestExpiry}): _rewardTypes = rewardTypes,_earningTypes = earningTypes,_opportunityIds = opportunityIds,super._();
  factory _InboxThread.fromJson(Map<String, dynamic> json) => _$InboxThreadFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? threadImage;
@override final  bool isPinned;
@override final  bool isFeatured;
@override final  DateTime? activeTo;
@override final  int availableOpportunities;
@override@JsonKey() final  int completedByUser;
@override final  int totalTokenReward;
 final  List<String> _rewardTypes;
@override@JsonKey() List<String> get rewardTypes {
  if (_rewardTypes is EqualUnmodifiableListView) return _rewardTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rewardTypes);
}

 final  List<String> _earningTypes;
@override@JsonKey() List<String> get earningTypes {
  if (_earningTypes is EqualUnmodifiableListView) return _earningTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earningTypes);
}

@override@JsonKey() final  int estimatedDurationSeconds;
 final  List<String> _opportunityIds;
@override@JsonKey() List<String> get opportunityIds {
  if (_opportunityIds is EqualUnmodifiableListView) return _opportunityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opportunityIds);
}

@override@JsonKey() final  bool hasRewardCampaign;
@override final  DateTime? soonestExpiry;

/// Create a copy of InboxThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxThreadCopyWith<_InboxThread> get copyWith => __$InboxThreadCopyWithImpl<_InboxThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InboxThreadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxThread&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.activeTo, activeTo) || other.activeTo == activeTo)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities)&&(identical(other.completedByUser, completedByUser) || other.completedByUser == completedByUser)&&(identical(other.totalTokenReward, totalTokenReward) || other.totalTokenReward == totalTokenReward)&&const DeepCollectionEquality().equals(other._rewardTypes, _rewardTypes)&&const DeepCollectionEquality().equals(other._earningTypes, _earningTypes)&&(identical(other.estimatedDurationSeconds, estimatedDurationSeconds) || other.estimatedDurationSeconds == estimatedDurationSeconds)&&const DeepCollectionEquality().equals(other._opportunityIds, _opportunityIds)&&(identical(other.hasRewardCampaign, hasRewardCampaign) || other.hasRewardCampaign == hasRewardCampaign)&&(identical(other.soonestExpiry, soonestExpiry) || other.soonestExpiry == soonestExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,threadImage,isPinned,isFeatured,activeTo,availableOpportunities,completedByUser,totalTokenReward,const DeepCollectionEquality().hash(_rewardTypes),const DeepCollectionEquality().hash(_earningTypes),estimatedDurationSeconds,const DeepCollectionEquality().hash(_opportunityIds),hasRewardCampaign,soonestExpiry);

@override
String toString() {
  return 'InboxThread(id: $id, title: $title, description: $description, threadImage: $threadImage, isPinned: $isPinned, isFeatured: $isFeatured, activeTo: $activeTo, availableOpportunities: $availableOpportunities, completedByUser: $completedByUser, totalTokenReward: $totalTokenReward, rewardTypes: $rewardTypes, earningTypes: $earningTypes, estimatedDurationSeconds: $estimatedDurationSeconds, opportunityIds: $opportunityIds, hasRewardCampaign: $hasRewardCampaign, soonestExpiry: $soonestExpiry)';
}


}

/// @nodoc
abstract mixin class _$InboxThreadCopyWith<$Res> implements $InboxThreadCopyWith<$Res> {
  factory _$InboxThreadCopyWith(_InboxThread value, $Res Function(_InboxThread) _then) = __$InboxThreadCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? threadImage, bool isPinned, bool isFeatured, DateTime? activeTo, int availableOpportunities, int completedByUser, int totalTokenReward, List<String> rewardTypes, List<String> earningTypes, int estimatedDurationSeconds, List<String> opportunityIds, bool hasRewardCampaign, DateTime? soonestExpiry
});




}
/// @nodoc
class __$InboxThreadCopyWithImpl<$Res>
    implements _$InboxThreadCopyWith<$Res> {
  __$InboxThreadCopyWithImpl(this._self, this._then);

  final _InboxThread _self;
  final $Res Function(_InboxThread) _then;

/// Create a copy of InboxThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? threadImage = freezed,Object? isPinned = null,Object? isFeatured = null,Object? activeTo = freezed,Object? availableOpportunities = null,Object? completedByUser = null,Object? totalTokenReward = null,Object? rewardTypes = null,Object? earningTypes = null,Object? estimatedDurationSeconds = null,Object? opportunityIds = null,Object? hasRewardCampaign = null,Object? soonestExpiry = freezed,}) {
  return _then(_InboxThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,activeTo: freezed == activeTo ? _self.activeTo : activeTo // ignore: cast_nullable_to_non_nullable
as DateTime?,availableOpportunities: null == availableOpportunities ? _self.availableOpportunities : availableOpportunities // ignore: cast_nullable_to_non_nullable
as int,completedByUser: null == completedByUser ? _self.completedByUser : completedByUser // ignore: cast_nullable_to_non_nullable
as int,totalTokenReward: null == totalTokenReward ? _self.totalTokenReward : totalTokenReward // ignore: cast_nullable_to_non_nullable
as int,rewardTypes: null == rewardTypes ? _self._rewardTypes : rewardTypes // ignore: cast_nullable_to_non_nullable
as List<String>,earningTypes: null == earningTypes ? _self._earningTypes : earningTypes // ignore: cast_nullable_to_non_nullable
as List<String>,estimatedDurationSeconds: null == estimatedDurationSeconds ? _self.estimatedDurationSeconds : estimatedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,opportunityIds: null == opportunityIds ? _self._opportunityIds : opportunityIds // ignore: cast_nullable_to_non_nullable
as List<String>,hasRewardCampaign: null == hasRewardCampaign ? _self.hasRewardCampaign : hasRewardCampaign // ignore: cast_nullable_to_non_nullable
as bool,soonestExpiry: freezed == soonestExpiry ? _self.soonestExpiry : soonestExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
