// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_opportunity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BranchRuleModel {
  String get optionValue => throw _privateConstructorUsedError;
  String get goToQuestionId => throw _privateConstructorUsedError;

  /// Create a copy of BranchRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchRuleModelCopyWith<BranchRuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchRuleModelCopyWith<$Res> {
  factory $BranchRuleModelCopyWith(
    BranchRuleModel value,
    $Res Function(BranchRuleModel) then,
  ) = _$BranchRuleModelCopyWithImpl<$Res, BranchRuleModel>;
  @useResult
  $Res call({String optionValue, String goToQuestionId});
}

/// @nodoc
class _$BranchRuleModelCopyWithImpl<$Res, $Val extends BranchRuleModel>
    implements $BranchRuleModelCopyWith<$Res> {
  _$BranchRuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BranchRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? optionValue = null, Object? goToQuestionId = null}) {
    return _then(
      _value.copyWith(
            optionValue: null == optionValue
                ? _value.optionValue
                : optionValue // ignore: cast_nullable_to_non_nullable
                      as String,
            goToQuestionId: null == goToQuestionId
                ? _value.goToQuestionId
                : goToQuestionId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BranchRuleModelImplCopyWith<$Res>
    implements $BranchRuleModelCopyWith<$Res> {
  factory _$$BranchRuleModelImplCopyWith(
    _$BranchRuleModelImpl value,
    $Res Function(_$BranchRuleModelImpl) then,
  ) = __$$BranchRuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String optionValue, String goToQuestionId});
}

/// @nodoc
class __$$BranchRuleModelImplCopyWithImpl<$Res>
    extends _$BranchRuleModelCopyWithImpl<$Res, _$BranchRuleModelImpl>
    implements _$$BranchRuleModelImplCopyWith<$Res> {
  __$$BranchRuleModelImplCopyWithImpl(
    _$BranchRuleModelImpl _value,
    $Res Function(_$BranchRuleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BranchRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? optionValue = null, Object? goToQuestionId = null}) {
    return _then(
      _$BranchRuleModelImpl(
        optionValue: null == optionValue
            ? _value.optionValue
            : optionValue // ignore: cast_nullable_to_non_nullable
                  as String,
        goToQuestionId: null == goToQuestionId
            ? _value.goToQuestionId
            : goToQuestionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BranchRuleModelImpl extends _BranchRuleModel {
  const _$BranchRuleModelImpl({
    required this.optionValue,
    required this.goToQuestionId,
  }) : super._();

  @override
  final String optionValue;
  @override
  final String goToQuestionId;

  @override
  String toString() {
    return 'BranchRuleModel(optionValue: $optionValue, goToQuestionId: $goToQuestionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchRuleModelImpl &&
            (identical(other.optionValue, optionValue) ||
                other.optionValue == optionValue) &&
            (identical(other.goToQuestionId, goToQuestionId) ||
                other.goToQuestionId == goToQuestionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, optionValue, goToQuestionId);

  /// Create a copy of BranchRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchRuleModelImplCopyWith<_$BranchRuleModelImpl> get copyWith =>
      __$$BranchRuleModelImplCopyWithImpl<_$BranchRuleModelImpl>(
        this,
        _$identity,
      );
}

abstract class _BranchRuleModel extends BranchRuleModel {
  const factory _BranchRuleModel({
    required final String optionValue,
    required final String goToQuestionId,
  }) = _$BranchRuleModelImpl;
  const _BranchRuleModel._() : super._();

  @override
  String get optionValue;
  @override
  String get goToQuestionId;

  /// Create a copy of BranchRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchRuleModelImplCopyWith<_$BranchRuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SurveyQuestionModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  bool get isRequired =>
      throw _privateConstructorUsedError; // single_select + multi_select
  List<String> get options => throw _privateConstructorUsedError;
  int? get maxSelections => throw _privateConstructorUsedError; // text_input
  int get textInputCount => throw _privateConstructorUsedError;
  int get textMaxLength => throw _privateConstructorUsedError; // likert
  int get likertScale => throw _privateConstructorUsedError;
  String? get likertLowLabel => throw _privateConstructorUsedError;
  String? get likertHighLabel =>
      throw _privateConstructorUsedError; // star_tags
  int get maxStars => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  int? get maxTags => throw _privateConstructorUsedError; // slider
  int get sliderMin => throw _privateConstructorUsedError;
  int get sliderMax => throw _privateConstructorUsedError;
  int get sliderStep => throw _privateConstructorUsedError;
  String? get sliderMinLabel => throw _privateConstructorUsedError;
  String? get sliderMaxLabel =>
      throw _privateConstructorUsedError; // attention check
  bool get isAttentionCheck => throw _privateConstructorUsedError;
  String? get correctAnswer => throw _privateConstructorUsedError; // branching
  List<BranchRuleModel> get branchRules => throw _privateConstructorUsedError;

  /// Create a copy of SurveyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyQuestionModelCopyWith<SurveyQuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyQuestionModelCopyWith<$Res> {
  factory $SurveyQuestionModelCopyWith(
    SurveyQuestionModel value,
    $Res Function(SurveyQuestionModel) then,
  ) = _$SurveyQuestionModelCopyWithImpl<$Res, SurveyQuestionModel>;
  @useResult
  $Res call({
    String id,
    String text,
    int orderIndex,
    String questionType,
    bool isRequired,
    List<String> options,
    int? maxSelections,
    int textInputCount,
    int textMaxLength,
    int likertScale,
    String? likertLowLabel,
    String? likertHighLabel,
    int maxStars,
    List<String> tags,
    int? maxTags,
    int sliderMin,
    int sliderMax,
    int sliderStep,
    String? sliderMinLabel,
    String? sliderMaxLabel,
    bool isAttentionCheck,
    String? correctAnswer,
    List<BranchRuleModel> branchRules,
  });
}

/// @nodoc
class _$SurveyQuestionModelCopyWithImpl<$Res, $Val extends SurveyQuestionModel>
    implements $SurveyQuestionModelCopyWith<$Res> {
  _$SurveyQuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? orderIndex = null,
    Object? questionType = null,
    Object? isRequired = null,
    Object? options = null,
    Object? maxSelections = freezed,
    Object? textInputCount = null,
    Object? textMaxLength = null,
    Object? likertScale = null,
    Object? likertLowLabel = freezed,
    Object? likertHighLabel = freezed,
    Object? maxStars = null,
    Object? tags = null,
    Object? maxTags = freezed,
    Object? sliderMin = null,
    Object? sliderMax = null,
    Object? sliderStep = null,
    Object? sliderMinLabel = freezed,
    Object? sliderMaxLabel = freezed,
    Object? isAttentionCheck = null,
    Object? correctAnswer = freezed,
    Object? branchRules = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            questionType: null == questionType
                ? _value.questionType
                : questionType // ignore: cast_nullable_to_non_nullable
                      as String,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            maxSelections: freezed == maxSelections
                ? _value.maxSelections
                : maxSelections // ignore: cast_nullable_to_non_nullable
                      as int?,
            textInputCount: null == textInputCount
                ? _value.textInputCount
                : textInputCount // ignore: cast_nullable_to_non_nullable
                      as int,
            textMaxLength: null == textMaxLength
                ? _value.textMaxLength
                : textMaxLength // ignore: cast_nullable_to_non_nullable
                      as int,
            likertScale: null == likertScale
                ? _value.likertScale
                : likertScale // ignore: cast_nullable_to_non_nullable
                      as int,
            likertLowLabel: freezed == likertLowLabel
                ? _value.likertLowLabel
                : likertLowLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            likertHighLabel: freezed == likertHighLabel
                ? _value.likertHighLabel
                : likertHighLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxStars: null == maxStars
                ? _value.maxStars
                : maxStars // ignore: cast_nullable_to_non_nullable
                      as int,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            maxTags: freezed == maxTags
                ? _value.maxTags
                : maxTags // ignore: cast_nullable_to_non_nullable
                      as int?,
            sliderMin: null == sliderMin
                ? _value.sliderMin
                : sliderMin // ignore: cast_nullable_to_non_nullable
                      as int,
            sliderMax: null == sliderMax
                ? _value.sliderMax
                : sliderMax // ignore: cast_nullable_to_non_nullable
                      as int,
            sliderStep: null == sliderStep
                ? _value.sliderStep
                : sliderStep // ignore: cast_nullable_to_non_nullable
                      as int,
            sliderMinLabel: freezed == sliderMinLabel
                ? _value.sliderMinLabel
                : sliderMinLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            sliderMaxLabel: freezed == sliderMaxLabel
                ? _value.sliderMaxLabel
                : sliderMaxLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAttentionCheck: null == isAttentionCheck
                ? _value.isAttentionCheck
                : isAttentionCheck // ignore: cast_nullable_to_non_nullable
                      as bool,
            correctAnswer: freezed == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as String?,
            branchRules: null == branchRules
                ? _value.branchRules
                : branchRules // ignore: cast_nullable_to_non_nullable
                      as List<BranchRuleModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyQuestionModelImplCopyWith<$Res>
    implements $SurveyQuestionModelCopyWith<$Res> {
  factory _$$SurveyQuestionModelImplCopyWith(
    _$SurveyQuestionModelImpl value,
    $Res Function(_$SurveyQuestionModelImpl) then,
  ) = __$$SurveyQuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    int orderIndex,
    String questionType,
    bool isRequired,
    List<String> options,
    int? maxSelections,
    int textInputCount,
    int textMaxLength,
    int likertScale,
    String? likertLowLabel,
    String? likertHighLabel,
    int maxStars,
    List<String> tags,
    int? maxTags,
    int sliderMin,
    int sliderMax,
    int sliderStep,
    String? sliderMinLabel,
    String? sliderMaxLabel,
    bool isAttentionCheck,
    String? correctAnswer,
    List<BranchRuleModel> branchRules,
  });
}

/// @nodoc
class __$$SurveyQuestionModelImplCopyWithImpl<$Res>
    extends _$SurveyQuestionModelCopyWithImpl<$Res, _$SurveyQuestionModelImpl>
    implements _$$SurveyQuestionModelImplCopyWith<$Res> {
  __$$SurveyQuestionModelImplCopyWithImpl(
    _$SurveyQuestionModelImpl _value,
    $Res Function(_$SurveyQuestionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? orderIndex = null,
    Object? questionType = null,
    Object? isRequired = null,
    Object? options = null,
    Object? maxSelections = freezed,
    Object? textInputCount = null,
    Object? textMaxLength = null,
    Object? likertScale = null,
    Object? likertLowLabel = freezed,
    Object? likertHighLabel = freezed,
    Object? maxStars = null,
    Object? tags = null,
    Object? maxTags = freezed,
    Object? sliderMin = null,
    Object? sliderMax = null,
    Object? sliderStep = null,
    Object? sliderMinLabel = freezed,
    Object? sliderMaxLabel = freezed,
    Object? isAttentionCheck = null,
    Object? correctAnswer = freezed,
    Object? branchRules = null,
  }) {
    return _then(
      _$SurveyQuestionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        questionType: null == questionType
            ? _value.questionType
            : questionType // ignore: cast_nullable_to_non_nullable
                  as String,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        maxSelections: freezed == maxSelections
            ? _value.maxSelections
            : maxSelections // ignore: cast_nullable_to_non_nullable
                  as int?,
        textInputCount: null == textInputCount
            ? _value.textInputCount
            : textInputCount // ignore: cast_nullable_to_non_nullable
                  as int,
        textMaxLength: null == textMaxLength
            ? _value.textMaxLength
            : textMaxLength // ignore: cast_nullable_to_non_nullable
                  as int,
        likertScale: null == likertScale
            ? _value.likertScale
            : likertScale // ignore: cast_nullable_to_non_nullable
                  as int,
        likertLowLabel: freezed == likertLowLabel
            ? _value.likertLowLabel
            : likertLowLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        likertHighLabel: freezed == likertHighLabel
            ? _value.likertHighLabel
            : likertHighLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxStars: null == maxStars
            ? _value.maxStars
            : maxStars // ignore: cast_nullable_to_non_nullable
                  as int,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        maxTags: freezed == maxTags
            ? _value.maxTags
            : maxTags // ignore: cast_nullable_to_non_nullable
                  as int?,
        sliderMin: null == sliderMin
            ? _value.sliderMin
            : sliderMin // ignore: cast_nullable_to_non_nullable
                  as int,
        sliderMax: null == sliderMax
            ? _value.sliderMax
            : sliderMax // ignore: cast_nullable_to_non_nullable
                  as int,
        sliderStep: null == sliderStep
            ? _value.sliderStep
            : sliderStep // ignore: cast_nullable_to_non_nullable
                  as int,
        sliderMinLabel: freezed == sliderMinLabel
            ? _value.sliderMinLabel
            : sliderMinLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        sliderMaxLabel: freezed == sliderMaxLabel
            ? _value.sliderMaxLabel
            : sliderMaxLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAttentionCheck: null == isAttentionCheck
            ? _value.isAttentionCheck
            : isAttentionCheck // ignore: cast_nullable_to_non_nullable
                  as bool,
        correctAnswer: freezed == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as String?,
        branchRules: null == branchRules
            ? _value._branchRules
            : branchRules // ignore: cast_nullable_to_non_nullable
                  as List<BranchRuleModel>,
      ),
    );
  }
}

/// @nodoc

class _$SurveyQuestionModelImpl extends _SurveyQuestionModel {
  const _$SurveyQuestionModelImpl({
    required this.id,
    required this.text,
    required this.orderIndex,
    required this.questionType,
    this.isRequired = true,
    final List<String> options = const [],
    this.maxSelections,
    this.textInputCount = 1,
    this.textMaxLength = 50,
    this.likertScale = 5,
    this.likertLowLabel,
    this.likertHighLabel,
    this.maxStars = 5,
    final List<String> tags = const [],
    this.maxTags,
    this.sliderMin = 0,
    this.sliderMax = 100,
    this.sliderStep = 1,
    this.sliderMinLabel,
    this.sliderMaxLabel,
    this.isAttentionCheck = false,
    this.correctAnswer,
    final List<BranchRuleModel> branchRules = const [],
  }) : _options = options,
       _tags = tags,
       _branchRules = branchRules,
       super._();

  @override
  final String id;
  @override
  final String text;
  @override
  final int orderIndex;
  @override
  final String questionType;
  @override
  @JsonKey()
  final bool isRequired;
  // single_select + multi_select
  final List<String> _options;
  // single_select + multi_select
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int? maxSelections;
  // text_input
  @override
  @JsonKey()
  final int textInputCount;
  @override
  @JsonKey()
  final int textMaxLength;
  // likert
  @override
  @JsonKey()
  final int likertScale;
  @override
  final String? likertLowLabel;
  @override
  final String? likertHighLabel;
  // star_tags
  @override
  @JsonKey()
  final int maxStars;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final int? maxTags;
  // slider
  @override
  @JsonKey()
  final int sliderMin;
  @override
  @JsonKey()
  final int sliderMax;
  @override
  @JsonKey()
  final int sliderStep;
  @override
  final String? sliderMinLabel;
  @override
  final String? sliderMaxLabel;
  // attention check
  @override
  @JsonKey()
  final bool isAttentionCheck;
  @override
  final String? correctAnswer;
  // branching
  final List<BranchRuleModel> _branchRules;
  // branching
  @override
  @JsonKey()
  List<BranchRuleModel> get branchRules {
    if (_branchRules is EqualUnmodifiableListView) return _branchRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branchRules);
  }

  @override
  String toString() {
    return 'SurveyQuestionModel(id: $id, text: $text, orderIndex: $orderIndex, questionType: $questionType, isRequired: $isRequired, options: $options, maxSelections: $maxSelections, textInputCount: $textInputCount, textMaxLength: $textMaxLength, likertScale: $likertScale, likertLowLabel: $likertLowLabel, likertHighLabel: $likertHighLabel, maxStars: $maxStars, tags: $tags, maxTags: $maxTags, sliderMin: $sliderMin, sliderMax: $sliderMax, sliderStep: $sliderStep, sliderMinLabel: $sliderMinLabel, sliderMaxLabel: $sliderMaxLabel, isAttentionCheck: $isAttentionCheck, correctAnswer: $correctAnswer, branchRules: $branchRules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyQuestionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.maxSelections, maxSelections) ||
                other.maxSelections == maxSelections) &&
            (identical(other.textInputCount, textInputCount) ||
                other.textInputCount == textInputCount) &&
            (identical(other.textMaxLength, textMaxLength) ||
                other.textMaxLength == textMaxLength) &&
            (identical(other.likertScale, likertScale) ||
                other.likertScale == likertScale) &&
            (identical(other.likertLowLabel, likertLowLabel) ||
                other.likertLowLabel == likertLowLabel) &&
            (identical(other.likertHighLabel, likertHighLabel) ||
                other.likertHighLabel == likertHighLabel) &&
            (identical(other.maxStars, maxStars) ||
                other.maxStars == maxStars) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.maxTags, maxTags) || other.maxTags == maxTags) &&
            (identical(other.sliderMin, sliderMin) ||
                other.sliderMin == sliderMin) &&
            (identical(other.sliderMax, sliderMax) ||
                other.sliderMax == sliderMax) &&
            (identical(other.sliderStep, sliderStep) ||
                other.sliderStep == sliderStep) &&
            (identical(other.sliderMinLabel, sliderMinLabel) ||
                other.sliderMinLabel == sliderMinLabel) &&
            (identical(other.sliderMaxLabel, sliderMaxLabel) ||
                other.sliderMaxLabel == sliderMaxLabel) &&
            (identical(other.isAttentionCheck, isAttentionCheck) ||
                other.isAttentionCheck == isAttentionCheck) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            const DeepCollectionEquality().equals(
              other._branchRules,
              _branchRules,
            ));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    text,
    orderIndex,
    questionType,
    isRequired,
    const DeepCollectionEquality().hash(_options),
    maxSelections,
    textInputCount,
    textMaxLength,
    likertScale,
    likertLowLabel,
    likertHighLabel,
    maxStars,
    const DeepCollectionEquality().hash(_tags),
    maxTags,
    sliderMin,
    sliderMax,
    sliderStep,
    sliderMinLabel,
    sliderMaxLabel,
    isAttentionCheck,
    correctAnswer,
    const DeepCollectionEquality().hash(_branchRules),
  ]);

  /// Create a copy of SurveyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyQuestionModelImplCopyWith<_$SurveyQuestionModelImpl> get copyWith =>
      __$$SurveyQuestionModelImplCopyWithImpl<_$SurveyQuestionModelImpl>(
        this,
        _$identity,
      );
}

