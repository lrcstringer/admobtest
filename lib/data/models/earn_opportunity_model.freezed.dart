// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_opportunity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BranchRuleModel {

 String get optionValue; String get goToQuestionId;
/// Create a copy of BranchRuleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchRuleModelCopyWith<BranchRuleModel> get copyWith => _$BranchRuleModelCopyWithImpl<BranchRuleModel>(this as BranchRuleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchRuleModel&&(identical(other.optionValue, optionValue) || other.optionValue == optionValue)&&(identical(other.goToQuestionId, goToQuestionId) || other.goToQuestionId == goToQuestionId));
}


@override
int get hashCode => Object.hash(runtimeType,optionValue,goToQuestionId);

@override
String toString() {
  return 'BranchRuleModel(optionValue: $optionValue, goToQuestionId: $goToQuestionId)';
}


}

/// @nodoc
abstract mixin class $BranchRuleModelCopyWith<$Res>  {
  factory $BranchRuleModelCopyWith(BranchRuleModel value, $Res Function(BranchRuleModel) _then) = _$BranchRuleModelCopyWithImpl;
@useResult
$Res call({
 String optionValue, String goToQuestionId
});




}
/// @nodoc
class _$BranchRuleModelCopyWithImpl<$Res>
    implements $BranchRuleModelCopyWith<$Res> {
  _$BranchRuleModelCopyWithImpl(this._self, this._then);

  final BranchRuleModel _self;
  final $Res Function(BranchRuleModel) _then;

/// Create a copy of BranchRuleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionValue = null,Object? goToQuestionId = null,}) {
  return _then(_self.copyWith(
optionValue: null == optionValue ? _self.optionValue : optionValue // ignore: cast_nullable_to_non_nullable
as String,goToQuestionId: null == goToQuestionId ? _self.goToQuestionId : goToQuestionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchRuleModel].
extension BranchRuleModelPatterns on BranchRuleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchRuleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchRuleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchRuleModel value)  $default,){
final _that = this;
switch (_that) {
case _BranchRuleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchRuleModel value)?  $default,){
final _that = this;
switch (_that) {
case _BranchRuleModel() when $default != null:
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
case _BranchRuleModel() when $default != null:
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
case _BranchRuleModel():
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
case _BranchRuleModel() when $default != null:
return $default(_that.optionValue,_that.goToQuestionId);case _:
  return null;

}
}

}

/// @nodoc


class _BranchRuleModel extends BranchRuleModel {
  const _BranchRuleModel({required this.optionValue, required this.goToQuestionId}): super._();
  

@override final  String optionValue;
@override final  String goToQuestionId;

/// Create a copy of BranchRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchRuleModelCopyWith<_BranchRuleModel> get copyWith => __$BranchRuleModelCopyWithImpl<_BranchRuleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchRuleModel&&(identical(other.optionValue, optionValue) || other.optionValue == optionValue)&&(identical(other.goToQuestionId, goToQuestionId) || other.goToQuestionId == goToQuestionId));
}


@override
int get hashCode => Object.hash(runtimeType,optionValue,goToQuestionId);

@override
String toString() {
  return 'BranchRuleModel(optionValue: $optionValue, goToQuestionId: $goToQuestionId)';
}


}

