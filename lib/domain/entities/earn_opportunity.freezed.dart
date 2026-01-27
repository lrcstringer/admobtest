// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_opportunity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) {
  return _SurveyQuestion.fromJson(json);
}

/// @nodoc
mixin _$SurveyQuestion {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  bool? get isAttentionCheck => throw _privateConstructorUsedError;
  String? get correctAnswer => throw _privateConstructorUsedError;

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
    List<String> options,
    int orderIndex,
    bool? isAttentionCheck,
    String? correctAnswer,
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
    Object? options = null,
    Object? orderIndex = null,
    Object? isAttentionCheck = freezed,
    Object? correctAnswer = freezed,
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
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isAttentionCheck: freezed == isAttentionCheck
                ? _value.isAttentionCheck
                : isAttentionCheck // ignore: cast_nullable_to_non_nullable
                      as bool?,
            correctAnswer: freezed == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
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
    List<String> options,
    int orderIndex,
    bool? isAttentionCheck,
    String? correctAnswer,
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
    Object? options = null,
    Object? orderIndex = null,
    Object? isAttentionCheck = freezed,
    Object? correctAnswer = freezed,
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
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isAttentionCheck: freezed == isAttentionCheck
            ? _value.isAttentionCheck
            : isAttentionCheck // ignore: cast_nullable_to_non_nullable
                  as bool?,
        correctAnswer: freezed == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
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
    required final List<String> options,
    required this.orderIndex,
    this.isAttentionCheck,
    this.correctAnswer,
  }) : _options = options;

  factory _$SurveyQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int orderIndex;
  @override
  final bool? isAttentionCheck;
  @override
  final String? correctAnswer;

  @override
  String toString() {
    return 'SurveyQuestion(id: $id, text: $text, options: $options, orderIndex: $orderIndex, isAttentionCheck: $isAttentionCheck, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.isAttentionCheck, isAttentionCheck) ||
                other.isAttentionCheck == isAttentionCheck) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    const DeepCollectionEquality().hash(_options),
    orderIndex,
    isAttentionCheck,
    correctAnswer,
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
    required final List<String> options,
    required final int orderIndex,
    final bool? isAttentionCheck,
    final String? correctAnswer,
  }) = _$SurveyQuestionImpl;

  factory _SurveyQuestion.fromJson(Map<String, dynamic> json) =
      _$SurveyQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  List<String> get options;
  @override
  int get orderIndex;
  @override
  bool? get isAttentionCheck;
  @override
  String? get correctAnswer;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyQuestionImplCopyWith<_$SurveyQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarnOpportunity _$EarnOpportunityFromJson(Map<String, dynamic> json) {
  return _EarnOpportunity.fromJson(json);
}

/// @nodoc
mixin _$EarnOpportunity {
  String get id => throw _privateConstructorUsedError;
  String get threadId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get tokenReward => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  String get mediaUrl => throw _privateConstructorUsedError;
  List<SurveyQuestion> get questions => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  String? get brandAvatarColor => throw _privateConstructorUsedError;
  String? get campaignId => throw _privateConstructorUsedError;

  /// Serializes this EarnOpportunity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarnOpportunity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnOpportunityCopyWith<EarnOpportunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnOpportunityCopyWith<$Res> {
  factory $EarnOpportunityCopyWith(
    EarnOpportunity value,
    $Res Function(EarnOpportunity) then,
  ) = _$EarnOpportunityCopyWithImpl<$Res, EarnOpportunity>;
  @useResult
  $Res call({
    String id,
    String threadId,
    String title,
    String? description,
    int tokenReward,
    MediaType mediaType,
    String mediaUrl,
    List<SurveyQuestion> questions,
    int durationSeconds,
    DateTime? expiresAt,
    bool isActive,
    String? brandName,
    String? brandAvatarColor,
    String? campaignId,
  });
}

/// @nodoc
class _$EarnOpportunityCopyWithImpl<$Res, $Val extends EarnOpportunity>
    implements $EarnOpportunityCopyWith<$Res> {
  _$EarnOpportunityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnOpportunity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? title = null,
    Object? description = freezed,
    Object? tokenReward = null,
    Object? mediaType = null,
    Object? mediaUrl = null,
    Object? questions = null,
    Object? durationSeconds = null,
    Object? expiresAt = freezed,
    Object? isActive = null,
    Object? brandName = freezed,
    Object? brandAvatarColor = freezed,
    Object? campaignId = freezed,
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
            tokenReward: null == tokenReward
                ? _value.tokenReward
                : tokenReward // ignore: cast_nullable_to_non_nullable
                      as int,
            mediaType: null == mediaType
                ? _value.mediaType
                : mediaType // ignore: cast_nullable_to_non_nullable
                      as MediaType,
            mediaUrl: null == mediaUrl
                ? _value.mediaUrl
                : mediaUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<SurveyQuestion>,
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
            brandName: freezed == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandAvatarColor: freezed == brandAvatarColor
                ? _value.brandAvatarColor
                : brandAvatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            campaignId: freezed == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarnOpportunityImplCopyWith<$Res>
    implements $EarnOpportunityCopyWith<$Res> {
  factory _$$EarnOpportunityImplCopyWith(
    _$EarnOpportunityImpl value,
    $Res Function(_$EarnOpportunityImpl) then,
  ) = __$$EarnOpportunityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String threadId,
    String title,
    String? description,
    int tokenReward,
    MediaType mediaType,
    String mediaUrl,
    List<SurveyQuestion> questions,
    int durationSeconds,
    DateTime? expiresAt,
    bool isActive,
    String? brandName,
    String? brandAvatarColor,
    String? campaignId,
  });
}

