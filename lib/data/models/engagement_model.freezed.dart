// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurveyResponseModel {

 String get questionId; String get questionType; DateTime get answeredAt;// single_select
 String? get selectedOption;// multi_select
 List<String>? get selectedOptions;// text_input
 List<String>? get textResponses;// likert
 int? get likertValue;// star_tags
 int? get starRating; List<String>? get selectedTags;// slider
 double? get sliderValue;// attention check result
 bool? get isCorrect;
/// Create a copy of SurveyResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyResponseModelCopyWith<SurveyResponseModel> get copyWith => _$SurveyResponseModelCopyWithImpl<SurveyResponseModel>(this as SurveyResponseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyResponseModel&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&const DeepCollectionEquality().equals(other.selectedOptions, selectedOptions)&&const DeepCollectionEquality().equals(other.textResponses, textResponses)&&(identical(other.likertValue, likertValue) || other.likertValue == likertValue)&&(identical(other.starRating, starRating) || other.starRating == starRating)&&const DeepCollectionEquality().equals(other.selectedTags, selectedTags)&&(identical(other.sliderValue, sliderValue) || other.sliderValue == sliderValue)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,questionType,answeredAt,selectedOption,const DeepCollectionEquality().hash(selectedOptions),const DeepCollectionEquality().hash(textResponses),likertValue,starRating,const DeepCollectionEquality().hash(selectedTags),sliderValue,isCorrect);

@override
String toString() {
  return 'SurveyResponseModel(questionId: $questionId, questionType: $questionType, answeredAt: $answeredAt, selectedOption: $selectedOption, selectedOptions: $selectedOptions, textResponses: $textResponses, likertValue: $likertValue, starRating: $starRating, selectedTags: $selectedTags, sliderValue: $sliderValue, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class $SurveyResponseModelCopyWith<$Res>  {
  factory $SurveyResponseModelCopyWith(SurveyResponseModel value, $Res Function(SurveyResponseModel) _then) = _$SurveyResponseModelCopyWithImpl;
@useResult
$Res call({
 String questionId, String questionType, DateTime answeredAt, String? selectedOption, List<String>? selectedOptions, List<String>? textResponses, int? likertValue, int? starRating, List<String>? selectedTags, double? sliderValue, bool? isCorrect
});




}
/// @nodoc
class _$SurveyResponseModelCopyWithImpl<$Res>
    implements $SurveyResponseModelCopyWith<$Res> {
  _$SurveyResponseModelCopyWithImpl(this._self, this._then);

  final SurveyResponseModel _self;
  final $Res Function(SurveyResponseModel) _then;

/// Create a copy of SurveyResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? questionType = null,Object? answeredAt = null,Object? selectedOption = freezed,Object? selectedOptions = freezed,Object? textResponses = freezed,Object? likertValue = freezed,Object? starRating = freezed,Object? selectedTags = freezed,Object? sliderValue = freezed,Object? isCorrect = freezed,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,selectedOption: freezed == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String?,selectedOptions: freezed == selectedOptions ? _self.selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as List<String>?,textResponses: freezed == textResponses ? _self.textResponses : textResponses // ignore: cast_nullable_to_non_nullable
as List<String>?,likertValue: freezed == likertValue ? _self.likertValue : likertValue // ignore: cast_nullable_to_non_nullable
as int?,starRating: freezed == starRating ? _self.starRating : starRating // ignore: cast_nullable_to_non_nullable
as int?,selectedTags: freezed == selectedTags ? _self.selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<String>?,sliderValue: freezed == sliderValue ? _self.sliderValue : sliderValue // ignore: cast_nullable_to_non_nullable
as double?,isCorrect: freezed == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyResponseModel].
extension SurveyResponseModelPatterns on SurveyResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SurveyResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String questionType,  DateTime answeredAt,  String? selectedOption,  List<String>? selectedOptions,  List<String>? textResponses,  int? likertValue,  int? starRating,  List<String>? selectedTags,  double? sliderValue,  bool? isCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyResponseModel() when $default != null:
return $default(_that.questionId,_that.questionType,_that.answeredAt,_that.selectedOption,_that.selectedOptions,_that.textResponses,_that.likertValue,_that.starRating,_that.selectedTags,_that.sliderValue,_that.isCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String questionType,  DateTime answeredAt,  String? selectedOption,  List<String>? selectedOptions,  List<String>? textResponses,  int? likertValue,  int? starRating,  List<String>? selectedTags,  double? sliderValue,  bool? isCorrect)  $default,) {final _that = this;
switch (_that) {
case _SurveyResponseModel():
return $default(_that.questionId,_that.questionType,_that.answeredAt,_that.selectedOption,_that.selectedOptions,_that.textResponses,_that.likertValue,_that.starRating,_that.selectedTags,_that.sliderValue,_that.isCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String questionType,  DateTime answeredAt,  String? selectedOption,  List<String>? selectedOptions,  List<String>? textResponses,  int? likertValue,  int? starRating,  List<String>? selectedTags,  double? sliderValue,  bool? isCorrect)?  $default,) {final _that = this;
switch (_that) {
case _SurveyResponseModel() when $default != null:
return $default(_that.questionId,_that.questionType,_that.answeredAt,_that.selectedOption,_that.selectedOptions,_that.textResponses,_that.likertValue,_that.starRating,_that.selectedTags,_that.sliderValue,_that.isCorrect);case _:
  return null;

}
}

}

/// @nodoc