/// @nodoc
abstract mixin class _$BranchRuleModelCopyWith<$Res> implements $BranchRuleModelCopyWith<$Res> {
  factory _$BranchRuleModelCopyWith(_BranchRuleModel value, $Res Function(_BranchRuleModel) _then) = __$BranchRuleModelCopyWithImpl;
@override @useResult
$Res call({
 String optionValue, String goToQuestionId
});




}
/// @nodoc
class __$BranchRuleModelCopyWithImpl<$Res>
    implements _$BranchRuleModelCopyWith<$Res> {
  __$BranchRuleModelCopyWithImpl(this._self, this._then);

  final _BranchRuleModel _self;
  final $Res Function(_BranchRuleModel) _then;

/// Create a copy of BranchRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionValue = null,Object? goToQuestionId = null,}) {
  return _then(_BranchRuleModel(
optionValue: null == optionValue ? _self.optionValue : optionValue // ignore: cast_nullable_to_non_nullable
as String,goToQuestionId: null == goToQuestionId ? _self.goToQuestionId : goToQuestionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SurveyQuestionModel {

 String get id; String get text; int get orderIndex; String get questionType; bool get isRequired;// single_select + multi_select
 List<String> get options; int? get maxSelections;// text_input
 int get textInputCount; int get textMaxLength;// likert
 int get likertScale; String? get likertLowLabel; String? get likertHighLabel;// star_tags
 int get maxStars; List<String> get tags; int? get maxTags;// slider
 int get sliderMin; int get sliderMax; int get sliderStep; String? get sliderMinLabel; String? get sliderMaxLabel;// attention check
 bool get isAttentionCheck; String? get correctAnswer;// correctness-based branching
 String? get correctGoToQuestionId; String? get incorrectGoToQuestionId;// response box (optional interstitial before branching)
 String? get correctResponseText; String? get correctResponseMediaUrl; String? get correctResponseMediaType; String? get incorrectResponseText; String? get incorrectResponseMediaUrl; String? get incorrectResponseMediaType;// branching
 List<BranchRuleModel> get branchRules;
/// Create a copy of SurveyQuestionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyQuestionModelCopyWith<SurveyQuestionModel> get copyWith => _$SurveyQuestionModelCopyWithImpl<SurveyQuestionModel>(this as SurveyQuestionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyQuestionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.maxSelections, maxSelections) || other.maxSelections == maxSelections)&&(identical(other.textInputCount, textInputCount) || other.textInputCount == textInputCount)&&(identical(other.textMaxLength, textMaxLength) || other.textMaxLength == textMaxLength)&&(identical(other.likertScale, likertScale) || other.likertScale == likertScale)&&(identical(other.likertLowLabel, likertLowLabel) || other.likertLowLabel == likertLowLabel)&&(identical(other.likertHighLabel, likertHighLabel) || other.likertHighLabel == likertHighLabel)&&(identical(other.maxStars, maxStars) || other.maxStars == maxStars)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.maxTags, maxTags) || other.maxTags == maxTags)&&(identical(other.sliderMin, sliderMin) || other.sliderMin == sliderMin)&&(identical(other.sliderMax, sliderMax) || other.sliderMax == sliderMax)&&(identical(other.sliderStep, sliderStep) || other.sliderStep == sliderStep)&&(identical(other.sliderMinLabel, sliderMinLabel) || other.sliderMinLabel == sliderMinLabel)&&(identical(other.sliderMaxLabel, sliderMaxLabel) || other.sliderMaxLabel == sliderMaxLabel)&&(identical(other.isAttentionCheck, isAttentionCheck) || other.isAttentionCheck == isAttentionCheck)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.correctGoToQuestionId, correctGoToQuestionId) || other.correctGoToQuestionId == correctGoToQuestionId)&&(identical(other.incorrectGoToQuestionId, incorrectGoToQuestionId) || other.incorrectGoToQuestionId == incorrectGoToQuestionId)&&(identical(other.correctResponseText, correctResponseText) || other.correctResponseText == correctResponseText)&&(identical(other.correctResponseMediaUrl, correctResponseMediaUrl) || other.correctResponseMediaUrl == correctResponseMediaUrl)&&(identical(other.correctResponseMediaType, correctResponseMediaType) || other.correctResponseMediaType == correctResponseMediaType)&&(identical(other.incorrectResponseText, incorrectResponseText) || other.incorrectResponseText == incorrectResponseText)&&(identical(other.incorrectResponseMediaUrl, incorrectResponseMediaUrl) || other.incorrectResponseMediaUrl == incorrectResponseMediaUrl)&&(identical(other.incorrectResponseMediaType, incorrectResponseMediaType) || other.incorrectResponseMediaType == incorrectResponseMediaType)&&const DeepCollectionEquality().equals(other.branchRules, branchRules));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,text,orderIndex,questionType,isRequired,const DeepCollectionEquality().hash(options),maxSelections,textInputCount,textMaxLength,likertScale,likertLowLabel,likertHighLabel,maxStars,const DeepCollectionEquality().hash(tags),maxTags,sliderMin,sliderMax,sliderStep,sliderMinLabel,sliderMaxLabel,isAttentionCheck,correctAnswer,correctGoToQuestionId,incorrectGoToQuestionId,correctResponseText,correctResponseMediaUrl,correctResponseMediaType,incorrectResponseText,incorrectResponseMediaUrl,incorrectResponseMediaType,const DeepCollectionEquality().hash(branchRules)]);

@override
String toString() {
  return 'SurveyQuestionModel(id: $id, text: $text, orderIndex: $orderIndex, questionType: $questionType, isRequired: $isRequired, options: $options, maxSelections: $maxSelections, textInputCount: $textInputCount, textMaxLength: $textMaxLength, likertScale: $likertScale, likertLowLabel: $likertLowLabel, likertHighLabel: $likertHighLabel, maxStars: $maxStars, tags: $tags, maxTags: $maxTags, sliderMin: $sliderMin, sliderMax: $sliderMax, sliderStep: $sliderStep, sliderMinLabel: $sliderMinLabel, sliderMaxLabel: $sliderMaxLabel, isAttentionCheck: $isAttentionCheck, correctAnswer: $correctAnswer, correctGoToQuestionId: $correctGoToQuestionId, incorrectGoToQuestionId: $incorrectGoToQuestionId, correctResponseText: $correctResponseText, correctResponseMediaUrl: $correctResponseMediaUrl, correctResponseMediaType: $correctResponseMediaType, incorrectResponseText: $incorrectResponseText, incorrectResponseMediaUrl: $incorrectResponseMediaUrl, incorrectResponseMediaType: $incorrectResponseMediaType, branchRules: $branchRules)';
}


}

/// @nodoc
abstract mixin class $SurveyQuestionModelCopyWith<$Res>  {
  factory $SurveyQuestionModelCopyWith(SurveyQuestionModel value, $Res Function(SurveyQuestionModel) _then) = _$SurveyQuestionModelCopyWithImpl;
@useResult
$Res call({
 String id, String text, int orderIndex, String questionType, bool isRequired, List<String> options, int? maxSelections, int textInputCount, int textMaxLength, int likertScale, String? likertLowLabel, String? likertHighLabel, int maxStars, List<String> tags, int? maxTags, int sliderMin, int sliderMax, int sliderStep, String? sliderMinLabel, String? sliderMaxLabel, bool isAttentionCheck, String? correctAnswer, String? correctGoToQuestionId, String? incorrectGoToQuestionId, String? correctResponseText, String? correctResponseMediaUrl, String? correctResponseMediaType, String? incorrectResponseText, String? incorrectResponseMediaUrl, String? incorrectResponseMediaType, List<BranchRuleModel> branchRules
});




}
/// @nodoc
class _$SurveyQuestionModelCopyWithImpl<$Res>
    implements $SurveyQuestionModelCopyWith<$Res> {
  _$SurveyQuestionModelCopyWithImpl(this._self, this._then);

  final SurveyQuestionModel _self;
  final $Res Function(SurveyQuestionModel) _then;

/// Create a copy of SurveyQuestionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? orderIndex = null,Object? questionType = null,Object? isRequired = null,Object? options = null,Object? maxSelections = freezed,Object? textInputCount = null,Object? textMaxLength = null,Object? likertScale = null,Object? likertLowLabel = freezed,Object? likertHighLabel = freezed,Object? maxStars = null,Object? tags = null,Object? maxTags = freezed,Object? sliderMin = null,Object? sliderMax = null,Object? sliderStep = null,Object? sliderMinLabel = freezed,Object? sliderMaxLabel = freezed,Object? isAttentionCheck = null,Object? correctAnswer = freezed,Object? correctGoToQuestionId = freezed,Object? incorrectGoToQuestionId = freezed,Object? correctResponseText = freezed,Object? correctResponseMediaUrl = freezed,Object? correctResponseMediaType = freezed,Object? incorrectResponseText = freezed,Object? incorrectResponseMediaUrl = freezed,Object? incorrectResponseMediaType = freezed,Object? branchRules = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
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
as List<BranchRuleModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyQuestionModel].
extension SurveyQuestionModelPatterns on SurveyQuestionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyQuestionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyQuestionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyQuestionModel value)  $default,){
final _that = this;
switch (_that) {
case _SurveyQuestionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyQuestionModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyQuestionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  int orderIndex,  String questionType,  bool isRequired,  List<String> options,  int? maxSelections,  int textInputCount,  int textMaxLength,  int likertScale,  String? likertLowLabel,  String? likertHighLabel,  int maxStars,  List<String> tags,  int? maxTags,  int sliderMin,  int sliderMax,  int sliderStep,  String? sliderMinLabel,  String? sliderMaxLabel,  bool isAttentionCheck,  String? correctAnswer,  String? correctGoToQuestionId,  String? incorrectGoToQuestionId,  String? correctResponseText,  String? correctResponseMediaUrl,  String? correctResponseMediaType,  String? incorrectResponseText,  String? incorrectResponseMediaUrl,  String? incorrectResponseMediaType,  List<BranchRuleModel> branchRules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyQuestionModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  int orderIndex,  String questionType,  bool isRequired,  List<String> options,  int? maxSelections,  int textInputCount,  int textMaxLength,  int likertScale,  String? likertLowLabel,  String? likertHighLabel,  int maxStars,  List<String> tags,  int? maxTags,  int sliderMin,  int sliderMax,  int sliderStep,  String? sliderMinLabel,  String? sliderMaxLabel,  bool isAttentionCheck,  String? correctAnswer,  String? correctGoToQuestionId,  String? incorrectGoToQuestionId,  String? correctResponseText,  String? correctResponseMediaUrl,  String? correctResponseMediaType,  String? incorrectResponseText,  String? incorrectResponseMediaUrl,  String? incorrectResponseMediaType,  List<BranchRuleModel> branchRules)  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestionModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  int orderIndex,  String questionType,  bool isRequired,  List<String> options,  int? maxSelections,  int textInputCount,  int textMaxLength,  int likertScale,  String? likertLowLabel,  String? likertHighLabel,  int maxStars,  List<String> tags,  int? maxTags,  int sliderMin,  int sliderMax,  int sliderStep,  String? sliderMinLabel,  String? sliderMaxLabel,  bool isAttentionCheck,  String? correctAnswer,  String? correctGoToQuestionId,  String? incorrectGoToQuestionId,  String? correctResponseText,  String? correctResponseMediaUrl,  String? correctResponseMediaType,  String? incorrectResponseText,  String? incorrectResponseMediaUrl,  String? incorrectResponseMediaType,  List<BranchRuleModel> branchRules)?  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestionModel() when $default != null:
return $default(_that.id,_that.text,_that.orderIndex,_that.questionType,_that.isRequired,_that.options,_that.maxSelections,_that.textInputCount,_that.textMaxLength,_that.likertScale,_that.likertLowLabel,_that.likertHighLabel,_that.maxStars,_that.tags,_that.maxTags,_that.sliderMin,_that.sliderMax,_that.sliderStep,_that.sliderMinLabel,_that.sliderMaxLabel,_that.isAttentionCheck,_that.correctAnswer,_that.correctGoToQuestionId,_that.incorrectGoToQuestionId,_that.correctResponseText,_that.correctResponseMediaUrl,_that.correctResponseMediaType,_that.incorrectResponseText,_that.incorrectResponseMediaUrl,_that.incorrectResponseMediaType,_that.branchRules);case _:
  return null;

}
}

}