abstract class _SurveyQuestionModel extends SurveyQuestionModel {
  const factory _SurveyQuestionModel({
    required final String id,
    required final String text,
    required final int orderIndex,
    required final String questionType,
    final bool isRequired,
    final List<String> options,
    final int? maxSelections,
    final int textInputCount,
    final int textMaxLength,
    final int likertScale,
    final String? likertLowLabel,
    final String? likertHighLabel,
    final int maxStars,
    final List<String> tags,
    final int? maxTags,
    final int sliderMin,
    final int sliderMax,
    final int sliderStep,
    final String? sliderMinLabel,
    final String? sliderMaxLabel,
    final bool isAttentionCheck,
    final String? correctAnswer,
    final List<BranchRuleModel> branchRules,
  }) = _$SurveyQuestionModelImpl;
  const _SurveyQuestionModel._() : super._();

  @override
  String get id;
  @override
  String get text;
  @override
  int get orderIndex;
  @override
  String get questionType;
  @override
  bool get isRequired; // single_select + multi_select
  @override
  List<String> get options;
  @override
  int? get maxSelections; // text_input
  @override
  int get textInputCount;
  @override
  int get textMaxLength; // likert
  @override
  int get likertScale;
  @override
  String? get likertLowLabel;
  @override
  String? get likertHighLabel; // star_tags
  @override
  int get maxStars;
  @override
  List<String> get tags;
  @override
  int? get maxTags; // slider
  @override
  int get sliderMin;
  @override
  int get sliderMax;
  @override
  int get sliderStep;
  @override
  String? get sliderMinLabel;
  @override
  String? get sliderMaxLabel; // attention check
  @override
  bool get isAttentionCheck;
  @override
  String? get correctAnswer; // branching
  @override
  List<BranchRuleModel> get branchRules;