class _SurveyResponseModel extends SurveyResponseModel {
  const _SurveyResponseModel({required this.questionId, required this.questionType, required this.answeredAt, this.selectedOption, final  List<String>? selectedOptions, final  List<String>? textResponses, this.likertValue, this.starRating, final  List<String>? selectedTags, this.sliderValue, this.isCorrect}): _selectedOptions = selectedOptions,_textResponses = textResponses,_selectedTags = selectedTags,super._();
  

@override final  String questionId;
@override final  String questionType;
@override final  DateTime answeredAt;
// single_select
@override final  String? selectedOption;
// multi_select
 final  List<String>? _selectedOptions;
// multi_select
@override List<String>? get selectedOptions {
  final value = _selectedOptions;
  if (value == null) return null;
  if (_selectedOptions is EqualUnmodifiableListView) return _selectedOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// text_input
 final  List<String>? _textResponses;
// text_input
@override List<String>? get textResponses {
  final value = _textResponses;
  if (value == null) return null;
  if (_textResponses is EqualUnmodifiableListView) return _textResponses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// likert
@override final  int? likertValue;
// star_tags
@override final  int? starRating;
 final  List<String>? _selectedTags;
@override List<String>? get selectedTags {
  final value = _selectedTags;
  if (value == null) return null;
  if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// slider
@override final  double? sliderValue;
// attention check result
@override final  bool? isCorrect;

/// Create a copy of SurveyResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyResponseModelCopyWith<_SurveyResponseModel> get copyWith => __$SurveyResponseModelCopyWithImpl<_SurveyResponseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyResponseModel&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&const DeepCollectionEquality().equals(other._selectedOptions, _selectedOptions)&&const DeepCollectionEquality().equals(other._textResponses, _textResponses)&&(identical(other.likertValue, likertValue) || other.likertValue == likertValue)&&(identical(other.starRating, starRating) || other.starRating == starRating)&&const DeepCollectionEquality().equals(other._selectedTags, _selectedTags)&&(identical(other.sliderValue, sliderValue) || other.sliderValue == sliderValue)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,questionType,answeredAt,selectedOption,const DeepCollectionEquality().hash(_selectedOptions),const DeepCollectionEquality().hash(_textResponses),likertValue,starRating,const DeepCollectionEquality().hash(_selectedTags),sliderValue,isCorrect);

@override
String toString() {
  return 'SurveyResponseModel(questionId: $questionId, questionType: $questionType, answeredAt: $answeredAt, selectedOption: $selectedOption, selectedOptions: $selectedOptions, textResponses: $textResponses, likertValue: $likertValue, starRating: $starRating, selectedTags: $selectedTags, sliderValue: $sliderValue, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class _$SurveyResponseModelCopyWith<$Res> implements $SurveyResponseModelCopyWith<$Res> {
  factory _$SurveyResponseModelCopyWith(_SurveyResponseModel value, $Res Function(_SurveyResponseModel) _then) = __$SurveyResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String questionType, DateTime answeredAt, String? selectedOption, List<String>? selectedOptions, List<String>? textResponses, int? likertValue, int? starRating, List<String>? selectedTags, double? sliderValue, bool? isCorrect
});




}
/// @nodoc
class __$SurveyResponseModelCopyWithImpl<$Res>
    implements _$SurveyResponseModelCopyWith<$Res> {
  __$SurveyResponseModelCopyWithImpl(this._self, this._then);

  final _SurveyResponseModel _self;
  final $Res Function(_SurveyResponseModel) _then;

/// Create a copy of SurveyResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? questionType = null,Object? answeredAt = null,Object? selectedOption = freezed,Object? selectedOptions = freezed,Object? textResponses = freezed,Object? likertValue = freezed,Object? starRating = freezed,Object? selectedTags = freezed,Object? sliderValue = freezed,Object? isCorrect = freezed,}) {
  return _then(_SurveyResponseModel(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,selectedOption: freezed == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String?,selectedOptions: freezed == selectedOptions ? _self._selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as List<String>?,textResponses: freezed == textResponses ? _self._textResponses : textResponses // ignore: cast_nullable_to_non_nullable
as List<String>?,likertValue: freezed == likertValue ? _self.likertValue : likertValue // ignore: cast_nullable_to_non_nullable
as int?,starRating: freezed == starRating ? _self.starRating : starRating // ignore: cast_nullable_to_non_nullable
as int?,selectedTags: freezed == selectedTags ? _self._selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<String>?,sliderValue: freezed == sliderValue ? _self.sliderValue : sliderValue // ignore: cast_nullable_to_non_nullable
as double?,isCorrect: freezed == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$EngagementEvidenceModel {

 String get deviceFingerprint; String? get integrityToken; String? get integrityNonce; int get watchDurationMs; bool get videoSeeked; bool get screenVisible; bool get appInForeground; List<int> get surveyResponseTimesMs; DateTime get videoStartedAt; DateTime get surveySubmittedAt; double? get clientAttentionScore;// AdMob verification fields
 String? get adTransactionId; bool? get adFullyWatched; String? get adResponseId;// Upload evidence fields
 List<Map<String, dynamic>>? get uploadedFiles; String? get uploadTextResponse; DateTime? get uploadStartedAt; DateTime? get uploadCompletedAt;
/// Create a copy of EngagementEvidenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EngagementEvidenceModelCopyWith<EngagementEvidenceModel> get copyWith => _$EngagementEvidenceModelCopyWithImpl<EngagementEvidenceModel>(this as EngagementEvidenceModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EngagementEvidenceModel&&(identical(other.deviceFingerprint, deviceFingerprint) || other.deviceFingerprint == deviceFingerprint)&&(identical(other.integrityToken, integrityToken) || other.integrityToken == integrityToken)&&(identical(other.integrityNonce, integrityNonce) || other.integrityNonce == integrityNonce)&&(identical(other.watchDurationMs, watchDurationMs) || other.watchDurationMs == watchDurationMs)&&(identical(other.videoSeeked, videoSeeked) || other.videoSeeked == videoSeeked)&&(identical(other.screenVisible, screenVisible) || other.screenVisible == screenVisible)&&(identical(other.appInForeground, appInForeground) || other.appInForeground == appInForeground)&&const DeepCollectionEquality().equals(other.surveyResponseTimesMs, surveyResponseTimesMs)&&(identical(other.videoStartedAt, videoStartedAt) || other.videoStartedAt == videoStartedAt)&&(identical(other.surveySubmittedAt, surveySubmittedAt) || other.surveySubmittedAt == surveySubmittedAt)&&(identical(other.clientAttentionScore, clientAttentionScore) || other.clientAttentionScore == clientAttentionScore)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adFullyWatched, adFullyWatched) || other.adFullyWatched == adFullyWatched)&&(identical(other.adResponseId, adResponseId) || other.adResponseId == adResponseId)&&const DeepCollectionEquality().equals(other.uploadedFiles, uploadedFiles)&&(identical(other.uploadTextResponse, uploadTextResponse) || other.uploadTextResponse == uploadTextResponse)&&(identical(other.uploadStartedAt, uploadStartedAt) || other.uploadStartedAt == uploadStartedAt)&&(identical(other.uploadCompletedAt, uploadCompletedAt) || other.uploadCompletedAt == uploadCompletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,deviceFingerprint,integrityToken,integrityNonce,watchDurationMs,videoSeeked,screenVisible,appInForeground,const DeepCollectionEquality().hash(surveyResponseTimesMs),videoStartedAt,surveySubmittedAt,clientAttentionScore,adTransactionId,adFullyWatched,adResponseId,const DeepCollectionEquality().hash(uploadedFiles),uploadTextResponse,uploadStartedAt,uploadCompletedAt);

@override
String toString() {
  return 'EngagementEvidenceModel(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, integrityNonce: $integrityNonce, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore, adTransactionId: $adTransactionId, adFullyWatched: $adFullyWatched, adResponseId: $adResponseId, uploadedFiles: $uploadedFiles, uploadTextResponse: $uploadTextResponse, uploadStartedAt: $uploadStartedAt, uploadCompletedAt: $uploadCompletedAt)';
}


}

/// @nodoc
abstract mixin class $EngagementEvidenceModelCopyWith<$Res>  {
  factory $EngagementEvidenceModelCopyWith(EngagementEvidenceModel value, $Res Function(EngagementEvidenceModel) _then) = _$EngagementEvidenceModelCopyWithImpl;
@useResult
$Res call({
 String deviceFingerprint, String? integrityToken, String? integrityNonce, int watchDurationMs, bool videoSeeked, bool screenVisible, bool appInForeground, List<int> surveyResponseTimesMs, DateTime videoStartedAt, DateTime surveySubmittedAt, double? clientAttentionScore, String? adTransactionId, bool? adFullyWatched, String? adResponseId, List<Map<String, dynamic>>? uploadedFiles, String? uploadTextResponse, DateTime? uploadStartedAt, DateTime? uploadCompletedAt
});




}
/// @nodoc
class _$EngagementEvidenceModelCopyWithImpl<$Res>
    implements $EngagementEvidenceModelCopyWith<$Res> {
  _$EngagementEvidenceModelCopyWithImpl(this._self, this._then);

  final EngagementEvidenceModel _self;
  final $Res Function(EngagementEvidenceModel) _then;

/// Create a copy of EngagementEvidenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceFingerprint = null,Object? integrityToken = freezed,Object? integrityNonce = freezed,Object? watchDurationMs = null,Object? videoSeeked = null,Object? screenVisible = null,Object? appInForeground = null,Object? surveyResponseTimesMs = null,Object? videoStartedAt = null,Object? surveySubmittedAt = null,Object? clientAttentionScore = freezed,Object? adTransactionId = freezed,Object? adFullyWatched = freezed,Object? adResponseId = freezed,Object? uploadedFiles = freezed,Object? uploadTextResponse = freezed,Object? uploadStartedAt = freezed,Object? uploadCompletedAt = freezed,}) {
  return _then(_self.copyWith(
deviceFingerprint: null == deviceFingerprint ? _self.deviceFingerprint : deviceFingerprint // ignore: cast_nullable_to_non_nullable
as String,integrityToken: freezed == integrityToken ? _self.integrityToken : integrityToken // ignore: cast_nullable_to_non_nullable
as String?,integrityNonce: freezed == integrityNonce ? _self.integrityNonce : integrityNonce // ignore: cast_nullable_to_non_nullable
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
as List<Map<String, dynamic>>?,uploadTextResponse: freezed == uploadTextResponse ? _self.uploadTextResponse : uploadTextResponse // ignore: cast_nullable_to_non_nullable
as String?,uploadStartedAt: freezed == uploadStartedAt ? _self.uploadStartedAt : uploadStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,uploadCompletedAt: freezed == uploadCompletedAt ? _self.uploadCompletedAt : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EngagementEvidenceModel].
extension EngagementEvidenceModelPatterns on EngagementEvidenceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EngagementEvidenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EngagementEvidenceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EngagementEvidenceModel value)  $default,){
final _that = this;
switch (_that) {
case _EngagementEvidenceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EngagementEvidenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _EngagementEvidenceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceFingerprint,  String? integrityToken,  String? integrityNonce,  int watchDurationMs,  bool videoSeeked,  bool screenVisible,  bool appInForeground,  List<int> surveyResponseTimesMs,  DateTime videoStartedAt,  DateTime surveySubmittedAt,  double? clientAttentionScore,  String? adTransactionId,  bool? adFullyWatched,  String? adResponseId,  List<Map<String, dynamic>>? uploadedFiles,  String? uploadTextResponse,  DateTime? uploadStartedAt,  DateTime? uploadCompletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EngagementEvidenceModel() when $default != null:
return $default(_that.deviceFingerprint,_that.integrityToken,_that.integrityNonce,_that.watchDurationMs,_that.videoSeeked,_that.screenVisible,_that.appInForeground,_that.surveyResponseTimesMs,_that.videoStartedAt,_that.surveySubmittedAt,_that.clientAttentionScore,_that.adTransactionId,_that.adFullyWatched,_that.adResponseId,_that.uploadedFiles,_that.uploadTextResponse,_that.uploadStartedAt,_that.uploadCompletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceFingerprint,  String? integrityToken,  String? integrityNonce,  int watchDurationMs,  bool videoSeeked,  bool screenVisible,  bool appInForeground,  List<int> surveyResponseTimesMs,  DateTime videoStartedAt,  DateTime surveySubmittedAt,  double? clientAttentionScore,  String? adTransactionId,  bool? adFullyWatched,  String? adResponseId,  List<Map<String, dynamic>>? uploadedFiles,  String? uploadTextResponse,  DateTime? uploadStartedAt,  DateTime? uploadCompletedAt)  $default,) {final _that = this;
switch (_that) {
case _EngagementEvidenceModel():
return $default(_that.deviceFingerprint,_that.integrityToken,_that.integrityNonce,_that.watchDurationMs,_that.videoSeeked,_that.screenVisible,_that.appInForeground,_that.surveyResponseTimesMs,_that.videoStartedAt,_that.surveySubmittedAt,_that.clientAttentionScore,_that.adTransactionId,_that.adFullyWatched,_that.adResponseId,_that.uploadedFiles,_that.uploadTextResponse,_that.uploadStartedAt,_that.uploadCompletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceFingerprint,  String? integrityToken,  String? integrityNonce,  int watchDurationMs,  bool videoSeeked,  bool screenVisible,  bool appInForeground,  List<int> surveyResponseTimesMs,  DateTime videoStartedAt,  DateTime surveySubmittedAt,  double? clientAttentionScore,  String? adTransactionId,  bool? adFullyWatched,  String? adResponseId,  List<Map<String, dynamic>>? uploadedFiles,  String? uploadTextResponse,  DateTime? uploadStartedAt,  DateTime? uploadCompletedAt)?  $default,) {final _that = this;
switch (_that) {
case _EngagementEvidenceModel() when $default != null:
return $default(_that.deviceFingerprint,_that.integrityToken,_that.integrityNonce,_that.watchDurationMs,_that.videoSeeked,_that.screenVisible,_that.appInForeground,_that.surveyResponseTimesMs,_that.videoStartedAt,_that.surveySubmittedAt,_that.clientAttentionScore,_that.adTransactionId,_that.adFullyWatched,_that.adResponseId,_that.uploadedFiles,_that.uploadTextResponse,_that.uploadStartedAt,_that.uploadCompletedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EngagementEvidenceModel extends EngagementEvidenceModel {
  const _EngagementEvidenceModel({required this.deviceFingerprint, this.integrityToken, this.integrityNonce, required this.watchDurationMs, required this.videoSeeked, required this.screenVisible, required this.appInForeground, required final  List<int> surveyResponseTimesMs, required this.videoStartedAt, required this.surveySubmittedAt, this.clientAttentionScore, this.adTransactionId, this.adFullyWatched, this.adResponseId, final  List<Map<String, dynamic>>? uploadedFiles, this.uploadTextResponse, this.uploadStartedAt, this.uploadCompletedAt}): _surveyResponseTimesMs = surveyResponseTimesMs,_uploadedFiles = uploadedFiles,super._();
  

@override final  String deviceFingerprint;
@override final  String? integrityToken;
@override final  String? integrityNonce;
@override final  int watchDurationMs;
@override final  bool videoSeeked;
@override final  bool screenVisible;
@override final  bool appInForeground;
 final  List<int> _surveyResponseTimesMs;
@override List<int> get surveyResponseTimesMs {
  if (_surveyResponseTimesMs is EqualUnmodifiableListView) return _surveyResponseTimesMs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surveyResponseTimesMs);
}

@override final  DateTime videoStartedAt;
@override final  DateTime surveySubmittedAt;
@override final  double? clientAttentionScore;
// AdMob verification fields
@override final  String? adTransactionId;
@override final  bool? adFullyWatched;
@override final  String? adResponseId;
// Upload evidence fields
 final  List<Map<String, dynamic>>? _uploadedFiles;
// Upload evidence fields
@override List<Map<String, dynamic>>? get uploadedFiles {
  final value = _uploadedFiles;
  if (value == null) return null;
  if (_uploadedFiles is EqualUnmodifiableListView) return _uploadedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? uploadTextResponse;
@override final  DateTime? uploadStartedAt;
@override final  DateTime? uploadCompletedAt;

/// Create a copy of EngagementEvidenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EngagementEvidenceModelCopyWith<_EngagementEvidenceModel> get copyWith => __$EngagementEvidenceModelCopyWithImpl<_EngagementEvidenceModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EngagementEvidenceModel&&(identical(other.deviceFingerprint, deviceFingerprint) || other.deviceFingerprint == deviceFingerprint)&&(identical(other.integrityToken, integrityToken) || other.integrityToken == integrityToken)&&(identical(other.integrityNonce, integrityNonce) || other.integrityNonce == integrityNonce)&&(identical(other.watchDurationMs, watchDurationMs) || other.watchDurationMs == watchDurationMs)&&(identical(other.videoSeeked, videoSeeked) || other.videoSeeked == videoSeeked)&&(identical(other.screenVisible, screenVisible) || other.screenVisible == screenVisible)&&(identical(other.appInForeground, appInForeground) || other.appInForeground == appInForeground)&&const DeepCollectionEquality().equals(other._surveyResponseTimesMs, _surveyResponseTimesMs)&&(identical(other.videoStartedAt, videoStartedAt) || other.videoStartedAt == videoStartedAt)&&(identical(other.surveySubmittedAt, surveySubmittedAt) || other.surveySubmittedAt == surveySubmittedAt)&&(identical(other.clientAttentionScore, clientAttentionScore) || other.clientAttentionScore == clientAttentionScore)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adFullyWatched, adFullyWatched) || other.adFullyWatched == adFullyWatched)&&(identical(other.adResponseId, adResponseId) || other.adResponseId == adResponseId)&&const DeepCollectionEquality().equals(other._uploadedFiles, _uploadedFiles)&&(identical(other.uploadTextResponse, uploadTextResponse) || other.uploadTextResponse == uploadTextResponse)&&(identical(other.uploadStartedAt, uploadStartedAt) || other.uploadStartedAt == uploadStartedAt)&&(identical(other.uploadCompletedAt, uploadCompletedAt) || other.uploadCompletedAt == uploadCompletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,deviceFingerprint,integrityToken,integrityNonce,watchDurationMs,videoSeeked,screenVisible,appInForeground,const DeepCollectionEquality().hash(_surveyResponseTimesMs),videoStartedAt,surveySubmittedAt,clientAttentionScore,adTransactionId,adFullyWatched,adResponseId,const DeepCollectionEquality().hash(_uploadedFiles),uploadTextResponse,uploadStartedAt,uploadCompletedAt);

@override
String toString() {
  return 'EngagementEvidenceModel(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, integrityNonce: $integrityNonce, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore, adTransactionId: $adTransactionId, adFullyWatched: $adFullyWatched, adResponseId: $adResponseId, uploadedFiles: $uploadedFiles, uploadTextResponse: $uploadTextResponse, uploadStartedAt: $uploadStartedAt, uploadCompletedAt: $uploadCompletedAt)';
}


}

/// @nodoc
abstract mixin class _$EngagementEvidenceModelCopyWith<$Res> implements $EngagementEvidenceModelCopyWith<$Res> {
  factory _$EngagementEvidenceModelCopyWith(_EngagementEvidenceModel value, $Res Function(_EngagementEvidenceModel) _then) = __$EngagementEvidenceModelCopyWithImpl;
@override @useResult
$Res call({
 String deviceFingerprint, String? integrityToken, String? integrityNonce, int watchDurationMs, bool videoSeeked, bool screenVisible, bool appInForeground, List<int> surveyResponseTimesMs, DateTime videoStartedAt, DateTime surveySubmittedAt, double? clientAttentionScore, String? adTransactionId, bool? adFullyWatched, String? adResponseId, List<Map<String, dynamic>>? uploadedFiles, String? uploadTextResponse, DateTime? uploadStartedAt, DateTime? uploadCompletedAt
});




}
/// @nodoc
class __$EngagementEvidenceModelCopyWithImpl<$Res>
    implements _$EngagementEvidenceModelCopyWith<$Res> {
  __$EngagementEvidenceModelCopyWithImpl(this._self, this._then);

  final _EngagementEvidenceModel _self;
  final $Res Function(_EngagementEvidenceModel) _then;

/// Create a copy of EngagementEvidenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceFingerprint = null,Object? integrityToken = freezed,Object? integrityNonce = freezed,Object? watchDurationMs = null,Object? videoSeeked = null,Object? screenVisible = null,Object? appInForeground = null,Object? surveyResponseTimesMs = null,Object? videoStartedAt = null,Object? surveySubmittedAt = null,Object? clientAttentionScore = freezed,Object? adTransactionId = freezed,Object? adFullyWatched = freezed,Object? adResponseId = freezed,Object? uploadedFiles = freezed,Object? uploadTextResponse = freezed,Object? uploadStartedAt = freezed,Object? uploadCompletedAt = freezed,}) {
  return _then(_EngagementEvidenceModel(
deviceFingerprint: null == deviceFingerprint ? _self.deviceFingerprint : deviceFingerprint // ignore: cast_nullable_to_non_nullable
as String,integrityToken: freezed == integrityToken ? _self.integrityToken : integrityToken // ignore: cast_nullable_to_non_nullable
as String?,integrityNonce: freezed == integrityNonce ? _self.integrityNonce : integrityNonce // ignore: cast_nullable_to_non_nullable
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
as List<Map<String, dynamic>>?,uploadTextResponse: freezed == uploadTextResponse ? _self.uploadTextResponse : uploadTextResponse // ignore: cast_nullable_to_non_nullable
as String?,uploadStartedAt: freezed == uploadStartedAt ? _self.uploadStartedAt : uploadStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,uploadCompletedAt: freezed == uploadCompletedAt ? _self.uploadCompletedAt : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$EngagementModel {

 String get id; String get userId; String? get audienceCampaignId; String get earnOpportunityId; String get status; DateTime get startedAt; DateTime? get completedAt; int get watchDurationSeconds; int get requiredDurationSeconds; List<SurveyResponseModel> get answers; EngagementEvidenceModel? get evidence; double? get tokensEarned; double? get totalTokensGenerated; String? get failureReason; int get attemptNumber; DateTime get createdAt; DateTime? get updatedAt;// Denormalized fields for targeting queries
 String? get threadId; String? get clientId;// Streak audit fields
 int? get streakDayAtCompletion; double? get multiplierApplied;// AdMob tracking fields
 bool get adWatched; String? get adTransactionId; DateTime? get adCompletedAt;// Reward escrow fields
 String? get rewardItemId; String? get rewardCampaignName; String? get rewardType;
/// Create a copy of EngagementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EngagementModelCopyWith<EngagementModel> get copyWith => _$EngagementModelCopyWithImpl<EngagementModel>(this as EngagementModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EngagementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.audienceCampaignId, audienceCampaignId) || other.audienceCampaignId == audienceCampaignId)&&(identical(other.earnOpportunityId, earnOpportunityId) || other.earnOpportunityId == earnOpportunityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds)&&(identical(other.requiredDurationSeconds, requiredDurationSeconds) || other.requiredDurationSeconds == requiredDurationSeconds)&&const DeepCollectionEquality().equals(other.answers, answers)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.totalTokensGenerated, totalTokensGenerated) || other.totalTokensGenerated == totalTokensGenerated)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.attemptNumber, attemptNumber) || other.attemptNumber == attemptNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.streakDayAtCompletion, streakDayAtCompletion) || other.streakDayAtCompletion == streakDayAtCompletion)&&(identical(other.multiplierApplied, multiplierApplied) || other.multiplierApplied == multiplierApplied)&&(identical(other.adWatched, adWatched) || other.adWatched == adWatched)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adCompletedAt, adCompletedAt) || other.adCompletedAt == adCompletedAt)&&(identical(other.rewardItemId, rewardItemId) || other.rewardItemId == rewardItemId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,audienceCampaignId,earnOpportunityId,status,startedAt,completedAt,watchDurationSeconds,requiredDurationSeconds,const DeepCollectionEquality().hash(answers),evidence,tokensEarned,totalTokensGenerated,failureReason,attemptNumber,createdAt,updatedAt,threadId,clientId,streakDayAtCompletion,multiplierApplied,adWatched,adTransactionId,adCompletedAt,rewardItemId,rewardCampaignName,rewardType]);

@override
String toString() {
  return 'EngagementModel(id: $id, userId: $userId, audienceCampaignId: $audienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, totalTokensGenerated: $totalTokensGenerated, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
}


}

/// @nodoc
abstract mixin class $EngagementModelCopyWith<$Res>  {
  factory $EngagementModelCopyWith(EngagementModel value, $Res Function(EngagementModel) _then) = _$EngagementModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String? audienceCampaignId, String earnOpportunityId, String status, DateTime startedAt, DateTime? completedAt, int watchDurationSeconds, int requiredDurationSeconds, List<SurveyResponseModel> answers, EngagementEvidenceModel? evidence, double? tokensEarned, double? totalTokensGenerated, String? failureReason, int attemptNumber, DateTime createdAt, DateTime? updatedAt, String? threadId, String? clientId, int? streakDayAtCompletion, double? multiplierApplied, bool adWatched, String? adTransactionId, DateTime? adCompletedAt, String? rewardItemId, String? rewardCampaignName, String? rewardType
});


$EngagementEvidenceModelCopyWith<$Res>? get evidence;

}
/// @nodoc
class _$EngagementModelCopyWithImpl<$Res>
    implements $EngagementModelCopyWith<$Res> {
  _$EngagementModelCopyWithImpl(this._self, this._then);

  final EngagementModel _self;
  final $Res Function(EngagementModel) _then;

/// Create a copy of EngagementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? audienceCampaignId = freezed,Object? earnOpportunityId = null,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? watchDurationSeconds = null,Object? requiredDurationSeconds = null,Object? answers = null,Object? evidence = freezed,Object? tokensEarned = freezed,Object? totalTokensGenerated = freezed,Object? failureReason = freezed,Object? attemptNumber = null,Object? createdAt = null,Object? updatedAt = freezed,Object? threadId = freezed,Object? clientId = freezed,Object? streakDayAtCompletion = freezed,Object? multiplierApplied = freezed,Object? adWatched = null,Object? adTransactionId = freezed,Object? adCompletedAt = freezed,Object? rewardItemId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,audienceCampaignId: freezed == audienceCampaignId ? _self.audienceCampaignId : audienceCampaignId // ignore: cast_nullable_to_non_nullable
as String?,earnOpportunityId: null == earnOpportunityId ? _self.earnOpportunityId : earnOpportunityId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,watchDurationSeconds: null == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredDurationSeconds: null == requiredDurationSeconds ? _self.requiredDurationSeconds : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<SurveyResponseModel>,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as EngagementEvidenceModel?,tokensEarned: freezed == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as double?,totalTokensGenerated: freezed == totalTokensGenerated ? _self.totalTokensGenerated : totalTokensGenerated // ignore: cast_nullable_to_non_nullable
as double?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,attemptNumber: null == attemptNumber ? _self.attemptNumber : attemptNumber // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,streakDayAtCompletion: freezed == streakDayAtCompletion ? _self.streakDayAtCompletion : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
as int?,multiplierApplied: freezed == multiplierApplied ? _self.multiplierApplied : multiplierApplied // ignore: cast_nullable_to_non_nullable
as double?,adWatched: null == adWatched ? _self.adWatched : adWatched // ignore: cast_nullable_to_non_nullable
as bool,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adCompletedAt: freezed == adCompletedAt ? _self.adCompletedAt : adCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardItemId: freezed == rewardItemId ? _self.rewardItemId : rewardItemId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EngagementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementEvidenceModelCopyWith<$Res>? get evidence {
    if (_self.evidence == null) {
    return null;
  }

  return $EngagementEvidenceModelCopyWith<$Res>(_self.evidence!, (value) {
    return _then(_self.copyWith(evidence: value));
  });
}
}


/// Adds pattern-matching-related methods to [EngagementModel].
extension EngagementModelPatterns on EngagementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EngagementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EngagementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EngagementModel value)  $default,){
final _that = this;
switch (_that) {
case _EngagementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EngagementModel value)?  $default,){
final _that = this;
switch (_that) {
case _EngagementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String? audienceCampaignId,  String earnOpportunityId,  String status,  DateTime startedAt,  DateTime? completedAt,  int watchDurationSeconds,  int requiredDurationSeconds,  List<SurveyResponseModel> answers,  EngagementEvidenceModel? evidence,  double? tokensEarned,  double? totalTokensGenerated,  String? failureReason,  int attemptNumber,  DateTime createdAt,  DateTime? updatedAt,  String? threadId,  String? clientId,  int? streakDayAtCompletion,  double? multiplierApplied,  bool adWatched,  String? adTransactionId,  DateTime? adCompletedAt,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EngagementModel() when $default != null:
return $default(_that.id,_that.userId,_that.audienceCampaignId,_that.earnOpportunityId,_that.status,_that.startedAt,_that.completedAt,_that.watchDurationSeconds,_that.requiredDurationSeconds,_that.answers,_that.evidence,_that.tokensEarned,_that.totalTokensGenerated,_that.failureReason,_that.attemptNumber,_that.createdAt,_that.updatedAt,_that.threadId,_that.clientId,_that.streakDayAtCompletion,_that.multiplierApplied,_that.adWatched,_that.adTransactionId,_that.adCompletedAt,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String? audienceCampaignId,  String earnOpportunityId,  String status,  DateTime startedAt,  DateTime? completedAt,  int watchDurationSeconds,  int requiredDurationSeconds,  List<SurveyResponseModel> answers,  EngagementEvidenceModel? evidence,  double? tokensEarned,  double? totalTokensGenerated,  String? failureReason,  int attemptNumber,  DateTime createdAt,  DateTime? updatedAt,  String? threadId,  String? clientId,  int? streakDayAtCompletion,  double? multiplierApplied,  bool adWatched,  String? adTransactionId,  DateTime? adCompletedAt,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)  $default,) {final _that = this;
switch (_that) {
case _EngagementModel():
return $default(_that.id,_that.userId,_that.audienceCampaignId,_that.earnOpportunityId,_that.status,_that.startedAt,_that.completedAt,_that.watchDurationSeconds,_that.requiredDurationSeconds,_that.answers,_that.evidence,_that.tokensEarned,_that.totalTokensGenerated,_that.failureReason,_that.attemptNumber,_that.createdAt,_that.updatedAt,_that.threadId,_that.clientId,_that.streakDayAtCompletion,_that.multiplierApplied,_that.adWatched,_that.adTransactionId,_that.adCompletedAt,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String? audienceCampaignId,  String earnOpportunityId,  String status,  DateTime startedAt,  DateTime? completedAt,  int watchDurationSeconds,  int requiredDurationSeconds,  List<SurveyResponseModel> answers,  EngagementEvidenceModel? evidence,  double? tokensEarned,  double? totalTokensGenerated,  String? failureReason,  int attemptNumber,  DateTime createdAt,  DateTime? updatedAt,  String? threadId,  String? clientId,  int? streakDayAtCompletion,  double? multiplierApplied,  bool adWatched,  String? adTransactionId,  DateTime? adCompletedAt,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)?  $default,) {final _that = this;
switch (_that) {
case _EngagementModel() when $default != null:
return $default(_that.id,_that.userId,_that.audienceCampaignId,_that.earnOpportunityId,_that.status,_that.startedAt,_that.completedAt,_that.watchDurationSeconds,_that.requiredDurationSeconds,_that.answers,_that.evidence,_that.tokensEarned,_that.totalTokensGenerated,_that.failureReason,_that.attemptNumber,_that.createdAt,_that.updatedAt,_that.threadId,_that.clientId,_that.streakDayAtCompletion,_that.multiplierApplied,_that.adWatched,_that.adTransactionId,_that.adCompletedAt,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
  return null;

}
}

}

/// @nodoc


class _EngagementModel extends EngagementModel {
  const _EngagementModel({required this.id, required this.userId, this.audienceCampaignId, required this.earnOpportunityId, required this.status, required this.startedAt, this.completedAt, required this.watchDurationSeconds, required this.requiredDurationSeconds, required final  List<SurveyResponseModel> answers, this.evidence, this.tokensEarned, this.totalTokensGenerated, this.failureReason, required this.attemptNumber, required this.createdAt, this.updatedAt, this.threadId, this.clientId, this.streakDayAtCompletion, this.multiplierApplied, this.adWatched = false, this.adTransactionId, this.adCompletedAt, this.rewardItemId, this.rewardCampaignName, this.rewardType}): _answers = answers,super._();
  

@override final  String id;
@override final  String userId;
@override final  String? audienceCampaignId;
@override final  String earnOpportunityId;
@override final  String status;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;
@override final  int watchDurationSeconds;
@override final  int requiredDurationSeconds;
 final  List<SurveyResponseModel> _answers;
@override List<SurveyResponseModel> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

@override final  EngagementEvidenceModel? evidence;
@override final  double? tokensEarned;
@override final  double? totalTokensGenerated;
@override final  String? failureReason;
@override final  int attemptNumber;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
// Denormalized fields for targeting queries
@override final  String? threadId;
@override final  String? clientId;
// Streak audit fields
@override final  int? streakDayAtCompletion;
@override final  double? multiplierApplied;
// AdMob tracking fields
@override@JsonKey() final  bool adWatched;
@override final  String? adTransactionId;
@override final  DateTime? adCompletedAt;
// Reward escrow fields
@override final  String? rewardItemId;
@override final  String? rewardCampaignName;
@override final  String? rewardType;

/// Create a copy of EngagementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EngagementModelCopyWith<_EngagementModel> get copyWith => __$EngagementModelCopyWithImpl<_EngagementModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EngagementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.audienceCampaignId, audienceCampaignId) || other.audienceCampaignId == audienceCampaignId)&&(identical(other.earnOpportunityId, earnOpportunityId) || other.earnOpportunityId == earnOpportunityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds)&&(identical(other.requiredDurationSeconds, requiredDurationSeconds) || other.requiredDurationSeconds == requiredDurationSeconds)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.totalTokensGenerated, totalTokensGenerated) || other.totalTokensGenerated == totalTokensGenerated)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.attemptNumber, attemptNumber) || other.attemptNumber == attemptNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.streakDayAtCompletion, streakDayAtCompletion) || other.streakDayAtCompletion == streakDayAtCompletion)&&(identical(other.multiplierApplied, multiplierApplied) || other.multiplierApplied == multiplierApplied)&&(identical(other.adWatched, adWatched) || other.adWatched == adWatched)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adCompletedAt, adCompletedAt) || other.adCompletedAt == adCompletedAt)&&(identical(other.rewardItemId, rewardItemId) || other.rewardItemId == rewardItemId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,audienceCampaignId,earnOpportunityId,status,startedAt,completedAt,watchDurationSeconds,requiredDurationSeconds,const DeepCollectionEquality().hash(_answers),evidence,tokensEarned,totalTokensGenerated,failureReason,attemptNumber,createdAt,updatedAt,threadId,clientId,streakDayAtCompletion,multiplierApplied,adWatched,adTransactionId,adCompletedAt,rewardItemId,rewardCampaignName,rewardType]);

@override
String toString() {
  return 'EngagementModel(id: $id, userId: $userId, audienceCampaignId: $audienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, totalTokensGenerated: $totalTokensGenerated, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
}


}

/// @nodoc
abstract mixin class _$EngagementModelCopyWith<$Res> implements $EngagementModelCopyWith<$Res> {
  factory _$EngagementModelCopyWith(_EngagementModel value, $Res Function(_EngagementModel) _then) = __$EngagementModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String? audienceCampaignId, String earnOpportunityId, String status, DateTime startedAt, DateTime? completedAt, int watchDurationSeconds, int requiredDurationSeconds, List<SurveyResponseModel> answers, EngagementEvidenceModel? evidence, double? tokensEarned, double? totalTokensGenerated, String? failureReason, int attemptNumber, DateTime createdAt, DateTime? updatedAt, String? threadId, String? clientId, int? streakDayAtCompletion, double? multiplierApplied, bool adWatched, String? adTransactionId, DateTime? adCompletedAt, String? rewardItemId, String? rewardCampaignName, String? rewardType
});


@override $EngagementEvidenceModelCopyWith<$Res>? get evidence;

}
/// @nodoc
class __$EngagementModelCopyWithImpl<$Res>
    implements _$EngagementModelCopyWith<$Res> {
  __$EngagementModelCopyWithImpl(this._self, this._then);

  final _EngagementModel _self;
  final $Res Function(_EngagementModel) _then;

/// Create a copy of EngagementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? audienceCampaignId = freezed,Object? earnOpportunityId = null,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? watchDurationSeconds = null,Object? requiredDurationSeconds = null,Object? answers = null,Object? evidence = freezed,Object? tokensEarned = freezed,Object? totalTokensGenerated = freezed,Object? failureReason = freezed,Object? attemptNumber = null,Object? createdAt = null,Object? updatedAt = freezed,Object? threadId = freezed,Object? clientId = freezed,Object? streakDayAtCompletion = freezed,Object? multiplierApplied = freezed,Object? adWatched = null,Object? adTransactionId = freezed,Object? adCompletedAt = freezed,Object? rewardItemId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,}) {
  return _then(_EngagementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,audienceCampaignId: freezed == audienceCampaignId ? _self.audienceCampaignId : audienceCampaignId // ignore: cast_nullable_to_non_nullable
as String?,earnOpportunityId: null == earnOpportunityId ? _self.earnOpportunityId : earnOpportunityId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,watchDurationSeconds: null == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredDurationSeconds: null == requiredDurationSeconds ? _self.requiredDurationSeconds : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<SurveyResponseModel>,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as EngagementEvidenceModel?,tokensEarned: freezed == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as double?,totalTokensGenerated: freezed == totalTokensGenerated ? _self.totalTokensGenerated : totalTokensGenerated // ignore: cast_nullable_to_non_nullable
as double?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,attemptNumber: null == attemptNumber ? _self.attemptNumber : attemptNumber // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,streakDayAtCompletion: freezed == streakDayAtCompletion ? _self.streakDayAtCompletion : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
as int?,multiplierApplied: freezed == multiplierApplied ? _self.multiplierApplied : multiplierApplied // ignore: cast_nullable_to_non_nullable
as double?,adWatched: null == adWatched ? _self.adWatched : adWatched // ignore: cast_nullable_to_non_nullable
as bool,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adCompletedAt: freezed == adCompletedAt ? _self.adCompletedAt : adCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardItemId: freezed == rewardItemId ? _self.rewardItemId : rewardItemId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EngagementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementEvidenceModelCopyWith<$Res>? get evidence {
    if (_self.evidence == null) {
    return null;
  }

  return $EngagementEvidenceModelCopyWith<$Res>(_self.evidence!, (value) {
    return _then(_self.copyWith(evidence: value));
  });
}
}

// dart format on
