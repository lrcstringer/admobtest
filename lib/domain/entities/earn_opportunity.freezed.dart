// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_opportunity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BranchRule {

 String get optionValue; String get goToQuestionId;
/// Create a copy of BranchRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchRuleCopyWith<BranchRule> get copyWith => _$BranchRuleCopyWithImpl<BranchRule>(this as BranchRule, _$identity);

  /// Serializes this BranchRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchRule&&(identical(other.optionValue, optionValue) || other.optionValue == optionValue)&&(identical(other.goToQuestionId, goToQuestionId) || other.goToQuestionId == goToQuestionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,optionValue,goToQuestionId);

@override
String toString() {
  return 'BranchRule(optionValue: $optionValue, goToQuestionId: $goToQuestionId)';
}


}

/// @nodoc
abstract mixin class $BranchRuleCopyWith<$Res>  {
  factory $BranchRuleCopyWith(BranchRule value, $Res Function(BranchRule) _then) = _$BranchRuleCopyWithImpl;
@useResult
$Res call({
 String optionValue, String goToQuestionId
});




}
/// @nodoc
class _$BranchRuleCopyWithImpl<$Res>
    implements $BranchRuleCopyWith<$Res> {
  _$BranchRuleCopyWithImpl(this._self, this._then);

  final BranchRule _self;
  final $Res Function(BranchRule) _then;

/// Create a copy of BranchRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionValue = null,Object? goToQuestionId = null,}) {
  return _then(_self.copyWith(
optionValue: null == optionValue ? _self.optionValue : optionValue // ignore: cast_nullable_to_non_nullable
as String,goToQuestionId: null == goToQuestionId ? _self.goToQuestionId : goToQuestionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchRule].
extension BranchRulePatterns on BranchRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchRule value)  $default,){
final _that = this;
switch (_that) {
case _BranchRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchRule value)?  $default,){
final _that = this;
switch (_that) {
case _BranchRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String optionValue,  String goToQuestionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BranchRule() when $default != null:
return $default(_that.optionValue,_that.goToQuestionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String optionValue,  String goToQuestionId)  $default,) {final _that = this;
switch (_that) {
case _BranchRule():
return $default(_that.optionValue,_that.goToQuestionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String optionValue,  String goToQuestionId)?  $default,) {final _that = this;
switch (_that) {
case _BranchRule() when $default != null:
return $default(_that.optionValue,_that.goToQuestionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BranchRule implements BranchRule {
  const _BranchRule({required this.optionValue, required this.goToQuestionId});
  factory _BranchRule.fromJson(Map<String, dynamic> json) => _$BranchRuleFromJson(json);

@override final  String optionValue;
@override final  String goToQuestionId;

/// Create a copy of BranchRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchRuleCopyWith<_BranchRule> get copyWith => __$BranchRuleCopyWithImpl<_BranchRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BranchRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchRule&&(identical(other.optionValue, optionValue) || other.optionValue == optionValue)&&(identical(other.goToQuestionId, goToQuestionId) || other.goToQuestionId == goToQuestionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,optionValue,goToQuestionId);

@override
String toString() {
  return 'BranchRule(optionValue: $optionValue, goToQuestionId: $goToQuestionId)';
}


}

/// @nodoc
abstract mixin class _$BranchRuleCopyWith<$Res> implements $BranchRuleCopyWith<$Res> {
  factory _$BranchRuleCopyWith(_BranchRule value, $Res Function(_BranchRule) _then) = __$BranchRuleCopyWithImpl;
@override @useResult
$Res call({
 String optionValue, String goToQuestionId
});




}
/// @nodoc
class __$BranchRuleCopyWithImpl<$Res>
    implements _$BranchRuleCopyWith<$Res> {
  __$BranchRuleCopyWithImpl(this._self, this._then);

  final _BranchRule _self;
  final $Res Function(_BranchRule) _then;

/// Create a copy of BranchRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionValue = null,Object? goToQuestionId = null,}) {
  return _then(_BranchRule(
optionValue: null == optionValue ? _self.optionValue : optionValue // ignore: cast_nullable_to_non_nullable
as String,goToQuestionId: null == goToQuestionId ? _self.goToQuestionId : goToQuestionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SurveyQuestion {

 String get id; String get text; int get orderIndex; QuestionType get questionType; bool get isRequired;// --- single_select + multi_select ---
 List<String> get options; int? get maxSelections;// multi_select only
// --- text_input ---
 int get textInputCount; int get textMaxLength;// --- likert ---
 int get likertScale; String? get likertLowLabel; String? get likertHighLabel;// --- star_tags ---
 int get maxStars; List<String> get tags; int? get maxTags;// --- slider ---
 int get sliderMin; int get sliderMax; int get sliderStep; String? get sliderMinLabel; String? get sliderMaxLabel;// --- Attention check (single_select only) ---
 bool get isAttentionCheck; String? get correctAnswer;// --- Correctness-based branching (single_select + attention check) ---
/// Jump here when the user answers correctly (takes priority over branchRules)
 String? get correctGoToQuestionId;/// Jump here when the user answers incorrectly (takes priority over branchRules)
 String? get incorrectGoToQuestionId;// --- Response Box (optional interstitial before branching) ---
 String? get correctResponseText; String? get correctResponseMediaUrl; String? get correctResponseMediaType;// "image" or "video"
 String? get incorrectResponseText; String? get incorrectResponseMediaUrl; String? get incorrectResponseMediaType;// "image" or "video"
// --- Branching (single_select only) ---
 List<BranchRule> get branchRules;
/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyQuestionCopyWith<SurveyQuestion> get copyWith => _$SurveyQuestionCopyWithImpl<SurveyQuestion>(this as SurveyQuestion, _$identity);

  /// Serializes this SurveyQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.maxSelections, maxSelections) || other.maxSelections == maxSelections)&&(identical(other.textInputCount, textInputCount) || other.textInputCount == textInputCount)&&(identical(other.textMaxLength, textMaxLength) || other.textMaxLength == textMaxLength)&&(identical(other.likertScale, likertScale) || other.likertScale == likertScale)&&(identical(other.likertLowLabel, likertLowLabel) || other.likertLowLabel == likertLowLabel)&&(identical(other.likertHighLabel, likertHighLabel) || other.likertHighLabel == likertHighLabel)&&(identical(other.maxStars, maxStars) || other.maxStars == maxStars)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.maxTags, maxTags) || other.maxTags == maxTags)&&(identical(other.sliderMin, sliderMin) || other.sliderMin == sliderMin)&&(identical(other.sliderMax, sliderMax) || other.sliderMax == sliderMax)&&(identical(other.sliderStep, sliderStep) || other.sliderStep == sliderStep)&&(identical(other.sliderMinLabel, sliderMinLabel) || other.sliderMinLabel == sliderMinLabel)&&(identical(other.sliderMaxLabel, sliderMaxLabel) || other.sliderMaxLabel == sliderMaxLabel)&&(identical(other.isAttentionCheck, isAttentionCheck) || other.isAttentionCheck == isAttentionCheck)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.correctGoToQuestionId, correctGoToQuestionId) || other.correctGoToQuestionId == correctGoToQuestionId)&&(identical(other.incorrectGoToQuestionId, incorrectGoToQuestionId) || other.incorrectGoToQuestionId == incorrectGoToQuestionId)&&(identical(other.correctResponseText, correctResponseText) || other.correctResponseText == correctResponseText)&&(identical(other.correctResponseMediaUrl, correctResponseMediaUrl) || other.correctResponseMediaUrl == correctResponseMediaUrl)&&(identical(other.correctResponseMediaType, correctResponseMediaType) || other.correctResponseMediaType == correctResponseMediaType)&&(identical(other.incorrectResponseText, incorrectResponseText) || other.incorrectResponseText == incorrectResponseText)&&(identical(other.incorrectResponseMediaUrl, incorrectResponseMediaUrl) || other.incorrectResponseMediaUrl == incorrectResponseMediaUrl)&&(identical(other.incorrectResponseMediaType, incorrectResponseMediaType) || other.incorrectResponseMediaType == incorrectResponseMediaType)&&const DeepCollectionEquality().equals(other.branchRules, branchRules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,text,orderIndex,questionType,isRequired,const DeepCollectionEquality().hash(options),maxSelections,textInputCount,textMaxLength,likertScale,likertLowLabel,likertHighLabel,maxStars,const DeepCollectionEquality().hash(tags),maxTags,sliderMin,sliderMax,sliderStep,sliderMinLabel,sliderMaxLabel,isAttentionCheck,correctAnswer,correctGoToQuestionId,incorrectGoToQuestionId,correctResponseText,correctResponseMediaUrl,correctResponseMediaType,incorrectResponseText,incorrectResponseMediaUrl,incorrectResponseMediaType,const DeepCollectionEquality().hash(branchRules)]);

@override
String toString() {
  return 'SurveyQuestion(id: $id, text: $text, orderIndex: $orderIndex, questionType: $questionType, isRequired: $isRequired, options: $options, maxSelections: $maxSelections, textInputCount: $textInputCount, textMaxLength: $textMaxLength, likertScale: $likertScale, likertLowLabel: $likertLowLabel, likertHighLabel: $likertHighLabel, maxStars: $maxStars, tags: $tags, maxTags: $maxTags, sliderMin: $sliderMin, sliderMax: $sliderMax, sliderStep: $sliderStep, sliderMinLabel: $sliderMinLabel, sliderMaxLabel: $sliderMaxLabel, isAttentionCheck: $isAttentionCheck, correctAnswer: $correctAnswer, correctGoToQuestionId: $correctGoToQuestionId, incorrectGoToQuestionId: $incorrectGoToQuestionId, correctResponseText: $correctResponseText, correctResponseMediaUrl: $correctResponseMediaUrl, correctResponseMediaType: $correctResponseMediaType, incorrectResponseText: $incorrectResponseText, incorrectResponseMediaUrl: $incorrectResponseMediaUrl, incorrectResponseMediaType: $incorrectResponseMediaType, branchRules: $branchRules)';
}


}

/// @nodoc
abstract mixin class $SurveyQuestionCopyWith<$Res>  {
  factory $SurveyQuestionCopyWith(SurveyQuestion value, $Res Function(SurveyQuestion) _then) = _$SurveyQuestionCopyWithImpl;
@useResult
$Res call({
 String id, String text, int orderIndex, QuestionType questionType, bool isRequired, List<String> options, int? maxSelections, int textInputCount, int textMaxLength, int likertScale, String? likertLowLabel, String? likertHighLabel, int maxStars, List<String> tags, int? maxTags, int sliderMin, int sliderMax, int sliderStep, String? sliderMinLabel, String? sliderMaxLabel, bool isAttentionCheck, String? correctAnswer, String? correctGoToQuestionId, String? incorrectGoToQuestionId, String? correctResponseText, String? correctResponseMediaUrl, String? correctResponseMediaType, String? incorrectResponseText, String? incorrectResponseMediaUrl, String? incorrectResponseMediaType, List<BranchRule> branchRules
});




}
/// @nodoc
class _$SurveyQuestionCopyWithImpl<$Res>
    implements $SurveyQuestionCopyWith<$Res> {
  _$SurveyQuestionCopyWithImpl(this._self, this._then);

  final SurveyQuestion _self;
  final $Res Function(SurveyQuestion) _then;

/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? orderIndex = null,Object? questionType = null,Object? isRequired = null,Object? options = null,Object? maxSelections = freezed,Object? textInputCount = null,Object? textMaxLength = null,Object? likertScale = null,Object? likertLowLabel = freezed,Object? likertHighLabel = freezed,Object? maxStars = null,Object? tags = null,Object? maxTags = freezed,Object? sliderMin = null,Object? sliderMax = null,Object? sliderStep = null,Object? sliderMinLabel = freezed,Object? sliderMaxLabel = freezed,Object? isAttentionCheck = null,Object? correctAnswer = freezed,Object? correctGoToQuestionId = freezed,Object? incorrectGoToQuestionId = freezed,Object? correctResponseText = freezed,Object? correctResponseMediaUrl = freezed,Object? correctResponseMediaType = freezed,Object? incorrectResponseText = freezed,Object? incorrectResponseMediaUrl = freezed,Object? incorrectResponseMediaType = freezed,Object? branchRules = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuestionType,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,maxSelections: freezed == maxSelections ? _self.maxSelections : maxSelections // ignore: cast_nullable_to_non_nullable
as int?,textInputCount: null == textInputCount ? _self.textInputCount : textInputCount // ignore: cast_nullable_to_non_nullable
as int,textMaxLength: null == textMaxLength ? _self.textMaxLength : textMaxLength // ignore: cast_nullable_to_non_nullable
as int,likertScale: null == likertScale ? _self.likertScale : likertScale // ignore: cast_nullable_to_non_nullable
as int,likertLowLabel: freezed == likertLowLabel ? _self.likertLowLabel : likertLowLabel // ignore: cast_nullable_to_non_nullable
as String?,likertHighLabel: freezed == likertHighLabel ? _self.likertHighLabel : likertHighLabel // ignore: cast_nullable_to_non_nullable
as String?,maxStars: null == maxStars ? _self.maxStars : maxStars // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,maxTags: freezed == maxTags ? _self.maxTags : maxTags // ignore: cast_nullable_to_non_nullable
as int?,sliderMin: null == sliderMin ? _self.sliderMin : sliderMin // ignore: cast_nullable_to_non_nullable
as int,sliderMax: null == sliderMax ? _self.sliderMax : sliderMax // ignore: cast_nullable_to_non_nullable
as int,sliderStep: null == sliderStep ? _self.sliderStep : sliderStep // ignore: cast_nullable_to_non_nullable
as int,sliderMinLabel: freezed == sliderMinLabel ? _self.sliderMinLabel : sliderMinLabel // ignore: cast_nullable_to_non_nullable
as String?,sliderMaxLabel: freezed == sliderMaxLabel ? _self.sliderMaxLabel : sliderMaxLabel // ignore: cast_nullable_to_non_nullable
as String?,isAttentionCheck: null == isAttentionCheck ? _self.isAttentionCheck : isAttentionCheck // ignore: cast_nullable_to_non_nullable
as bool,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String?,correctGoToQuestionId: freezed == correctGoToQuestionId ? _self.correctGoToQuestionId : correctGoToQuestionId // ignore: cast_nullable_to_non_nullable
as String?,incorrectGoToQuestionId: freezed == incorrectGoToQuestionId ? _self.incorrectGoToQuestionId : incorrectGoToQuestionId // ignore: cast_nullable_to_non_nullable
as String?,correctResponseText: freezed == correctResponseText ? _self.correctResponseText : correctResponseText // ignore: cast_nullable_to_non_nullable
as String?,correctResponseMediaUrl: freezed == correctResponseMediaUrl ? _self.correctResponseMediaUrl : correctResponseMediaUrl // ignore: cast_nullable_to_non_nullable
as String?,correctResponseMediaType: freezed == correctResponseMediaType ? _self.correctResponseMediaType : correctResponseMediaType // ignore: cast_nullable_to_non_nullable
as String?,incorrectResponseText: freezed == incorrectResponseText ? _self.incorrectResponseText : incorrectResponseText // ignore: cast_nullable_to_non_nullable
as String?,incorrectResponseMediaUrl: freezed == incorrectResponseMediaUrl ? _self.incorrectResponseMediaUrl : incorrectResponseMediaUrl // ignore: cast_nullable_to_non_nullable
as String?,incorrectResponseMediaType: freezed == incorrectResponseMediaType ? _self.incorrectResponseMediaType : incorrectResponseMediaType // ignore: cast_nullable_to_non_nullable
as String?,branchRules: null == branchRules ? _self.branchRules : branchRules // ignore: cast_nullable_to_non_nullable
as List<BranchRule>,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyQuestion].
extension SurveyQuestionPatterns on SurveyQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyQuestion value)  $default,){
final _that = this;
switch (_that) {
case _SurveyQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  int orderIndex,  QuestionType questionType,  bool isRequired,  List<String> options,  int? maxSelections,  int textInputCount,  int textMaxLength,  int likertScale,  String? likertLowLabel,  String? likertHighLabel,  int maxStars,  List<String> tags,  int? maxTags,  int sliderMin,  int sliderMax,  int sliderStep,  String? sliderMinLabel,  String? sliderMaxLabel,  bool isAttentionCheck,  String? correctAnswer,  String? correctGoToQuestionId,  String? incorrectGoToQuestionId,  String? correctResponseText,  String? correctResponseMediaUrl,  String? correctResponseMediaType,  String? incorrectResponseText,  String? incorrectResponseMediaUrl,  String? incorrectResponseMediaType,  List<BranchRule> branchRules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that.id,_that.text,_that.orderIndex,_that.questionType,_that.isRequired,_that.options,_that.maxSelections,_that.textInputCount,_that.textMaxLength,_that.likertScale,_that.likertLowLabel,_that.likertHighLabel,_that.maxStars,_that.tags,_that.maxTags,_that.sliderMin,_that.sliderMax,_that.sliderStep,_that.sliderMinLabel,_that.sliderMaxLabel,_that.isAttentionCheck,_that.correctAnswer,_that.correctGoToQuestionId,_that.incorrectGoToQuestionId,_that.correctResponseText,_that.correctResponseMediaUrl,_that.correctResponseMediaType,_that.incorrectResponseText,_that.incorrectResponseMediaUrl,_that.incorrectResponseMediaType,_that.branchRules);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  int orderIndex,  QuestionType questionType,  bool isRequired,  List<String> options,  int? maxSelections,  int textInputCount,  int textMaxLength,  int likertScale,  String? likertLowLabel,  String? likertHighLabel,  int maxStars,  List<String> tags,  int? maxTags,  int sliderMin,  int sliderMax,  int sliderStep,  String? sliderMinLabel,  String? sliderMaxLabel,  bool isAttentionCheck,  String? correctAnswer,  String? correctGoToQuestionId,  String? incorrectGoToQuestionId,  String? correctResponseText,  String? correctResponseMediaUrl,  String? correctResponseMediaType,  String? incorrectResponseText,  String? incorrectResponseMediaUrl,  String? incorrectResponseMediaType,  List<BranchRule> branchRules)  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestion():
return $default(_that.id,_that.text,_that.orderIndex,_that.questionType,_that.isRequired,_that.options,_that.maxSelections,_that.textInputCount,_that.textMaxLength,_that.likertScale,_that.likertLowLabel,_that.likertHighLabel,_that.maxStars,_that.tags,_that.maxTags,_that.sliderMin,_that.sliderMax,_that.sliderStep,_that.sliderMinLabel,_that.sliderMaxLabel,_that.isAttentionCheck,_that.correctAnswer,_that.correctGoToQuestionId,_that.incorrectGoToQuestionId,_that.correctResponseText,_that.correctResponseMediaUrl,_that.correctResponseMediaType,_that.incorrectResponseText,_that.incorrectResponseMediaUrl,_that.incorrectResponseMediaType,_that.branchRules);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  int orderIndex,  QuestionType questionType,  bool isRequired,  List<String> options,  int? maxSelections,  int textInputCount,  int textMaxLength,  int likertScale,  String? likertLowLabel,  String? likertHighLabel,  int maxStars,  List<String> tags,  int? maxTags,  int sliderMin,  int sliderMax,  int sliderStep,  String? sliderMinLabel,  String? sliderMaxLabel,  bool isAttentionCheck,  String? correctAnswer,  String? correctGoToQuestionId,  String? incorrectGoToQuestionId,  String? correctResponseText,  String? correctResponseMediaUrl,  String? correctResponseMediaType,  String? incorrectResponseText,  String? incorrectResponseMediaUrl,  String? incorrectResponseMediaType,  List<BranchRule> branchRules)?  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that.id,_that.text,_that.orderIndex,_that.questionType,_that.isRequired,_that.options,_that.maxSelections,_that.textInputCount,_that.textMaxLength,_that.likertScale,_that.likertLowLabel,_that.likertHighLabel,_that.maxStars,_that.tags,_that.maxTags,_that.sliderMin,_that.sliderMax,_that.sliderStep,_that.sliderMinLabel,_that.sliderMaxLabel,_that.isAttentionCheck,_that.correctAnswer,_that.correctGoToQuestionId,_that.incorrectGoToQuestionId,_that.correctResponseText,_that.correctResponseMediaUrl,_that.correctResponseMediaType,_that.incorrectResponseText,_that.incorrectResponseMediaUrl,_that.incorrectResponseMediaType,_that.branchRules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyQuestion implements SurveyQuestion {
  const _SurveyQuestion({required this.id, required this.text, required this.orderIndex, required this.questionType, this.isRequired = true, final  List<String> options = const [], this.maxSelections, this.textInputCount = 1, this.textMaxLength = 50, this.likertScale = 5, this.likertLowLabel, this.likertHighLabel, this.maxStars = 5, final  List<String> tags = const [], this.maxTags, this.sliderMin = 0, this.sliderMax = 100, this.sliderStep = 1, this.sliderMinLabel, this.sliderMaxLabel, this.isAttentionCheck = false, this.correctAnswer, this.correctGoToQuestionId, this.incorrectGoToQuestionId, this.correctResponseText, this.correctResponseMediaUrl, this.correctResponseMediaType, this.incorrectResponseText, this.incorrectResponseMediaUrl, this.incorrectResponseMediaType, final  List<BranchRule> branchRules = const []}): _options = options,_tags = tags,_branchRules = branchRules;
  factory _SurveyQuestion.fromJson(Map<String, dynamic> json) => _$SurveyQuestionFromJson(json);

@override final  String id;
@override final  String text;
@override final  int orderIndex;
@override final  QuestionType questionType;
@override@JsonKey() final  bool isRequired;
// --- single_select + multi_select ---
 final  List<String> _options;
// --- single_select + multi_select ---
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  int? maxSelections;
// multi_select only
// --- text_input ---
@override@JsonKey() final  int textInputCount;
@override@JsonKey() final  int textMaxLength;
// --- likert ---
@override@JsonKey() final  int likertScale;
@override final  String? likertLowLabel;
@override final  String? likertHighLabel;
// --- star_tags ---
@override@JsonKey() final  int maxStars;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  int? maxTags;
// --- slider ---
@override@JsonKey() final  int sliderMin;
@override@JsonKey() final  int sliderMax;
@override@JsonKey() final  int sliderStep;
@override final  String? sliderMinLabel;
@override final  String? sliderMaxLabel;
// --- Attention check (single_select only) ---
@override@JsonKey() final  bool isAttentionCheck;
@override final  String? correctAnswer;
// --- Correctness-based branching (single_select + attention check) ---
/// Jump here when the user answers correctly (takes priority over branchRules)
@override final  String? correctGoToQuestionId;
/// Jump here when the user answers incorrectly (takes priority over branchRules)
@override final  String? incorrectGoToQuestionId;
// --- Response Box (optional interstitial before branching) ---
@override final  String? correctResponseText;
@override final  String? correctResponseMediaUrl;
@override final  String? correctResponseMediaType;
// "image" or "video"
@override final  String? incorrectResponseText;
@override final  String? incorrectResponseMediaUrl;
@override final  String? incorrectResponseMediaType;
// "image" or "video"
// --- Branching (single_select only) ---
 final  List<BranchRule> _branchRules;
// "image" or "video"
// --- Branching (single_select only) ---
@override@JsonKey() List<BranchRule> get branchRules {
  if (_branchRules is EqualUnmodifiableListView) return _branchRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branchRules);
}


/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyQuestionCopyWith<_SurveyQuestion> get copyWith => __$SurveyQuestionCopyWithImpl<_SurveyQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.maxSelections, maxSelections) || other.maxSelections == maxSelections)&&(identical(other.textInputCount, textInputCount) || other.textInputCount == textInputCount)&&(identical(other.textMaxLength, textMaxLength) || other.textMaxLength == textMaxLength)&&(identical(other.likertScale, likertScale) || other.likertScale == likertScale)&&(identical(other.likertLowLabel, likertLowLabel) || other.likertLowLabel == likertLowLabel)&&(identical(other.likertHighLabel, likertHighLabel) || other.likertHighLabel == likertHighLabel)&&(identical(other.maxStars, maxStars) || other.maxStars == maxStars)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.maxTags, maxTags) || other.maxTags == maxTags)&&(identical(other.sliderMin, sliderMin) || other.sliderMin == sliderMin)&&(identical(other.sliderMax, sliderMax) || other.sliderMax == sliderMax)&&(identical(other.sliderStep, sliderStep) || other.sliderStep == sliderStep)&&(identical(other.sliderMinLabel, sliderMinLabel) || other.sliderMinLabel == sliderMinLabel)&&(identical(other.sliderMaxLabel, sliderMaxLabel) || other.sliderMaxLabel == sliderMaxLabel)&&(identical(other.isAttentionCheck, isAttentionCheck) || other.isAttentionCheck == isAttentionCheck)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.correctGoToQuestionId, correctGoToQuestionId) || other.correctGoToQuestionId == correctGoToQuestionId)&&(identical(other.incorrectGoToQuestionId, incorrectGoToQuestionId) || other.incorrectGoToQuestionId == incorrectGoToQuestionId)&&(identical(other.correctResponseText, correctResponseText) || other.correctResponseText == correctResponseText)&&(identical(other.correctResponseMediaUrl, correctResponseMediaUrl) || other.correctResponseMediaUrl == correctResponseMediaUrl)&&(identical(other.correctResponseMediaType, correctResponseMediaType) || other.correctResponseMediaType == correctResponseMediaType)&&(identical(other.incorrectResponseText, incorrectResponseText) || other.incorrectResponseText == incorrectResponseText)&&(identical(other.incorrectResponseMediaUrl, incorrectResponseMediaUrl) || other.incorrectResponseMediaUrl == incorrectResponseMediaUrl)&&(identical(other.incorrectResponseMediaType, incorrectResponseMediaType) || other.incorrectResponseMediaType == incorrectResponseMediaType)&&const DeepCollectionEquality().equals(other._branchRules, _branchRules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,text,orderIndex,questionType,isRequired,const DeepCollectionEquality().hash(_options),maxSelections,textInputCount,textMaxLength,likertScale,likertLowLabel,likertHighLabel,maxStars,const DeepCollectionEquality().hash(_tags),maxTags,sliderMin,sliderMax,sliderStep,sliderMinLabel,sliderMaxLabel,isAttentionCheck,correctAnswer,correctGoToQuestionId,incorrectGoToQuestionId,correctResponseText,correctResponseMediaUrl,correctResponseMediaType,incorrectResponseText,incorrectResponseMediaUrl,incorrectResponseMediaType,const DeepCollectionEquality().hash(_branchRules)]);