/// @nodoc


class _SurveyQuestionModel extends SurveyQuestionModel {
  const _SurveyQuestionModel({required this.id, required this.text, required this.orderIndex, required this.questionType, this.isRequired = true, final  List<String> options = const [], this.maxSelections, this.textInputCount = 1, this.textMaxLength = 50, this.likertScale = 5, this.likertLowLabel, this.likertHighLabel, this.maxStars = 5, final  List<String> tags = const [], this.maxTags, this.sliderMin = 0, this.sliderMax = 100, this.sliderStep = 1, this.sliderMinLabel, this.sliderMaxLabel, this.isAttentionCheck = false, this.correctAnswer, this.correctGoToQuestionId, this.incorrectGoToQuestionId, this.correctResponseText, this.correctResponseMediaUrl, this.correctResponseMediaType, this.incorrectResponseText, this.incorrectResponseMediaUrl, this.incorrectResponseMediaType, final  List<BranchRuleModel> branchRules = const []}): _options = options,_tags = tags,_branchRules = branchRules,super._();
  

@override final  String id;
@override final  String text;
@override final  int orderIndex;
@override final  String questionType;
@override@JsonKey() final  bool isRequired;
// single_select + multi_select
 final  List<String> _options;
// single_select + multi_select
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  int? maxSelections;
// text_input
@override@JsonKey() final  int textInputCount;
@override@JsonKey() final  int textMaxLength;
// likert
@override@JsonKey() final  int likertScale;
@override final  String? likertLowLabel;
@override final  String? likertHighLabel;
// star_tags
@override@JsonKey() final  int maxStars;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  int? maxTags;
// slider
@override@JsonKey() final  int sliderMin;
@override@JsonKey() final  int sliderMax;
@override@JsonKey() final  int sliderStep;
@override final  String? sliderMinLabel;
@override final  String? sliderMaxLabel;
// attention check
@override@JsonKey() final  bool isAttentionCheck;
@override final  String? correctAnswer;
// correctness-based branching
@override final  String? correctGoToQuestionId;
@override final  String? incorrectGoToQuestionId;
// response box (optional interstitial before branching)
@override final  String? correctResponseText;
@override final  String? correctResponseMediaUrl;
@override final  String? correctResponseMediaType;
@override final  String? incorrectResponseText;
@override final  String? incorrectResponseMediaUrl;
@override final  String? incorrectResponseMediaType;
// branching
 final  List<BranchRuleModel> _branchRules;
// branching
@override@JsonKey() List<BranchRuleModel> get branchRules {
  if (_branchRules is EqualUnmodifiableListView) return _branchRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branchRules);
}


/// Create a copy of SurveyQuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyQuestionModelCopyWith<_SurveyQuestionModel> get copyWith => __$SurveyQuestionModelCopyWithImpl<_SurveyQuestionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyQuestionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.maxSelections, maxSelections) || other.maxSelections == maxSelections)&&(identical(other.textInputCount, textInputCount) || other.textInputCount == textInputCount)&&(identical(other.textMaxLength, textMaxLength) || other.textMaxLength == textMaxLength)&&(identical(other.likertScale, likertScale) || other.likertScale == likertScale)&&(identical(other.likertLowLabel, likertLowLabel) || other.likertLowLabel == likertLowLabel)&&(identical(other.likertHighLabel, likertHighLabel) || other.likertHighLabel == likertHighLabel)&&(identical(other.maxStars, maxStars) || other.maxStars == maxStars)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.maxTags, maxTags) || other.maxTags == maxTags)&&(identical(other.sliderMin, sliderMin) || other.sliderMin == sliderMin)&&(identical(other.sliderMax, sliderMax) || other.sliderMax == sliderMax)&&(identical(other.sliderStep, sliderStep) || other.sliderStep == sliderStep)&&(identical(other.sliderMinLabel, sliderMinLabel) || other.sliderMinLabel == sliderMinLabel)&&(identical(other.sliderMaxLabel, sliderMaxLabel) || other.sliderMaxLabel == sliderMaxLabel)&&(identical(other.isAttentionCheck, isAttentionCheck) || other.isAttentionCheck == isAttentionCheck)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.correctGoToQuestionId, correctGoToQuestionId) || other.correctGoToQuestionId == correctGoToQuestionId)&&(identical(other.incorrectGoToQuestionId, incorrectGoToQuestionId) || other.incorrectGoToQuestionId == incorrectGoToQuestionId)&&(identical(other.correctResponseText, correctResponseText) || other.correctResponseText == correctResponseText)&&(identical(other.correctResponseMediaUrl, correctResponseMediaUrl) || other.correctResponseMediaUrl == correctResponseMediaUrl)&&(identical(other.correctResponseMediaType, correctResponseMediaType) || other.correctResponseMediaType == correctResponseMediaType)&&(identical(other.incorrectResponseText, incorrectResponseText) || other.incorrectResponseText == incorrectResponseText)&&(identical(other.incorrectResponseMediaUrl, incorrectResponseMediaUrl) || other.incorrectResponseMediaUrl == incorrectResponseMediaUrl)&&(identical(other.incorrectResponseMediaType, incorrectResponseMediaType) || other.incorrectResponseMediaType == incorrectResponseMediaType)&&const DeepCollectionEquality().equals(other._branchRules, _branchRules));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,text,orderIndex,questionType,isRequired,const DeepCollectionEquality().hash(_options),maxSelections,textInputCount,textMaxLength,likertScale,likertLowLabel,likertHighLabel,maxStars,const DeepCollectionEquality().hash(_tags),maxTags,sliderMin,sliderMax,sliderStep,sliderMinLabel,sliderMaxLabel,isAttentionCheck,correctAnswer,correctGoToQuestionId,incorrectGoToQuestionId,correctResponseText,correctResponseMediaUrl,correctResponseMediaType,incorrectResponseText,incorrectResponseMediaUrl,incorrectResponseMediaType,const DeepCollectionEquality().hash(_branchRules)]);