  /// Create a copy of SurveyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyQuestionModelImplCopyWith<_$SurveyQuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EarnOpportunityModel {
  String get id => throw _privateConstructorUsedError;
  String get threadId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Earning configuration
  String get earningType => throw _privateConstructorUsedError;
  int get tokenReward => throw _privateConstructorUsedError;
  int get streakPoints => throw _privateConstructorUsedError;
  String get mediaType => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;
  List<SurveyQuestionModel> get questions => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  bool get isActive =>
      throw _privateConstructorUsedError; // Denormalized client info
  String? get clientId => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get clientAvatarColor => throw _privateConstructorUsedError;
  String? get clientAvatarImage => throw _privateConstructorUsedError;
  String? get threadImage => throw _privateConstructorUsedError;
  String? get opportunityImage =>
      throw _privateConstructorUsedError; // Legacy campaign reference
  String? get campaignId =>
      throw _privateConstructorUsedError; // Targeting (stored as JSON map)
  Map<String, dynamic>? get targeting =>
      throw _privateConstructorUsedError; // Bonus reward configuration
  bool get bonusReward => throw _privateConstructorUsedError;
  double get bonusRewardMultiplier => throw _privateConstructorUsedError;
  String? get bonusIntervalType => throw _privateConstructorUsedError;
  int? get bonusIntervalX =>
      throw _privateConstructorUsedError; // User engagement status (populated by getEligibleOpportunities)
  String? get userEngagementStatus => throw _privateConstructorUsedError;
  String? get userEngagementId =>
      throw _privateConstructorUsedError; // AdMob configuration
  String? get adUnitId => throw _privateConstructorUsedError;
  int get dailyLimitPerUser =>
      throw _privateConstructorUsedError; // Budget cap fields
  bool get budgetExhausted => throw _privateConstructorUsedError;
  int? get tokenBudget => throw _privateConstructorUsedError;
  int get tokenSpent => throw _privateConstructorUsedError; // Poll link
  String? get pollId =>
      throw _privateConstructorUsedError; // Upload configuration
  String? get uploadPrompt => throw _privateConstructorUsedError;
  String? get uploadContextMediaUrl => throw _privateConstructorUsedError;
  String? get uploadContextMediaType => throw _privateConstructorUsedError;
  bool get uploadVideoEnabled => throw _privateConstructorUsedError;
  bool get uploadImageEnabled => throw _privateConstructorUsedError;
  bool get uploadTextEnabled => throw _privateConstructorUsedError;
  bool get uploadVideoRequired => throw _privateConstructorUsedError;
  bool get uploadImageRequired => throw _privateConstructorUsedError;
  bool get uploadTextRequired => throw _privateConstructorUsedError;
  int get uploadVideoMaxSeconds => throw _privateConstructorUsedError;
  int get uploadTextMinChars => throw _privateConstructorUsedError;
  int get uploadTextMaxChars => throw _privateConstructorUsedError;
  bool get requiresAdminReview =>
      throw _privateConstructorUsedError; // Reward campaign linkage
  String? get rewardCampaignId => throw _privateConstructorUsedError;
  String? get rewardCampaignName => throw _privateConstructorUsedError;
  String? get rewardType => throw _privateConstructorUsedError;