@override
String toString() {
  return 'SurveyQuestion(id: $id, text: $text, orderIndex: $orderIndex, questionType: $questionType, isRequired: $isRequired, options: $options, maxSelections: $maxSelections, textInputCount: $textInputCount, textMaxLength: $textMaxLength, likertScale: $likertScale, likertLowLabel: $likertLowLabel, likertHighLabel: $likertHighLabel, maxStars: $maxStars, tags: $tags, maxTags: $maxTags, sliderMin: $sliderMin, sliderMax: $sliderMax, sliderStep: $sliderStep, sliderMinLabel: $sliderMinLabel, sliderMaxLabel: $sliderMaxLabel, isAttentionCheck: $isAttentionCheck, correctAnswer: $correctAnswer, correctGoToQuestionId: $correctGoToQuestionId, incorrectGoToQuestionId: $incorrectGoToQuestionId, correctResponseText: $correctResponseText, correctResponseMediaUrl: $correctResponseMediaUrl, correctResponseMediaType: $correctResponseMediaType, incorrectResponseText: $incorrectResponseText, incorrectResponseMediaUrl: $incorrectResponseMediaUrl, incorrectResponseMediaType: $incorrectResponseMediaType, branchRules: $branchRules)';
}


}

/// @nodoc
abstract mixin class _$SurveyQuestionCopyWith<$Res> implements $SurveyQuestionCopyWith<$Res> {
  factory _$SurveyQuestionCopyWith(_SurveyQuestion value, $Res Function(_SurveyQuestion) _then) = __$SurveyQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, int orderIndex, QuestionType questionType, bool isRequired, List<String> options, int? maxSelections, int textInputCount, int textMaxLength, int likertScale, String? likertLowLabel, String? likertHighLabel, int maxStars, List<String> tags, int? maxTags, int sliderMin, int sliderMax, int sliderStep, String? sliderMinLabel, String? sliderMaxLabel, bool isAttentionCheck, String? correctAnswer, String? correctGoToQuestionId, String? incorrectGoToQuestionId, String? correctResponseText, String? correctResponseMediaUrl, String? correctResponseMediaType, String? incorrectResponseText, String? incorrectResponseMediaUrl, String? incorrectResponseMediaType, List<BranchRule> branchRules
});




}
/// @nodoc
class __$SurveyQuestionCopyWithImpl<$Res>
    implements _$SurveyQuestionCopyWith<$Res> {
  __$SurveyQuestionCopyWithImpl(this._self, this._then);

  final _SurveyQuestion _self;
  final $Res Function(_SurveyQuestion) _then;

/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? orderIndex = null,Object? questionType = null,Object? isRequired = null,Object? options = null,Object? maxSelections = freezed,Object? textInputCount = null,Object? textMaxLength = null,Object? likertScale = null,Object? likertLowLabel = freezed,Object? likertHighLabel = freezed,Object? maxStars = null,Object? tags = null,Object? maxTags = freezed,Object? sliderMin = null,Object? sliderMax = null,Object? sliderStep = null,Object? sliderMinLabel = freezed,Object? sliderMaxLabel = freezed,Object? isAttentionCheck = null,Object? correctAnswer = freezed,Object? correctGoToQuestionId = freezed,Object? incorrectGoToQuestionId = freezed,Object? correctResponseText = freezed,Object? correctResponseMediaUrl = freezed,Object? correctResponseMediaType = freezed,Object? incorrectResponseText = freezed,Object? incorrectResponseMediaUrl = freezed,Object? incorrectResponseMediaType = freezed,Object? branchRules = null,}) {
  return _then(_SurveyQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as QuestionType,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,maxSelections: freezed == maxSelections ? _self.maxSelections : maxSelections // ignore: cast_nullable_to_non_nullable
as int?,textInputCount: null == textInputCount ? _self.textInputCount : textInputCount // ignore: cast_nullable_to_non_nullable
as int,textMaxLength: null == textMaxLength ? _self.textMaxLength : textMaxLength // ignore: cast_nullable_to_non_nullable
as int,likertScale: null == likertScale ? _self.likertScale : likertScale // ignore: cast_nullable_to_non_nullable
as int,likertLowLabel: freezed == likertLowLabel ? _self.likertLowLabel : likertLowLabel // ignore: cast_nullable_to_non_nullable
as String?,likertHighLabel: freezed == likertHighLabel ? _self.likertHighLabel : likertHighLabel // ignore: cast_nullable_to_non_nullable
as String?,maxStars: null == maxStars ? _self.maxStars : maxStars // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,maxTags: freezed == maxTags ? _self.maxTags : maxTags // ignore: cast_nullable_to_non_nullable
as int?,sliderMin: null == sliderMin ? _self.sliderMin : sliderMin // ignore: cast_nullable_to_non_nullable
as int,sliderMax: null == sliderMax ? _self.sliderMax : sliderMax // ignore: cast_nullable_to_non_nullable
as int,sliderStep: null == sliderStep ? _self.sliderStep : sliderStep // ignore: cast_nullable_to_non_nullable
as int,sliderMinLabel: freezed == sliderMinLabel ? _self.sliderMinLabel : sliderMinLabel // ignore: cast_nullable_to_non_nullable
as String?,sliderMaxLabel: freezed == sliderMaxLabel ? _self.sliderMaxLabel : sliderMaxLabel // ignore: cast_nullable_to_non_nullable
as String?,isAttentionCheck: null == isAttentionCheck ? _self.isAttentionCheck : isAttentionCheck // ignore: cast_nullable_to_non_nullable
as bool,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String?,correctGoToQuestionId: freezed == correctGoToQuestionId ? _self.correctGoToQuestionId : correctGoToQuestionId // ignore: cast_nullable_to_non_nullable
as String?,incorrectGoToQuestionId: freezed == incorrectGoToQuestionId ? _self.incorrectGoToQuestionId : incorrectGoToQuestionId // ignore: cast_nullable_to_non_nullable
as String?,correctResponseText: freezed == correctResponseText ? _self.correctResponseText : correctResponseText // ignore: cast_nullable_to_non_nullable
as String?,correctResponseMediaUrl: freezed == correctResponseMediaUrl ? _self.correctResponseMediaUrl : correctResponseMediaUrl // ignore: cast_nullable_to_non_nullable
as String?,correctResponseMediaType: freezed == correctResponseMediaType ? _self.correctResponseMediaType : correctResponseMediaType // ignore: cast_nullable_to_non_nullable
as String?,incorrectResponseText: freezed == incorrectResponseText ? _self.incorrectResponseText : incorrectResponseText // ignore: cast_nullable_to_non_nullable
as String?,incorrectResponseMediaUrl: freezed == incorrectResponseMediaUrl ? _self.incorrectResponseMediaUrl : incorrectResponseMediaUrl // ignore: cast_nullable_to_non_nullable
as String?,incorrectResponseMediaType: freezed == incorrectResponseMediaType ? _self.incorrectResponseMediaType : incorrectResponseMediaType // ignore: cast_nullable_to_non_nullable
as String?,branchRules: null == branchRules ? _self._branchRules : branchRules // ignore: cast_nullable_to_non_nullable
as List<BranchRule>,
  ));
}


}