@override
String toString() {
  return 'SurveyQuestionModel(id: $id, text: $text, orderIndex: $orderIndex, questionType: $questionType, isRequired: $isRequired, options: $options, maxSelections: $maxSelections, textInputCount: $textInputCount, textMaxLength: $textMaxLength, likertScale: $likertScale, likertLowLabel: $likertLowLabel, likertHighLabel: $likertHighLabel, maxStars: $maxStars, tags: $tags, maxTags: $maxTags, sliderMin: $sliderMin, sliderMax: $sliderMax, sliderStep: $sliderStep, sliderMinLabel: $sliderMinLabel, sliderMaxLabel: $sliderMaxLabel, isAttentionCheck: $isAttentionCheck, correctAnswer: $correctAnswer, correctGoToQuestionId: $correctGoToQuestionId, incorrectGoToQuestionId: $incorrectGoToQuestionId, correctResponseText: $correctResponseText, correctResponseMediaUrl: $correctResponseMediaUrl, correctResponseMediaType: $correctResponseMediaType, incorrectResponseText: $incorrectResponseText, incorrectResponseMediaUrl: $incorrectResponseMediaUrl, incorrectResponseMediaType: $incorrectResponseMediaType, branchRules: $branchRules)';
}


}

/// @nodoc
abstract mixin class _$SurveyQuestionModelCopyWith<$Res> implements $SurveyQuestionModelCopyWith<$Res> {
  factory _$SurveyQuestionModelCopyWith(_SurveyQuestionModel value, $Res Function(_SurveyQuestionModel) _then) = __$SurveyQuestionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, int orderIndex, String questionType, bool isRequired, List<String> options, int? maxSelections, int textInputCount, int textMaxLength, int likertScale, String? likertLowLabel, String? likertHighLabel, int maxStars, List<String> tags, int? maxTags, int sliderMin, int sliderMax, int sliderStep, String? sliderMinLabel, String? sliderMaxLabel, bool isAttentionCheck, String? correctAnswer, String? correctGoToQuestionId, String? incorrectGoToQuestionId, String? correctResponseText, String? correctResponseMediaUrl, String? correctResponseMediaType, String? incorrectResponseText, String? incorrectResponseMediaUrl, String? incorrectResponseMediaType, List<BranchRuleModel> branchRules
});




}
/// @nodoc
class __$SurveyQuestionModelCopyWithImpl<$Res>
    implements _$SurveyQuestionModelCopyWith<$Res> {
  __$SurveyQuestionModelCopyWithImpl(this._self, this._then);

  final _SurveyQuestionModel _self;
  final $Res Function(_SurveyQuestionModel) _then;

/// Create a copy of SurveyQuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? orderIndex = null,Object? questionType = null,Object? isRequired = null,Object? options = null,Object? maxSelections = freezed,Object? textInputCount = null,Object? textMaxLength = null,Object? likertScale = null,Object? likertLowLabel = freezed,Object? likertHighLabel = freezed,Object? maxStars = null,Object? tags = null,Object? maxTags = freezed,Object? sliderMin = null,Object? sliderMax = null,Object? sliderStep = null,Object? sliderMinLabel = freezed,Object? sliderMaxLabel = freezed,Object? isAttentionCheck = null,Object? correctAnswer = freezed,Object? correctGoToQuestionId = freezed,Object? incorrectGoToQuestionId = freezed,Object? correctResponseText = freezed,Object? correctResponseMediaUrl = freezed,Object? correctResponseMediaType = freezed,Object? incorrectResponseText = freezed,Object? incorrectResponseMediaUrl = freezed,Object? incorrectResponseMediaType = freezed,Object? branchRules = null,}) {
  return _then(_SurveyQuestionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
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
as List<BranchRuleModel>,
  ));
}


}

