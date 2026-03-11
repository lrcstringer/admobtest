// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Video {

 String get id; String get campaignId; String get title; String get videoUrl; int get durationSeconds; int get requiredWatchSeconds; int get tokenReward; VideoStatus get status; DateTime get createdAt; String? get thumbnailUrl; String? get description; String? get callToActionText; String? get callToActionUrl; int? get totalViews; int? get completedViews; double? get averageWatchPercentage;
/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoCopyWith<Video> get copyWith => _$VideoCopyWithImpl<Video>(this as Video, _$identity);

  /// Serializes this Video to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Video&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.title, title) || other.title == title)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.requiredWatchSeconds, requiredWatchSeconds) || other.requiredWatchSeconds == requiredWatchSeconds)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.callToActionText, callToActionText) || other.callToActionText == callToActionText)&&(identical(other.callToActionUrl, callToActionUrl) || other.callToActionUrl == callToActionUrl)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews)&&(identical(other.completedViews, completedViews) || other.completedViews == completedViews)&&(identical(other.averageWatchPercentage, averageWatchPercentage) || other.averageWatchPercentage == averageWatchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,title,videoUrl,durationSeconds,requiredWatchSeconds,tokenReward,status,createdAt,thumbnailUrl,description,callToActionText,callToActionUrl,totalViews,completedViews,averageWatchPercentage);

@override
String toString() {
  return 'Video(id: $id, campaignId: $campaignId, title: $title, videoUrl: $videoUrl, durationSeconds: $durationSeconds, requiredWatchSeconds: $requiredWatchSeconds, tokenReward: $tokenReward, status: $status, createdAt: $createdAt, thumbnailUrl: $thumbnailUrl, description: $description, callToActionText: $callToActionText, callToActionUrl: $callToActionUrl, totalViews: $totalViews, completedViews: $completedViews, averageWatchPercentage: $averageWatchPercentage)';
}


}

/// @nodoc
abstract mixin class $VideoCopyWith<$Res>  {
  factory $VideoCopyWith(Video value, $Res Function(Video) _then) = _$VideoCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String title, String videoUrl, int durationSeconds, int requiredWatchSeconds, int tokenReward, VideoStatus status, DateTime createdAt, String? thumbnailUrl, String? description, String? callToActionText, String? callToActionUrl, int? totalViews, int? completedViews, double? averageWatchPercentage
});




}
/// @nodoc
class _$VideoCopyWithImpl<$Res>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._self, this._then);

  final Video _self;
  final $Res Function(Video) _then;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? title = null,Object? videoUrl = null,Object? durationSeconds = null,Object? requiredWatchSeconds = null,Object? tokenReward = null,Object? status = null,Object? createdAt = null,Object? thumbnailUrl = freezed,Object? description = freezed,Object? callToActionText = freezed,Object? callToActionUrl = freezed,Object? totalViews = freezed,Object? completedViews = freezed,Object? averageWatchPercentage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredWatchSeconds: null == requiredWatchSeconds ? _self.requiredWatchSeconds : requiredWatchSeconds // ignore: cast_nullable_to_non_nullable