/// @nodoc
class __$$EarnOpportunityImplCopyWithImpl<$Res>
    extends _$EarnOpportunityCopyWithImpl<$Res, _$EarnOpportunityImpl>
    implements _$$EarnOpportunityImplCopyWith<$Res> {
  __$$EarnOpportunityImplCopyWithImpl(
    _$EarnOpportunityImpl _value,
    $Res Function(_$EarnOpportunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnOpportunity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? title = null,
    Object? description = freezed,
    Object? tokenReward = null,
    Object? mediaType = null,
    Object? mediaUrl = null,
    Object? questions = null,
    Object? durationSeconds = null,
    Object? expiresAt = freezed,
    Object? isActive = null,
    Object? brandName = freezed,
    Object? brandAvatarColor = freezed,
    Object? campaignId = freezed,
  }) {
    return _then(
      _$EarnOpportunityImpl(
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
        tokenReward: null == tokenReward
            ? _value.tokenReward
            : tokenReward // ignore: cast_nullable_to_non_nullable
                  as int,
        mediaType: null == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as MediaType,
        mediaUrl: null == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<SurveyQuestion>,
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
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandAvatarColor: freezed == brandAvatarColor
            ? _value.brandAvatarColor
            : brandAvatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        campaignId: freezed == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarnOpportunityImpl extends _EarnOpportunity {
  const _$EarnOpportunityImpl({
    required this.id,
    required this.threadId,
    required this.title,
    this.description,
    required this.tokenReward,
    required this.mediaType,
    required this.mediaUrl,
    required final List<SurveyQuestion> questions,
    required this.durationSeconds,
    this.expiresAt,
    required this.isActive,
    this.brandName,
    this.brandAvatarColor,
    this.campaignId,
  }) : _questions = questions,
       super._();

  factory _$EarnOpportunityImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarnOpportunityImplFromJson(json);

  @override
  final String id;
  @override
  final String threadId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int tokenReward;
  @override
  final MediaType mediaType;
  @override
  final String mediaUrl;
  final List<SurveyQuestion> _questions;
  @override
  List<SurveyQuestion> get questions {
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
  @override
  final String? brandName;
  @override
  final String? brandAvatarColor;
  @override
  final String? campaignId;

  @override
  String toString() {
    return 'EarnOpportunity(id: $id, threadId: $threadId, title: $title, description: $description, tokenReward: $tokenReward, mediaType: $mediaType, mediaUrl: $mediaUrl, questions: $questions, durationSeconds: $durationSeconds, expiresAt: $expiresAt, isActive: $isActive, brandName: $brandName, brandAvatarColor: $brandAvatarColor, campaignId: $campaignId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnOpportunityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.tokenReward, tokenReward) ||
                other.tokenReward == tokenReward) &&
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
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandAvatarColor, brandAvatarColor) ||
                other.brandAvatarColor == brandAvatarColor) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    threadId,
    title,
    description,
    tokenReward,
    mediaType,
    mediaUrl,
    const DeepCollectionEquality().hash(_questions),
    durationSeconds,
    expiresAt,
    isActive,
    brandName,
    brandAvatarColor,
    campaignId,
  );

  /// Create a copy of EarnOpportunity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnOpportunityImplCopyWith<_$EarnOpportunityImpl> get copyWith =>
      __$$EarnOpportunityImplCopyWithImpl<_$EarnOpportunityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EarnOpportunityImplToJson(this);
  }
}

abstract class _EarnOpportunity extends EarnOpportunity {
  const factory _EarnOpportunity({
    required final String id,
    required final String threadId,
    required final String title,
    final String? description,
    required final int tokenReward,
    required final MediaType mediaType,
    required final String mediaUrl,
    required final List<SurveyQuestion> questions,
    required final int durationSeconds,
    final DateTime? expiresAt,
    required final bool isActive,
    final String? brandName,
    final String? brandAvatarColor,
    final String? campaignId,
  }) = _$EarnOpportunityImpl;
  const _EarnOpportunity._() : super._();

  factory _EarnOpportunity.fromJson(Map<String, dynamic> json) =
      _$EarnOpportunityImpl.fromJson;

  @override
  String get id;
  @override
  String get threadId;
  @override
  String get title;
  @override
  String? get description;
  @override
  int get tokenReward;
  @override
  MediaType get mediaType;
  @override
  String get mediaUrl;
  @override
  List<SurveyQuestion> get questions;
  @override
  int get durationSeconds;
  @override
  DateTime? get expiresAt;
  @override
  bool get isActive;
  @override
  String? get brandName;
  @override
  String? get brandAvatarColor;
  @override
  String? get campaignId;

  /// Create a copy of EarnOpportunity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnOpportunityImplCopyWith<_$EarnOpportunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
