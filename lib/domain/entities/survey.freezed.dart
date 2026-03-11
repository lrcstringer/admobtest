// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Survey {

 String get id; String get campaignId; String get title; String get description; List<SurveyQuestion> get questions; int get tokenReward; int get estimatedMinutes; SurveyStatus get status; DateTime get createdAt; DateTime? get expiresAt; int? get maxResponses; int? get currentResponses; Map<String, dynamic>? get targetingCriteria;
/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyCopyWith<Survey> get copyWith => _$SurveyCopyWithImpl<Survey>(this as Survey, _$identity);

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Survey&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxResponses, maxResponses) || other.maxResponses == maxResponses)&&(identical(other.currentResponses, currentResponses) || other.currentResponses == currentResponses)&&const DeepCollectionEquality().equals(other.targetingCriteria, targetingCriteria));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,title,description,const DeepCollectionEquality().hash(questions),tokenReward,estimatedMinutes,status,createdAt,expiresAt,maxResponses,currentResponses,const DeepCollectionEquality().hash(targetingCriteria));

@override
String toString() {
  return 'Survey(id: $id, campaignId: $campaignId, title: $title, description: $description, questions: $questions, tokenReward: $tokenReward, estimatedMinutes: $estimatedMinutes, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, maxResponses: $maxResponses, currentResponses: $currentResponses, targetingCriteria: $targetingCriteria)';
}


}

/// @nodoc
abstract mixin class $SurveyCopyWith<$Res>  {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) _then) = _$SurveyCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String title, String description, List<SurveyQuestion> questions, int tokenReward, int estimatedMinutes, SurveyStatus status, DateTime createdAt, DateTime? expiresAt, int? maxResponses, int? currentResponses, Map<String, dynamic>? targetingCriteria
});




}
/// @nodoc
class _$SurveyCopyWithImpl<$Res>
    implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._self, this._then);

  final Survey _self;
  final $Res Function(Survey) _then;

/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? title = null,Object? description = null,Object? questions = null,Object? tokenReward = null,Object? estimatedMinutes = null,Object? status = null,Object? createdAt = null,Object? expiresAt = freezed,Object? maxResponses = freezed,Object? currentResponses = freezed,Object? targetingCriteria = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestion>,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SurveyStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxResponses: freezed == maxResponses ? _self.maxResponses : maxResponses // ignore: cast_nullable_to_non_nullable
as int?,currentResponses: freezed == currentResponses ? _self.currentResponses : currentResponses // ignore: cast_nullable_to_non_nullable
as int?,targetingCriteria: freezed == targetingCriteria ? _self.targetingCriteria : targetingCriteria // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Survey].
extension SurveyPatterns on Survey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Survey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Survey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Survey value)  $default,){
final _that = this;
switch (_that) {
case _Survey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Survey value)?  $default,){
final _that = this;
switch (_that) {
case _Survey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String title,  String description,  List<SurveyQuestion> questions,  int tokenReward,  int estimatedMinutes,  SurveyStatus status,  DateTime createdAt,  DateTime? expiresAt,  int? maxResponses,  int? currentResponses,  Map<String, dynamic>? targetingCriteria)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Survey() when $default != null:
return $default(_that.id,_that.campaignId,_that.title,_that.description,_that.questions,_that.tokenReward,_that.estimatedMinutes,_that.status,_that.createdAt,_that.expiresAt,_that.maxResponses,_that.currentResponses,_that.targetingCriteria);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String title,  String description,  List<SurveyQuestion> questions,  int tokenReward,  int estimatedMinutes,  SurveyStatus status,  DateTime createdAt,  DateTime? expiresAt,  int? maxResponses,  int? currentResponses,  Map<String, dynamic>? targetingCriteria)  $default,) {final _that = this;
switch (_that) {
case _Survey():
return $default(_that.id,_that.campaignId,_that.title,_that.description,_that.questions,_that.tokenReward,_that.estimatedMinutes,_that.status,_that.createdAt,_that.expiresAt,_that.maxResponses,_that.currentResponses,_that.targetingCriteria);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String title,  String description,  List<SurveyQuestion> questions,  int tokenReward,  int estimatedMinutes,  SurveyStatus status,  DateTime createdAt,  DateTime? expiresAt,  int? maxResponses,  int? currentResponses,  Map<String, dynamic>? targetingCriteria)?  $default,) {final _that = this;
switch (_that) {
case _Survey() when $default != null:
return $default(_that.id,_that.campaignId,_that.title,_that.description,_that.questions,_that.tokenReward,_that.estimatedMinutes,_that.status,_that.createdAt,_that.expiresAt,_that.maxResponses,_that.currentResponses,_that.targetingCriteria);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Survey implements Survey {
  const _Survey({required this.id, required this.campaignId, required this.title, required this.description, required final  List<SurveyQuestion> questions, required this.tokenReward, required this.estimatedMinutes, required this.status, required this.createdAt, this.expiresAt, this.maxResponses, this.currentResponses, final  Map<String, dynamic>? targetingCriteria}): _questions = questions,_targetingCriteria = targetingCriteria;
  factory _Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

@override final  String id;
@override final  String campaignId;
@override final  String title;
@override final  String description;
 final  List<SurveyQuestion> _questions;
@override List<SurveyQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  int tokenReward;
@override final  int estimatedMinutes;
@override final  SurveyStatus status;
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;
@override final  int? maxResponses;
@override final  int? currentResponses;
 final  Map<String, dynamic>? _targetingCriteria;
@override Map<String, dynamic>? get targetingCriteria {
  final value = _targetingCriteria;
  if (value == null) return null;
  if (_targetingCriteria is EqualUnmodifiableMapView) return _targetingCriteria;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyCopyWith<_Survey> get copyWith => __$SurveyCopyWithImpl<_Survey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Survey&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.tokenReward, tokenReward) || other.tokenReward == tokenReward)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxResponses, maxResponses) || other.maxResponses == maxResponses)&&(identical(other.currentResponses, currentResponses) || other.currentResponses == currentResponses)&&const DeepCollectionEquality().equals(other._targetingCriteria, _targetingCriteria));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,title,description,const DeepCollectionEquality().hash(_questions),tokenReward,estimatedMinutes,status,createdAt,expiresAt,maxResponses,currentResponses,const DeepCollectionEquality().hash(_targetingCriteria));