/// @nodoc
mixin _$EarnOpportunityModel {

 String get id; String get threadId; String get title; String? get description;// Earning configuration
 String get earningType; int get tokenReward; int get streakPoints; String get mediaType; String? get mediaUrl; List<SurveyQuestionModel> get questions; int get durationSeconds; DateTime? get expiresAt; bool get isActive;// Pin/feature flags for ordering
 bool get isPinned; bool get isFeatured;// Denormalized client info
 String? get clientId; String? get clientName; String? get clientAvatarColor; String? get clientAvatarImage; String? get threadImage; String? get opportunityImage;// Legacy campaign reference
 String? get campaignId;// Targeting (stored as JSON map)
 Map<String, dynamic>? get targeting;// Bonus reward configuration
 bool get bonusReward; double get bonusRewardMultiplier; String? get bonusIntervalType; int? get bonusIntervalX;// User engagement status (populated by getEligibleOpportunities)
 String? get userEngagementStatus; String? get userEngagementId;// AdMob configuration
 String? get adUnitId; int get dailyLimitPerUser;// Budget cap fields
 bool get budgetExhausted; int? get tokenBudget; int get tokenSpent;// Poll link
 String? get pollId;// Upload configuration
 String? get uploadPrompt; String? get uploadContextMediaUrl; String? get uploadContextMediaType; bool get uploadVideoEnabled; bool get uploadImageEnabled; bool get uploadTextEnabled; bool get uploadVideoRequired; bool get uploadImageRequired; bool get uploadTextRequired; int get uploadVideoMaxSeconds; int get uploadTextMinChars; int get uploadTextMaxChars; bool get requiresAdminReview;// Token source (opportunity-level override; falls back to thread-level)
 String? get tokenSourceAccountId;// Reward campaign linkage
 String? get rewardCampaignId; String? get rewardCampaignName; String? get rewardType; int get rewardQuantity;
/// Create a copy of EarnOpportunityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnOpportunityModelCopyWith<EarnOpportunityModel> get copyWith => _$EarnOpportunityModelCopyWithImpl<EarnOpportunityModel>(this as EarnOpportunityModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnOpportunityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.earningType, earningType) || other.earningType == earningType)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.streakPoints, streakPoints) || other.streakPoints == streakPoints)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.opportunityImage, opportunityImage) || other.opportunityImage == opportunityImage)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&const DeepCollectionEquality().equals(other.targeting, targeting)&&(identical(other.bonusReward, bonusReward) || other.bonusReward == bonusReward)&&(identical(other.bonusRewardMultiplier, bonusRewardMultiplier) || other.bonusRewardMultiplier == bonusRewardMultiplier)&&(identical(other.bonusIntervalType, bonusIntervalType) || other.bonusIntervalType == bonusIntervalType)&&(identical(other.bonusIntervalX, bonusIntervalX) || other.bonusIntervalX == bonusIntervalX)&&(identical(other.userEngagementStatus, userEngagementStatus) || other.userEngagementStatus == userEngagementStatus)&&(identical(other.userEngagementId, userEngagementId) || other.userEngagementId == userEngagementId)&&(identical(other.adUnitId, adUnitId) || other.adUnitId == adUnitId)&&(identical(other.dailyLimitPerUser, dailyLimitPerUser) || other.dailyLimitPerUser == dailyLimitPerUser)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.tokenBudget, tokenBudget) || other.tokenBudget == tokenBudget)&&(identical(other.tokenSpent, tokenSpent) || other.tokenSpent == tokenSpent)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.uploadPrompt, uploadPrompt) || other.uploadPrompt == uploadPrompt)&&(identical(other.uploadContextMediaUrl, uploadContextMediaUrl) || other.uploadContextMediaUrl == uploadContextMediaUrl)&&(identical(other.uploadContextMediaType, uploadContextMediaType) || other.uploadContextMediaType == uploadContextMediaType)&&(identical(other.uploadVideoEnabled, uploadVideoEnabled) || other.uploadVideoEnabled == uploadVideoEnabled)&&(identical(other.uploadImageEnabled, uploadImageEnabled) || other.uploadImageEnabled == uploadImageEnabled)&&(identical(other.uploadTextEnabled, uploadTextEnabled) || other.uploadTextEnabled == uploadTextEnabled)&&(identical(other.uploadVideoRequired, uploadVideoRequired) || other.uploadVideoRequired == uploadVideoRequired)&&(identical(other.uploadImageRequired, uploadImageRequired) || other.uploadImageRequired == uploadImageRequired)&&(identical(other.uploadTextRequired, uploadTextRequired) || other.uploadTextRequired == uploadTextRequired)&&(identical(other.uploadVideoMaxSeconds, uploadVideoMaxSeconds) || other.uploadVideoMaxSeconds == uploadVideoMaxSeconds)&&(identical(other.uploadTextMinChars, uploadTextMinChars) || other.uploadTextMinChars == uploadTextMinChars)&&(identical(other.uploadTextMaxChars, uploadTextMaxChars) || other.uploadTextMaxChars == uploadTextMaxChars)&&(identical(other.requiresAdminReview, requiresAdminReview) || other.requiresAdminReview == requiresAdminReview)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.rewardCampaignId, rewardCampaignId) || other.rewardCampaignId == rewardCampaignId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardQuantity, rewardQuantity) || other.rewardQuantity == rewardQuantity));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,threadId,title,description,earningType,tokenReward,streakPoints,mediaType,mediaUrl,const DeepCollectionEquality().hash(questions),durationSeconds,expiresAt,isActive,isPinned,isFeatured,clientId,clientName,clientAvatarColor,clientAvatarImage,threadImage,opportunityImage,campaignId,const DeepCollectionEquality().hash(targeting),bonusReward,bonusRewardMultiplier,bonusIntervalType,bonusIntervalX,userEngagementStatus,userEngagementId,adUnitId,dailyLimitPerUser,budgetExhausted,tokenBudget,tokenSpent,pollId,uploadPrompt,uploadContextMediaUrl,uploadContextMediaType,uploadVideoEnabled,uploadImageEnabled,uploadTextEnabled,uploadVideoRequired,uploadImageRequired,uploadTextRequired,uploadVideoMaxSeconds,uploadTextMinChars,uploadTextMaxChars,requiresAdminReview,tokenSourceAccountId,rewardCampaignId,rewardCampaignName,rewardType,rewardQuantity]);

@override
String toString() {
  return 'EarnOpportunityModel(id: $id, threadId: $threadId, title: $title, description: $description, earningType: $earningType, tokenReward: $tokenReward, streakPoints: $streakPoints, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, isPinned: $isPinned, isFeatured: $isFeatured, clientId: $clientId, clientName: $clientName, clientAvatarColor: $clientAvatarColor, clientAvatarImage: $clientAvatarImage, threadImage: $threadImage, opportunityImage: $opportunityImage, campaignId: $campaignId, targeting: $targeting, bonusReward: $bonusReward, bonusRewardMultiplier: $bonusRewardMultiplier, bonusIntervalType: $bonusIntervalType, bonusIntervalX: $bonusIntervalX, userEngagementStatus: $userEngagementStatus, userEngagementId: $userEngagementId, adUnitId: $adUnitId, dailyLimitPerUser: $dailyLimitPerUser, budgetExhausted: $budgetExhausted, tokenBudget: $tokenBudget, tokenSpent: $tokenSpent, pollId: $pollId, uploadPrompt: $uploadPrompt, uploadContextMediaUrl: $uploadContextMediaUrl, uploadContextMediaType: $uploadContextMediaType, uploadVideoEnabled: $uploadVideoEnabled, uploadImageEnabled: $uploadImageEnabled, uploadTextEnabled: $uploadTextEnabled, uploadVideoRequired: $uploadVideoRequired, uploadImageRequired: $uploadImageRequired, uploadTextRequired: $uploadTextRequired, uploadVideoMaxSeconds: $uploadVideoMaxSeconds, uploadTextMinChars: $uploadTextMinChars, uploadTextMaxChars: $uploadTextMaxChars, requiresAdminReview: $requiresAdminReview, tokenSourceAccountId: $tokenSourceAccountId, rewardCampaignId: $rewardCampaignId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType, rewardQuantity: $rewardQuantity)';
}


}

/// @nodoc
abstract mixin class $EarnOpportunityModelCopyWith<$Res>  {
  factory $EarnOpportunityModelCopyWith(EarnOpportunityModel value, $Res Function(EarnOpportunityModel) _then) = _$EarnOpportunityModelCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, String title, String? description, String earningType, int tokenReward, int streakPoints, String mediaType, String? mediaUrl, List<SurveyQuestionModel> questions, int durationSeconds, DateTime? expiresAt, bool isActive, bool isPinned, bool isFeatured, String? clientId, String? clientName, String? clientAvatarColor, String? clientAvatarImage, String? threadImage, String? opportunityImage, String? campaignId, Map<String, dynamic>? targeting, bool bonusReward, double bonusRewardMultiplier, String? bonusIntervalType, int? bonusIntervalX, String? userEngagementStatus, String? userEngagementId, String? adUnitId, int dailyLimitPerUser, bool budgetExhausted, int? tokenBudget, int tokenSpent, String? pollId, String? uploadPrompt, String? uploadContextMediaUrl, String? uploadContextMediaType, bool uploadVideoEnabled, bool uploadImageEnabled, bool uploadTextEnabled, bool uploadVideoRequired, bool uploadImageRequired, bool uploadTextRequired, int uploadVideoMaxSeconds, int uploadTextMinChars, int uploadTextMaxChars, bool requiresAdminReview, String? tokenSourceAccountId, String? rewardCampaignId, String? rewardCampaignName, String? rewardType, int rewardQuantity
});




}
/// @nodoc
class _$EarnOpportunityModelCopyWithImpl<$Res>
    implements $EarnOpportunityModelCopyWith<$Res> {
  _$EarnOpportunityModelCopyWithImpl(this._self, this._then);

  final EarnOpportunityModel _self;
  final $Res Function(EarnOpportunityModel) _then;

/// Create a copy of EarnOpportunityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? title = null,Object? description = freezed,Object? earningType = null,Object? tokenReward = null,Object? streakPoints = null,Object? mediaType = null,Object? mediaUrl = freezed,Object? questions = null,Object? durationSeconds = null,Object? expiresAt = freezed,Object? isActive = null,Object? isPinned = null,Object? isFeatured = null,Object? clientId = freezed,Object? clientName = freezed,Object? clientAvatarColor = freezed,Object? clientAvatarImage = freezed,Object? threadImage = freezed,Object? opportunityImage = freezed,Object? campaignId = freezed,Object? targeting = freezed,Object? bonusReward = null,Object? bonusRewardMultiplier = null,Object? bonusIntervalType = freezed,Object? bonusIntervalX = freezed,Object? userEngagementStatus = freezed,Object? userEngagementId = freezed,Object? adUnitId = freezed,Object? dailyLimitPerUser = null,Object? budgetExhausted = null,Object? tokenBudget = freezed,Object? tokenSpent = null,Object? pollId = freezed,Object? uploadPrompt = freezed,Object? uploadContextMediaUrl = freezed,Object? uploadContextMediaType = freezed,Object? uploadVideoEnabled = null,Object? uploadImageEnabled = null,Object? uploadTextEnabled = null,Object? uploadVideoRequired = null,Object? uploadImageRequired = null,Object? uploadTextRequired = null,Object? uploadVideoMaxSeconds = null,Object? uploadTextMinChars = null,Object? uploadTextMaxChars = null,Object? requiresAdminReview = null,Object? tokenSourceAccountId = freezed,Object? rewardCampaignId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,Object? rewardQuantity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,earningType: null == earningType ? _self.earningType : earningType // ignore: cast_nullable_to_non_nullable
as String,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,streakPoints: null == streakPoints ? _self.streakPoints : streakPoints // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestionModel>,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
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
as Map<String, dynamic>?,bonusReward: null == bonusReward ? _self.bonusReward : bonusReward // ignore: cast_nullable_to_non_nullable
as bool,bonusRewardMultiplier: null == bonusRewardMultiplier ? _self.bonusRewardMultiplier : bonusRewardMultiplier // ignore: cast_nullable_to_non_nullable
as double,bonusIntervalType: freezed == bonusIntervalType ? _self.bonusIntervalType : bonusIntervalType // ignore: cast_nullable_to_non_nullable
as String?,bonusIntervalX: freezed == bonusIntervalX ? _self.bonusIntervalX : bonusIntervalX // ignore: cast_nullable_to_non_nullable
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

}