as int,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VideoStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,callToActionText: freezed == callToActionText ? _self.callToActionText : callToActionText // ignore: cast_nullable_to_non_nullable
as String?,callToActionUrl: freezed == callToActionUrl ? _self.callToActionUrl : callToActionUrl // ignore: cast_nullable_to_non_nullable
as String?,totalViews: freezed == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int?,completedViews: freezed == completedViews ? _self.completedViews : completedViews // ignore: cast_nullable_to_non_nullable
as int?,averageWatchPercentage: freezed == averageWatchPercentage ? _self.averageWatchPercentage : averageWatchPercentage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Video].
extension VideoPatterns on Video {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Video value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Video() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Video value)  $default,){
final _that = this;
switch (_that) {
case _Video():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Video value)?  $default,){
final _that = this;
switch (_that) {
case _Video() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String title,  String videoUrl,  int durationSeconds,  int requiredWatchSeconds,  int tokenReward,  VideoStatus status,  DateTime createdAt,  String? thumbnailUrl,  String? description,  String? callToActionText,  String? callToActionUrl,  int? totalViews,  int? completedViews,  double? averageWatchPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Video() when $default != null:
return $default(_that.id,_that.campaignId,_that.title,_that.videoUrl,_that.durationSeconds,_that.requiredWatchSeconds,_that.tokenReward,_that.status,_that.createdAt,_that.thumbnailUrl,_that.description,_that.callToActionText,_that.callToActionUrl,_that.totalViews,_that.completedViews,_that.averageWatchPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String title,  String videoUrl,  int durationSeconds,  int requiredWatchSeconds,  int tokenReward,  VideoStatus status,  DateTime createdAt,  String? thumbnailUrl,  String? description,  String? callToActionText,  String? callToActionUrl,  int? totalViews,  int? completedViews,  double? averageWatchPercentage)  $default,) {final _that = this;
switch (_that) {
case _Video():
return $default(_that.id,_that.campaignId,_that.title,_that.videoUrl,_that.durationSeconds,_that.requiredWatchSeconds,_that.tokenReward,_that.status,_that.createdAt,_that.thumbnailUrl,_that.description,_that.callToActionText,_that.callToActionUrl,_that.totalViews,_that.completedViews,_that.averageWatchPercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String title,  String videoUrl,  int durationSeconds,  int requiredWatchSeconds,  int tokenReward,  VideoStatus status,  DateTime createdAt,  String? thumbnailUrl,  String? description,  String? callToActionText,  String? callToActionUrl,  int? totalViews,  int? completedViews,  double? averageWatchPercentage)?  $default,) {final _that = this;
switch (_that) {
case _Video() when $default != null:
return $default(_that.id,_that.campaignId,_that.title,_that.videoUrl,_that.durationSeconds,_that.requiredWatchSeconds,_that.tokenReward,_that.status,_that.createdAt,_that.thumbnailUrl,_that.description,_that.callToActionText,_that.callToActionUrl,_that.totalViews,_that.completedViews,_that.averageWatchPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Video implements Video {
  const _Video({required this.id, required this.campaignId, required this.title, required this.videoUrl, required this.durationSeconds, required this.requiredWatchSeconds, required this.tokenReward, required this.status, required this.createdAt, this.thumbnailUrl, this.description, this.callToActionText, this.callToActionUrl, this.totalViews, this.completedViews, this.averageWatchPercentage});
  factory _Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

@override final  String id;
@override final  String campaignId;
@override final  String title;
@override final  String videoUrl;
@override final  int durationSeconds;
@override final  int requiredWatchSeconds;
@override final  int tokenReward;
@override final  VideoStatus status;
@override final  DateTime createdAt;
@override final  String? thumbnailUrl;
@override final  String? description;
@override final  String? callToActionText;
@override final  String? callToActionUrl;
@override final  int? totalViews;
@override final  int? completedViews;
@override final  double? averageWatchPercentage;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoCopyWith<_Video> get copyWith => __$VideoCopyWithImpl<_Video>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Video&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.title, title) || other.title == title)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.requiredWatchSeconds, requiredWatchSeconds) || other.requiredWatchSeconds == requiredWatchSeconds)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.callToActionText, callToActionText) || other.callToActionText == callToActionText)&&(identical(other.callToActionUrl, callToActionUrl) || other.callToActionUrl == callToActionUrl)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews)&&(identical(other.completedViews, completedViews) || other.completedViews == completedViews)&&(identical(other.averageWatchPercentage, averageWatchPercentage) || other.averageWatchPercentage == averageWatchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,title,videoUrl,durationSeconds,requiredWatchSeconds,tokenReward,status,createdAt,thumbnailUrl,description,callToActionText,callToActionUrl,totalViews,completedViews,averageWatchPercentage);

@override
String toString() {
  return 'Video(id: $id, campaignId: $campaignId, title: $title, videoUrl: $videoUrl, durationSeconds: $durationSeconds, requiredWatchSeconds: $requiredWatchSeconds, tokenReward: $tokenReward, status: $status, createdAt: $createdAt, thumbnailUrl: $thumbnailUrl, description: $description, callToActionText: $callToActionText, callToActionUrl: $callToActionUrl, totalViews: $totalViews, completedViews: $completedViews, averageWatchPercentage: $averageWatchPercentage)';
}


}

/// @nodoc
abstract mixin class _$VideoCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$VideoCopyWith(_Video value, $Res Function(_Video) _then) = __$VideoCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String title, String videoUrl, int durationSeconds, int requiredWatchSeconds, int tokenReward, VideoStatus status, DateTime createdAt, String? thumbnailUrl, String? description, String? callToActionText, String? callToActionUrl, int? totalViews, int? completedViews, double? averageWatchPercentage
});




}
/// @nodoc
class __$VideoCopyWithImpl<$Res>
    implements _$VideoCopyWith<$Res> {
  __$VideoCopyWithImpl(this._self, this._then);

  final _Video _self;
  final $Res Function(_Video) _then;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? title = null,Object? videoUrl = null,Object? durationSeconds = null,Object? requiredWatchSeconds = null,Object? tokenReward = null,Object? status = null,Object? createdAt = null,Object? thumbnailUrl = freezed,Object? description = freezed,Object? callToActionText = freezed,Object? callToActionUrl = freezed,Object? totalViews = freezed,Object? completedViews = freezed,Object? averageWatchPercentage = freezed,}) {
  return _then(_Video(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredWatchSeconds: null == requiredWatchSeconds ? _self.requiredWatchSeconds : requiredWatchSeconds // ignore: cast_nullable_to_non_nullable
as int,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VideoStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,callToActionText: freezed == callToActionText ? _self.callToActionText : callToActionText // ignore: cast_nullable_to_non_nullable
as String?,callToActionUrl: freezed == callToActionUrl ? _self.callToActionUrl : callToActionUrl // ignore: cast_nullable_to_non_nullable
as String?,totalViews: freezed == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int?,completedViews: freezed == completedViews ? _self.completedViews : completedViews // ignore: cast_nullable_to_non_nullable
as int?,averageWatchPercentage: freezed == averageWatchPercentage ? _self.averageWatchPercentage : averageWatchPercentage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