  /// Create a copy of EarnOpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnOpportunityModelCopyWith<EarnOpportunityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnOpportunityModelCopyWith<$Res> {
  factory $EarnOpportunityModelCopyWith(
    EarnOpportunityModel value,
    $Res Function(EarnOpportunityModel) then,
  ) = _$EarnOpportunityModelCopyWithImpl<$Res, EarnOpportunityModel>;
  @useResult
  $Res call({
    String id,
    String threadId,
    String title,
    String? description,
    String earningType,
    int tokenReward,
    int streakPoints,
    String mediaType,
    String? mediaUrl,
    List<SurveyQuestionModel> questions,
    int durationSeconds,
    DateTime? expiresAt,
    bool isActive,
    String? clientId,
    String? clientName,
    String? clientAvatarColor,
    String? clientAvatarImage,
    String? threadImage,
    String? opportunityImage,
    String? campaignId,
    Map<String, dynamic>? targeting,
    bool bonusReward,
    double bonusRewardMultiplier,
    String? bonusIntervalType,
    int? bonusIntervalX,
    String? userEngagementStatus,
    String? userEngagementId,
    String? adUnitId,
    int dailyLimitPerUser,
    bool budgetExhausted,
    int? tokenBudget,
    int tokenSpent,
    String? pollId,
    String? uploadPrompt,
    String? uploadContextMediaUrl,
    String? uploadContextMediaType,
    bool uploadVideoEnabled,
    bool uploadImageEnabled,
    bool uploadTextEnabled,
    bool uploadVideoRequired,
    bool uploadImageRequired,
    bool uploadTextRequired,
    int uploadVideoMaxSeconds,
    int uploadTextMinChars,
    int uploadTextMaxChars,
    bool requiresAdminReview,
    String? rewardCampaignId,
    String? rewardCampaignName,
    String? rewardType,
  });
}

/// @nodoc
class _$EarnOpportunityModelCopyWithImpl<
  $Res,
  $Val extends EarnOpportunityModel
