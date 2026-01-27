// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return _Survey.fromJson(json);
}

/// @nodoc
mixin _$Survey {
  String get id => throw _privateConstructorUsedError;
  String get campaignId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<SurveyQuestion> get questions => throw _privateConstructorUsedError;
  int get tokenReward => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;
  SurveyStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  int? get maxResponses => throw _privateConstructorUsedError;
  int? get currentResponses => throw _privateConstructorUsedError;
  Map<String, dynamic>? get targetingCriteria =>
      throw _privateConstructorUsedError;

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyCopyWith<Survey> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyCopyWith<$Res> {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) then) =
      _$SurveyCopyWithImpl<$Res, Survey>;
  @useResult
  $Res call({
    String id,
    String campaignId,
    String title,
    String description,
    List<SurveyQuestion> questions,
    int tokenReward,
    int estimatedMinutes,
    SurveyStatus status,
    DateTime createdAt,
    DateTime? expiresAt,
    int? maxResponses,
    int? currentResponses,
    Map<String, dynamic>? targetingCriteria,
  });
}

/// @nodoc
class _$SurveyCopyWithImpl<$Res, $Val extends Survey>
    implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? title = null,
    Object? description = null,
    Object? questions = null,
    Object? tokenReward = null,
    Object? estimatedMinutes = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? maxResponses = freezed,
    Object? currentResponses = freezed,
    Object? targetingCriteria = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<SurveyQuestion>,
            tokenReward: null == tokenReward
                ? _value.tokenReward
                : tokenReward // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedMinutes: null == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SurveyStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            maxResponses: freezed == maxResponses
                ? _value.maxResponses
                : maxResponses // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentResponses: freezed == currentResponses
                ? _value.currentResponses
                : currentResponses // ignore: cast_nullable_to_non_nullable
                      as int?,
            targetingCriteria: freezed == targetingCriteria
                ? _value.targetingCriteria
                : targetingCriteria // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyImplCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$$SurveyImplCopyWith(
    _$SurveyImpl value,
    $Res Function(_$SurveyImpl) then,
  ) = __$$SurveyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String campaignId,
    String title,
    String description,
    List<SurveyQuestion> questions,
    int tokenReward,
    int estimatedMinutes,
    SurveyStatus status,
    DateTime createdAt,
    DateTime? expiresAt,
    int? maxResponses,
    int? currentResponses,
    Map<String, dynamic>? targetingCriteria,
  });
}

/// @nodoc
class __$$SurveyImplCopyWithImpl<$Res>
    extends _$SurveyCopyWithImpl<$Res, _$SurveyImpl>
    implements _$$SurveyImplCopyWith<$Res> {
  __$$SurveyImplCopyWithImpl(
    _$SurveyImpl _value,
    $Res Function(_$SurveyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? title = null,
    Object? description = null,
    Object? questions = null,
    Object? tokenReward = null,
    Object? estimatedMinutes = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? maxResponses = freezed,
    Object? currentResponses = freezed,
    Object? targetingCriteria = freezed,
  }) {
    return _then(
      _$SurveyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<SurveyQuestion>,
        tokenReward: null == tokenReward
            ? _value.tokenReward
            : tokenReward // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedMinutes: null == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SurveyStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        maxResponses: freezed == maxResponses
            ? _value.maxResponses
            : maxResponses // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentResponses: freezed == currentResponses
            ? _value.currentResponses
            : currentResponses // ignore: cast_nullable_to_non_nullable
                  as int?,
        targetingCriteria: freezed == targetingCriteria
            ? _value._targetingCriteria
            : targetingCriteria // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyImpl implements _Survey {
  const _$SurveyImpl({
    required this.id,
    required this.campaignId,
    required this.title,
    required this.description,
    required final List<SurveyQuestion> questions,
    required this.tokenReward,
    required this.estimatedMinutes,
    required this.status,
    required this.createdAt,
    this.expiresAt,
    this.maxResponses,
    this.currentResponses,
    final Map<String, dynamic>? targetingCriteria,
  }) : _questions = questions,
       _targetingCriteria = targetingCriteria;

  factory _$SurveyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyImplFromJson(json);

  @override
  final String id;
  @override
  final String campaignId;
  @override
  final String title;
  @override
  final String description;
  final List<SurveyQuestion> _questions;
  @override
  List<SurveyQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final int tokenReward;
  @override
  final int estimatedMinutes;
  @override
  final SurveyStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final int? maxResponses;
  @override
  final int? currentResponses;
  final Map<String, dynamic>? _targetingCriteria;
  @override
  Map<String, dynamic>? get targetingCriteria {
    final value = _targetingCriteria;
    if (value == null) return null;
    if (_targetingCriteria is EqualUnmodifiableMapView)
      return _targetingCriteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Survey(id: $id, campaignId: $campaignId, title: $title, description: $description, questions: $questions, tokenReward: $tokenReward, estimatedMinutes: $estimatedMinutes, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, maxResponses: $maxResponses, currentResponses: $currentResponses, targetingCriteria: $targetingCriteria)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.tokenReward, tokenReward) ||
                other.tokenReward == tokenReward) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.maxResponses, maxResponses) ||
                other.maxResponses == maxResponses) &&
            (identical(other.currentResponses, currentResponses) ||
                other.currentResponses == currentResponses) &&
            const DeepCollectionEquality().equals(
              other._targetingCriteria,
              _targetingCriteria,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    title,
    description,
    const DeepCollectionEquality().hash(_questions),
    tokenReward,
    estimatedMinutes,
    status,
    createdAt,
    expiresAt,
    maxResponses,
    currentResponses,
    const DeepCollectionEquality().hash(_targetingCriteria),
  );

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyImplCopyWith<_$SurveyImpl> get copyWith =>
      __$$SurveyImplCopyWithImpl<_$SurveyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyImplToJson(this);
  }
}