@override
String toString() {
  return 'Survey(id: $id, campaignId: $campaignId, title: $title, description: $description, questions: $questions, tokenReward: $tokenReward, estimatedMinutes: $estimatedMinutes, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, maxResponses: $maxResponses, currentResponses: $currentResponses, targetingCriteria: $targetingCriteria)';
}


}

/// @nodoc
abstract mixin class _$SurveyCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$SurveyCopyWith(_Survey value, $Res Function(_Survey) _then) = __$SurveyCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String title, String description, List<SurveyQuestion> questions, int tokenReward, int estimatedMinutes, SurveyStatus status, DateTime createdAt, DateTime? expiresAt, int? maxResponses, int? currentResponses, Map<String, dynamic>? targetingCriteria
});




}
/// @nodoc
class __$SurveyCopyWithImpl<$Res>
    implements _$SurveyCopyWith<$Res> {
  __$SurveyCopyWithImpl(this._self, this._then);

  final _Survey _self;
  final $Res Function(_Survey) _then;

/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? title = null,Object? description = null,Object? questions = null,Object? tokenReward = null,Object? estimatedMinutes = null,Object? status = null,Object? createdAt = null,Object? expiresAt = freezed,Object? maxResponses = freezed,Object? currentResponses = freezed,Object? targetingCriteria = freezed,}) {
  return _then(_Survey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestion>,tokenReward: null == tokenReward ? _self.tokenReward : tokenReward // ignore: cast_nullable_to_non_nullable
as int,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SurveyStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxResponses: freezed == maxResponses ? _self.maxResponses : maxResponses // ignore: cast_nullable_to_non_nullable
as int?,currentResponses: freezed == currentResponses ? _self.currentResponses : currentResponses // ignore: cast_nullable_to_non_nullable
as int?,targetingCriteria: freezed == targetingCriteria ? _self._targetingCriteria : targetingCriteria // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$SurveyQuestion {

 String get id; String get text; QuestionType get type; bool get isRequired; List<String>? get options; int? get minValue; int? get maxValue; String? get placeholder;
/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyQuestionCopyWith<SurveyQuestion> get copyWith => _$SurveyQuestionCopyWithImpl<SurveyQuestion>(this as SurveyQuestion, _$identity);

  /// Serializes this SurveyQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.minValue, minValue) || other.minValue == minValue)&&(identical(other.maxValue, maxValue) || other.maxValue == maxValue)&&(identical(other.placeholder, placeholder) || other.placeholder == placeholder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,type,isRequired,const DeepCollectionEquality().hash(options),minValue,maxValue,placeholder);

@override
String toString() {
  return 'SurveyQuestion(id: $id, text: $text, type: $type, isRequired: $isRequired, options: $options, minValue: $minValue, maxValue: $maxValue, placeholder: $placeholder)';
}


}

/// @nodoc
abstract mixin class $SurveyQuestionCopyWith<$Res>  {
  factory $SurveyQuestionCopyWith(SurveyQuestion value, $Res Function(SurveyQuestion) _then) = _$SurveyQuestionCopyWithImpl;
@useResult
$Res call({
 String id, String text, QuestionType type, bool isRequired, List<String>? options, int? minValue, int? maxValue, String? placeholder
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? type = null,Object? isRequired = null,Object? options = freezed,Object? minValue = freezed,Object? maxValue = freezed,Object? placeholder = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,minValue: freezed == minValue ? _self.minValue : minValue // ignore: cast_nullable_to_non_nullable
as int?,maxValue: freezed == maxValue ? _self.maxValue : maxValue // ignore: cast_nullable_to_non_nullable
as int?,placeholder: freezed == placeholder ? _self.placeholder : placeholder // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  QuestionType type,  bool isRequired,  List<String>? options,  int? minValue,  int? maxValue,  String? placeholder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that.id,_that.text,_that.type,_that.isRequired,_that.options,_that.minValue,_that.maxValue,_that.placeholder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  QuestionType type,  bool isRequired,  List<String>? options,  int? minValue,  int? maxValue,  String? placeholder)  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestion():
return $default(_that.id,_that.text,_that.type,_that.isRequired,_that.options,_that.minValue,_that.maxValue,_that.placeholder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  QuestionType type,  bool isRequired,  List<String>? options,  int? minValue,  int? maxValue,  String? placeholder)?  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that.id,_that.text,_that.type,_that.isRequired,_that.options,_that.minValue,_that.maxValue,_that.placeholder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyQuestion implements SurveyQuestion {
  const _SurveyQuestion({required this.id, required this.text, required this.type, required this.isRequired, final  List<String>? options, this.minValue, this.maxValue, this.placeholder}): _options = options;
  factory _SurveyQuestion.fromJson(Map<String, dynamic> json) => _$SurveyQuestionFromJson(json);

@override final  String id;
@override final  String text;
@override final  QuestionType type;
@override final  bool isRequired;
 final  List<String>? _options;
@override List<String>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? minValue;
@override final  int? maxValue;
@override final  String? placeholder;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.minValue, minValue) || other.minValue == minValue)&&(identical(other.maxValue, maxValue) || other.maxValue == maxValue)&&(identical(other.placeholder, placeholder) || other.placeholder == placeholder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,type,isRequired,const DeepCollectionEquality().hash(_options),minValue,maxValue,placeholder);

@override
String toString() {
  return 'SurveyQuestion(id: $id, text: $text, type: $type, isRequired: $isRequired, options: $options, minValue: $minValue, maxValue: $maxValue, placeholder: $placeholder)';
}


}

/// @nodoc
abstract mixin class _$SurveyQuestionCopyWith<$Res> implements $SurveyQuestionCopyWith<$Res> {
  factory _$SurveyQuestionCopyWith(_SurveyQuestion value, $Res Function(_SurveyQuestion) _then) = __$SurveyQuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, QuestionType type, bool isRequired, List<String>? options, int? minValue, int? maxValue, String? placeholder
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? type = null,Object? isRequired = null,Object? options = freezed,Object? minValue = freezed,Object? maxValue = freezed,Object? placeholder = freezed,}) {
  return _then(_SurveyQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,minValue: freezed == minValue ? _self.minValue : minValue // ignore: cast_nullable_to_non_nullable
as int?,maxValue: freezed == maxValue ? _self.maxValue : maxValue // ignore: cast_nullable_to_non_nullable
as int?,placeholder: freezed == placeholder ? _self.placeholder : placeholder // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