/// @nodoc
mixin _$EarnOpportunity {

 String get id; String get threadId; String get title; String? get description;// Earning configuration
 EarningType get earningType; int get tokenReward; int get streakPoints; MediaType get mediaType; String? get mediaUrl; List<SurveyQuestion> get questions; int get durationSeconds; DateTime? get expiresAt; bool get isActive;// Pin/feature flags for ordering
 bool get isPinned; bool get isFeatured;// Denormalized client info
 String? get clientId; String? get clientName; String? get clientAvatarColor; String? get clientAvatarImage; String? get threadImage; String? get opportunityImage;// Legacy campaign reference
 String? get campaignId;// Targeting
 TargetingCriteria? get targeting;// Bonus reward configuration
 bool get bonusReward; double get bonusRewardMultiplier; BonusIntervalType? get bonusIntervalType; int? get bonusIntervalX;// User engagement status (populated by getEligibleOpportunities)
 String? get userEngagementStatus; String? get userEngagementId;// AdMob configuration
 String? get adUnitId; int get dailyLimitPerUser;// Budget cap fields
 bool get budgetExhausted; int? get tokenBudget; int get tokenSpent;// Poll link
 String? get pollId;// Upload configuration (earningType == upload)
 String? get uploadPrompt; String? get uploadContextMediaUrl; String? get uploadContextMediaType; bool get uploadVideoEnabled; bool get uploadImageEnabled; bool get uploadTextEnabled; bool get uploadVideoRequired; bool get uploadImageRequired; bool get uploadTextRequired; int get uploadVideoMaxSeconds; int get uploadTextMinChars; int get uploadTextMaxChars; bool get requiresAdminReview;// Token source (opportunity-level override; falls back to thread-level)
 String? get tokenSourceAccountId;// Reward campaign linkage
 String? get rewardCampaignId; String? get rewardCampaignName; String? get rewardType; int get rewardQuantity;
/// Create a copy of EarnOpportunity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnOpportunityCopyWith<EarnOpportunity> get copyWith => _$EarnOpportunityCopyWithImpl<EarnOpportunity>(this as EarnOpportunity, _$identity);

  /// Serializes this EarnOpportunity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnOpportunity&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.earningType, earningType) || other.earningType == earningType)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.streakPoints, streakPoints) || other.streakPoints == streakPoints)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.opportunityImage, opportunityImage) || other.opportunityImage == opportunityImage)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.targeting, targeting) || other.targeting == targeting)&&(identical(other.bonusReward, bonusReward) || other.bonusReward == bonusReward)&&(identical(other.bonusRewardMultiplier, bonusRewardMultiplier) || other.bonusRewardMultiplier == bonusRewardMultiplier)&&(identical(other.bonusIntervalType, bonusIntervalType) || other.bonusIntervalType == bonusIntervalType)&&(identical(other.bonusIntervalX, bonusIntervalX) || other.bonusIntervalX == bonusIntervalX)&&(identical(other.userEngagementStatus, userEngagementStatus) || other.userEngagementStatus == userEngagementStatus)&&(identical(other.userEngagementId, userEngagementId) || other.userEngagementId == userEngagementId)&&(identical(other.adUnitId, adUnitId) || other.adUnitId == adUnitId)&&(identical(other.dailyLimitPerUser, dailyLimitPerUser) || other.dailyLimitPerUser == dailyLimitPerUser)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.tokenBudget, tokenBudget) || other.tokenBudget == tokenBudget)&&(identical(other.tokenSpent, tokenSpent) || other.tokenSpent == tokenSpent)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.uploadPrompt, uploadPrompt) || other.uploadPrompt == uploadPrompt)&&(identical(other.uploadContextMediaUrl, uploadContextMediaUrl) || other.uploadContextMediaUrl == uploadContextMediaUrl)&&(identical(other.uploadContextMediaType, uploadContextMediaType) || other.uploadContextMediaType == uploadContextMediaType)&&(identical(other.uploadVideoEnabled, uploadVideoEnabled) || other.uploadVideoEnabled == uploadVideoEnabled)&&(identical(other.uploadImageEnabled, uploadImageEnabled) || other.uploadImageEnabled == uploadImageEnabled)&&(identical(other.uploadTextEnabled, uploadTextEnabled) || other.uploadTextEnabled == uploadTextEnabled)&&(identical(other.uploadVideoRequired, uploadVideoRequired) || other.uploadVideoRequired == uploadVideoRequired)&&(identical(other.uploadImageRequired, uploadImageRequired) || other.uploadImageRequired == uploadImageRequired)&&(identical(other.uploadTextRequired, uploadTextRequired) || other.uploadTextRequired == uploadTextRequired)&&(identical(other.uploadVideoMaxSeconds, uploadVideoMaxSeconds) || other.uploadVideoMaxSeconds == uploadVideoMaxSeconds)&&(identical(other.uploadTextMinChars, uploadTextMinChars) || other.uploadTextMinChars == uploadTextMinChars)&&(identical(other.uploadTextMaxChars, uploadTextMaxChars) || other.uploadTextMaxChars == uploadTextMaxChars)&&(identical(other.requiresAdminReview, requiresAdminReview) || other.requiresAdminReview == requiresAdminReview)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.rewardCampaignId, rewardCampaignId) || other.rewardCampaignId == rewardCampaignId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardQuantity, rewardQuantity) || other.rewardQuantity == rewardQuantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,threadId,title,description,earningType,tokenReward,streakPoints,mediaType,mediaUrl,const DeepCollectionEquality().hash(questions),durationSeconds,expiresAt,isActive,isPinned,isFeatured,clientId,clientName,clientAvatarColor,clientAvatarImage,threadImage,opportunityImage,campaignId,targeting,bonusReward,bonusRewardMultiplier,bonusIntervalType,bonusIntervalX,userEngagementStatus,userEngagementId,adUnitId,dailyLimitPerUser,budgetExhausted,tokenBudget,tokenSpent,pollId,uploadPrompt,uploadContextMediaUrl,uploadContextMediaType,uploadVideoEnabled,uploadImageEnabled,uploadTextEnabled,uploadVideoRequired,uploadImageRequired,uploadTextRequired,uploadVideoMaxSeconds,uploadTextMinChars,uploadTextMaxChars,requiresAdminReview,tokenSourceAccountId,rewardCampaignId,rewardCampaignName,rewardType,rewardQuantity]);

@override
String toString() {
  return 'EarnOpportunity(id: $id, threadId: $threadId, title: $title, description: $description, earningType: $earningType, tokenReward: $tokenReward, streakPoints: $streakPoints, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, isPinned: $isPinned, isFeatured: $isFeatured, clientId: $clientId, clientName: $clientName, clientAvatarColor: $clientAvatarColor, clientAvatarImage: $clientAvatarImage, threadImage: $threadImage, opportunityImage: $opportunityImage, campaignId: $campaignId, targeting: $targeting, bonusReward: $bonusReward, bonusRewardMultiplier: $bonusRewardMultiplier, bonusIntervalType: $bonusIntervalType, bonusIntervalX: $bonusIntervalX, userEngagementStatus: $userEngagementStatus, userEngagementId: $userEngagementId, adUnitId: $adUnitId, dailyLimitPerUser: $dailyLimitPerUser, budgetExhausted: $budgetExhausted, tokenBudget: $tokenBudget, tokenSpent: $tokenSpent, pollId: $pollId, uploadPrompt: $uploadPrompt, uploadContextMediaUrl: $uploadContextMediaUrl, uploadContextMediaType: $uploadContextMediaType, uploadVideoEnabled: $uploadVideoEnabled, uploadImageEnabled: $uploadImageEnabled, uploadTextEnabled: $uploadTextEnabled, uploadVideoRequired: $uploadVideoRequired, uploadImageRequired: $uploadImageRequired, uploadTextRequired: $uploadTextRequired, uploadVideoMaxSeconds: $uploadVideoMaxSeconds, uploadTextMinChars: $uploadTextMinChars, uploadTextMaxChars: $uploadTextMaxChars, requiresAdminReview: $requiresAdminReview, tokenSourceAccountId: $tokenSourceAccountId, rewardCampaignId: $rewardCampaignId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType, rewardQuantity: $rewardQuantity)';
}


}