abstract class _Survey implements Survey {
  const factory _Survey({
    required final String id,
    required final String campaignId,
    required final String title,
    required final String description,
    required final List<SurveyQuestion> questions,
    required final int tokenReward,
    required final int estimatedMinutes,
    required final SurveyStatus status,
    required final DateTime createdAt,
    final DateTime? expiresAt,
    final int? maxResponses,
    final int? currentResponses,
    final Map<String, dynamic>? targetingCriteria,
  }) = _$SurveyImpl;

  factory _Survey.fromJson(Map<String, dynamic> json) = _$SurveyImpl.fromJson;

  @override
  String get id;
  @override
  String get campaignId;
  @override
  String get title;
  @override
  String get description;
  @override
  List<SurveyQuestion> get questions;
  @override
  int get tokenReward;
  @override
  int get estimatedMinutes;
  @override
  SurveyStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get expiresAt;
  @override
  int? get maxResponses;
  @override
  int? get currentResponses;
  @override
  Map<String, dynamic>? get targetingCriteria;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyImplCopyWith<_$SurveyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) {
  return _SurveyQuestion.fromJson(json);
}

/// @nodoc
mixin _$SurveyQuestion {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  QuestionType get type => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;
  int? get minValue => throw _privateConstructorUsedError;
  int? get maxValue => throw _privateConstructorUsedError;
  String? get placeholder => throw _privateConstructorUsedError;

  /// Serializes this SurveyQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyQuestionCopyWith<SurveyQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyQuestionCopyWith<$Res> {
  factory $SurveyQuestionCopyWith(
    SurveyQuestion value,
    $Res Function(SurveyQuestion) then,
  ) = _$SurveyQuestionCopyWithImpl<$Res, SurveyQuestion>;
  @useResult
  $Res call({
    String id,
    String text,
    QuestionType type,
    bool isRequired,
    List<String>? options,
    int? minValue,
    int? maxValue,
    String? placeholder,
  });
}

/// @nodoc
class _$SurveyQuestionCopyWithImpl<$Res, $Val extends SurveyQuestion>
    implements $SurveyQuestionCopyWith<$Res> {
  _$SurveyQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? type = null,
    Object? isRequired = null,
    Object? options = freezed,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? placeholder = freezed,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as QuestionType,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            options: freezed == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            minValue: freezed == minValue
                ? _value.minValue
                : minValue // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxValue: freezed == maxValue
                ? _value.maxValue
                : maxValue // ignore: cast_nullable_to_non_nullable
                      as int?,
            placeholder: freezed == placeholder
                ? _value.placeholder
                : placeholder // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyQuestionImplCopyWith<$Res>
    implements $SurveyQuestionCopyWith<$Res> {
  factory _$$SurveyQuestionImplCopyWith(
    _$SurveyQuestionImpl value,
    $Res Function(_$SurveyQuestionImpl) then,
  ) = __$$SurveyQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    QuestionType type,
    bool isRequired,
    List<String>? options,
    int? minValue,
    int? maxValue,
    String? placeholder,
  });
}

/// @nodoc
class __$$SurveyQuestionImplCopyWithImpl<$Res>
    extends _$SurveyQuestionCopyWithImpl<$Res, _$SurveyQuestionImpl>
    implements _$$SurveyQuestionImplCopyWith<$Res> {
  __$$SurveyQuestionImplCopyWithImpl(
    _$SurveyQuestionImpl _value,
    $Res Function(_$SurveyQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? type = null,
    Object? isRequired = null,
    Object? options = freezed,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? placeholder = freezed,
  }) {
    return _then(
      _$SurveyQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as QuestionType,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        options: freezed == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        minValue: freezed == minValue
            ? _value.minValue
            : minValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxValue: freezed == maxValue
            ? _value.maxValue
            : maxValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        placeholder: freezed == placeholder
            ? _value.placeholder
            : placeholder // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyQuestionImpl implements _SurveyQuestion {
  const _$SurveyQuestionImpl({
    required this.id,
    required this.text,
    required this.type,
    required this.isRequired,
    final List<String>? options,
    this.minValue,
    this.maxValue,
    this.placeholder,
  }) : _options = options;

  factory _$SurveyQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final QuestionType type;
  @override
  final bool isRequired;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? minValue;
  @override
  final int? maxValue;
  @override
  final String? placeholder;

  @override
  String toString() {
    return 'SurveyQuestion(id: $id, text: $text, type: $type, isRequired: $isRequired, options: $options, minValue: $minValue, maxValue: $maxValue, placeholder: $placeholder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    type,
    isRequired,
    const DeepCollectionEquality().hash(_options),
    minValue,
    maxValue,
    placeholder,
  );

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyQuestionImplCopyWith<_$SurveyQuestionImpl> get copyWith =>
      __$$SurveyQuestionImplCopyWithImpl<_$SurveyQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyQuestionImplToJson(this);
  }
}

abstract class _SurveyQuestion implements SurveyQuestion {
  const factory _SurveyQuestion({
    required final String id,
    required final String text,
    required final QuestionType type,
    required final bool isRequired,
    final List<String>? options,
    final int? minValue,
    final int? maxValue,
    final String? placeholder,
  }) = _$SurveyQuestionImpl;

  factory _SurveyQuestion.fromJson(Map<String, dynamic> json) =
      _$SurveyQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  QuestionType get type;
  @override
  bool get isRequired;
  @override
  List<String>? get options;
  @override
  int? get minValue;
  @override
  int? get maxValue;
  @override
  String? get placeholder;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyQuestionImplCopyWith<_$SurveyQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
