// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollOption {

 String get id; String get text; String? get mediaUrl; String? get mediaType;
/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionCopyWith<PollOption> get copyWith => _$PollOptionCopyWithImpl<PollOption>(this as PollOption, _$identity);

  /// Serializes this PollOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,mediaUrl,mediaType);

@override
String toString() {
  return 'PollOption(id: $id, text: $text, mediaUrl: $mediaUrl, mediaType: $mediaType)';
}


}

/// @nodoc
abstract mixin class $PollOptionCopyWith<$Res>  {
  factory $PollOptionCopyWith(PollOption value, $Res Function(PollOption) _then) = _$PollOptionCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? mediaUrl, String? mediaType
});




}
/// @nodoc
class _$PollOptionCopyWithImpl<$Res>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._self, this._then);

  final PollOption _self;
  final $Res Function(PollOption) _then;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? mediaUrl = freezed,Object? mediaType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PollOption].
extension PollOptionPatterns on PollOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOption value)  $default,){
final _that = this;
switch (_that) {
case _PollOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOption value)?  $default,){
final _that = this;
switch (_that) {
case _PollOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String? mediaUrl,  String? mediaType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollOption() when $default != null:
return $default(_that.id,_that.text,_that.mediaUrl,_that.mediaType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String? mediaUrl,  String? mediaType)  $default,) {final _that = this;
switch (_that) {
case _PollOption():
return $default(_that.id,_that.text,_that.mediaUrl,_that.mediaType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String? mediaUrl,  String? mediaType)?  $default,) {final _that = this;
switch (_that) {
case _PollOption() when $default != null:
return $default(_that.id,_that.text,_that.mediaUrl,_that.mediaType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollOption implements PollOption {
  const _PollOption({required this.id, required this.text, this.mediaUrl, this.mediaType});
  factory _PollOption.fromJson(Map<String, dynamic> json) => _$PollOptionFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? mediaUrl;
@override final  String? mediaType;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionCopyWith<_PollOption> get copyWith => __$PollOptionCopyWithImpl<_PollOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,mediaUrl,mediaType);

@override
String toString() {
  return 'PollOption(id: $id, text: $text, mediaUrl: $mediaUrl, mediaType: $mediaType)';
}


}

/// @nodoc
abstract mixin class _$PollOptionCopyWith<$Res> implements $PollOptionCopyWith<$Res> {
  factory _$PollOptionCopyWith(_PollOption value, $Res Function(_PollOption) _then) = __$PollOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? mediaUrl, String? mediaType
});




}
/// @nodoc
class __$PollOptionCopyWithImpl<$Res>
    implements _$PollOptionCopyWith<$Res> {
  __$PollOptionCopyWithImpl(this._self, this._then);

  final _PollOption _self;
  final $Res Function(_PollOption) _then;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? mediaUrl = freezed,Object? mediaType = freezed,}) {
  return _then(_PollOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Poll {

 String get id; String get opportunityId; String get threadId; String get clientId; String get question; List<PollOption> get options; PollStatus get status;// Question type — determines UI, validation, and aggregation
 PollQuestionType get questionType; bool get isAnonymous; bool get allowChangeVote;// Multi-select support (multipleChoice only)
 bool get allowMultipleSelections; int? get maxSelections;// Poll expiry/deadline (stored as UTC)
 DateTime? get closesAt;// Minimum responses before results are visible (for afterThreshold)
 int? get minResponsesForResults;// Result visibility control (replaces showResultsAfterVote)
 ResultVisibility get resultVisibility;// "Other" free-text option
 bool get allowOtherOption; DateTime? get openedAt; DateTime? get closedAt; int get totalRespondents; Map<String, int> get optionCounts; DateTime get createdAt; DateTime? get updatedAt; String get createdBy;// --- Scale question config ---
 int get scaleMin; int get scaleMax; String? get scaleMinLabel;// e.g. "Extremely unlikely"
 String? get scaleMaxLabel;// e.g. "Extremely likely"
 List<String> get scaleIntermediateLabels;// optional labels for each position
// --- Text question config ---
 int get textMinLength; int get textMaxLength;// --- Type-specific aggregation ---
 Map<String, double> get averageRanks;// ranking: optionId → avg rank
 Map<String, double> get averageRatings;// scale: optionId → avg rating
 Map<String, Map<String, int>> get ratingDistribution;// scale: optionId → {ratingValue → count}
// Legacy field — kept for backward compat reads, not used for new logic
 bool get showResultsAfterVote;
/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollCopyWith<Poll> get copyWith => _$PollCopyWithImpl<Poll>(this as Poll, _$identity);

  /// Serializes this Poll to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Poll&&(identical(other.id, id) || other.id == id)&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.status, status) || other.status == status)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.allowChangeVote, allowChangeVote) || other.allowChangeVote == allowChangeVote)&&(identical(other.allowMultipleSelections, allowMultipleSelections) || other.allowMultipleSelections == allowMultipleSelections)&&(identical(other.maxSelections, maxSelections) || other.maxSelections == maxSelections)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.minResponsesForResults, minResponsesForResults) || other.minResponsesForResults == minResponsesForResults)&&(identical(other.resultVisibility, resultVisibility) || other.resultVisibility == resultVisibility)&&(identical(other.allowOtherOption, allowOtherOption) || other.allowOtherOption == allowOtherOption)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other.optionCounts, optionCounts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.scaleMin, scaleMin) || other.scaleMin == scaleMin)&&(identical(other.scaleMax, scaleMax) || other.scaleMax == scaleMax)&&(identical(other.scaleMinLabel, scaleMinLabel) || other.scaleMinLabel == scaleMinLabel)&&(identical(other.scaleMaxLabel, scaleMaxLabel) || other.scaleMaxLabel == scaleMaxLabel)&&const DeepCollectionEquality().equals(other.scaleIntermediateLabels, scaleIntermediateLabels)&&(identical(other.textMinLength, textMinLength) || other.textMinLength == textMinLength)&&(identical(other.textMaxLength, textMaxLength) || other.textMaxLength == textMaxLength)&&const DeepCollectionEquality().equals(other.averageRanks, averageRanks)&&const DeepCollectionEquality().equals(other.averageRatings, averageRatings)&&const DeepCollectionEquality().equals(other.ratingDistribution, ratingDistribution)&&(identical(other.showResultsAfterVote, showResultsAfterVote) || other.showResultsAfterVote == showResultsAfterVote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,opportunityId,threadId,clientId,question,const DeepCollectionEquality().hash(options),status,questionType,isAnonymous,allowChangeVote,allowMultipleSelections,maxSelections,closesAt,minResponsesForResults,resultVisibility,allowOtherOption,openedAt,closedAt,totalRespondents,const DeepCollectionEquality().hash(optionCounts),createdAt,updatedAt,createdBy,scaleMin,scaleMax,scaleMinLabel,scaleMaxLabel,const DeepCollectionEquality().hash(scaleIntermediateLabels),textMinLength,textMaxLength,const DeepCollectionEquality().hash(averageRanks),const DeepCollectionEquality().hash(averageRatings),const DeepCollectionEquality().hash(ratingDistribution),showResultsAfterVote]);

@override
String toString() {
  return 'Poll(id: $id, opportunityId: $opportunityId, threadId: $threadId, clientId: $clientId, question: $question, options: $options, status: $status, questionType: $questionType, isAnonymous: $isAnonymous, allowChangeVote: $allowChangeVote, allowMultipleSelections: $allowMultipleSelections, maxSelections: $maxSelections, closesAt: $closesAt, minResponsesForResults: $minResponsesForResults, resultVisibility: $resultVisibility, allowOtherOption: $allowOtherOption, openedAt: $openedAt, closedAt: $closedAt, totalRespondents: $totalRespondents, optionCounts: $optionCounts, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, scaleMin: $scaleMin, scaleMax: $scaleMax, scaleMinLabel: $scaleMinLabel, scaleMaxLabel: $scaleMaxLabel, scaleIntermediateLabels: $scaleIntermediateLabels, textMinLength: $textMinLength, textMaxLength: $textMaxLength, averageRanks: $averageRanks, averageRatings: $averageRatings, ratingDistribution: $ratingDistribution, showResultsAfterVote: $showResultsAfterVote)';
}


}

/// @nodoc
abstract mixin class $PollCopyWith<$Res>  {
  factory $PollCopyWith(Poll value, $Res Function(Poll) _then) = _$PollCopyWithImpl;
@useResult
$Res call({
 String id, String opportunityId, String threadId, String clientId, String question, List<PollOption> options, PollStatus status, PollQuestionType questionType, bool isAnonymous, bool allowChangeVote, bool allowMultipleSelections, int? maxSelections, DateTime? closesAt, int? minResponsesForResults, ResultVisibility resultVisibility, bool allowOtherOption, DateTime? openedAt, DateTime? closedAt, int totalRespondents, Map<String, int> optionCounts, DateTime createdAt, DateTime? updatedAt, String createdBy, int scaleMin, int scaleMax, String? scaleMinLabel, String? scaleMaxLabel, List<String> scaleIntermediateLabels, int textMinLength, int textMaxLength, Map<String, double> averageRanks, Map<String, double> averageRatings, Map<String, Map<String, int>> ratingDistribution, bool showResultsAfterVote
});




}
/// @nodoc
class _$PollCopyWithImpl<$Res>
    implements $PollCopyWith<$Res> {
  _$PollCopyWithImpl(this._self, this._then);

  final Poll _self;
  final $Res Function(Poll) _then;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? opportunityId = null,Object? threadId = null,Object? clientId = null,Object? question = null,Object? options = null,Object? status = null,Object? questionType = null,Object? isAnonymous = null,Object? allowChangeVote = null,Object? allowMultipleSelections = null,Object? maxSelections = freezed,Object? closesAt = freezed,Object? minResponsesForResults = freezed,Object? resultVisibility = null,Object? allowOtherOption = null,Object? openedAt = freezed,Object? closedAt = freezed,Object? totalRespondents = null,Object? optionCounts = null,Object? createdAt = null,Object? updatedAt = freezed,Object? createdBy = null,Object? scaleMin = null,Object? scaleMax = null,Object? scaleMinLabel = freezed,Object? scaleMaxLabel = freezed,Object? scaleIntermediateLabels = null,Object? textMinLength = null,Object? textMaxLength = null,Object? averageRanks = null,Object? averageRatings = null,Object? ratingDistribution = null,Object? showResultsAfterVote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOption>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PollStatus,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as PollQuestionType,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,allowChangeVote: null == allowChangeVote ? _self.allowChangeVote : allowChangeVote // ignore: cast_nullable_to_non_nullable
as bool,allowMultipleSelections: null == allowMultipleSelections ? _self.allowMultipleSelections : allowMultipleSelections // ignore: cast_nullable_to_non_nullable
as bool,maxSelections: freezed == maxSelections ? _self.maxSelections : maxSelections // ignore: cast_nullable_to_non_nullable
as int?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,minResponsesForResults: freezed == minResponsesForResults ? _self.minResponsesForResults : minResponsesForResults // ignore: cast_nullable_to_non_nullable
as int?,resultVisibility: null == resultVisibility ? _self.resultVisibility : resultVisibility // ignore: cast_nullable_to_non_nullable
as ResultVisibility,allowOtherOption: null == allowOtherOption ? _self.allowOtherOption : allowOtherOption // ignore: cast_nullable_to_non_nullable
as bool,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self.optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,scaleMin: null == scaleMin ? _self.scaleMin : scaleMin // ignore: cast_nullable_to_non_nullable
as int,scaleMax: null == scaleMax ? _self.scaleMax : scaleMax // ignore: cast_nullable_to_non_nullable
as int,scaleMinLabel: freezed == scaleMinLabel ? _self.scaleMinLabel : scaleMinLabel // ignore: cast_nullable_to_non_nullable
as String?,scaleMaxLabel: freezed == scaleMaxLabel ? _self.scaleMaxLabel : scaleMaxLabel // ignore: cast_nullable_to_non_nullable
as String?,scaleIntermediateLabels: null == scaleIntermediateLabels ? _self.scaleIntermediateLabels : scaleIntermediateLabels // ignore: cast_nullable_to_non_nullable
as List<String>,textMinLength: null == textMinLength ? _self.textMinLength : textMinLength // ignore: cast_nullable_to_non_nullable
as int,textMaxLength: null == textMaxLength ? _self.textMaxLength : textMaxLength // ignore: cast_nullable_to_non_nullable
as int,averageRanks: null == averageRanks ? _self.averageRanks : averageRanks // ignore: cast_nullable_to_non_nullable
as Map<String, double>,averageRatings: null == averageRatings ? _self.averageRatings : averageRatings // ignore: cast_nullable_to_non_nullable
as Map<String, double>,ratingDistribution: null == ratingDistribution ? _self.ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, int>>,showResultsAfterVote: null == showResultsAfterVote ? _self.showResultsAfterVote : showResultsAfterVote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Poll].
extension PollPatterns on Poll {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Poll value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Poll value)  $default,){
final _that = this;
switch (_that) {
case _Poll():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Poll value)?  $default,){
final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String opportunityId,  String threadId,  String clientId,  String question,  List<PollOption> options,  PollStatus status,  PollQuestionType questionType,  bool isAnonymous,  bool allowChangeVote,  bool allowMultipleSelections,  int? maxSelections,  DateTime? closesAt,  int? minResponsesForResults,  ResultVisibility resultVisibility,  bool allowOtherOption,  DateTime? openedAt,  DateTime? closedAt,  int totalRespondents,  Map<String, int> optionCounts,  DateTime createdAt,  DateTime? updatedAt,  String createdBy,  int scaleMin,  int scaleMax,  String? scaleMinLabel,  String? scaleMaxLabel,  List<String> scaleIntermediateLabels,  int textMinLength,  int textMaxLength,  Map<String, double> averageRanks,  Map<String, double> averageRatings,  Map<String, Map<String, int>> ratingDistribution,  bool showResultsAfterVote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Poll() when $default != null:
return $default(_that.id,_that.opportunityId,_that.threadId,_that.clientId,_that.question,_that.options,_that.status,_that.questionType,_that.isAnonymous,_that.allowChangeVote,_that.allowMultipleSelections,_that.maxSelections,_that.closesAt,_that.minResponsesForResults,_that.resultVisibility,_that.allowOtherOption,_that.openedAt,_that.closedAt,_that.totalRespondents,_that.optionCounts,_that.createdAt,_that.updatedAt,_that.createdBy,_that.scaleMin,_that.scaleMax,_that.scaleMinLabel,_that.scaleMaxLabel,_that.scaleIntermediateLabels,_that.textMinLength,_that.textMaxLength,_that.averageRanks,_that.averageRatings,_that.ratingDistribution,_that.showResultsAfterVote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String opportunityId,  String threadId,  String clientId,  String question,  List<PollOption> options,  PollStatus status,  PollQuestionType questionType,  bool isAnonymous,  bool allowChangeVote,  bool allowMultipleSelections,  int? maxSelections,  DateTime? closesAt,  int? minResponsesForResults,  ResultVisibility resultVisibility,  bool allowOtherOption,  DateTime? openedAt,  DateTime? closedAt,  int totalRespondents,  Map<String, int> optionCounts,  DateTime createdAt,  DateTime? updatedAt,  String createdBy,  int scaleMin,  int scaleMax,  String? scaleMinLabel,  String? scaleMaxLabel,  List<String> scaleIntermediateLabels,  int textMinLength,  int textMaxLength,  Map<String, double> averageRanks,  Map<String, double> averageRatings,  Map<String, Map<String, int>> ratingDistribution,  bool showResultsAfterVote)  $default,) {final _that = this;
switch (_that) {
case _Poll():
return $default(_that.id,_that.opportunityId,_that.threadId,_that.clientId,_that.question,_that.options,_that.status,_that.questionType,_that.isAnonymous,_that.allowChangeVote,_that.allowMultipleSelections,_that.maxSelections,_that.closesAt,_that.minResponsesForResults,_that.resultVisibility,_that.allowOtherOption,_that.openedAt,_that.closedAt,_that.totalRespondents,_that.optionCounts,_that.createdAt,_that.updatedAt,_that.createdBy,_that.scaleMin,_that.scaleMax,_that.scaleMinLabel,_that.scaleMaxLabel,_that.scaleIntermediateLabels,_that.textMinLength,_that.textMaxLength,_that.averageRanks,_that.averageRatings,_that.ratingDistribution,_that.showResultsAfterVote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String opportunityId,  String threadId,  String clientId,  String question,  List<PollOption> options,  PollStatus status,  PollQuestionType questionType,  bool isAnonymous,  bool allowChangeVote,  bool allowMultipleSelections,  int? maxSelections,  DateTime? closesAt,  int? minResponsesForResults,  ResultVisibility resultVisibility,  bool allowOtherOption,  DateTime? openedAt,  DateTime? closedAt,  int totalRespondents,  Map<String, int> optionCounts,  DateTime createdAt,  DateTime? updatedAt,  String createdBy,  int scaleMin,  int scaleMax,  String? scaleMinLabel,  String? scaleMaxLabel,  List<String> scaleIntermediateLabels,  int textMinLength,  int textMaxLength,  Map<String, double> averageRanks,  Map<String, double> averageRatings,  Map<String, Map<String, int>> ratingDistribution,  bool showResultsAfterVote)?  $default,) {final _that = this;
switch (_that) {
case _Poll() when $default != null:
return $default(_that.id,_that.opportunityId,_that.threadId,_that.clientId,_that.question,_that.options,_that.status,_that.questionType,_that.isAnonymous,_that.allowChangeVote,_that.allowMultipleSelections,_that.maxSelections,_that.closesAt,_that.minResponsesForResults,_that.resultVisibility,_that.allowOtherOption,_that.openedAt,_that.closedAt,_that.totalRespondents,_that.optionCounts,_that.createdAt,_that.updatedAt,_that.createdBy,_that.scaleMin,_that.scaleMax,_that.scaleMinLabel,_that.scaleMaxLabel,_that.scaleIntermediateLabels,_that.textMinLength,_that.textMaxLength,_that.averageRanks,_that.averageRatings,_that.ratingDistribution,_that.showResultsAfterVote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Poll extends Poll {
  const _Poll({required this.id, required this.opportunityId, required this.threadId, required this.clientId, required this.question, required final  List<PollOption> options, required this.status, this.questionType = PollQuestionType.multipleChoice, this.isAnonymous = false, this.allowChangeVote = true, this.allowMultipleSelections = false, this.maxSelections, this.closesAt, this.minResponsesForResults, this.resultVisibility = ResultVisibility.immediate, this.allowOtherOption = false, this.openedAt, this.closedAt, this.totalRespondents = 0, final  Map<String, int> optionCounts = const {}, required this.createdAt, this.updatedAt, required this.createdBy, this.scaleMin = 1, this.scaleMax = 10, this.scaleMinLabel, this.scaleMaxLabel, final  List<String> scaleIntermediateLabels = const [], this.textMinLength = 1, this.textMaxLength = 500, final  Map<String, double> averageRanks = const {}, final  Map<String, double> averageRatings = const {}, final  Map<String, Map<String, int>> ratingDistribution = const {}, this.showResultsAfterVote = true}): _options = options,_optionCounts = optionCounts,_scaleIntermediateLabels = scaleIntermediateLabels,_averageRanks = averageRanks,_averageRatings = averageRatings,_ratingDistribution = ratingDistribution,super._();
  factory _Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

@override final  String id;
@override final  String opportunityId;
@override final  String threadId;
@override final  String clientId;
@override final  String question;
 final  List<PollOption> _options;
@override List<PollOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  PollStatus status;
// Question type — determines UI, validation, and aggregation
@override@JsonKey() final  PollQuestionType questionType;
@override@JsonKey() final  bool isAnonymous;
@override@JsonKey() final  bool allowChangeVote;
// Multi-select support (multipleChoice only)
@override@JsonKey() final  bool allowMultipleSelections;
@override final  int? maxSelections;
// Poll expiry/deadline (stored as UTC)
@override final  DateTime? closesAt;
// Minimum responses before results are visible (for afterThreshold)
@override final  int? minResponsesForResults;
// Result visibility control (replaces showResultsAfterVote)
@override@JsonKey() final  ResultVisibility resultVisibility;
// "Other" free-text option
@override@JsonKey() final  bool allowOtherOption;
@override final  DateTime? openedAt;
@override final  DateTime? closedAt;
@override@JsonKey() final  int totalRespondents;
 final  Map<String, int> _optionCounts;
@override@JsonKey() Map<String, int> get optionCounts {
  if (_optionCounts is EqualUnmodifiableMapView) return _optionCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionCounts);
}

@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  String createdBy;
// --- Scale question config ---
@override@JsonKey() final  int scaleMin;
@override@JsonKey() final  int scaleMax;
@override final  String? scaleMinLabel;
// e.g. "Extremely unlikely"
@override final  String? scaleMaxLabel;
// e.g. "Extremely likely"
 final  List<String> _scaleIntermediateLabels;
// e.g. "Extremely likely"
@override@JsonKey() List<String> get scaleIntermediateLabels {
  if (_scaleIntermediateLabels is EqualUnmodifiableListView) return _scaleIntermediateLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scaleIntermediateLabels);
}

// optional labels for each position
// --- Text question config ---
@override@JsonKey() final  int textMinLength;
@override@JsonKey() final  int textMaxLength;
// --- Type-specific aggregation ---
 final  Map<String, double> _averageRanks;
// --- Type-specific aggregation ---
@override@JsonKey() Map<String, double> get averageRanks {
  if (_averageRanks is EqualUnmodifiableMapView) return _averageRanks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_averageRanks);
}

// ranking: optionId → avg rank
 final  Map<String, double> _averageRatings;
// ranking: optionId → avg rank
@override@JsonKey() Map<String, double> get averageRatings {
  if (_averageRatings is EqualUnmodifiableMapView) return _averageRatings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_averageRatings);
}

// scale: optionId → avg rating
 final  Map<String, Map<String, int>> _ratingDistribution;
// scale: optionId → avg rating
@override@JsonKey() Map<String, Map<String, int>> get ratingDistribution {
  if (_ratingDistribution is EqualUnmodifiableMapView) return _ratingDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratingDistribution);
}

// scale: optionId → {ratingValue → count}
// Legacy field — kept for backward compat reads, not used for new logic
@override@JsonKey() final  bool showResultsAfterVote;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollCopyWith<_Poll> get copyWith => __$PollCopyWithImpl<_Poll>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Poll&&(identical(other.id, id) || other.id == id)&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.status, status) || other.status == status)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.allowChangeVote, allowChangeVote) || other.allowChangeVote == allowChangeVote)&&(identical(other.allowMultipleSelections, allowMultipleSelections) || other.allowMultipleSelections == allowMultipleSelections)&&(identical(other.maxSelections, maxSelections) || other.maxSelections == maxSelections)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.minResponsesForResults, minResponsesForResults) || other.minResponsesForResults == minResponsesForResults)&&(identical(other.resultVisibility, resultVisibility) || other.resultVisibility == resultVisibility)&&(identical(other.allowOtherOption, allowOtherOption) || other.allowOtherOption == allowOtherOption)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other._optionCounts, _optionCounts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.scaleMin, scaleMin) || other.scaleMin == scaleMin)&&(identical(other.scaleMax, scaleMax) || other.scaleMax == scaleMax)&&(identical(other.scaleMinLabel, scaleMinLabel) || other.scaleMinLabel == scaleMinLabel)&&(identical(other.scaleMaxLabel, scaleMaxLabel) || other.scaleMaxLabel == scaleMaxLabel)&&const DeepCollectionEquality().equals(other._scaleIntermediateLabels, _scaleIntermediateLabels)&&(identical(other.textMinLength, textMinLength) || other.textMinLength == textMinLength)&&(identical(other.textMaxLength, textMaxLength) || other.textMaxLength == textMaxLength)&&const DeepCollectionEquality().equals(other._averageRanks, _averageRanks)&&const DeepCollectionEquality().equals(other._averageRatings, _averageRatings)&&const DeepCollectionEquality().equals(other._ratingDistribution, _ratingDistribution)&&(identical(other.showResultsAfterVote, showResultsAfterVote) || other.showResultsAfterVote == showResultsAfterVote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,opportunityId,threadId,clientId,question,const DeepCollectionEquality().hash(_options),status,questionType,isAnonymous,allowChangeVote,allowMultipleSelections,maxSelections,closesAt,minResponsesForResults,resultVisibility,allowOtherOption,openedAt,closedAt,totalRespondents,const DeepCollectionEquality().hash(_optionCounts),createdAt,updatedAt,createdBy,scaleMin,scaleMax,scaleMinLabel,scaleMaxLabel,const DeepCollectionEquality().hash(_scaleIntermediateLabels),textMinLength,textMaxLength,const DeepCollectionEquality().hash(_averageRanks),const DeepCollectionEquality().hash(_averageRatings),const DeepCollectionEquality().hash(_ratingDistribution),showResultsAfterVote]);