>
    implements $EarnOpportunityModelCopyWith<$Res> {
  _$EarnOpportunityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnOpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? title = null,
    Object? description = freezed,
    Object? earningType = null,
    Object? tokenReward = null,
    Object? streakPoints = null,
    Object? mediaType = null,
    Object? mediaUrl = freezed,
    Object? questions = null,
    Object? durationSeconds = null,
    Object? expiresAt = freezed,
    Object? isActive = null,
    Object? clientId = freezed,
    Object? clientName = freezed,
    Object? clientAvatarColor = freezed,
    Object? clientAvatarImage = freezed,
    Object? threadImage = freezed,
    Object? opportunityImage = freezed,
    Object? campaignId = freezed,
    Object? targeting = freezed,
    Object? bonusReward = null,
    Object? bonusRewardMultiplier = null,
    Object? bonusIntervalType = freezed,
    Object? bonusIntervalX = freezed,
    Object? userEngagementStatus = freezed,
    Object? userEngagementId = freezed,
    Object? adUnitId = freezed,
    Object? dailyLimitPerUser = null,
    Object? budgetExhausted = null,
    Object? tokenBudget = freezed,
    Object? tokenSpent = null,
    Object? pollId = freezed,
    Object? uploadPrompt = freezed,
    Object? uploadContextMediaUrl = freezed,
    Object? uploadContextMediaType = freezed,
    Object? uploadVideoEnabled = null,
    Object? uploadImageEnabled = null,
    Object? uploadTextEnabled = null,
    Object? uploadVideoRequired = null,
    Object? uploadImageRequired = null,
    Object? uploadTextRequired = null,
    Object? uploadVideoMaxSeconds = null,
    Object? uploadTextMinChars = null,
    Object? uploadTextMaxChars = null,
    Object? requiresAdminReview = null,
    Object? rewardCampaignId = freezed,
    Object? rewardCampaignName = freezed,
    Object? rewardType = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            threadId: null == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            earningType: null == earningType
                ? _value.earningType
                : earningType // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenReward: null == tokenReward
                ? _value.tokenReward
                : tokenReward // ignore: cast_nullable_to_non_nullable
                      as int,
            streakPoints: null == streakPoints
                ? _value.streakPoints
                : streakPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            mediaType: null == mediaType
                ? _value.mediaType
                : mediaType // ignore: cast_nullable_to_non_nullable
                      as String,
            mediaUrl: freezed == mediaUrl
                ? _value.mediaUrl
                : mediaUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<SurveyQuestionModel>,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            clientId: freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientName: freezed == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientAvatarColor: freezed == clientAvatarColor
                ? _value.clientAvatarColor
                : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientAvatarImage: freezed == clientAvatarImage
                ? _value.clientAvatarImage
                : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            threadImage: freezed == threadImage
                ? _value.threadImage
                : threadImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            opportunityImage: freezed == opportunityImage
                ? _value.opportunityImage
                : opportunityImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            campaignId: freezed == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String?,
            targeting: freezed == targeting
                ? _value.targeting
                : targeting // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            bonusReward: null == bonusReward
                ? _value.bonusReward
                : bonusReward // ignore: cast_nullable_to_non_nullable
                      as bool,
            bonusRewardMultiplier: null == bonusRewardMultiplier
                ? _value.bonusRewardMultiplier
                : bonusRewardMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            bonusIntervalType: freezed == bonusIntervalType
                ? _value.bonusIntervalType
                : bonusIntervalType // ignore: cast_nullable_to_non_nullable
                      as String?,
            bonusIntervalX: freezed == bonusIntervalX
                ? _value.bonusIntervalX
                : bonusIntervalX // ignore: cast_nullable_to_non_nullable
                      as int?,
            userEngagementStatus: freezed == userEngagementStatus
                ? _value.userEngagementStatus
                : userEngagementStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            userEngagementId: freezed == userEngagementId
                ? _value.userEngagementId
                : userEngagementId // ignore: cast_nullable_to_non_nullable
                      as String?,
            adUnitId: freezed == adUnitId
                ? _value.adUnitId
                : adUnitId // ignore: cast_nullable_to_non_nullable
                      as String?,
            dailyLimitPerUser: null == dailyLimitPerUser
                ? _value.dailyLimitPerUser
                : dailyLimitPerUser // ignore: cast_nullable_to_non_nullable
                      as int,
            budgetExhausted: null == budgetExhausted
                ? _value.budgetExhausted
                : budgetExhausted // ignore: cast_nullable_to_non_nullable
                      as bool,
            tokenBudget: freezed == tokenBudget
                ? _value.tokenBudget
                : tokenBudget // ignore: cast_nullable_to_non_nullable
                      as int?,
            tokenSpent: null == tokenSpent
                ? _value.tokenSpent
                : tokenSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            pollId: freezed == pollId
                ? _value.pollId
                : pollId // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadPrompt: freezed == uploadPrompt
                ? _value.uploadPrompt
                : uploadPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadContextMediaUrl: freezed == uploadContextMediaUrl
                ? _value.uploadContextMediaUrl
                : uploadContextMediaUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadContextMediaType: freezed == uploadContextMediaType
                ? _value.uploadContextMediaType
                : uploadContextMediaType // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadVideoEnabled: null == uploadVideoEnabled
                ? _value.uploadVideoEnabled
                : uploadVideoEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadImageEnabled: null == uploadImageEnabled
                ? _value.uploadImageEnabled
                : uploadImageEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadTextEnabled: null == uploadTextEnabled
                ? _value.uploadTextEnabled
                : uploadTextEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadVideoRequired: null == uploadVideoRequired
                ? _value.uploadVideoRequired
                : uploadVideoRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadImageRequired: null == uploadImageRequired
                ? _value.uploadImageRequired
                : uploadImageRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadTextRequired: null == uploadTextRequired
                ? _value.uploadTextRequired
                : uploadTextRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            uploadVideoMaxSeconds: null == uploadVideoMaxSeconds
                ? _value.uploadVideoMaxSeconds
                : uploadVideoMaxSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            uploadTextMinChars: null == uploadTextMinChars
                ? _value.uploadTextMinChars
                : uploadTextMinChars // ignore: cast_nullable_to_non_nullable
                      as int,
            uploadTextMaxChars: null == uploadTextMaxChars
                ? _value.uploadTextMaxChars
                : uploadTextMaxChars // ignore: cast_nullable_to_non_nullable
                      as int,
            requiresAdminReview: null == requiresAdminReview
                ? _value.requiresAdminReview
                : requiresAdminReview // ignore: cast_nullable_to_non_nullable
                      as bool,
            rewardCampaignId: freezed == rewardCampaignId
                ? _value.rewardCampaignId
                : rewardCampaignId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardCampaignName: freezed == rewardCampaignName
                ? _value.rewardCampaignName
                : rewardCampaignName // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardType: freezed == rewardType
                ? _value.rewardType
                : rewardType // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarnOpportunityModelImplCopyWith<$Res>
    implements $EarnOpportunityModelCopyWith<$Res> {
  factory _$$EarnOpportunityModelImplCopyWith(
    _$EarnOpportunityModelImpl value,
    $Res Function(_$EarnOpportunityModelImpl) then,
  ) = __$$EarnOpportunityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String threadId,
    String title,
    String? description,
    String earningType,
    int tokenReward,
    int streakPoints,
    String mediaType,
    String? mediaUrl,
    List<SurveyQuestionModel> questions,
    int durationSeconds,
    DateTime? expiresAt,
    bool isActive,
    String? clientId,
    String? clientName,
    String? clientAvatarColor,
    String? clientAvatarImage,
    String? threadImage,
    String? opportunityImage,
    String? campaignId,
    Map<String, dynamic>? targeting,
    bool bonusReward,
    double bonusRewardMultiplier,
    String? bonusIntervalType,
    int? bonusIntervalX,
    String? userEngagementStatus,
    String? userEngagementId,
    String? adUnitId,
    int dailyLimitPerUser,
    bool budgetExhausted,
    int? tokenBudget,
    int tokenSpent,
    String? pollId,
    String? uploadPrompt,
    String? uploadContextMediaUrl,
    String? uploadContextMediaType,
    bool uploadVideoEnabled,
    bool uploadImageEnabled,
    bool uploadTextEnabled,
    bool uploadVideoRequired,
    bool uploadImageRequired,
    bool uploadTextRequired,
    int uploadVideoMaxSeconds,
    int uploadTextMinChars,
    int uploadTextMaxChars,
    bool requiresAdminReview,
    String? rewardCampaignId,
    String? rewardCampaignName,
    String? rewardType,
  });
}