/// Adds pattern-matching-related methods to [EarnOpportunityModel].
extension EarnOpportunityModelPatterns on EarnOpportunityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnOpportunityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnOpportunityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnOpportunityModel value)  $default,){
final _that = this;
switch (_that) {
case _EarnOpportunityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnOpportunityModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarnOpportunityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String threadId,  String title,  String? description,  String earningType,  int tokenReward,  int streakPoints,  String mediaType,  String? mediaUrl,  List<SurveyQuestionModel> questions,  int durationSeconds,  DateTime? expiresAt,  bool isActive,  bool isPinned,  bool isFeatured,  String? clientId,  String? clientName,  String? clientAvatarColor,  String? clientAvatarImage,  String? threadImage,  String? opportunityImage,  String? campaignId,  Map<String, dynamic>? targeting,  bool bonusReward,  double bonusRewardMultiplier,  String? bonusIntervalType,  int? bonusIntervalX,  String? userEngagementStatus,  String? userEngagementId,  String? adUnitId,  int dailyLimitPerUser,  bool budgetExhausted,  int? tokenBudget,  int tokenSpent,  String? pollId,  String? uploadPrompt,  String? uploadContextMediaUrl,  String? uploadContextMediaType,  bool uploadVideoEnabled,  bool uploadImageEnabled,  bool uploadTextEnabled,  bool uploadVideoRequired,  bool uploadImageRequired,  bool uploadTextRequired,  int uploadVideoMaxSeconds,  int uploadTextMinChars,  int uploadTextMaxChars,  bool requiresAdminReview,  String? tokenSourceAccountId,  String? rewardCampaignId,  String? rewardCampaignName,  String? rewardType,  int rewardQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnOpportunityModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String threadId,  String title,  String? description,  String earningType,  int tokenReward,  int streakPoints,  String mediaType,  String? mediaUrl,  List<SurveyQuestionModel> questions,  int durationSeconds,  DateTime? expiresAt,  bool isActive,  bool isPinned,  bool isFeatured,  String? clientId,  String? clientName,  String? clientAvatarColor,  String? clientAvatarImage,  String? threadImage,  String? opportunityImage,  String? campaignId,  Map<String, dynamic>? targeting,  bool bonusReward,  double bonusRewardMultiplier,  String? bonusIntervalType,  int? bonusIntervalX,  String? userEngagementStatus,  String? userEngagementId,  String? adUnitId,  int dailyLimitPerUser,  bool budgetExhausted,  int? tokenBudget,  int tokenSpent,  String? pollId,  String? uploadPrompt,  String? uploadContextMediaUrl,  String? uploadContextMediaType,  bool uploadVideoEnabled,  bool uploadImageEnabled,  bool uploadTextEnabled,  bool uploadVideoRequired,  bool uploadImageRequired,  bool uploadTextRequired,  int uploadVideoMaxSeconds,  int uploadTextMinChars,  int uploadTextMaxChars,  bool requiresAdminReview,  String? tokenSourceAccountId,  String? rewardCampaignId,  String? rewardCampaignName,  String? rewardType,  int rewardQuantity)  $default,) {final _that = this;
switch (_that) {
case _EarnOpportunityModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String threadId,  String title,  String? description,  String earningType,  int tokenReward,  int streakPoints,  String mediaType,  String? mediaUrl,  List<SurveyQuestionModel> questions,  int durationSeconds,  DateTime? expiresAt,  bool isActive,  bool isPinned,  bool isFeatured,  String? clientId,  String? clientName,  String? clientAvatarColor,  String? clientAvatarImage,  String? threadImage,  String? opportunityImage,  String? campaignId,  Map<String, dynamic>? targeting,  bool bonusReward,  double bonusRewardMultiplier,  String? bonusIntervalType,  int? bonusIntervalX,  String? userEngagementStatus,  String? userEngagementId,  String? adUnitId,  int dailyLimitPerUser,  bool budgetExhausted,  int? tokenBudget,  int tokenSpent,  String? pollId,  String? uploadPrompt,  String? uploadContextMediaUrl,  String? uploadContextMediaType,  bool uploadVideoEnabled,  bool uploadImageEnabled,  bool uploadTextEnabled,  bool uploadVideoRequired,  bool uploadImageRequired,  bool uploadTextRequired,  int uploadVideoMaxSeconds,  int uploadTextMinChars,  int uploadTextMaxChars,  bool requiresAdminReview,  String? tokenSourceAccountId,  String? rewardCampaignId,  String? rewardCampaignName,  String? rewardType,  int rewardQuantity)?  $default,) {final _that = this;
switch (_that) {
case _EarnOpportunityModel() when $default != null:
return $default(_that.id,_that.threadId,_that.title,_that.description,_that.earningType,_that.tokenReward,_that.streakPoints,_that.mediaType,_that.mediaUrl,_that.questions,_that.durationSeconds,_that.expiresAt,_that.isActive,_that.isPinned,_that.isFeatured,_that.clientId,_that.clientName,_that.clientAvatarColor,_that.clientAvatarImage,_that.threadImage,_that.opportunityImage,_that.campaignId,_that.targeting,_that.bonusReward,_that.bonusRewardMultiplier,_that.bonusIntervalType,_that.bonusIntervalX,_that.userEngagementStatus,_that.userEngagementId,_that.adUnitId,_that.dailyLimitPerUser,_that.budgetExhausted,_that.tokenBudget,_that.tokenSpent,_that.pollId,_that.uploadPrompt,_that.uploadContextMediaUrl,_that.uploadContextMediaType,_that.uploadVideoEnabled,_that.uploadImageEnabled,_that.uploadTextEnabled,_that.uploadVideoRequired,_that.uploadImageRequired,_that.uploadTextRequired,_that.uploadVideoMaxSeconds,_that.uploadTextMinChars,_that.uploadTextMaxChars,_that.requiresAdminReview,_that.tokenSourceAccountId,_that.rewardCampaignId,_that.rewardCampaignName,_that.rewardType,_that.rewardQuantity);case _:
  return null;

}
}

}

