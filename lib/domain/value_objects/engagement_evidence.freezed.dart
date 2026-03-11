// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement_evidence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadedFileEvidence {

 String get url; String get type;// 'video' or 'image'
 int get sizeBytes; String? get mimeType; int? get durationSeconds;// video only
 int? get width; int? get height;
/// Create a copy of UploadedFileEvidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadedFileEvidenceCopyWith<UploadedFileEvidence> get copyWith => _$UploadedFileEvidenceCopyWithImpl<UploadedFileEvidence>(this as UploadedFileEvidence, _$identity);

  /// Serializes this UploadedFileEvidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadedFileEvidence&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,type,sizeBytes,mimeType,durationSeconds,width,height);

@override
String toString() {
  return 'UploadedFileEvidence(url: $url, type: $type, sizeBytes: $sizeBytes, mimeType: $mimeType, durationSeconds: $durationSeconds, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $UploadedFileEvidenceCopyWith<$Res>  {
  factory $UploadedFileEvidenceCopyWith(UploadedFileEvidence value, $Res Function(UploadedFileEvidence) _then) = _$UploadedFileEvidenceCopyWithImpl;
@useResult
$Res call({
 String url, String type, int sizeBytes, String? mimeType, int? durationSeconds, int? width, int? height
});




}
/// @nodoc
class _$UploadedFileEvidenceCopyWithImpl<$Res>
    implements $UploadedFileEvidenceCopyWith<$Res> {
  _$UploadedFileEvidenceCopyWithImpl(this._self, this._then);

  final UploadedFileEvidence _self;
  final $Res Function(UploadedFileEvidence) _then;

/// Create a copy of UploadedFileEvidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? type = null,Object? sizeBytes = null,Object? mimeType = freezed,Object? durationSeconds = freezed,Object? width = freezed,Object? height = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadedFileEvidence].
extension UploadedFileEvidencePatterns on UploadedFileEvidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadedFileEvidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadedFileEvidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadedFileEvidence value)  $default,){
final _that = this;
switch (_that) {
case _UploadedFileEvidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadedFileEvidence value)?  $default,){
final _that = this;
switch (_that) {
case _UploadedFileEvidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String type,  int sizeBytes,  String? mimeType,  int? durationSeconds,  int? width,  int? height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadedFileEvidence() when $default != null:
return $default(_that.url,_that.type,_that.sizeBytes,_that.mimeType,_that.durationSeconds,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String type,  int sizeBytes,  String? mimeType,  int? durationSeconds,  int? width,  int? height)  $default,) {final _that = this;
switch (_that) {
case _UploadedFileEvidence():
return $default(_that.url,_that.type,_that.sizeBytes,_that.mimeType,_that.durationSeconds,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String type,  int sizeBytes,  String? mimeType,  int? durationSeconds,  int? width,  int? height)?  $default,) {final _that = this;
switch (_that) {
case _UploadedFileEvidence() when $default != null:
return $default(_that.url,_that.type,_that.sizeBytes,_that.mimeType,_that.durationSeconds,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadedFileEvidence implements UploadedFileEvidence {
  const _UploadedFileEvidence({required this.url, required this.type, required this.sizeBytes, this.mimeType, this.durationSeconds, this.width, this.height});
  factory _UploadedFileEvidence.fromJson(Map<String, dynamic> json) => _$UploadedFileEvidenceFromJson(json);

@override final  String url;
@override final  String type;
// 'video' or 'image'
@override final  int sizeBytes;
@override final  String? mimeType;
@override final  int? durationSeconds;
// video only
@override final  int? width;
@override final  int? height;

/// Create a copy of UploadedFileEvidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadedFileEvidenceCopyWith<_UploadedFileEvidence> get copyWith => __$UploadedFileEvidenceCopyWithImpl<_UploadedFileEvidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadedFileEvidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadedFileEvidence&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,type,sizeBytes,mimeType,durationSeconds,width,height);

@override
String toString() {
  return 'UploadedFileEvidence(url: $url, type: $type, sizeBytes: $sizeBytes, mimeType: $mimeType, durationSeconds: $durationSeconds, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$UploadedFileEvidenceCopyWith<$Res> implements $UploadedFileEvidenceCopyWith<$Res> {
  factory _$UploadedFileEvidenceCopyWith(_UploadedFileEvidence value, $Res Function(_UploadedFileEvidence) _then) = __$UploadedFileEvidenceCopyWithImpl;
@override @useResult
$Res call({
 String url, String type, int sizeBytes, String? mimeType, int? durationSeconds, int? width, int? height
});




}
/// @nodoc
class __$UploadedFileEvidenceCopyWithImpl<$Res>
    implements _$UploadedFileEvidenceCopyWith<$Res> {
  __$UploadedFileEvidenceCopyWithImpl(this._self, this._then);

  final _UploadedFileEvidence _self;
  final $Res Function(_UploadedFileEvidence) _then;

/// Create a copy of UploadedFileEvidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? type = null,Object? sizeBytes = null,Object? mimeType = freezed,Object? durationSeconds = freezed,Object? width = freezed,Object? height = freezed,}) {
  return _then(_UploadedFileEvidence(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$EngagementEvidence {

/// Device fingerprint hash
 String get deviceFingerprint;/// Play Integrity token (Android) or Device Check token (iOS)
 String? get integrityToken;/// Watch duration in milliseconds
 int get watchDurationMs;/// Video seeked (indicates skipping)
 bool get videoSeeked;/// Screen was visible during watch
 bool get screenVisible;/// App was in foreground
 bool get appInForeground;/// Response time for survey questions (ms per question)
 List<int> get surveyResponseTimesMs;/// Timestamp when video playback started
 DateTime get videoStartedAt;/// Timestamp when survey was submitted
 DateTime get surveySubmittedAt;/// Client-side calculated attention score (0-100)
 double? get clientAttentionScore;/// AdMob transaction ID for server-side verification
 String? get adTransactionId;/// Client-side flag indicating ad was fully watched
 bool? get adFullyWatched;/// AdMob response ID — uniquely identifies the ad impression for debugging
 String? get adResponseId;/// Upload evidence fields
 List<UploadedFileEvidence>? get uploadedFiles; String? get uploadTextResponse; DateTime? get uploadStartedAt; DateTime? get uploadCompletedAt;
/// Create a copy of EngagementEvidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EngagementEvidenceCopyWith<EngagementEvidence> get copyWith => _$EngagementEvidenceCopyWithImpl<EngagementEvidence>(this as EngagementEvidence, _$identity);

  /// Serializes this EngagementEvidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EngagementEvidence&&(identical(other.deviceFingerprint, deviceFingerprint) || other.deviceFingerprint == deviceFingerprint)&&(identical(other.integrityToken, integrityToken) || other.integrityToken == integrityToken)&&(identical(other.watchDurationMs, watchDurationMs) || other.watchDurationMs == watchDurationMs)&&(identical(other.videoSeeked, videoSeeked) || other.videoSeeked == videoSeeked)&&(identical(other.screenVisible, screenVisible) || other.screenVisible == screenVisible)&&(identical(other.appInForeground, appInForeground) || other.appInForeground == appInForeground)&&const DeepCollectionEquality().equals(other.surveyResponseTimesMs, surveyResponseTimesMs)&&(identical(other.videoStartedAt, videoStartedAt) || other.videoStartedAt == videoStartedAt)&&(identical(other.surveySubmittedAt, surveySubmittedAt) || other.surveySubmittedAt == surveySubmittedAt)&&(identical(other.clientAttentionScore, clientAttentionScore) || other.clientAttentionScore == clientAttentionScore)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adFullyWatched, adFullyWatched) || other.adFullyWatched == adFullyWatched)&&(identical(other.adResponseId, adResponseId) || other.adResponseId == adResponseId)&&const DeepCollectionEquality().equals(other.uploadedFiles, uploadedFiles)&&(identical(other.uploadTextResponse, uploadTextResponse) || other.uploadTextResponse == uploadTextResponse)&&(identical(other.uploadStartedAt, uploadStartedAt) || other.uploadStartedAt == uploadStartedAt)&&(identical(other.uploadCompletedAt, uploadCompletedAt) || other.uploadCompletedAt == uploadCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceFingerprint,integrityToken,watchDurationMs,videoSeeked,screenVisible,appInForeground,const DeepCollectionEquality().hash(surveyResponseTimesMs),videoStartedAt,surveySubmittedAt,clientAttentionScore,adTransactionId,adFullyWatched,adResponseId,const DeepCollectionEquality().hash(uploadedFiles),uploadTextResponse,uploadStartedAt,uploadCompletedAt);

@override
String toString() {
  return 'EngagementEvidence(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore, adTransactionId: $adTransactionId, adFullyWatched: $adFullyWatched, adResponseId: $adResponseId, uploadedFiles: $uploadedFiles, uploadTextResponse: $uploadTextResponse, uploadStartedAt: $uploadStartedAt, uploadCompletedAt: $uploadCompletedAt)';
}


}

/// @nodoc
abstract mixin class $EngagementEvidenceCopyWith<$Res>  {
  factory $EngagementEvidenceCopyWith(EngagementEvidence value, $Res Function(EngagementEvidence) _then) = _$EngagementEvidenceCopyWithImpl;
@useResult
$Res call({
 String deviceFingerprint, String? integrityToken, int watchDurationMs, bool videoSeeked, bool screenVisible, bool appInForeground, List<int> surveyResponseTimesMs, DateTime videoStartedAt, DateTime surveySubmittedAt, double? clientAttentionScore, String? adTransactionId, bool? adFullyWatched, String? adResponseId, List<UploadedFileEvidence>? uploadedFiles, String? uploadTextResponse, DateTime? uploadStartedAt, DateTime? uploadCompletedAt
});




}
/// @nodoc
class _$EngagementEvidenceCopyWithImpl<$Res>
    implements $EngagementEvidenceCopyWith<$Res> {
  _$EngagementEvidenceCopyWithImpl(this._self, this._then);

  final EngagementEvidence _self;
  final $Res Function(EngagementEvidence) _then;

/// Create a copy of EngagementEvidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceFingerprint = null,Object? integrityToken = freezed,Object? watchDurationMs = null,Object? videoSeeked = null,Object? screenVisible = null,Object? appInForeground = null,Object? surveyResponseTimesMs = null,Object? videoStartedAt = null,Object? surveySubmittedAt = null,Object? clientAttentionScore = freezed,Object? adTransactionId = freezed,Object? adFullyWatched = freezed,Object? adResponseId = freezed,Object? uploadedFiles = freezed,Object? uploadTextResponse = freezed,Object? uploadStartedAt = freezed,Object? uploadCompletedAt = freezed,}) {
  return _then(_self.copyWith(
deviceFingerprint: null == deviceFingerprint ? _self.deviceFingerprint : deviceFingerprint // ignore: cast_nullable_to_non_nullable
as String,integrityToken: freezed == integrityToken ? _self.integrityToken : integrityToken // ignore: cast_nullable_to_non_nullable
as String?,watchDurationMs: null == watchDurationMs ? _self.watchDurationMs : watchDurationMs // ignore: cast_nullable_to_non_nullable
as int,videoSeeked: null == videoSeeked ? _self.videoSeeked : videoSeeked // ignore: cast_nullable_to_non_nullable
as bool,screenVisible: null == screenVisible ? _self.screenVisible : screenVisible // ignore: cast_nullable_to_non_nullable
as bool,appInForeground: null == appInForeground ? _self.appInForeground : appInForeground // ignore: cast_nullable_to_non_nullable
as bool,surveyResponseTimesMs: null == surveyResponseTimesMs ? _self.surveyResponseTimesMs : surveyResponseTimesMs // ignore: cast_nullable_to_non_nullable
as List<int>,videoStartedAt: null == videoStartedAt ? _self.videoStartedAt : videoStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,surveySubmittedAt: null == surveySubmittedAt ? _self.surveySubmittedAt : surveySubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,clientAttentionScore: freezed == clientAttentionScore ? _self.clientAttentionScore : clientAttentionScore // ignore: cast_nullable_to_non_nullable
as double?,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adFullyWatched: freezed == adFullyWatched ? _self.adFullyWatched : adFullyWatched // ignore: cast_nullable_to_non_nullable
as bool?,adResponseId: freezed == adResponseId ? _self.adResponseId : adResponseId // ignore: cast_nullable_to_non_nullable
as String?,uploadedFiles: freezed == uploadedFiles ? _self.uploadedFiles : uploadedFiles // ignore: cast_nullable_to_non_nullable
as List<UploadedFileEvidence>?,uploadTextResponse: freezed == uploadTextResponse ? _self.uploadTextResponse : uploadTextResponse // ignore: cast_nullable_to_non_nullable
as String?,uploadStartedAt: freezed == uploadStartedAt ? _self.uploadStartedAt : uploadStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,uploadCompletedAt: freezed == uploadCompletedAt ? _self.uploadCompletedAt : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EngagementEvidence].
extension EngagementEvidencePatterns on EngagementEvidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EngagementEvidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EngagementEvidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EngagementEvidence value)  $default,){
final _that = this;
switch (_that) {
case _EngagementEvidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EngagementEvidence value)?  $default,){
final _that = this;
switch (_that) {
case _EngagementEvidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceFingerprint,  String? integrityToken,  int watchDurationMs,  bool videoSeeked,  bool screenVisible,  bool appInForeground,  List<int> surveyResponseTimesMs,  DateTime videoStartedAt,  DateTime surveySubmittedAt,  double? clientAttentionScore,  String? adTransactionId,  bool? adFullyWatched,  String? adResponseId,  List<UploadedFileEvidence>? uploadedFiles,  String? uploadTextResponse,  DateTime? uploadStartedAt,  DateTime? uploadCompletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EngagementEvidence() when $default != null:
return $default(_that.deviceFingerprint,_that.integrityToken,_that.watchDurationMs,_that.videoSeeked,_that.screenVisible,_that.appInForeground,_that.surveyResponseTimesMs,_that.videoStartedAt,_that.surveySubmittedAt,_that.clientAttentionScore,_that.adTransactionId,_that.adFullyWatched,_that.adResponseId,_that.uploadedFiles,_that.uploadTextResponse,_that.uploadStartedAt,_that.uploadCompletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceFingerprint,  String? integrityToken,  int watchDurationMs,  bool videoSeeked,  bool screenVisible,  bool appInForeground,  List<int> surveyResponseTimesMs,  DateTime videoStartedAt,  DateTime surveySubmittedAt,  double? clientAttentionScore,  String? adTransactionId,  bool? adFullyWatched,  String? adResponseId,  List<UploadedFileEvidence>? uploadedFiles,  String? uploadTextResponse,  DateTime? uploadStartedAt,  DateTime? uploadCompletedAt)  $default,) {final _that = this;
switch (_that) {
case _EngagementEvidence():
return $default(_that.deviceFingerprint,_that.integrityToken,_that.watchDurationMs,_that.videoSeeked,_that.screenVisible,_that.appInForeground,_that.surveyResponseTimesMs,_that.videoStartedAt,_that.surveySubmittedAt,_that.clientAttentionScore,_that.adTransactionId,_that.adFullyWatched,_that.adResponseId,_that.uploadedFiles,_that.uploadTextResponse,_that.uploadStartedAt,_that.uploadCompletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceFingerprint,  String? integrityToken,  int watchDurationMs,  bool videoSeeked,  bool screenVisible,  bool appInForeground,  List<int> surveyResponseTimesMs,  DateTime videoStartedAt,  DateTime surveySubmittedAt,  double? clientAttentionScore,  String? adTransactionId,  bool? adFullyWatched,  String? adResponseId,  List<UploadedFileEvidence>? uploadedFiles,  String? uploadTextResponse,  DateTime? uploadStartedAt,  DateTime? uploadCompletedAt)?  $default,) {final _that = this;
switch (_that) {
case _EngagementEvidence() when $default != null:
return $default(_that.deviceFingerprint,_that.integrityToken,_that.watchDurationMs,_that.videoSeeked,_that.screenVisible,_that.appInForeground,_that.surveyResponseTimesMs,_that.videoStartedAt,_that.surveySubmittedAt,_that.clientAttentionScore,_that.adTransactionId,_that.adFullyWatched,_that.adResponseId,_that.uploadedFiles,_that.uploadTextResponse,_that.uploadStartedAt,_that.uploadCompletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EngagementEvidence extends EngagementEvidence {
  const _EngagementEvidence({required this.deviceFingerprint, this.integrityToken, required this.watchDurationMs, required this.videoSeeked, required this.screenVisible, required this.appInForeground, required final  List<int> surveyResponseTimesMs, required this.videoStartedAt, required this.surveySubmittedAt, this.clientAttentionScore, this.adTransactionId, this.adFullyWatched, this.adResponseId, final  List<UploadedFileEvidence>? uploadedFiles, this.uploadTextResponse, this.uploadStartedAt, this.uploadCompletedAt}): _surveyResponseTimesMs = surveyResponseTimesMs,_uploadedFiles = uploadedFiles,super._();
  factory _EngagementEvidence.fromJson(Map<String, dynamic> json) => _$EngagementEvidenceFromJson(json);

/// Device fingerprint hash
@override final  String deviceFingerprint;
/// Play Integrity token (Android) or Device Check token (iOS)
@override final  String? integrityToken;
/// Watch duration in milliseconds
@override final  int watchDurationMs;
/// Video seeked (indicates skipping)
@override final  bool videoSeeked;
/// Screen was visible during watch
@override final  bool screenVisible;
/// App was in foreground
@override final  bool appInForeground;
/// Response time for survey questions (ms per question)
 final  List<int> _surveyResponseTimesMs;
/// Response time for survey questions (ms per question)
@override List<int> get surveyResponseTimesMs {
  if (_surveyResponseTimesMs is EqualUnmodifiableListView) return _surveyResponseTimesMs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surveyResponseTimesMs);
}

/// Timestamp when video playback started
@override final  DateTime videoStartedAt;
/// Timestamp when survey was submitted
@override final  DateTime surveySubmittedAt;
/// Client-side calculated attention score (0-100)
@override final  double? clientAttentionScore;
/// AdMob transaction ID for server-side verification
@override final  String? adTransactionId;
/// Client-side flag indicating ad was fully watched
@override final  bool? adFullyWatched;
/// AdMob response ID — uniquely identifies the ad impression for debugging
@override final  String? adResponseId;
/// Upload evidence fields
 final  List<UploadedFileEvidence>? _uploadedFiles;
/// Upload evidence fields
@override List<UploadedFileEvidence>? get uploadedFiles {
  final value = _uploadedFiles;
  if (value == null) return null;
  if (_uploadedFiles is EqualUnmodifiableListView) return _uploadedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? uploadTextResponse;
@override final  DateTime? uploadStartedAt;
@override final  DateTime? uploadCompletedAt;

/// Create a copy of EngagementEvidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EngagementEvidenceCopyWith<_EngagementEvidence> get copyWith => __$EngagementEvidenceCopyWithImpl<_EngagementEvidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EngagementEvidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EngagementEvidence&&(identical(other.deviceFingerprint, deviceFingerprint) || other.deviceFingerprint == deviceFingerprint)&&(identical(other.integrityToken, integrityToken) || other.integrityToken == integrityToken)&&(identical(other.watchDurationMs, watchDurationMs) || other.watchDurationMs == watchDurationMs)&&(identical(other.videoSeeked, videoSeeked) || other.videoSeeked == videoSeeked)&&(identical(other.screenVisible, screenVisible) || other.screenVisible == screenVisible)&&(identical(other.appInForeground, appInForeground) || other.appInForeground == appInForeground)&&const DeepCollectionEquality().equals(other._surveyResponseTimesMs, _surveyResponseTimesMs)&&(identical(other.videoStartedAt, videoStartedAt) || other.videoStartedAt == videoStartedAt)&&(identical(other.surveySubmittedAt, surveySubmittedAt) || other.surveySubmittedAt == surveySubmittedAt)&&(identical(other.clientAttentionScore, clientAttentionScore) || other.clientAttentionScore == clientAttentionScore)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adFullyWatched, adFullyWatched) || other.adFullyWatched == adFullyWatched)&&(identical(other.adResponseId, adResponseId) || other.adResponseId == adResponseId)&&const DeepCollectionEquality().equals(other._uploadedFiles, _uploadedFiles)&&(identical(other.uploadTextResponse, uploadTextResponse) || other.uploadTextResponse == uploadTextResponse)&&(identical(other.uploadStartedAt, uploadStartedAt) || other.uploadStartedAt == uploadStartedAt)&&(identical(other.uploadCompletedAt, uploadCompletedAt) || other.uploadCompletedAt == uploadCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceFingerprint,integrityToken,watchDurationMs,videoSeeked,screenVisible,appInForeground,const DeepCollectionEquality().hash(_surveyResponseTimesMs),videoStartedAt,surveySubmittedAt,clientAttentionScore,adTransactionId,adFullyWatched,adResponseId,const DeepCollectionEquality().hash(_uploadedFiles),uploadTextResponse,uploadStartedAt,uploadCompletedAt);

@override
String toString() {
  return 'EngagementEvidence(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore, adTransactionId: $adTransactionId, adFullyWatched: $adFullyWatched, adResponseId: $adResponseId, uploadedFiles: $uploadedFiles, uploadTextResponse: $uploadTextResponse, uploadStartedAt: $uploadStartedAt, uploadCompletedAt: $uploadCompletedAt)';
}


}

/// @nodoc
abstract mixin class _$EngagementEvidenceCopyWith<$Res> implements $EngagementEvidenceCopyWith<$Res> {
  factory _$EngagementEvidenceCopyWith(_EngagementEvidence value, $Res Function(_EngagementEvidence) _then) = __$EngagementEvidenceCopyWithImpl;
@override @useResult
$Res call({
 String deviceFingerprint, String? integrityToken, int watchDurationMs, bool videoSeeked, bool screenVisible, bool appInForeground, List<int> surveyResponseTimesMs, DateTime videoStartedAt, DateTime surveySubmittedAt, double? clientAttentionScore, String? adTransactionId, bool? adFullyWatched, String? adResponseId, List<UploadedFileEvidence>? uploadedFiles, String? uploadTextResponse, DateTime? uploadStartedAt, DateTime? uploadCompletedAt
});




}
/// @nodoc
class __$EngagementEvidenceCopyWithImpl<$Res>
    implements _$EngagementEvidenceCopyWith<$Res> {
  __$EngagementEvidenceCopyWithImpl(this._self, this._then);

  final _EngagementEvidence _self;
  final $Res Function(_EngagementEvidence) _then;

/// Create a copy of EngagementEvidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceFingerprint = null,Object? integrityToken = freezed,Object? watchDurationMs = null,Object? videoSeeked = null,Object? screenVisible = null,Object? appInForeground = null,Object? surveyResponseTimesMs = null,Object? videoStartedAt = null,Object? surveySubmittedAt = null,Object? clientAttentionScore = freezed,Object? adTransactionId = freezed,Object? adFullyWatched = freezed,Object? adResponseId = freezed,Object? uploadedFiles = freezed,Object? uploadTextResponse = freezed,Object? uploadStartedAt = freezed,Object? uploadCompletedAt = freezed,}) {
  return _then(_EngagementEvidence(
deviceFingerprint: null == deviceFingerprint ? _self.deviceFingerprint : deviceFingerprint // ignore: cast_nullable_to_non_nullable
as String,integrityToken: freezed == integrityToken ? _self.integrityToken : integrityToken // ignore: cast_nullable_to_non_nullable
as String?,watchDurationMs: null == watchDurationMs ? _self.watchDurationMs : watchDurationMs // ignore: cast_nullable_to_non_nullable
as int,videoSeeked: null == videoSeeked ? _self.videoSeeked : videoSeeked // ignore: cast_nullable_to_non_nullable
as bool,screenVisible: null == screenVisible ? _self.screenVisible : screenVisible // ignore: cast_nullable_to_non_nullable
as bool,appInForeground: null == appInForeground ? _self.appInForeground : appInForeground // ignore: cast_nullable_to_non_nullable
as bool,surveyResponseTimesMs: null == surveyResponseTimesMs ? _self._surveyResponseTimesMs : surveyResponseTimesMs // ignore: cast_nullable_to_non_nullable
as List<int>,videoStartedAt: null == videoStartedAt ? _self.videoStartedAt : videoStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,surveySubmittedAt: null == surveySubmittedAt ? _self.surveySubmittedAt : surveySubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,clientAttentionScore: freezed == clientAttentionScore ? _self.clientAttentionScore : clientAttentionScore // ignore: cast_nullable_to_non_nullable
as double?,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adFullyWatched: freezed == adFullyWatched ? _self.adFullyWatched : adFullyWatched // ignore: cast_nullable_to_non_nullable
as bool?,adResponseId: freezed == adResponseId ? _self.adResponseId : adResponseId // ignore: cast_nullable_to_non_nullable
as String?,uploadedFiles: freezed == uploadedFiles ? _self._uploadedFiles : uploadedFiles // ignore: cast_nullable_to_non_nullable
as List<UploadedFileEvidence>?,uploadTextResponse: freezed == uploadTextResponse ? _self.uploadTextResponse : uploadTextResponse // ignore: cast_nullable_to_non_nullable
as String?,uploadStartedAt: freezed == uploadStartedAt ? _self.uploadStartedAt : uploadStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,uploadCompletedAt: freezed == uploadCompletedAt ? _self.uploadCompletedAt : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