/// @nodoc
class __$$EarnOpportunityModelImplCopyWithImpl<$Res>
    extends _$EarnOpportunityModelCopyWithImpl<$Res, _$EarnOpportunityModelImpl>
    implements _$$EarnOpportunityModelImplCopyWith<$Res> {
  __$$EarnOpportunityModelImplCopyWithImpl(
    _$EarnOpportunityModelImpl _value,
    $Res Function(_$EarnOpportunityModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnOpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? title = null,
    Object? description = freezed,
    Object? earningType = null,
    Object? tokenReward = null,
    Object? streakPoints = null,
    Object? mediaType = null,
    Object? mediaUrl = freezed,
    Object? questions = null,
    Object? durationSeconds = null,
    Object? expiresAt = freezed,
    Object? isActive = null,
    Object? clientId = freezed,
    Object? clientName = freezed,
    Object? clientAvatarColor = freezed,
    Object? clientAvatarImage = freezed,
    Object? threadImage = freezed,
    Object? opportunityImage = freezed,
    Object? campaignId = freezed,
    Object? targeting = freezed,
    Object? bonusReward = null,
    Object? bonusRewardMultiplier = null,
    Object? bonusIntervalType = freezed,
    Object? bonusIntervalX = freezed,
    Object? userEngagementStatus = freezed,
    Object? userEngagementId = freezed,
    Object? adUnitId = freezed,
    Object? dailyLimitPerUser = null,
    Object? budgetExhausted = null,
    Object? tokenBudget = freezed,
    Object? tokenSpent = null,
    Object? pollId = freezed,
    Object? uploadPrompt = freezed,
    Object? uploadContextMediaUrl = freezed,
    Object? uploadContextMediaType = freezed,
    Object? uploadVideoEnabled = null,
    Object? uploadImageEnabled = null,
    Object? uploadTextEnabled = null,
    Object? uploadVideoRequired = null,
    Object? uploadImageRequired = null,
    Object? uploadTextRequired = null,
    Object? uploadVideoMaxSeconds = null,
    Object? uploadTextMinChars = null,
    Object? uploadTextMaxChars = null,
    Object? requiresAdminReview = null,
    Object? rewardCampaignId = freezed,
    Object? rewardCampaignName = freezed,
    Object? rewardType = freezed,
  }) {
    return _then(
      _$EarnOpportunityModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        earningType: null == earningType
            ? _value.earningType
            : earningType // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenReward: null == tokenReward
            ? _value.tokenReward
            : tokenReward // ignore: cast_nullable_to_non_nullable
                  as int,
        streakPoints: null == streakPoints
            ? _value.streakPoints
            : streakPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        mediaType: null == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaUrl: freezed == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<SurveyQuestionModel>,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientName: freezed == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientAvatarColor: freezed == clientAvatarColor
            ? _value.clientAvatarColor
            : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientAvatarImage: freezed == clientAvatarImage
            ? _value.clientAvatarImage
            : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        threadImage: freezed == threadImage
            ? _value.threadImage
            : threadImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        opportunityImage: freezed == opportunityImage
            ? _value.opportunityImage
            : opportunityImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        campaignId: freezed == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String?,
        targeting: freezed == targeting
            ? _value._targeting
            : targeting // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        bonusReward: null == bonusReward
            ? _value.bonusReward
            : bonusReward // ignore: cast_nullable_to_non_nullable
                  as bool,
        bonusRewardMultiplier: null == bonusRewardMultiplier
            ? _value.bonusRewardMultiplier
            : bonusRewardMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        bonusIntervalType: freezed == bonusIntervalType
            ? _value.bonusIntervalType
            : bonusIntervalType // ignore: cast_nullable_to_non_nullable
                  as String?,
        bonusIntervalX: freezed == bonusIntervalX
            ? _value.bonusIntervalX
            : bonusIntervalX // ignore: cast_nullable_to_non_nullable
                  as int?,
        userEngagementStatus: freezed == userEngagementStatus
            ? _value.userEngagementStatus
            : userEngagementStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        userEngagementId: freezed == userEngagementId
            ? _value.userEngagementId
            : userEngagementId // ignore: cast_nullable_to_non_nullable
                  as String?,
        adUnitId: freezed == adUnitId
            ? _value.adUnitId
            : adUnitId // ignore: cast_nullable_to_non_nullable
                  as String?,
        dailyLimitPerUser: null == dailyLimitPerUser
            ? _value.dailyLimitPerUser
            : dailyLimitPerUser // ignore: cast_nullable_to_non_nullable
                  as int,
        budgetExhausted: null == budgetExhausted
            ? _value.budgetExhausted
            : budgetExhausted // ignore: cast_nullable_to_non_nullable
                  as bool,
        tokenBudget: freezed == tokenBudget
            ? _value.tokenBudget
            : tokenBudget // ignore: cast_nullable_to_non_nullable
                  as int?,
        tokenSpent: null == tokenSpent
            ? _value.tokenSpent
            : tokenSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        pollId: freezed == pollId
            ? _value.pollId
            : pollId // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadPrompt: freezed == uploadPrompt
            ? _value.uploadPrompt
            : uploadPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadContextMediaUrl: freezed == uploadContextMediaUrl
            ? _value.uploadContextMediaUrl
            : uploadContextMediaUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadContextMediaType: freezed == uploadContextMediaType
            ? _value.uploadContextMediaType
            : uploadContextMediaType // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadVideoEnabled: null == uploadVideoEnabled
            ? _value.uploadVideoEnabled
            : uploadVideoEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadImageEnabled: null == uploadImageEnabled
            ? _value.uploadImageEnabled
            : uploadImageEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadTextEnabled: null == uploadTextEnabled
            ? _value.uploadTextEnabled
            : uploadTextEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadVideoRequired: null == uploadVideoRequired
            ? _value.uploadVideoRequired
            : uploadVideoRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadImageRequired: null == uploadImageRequired
            ? _value.uploadImageRequired
            : uploadImageRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadTextRequired: null == uploadTextRequired
            ? _value.uploadTextRequired
            : uploadTextRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        uploadVideoMaxSeconds: null == uploadVideoMaxSeconds
            ? _value.uploadVideoMaxSeconds
            : uploadVideoMaxSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        uploadTextMinChars: null == uploadTextMinChars
            ? _value.uploadTextMinChars
            : uploadTextMinChars // ignore: cast_nullable_to_non_nullable
                  as int,
        uploadTextMaxChars: null == uploadTextMaxChars
            ? _value.uploadTextMaxChars
            : uploadTextMaxChars // ignore: cast_nullable_to_non_nullable
                  as int,
        requiresAdminReview: null == requiresAdminReview
            ? _value.requiresAdminReview
            : requiresAdminReview // ignore: cast_nullable_to_non_nullable
                  as bool,
        rewardCampaignId: freezed == rewardCampaignId
            ? _value.rewardCampaignId
            : rewardCampaignId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardCampaignName: freezed == rewardCampaignName
            ? _value.rewardCampaignName
            : rewardCampaignName // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardType: freezed == rewardType
            ? _value.rewardType
            : rewardType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$EarnOpportunityModelImpl extends _EarnOpportunityModel {
  const _$EarnOpportunityModelImpl({
    required this.id,
    required this.threadId,
    required this.title,
    this.description,
    required this.earningType,
    required this.tokenReward,
    this.streakPoints = 1,
    required this.mediaType,
    this.mediaUrl,
    required final List<SurveyQuestionModel> questions,
    required this.durationSeconds,
    this.expiresAt,
    required this.isActive,
    this.clientId,
    this.clientName,
    this.clientAvatarColor,
    this.clientAvatarImage,
    this.threadImage,
    this.opportunityImage,
    this.campaignId,
    final Map<String, dynamic>? targeting,
    this.bonusReward = false,
    this.bonusRewardMultiplier = 1.0,
    this.bonusIntervalType,
    this.bonusIntervalX,
    this.userEngagementStatus,
    this.userEngagementId,
    this.adUnitId,
    this.dailyLimitPerUser = 3,
    this.budgetExhausted = false,
    this.tokenBudget,
    this.tokenSpent = 0,
    this.pollId,
    this.uploadPrompt,
    this.uploadContextMediaUrl,
    this.uploadContextMediaType,
    this.uploadVideoEnabled = false,
    this.uploadImageEnabled = false,
    this.uploadTextEnabled = false,
    this.uploadVideoRequired = false,
    this.uploadImageRequired = false,
    this.uploadTextRequired = false,
    this.uploadVideoMaxSeconds = 60,
    this.uploadTextMinChars = 10,
    this.uploadTextMaxChars = 1500,
    this.requiresAdminReview = false,
    this.rewardCampaignId,
    this.rewardCampaignName,
    this.rewardType,
  }) : _questions = questions,
       _targeting = targeting,
       super._();

  @override
  final String id;
  @override
  final String threadId;
  @override
  final String title;
  @override
  final String? description;
  // Earning configuration
  @override
  final String earningType;
  @override
  final int tokenReward;
  @override
  @JsonKey()
  final int streakPoints;
  @override
  final String mediaType;
  @override
  final String? mediaUrl;
  final List<SurveyQuestionModel> _questions;
  @override
  List<SurveyQuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final int durationSeconds;
  @override
  final DateTime? expiresAt;
  @override
  final bool isActive;
  // Denormalized client info
  @override
  final String? clientId;
  @override
  final String? clientName;
  @override
  final String? clientAvatarColor;
  @override
  final String? clientAvatarImage;
  @override
  final String? threadImage;
  @override
  final String? opportunityImage;
  // Legacy campaign reference
  @override
  final String? campaignId;
  // Targeting (stored as JSON map)
  final Map<String, dynamic>? _targeting;
  // Targeting (stored as JSON map)
  @override
  Map<String, dynamic>? get targeting {
    final value = _targeting;
    if (value == null) return null;
    if (_targeting is EqualUnmodifiableMapView) return _targeting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Bonus reward configuration
  @override
  @JsonKey()
  final bool bonusReward;
  @override
  @JsonKey()
  final double bonusRewardMultiplier;
  @override
  final String? bonusIntervalType;
  @override
  final int? bonusIntervalX;
  // User engagement status (populated by getEligibleOpportunities)
  @override
  final String? userEngagementStatus;
  @override
  final String? userEngagementId;
  // AdMob configuration
  @override
  final String? adUnitId;
  @override
  @JsonKey()
  final int dailyLimitPerUser;
  // Budget cap fields
  @override
  @JsonKey()
  final bool budgetExhausted;
  @override
  final int? tokenBudget;
  @override
  @JsonKey()
  final int tokenSpent;
  // Poll link
  @override
  final String? pollId;
  // Upload configuration
  @override
  final String? uploadPrompt;
  @override
  final String? uploadContextMediaUrl;
  @override
  final String? uploadContextMediaType;
  @override
  @JsonKey()
  final bool uploadVideoEnabled;
  @override
  @JsonKey()
  final bool uploadImageEnabled;
  @override
  @JsonKey()
  final bool uploadTextEnabled;
  @override
  @JsonKey()
  final bool uploadVideoRequired;
  @override
  @JsonKey()
  final bool uploadImageRequired;
  @override
  @JsonKey()
  final bool uploadTextRequired;
  @override
  @JsonKey()
  final int uploadVideoMaxSeconds;
  @override
  @JsonKey()
  final int uploadTextMinChars;
  @override
  @JsonKey()
  final int uploadTextMaxChars;
  @override
  @JsonKey()
  final bool requiresAdminReview;
  // Reward campaign linkage
  @override
  final String? rewardCampaignId;
  @override
  final String? rewardCampaignName;
  @override
  final String? rewardType;

  @override
  String toString() {
    return 'EarnOpportunityModel(id: $id, threadId: $threadId, title: $title, description: $description, earningType: $earningType, tokenReward: $tokenReward, streakPoints: $streakPoints, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, clientId: $clientId, clientName: $clientName, clientAvatarColor: $clientAvatarColor, clientAvatarImage: $clientAvatarImage, threadImage: $threadImage, opportunityImage: $opportunityImage, campaignId: $campaignId, targeting: $targeting, bonusReward: $bonusReward, bonusRewardMultiplier: $bonusRewardMultiplier, bonusIntervalType: $bonusIntervalType, bonusIntervalX: $bonusIntervalX, userEngagementStatus: $userEngagementStatus, userEngagementId: $userEngagementId, adUnitId: $adUnitId, dailyLimitPerUser: $dailyLimitPerUser, budgetExhausted: $budgetExhausted, tokenBudget: $tokenBudget, tokenSpent: $tokenSpent, pollId: $pollId, uploadPrompt: $uploadPrompt, uploadContextMediaUrl: $uploadContextMediaUrl, uploadContextMediaType: $uploadContextMediaType, uploadVideoEnabled: $uploadVideoEnabled, uploadImageEnabled: $uploadImageEnabled, uploadTextEnabled: $uploadTextEnabled, uploadVideoRequired: $uploadVideoRequired, uploadImageRequired: $uploadImageRequired, uploadTextRequired: $uploadTextRequired, uploadVideoMaxSeconds: $uploadVideoMaxSeconds, uploadTextMinChars: $uploadTextMinChars, uploadTextMaxChars: $uploadTextMaxChars, requiresAdminReview: $requiresAdminReview, rewardCampaignId: $rewardCampaignId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnOpportunityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.earningType, earningType) ||
                other.earningType == earningType) &&
            (identical(other.tokenReward, tokenReward) ||
                other.tokenReward == tokenReward) &&
            (identical(other.streakPoints, streakPoints) ||
                other.streakPoints == streakPoints) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAvatarColor, clientAvatarColor) ||
                other.clientAvatarColor == clientAvatarColor) &&
            (identical(other.clientAvatarImage, clientAvatarImage) ||
                other.clientAvatarImage == clientAvatarImage) &&
            (identical(other.threadImage, threadImage) ||
                other.threadImage == threadImage) &&
            (identical(other.opportunityImage, opportunityImage) ||
                other.opportunityImage == opportunityImage) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            const DeepCollectionEquality().equals(
              other._targeting,
              _targeting,
            ) &&
            (identical(other.bonusReward, bonusReward) ||
                other.bonusReward == bonusReward) &&
            (identical(other.bonusRewardMultiplier, bonusRewardMultiplier) ||
                other.bonusRewardMultiplier == bonusRewardMultiplier) &&
            (identical(other.bonusIntervalType, bonusIntervalType) ||
                other.bonusIntervalType == bonusIntervalType) &&
            (identical(other.bonusIntervalX, bonusIntervalX) ||
                other.bonusIntervalX == bonusIntervalX) &&
            (identical(other.userEngagementStatus, userEngagementStatus) ||
                other.userEngagementStatus == userEngagementStatus) &&
            (identical(other.userEngagementId, userEngagementId) ||
                other.userEngagementId == userEngagementId) &&
            (identical(other.adUnitId, adUnitId) ||
                other.adUnitId == adUnitId) &&
            (identical(other.dailyLimitPerUser, dailyLimitPerUser) ||
                other.dailyLimitPerUser == dailyLimitPerUser) &&
            (identical(other.budgetExhausted, budgetExhausted) ||
                other.budgetExhausted == budgetExhausted) &&
            (identical(other.tokenBudget, tokenBudget) ||
                other.tokenBudget == tokenBudget) &&
            (identical(other.tokenSpent, tokenSpent) ||
                other.tokenSpent == tokenSpent) &&
            (identical(other.pollId, pollId) || other.pollId == pollId) &&
            (identical(other.uploadPrompt, uploadPrompt) ||
                other.uploadPrompt == uploadPrompt) &&
            (identical(other.uploadContextMediaUrl, uploadContextMediaUrl) ||
                other.uploadContextMediaUrl == uploadContextMediaUrl) &&
            (identical(other.uploadContextMediaType, uploadContextMediaType) ||
                other.uploadContextMediaType == uploadContextMediaType) &&
            (identical(other.uploadVideoEnabled, uploadVideoEnabled) ||
                other.uploadVideoEnabled == uploadVideoEnabled) &&
            (identical(other.uploadImageEnabled, uploadImageEnabled) ||
                other.uploadImageEnabled == uploadImageEnabled) &&
            (identical(other.uploadTextEnabled, uploadTextEnabled) ||
                other.uploadTextEnabled == uploadTextEnabled) &&
            (identical(other.uploadVideoRequired, uploadVideoRequired) ||
                other.uploadVideoRequired == uploadVideoRequired) &&
            (identical(other.uploadImageRequired, uploadImageRequired) ||
                other.uploadImageRequired == uploadImageRequired) &&
            (identical(other.uploadTextRequired, uploadTextRequired) ||
                other.uploadTextRequired == uploadTextRequired) &&
            (identical(other.uploadVideoMaxSeconds, uploadVideoMaxSeconds) ||
                other.uploadVideoMaxSeconds == uploadVideoMaxSeconds) &&
            (identical(other.uploadTextMinChars, uploadTextMinChars) ||
                other.uploadTextMinChars == uploadTextMinChars) &&
            (identical(other.uploadTextMaxChars, uploadTextMaxChars) ||
                other.uploadTextMaxChars == uploadTextMaxChars) &&
            (identical(other.requiresAdminReview, requiresAdminReview) ||
                other.requiresAdminReview == requiresAdminReview) &&
            (identical(other.rewardCampaignId, rewardCampaignId) ||
                other.rewardCampaignId == rewardCampaignId) &&
            (identical(other.rewardCampaignName, rewardCampaignName) ||
                other.rewardCampaignName == rewardCampaignName) &&
            (identical(other.rewardType, rewardType) ||
                other.rewardType == rewardType));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    threadId,
    title,
    description,
    earningType,
    tokenReward,
    streakPoints,
    mediaType,
    mediaUrl,
    const DeepCollectionEquality().hash(_questions),
    durationSeconds,
    expiresAt,
    isActive,
    clientId,
    clientName,
    clientAvatarColor,
    clientAvatarImage,
    threadImage,
    opportunityImage,
    campaignId,
    const DeepCollectionEquality().hash(_targeting),
    bonusReward,
    bonusRewardMultiplier,
    bonusIntervalType,
    bonusIntervalX,
    userEngagementStatus,
    userEngagementId,
    adUnitId,
    dailyLimitPerUser,
    budgetExhausted,
    tokenBudget,
    tokenSpent,
    pollId,
    uploadPrompt,
    uploadContextMediaUrl,
    uploadContextMediaType,
    uploadVideoEnabled,
    uploadImageEnabled,
    uploadTextEnabled,
    uploadVideoRequired,
    uploadImageRequired,
    uploadTextRequired,
    uploadVideoMaxSeconds,
    uploadTextMinChars,
    uploadTextMaxChars,
    requiresAdminReview,
    rewardCampaignId,
    rewardCampaignName,
    rewardType,
  ]);

  /// Create a copy of EarnOpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnOpportunityModelImplCopyWith<_$EarnOpportunityModelImpl>
  get copyWith =>
      __$$EarnOpportunityModelImplCopyWithImpl<_$EarnOpportunityModelImpl>(
        this,
        _$identity,
      );
}