/// @nodoc


class _EarnOpportunityModel extends EarnOpportunityModel {
  const _EarnOpportunityModel({required this.id, required this.threadId, required this.title, this.description, required this.earningType, required this.tokenReward, this.streakPoints = 1, required this.mediaType, this.mediaUrl, required final  List<SurveyQuestionModel> questions, required this.durationSeconds, this.expiresAt, required this.isActive, this.isPinned = false, this.isFeatured = false, this.clientId, this.clientName, this.clientAvatarColor, this.clientAvatarImage, this.threadImage, this.opportunityImage, this.campaignId, final  Map<String, dynamic>? targeting, this.bonusReward = false, this.bonusRewardMultiplier = 1.0, this.bonusIntervalType, this.bonusIntervalX, this.userEngagementStatus, this.userEngagementId, this.adUnitId, this.dailyLimitPerUser = 3, this.budgetExhausted = false, this.tokenBudget, this.tokenSpent = 0, this.pollId, this.uploadPrompt, this.uploadContextMediaUrl, this.uploadContextMediaType, this.uploadVideoEnabled = false, this.uploadImageEnabled = false, this.uploadTextEnabled = false, this.uploadVideoRequired = false, this.uploadImageRequired = false, this.uploadTextRequired = false, this.uploadVideoMaxSeconds = 60, this.uploadTextMinChars = 10, this.uploadTextMaxChars = 1500, this.requiresAdminReview = false, this.tokenSourceAccountId, this.rewardCampaignId, this.rewardCampaignName, this.rewardType, this.rewardQuantity = 1}): _questions = questions,_targeting = targeting,super._();
  

@override final  String id;
@override final  String threadId;
@override final  String title;
@override final  String? description;
// Earning configuration
@override final  String earningType;
@override final  int tokenReward;
@override@JsonKey() final  int streakPoints;
@override final  String mediaType;
@override final  String? mediaUrl;
 final  List<SurveyQuestionModel> _questions;
@override List<SurveyQuestionModel> get questions {
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
// Targeting (stored as JSON map)
 final  Map<String, dynamic>? _targeting;
// Targeting (stored as JSON map)
@override Map<String, dynamic>? get targeting {
  final value = _targeting;
  if (value == null) return null;
  if (_targeting is EqualUnmodifiableMapView) return _targeting;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Bonus reward configuration
@override@JsonKey() final  bool bonusReward;
@override@JsonKey() final  double bonusRewardMultiplier;
@override final  String? bonusIntervalType;
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
// Upload configuration
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

/// Create a copy of EarnOpportunityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnOpportunityModelCopyWith<_EarnOpportunityModel> get copyWith => __$EarnOpportunityModelCopyWithImpl<_EarnOpportunityModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnOpportunityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.earningType, earningType) || other.earningType == earningType)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.streakPoints, streakPoints) || other.streakPoints == streakPoints)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.opportunityImage, opportunityImage) || other.opportunityImage == opportunityImage)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&const DeepCollectionEquality().equals(other._targeting, _targeting)&&(identical(other.bonusReward, bonusReward) || other.bonusReward == bonusReward)&&(identical(other.bonusRewardMultiplier, bonusRewardMultiplier) || other.bonusRewardMultiplier == bonusRewardMultiplier)&&(identical(other.bonusIntervalType, bonusIntervalType) || other.bonusIntervalType == bonusIntervalType)&&(identical(other.bonusIntervalX, bonusIntervalX) || other.bonusIntervalX == bonusIntervalX)&&(identical(other.userEngagementStatus, userEngagementStatus) || other.userEngagementStatus == userEngagementStatus)&&(identical(other.userEngagementId, userEngagementId) || other.userEngagementId == userEngagementId)&&(identical(other.adUnitId, adUnitId) || other.adUnitId == adUnitId)&&(identical(other.dailyLimitPerUser, dailyLimitPerUser) || other.dailyLimitPerUser == dailyLimitPerUser)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.tokenBudget, tokenBudget) || other.tokenBudget == tokenBudget)&&(identical(other.tokenSpent, tokenSpent) || other.tokenSpent == tokenSpent)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.uploadPrompt, uploadPrompt) || other.uploadPrompt == uploadPrompt)&&(identical(other.uploadContextMediaUrl, uploadContextMediaUrl) || other.uploadContextMediaUrl == uploadContextMediaUrl)&&(identical(other.uploadContextMediaType, uploadContextMediaType) || other.uploadContextMediaType == uploadContextMediaType)&&(identical(other.uploadVideoEnabled, uploadVideoEnabled) || other.uploadVideoEnabled == uploadVideoEnabled)&&(identical(other.uploadImageEnabled, uploadImageEnabled) || other.uploadImageEnabled == uploadImageEnabled)&&(identical(other.uploadTextEnabled, uploadTextEnabled) || other.uploadTextEnabled == uploadTextEnabled)&&(identical(other.uploadVideoRequired, uploadVideoRequired) || other.uploadVideoRequired == uploadVideoRequired)&&(identical(other.uploadImageRequired, uploadImageRequired) || other.uploadImageRequired == uploadImageRequired)&&(identical(other.uploadTextRequired, uploadTextRequired) || other.uploadTextRequired == uploadTextRequired)&&(identical(other.uploadVideoMaxSeconds, uploadVideoMaxSeconds) || other.uploadVideoMaxSeconds == uploadVideoMaxSeconds)&&(identical(other.uploadTextMinChars, uploadTextMinChars) || other.uploadTextMinChars == uploadTextMinChars)&&(identical(other.uploadTextMaxChars, uploadTextMaxChars) || other.uploadTextMaxChars == uploadTextMaxChars)&&(identical(other.requiresAdminReview, requiresAdminReview) || other.requiresAdminReview == requiresAdminReview)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.rewardCampaignId, rewardCampaignId) || other.rewardCampaignId == rewardCampaignId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardQuantity, rewardQuantity) || other.rewardQuantity == rewardQuantity));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,threadId,title,description,earningType,tokenReward,streakPoints,mediaType,mediaUrl,const DeepCollectionEquality().hash(_questions),durationSeconds,expiresAt,isActive,isPinned,isFeatured,clientId,clientName,clientAvatarColor,clientAvatarImage,threadImage,opportunityImage,campaignId,const DeepCollectionEquality().hash(_targeting),bonusReward,bonusRewardMultiplier,bonusIntervalType,bonusIntervalX,userEngagementStatus,userEngagementId,adUnitId,dailyLimitPerUser,budgetExhausted,tokenBudget,tokenSpent,pollId,uploadPrompt,uploadContextMediaUrl,uploadContextMediaType,uploadVideoEnabled,uploadImageEnabled,uploadTextEnabled,uploadVideoRequired,uploadImageRequired,uploadTextRequired,uploadVideoMaxSeconds,uploadTextMinChars,uploadTextMaxChars,requiresAdminReview,tokenSourceAccountId,rewardCampaignId,rewardCampaignName,rewardType,rewardQuantity]);

@override
String toString() {
  return 'EarnOpportunityModel(id: $id, threadId: $threadId, title: $title, description: $description, earningType: $earningType, tokenReward: $tokenReward, streakPoints: $streakPoints, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, isPinned: $isPinned, isFeatured: $isFeatured, clientId: $clientId, clientName: $clientName, clientAvatarColor: $clientAvatarColor, clientAvatarImage: $clientAvatarImage, threadImage: $threadImage, opportunityImage: $opportunityImage, campaignId: $campaignId, targeting: $targeting, bonusReward: $bonusReward, bonusRewardMultiplier: $bonusRewardMultiplier, bonusIntervalType: $bonusIntervalType, bonusIntervalX: $bonusIntervalX, userEngagementStatus: $userEngagementStatus, userEngagementId: $userEngagementId, adUnitId: $adUnitId, dailyLimitPerUser: $dailyLimitPerUser, budgetExhausted: $budgetExhausted, tokenBudget: $tokenBudget, tokenSpent: $tokenSpent, pollId: $pollId, uploadPrompt: $uploadPrompt, uploadContextMediaUrl: $uploadContextMediaUrl, uploadContextMediaType: $uploadContextMediaType, uploadVideoEnabled: $uploadVideoEnabled, uploadImageEnabled: $uploadImageEnabled, uploadTextEnabled: $uploadTextEnabled, uploadVideoRequired: $uploadVideoRequired, uploadImageRequired: $uploadImageRequired, uploadTextRequired: $uploadTextRequired, uploadVideoMaxSeconds: $uploadVideoMaxSeconds, uploadTextMinChars: $uploadTextMinChars, uploadTextMaxChars: $uploadTextMaxChars, requiresAdminReview: $requiresAdminReview, tokenSourceAccountId: $tokenSourceAccountId, rewardCampaignId: $rewardCampaignId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType, rewardQuantity: $rewardQuantity)';
}


}

/// @nodoc
abstract mixin class _$EarnOpportunityModelCopyWith<$Res> implements $EarnOpportunityModelCopyWith<$Res> {
  factory _$EarnOpportunityModelCopyWith(_EarnOpportunityModel value, $Res Function(_EarnOpportunityModel) _then) = __$EarnOpportunityModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, String title, String? description, String earningType, int tokenReward, int streakPoints, String mediaType, String? mediaUrl, List<SurveyQuestionModel> questions, int durationSeconds, DateTime? expiresAt, bool isActive, bool isPinned, bool isFeatured, String? clientId, String? clientName, String? clientAvatarColor, String? clientAvatarImage, String? threadImage, String? opportunityImage, String? campaignId, Map<String, dynamic>? targeting, bool bonusReward, double bonusRewardMultiplier, String? bonusIntervalType, int? bonusIntervalX, String? userEngagementStatus, String? userEngagementId, String? adUnitId, int dailyLimitPerUser, bool budgetExhausted, int? tokenBudget, int tokenSpent, String? pollId, String? uploadPrompt, String? uploadContextMediaUrl, String? uploadContextMediaType, bool uploadVideoEnabled, bool uploadImageEnabled, bool uploadTextEnabled, bool uploadVideoRequired, bool uploadImageRequired, bool uploadTextRequired, int uploadVideoMaxSeconds, int uploadTextMinChars, int uploadTextMaxChars, bool requiresAdminReview, String? tokenSourceAccountId, String? rewardCampaignId, String? rewardCampaignName, String? rewardType, int rewardQuantity
});




}
/// @nodoc
class __$EarnOpportunityModelCopyWithImpl<$Res>
    implements _$EarnOpportunityModelCopyWith<$Res> {
  __$EarnOpportunityModelCopyWithImpl(this._self, this._then);

  final _EarnOpportunityModel _self;
  final $Res Function(_EarnOpportunityModel) _then;

/// Create a copy of EarnOpportunityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? title = null,Object? description = freezed,Object? earningType = null,Object? tokenReward = null,Object? streakPoints = null,Object? mediaType = null,Object? mediaUrl = freezed,Object? questions = null,Object? durationSeconds = null,Object? expiresAt = freezed,Object? isActive = null,Object? isPinned = null,Object? isFeatured = null,Object? clientId = freezed,Object? clientName = freezed,Object? clientAvatarColor = freezed,Object? clientAvatarImage = freezed,Object? threadImage = freezed,Object? opportunityImage = freezed,Object? campaignId = freezed,Object? targeting = freezed,Object? bonusReward = null,Object? bonusRewardMultiplier = null,Object? bonusIntervalType = freezed,Object? bonusIntervalX = freezed,Object? userEngagementStatus = freezed,Object? userEngagementId = freezed,Object? adUnitId = freezed,Object? dailyLimitPerUser = null,Object? budgetExhausted = null,Object? tokenBudget = freezed,Object? tokenSpent = null,Object? pollId = freezed,Object? uploadPrompt = freezed,Object? uploadContextMediaUrl = freezed,Object? uploadContextMediaType = freezed,Object? uploadVideoEnabled = null,Object? uploadImageEnabled = null,Object? uploadTextEnabled = null,Object? uploadVideoRequired = null,Object? uploadImageRequired = null,Object? uploadTextRequired = null,Object? uploadVideoMaxSeconds = null,Object? uploadTextMinChars = null,Object? uploadTextMaxChars = null,Object? requiresAdminReview = null,Object? tokenSourceAccountId = freezed,Object? rewardCampaignId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,Object? rewardQuantity = null,}) {
  return _then(_EarnOpportunityModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,earningType: null == earningType ? _self.earningType : earningType // ignore: cast_nullable_to_non_nullable
as String,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,streakPoints: null == streakPoints ? _self.streakPoints : streakPoints // ignore: cast_nullable_to_non_nullable
as int,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestionModel>,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
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
as String?,targeting: freezed == targeting ? _self._targeting : targeting // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,bonusReward: null == bonusReward ? _self.bonusReward : bonusReward // ignore: cast_nullable_to_non_nullable
as bool,bonusRewardMultiplier: null == bonusRewardMultiplier ? _self.bonusRewardMultiplier : bonusRewardMultiplier // ignore: cast_nullable_to_non_nullable
as double,bonusIntervalType: freezed == bonusIntervalType ? _self.bonusIntervalType : bonusIntervalType // ignore: cast_nullable_to_non_nullable
as String?,bonusIntervalX: freezed == bonusIntervalX ? _self.bonusIntervalX : bonusIntervalX // ignore: cast_nullable_to_non_nullable
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


}

// dart format on