@override
String toString() {
  return 'Poll(id: $id, opportunityId: $opportunityId, threadId: $threadId, clientId: $clientId, question: $question, options: $options, status: $status, questionType: $questionType, isAnonymous: $isAnonymous, allowChangeVote: $allowChangeVote, allowMultipleSelections: $allowMultipleSelections, maxSelections: $maxSelections, closesAt: $closesAt, minResponsesForResults: $minResponsesForResults, resultVisibility: $resultVisibility, allowOtherOption: $allowOtherOption, openedAt: $openedAt, closedAt: $closedAt, totalRespondents: $totalRespondents, optionCounts: $optionCounts, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, scaleMin: $scaleMin, scaleMax: $scaleMax, scaleMinLabel: $scaleMinLabel, scaleMaxLabel: $scaleMaxLabel, scaleIntermediateLabels: $scaleIntermediateLabels, textMinLength: $textMinLength, textMaxLength: $textMaxLength, averageRanks: $averageRanks, averageRatings: $averageRatings, ratingDistribution: $ratingDistribution, showResultsAfterVote: $showResultsAfterVote)';
}


}

/// @nodoc
abstract mixin class _$PollCopyWith<$Res> implements $PollCopyWith<$Res> {
  factory _$PollCopyWith(_Poll value, $Res Function(_Poll) _then) = __$PollCopyWithImpl;
@override @useResult
$Res call({
 String id, String opportunityId, String threadId, String clientId, String question, List<PollOption> options, PollStatus status, PollQuestionType questionType, bool isAnonymous, bool allowChangeVote, bool allowMultipleSelections, int? maxSelections, DateTime? closesAt, int? minResponsesForResults, ResultVisibility resultVisibility, bool allowOtherOption, DateTime? openedAt, DateTime? closedAt, int totalRespondents, Map<String, int> optionCounts, DateTime createdAt, DateTime? updatedAt, String createdBy, int scaleMin, int scaleMax, String? scaleMinLabel, String? scaleMaxLabel, List<String> scaleIntermediateLabels, int textMinLength, int textMaxLength, Map<String, double> averageRanks, Map<String, double> averageRatings, Map<String, Map<String, int>> ratingDistribution, bool showResultsAfterVote
});




}
/// @nodoc
class __$PollCopyWithImpl<$Res>
    implements _$PollCopyWith<$Res> {
  __$PollCopyWithImpl(this._self, this._then);

  final _Poll _self;
  final $Res Function(_Poll) _then;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? opportunityId = null,Object? threadId = null,Object? clientId = null,Object? question = null,Object? options = null,Object? status = null,Object? questionType = null,Object? isAnonymous = null,Object? allowChangeVote = null,Object? allowMultipleSelections = null,Object? maxSelections = freezed,Object? closesAt = freezed,Object? minResponsesForResults = freezed,Object? resultVisibility = null,Object? allowOtherOption = null,Object? openedAt = freezed,Object? closedAt = freezed,Object? totalRespondents = null,Object? optionCounts = null,Object? createdAt = null,Object? updatedAt = freezed,Object? createdBy = null,Object? scaleMin = null,Object? scaleMax = null,Object? scaleMinLabel = freezed,Object? scaleMaxLabel = freezed,Object? scaleIntermediateLabels = null,Object? textMinLength = null,Object? textMaxLength = null,Object? averageRanks = null,Object? averageRatings = null,Object? ratingDistribution = null,Object? showResultsAfterVote = null,}) {
  return _then(_Poll(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOption>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PollStatus,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as PollQuestionType,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,allowChangeVote: null == allowChangeVote ? _self.allowChangeVote : allowChangeVote // ignore: cast_nullable_to_non_nullable
as bool,allowMultipleSelections: null == allowMultipleSelections ? _self.allowMultipleSelections : allowMultipleSelections // ignore: cast_nullable_to_non_nullable
as bool,maxSelections: freezed == maxSelections ? _self.maxSelections : maxSelections // ignore: cast_nullable_to_non_nullable
as int?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,minResponsesForResults: freezed == minResponsesForResults ? _self.minResponsesForResults : minResponsesForResults // ignore: cast_nullable_to_non_nullable
as int?,resultVisibility: null == resultVisibility ? _self.resultVisibility : resultVisibility // ignore: cast_nullable_to_non_nullable
as ResultVisibility,allowOtherOption: null == allowOtherOption ? _self.allowOtherOption : allowOtherOption // ignore: cast_nullable_to_non_nullable
as bool,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self._optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,scaleMin: null == scaleMin ? _self.scaleMin : scaleMin // ignore: cast_nullable_to_non_nullable
as int,scaleMax: null == scaleMax ? _self.scaleMax : scaleMax // ignore: cast_nullable_to_non_nullable
as int,scaleMinLabel: freezed == scaleMinLabel ? _self.scaleMinLabel : scaleMinLabel // ignore: cast_nullable_to_non_nullable
as String?,scaleMaxLabel: freezed == scaleMaxLabel ? _self.scaleMaxLabel : scaleMaxLabel // ignore: cast_nullable_to_non_nullable
as String?,scaleIntermediateLabels: null == scaleIntermediateLabels ? _self._scaleIntermediateLabels : scaleIntermediateLabels // ignore: cast_nullable_to_non_nullable
as List<String>,textMinLength: null == textMinLength ? _self.textMinLength : textMinLength // ignore: cast_nullable_to_non_nullable
as int,textMaxLength: null == textMaxLength ? _self.textMaxLength : textMaxLength // ignore: cast_nullable_to_non_nullable
as int,averageRanks: null == averageRanks ? _self._averageRanks : averageRanks // ignore: cast_nullable_to_non_nullable
as Map<String, double>,averageRatings: null == averageRatings ? _self._averageRatings : averageRatings // ignore: cast_nullable_to_non_nullable
as Map<String, double>,ratingDistribution: null == ratingDistribution ? _self._ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, int>>,showResultsAfterVote: null == showResultsAfterVote ? _self.showResultsAfterVote : showResultsAfterVote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PollResponse {

 String get userId; String get pollId; String get selectedOption;// Multi-select: all selected option IDs
 List<String> get selectedOptions; String? get previousOption; int get voteCount; DateTime get respondedAt; DateTime? get updatedAt; String get status; DateTime? get invalidatedAt; String? get invalidatedBy; String? get invalidationReason; String? get engagementId; bool get tokensAwarded; Map<String, String?>? get demographics;// "Other" free-text response (max 200 chars)
 String? get otherText;// --- Ranking response ---
 List<String> get rankedOptions;// ordered option IDs (first = rank 1)
// --- Text response ---
 String? get textResponse;// --- Scale response ---
 Map<String, int> get scaleRatings;
/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollResponseCopyWith<PollResponse> get copyWith => _$PollResponseCopyWithImpl<PollResponse>(this as PollResponse, _$identity);

  /// Serializes this PollResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollResponse&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&const DeepCollectionEquality().equals(other.selectedOptions, selectedOptions)&&(identical(other.previousOption, previousOption) || other.previousOption == previousOption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.invalidatedAt, invalidatedAt) || other.invalidatedAt == invalidatedAt)&&(identical(other.invalidatedBy, invalidatedBy) || other.invalidatedBy == invalidatedBy)&&(identical(other.invalidationReason, invalidationReason) || other.invalidationReason == invalidationReason)&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&(identical(other.tokensAwarded, tokensAwarded) || other.tokensAwarded == tokensAwarded)&&const DeepCollectionEquality().equals(other.demographics, demographics)&&(identical(other.otherText, otherText) || other.otherText == otherText)&&const DeepCollectionEquality().equals(other.rankedOptions, rankedOptions)&&(identical(other.textResponse, textResponse) || other.textResponse == textResponse)&&const DeepCollectionEquality().equals(other.scaleRatings, scaleRatings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,pollId,selectedOption,const DeepCollectionEquality().hash(selectedOptions),previousOption,voteCount,respondedAt,updatedAt,status,invalidatedAt,invalidatedBy,invalidationReason,engagementId,tokensAwarded,const DeepCollectionEquality().hash(demographics),otherText,const DeepCollectionEquality().hash(rankedOptions),textResponse,const DeepCollectionEquality().hash(scaleRatings)]);

@override
String toString() {
  return 'PollResponse(userId: $userId, pollId: $pollId, selectedOption: $selectedOption, selectedOptions: $selectedOptions, previousOption: $previousOption, voteCount: $voteCount, respondedAt: $respondedAt, updatedAt: $updatedAt, status: $status, invalidatedAt: $invalidatedAt, invalidatedBy: $invalidatedBy, invalidationReason: $invalidationReason, engagementId: $engagementId, tokensAwarded: $tokensAwarded, demographics: $demographics, otherText: $otherText, rankedOptions: $rankedOptions, textResponse: $textResponse, scaleRatings: $scaleRatings)';
}


}

/// @nodoc
abstract mixin class $PollResponseCopyWith<$Res>  {
  factory $PollResponseCopyWith(PollResponse value, $Res Function(PollResponse) _then) = _$PollResponseCopyWithImpl;
@useResult
$Res call({
 String userId, String pollId, String selectedOption, List<String> selectedOptions, String? previousOption, int voteCount, DateTime respondedAt, DateTime? updatedAt, String status, DateTime? invalidatedAt, String? invalidatedBy, String? invalidationReason, String? engagementId, bool tokensAwarded, Map<String, String?>? demographics, String? otherText, List<String> rankedOptions, String? textResponse, Map<String, int> scaleRatings
});




}
/// @nodoc
class _$PollResponseCopyWithImpl<$Res>
    implements $PollResponseCopyWith<$Res> {
  _$PollResponseCopyWithImpl(this._self, this._then);

  final PollResponse _self;
  final $Res Function(PollResponse) _then;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? pollId = null,Object? selectedOption = null,Object? selectedOptions = null,Object? previousOption = freezed,Object? voteCount = null,Object? respondedAt = null,Object? updatedAt = freezed,Object? status = null,Object? invalidatedAt = freezed,Object? invalidatedBy = freezed,Object? invalidationReason = freezed,Object? engagementId = freezed,Object? tokensAwarded = null,Object? demographics = freezed,Object? otherText = freezed,Object? rankedOptions = null,Object? textResponse = freezed,Object? scaleRatings = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pollId: null == pollId ? _self.pollId : pollId // ignore: cast_nullable_to_non_nullable
as String,selectedOption: null == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String,selectedOptions: null == selectedOptions ? _self.selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as List<String>,previousOption: freezed == previousOption ? _self.previousOption : previousOption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,respondedAt: null == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,invalidatedAt: freezed == invalidatedAt ? _self.invalidatedAt : invalidatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invalidatedBy: freezed == invalidatedBy ? _self.invalidatedBy : invalidatedBy // ignore: cast_nullable_to_non_nullable
as String?,invalidationReason: freezed == invalidationReason ? _self.invalidationReason : invalidationReason // ignore: cast_nullable_to_non_nullable
as String?,engagementId: freezed == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String?,tokensAwarded: null == tokensAwarded ? _self.tokensAwarded : tokensAwarded // ignore: cast_nullable_to_non_nullable
as bool,demographics: freezed == demographics ? _self.demographics : demographics // ignore: cast_nullable_to_non_nullable
as Map<String, String?>?,otherText: freezed == otherText ? _self.otherText : otherText // ignore: cast_nullable_to_non_nullable
as String?,rankedOptions: null == rankedOptions ? _self.rankedOptions : rankedOptions // ignore: cast_nullable_to_non_nullable
as List<String>,textResponse: freezed == textResponse ? _self.textResponse : textResponse // ignore: cast_nullable_to_non_nullable
as String?,scaleRatings: null == scaleRatings ? _self.scaleRatings : scaleRatings // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [PollResponse].
extension PollResponsePatterns on PollResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollResponse value)  $default,){
final _that = this;
switch (_that) {
case _PollResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String pollId,  String selectedOption,  List<String> selectedOptions,  String? previousOption,  int voteCount,  DateTime respondedAt,  DateTime? updatedAt,  String status,  DateTime? invalidatedAt,  String? invalidatedBy,  String? invalidationReason,  String? engagementId,  bool tokensAwarded,  Map<String, String?>? demographics,  String? otherText,  List<String> rankedOptions,  String? textResponse,  Map<String, int> scaleRatings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
return $default(_that.userId,_that.pollId,_that.selectedOption,_that.selectedOptions,_that.previousOption,_that.voteCount,_that.respondedAt,_that.updatedAt,_that.status,_that.invalidatedAt,_that.invalidatedBy,_that.invalidationReason,_that.engagementId,_that.tokensAwarded,_that.demographics,_that.otherText,_that.rankedOptions,_that.textResponse,_that.scaleRatings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String pollId,  String selectedOption,  List<String> selectedOptions,  String? previousOption,  int voteCount,  DateTime respondedAt,  DateTime? updatedAt,  String status,  DateTime? invalidatedAt,  String? invalidatedBy,  String? invalidationReason,  String? engagementId,  bool tokensAwarded,  Map<String, String?>? demographics,  String? otherText,  List<String> rankedOptions,  String? textResponse,  Map<String, int> scaleRatings)  $default,) {final _that = this;
switch (_that) {
case _PollResponse():
return $default(_that.userId,_that.pollId,_that.selectedOption,_that.selectedOptions,_that.previousOption,_that.voteCount,_that.respondedAt,_that.updatedAt,_that.status,_that.invalidatedAt,_that.invalidatedBy,_that.invalidationReason,_that.engagementId,_that.tokensAwarded,_that.demographics,_that.otherText,_that.rankedOptions,_that.textResponse,_that.scaleRatings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String pollId,  String selectedOption,  List<String> selectedOptions,  String? previousOption,  int voteCount,  DateTime respondedAt,  DateTime? updatedAt,  String status,  DateTime? invalidatedAt,  String? invalidatedBy,  String? invalidationReason,  String? engagementId,  bool tokensAwarded,  Map<String, String?>? demographics,  String? otherText,  List<String> rankedOptions,  String? textResponse,  Map<String, int> scaleRatings)?  $default,) {final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
return $default(_that.userId,_that.pollId,_that.selectedOption,_that.selectedOptions,_that.previousOption,_that.voteCount,_that.respondedAt,_that.updatedAt,_that.status,_that.invalidatedAt,_that.invalidatedBy,_that.invalidationReason,_that.engagementId,_that.tokensAwarded,_that.demographics,_that.otherText,_that.rankedOptions,_that.textResponse,_that.scaleRatings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollResponse extends PollResponse {
  const _PollResponse({required this.userId, required this.pollId, required this.selectedOption, final  List<String> selectedOptions = const [], this.previousOption, this.voteCount = 1, required this.respondedAt, this.updatedAt, this.status = 'valid', this.invalidatedAt, this.invalidatedBy, this.invalidationReason, this.engagementId, this.tokensAwarded = false, final  Map<String, String?>? demographics, this.otherText, final  List<String> rankedOptions = const [], this.textResponse, final  Map<String, int> scaleRatings = const {}}): _selectedOptions = selectedOptions,_demographics = demographics,_rankedOptions = rankedOptions,_scaleRatings = scaleRatings,super._();
  factory _PollResponse.fromJson(Map<String, dynamic> json) => _$PollResponseFromJson(json);

@override final  String userId;
@override final  String pollId;
@override final  String selectedOption;
// Multi-select: all selected option IDs
 final  List<String> _selectedOptions;
// Multi-select: all selected option IDs
@override@JsonKey() List<String> get selectedOptions {
  if (_selectedOptions is EqualUnmodifiableListView) return _selectedOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedOptions);
}

@override final  String? previousOption;
@override@JsonKey() final  int voteCount;
@override final  DateTime respondedAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  String status;
@override final  DateTime? invalidatedAt;
@override final  String? invalidatedBy;
@override final  String? invalidationReason;
@override final  String? engagementId;
@override@JsonKey() final  bool tokensAwarded;
 final  Map<String, String?>? _demographics;
@override Map<String, String?>? get demographics {
  final value = _demographics;
  if (value == null) return null;
  if (_demographics is EqualUnmodifiableMapView) return _demographics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// "Other" free-text response (max 200 chars)
@override final  String? otherText;
// --- Ranking response ---
 final  List<String> _rankedOptions;
// --- Ranking response ---
@override@JsonKey() List<String> get rankedOptions {
  if (_rankedOptions is EqualUnmodifiableListView) return _rankedOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rankedOptions);
}

// ordered option IDs (first = rank 1)
// --- Text response ---
@override final  String? textResponse;
// --- Scale response ---
 final  Map<String, int> _scaleRatings;
// --- Scale response ---
@override@JsonKey() Map<String, int> get scaleRatings {
  if (_scaleRatings is EqualUnmodifiableMapView) return _scaleRatings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scaleRatings);
}


/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollResponseCopyWith<_PollResponse> get copyWith => __$PollResponseCopyWithImpl<_PollResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollResponse&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&const DeepCollectionEquality().equals(other._selectedOptions, _selectedOptions)&&(identical(other.previousOption, previousOption) || other.previousOption == previousOption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.invalidatedAt, invalidatedAt) || other.invalidatedAt == invalidatedAt)&&(identical(other.invalidatedBy, invalidatedBy) || other.invalidatedBy == invalidatedBy)&&(identical(other.invalidationReason, invalidationReason) || other.invalidationReason == invalidationReason)&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&(identical(other.tokensAwarded, tokensAwarded) || other.tokensAwarded == tokensAwarded)&&const DeepCollectionEquality().equals(other._demographics, _demographics)&&(identical(other.otherText, otherText) || other.otherText == otherText)&&const DeepCollectionEquality().equals(other._rankedOptions, _rankedOptions)&&(identical(other.textResponse, textResponse) || other.textResponse == textResponse)&&const DeepCollectionEquality().equals(other._scaleRatings, _scaleRatings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,pollId,selectedOption,const DeepCollectionEquality().hash(_selectedOptions),previousOption,voteCount,respondedAt,updatedAt,status,invalidatedAt,invalidatedBy,invalidationReason,engagementId,tokensAwarded,const DeepCollectionEquality().hash(_demographics),otherText,const DeepCollectionEquality().hash(_rankedOptions),textResponse,const DeepCollectionEquality().hash(_scaleRatings)]);

@override
String toString() {
  return 'PollResponse(userId: $userId, pollId: $pollId, selectedOption: $selectedOption, selectedOptions: $selectedOptions, previousOption: $previousOption, voteCount: $voteCount, respondedAt: $respondedAt, updatedAt: $updatedAt, status: $status, invalidatedAt: $invalidatedAt, invalidatedBy: $invalidatedBy, invalidationReason: $invalidationReason, engagementId: $engagementId, tokensAwarded: $tokensAwarded, demographics: $demographics, otherText: $otherText, rankedOptions: $rankedOptions, textResponse: $textResponse, scaleRatings: $scaleRatings)';
}


}

/// @nodoc
abstract mixin class _$PollResponseCopyWith<$Res> implements $PollResponseCopyWith<$Res> {
  factory _$PollResponseCopyWith(_PollResponse value, $Res Function(_PollResponse) _then) = __$PollResponseCopyWithImpl;
@override @useResult
$Res call({
 String userId, String pollId, String selectedOption, List<String> selectedOptions, String? previousOption, int voteCount, DateTime respondedAt, DateTime? updatedAt, String status, DateTime? invalidatedAt, String? invalidatedBy, String? invalidationReason, String? engagementId, bool tokensAwarded, Map<String, String?>? demographics, String? otherText, List<String> rankedOptions, String? textResponse, Map<String, int> scaleRatings
});




}
/// @nodoc
class __$PollResponseCopyWithImpl<$Res>
    implements _$PollResponseCopyWith<$Res> {
  __$PollResponseCopyWithImpl(this._self, this._then);

  final _PollResponse _self;
  final $Res Function(_PollResponse) _then;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? pollId = null,Object? selectedOption = null,Object? selectedOptions = null,Object? previousOption = freezed,Object? voteCount = null,Object? respondedAt = null,Object? updatedAt = freezed,Object? status = null,Object? invalidatedAt = freezed,Object? invalidatedBy = freezed,Object? invalidationReason = freezed,Object? engagementId = freezed,Object? tokensAwarded = null,Object? demographics = freezed,Object? otherText = freezed,Object? rankedOptions = null,Object? textResponse = freezed,Object? scaleRatings = null,}) {
  return _then(_PollResponse(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pollId: null == pollId ? _self.pollId : pollId // ignore: cast_nullable_to_non_nullable
as String,selectedOption: null == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String,selectedOptions: null == selectedOptions ? _self._selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as List<String>,previousOption: freezed == previousOption ? _self.previousOption : previousOption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,respondedAt: null == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,invalidatedAt: freezed == invalidatedAt ? _self.invalidatedAt : invalidatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invalidatedBy: freezed == invalidatedBy ? _self.invalidatedBy : invalidatedBy // ignore: cast_nullable_to_non_nullable
as String?,invalidationReason: freezed == invalidationReason ? _self.invalidationReason : invalidationReason // ignore: cast_nullable_to_non_nullable
as String?,engagementId: freezed == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String?,tokensAwarded: null == tokensAwarded ? _self.tokensAwarded : tokensAwarded // ignore: cast_nullable_to_non_nullable
as bool,demographics: freezed == demographics ? _self._demographics : demographics // ignore: cast_nullable_to_non_nullable
as Map<String, String?>?,otherText: freezed == otherText ? _self.otherText : otherText // ignore: cast_nullable_to_non_nullable
as String?,rankedOptions: null == rankedOptions ? _self._rankedOptions : rankedOptions // ignore: cast_nullable_to_non_nullable
as List<String>,textResponse: freezed == textResponse ? _self.textResponse : textResponse // ignore: cast_nullable_to_non_nullable
as String?,scaleRatings: null == scaleRatings ? _self._scaleRatings : scaleRatings // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}


/// @nodoc
mixin _$PollResults {

 int get totalRespondents; Map<String, int> get optionCounts; Map<String, double> get percentages;
/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollResultsCopyWith<PollResults> get copyWith => _$PollResultsCopyWithImpl<PollResults>(this as PollResults, _$identity);

  /// Serializes this PollResults to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollResults&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other.optionCounts, optionCounts)&&const DeepCollectionEquality().equals(other.percentages, percentages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRespondents,const DeepCollectionEquality().hash(optionCounts),const DeepCollectionEquality().hash(percentages));

@override
String toString() {
  return 'PollResults(totalRespondents: $totalRespondents, optionCounts: $optionCounts, percentages: $percentages)';
}


}

/// @nodoc
abstract mixin class $PollResultsCopyWith<$Res>  {
  factory $PollResultsCopyWith(PollResults value, $Res Function(PollResults) _then) = _$PollResultsCopyWithImpl;
@useResult
$Res call({
 int totalRespondents, Map<String, int> optionCounts, Map<String, double> percentages
});




}
/// @nodoc
class _$PollResultsCopyWithImpl<$Res>
    implements $PollResultsCopyWith<$Res> {
  _$PollResultsCopyWithImpl(this._self, this._then);

  final PollResults _self;
  final $Res Function(PollResults) _then;

/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRespondents = null,Object? optionCounts = null,Object? percentages = null,}) {
  return _then(_self.copyWith(
totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self.optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,percentages: null == percentages ? _self.percentages : percentages // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [PollResults].
extension PollResultsPatterns on PollResults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollResults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollResults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollResults value)  $default,){
final _that = this;
switch (_that) {
case _PollResults():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollResults value)?  $default,){
final _that = this;
switch (_that) {
case _PollResults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalRespondents,  Map<String, int> optionCounts,  Map<String, double> percentages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollResults() when $default != null:
return $default(_that.totalRespondents,_that.optionCounts,_that.percentages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalRespondents,  Map<String, int> optionCounts,  Map<String, double> percentages)  $default,) {final _that = this;
switch (_that) {
case _PollResults():
return $default(_that.totalRespondents,_that.optionCounts,_that.percentages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalRespondents,  Map<String, int> optionCounts,  Map<String, double> percentages)?  $default,) {final _that = this;
switch (_that) {
case _PollResults() when $default != null:
return $default(_that.totalRespondents,_that.optionCounts,_that.percentages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollResults implements PollResults {
  const _PollResults({required this.totalRespondents, required final  Map<String, int> optionCounts, required final  Map<String, double> percentages}): _optionCounts = optionCounts,_percentages = percentages;
  factory _PollResults.fromJson(Map<String, dynamic> json) => _$PollResultsFromJson(json);

@override final  int totalRespondents;
 final  Map<String, int> _optionCounts;
@override Map<String, int> get optionCounts {
  if (_optionCounts is EqualUnmodifiableMapView) return _optionCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionCounts);
}

 final  Map<String, double> _percentages;
@override Map<String, double> get percentages {
  if (_percentages is EqualUnmodifiableMapView) return _percentages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_percentages);
}


/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollResultsCopyWith<_PollResults> get copyWith => __$PollResultsCopyWithImpl<_PollResults>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollResultsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollResults&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other._optionCounts, _optionCounts)&&const DeepCollectionEquality().equals(other._percentages, _percentages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRespondents,const DeepCollectionEquality().hash(_optionCounts),const DeepCollectionEquality().hash(_percentages));

@override
String toString() {
  return 'PollResults(totalRespondents: $totalRespondents, optionCounts: $optionCounts, percentages: $percentages)';
}


}

/// @nodoc
abstract mixin class _$PollResultsCopyWith<$Res> implements $PollResultsCopyWith<$Res> {
  factory _$PollResultsCopyWith(_PollResults value, $Res Function(_PollResults) _then) = __$PollResultsCopyWithImpl;
@override @useResult
$Res call({
 int totalRespondents, Map<String, int> optionCounts, Map<String, double> percentages
});




}
/// @nodoc
class __$PollResultsCopyWithImpl<$Res>
    implements _$PollResultsCopyWith<$Res> {
  __$PollResultsCopyWithImpl(this._self, this._then);

  final _PollResults _self;
  final $Res Function(_PollResults) _then;

/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRespondents = null,Object? optionCounts = null,Object? percentages = null,}) {
  return _then(_PollResults(
totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self._optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,percentages: null == percentages ? _self._percentages : percentages // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