abstract class _EarnOpportunityModel extends EarnOpportunityModel {
  const factory _EarnOpportunityModel({
    required final String id,
    required final String threadId,
    required final String title,
    final String? description,
    required final String earningType,
    required final int tokenReward,
    final int streakPoints,
    required final String mediaType,
    final String? mediaUrl,
    required final List<SurveyQuestionModel> questions,
    required final int durationSeconds,
    final DateTime? expiresAt,
    required final bool isActive,
    final String? clientId,
    final String? clientName,
    final String? clientAvatarColor,
    final String? clientAvatarImage,
    final String? threadImage,
    final String? opportunityImage,
    final String? campaignId,
    final Map<String, dynamic>? targeting,
    final bool bonusReward,
    final double bonusRewardMultiplier,
    final String? bonusIntervalType,
    final int? bonusIntervalX,
    final String? userEngagementStatus,
    final String? userEngagementId,
    final String? adUnitId,
    final int dailyLimitPerUser,
    final bool budgetExhausted,
    final int? tokenBudget,
    final int tokenSpent,
    final String? pollId,
    final String? uploadPrompt,
    final String? uploadContextMediaUrl,
    final String? uploadContextMediaType,
    final bool uploadVideoEnabled,
    final bool uploadImageEnabled,
    final bool uploadTextEnabled,
    final bool uploadVideoRequired,
    final bool uploadImageRequired,
    final bool uploadTextRequired,
    final int uploadVideoMaxSeconds,
    final int uploadTextMinChars,
    final int uploadTextMaxChars,
    final bool requiresAdminReview,
    final String? rewardCampaignId,
    final String? rewardCampaignName,
    final String? rewardType,
  }) = _$EarnOpportunityModelImpl;
  const _EarnOpportunityModel._() : super._();