/// @nodoc
abstract mixin class $EarnOpportunityCopyWith<$Res>  {
  factory $EarnOpportunityCopyWith(EarnOpportunity value, $Res Function(EarnOpportunity) _then) = _$EarnOpportunityCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, String title, String? description, EarningType earningType, int tokenReward, int streakPoints, MediaType mediaType, String? mediaUrl, List<SurveyQuestion> questions, int durationSeconds, DateTime? expiresAt, bool isActive, bool isPinned, bool isFeatured, String? clientId, String? clientName, String? clientAvatarColor, String? clientAvatarImage, String? threadImage, String? opportunityImage, String? campaignId, TargetingCriteria? targeting, bool bonusReward, double bonusRewardMultiplier, BonusIntervalType? bonusIntervalType, int? bonusIntervalX, String? userEngagementStatus, String? userEngagementId, String? adUnitId, int dailyLimitPerUser, bool budgetExhausted, int? tokenBudget, int tokenSpent, String? pollId, String? uploadPrompt, String? uploadContextMediaUrl, String? uploadContextMediaType, bool uploadVideoEnabled, bool uploadImageEnabled, bool uploadTextEnabled, bool uploadVideoRequired, bool uploadImageRequired, bool uploadTextRequired, int uploadVideoMaxSeconds, int uploadTextMinChars, int uploadTextMaxChars, bool requiresAdminReview, String? tokenSourceAccountId, String? rewardCampaignId, String? rewardCampaignName, String? rewardType, int rewardQuantity
});