  @override
  String get id;
  @override
  String get threadId;
  @override
  String get title;
  @override
  String? get description; // Earning configuration
  @override
  String get earningType;
  @override
  int get tokenReward;
  @override
  int get streakPoints;
  @override
  String get mediaType;
  @override
  String? get mediaUrl;
  @override
  List<SurveyQuestionModel> get questions;
  @override
  int get durationSeconds;
  @override
  DateTime? get expiresAt;
  @override
  bool get isActive; // Denormalized client info
  @override
  String? get clientId;
  @override
  String? get clientName;
  @override
  String? get clientAvatarColor;
  @override
  String? get clientAvatarImage;
  @override
  String? get threadImage;
  @override
  String? get opportunityImage; // Legacy campaign reference
  @override
  String? get campaignId; // Targeting (stored as JSON map)
  @override
  Map<String, dynamic>? get targeting; // Bonus reward configuration
  @override
  bool get bonusReward;
  @override
  double get bonusRewardMultiplier;
  @override
  String? get bonusIntervalType;
  @override
  int? get bonusIntervalX; // User engagement status (populated by getEligibleOpportunities)
  @override
  String? get userEngagementStatus;
  @override
  String? get userEngagementId; // AdMob configuration
  @override
  String? get adUnitId;
  @override
  int get dailyLimitPerUser; // Budget cap fields
  @override
  bool get budgetExhausted;
  @override
  int? get tokenBudget;
  @override
  int get tokenSpent; // Poll link
  @override
  String? get pollId; // Upload configuration
  @override
  String? get uploadPrompt;
  @override
  String? get uploadContextMediaUrl;
  @override
  String? get uploadContextMediaType;
  @override
  bool get uploadVideoEnabled;
  @override
  bool get uploadImageEnabled;
  @override
  bool get uploadTextEnabled;
  @override
  bool get uploadVideoRequired;
  @override
  bool get uploadImageRequired;
  @override
  bool get uploadTextRequired;
  @override
  int get uploadVideoMaxSeconds;
  @override
  int get uploadTextMinChars;
  @override
  int get uploadTextMaxChars;
  @override
  bool get requiresAdminReview; // Reward campaign linkage
  @override
  String? get rewardCampaignId;
  @override
  String? get rewardCampaignName;
  @override
  String? get rewardType;

  /// Create a copy of EarnOpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnOpportunityModelImplCopyWith<_$EarnOpportunityModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