$TargetingCriteriaCopyWith<$Res>? get targeting;

}
/// @nodoc
class _$EarnOpportunityCopyWithImpl<$Res>
    implements $EarnOpportunityCopyWith<$Res> {
  _$EarnOpportunityCopyWithImpl(this._self, this._then);

  final EarnOpportunity _self;
  final $Res Function(EarnOpportunity) _then;

/// Create a copy of EarnOpportunity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? title = null,Object? description = freezed,Object? earningType = null,Object? tokenReward = null,Object? streakPoints = null,Object? mediaType = null,Object? mediaUrl = freezed,Object? questions = null,Object? durationSeconds = null,Object? expiresAt = freezed,Object? isActive = null,Object? isPinned = null,Object? isFeatured = null,Object? clientId = freezed,Object? clientName = freezed,Object? clientAvatarColor = freezed,Object? clientAvatarImage = freezed,Object? threadImage = freezed,Object? opportunityImage = freezed,Object? campaignId = freezed,Object? targeting = freezed,Object? bonusReward = null,Object? bonusRewardMultiplier = null,Object? bonusIntervalType = freezed,Object? bonusIntervalX = freezed,Object? userEngagementStatus = freezed,Object? userEngagementId = freezed,Object? adUnitId = freezed,Object? dailyLimitPerUser = null,Object? budgetExhausted = null,Object? tokenBudget = freezed,Object? tokenSpent = null,Object? pollId = freezed,Object? uploadPrompt = freezed,Object? uploadContextMediaUrl = freezed,Object? uploadContextMediaType = freezed,Object? uploadVideoEnabled = null,Object? uploadImageEnabled = null,Object? uploadTextEnabled = null,Object? uploadVideoRequired = null,Object? uploadImageRequired = null,Object? uploadTextRequired = null,Object? uploadVideoMaxSeconds = null,Object? uploadTextMinChars = null,Object? uploadTextMaxChars = null,Object? requiresAdminReview = null,Object? tokenSourceAccountId = freezed,Object? rewardCampaignId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,Object? rewardQuantity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,earningType: null == earningType ? _self.earningType : earningType // ignore: cast_nullable_to_non_nullable
as EarningType,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,streakPoints: null == streakPoints ? _self.streakPoints : streakPoints // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestion>,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,opportunityImage: freezed == opportunityImage ? _self.opportunityImage : opportunityImage // ignore: cast_nullable_to_non_nullable
as String?,campaignId: freezed == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String?,targeting: freezed == targeting ? _self.targeting : targeting // ignore: cast_nullable_to_non_nullable
as TargetingCriteria?,bonusReward: null == bonusReward ? _self.bonusReward : bonusReward // ignore: cast_nullable_to_non_nullable
as bool,bonusRewardMultiplier: null == bonusRewardMultiplier ? _self.bonusRewardMultiplier : bonusRewardMultiplier // ignore: cast_nullable_to_non_nullable
as double,bonusIntervalType: freezed == bonusIntervalType ? _self.bonusIntervalType : bonusIntervalType // ignore: cast_nullable_to_non_nullable
as BonusIntervalType?,bonusIntervalX: freezed == bonusIntervalX ? _self.bonusIntervalX : bonusIntervalX // ignore: cast_nullable_to_non_nullable
as int?,userEngagementStatus: freezed == userEngagementStatus ? _self.userEngagementStatus : userEngagementStatus // ignore: cast_nullable_to_non_nullable
as String?,userEngagementId: freezed == userEngagementId ? _self.userEngagementId : userEngagementId // ignore: cast_nullable_to_non_nullable
as String?,adUnitId: freezed == adUnitId ? _self.adUnitId : adUnitId // ignore: cast_nullable_to_non_nullable
as String?,dailyLimitPerUser: null == dailyLimitPerUser ? _self.dailyLimitPerUser : dailyLimitPerUser // ignore: cast_nullable_to_non_nullable
as int,budgetExhausted: null == budgetExhausted ? _self.budgetExhausted : budgetExhausted // ignore: cast_nullable_to_non_nullable
as bool,tokenBudget: freezed == tokenBudget ? _self.tokenBudget : tokenBudget // ignore: cast_nullable_to_non_nullable
as int?,tokenSpent: null == tokenSpent ? _self.tokenSpent : tokenSpent // ignore: cast_nullable_to_non_nullable
as int,pollId: freezed == pollId ? _self.pollId : pollId // ignore: cast_nullable_to_non_nullable
as String?,uploadPrompt: freezed == uploadPrompt ? _self.uploadPrompt : uploadPrompt // ignore: cast_nullable_to_non_nullable
as String?,uploadContextMediaUrl: freezed == uploadContextMediaUrl ? _self.uploadContextMediaUrl : uploadContextMediaUrl // ignore: cast_nullable_to_non_nullable
as String?,uploadContextMediaType: freezed == uploadContextMediaType ? _self.uploadContextMediaType : uploadContextMediaType // ignore: cast_nullable_to_non_nullable
as String?,uploadVideoEnabled: null == uploadVideoEnabled ? _self.uploadVideoEnabled : uploadVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,uploadImageEnabled: null == uploadImageEnabled ? _self.uploadImageEnabled : uploadImageEnabled // ignore: cast_nullable_to_non_nullable
as bool,uploadTextEnabled: null == uploadTextEnabled ? _self.uploadTextEnabled : uploadTextEnabled // ignore: cast_nullable_to_non_nullable
as bool,uploadVideoRequired: null == uploadVideoRequired ? _self.uploadVideoRequired : uploadVideoRequired // ignore: cast_nullable_to_non_nullable
as bool,uploadImageRequired: null == uploadImageRequired ? _self.uploadImageRequired : uploadImageRequired // ignore: cast_nullable_to_non_nullable
as bool,uploadTextRequired: null == uploadTextRequired ? _self.uploadTextRequired : uploadTextRequired // ignore: cast_nullable_to_non_nullable
as bool,uploadVideoMaxSeconds: null == uploadVideoMaxSeconds ? _self.uploadVideoMaxSeconds : uploadVideoMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,uploadTextMinChars: null == uploadTextMinChars ? _self.uploadTextMinChars : uploadTextMinChars // ignore: cast_nullable_to_non_nullable
as int,uploadTextMaxChars: null == uploadTextMaxChars ? _self.uploadTextMaxChars : uploadTextMaxChars // ignore: cast_nullable_to_non_nullable
as int,requiresAdminReview: null == requiresAdminReview ? _self.requiresAdminReview : requiresAdminReview // ignore: cast_nullable_to_non_nullable
as bool,tokenSourceAccountId: freezed == tokenSourceAccountId ? _self.tokenSourceAccountId : tokenSourceAccountId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignId: freezed == rewardCampaignId ? _self.rewardCampaignId : rewardCampaignId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,rewardQuantity: null == rewardQuantity ? _self.rewardQuantity : rewardQuantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of EarnOpportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetingCriteriaCopyWith<$Res>? get targeting {
    if (_self.targeting == null) {
    return null;
  }

  return $TargetingCriteriaCopyWith<$Res>(_self.targeting!, (value) {
    return _then(_self.copyWith(targeting: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarnOpportunity].
extension EarnOpportunityPatterns on EarnOpportunity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnOpportunity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnOpportunity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnOpportunity value)  $default,){
final _that = this;
switch (_that) {
case _EarnOpportunity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnOpportunity value)?  $default,){
final _that = this;
switch (_that) {
case _EarnOpportunity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String threadId,  String title,  String? description,  EarningType earningType,  int tokenReward,  int streakPoints,  MediaType mediaType,  String? mediaUrl,  List<SurveyQuestion> questions,  int durationSeconds,  DateTime? expiresAt,  bool isActive,  bool isPinned,  bool isFeatured,  String? clientId,  String? clientName,  String? clientAvatarColor,  String? clientAvatarImage,  String? threadImage,  String? opportunityImage,  String? campaignId,  TargetingCriteria? targeting,  bool bonusReward,  double bonusRewardMultiplier,  BonusIntervalType? bonusIntervalType,  int? bonusIntervalX,  String? userEngagementStatus,  String? userEngagementId,  String? adUnitId,  int dailyLimitPerUser,  bool budgetExhausted,  int? tokenBudget,  int tokenSpent,  String? pollId,  String? uploadPrompt,  String? uploadContextMediaUrl,  String? uploadContextMediaType,  bool uploadVideoEnabled,  bool uploadImageEnabled,  bool uploadTextEnabled,  bool uploadVideoRequired,  bool uploadImageRequired,  bool uploadTextRequired,  int uploadVideoMaxSeconds,  int uploadTextMinChars,  int uploadTextMaxChars,  bool requiresAdminReview,  String? tokenSourceAccountId,  String? rewardCampaignId,  String? rewardCampaignName,  String? rewardType,  int rewardQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnOpportunity() when $default != null:
return $default(_that.id,_that.threadId,_that.title,_that.description,_that.earningType,_that.tokenReward,_that.streakPoints,_that.mediaType,_that.mediaUrl,_that.questions,_that.durationSeconds,_that.expiresAt,_that.isActive,_that.isPinned,_that.isFeatured,_that.clientId,_that.clientName,_that.clientAvatarColor,_that.clientAvatarImage,_that.threadImage,_that.opportunityImage,_that.campaignId,_that.targeting,_that.bonusReward,_that.bonusRewardMultiplier,_that.bonusIntervalType,_that.bonusIntervalX,_that.userEngagementStatus,_that.userEngagementId,_that.adUnitId,_that.dailyLimitPerUser,_that.budgetExhausted,_that.tokenBudget,_that.tokenSpent,_that.pollId,_that.uploadPrompt,_that.uploadContextMediaUrl,_that.uploadContextMediaType,_that.uploadVideoEnabled,_that.uploadImageEnabled,_that.uploadTextEnabled,_that.uploadVideoRequired,_that.uploadImageRequired,_that.uploadTextRequired,_that.uploadVideoMaxSeconds,_that.uploadTextMinChars,_that.uploadTextMaxChars,_that.requiresAdminReview,_that.tokenSourceAccountId,_that.rewardCampaignId,_that.rewardCampaignName,_that.rewardType,_that.rewardQuantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String threadId,  String title,  String? description,  EarningType earningType,  int tokenReward,  int streakPoints,  MediaType mediaType,  String? mediaUrl,  List<SurveyQuestion> questions,  int durationSeconds,  DateTime? expiresAt,  bool isActive,  bool isPinned,  bool isFeatured,  String? clientId,  String? clientName,  String? clientAvatarColor,  String? clientAvatarImage,  String? threadImage,  String? opportunityImage,  String? campaignId,  TargetingCriteria? targeting,  bool bonusReward,  double bonusRewardMultiplier,  BonusIntervalType? bonusIntervalType,  int? bonusIntervalX,  String? userEngagementStatus,  String? userEngagementId,  String? adUnitId,  int dailyLimitPerUser,  bool budgetExhausted,  int? tokenBudget,  int tokenSpent,  String? pollId,  String? uploadPrompt,  String? uploadContextMediaUrl,  String? uploadContextMediaType,  bool uploadVideoEnabled,  bool uploadImageEnabled,  bool uploadTextEnabled,  bool uploadVideoRequired,  bool uploadImageRequired,  bool uploadTextRequired,  int uploadVideoMaxSeconds,  int uploadTextMinChars,  int uploadTextMaxChars,  bool requiresAdminReview,  String? tokenSourceAccountId,  String? rewardCampaignId,  String? rewardCampaignName,  String? rewardType,  int rewardQuantity)  $default,) {final _that = this;
switch (_that) {
case _EarnOpportunity():
return $default(_that.id,_that.threadId,_that.title,_that.description,_that.earningType,_that.tokenReward,_that.streakPoints,_that.mediaType,_that.mediaUrl,_that.questions,_that.durationSeconds,_that.expiresAt,_that.isActive,_that.isPinned,_that.isFeatured,_that.clientId,_that.clientName,_that.clientAvatarColor,_that.clientAvatarImage,_that.threadImage,_that.opportunityImage,_that.campaignId,_that.targeting,_that.bonusReward,_that.bonusRewardMultiplier,_that.bonusIntervalType,_that.bonusIntervalX,_that.userEngagementStatus,_that.userEngagementId,_that.adUnitId,_that.dailyLimitPerUser,_that.budgetExhausted,_that.tokenBudget,_that.tokenSpent,_that.pollId,_that.uploadPrompt,_that.uploadContextMediaUrl,_that.uploadContextMediaType,_that.uploadVideoEnabled,_that.uploadImageEnabled,_that.uploadTextEnabled,_that.uploadVideoRequired,_that.uploadImageRequired,_that.uploadTextRequired,_that.uploadVideoMaxSeconds,_that.uploadTextMinChars,_that.uploadTextMaxChars,_that.requiresAdminReview,_that.tokenSourceAccountId,_that.rewardCampaignId,_that.rewardCampaignName,_that.rewardType,_that.rewardQuantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String threadId,  String title,  String? description,  EarningType earningType,  int tokenReward,  int streakPoints,  MediaType mediaType,  String? mediaUrl,  List<SurveyQuestion> questions,  int durationSeconds,  DateTime? expiresAt,  bool isActive,  bool isPinned,  bool isFeatured,  String? clientId,  String? clientName,  String? clientAvatarColor,  String? clientAvatarImage,  String? threadImage,  String? opportunityImage,  String? campaignId,  TargetingCriteria? targeting,  bool bonusReward,  double bonusRewardMultiplier,  BonusIntervalType? bonusIntervalType,  int? bonusIntervalX,  String? userEngagementStatus,  String? userEngagementId,  String? adUnitId,  int dailyLimitPerUser,  bool budgetExhausted,  int? tokenBudget,  int tokenSpent,  String? pollId,  String? uploadPrompt,  String? uploadContextMediaUrl,  String? uploadContextMediaType,  bool uploadVideoEnabled,  bool uploadImageEnabled,  bool uploadTextEnabled,  bool uploadVideoRequired,  bool uploadImageRequired,  bool uploadTextRequired,  int uploadVideoMaxSeconds,  int uploadTextMinChars,  int uploadTextMaxChars,  bool requiresAdminReview,  String? tokenSourceAccountId,  String? rewardCampaignId,  String? rewardCampaignName,  String? rewardType,  int rewardQuantity)?  $default,) {final _that = this;
switch (_that) {
case _EarnOpportunity() when $default != null:
return $default(_that.id,_that.threadId,_that.title,_that.description,_that.earningType,_that.tokenReward,_that.streakPoints,_that.mediaType,_that.mediaUrl,_that.questions,_that.durationSeconds,_that.expiresAt,_that.isActive,_that.isPinned,_that.isFeatured,_that.clientId,_that.clientName,_that.clientAvatarColor,_that.clientAvatarImage,_that.threadImage,_that.opportunityImage,_that.campaignId,_that.targeting,_that.bonusReward,_that.bonusRewardMultiplier,_that.bonusIntervalType,_that.bonusIntervalX,_that.userEngagementStatus,_that.userEngagementId,_that.adUnitId,_that.dailyLimitPerUser,_that.budgetExhausted,_that.tokenBudget,_that.tokenSpent,_that.pollId,_that.uploadPrompt,_that.uploadContextMediaUrl,_that.uploadContextMediaType,_that.uploadVideoEnabled,_that.uploadImageEnabled,_that.uploadTextEnabled,_that.uploadVideoRequired,_that.uploadImageRequired,_that.uploadTextRequired,_that.uploadVideoMaxSeconds,_that.uploadTextMinChars,_that.uploadTextMaxChars,_that.requiresAdminReview,_that.tokenSourceAccountId,_that.rewardCampaignId,_that.rewardCampaignName,_that.rewardType,_that.rewardQuantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarnOpportunity extends EarnOpportunity {
  const _EarnOpportunity({required this.id, required this.threadId, required this.title, this.description, required this.earningType, required this.tokenReward, this.streakPoints = 1, required this.mediaType, this.mediaUrl, required final  List<SurveyQuestion> questions, required this.durationSeconds, this.expiresAt, required this.isActive, this.isPinned = false, this.isFeatured = false, this.clientId, this.clientName, this.clientAvatarColor, this.clientAvatarImage, this.threadImage, this.opportunityImage, this.campaignId, this.targeting, this.bonusReward = false, this.bonusRewardMultiplier = 1.0, this.bonusIntervalType, this.bonusIntervalX, this.userEngagementStatus, this.userEngagementId, this.adUnitId, this.dailyLimitPerUser = 3, this.budgetExhausted = false, this.tokenBudget, this.tokenSpent = 0, this.pollId, this.uploadPrompt, this.uploadContextMediaUrl, this.uploadContextMediaType, this.uploadVideoEnabled = false, this.uploadImageEnabled = false, this.uploadTextEnabled = false, this.uploadVideoRequired = false, this.uploadImageRequired = false, this.uploadTextRequired = false, this.uploadVideoMaxSeconds = 60, this.uploadTextMinChars = 10, this.uploadTextMaxChars = 1500, this.requiresAdminReview = false, this.tokenSourceAccountId, this.rewardCampaignId, this.rewardCampaignName, this.rewardType, this.rewardQuantity = 1}): _questions = questions,super._();
  factory _EarnOpportunity.fromJson(Map<String, dynamic> json) => _$EarnOpportunityFromJson(json);

@override final  String id;
@override final  String threadId;
@override final  String title;
@override final  String? description;
// Earning configuration
@override final  EarningType earningType;
@override final  int tokenReward;
@override@JsonKey() final  int streakPoints;
@override final  MediaType mediaType;
@override final  String? mediaUrl;
 final  List<SurveyQuestion> _questions;
@override List<SurveyQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  int durationSeconds;
@override final  DateTime? expiresAt;
@override final  bool isActive;
// Pin/feature flags for ordering
@override@JsonKey() final  bool isPinned;
@override@JsonKey() final  bool isFeatured;
// Denormalized client info
@override final  String? clientId;
@override final  String? clientName;
@override final  String? clientAvatarColor;
@override final  String? clientAvatarImage;
@override final  String? threadImage;
@override final  String? opportunityImage;
// Legacy campaign reference
@override final  String? campaignId;
// Targeting
@override final  TargetingCriteria? targeting;
// Bonus reward configuration
@override@JsonKey() final  bool bonusReward;
@override@JsonKey() final  double bonusRewardMultiplier;
@override final  BonusIntervalType? bonusIntervalType;
@override final  int? bonusIntervalX;
// User engagement status (populated by getEligibleOpportunities)
@override final  String? userEngagementStatus;
@override final  String? userEngagementId;
// AdMob configuration
@override final  String? adUnitId;
@override@JsonKey() final  int dailyLimitPerUser;
// Budget cap fields
@override@JsonKey() final  bool budgetExhausted;
@override final  int? tokenBudget;
@override@JsonKey() final  int tokenSpent;
// Poll link
@override final  String? pollId;
// Upload configuration (earningType == upload)
@override final  String? uploadPrompt;
@override final  String? uploadContextMediaUrl;
@override final  String? uploadContextMediaType;
@override@JsonKey() final  bool uploadVideoEnabled;
@override@JsonKey() final  bool uploadImageEnabled;
@override@JsonKey() final  bool uploadTextEnabled;
@override@JsonKey() final  bool uploadVideoRequired;
@override@JsonKey() final  bool uploadImageRequired;
@override@JsonKey() final  bool uploadTextRequired;
@override@JsonKey() final  int uploadVideoMaxSeconds;
@override@JsonKey() final  int uploadTextMinChars;
@override@JsonKey() final  int uploadTextMaxChars;
@override@JsonKey() final  bool requiresAdminReview;
// Token source (opportunity-level override; falls back to thread-level)
@override final  String? tokenSourceAccountId;
// Reward campaign linkage
@override final  String? rewardCampaignId;
@override final  String? rewardCampaignName;
@override final  String? rewardType;
@override@JsonKey() final  int rewardQuantity;

/// Create a copy of EarnOpportunity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnOpportunityCopyWith<_EarnOpportunity> get copyWith => __$EarnOpportunityCopyWithImpl<_EarnOpportunity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarnOpportunityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnOpportunity&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.earningType, earningType) || other.earningType == earningType)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.streakPoints, streakPoints) || other.streakPoints == streakPoints)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.opportunityImage, opportunityImage) || other.opportunityImage == opportunityImage)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.targeting, targeting) || other.targeting == targeting)&&(identical(other.bonusReward, bonusReward) || other.bonusReward == bonusReward)&&(identical(other.bonusRewardMultiplier, bonusRewardMultiplier) || other.bonusRewardMultiplier == bonusRewardMultiplier)&&(identical(other.bonusIntervalType, bonusIntervalType) || other.bonusIntervalType == bonusIntervalType)&&(identical(other.bonusIntervalX, bonusIntervalX) || other.bonusIntervalX == bonusIntervalX)&&(identical(other.userEngagementStatus, userEngagementStatus) || other.userEngagementStatus == userEngagementStatus)&&(identical(other.userEngagementId, userEngagementId) || other.userEngagementId == userEngagementId)&&(identical(other.adUnitId, adUnitId) || other.adUnitId == adUnitId)&&(identical(other.dailyLimitPerUser, dailyLimitPerUser) || other.dailyLimitPerUser == dailyLimitPerUser)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.tokenBudget, tokenBudget) || other.tokenBudget == tokenBudget)&&(identical(other.tokenSpent, tokenSpent) || other.tokenSpent == tokenSpent)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.uploadPrompt, uploadPrompt) || other.uploadPrompt == uploadPrompt)&&(identical(other.uploadContextMediaUrl, uploadContextMediaUrl) || other.uploadContextMediaUrl == uploadContextMediaUrl)&&(identical(other.uploadContextMediaType, uploadContextMediaType) || other.uploadContextMediaType == uploadContextMediaType)&&(identical(other.uploadVideoEnabled, uploadVideoEnabled) || other.uploadVideoEnabled == uploadVideoEnabled)&&(identical(other.uploadImageEnabled, uploadImageEnabled) || other.uploadImageEnabled == uploadImageEnabled)&&(identical(other.uploadTextEnabled, uploadTextEnabled) || other.uploadTextEnabled == uploadTextEnabled)&&(identical(other.uploadVideoRequired, uploadVideoRequired) || other.uploadVideoRequired == uploadVideoRequired)&&(identical(other.uploadImageRequired, uploadImageRequired) || other.uploadImageRequired == uploadImageRequired)&&(identical(other.uploadTextRequired, uploadTextRequired) || other.uploadTextRequired == uploadTextRequired)&&(identical(other.uploadVideoMaxSeconds, uploadVideoMaxSeconds) || other.uploadVideoMaxSeconds == uploadVideoMaxSeconds)&&(identical(other.uploadTextMinChars, uploadTextMinChars) || other.uploadTextMinChars == uploadTextMinChars)&&(identical(other.uploadTextMaxChars, uploadTextMaxChars) || other.uploadTextMaxChars == uploadTextMaxChars)&&(identical(other.requiresAdminReview, requiresAdminReview) || other.requiresAdminReview == requiresAdminReview)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.rewardCampaignId, rewardCampaignId) || other.rewardCampaignId == rewardCampaignId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardQuantity, rewardQuantity) || other.rewardQuantity == rewardQuantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,threadId,title,description,earningType,tokenReward,streakPoints,mediaType,mediaUrl,const DeepCollectionEquality().hash(_questions),durationSeconds,expiresAt,isActive,isPinned,isFeatured,clientId,clientName,clientAvatarColor,clientAvatarImage,threadImage,opportunityImage,campaignId,targeting,bonusReward,bonusRewardMultiplier,bonusIntervalType,bonusIntervalX,userEngagementStatus,userEngagementId,adUnitId,dailyLimitPerUser,budgetExhausted,tokenBudget,tokenSpent,pollId,uploadPrompt,uploadContextMediaUrl,uploadContextMediaType,uploadVideoEnabled,uploadImageEnabled,uploadTextEnabled,uploadVideoRequired,uploadImageRequired,uploadTextRequired,uploadVideoMaxSeconds,uploadTextMinChars,uploadTextMaxChars,requiresAdminReview,tokenSourceAccountId,rewardCampaignId,rewardCampaignName,rewardType,rewardQuantity]);

@override
String toString() {
  return 'EarnOpportunity(id: $id, threadId: $threadId, title: $title, description: $description, earningType: $earningType, tokenReward: $tokenReward, streakPoints: $streakPoints, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, isPinned: $isPinned, isFeatured: $isFeatured, clientId: $clientId, clientName: $clientName, clientAvatarColor: $clientAvatarColor, clientAvatarImage: $clientAvatarImage, threadImage: $threadImage, opportunityImage: $opportunityImage, campaignId: $campaignId, targeting: $targeting, bonusReward: $bonusReward, bonusRewardMultiplier: $bonusRewardMultiplier, bonusIntervalType: $bonusIntervalType, bonusIntervalX: $bonusIntervalX, userEngagementStatus: $userEngagementStatus, userEngagementId: $userEngagementId, adUnitId: $adUnitId, dailyLimitPerUser: $dailyLimitPerUser, budgetExhausted: $budgetExhausted, tokenBudget: $tokenBudget, tokenSpent: $tokenSpent, pollId: $pollId, uploadPrompt: $uploadPrompt, uploadContextMediaUrl: $uploadContextMediaUrl, uploadContextMediaType: $uploadContextMediaType, uploadVideoEnabled: $uploadVideoEnabled, uploadImageEnabled: $uploadImageEnabled, uploadTextEnabled: $uploadTextEnabled, uploadVideoRequired: $uploadVideoRequired, uploadImageRequired: $uploadImageRequired, uploadTextRequired: $uploadTextRequired, uploadVideoMaxSeconds: $uploadVideoMaxSeconds, uploadTextMinChars: $uploadTextMinChars, uploadTextMaxChars: $uploadTextMaxChars, requiresAdminReview: $requiresAdminReview, tokenSourceAccountId: $tokenSourceAccountId, rewardCampaignId: $rewardCampaignId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType, rewardQuantity: $rewardQuantity)';
}


}

/// @nodoc
abstract mixin class _$EarnOpportunityCopyWith<$Res> implements $EarnOpportunityCopyWith<$Res> {
  factory _$EarnOpportunityCopyWith(_EarnOpportunity value, $Res Function(_EarnOpportunity) _then) = __$EarnOpportunityCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, String title, String? description, EarningType earningType, int tokenReward, int streakPoints, MediaType mediaType, String? mediaUrl, List<SurveyQuestion> questions, int durationSeconds, DateTime? expiresAt, bool isActive, bool isPinned, bool isFeatured, String? clientId, String? clientName, String? clientAvatarColor, String? clientAvatarImage, String? threadImage, String? opportunityImage, String? campaignId, TargetingCriteria? targeting, bool bonusReward, double bonusRewardMultiplier, BonusIntervalType? bonusIntervalType, int? bonusIntervalX, String? userEngagementStatus, String? userEngagementId, String? adUnitId, int dailyLimitPerUser, bool budgetExhausted, int? tokenBudget, int tokenSpent, String? pollId, String? uploadPrompt, String? uploadContextMediaUrl, String? uploadContextMediaType, bool uploadVideoEnabled, bool uploadImageEnabled, bool uploadTextEnabled, bool uploadVideoRequired, bool uploadImageRequired, bool uploadTextRequired, int uploadVideoMaxSeconds, int uploadTextMinChars, int uploadTextMaxChars, bool requiresAdminReview, String? tokenSourceAccountId, String? rewardCampaignId, String? rewardCampaignName, String? rewardType, int rewardQuantity
});


@override $TargetingCriteriaCopyWith<$Res>? get targeting;

}
/// @nodoc
class __$EarnOpportunityCopyWithImpl<$Res>
    implements _$EarnOpportunityCopyWith<$Res> {
  __$EarnOpportunityCopyWithImpl(this._self, this._then);

  final _EarnOpportunity _self;
  final $Res Function(_EarnOpportunity) _then;

/// Create a copy of EarnOpportunity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? title = null,Object? description = freezed,Object? earningType = null,Object? tokenReward = null,Object? streakPoints = null,Object? mediaType = null,Object? mediaUrl = freezed,Object? questions = null,Object? durationSeconds = null,Object? expiresAt = freezed,Object? isActive = null,Object? isPinned = null,Object? isFeatured = null,Object? clientId = freezed,Object? clientName = freezed,Object? clientAvatarColor = freezed,Object? clientAvatarImage = freezed,Object? threadImage = freezed,Object? opportunityImage = freezed,Object? campaignId = freezed,Object? targeting = freezed,Object? bonusReward = null,Object? bonusRewardMultiplier = null,Object? bonusIntervalType = freezed,Object? bonusIntervalX = freezed,Object? userEngagementStatus = freezed,Object? userEngagementId = freezed,Object? adUnitId = freezed,Object? dailyLimitPerUser = null,Object? budgetExhausted = null,Object? tokenBudget = freezed,Object? tokenSpent = null,Object? pollId = freezed,Object? uploadPrompt = freezed,Object? uploadContextMediaUrl = freezed,Object? uploadContextMediaType = freezed,Object? uploadVideoEnabled = null,Object? uploadImageEnabled = null,Object? uploadTextEnabled = null,Object? uploadVideoRequired = null,Object? uploadImageRequired = null,Object? uploadTextRequired = null,Object? uploadVideoMaxSeconds = null,Object? uploadTextMinChars = null,Object? uploadTextMaxChars = null,Object? requiresAdminReview = null,Object? tokenSourceAccountId = freezed,Object? rewardCampaignId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,Object? rewardQuantity = null,}) {
  return _then(_EarnOpportunity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,earningType: null == earningType ? _self.earningType : earningType // ignore: cast_nullable_to_non_nullable
as EarningType,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,streakPoints: null == streakPoints ? _self.streakPoints : streakPoints // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestion>,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,opportunityImage: freezed == opportunityImage ? _self.opportunityImage : opportunityImage // ignore: cast_nullable_to_non_nullable
as String?,campaignId: freezed == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String?,targeting: freezed == targeting ? _self.targeting : targeting // ignore: cast_nullable_to_non_nullable
as TargetingCriteria?,bonusReward: null == bonusReward ? _self.bonusReward : bonusReward // ignore: cast_nullable_to_non_nullable
as bool,bonusRewardMultiplier: null == bonusRewardMultiplier ? _self.bonusRewardMultiplier : bonusRewardMultiplier // ignore: cast_nullable_to_non_nullable
as double,bonusIntervalType: freezed == bonusIntervalType ? _self.bonusIntervalType : bonusIntervalType // ignore: cast_nullable_to_non_nullable
as BonusIntervalType?,bonusIntervalX: freezed == bonusIntervalX ? _self.bonusIntervalX : bonusIntervalX // ignore: cast_nullable_to_non_nullable
as int?,userEngagementStatus: freezed == userEngagementStatus ? _self.userEngagementStatus : userEngagementStatus // ignore: cast_nullable_to_non_nullable
as String?,userEngagementId: freezed == userEngagementId ? _self.userEngagementId : userEngagementId // ignore: cast_nullable_to_non_nullable
as String?,adUnitId: freezed == adUnitId ? _self.adUnitId : adUnitId // ignore: cast_nullable_to_non_nullable
as String?,dailyLimitPerUser: null == dailyLimitPerUser ? _self.dailyLimitPerUser : dailyLimitPerUser // ignore: cast_nullable_to_non_nullable
as int,budgetExhausted: null == budgetExhausted ? _self.budgetExhausted : budgetExhausted // ignore: cast_nullable_to_non_nullable
as bool,tokenBudget: freezed == tokenBudget ? _self.tokenBudget : tokenBudget // ignore: cast_nullable_to_non_nullable
as int?,tokenSpent: null == tokenSpent ? _self.tokenSpent : tokenSpent // ignore: cast_nullable_to_non_nullable
as int,pollId: freezed == pollId ? _self.pollId : pollId // ignore: cast_nullable_to_non_nullable
as String?,uploadPrompt: freezed == uploadPrompt ? _self.uploadPrompt : uploadPrompt // ignore: cast_nullable_to_non_nullable
as String?,uploadContextMediaUrl: freezed == uploadContextMediaUrl ? _self.uploadContextMediaUrl : uploadContextMediaUrl // ignore: cast_nullable_to_non_nullable
as String?,uploadContextMediaType: freezed == uploadContextMediaType ? _self.uploadContextMediaType : uploadContextMediaType // ignore: cast_nullable_to_non_nullable
as String?,uploadVideoEnabled: null == uploadVideoEnabled ? _self.uploadVideoEnabled : uploadVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,uploadImageEnabled: null == uploadImageEnabled ? _self.uploadImageEnabled : uploadImageEnabled // ignore: cast_nullable_to_non_nullable
as bool,uploadTextEnabled: null == uploadTextEnabled ? _self.uploadTextEnabled : uploadTextEnabled // ignore: cast_nullable_to_non_nullable
as bool,uploadVideoRequired: null == uploadVideoRequired ? _self.uploadVideoRequired : uploadVideoRequired // ignore: cast_nullable_to_non_nullable
as bool,uploadImageRequired: null == uploadImageRequired ? _self.uploadImageRequired : uploadImageRequired // ignore: cast_nullable_to_non_nullable
as bool,uploadTextRequired: null == uploadTextRequired ? _self.uploadTextRequired : uploadTextRequired // ignore: cast_nullable_to_non_nullable
as bool,uploadVideoMaxSeconds: null == uploadVideoMaxSeconds ? _self.uploadVideoMaxSeconds : uploadVideoMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,uploadTextMinChars: null == uploadTextMinChars ? _self.uploadTextMinChars : uploadTextMinChars // ignore: cast_nullable_to_non_nullable
as int,uploadTextMaxChars: null == uploadTextMaxChars ? _self.uploadTextMaxChars : uploadTextMaxChars // ignore: cast_nullable_to_non_nullable
as int,requiresAdminReview: null == requiresAdminReview ? _self.requiresAdminReview : requiresAdminReview // ignore: cast_nullable_to_non_nullable
as bool,tokenSourceAccountId: freezed == tokenSourceAccountId ? _self.tokenSourceAccountId : tokenSourceAccountId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignId: freezed == rewardCampaignId ? _self.rewardCampaignId : rewardCampaignId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,rewardQuantity: null == rewardQuantity ? _self.rewardQuantity : rewardQuantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of EarnOpportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetingCriteriaCopyWith<$Res>? get targeting {
    if (_self.targeting == null) {
    return null;
  }

  return $TargetingCriteriaCopyWith<$Res>(_self.targeting!, (value) {
    return _then(_self.copyWith(targeting: value));
  });
}
}

// dart format on
