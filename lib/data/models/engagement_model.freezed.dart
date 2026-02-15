// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SurveyResponseModel {
  String get questionId => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  DateTime get answeredAt =>
      throw _privateConstructorUsedError; // single_select
  String? get selectedOption =>
      throw _privateConstructorUsedError; // multi_select
  List<String>? get selectedOptions =>
      throw _privateConstructorUsedError; // text_input
  List<String>? get textResponses =>
      throw _privateConstructorUsedError; // likert
  int? get likertValue => throw _privateConstructorUsedError; // star_tags
  int? get starRating => throw _privateConstructorUsedError;
  List<String>? get selectedTags =>
      throw _privateConstructorUsedError; // slider
  double? get sliderValue =>
      throw _privateConstructorUsedError; // attention check result
  bool? get isCorrect => throw _privateConstructorUsedError;

  /// Create a copy of SurveyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyResponseModelCopyWith<SurveyResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyResponseModelCopyWith<$Res> {
  factory $SurveyResponseModelCopyWith(
    SurveyResponseModel value,
    $Res Function(SurveyResponseModel) then,
  ) = _$SurveyResponseModelCopyWithImpl<$Res, SurveyResponseModel>;
  @useResult
  $Res call({
    String questionId,
    String questionType,
    DateTime answeredAt,
    String? selectedOption,
    List<String>? selectedOptions,
    List<String>? textResponses,
    int? likertValue,
    int? starRating,
    List<String>? selectedTags,
    double? sliderValue,
    bool? isCorrect,
  });
}

/// @nodoc
class _$SurveyResponseModelCopyWithImpl<$Res, $Val extends SurveyResponseModel>
    implements $SurveyResponseModelCopyWith<$Res> {
  _$SurveyResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? answeredAt = null,
    Object? selectedOption = freezed,
    Object? selectedOptions = freezed,
    Object? textResponses = freezed,
    Object? likertValue = freezed,
    Object? starRating = freezed,
    Object? selectedTags = freezed,
    Object? sliderValue = freezed,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionType: null == questionType
                ? _value.questionType
                : questionType // ignore: cast_nullable_to_non_nullable
                      as String,
            answeredAt: null == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            selectedOption: freezed == selectedOption
                ? _value.selectedOption
                : selectedOption // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedOptions: freezed == selectedOptions
                ? _value.selectedOptions
                : selectedOptions // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            textResponses: freezed == textResponses
                ? _value.textResponses
                : textResponses // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            likertValue: freezed == likertValue
                ? _value.likertValue
                : likertValue // ignore: cast_nullable_to_non_nullable
                      as int?,
            starRating: freezed == starRating
                ? _value.starRating
                : starRating // ignore: cast_nullable_to_non_nullable
                      as int?,
            selectedTags: freezed == selectedTags
                ? _value.selectedTags
                : selectedTags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            sliderValue: freezed == sliderValue
                ? _value.sliderValue
                : sliderValue // ignore: cast_nullable_to_non_nullable
                      as double?,
            isCorrect: freezed == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyResponseModelImplCopyWith<$Res>
    implements $SurveyResponseModelCopyWith<$Res> {
  factory _$$SurveyResponseModelImplCopyWith(
    _$SurveyResponseModelImpl value,
    $Res Function(_$SurveyResponseModelImpl) then,
  ) = __$$SurveyResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    String questionType,
    DateTime answeredAt,
    String? selectedOption,
    List<String>? selectedOptions,
    List<String>? textResponses,
    int? likertValue,
    int? starRating,
    List<String>? selectedTags,
    double? sliderValue,
    bool? isCorrect,
  });
}

/// @nodoc
class __$$SurveyResponseModelImplCopyWithImpl<$Res>
    extends _$SurveyResponseModelCopyWithImpl<$Res, _$SurveyResponseModelImpl>
    implements _$$SurveyResponseModelImplCopyWith<$Res> {
  __$$SurveyResponseModelImplCopyWithImpl(
    _$SurveyResponseModelImpl _value,
    $Res Function(_$SurveyResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? answeredAt = null,
    Object? selectedOption = freezed,
    Object? selectedOptions = freezed,
    Object? textResponses = freezed,
    Object? likertValue = freezed,
    Object? starRating = freezed,
    Object? selectedTags = freezed,
    Object? sliderValue = freezed,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _$SurveyResponseModelImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionType: null == questionType
            ? _value.questionType
            : questionType // ignore: cast_nullable_to_non_nullable
                  as String,
        answeredAt: null == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        selectedOption: freezed == selectedOption
            ? _value.selectedOption
            : selectedOption // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedOptions: freezed == selectedOptions
            ? _value._selectedOptions
            : selectedOptions // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        textResponses: freezed == textResponses
            ? _value._textResponses
            : textResponses // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        likertValue: freezed == likertValue
            ? _value.likertValue
            : likertValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        starRating: freezed == starRating
            ? _value.starRating
            : starRating // ignore: cast_nullable_to_non_nullable
                  as int?,
        selectedTags: freezed == selectedTags
            ? _value._selectedTags
            : selectedTags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        sliderValue: freezed == sliderValue
            ? _value.sliderValue
            : sliderValue // ignore: cast_nullable_to_non_nullable
                  as double?,
        isCorrect: freezed == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$SurveyResponseModelImpl extends _SurveyResponseModel {
  const _$SurveyResponseModelImpl({
    required this.questionId,
    required this.questionType,
    required this.answeredAt,
    this.selectedOption,
    final List<String>? selectedOptions,
    final List<String>? textResponses,
    this.likertValue,
    this.starRating,
    final List<String>? selectedTags,
    this.sliderValue,
    this.isCorrect,
  }) : _selectedOptions = selectedOptions,
       _textResponses = textResponses,
       _selectedTags = selectedTags,
       super._();

  @override
  final String questionId;
  @override
  final String questionType;
  @override
  final DateTime answeredAt;
  // single_select
  @override
  final String? selectedOption;
  // multi_select
  final List<String>? _selectedOptions;
  // multi_select
  @override
  List<String>? get selectedOptions {
    final value = _selectedOptions;
    if (value == null) return null;
    if (_selectedOptions is EqualUnmodifiableListView) return _selectedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // text_input
  final List<String>? _textResponses;
  // text_input
  @override
  List<String>? get textResponses {
    final value = _textResponses;
    if (value == null) return null;
    if (_textResponses is EqualUnmodifiableListView) return _textResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // likert
  @override
  final int? likertValue;
  // star_tags
  @override
  final int? starRating;
  final List<String>? _selectedTags;
  @override
  List<String>? get selectedTags {
    final value = _selectedTags;
    if (value == null) return null;
    if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // slider
  @override
  final double? sliderValue;
  // attention check result
  @override
  final bool? isCorrect;

  @override
  String toString() {
    return 'SurveyResponseModel(questionId: $questionId, questionType: $questionType, answeredAt: $answeredAt, selectedOption: $selectedOption, selectedOptions: $selectedOptions, textResponses: $textResponses, likertValue: $likertValue, starRating: $starRating, selectedTags: $selectedTags, sliderValue: $sliderValue, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyResponseModelImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption) &&
            const DeepCollectionEquality().equals(
              other._selectedOptions,
              _selectedOptions,
            ) &&
            const DeepCollectionEquality().equals(
              other._textResponses,
              _textResponses,
            ) &&
            (identical(other.likertValue, likertValue) ||
                other.likertValue == likertValue) &&
            (identical(other.starRating, starRating) ||
                other.starRating == starRating) &&
            const DeepCollectionEquality().equals(
              other._selectedTags,
              _selectedTags,
            ) &&
            (identical(other.sliderValue, sliderValue) ||
                other.sliderValue == sliderValue) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    questionType,
    answeredAt,
    selectedOption,
    const DeepCollectionEquality().hash(_selectedOptions),
    const DeepCollectionEquality().hash(_textResponses),
    likertValue,
    starRating,
    const DeepCollectionEquality().hash(_selectedTags),
    sliderValue,
    isCorrect,
  );

  /// Create a copy of SurveyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyResponseModelImplCopyWith<_$SurveyResponseModelImpl> get copyWith =>
      __$$SurveyResponseModelImplCopyWithImpl<_$SurveyResponseModelImpl>(
        this,
        _$identity,
      );
}

abstract class _SurveyResponseModel extends SurveyResponseModel {
  const factory _SurveyResponseModel({
    required final String questionId,
    required final String questionType,
    required final DateTime answeredAt,
    final String? selectedOption,
    final List<String>? selectedOptions,
    final List<String>? textResponses,
    final int? likertValue,
    final int? starRating,
    final List<String>? selectedTags,
    final double? sliderValue,
    final bool? isCorrect,
  }) = _$SurveyResponseModelImpl;
  const _SurveyResponseModel._() : super._();

  @override
  String get questionId;
  @override
  String get questionType;
  @override
  DateTime get answeredAt; // single_select
  @override
  String? get selectedOption; // multi_select
  @override
  List<String>? get selectedOptions; // text_input
  @override
  List<String>? get textResponses; // likert
  @override
  int? get likertValue; // star_tags
  @override
  int? get starRating;
  @override
  List<String>? get selectedTags; // slider
  @override
  double? get sliderValue; // attention check result
  @override
  bool? get isCorrect;

  /// Create a copy of SurveyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyResponseModelImplCopyWith<_$SurveyResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EngagementEvidenceModel {
  String get deviceFingerprint => throw _privateConstructorUsedError;
  String? get integrityToken => throw _privateConstructorUsedError;
  int get watchDurationMs => throw _privateConstructorUsedError;
  bool get videoSeeked => throw _privateConstructorUsedError;
  bool get screenVisible => throw _privateConstructorUsedError;
  bool get appInForeground => throw _privateConstructorUsedError;
  List<int> get surveyResponseTimesMs => throw _privateConstructorUsedError;
  DateTime get videoStartedAt => throw _privateConstructorUsedError;
  DateTime get surveySubmittedAt => throw _privateConstructorUsedError;
  double? get clientAttentionScore =>
      throw _privateConstructorUsedError; // AdMob verification fields
  String? get adTransactionId => throw _privateConstructorUsedError;
  bool? get adFullyWatched => throw _privateConstructorUsedError;
  String? get adResponseId =>
      throw _privateConstructorUsedError; // Upload evidence fields
  List<Map<String, dynamic>>? get uploadedFiles =>
      throw _privateConstructorUsedError;
  String? get uploadTextResponse => throw _privateConstructorUsedError;
  DateTime? get uploadStartedAt => throw _privateConstructorUsedError;
  DateTime? get uploadCompletedAt => throw _privateConstructorUsedError;

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementEvidenceModelCopyWith<EngagementEvidenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementEvidenceModelCopyWith<$Res> {
  factory $EngagementEvidenceModelCopyWith(
    EngagementEvidenceModel value,
    $Res Function(EngagementEvidenceModel) then,
  ) = _$EngagementEvidenceModelCopyWithImpl<$Res, EngagementEvidenceModel>;
  @useResult
  $Res call({
    String deviceFingerprint,
    String? integrityToken,
    int watchDurationMs,
    bool videoSeeked,
    bool screenVisible,
    bool appInForeground,
    List<int> surveyResponseTimesMs,
    DateTime videoStartedAt,
    DateTime surveySubmittedAt,
    double? clientAttentionScore,
    String? adTransactionId,
    bool? adFullyWatched,
    String? adResponseId,
    List<Map<String, dynamic>>? uploadedFiles,
    String? uploadTextResponse,
    DateTime? uploadStartedAt,
    DateTime? uploadCompletedAt,
  });
}

/// @nodoc
class _$EngagementEvidenceModelCopyWithImpl<
  $Res,
  $Val extends EngagementEvidenceModel
>
    implements $EngagementEvidenceModelCopyWith<$Res> {
  _$EngagementEvidenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceFingerprint = null,
    Object? integrityToken = freezed,
    Object? watchDurationMs = null,
    Object? videoSeeked = null,
    Object? screenVisible = null,
    Object? appInForeground = null,
    Object? surveyResponseTimesMs = null,
    Object? videoStartedAt = null,
    Object? surveySubmittedAt = null,
    Object? clientAttentionScore = freezed,
    Object? adTransactionId = freezed,
    Object? adFullyWatched = freezed,
    Object? adResponseId = freezed,
    Object? uploadedFiles = freezed,
    Object? uploadTextResponse = freezed,
    Object? uploadStartedAt = freezed,
    Object? uploadCompletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            deviceFingerprint: null == deviceFingerprint
                ? _value.deviceFingerprint
                : deviceFingerprint // ignore: cast_nullable_to_non_nullable
                      as String,
            integrityToken: freezed == integrityToken
                ? _value.integrityToken
                : integrityToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            watchDurationMs: null == watchDurationMs
                ? _value.watchDurationMs
                : watchDurationMs // ignore: cast_nullable_to_non_nullable
                      as int,
            videoSeeked: null == videoSeeked
                ? _value.videoSeeked
                : videoSeeked // ignore: cast_nullable_to_non_nullable
                      as bool,
            screenVisible: null == screenVisible
                ? _value.screenVisible
                : screenVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            appInForeground: null == appInForeground
                ? _value.appInForeground
                : appInForeground // ignore: cast_nullable_to_non_nullable
                      as bool,
            surveyResponseTimesMs: null == surveyResponseTimesMs
                ? _value.surveyResponseTimesMs
                : surveyResponseTimesMs // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            videoStartedAt: null == videoStartedAt
                ? _value.videoStartedAt
                : videoStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            surveySubmittedAt: null == surveySubmittedAt
                ? _value.surveySubmittedAt
                : surveySubmittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            clientAttentionScore: freezed == clientAttentionScore
                ? _value.clientAttentionScore
                : clientAttentionScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            adTransactionId: freezed == adTransactionId
                ? _value.adTransactionId
                : adTransactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            adFullyWatched: freezed == adFullyWatched
                ? _value.adFullyWatched
                : adFullyWatched // ignore: cast_nullable_to_non_nullable
                      as bool?,
            adResponseId: freezed == adResponseId
                ? _value.adResponseId
                : adResponseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadedFiles: freezed == uploadedFiles
                ? _value.uploadedFiles
                : uploadedFiles // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>?,
            uploadTextResponse: freezed == uploadTextResponse
                ? _value.uploadTextResponse
                : uploadTextResponse // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadStartedAt: freezed == uploadStartedAt
                ? _value.uploadStartedAt
                : uploadStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            uploadCompletedAt: freezed == uploadCompletedAt
                ? _value.uploadCompletedAt
                : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EngagementEvidenceModelImplCopyWith<$Res>
    implements $EngagementEvidenceModelCopyWith<$Res> {
  factory _$$EngagementEvidenceModelImplCopyWith(
    _$EngagementEvidenceModelImpl value,
    $Res Function(_$EngagementEvidenceModelImpl) then,
  ) = __$$EngagementEvidenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String deviceFingerprint,
    String? integrityToken,
    int watchDurationMs,
    bool videoSeeked,
    bool screenVisible,
    bool appInForeground,
    List<int> surveyResponseTimesMs,
    DateTime videoStartedAt,
    DateTime surveySubmittedAt,
    double? clientAttentionScore,
    String? adTransactionId,
    bool? adFullyWatched,
    String? adResponseId,
    List<Map<String, dynamic>>? uploadedFiles,
    String? uploadTextResponse,
    DateTime? uploadStartedAt,
    DateTime? uploadCompletedAt,
  });
}

/// @nodoc
class __$$EngagementEvidenceModelImplCopyWithImpl<$Res>
    extends
        _$EngagementEvidenceModelCopyWithImpl<
          $Res,
          _$EngagementEvidenceModelImpl
        >
    implements _$$EngagementEvidenceModelImplCopyWith<$Res> {
  __$$EngagementEvidenceModelImplCopyWithImpl(
    _$EngagementEvidenceModelImpl _value,
    $Res Function(_$EngagementEvidenceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceFingerprint = null,
    Object? integrityToken = freezed,
    Object? watchDurationMs = null,
    Object? videoSeeked = null,
    Object? screenVisible = null,
    Object? appInForeground = null,
    Object? surveyResponseTimesMs = null,
    Object? videoStartedAt = null,
    Object? surveySubmittedAt = null,
    Object? clientAttentionScore = freezed,
    Object? adTransactionId = freezed,
    Object? adFullyWatched = freezed,
    Object? adResponseId = freezed,
    Object? uploadedFiles = freezed,
    Object? uploadTextResponse = freezed,
    Object? uploadStartedAt = freezed,
    Object? uploadCompletedAt = freezed,
  }) {
    return _then(
      _$EngagementEvidenceModelImpl(
        deviceFingerprint: null == deviceFingerprint
            ? _value.deviceFingerprint
            : deviceFingerprint // ignore: cast_nullable_to_non_nullable
                  as String,
        integrityToken: freezed == integrityToken
            ? _value.integrityToken
            : integrityToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        watchDurationMs: null == watchDurationMs
            ? _value.watchDurationMs
            : watchDurationMs // ignore: cast_nullable_to_non_nullable
                  as int,
        videoSeeked: null == videoSeeked
            ? _value.videoSeeked
            : videoSeeked // ignore: cast_nullable_to_non_nullable
                  as bool,
        screenVisible: null == screenVisible
            ? _value.screenVisible
            : screenVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        appInForeground: null == appInForeground
            ? _value.appInForeground
            : appInForeground // ignore: cast_nullable_to_non_nullable
                  as bool,
        surveyResponseTimesMs: null == surveyResponseTimesMs
            ? _value._surveyResponseTimesMs
            : surveyResponseTimesMs // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        videoStartedAt: null == videoStartedAt
            ? _value.videoStartedAt
            : videoStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        surveySubmittedAt: null == surveySubmittedAt
            ? _value.surveySubmittedAt
            : surveySubmittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        clientAttentionScore: freezed == clientAttentionScore
            ? _value.clientAttentionScore
            : clientAttentionScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        adTransactionId: freezed == adTransactionId
            ? _value.adTransactionId
            : adTransactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        adFullyWatched: freezed == adFullyWatched
            ? _value.adFullyWatched
            : adFullyWatched // ignore: cast_nullable_to_non_nullable
                  as bool?,
        adResponseId: freezed == adResponseId
            ? _value.adResponseId
            : adResponseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadedFiles: freezed == uploadedFiles
            ? _value._uploadedFiles
            : uploadedFiles // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>?,
        uploadTextResponse: freezed == uploadTextResponse
            ? _value.uploadTextResponse
            : uploadTextResponse // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadStartedAt: freezed == uploadStartedAt
            ? _value.uploadStartedAt
            : uploadStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        uploadCompletedAt: freezed == uploadCompletedAt
            ? _value.uploadCompletedAt
            : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$EngagementEvidenceModelImpl extends _EngagementEvidenceModel {
  const _$EngagementEvidenceModelImpl({
    required this.deviceFingerprint,
    this.integrityToken,
    required this.watchDurationMs,
    required this.videoSeeked,
    required this.screenVisible,
    required this.appInForeground,
    required final List<int> surveyResponseTimesMs,
    required this.videoStartedAt,
    required this.surveySubmittedAt,
    this.clientAttentionScore,
    this.adTransactionId,
    this.adFullyWatched,
    this.adResponseId,
    final List<Map<String, dynamic>>? uploadedFiles,
    this.uploadTextResponse,
    this.uploadStartedAt,
    this.uploadCompletedAt,
  }) : _surveyResponseTimesMs = surveyResponseTimesMs,
       _uploadedFiles = uploadedFiles,
       super._();

  @override
  final String deviceFingerprint;
  @override
  final String? integrityToken;
  @override
  final int watchDurationMs;
  @override
  final bool videoSeeked;
  @override
  final bool screenVisible;
  @override
  final bool appInForeground;
  final List<int> _surveyResponseTimesMs;
  @override
  List<int> get surveyResponseTimesMs {
    if (_surveyResponseTimesMs is EqualUnmodifiableListView)
      return _surveyResponseTimesMs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surveyResponseTimesMs);
  }

  @override
  final DateTime videoStartedAt;
  @override
  final DateTime surveySubmittedAt;
  @override
  final double? clientAttentionScore;
  // AdMob verification fields
  @override
  final String? adTransactionId;
  @override
  final bool? adFullyWatched;
  @override
  final String? adResponseId;
  // Upload evidence fields
  final List<Map<String, dynamic>>? _uploadedFiles;
  // Upload evidence fields
  @override
  List<Map<String, dynamic>>? get uploadedFiles {
    final value = _uploadedFiles;
    if (value == null) return null;
    if (_uploadedFiles is EqualUnmodifiableListView) return _uploadedFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? uploadTextResponse;
  @override
  final DateTime? uploadStartedAt;
  @override
  final DateTime? uploadCompletedAt;

  @override
  String toString() {
    return 'EngagementEvidenceModel(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore, adTransactionId: $adTransactionId, adFullyWatched: $adFullyWatched, adResponseId: $adResponseId, uploadedFiles: $uploadedFiles, uploadTextResponse: $uploadTextResponse, uploadStartedAt: $uploadStartedAt, uploadCompletedAt: $uploadCompletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementEvidenceModelImpl &&
            (identical(other.deviceFingerprint, deviceFingerprint) ||
                other.deviceFingerprint == deviceFingerprint) &&
            (identical(other.integrityToken, integrityToken) ||
                other.integrityToken == integrityToken) &&
            (identical(other.watchDurationMs, watchDurationMs) ||
                other.watchDurationMs == watchDurationMs) &&
            (identical(other.videoSeeked, videoSeeked) ||
                other.videoSeeked == videoSeeked) &&
            (identical(other.screenVisible, screenVisible) ||
                other.screenVisible == screenVisible) &&
            (identical(other.appInForeground, appInForeground) ||
                other.appInForeground == appInForeground) &&
            const DeepCollectionEquality().equals(
              other._surveyResponseTimesMs,
              _surveyResponseTimesMs,
            ) &&
            (identical(other.videoStartedAt, videoStartedAt) ||
                other.videoStartedAt == videoStartedAt) &&
            (identical(other.surveySubmittedAt, surveySubmittedAt) ||
                other.surveySubmittedAt == surveySubmittedAt) &&
            (identical(other.clientAttentionScore, clientAttentionScore) ||
                other.clientAttentionScore == clientAttentionScore) &&
            (identical(other.adTransactionId, adTransactionId) ||
                other.adTransactionId == adTransactionId) &&
            (identical(other.adFullyWatched, adFullyWatched) ||
                other.adFullyWatched == adFullyWatched) &&
            (identical(other.adResponseId, adResponseId) ||
                other.adResponseId == adResponseId) &&
            const DeepCollectionEquality().equals(
              other._uploadedFiles,
              _uploadedFiles,
            ) &&
            (identical(other.uploadTextResponse, uploadTextResponse) ||
                other.uploadTextResponse == uploadTextResponse) &&
            (identical(other.uploadStartedAt, uploadStartedAt) ||
                other.uploadStartedAt == uploadStartedAt) &&
            (identical(other.uploadCompletedAt, uploadCompletedAt) ||
                other.uploadCompletedAt == uploadCompletedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    deviceFingerprint,
    integrityToken,
    watchDurationMs,
    videoSeeked,
    screenVisible,
    appInForeground,
    const DeepCollectionEquality().hash(_surveyResponseTimesMs),
    videoStartedAt,
    surveySubmittedAt,
    clientAttentionScore,
    adTransactionId,
    adFullyWatched,
    adResponseId,
    const DeepCollectionEquality().hash(_uploadedFiles),
    uploadTextResponse,
    uploadStartedAt,
    uploadCompletedAt,
  );

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementEvidenceModelImplCopyWith<_$EngagementEvidenceModelImpl>
  get copyWith =>
      __$$EngagementEvidenceModelImplCopyWithImpl<
        _$EngagementEvidenceModelImpl
      >(this, _$identity);
}

abstract class _EngagementEvidenceModel extends EngagementEvidenceModel {
  const factory _EngagementEvidenceModel({
    required final String deviceFingerprint,
    final String? integrityToken,
    required final int watchDurationMs,
    required final bool videoSeeked,
    required final bool screenVisible,
    required final bool appInForeground,
    required final List<int> surveyResponseTimesMs,
    required final DateTime videoStartedAt,
    required final DateTime surveySubmittedAt,
    final double? clientAttentionScore,
    final String? adTransactionId,
    final bool? adFullyWatched,
    final String? adResponseId,
    final List<Map<String, dynamic>>? uploadedFiles,
    final String? uploadTextResponse,
    final DateTime? uploadStartedAt,
    final DateTime? uploadCompletedAt,
  }) = _$EngagementEvidenceModelImpl;
  const _EngagementEvidenceModel._() : super._();

  @override
  String get deviceFingerprint;
  @override
  String? get integrityToken;
  @override
  int get watchDurationMs;
  @override
  bool get videoSeeked;
  @override
  bool get screenVisible;
  @override
  bool get appInForeground;
  @override
  List<int> get surveyResponseTimesMs;
  @override
  DateTime get videoStartedAt;
  @override
  DateTime get surveySubmittedAt;
  @override
  double? get clientAttentionScore; // AdMob verification fields
  @override
  String? get adTransactionId;
  @override
  bool? get adFullyWatched;
  @override
  String? get adResponseId; // Upload evidence fields
  @override
  List<Map<String, dynamic>>? get uploadedFiles;
  @override
  String? get uploadTextResponse;
  @override
  DateTime? get uploadStartedAt;
  @override
  DateTime? get uploadCompletedAt;

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementEvidenceModelImplCopyWith<_$EngagementEvidenceModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EngagementModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get audienceCampaignId => throw _privateConstructorUsedError;
  String get earnOpportunityId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get watchDurationSeconds => throw _privateConstructorUsedError;
  int get requiredDurationSeconds => throw _privateConstructorUsedError;
  List<SurveyResponseModel> get answers => throw _privateConstructorUsedError;
  EngagementEvidenceModel? get evidence => throw _privateConstructorUsedError;
  double? get tokensEarned => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  int get attemptNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Denormalized fields for targeting queries
  String? get threadId => throw _privateConstructorUsedError;
  String? get clientId =>
      throw _privateConstructorUsedError; // Streak audit fields
  int? get streakDayAtCompletion => throw _privateConstructorUsedError;
  double? get multiplierApplied =>
      throw _privateConstructorUsedError; // AdMob tracking fields
  bool get adWatched => throw _privateConstructorUsedError;
  String? get adTransactionId => throw _privateConstructorUsedError;
  DateTime? get adCompletedAt =>
      throw _privateConstructorUsedError; // Reward escrow fields
  String? get rewardItemId => throw _privateConstructorUsedError;
  String? get rewardCampaignName => throw _privateConstructorUsedError;
  String? get rewardType => throw _privateConstructorUsedError;

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementModelCopyWith<EngagementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementModelCopyWith<$Res> {
  factory $EngagementModelCopyWith(
    EngagementModel value,
    $Res Function(EngagementModel) then,
  ) = _$EngagementModelCopyWithImpl<$Res, EngagementModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? audienceCampaignId,
    String earnOpportunityId,
    String status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<SurveyResponseModel> answers,
    EngagementEvidenceModel? evidence,
    double? tokensEarned,
    String? failureReason,
    int attemptNumber,
    DateTime createdAt,
    DateTime? updatedAt,
    String? threadId,
    String? clientId,
    int? streakDayAtCompletion,
    double? multiplierApplied,
    bool adWatched,
    String? adTransactionId,
    DateTime? adCompletedAt,
    String? rewardItemId,
    String? rewardCampaignName,
    String? rewardType,
  });

  $EngagementEvidenceModelCopyWith<$Res>? get evidence;
}

/// @nodoc
class _$EngagementModelCopyWithImpl<$Res, $Val extends EngagementModel>
    implements $EngagementModelCopyWith<$Res> {
  _$EngagementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? audienceCampaignId = freezed,
    Object? earnOpportunityId = null,
    Object? status = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? watchDurationSeconds = null,
    Object? requiredDurationSeconds = null,
    Object? answers = null,
    Object? evidence = freezed,
    Object? tokensEarned = freezed,
    Object? failureReason = freezed,
    Object? attemptNumber = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? threadId = freezed,
    Object? clientId = freezed,
    Object? streakDayAtCompletion = freezed,
    Object? multiplierApplied = freezed,
    Object? adWatched = null,
    Object? adTransactionId = freezed,
    Object? adCompletedAt = freezed,
    Object? rewardItemId = freezed,
    Object? rewardCampaignName = freezed,
    Object? rewardType = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            audienceCampaignId: freezed == audienceCampaignId
                ? _value.audienceCampaignId
                : audienceCampaignId // ignore: cast_nullable_to_non_nullable
                      as String?,
            earnOpportunityId: null == earnOpportunityId
                ? _value.earnOpportunityId
                : earnOpportunityId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            watchDurationSeconds: null == watchDurationSeconds
                ? _value.watchDurationSeconds
                : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredDurationSeconds: null == requiredDurationSeconds
                ? _value.requiredDurationSeconds
                : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            answers: null == answers
                ? _value.answers
                : answers // ignore: cast_nullable_to_non_nullable
                      as List<SurveyResponseModel>,
            evidence: freezed == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as EngagementEvidenceModel?,
            tokensEarned: freezed == tokensEarned
                ? _value.tokensEarned
                : tokensEarned // ignore: cast_nullable_to_non_nullable
                      as double?,
            failureReason: freezed == failureReason
                ? _value.failureReason
                : failureReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            attemptNumber: null == attemptNumber
                ? _value.attemptNumber
                : attemptNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            threadId: freezed == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientId: freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            streakDayAtCompletion: freezed == streakDayAtCompletion
                ? _value.streakDayAtCompletion
                : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
                      as int?,
            multiplierApplied: freezed == multiplierApplied
                ? _value.multiplierApplied
                : multiplierApplied // ignore: cast_nullable_to_non_nullable
                      as double?,
            adWatched: null == adWatched
                ? _value.adWatched
                : adWatched // ignore: cast_nullable_to_non_nullable
                      as bool,
            adTransactionId: freezed == adTransactionId
                ? _value.adTransactionId
                : adTransactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            adCompletedAt: freezed == adCompletedAt
                ? _value.adCompletedAt
                : adCompletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            rewardItemId: freezed == rewardItemId
                ? _value.rewardItemId
                : rewardItemId // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EngagementEvidenceModelCopyWith<$Res>? get evidence {
    if (_value.evidence == null) {
      return null;
    }

    return $EngagementEvidenceModelCopyWith<$Res>(_value.evidence!, (value) {
      return _then(_value.copyWith(evidence: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EngagementModelImplCopyWith<$Res>
    implements $EngagementModelCopyWith<$Res> {
  factory _$$EngagementModelImplCopyWith(
    _$EngagementModelImpl value,
    $Res Function(_$EngagementModelImpl) then,
  ) = __$$EngagementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? audienceCampaignId,
    String earnOpportunityId,
    String status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<SurveyResponseModel> answers,
    EngagementEvidenceModel? evidence,
    double? tokensEarned,
    String? failureReason,
    int attemptNumber,
    DateTime createdAt,
    DateTime? updatedAt,
    String? threadId,
    String? clientId,
    int? streakDayAtCompletion,
    double? multiplierApplied,
    bool adWatched,
    String? adTransactionId,
    DateTime? adCompletedAt,
    String? rewardItemId,
    String? rewardCampaignName,
    String? rewardType,
  });

  @override
  $EngagementEvidenceModelCopyWith<$Res>? get evidence;
}

/// @nodoc
class __$$EngagementModelImplCopyWithImpl<$Res>
    extends _$EngagementModelCopyWithImpl<$Res, _$EngagementModelImpl>
    implements _$$EngagementModelImplCopyWith<$Res> {
  __$$EngagementModelImplCopyWithImpl(
    _$EngagementModelImpl _value,
    $Res Function(_$EngagementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? audienceCampaignId = freezed,
    Object? earnOpportunityId = null,
    Object? status = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? watchDurationSeconds = null,
    Object? requiredDurationSeconds = null,
    Object? answers = null,
    Object? evidence = freezed,
    Object? tokensEarned = freezed,
    Object? failureReason = freezed,
    Object? attemptNumber = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? threadId = freezed,
    Object? clientId = freezed,
    Object? streakDayAtCompletion = freezed,
    Object? multiplierApplied = freezed,
    Object? adWatched = null,
    Object? adTransactionId = freezed,
    Object? adCompletedAt = freezed,
    Object? rewardItemId = freezed,
    Object? rewardCampaignName = freezed,
    Object? rewardType = freezed,
  }) {
    return _then(
      _$EngagementModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        audienceCampaignId: freezed == audienceCampaignId
            ? _value.audienceCampaignId
            : audienceCampaignId // ignore: cast_nullable_to_non_nullable
                  as String?,
        earnOpportunityId: null == earnOpportunityId
            ? _value.earnOpportunityId
            : earnOpportunityId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        watchDurationSeconds: null == watchDurationSeconds
            ? _value.watchDurationSeconds
            : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredDurationSeconds: null == requiredDurationSeconds
            ? _value.requiredDurationSeconds
            : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        answers: null == answers
            ? _value._answers
            : answers // ignore: cast_nullable_to_non_nullable
                  as List<SurveyResponseModel>,
        evidence: freezed == evidence
            ? _value.evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as EngagementEvidenceModel?,
        tokensEarned: freezed == tokensEarned
            ? _value.tokensEarned
            : tokensEarned // ignore: cast_nullable_to_non_nullable
                  as double?,
        failureReason: freezed == failureReason
            ? _value.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        attemptNumber: null == attemptNumber
            ? _value.attemptNumber
            : attemptNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        threadId: freezed == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        streakDayAtCompletion: freezed == streakDayAtCompletion
            ? _value.streakDayAtCompletion
            : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
                  as int?,
        multiplierApplied: freezed == multiplierApplied
            ? _value.multiplierApplied
            : multiplierApplied // ignore: cast_nullable_to_non_nullable
                  as double?,
        adWatched: null == adWatched
            ? _value.adWatched
            : adWatched // ignore: cast_nullable_to_non_nullable
                  as bool,
        adTransactionId: freezed == adTransactionId
            ? _value.adTransactionId
            : adTransactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        adCompletedAt: freezed == adCompletedAt
            ? _value.adCompletedAt
            : adCompletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rewardItemId: freezed == rewardItemId
            ? _value.rewardItemId
            : rewardItemId // ignore: cast_nullable_to_non_nullable
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

class _$EngagementModelImpl extends _EngagementModel {
  const _$EngagementModelImpl({
    required this.id,
    required this.userId,
    this.audienceCampaignId,
    required this.earnOpportunityId,
    required this.status,
    required this.startedAt,
    this.completedAt,
    required this.watchDurationSeconds,
    required this.requiredDurationSeconds,
    required final List<SurveyResponseModel> answers,
    this.evidence,
    this.tokensEarned,
    this.failureReason,
    required this.attemptNumber,
    required this.createdAt,
    this.updatedAt,
    this.threadId,
    this.clientId,
    this.streakDayAtCompletion,
    this.multiplierApplied,
    this.adWatched = false,
    this.adTransactionId,
    this.adCompletedAt,
    this.rewardItemId,
    this.rewardCampaignName,
    this.rewardType,
  }) : _answers = answers,
       super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? audienceCampaignId;
  @override
  final String earnOpportunityId;
  @override
  final String status;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int watchDurationSeconds;
  @override
  final int requiredDurationSeconds;
  final List<SurveyResponseModel> _answers;
  @override
  List<SurveyResponseModel> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final EngagementEvidenceModel? evidence;
  @override
  final double? tokensEarned;
  @override
  final String? failureReason;
  @override
  final int attemptNumber;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  // Denormalized fields for targeting queries
  @override
  final String? threadId;
  @override
  final String? clientId;
  // Streak audit fields
  @override
  final int? streakDayAtCompletion;
  @override
  final double? multiplierApplied;
  // AdMob tracking fields
  @override
  @JsonKey()
  final bool adWatched;
  @override
  final String? adTransactionId;
  @override
  final DateTime? adCompletedAt;
  // Reward escrow fields
  @override
  final String? rewardItemId;
  @override
  final String? rewardCampaignName;
  @override
  final String? rewardType;

  @override
  String toString() {
    return 'EngagementModel(id: $id, userId: $userId, audienceCampaignId: $audienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.audienceCampaignId, audienceCampaignId) ||
                other.audienceCampaignId == audienceCampaignId) &&
            (identical(other.earnOpportunityId, earnOpportunityId) ||
                other.earnOpportunityId == earnOpportunityId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.watchDurationSeconds, watchDurationSeconds) ||
                other.watchDurationSeconds == watchDurationSeconds) &&
            (identical(
                  other.requiredDurationSeconds,
                  requiredDurationSeconds,
                ) ||
                other.requiredDurationSeconds == requiredDurationSeconds) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.evidence, evidence) ||
                other.evidence == evidence) &&
            (identical(other.tokensEarned, tokensEarned) ||
                other.tokensEarned == tokensEarned) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.attemptNumber, attemptNumber) ||
                other.attemptNumber == attemptNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.streakDayAtCompletion, streakDayAtCompletion) ||
                other.streakDayAtCompletion == streakDayAtCompletion) &&
            (identical(other.multiplierApplied, multiplierApplied) ||
                other.multiplierApplied == multiplierApplied) &&
            (identical(other.adWatched, adWatched) ||
                other.adWatched == adWatched) &&
            (identical(other.adTransactionId, adTransactionId) ||
                other.adTransactionId == adTransactionId) &&
            (identical(other.adCompletedAt, adCompletedAt) ||
                other.adCompletedAt == adCompletedAt) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.rewardCampaignName, rewardCampaignName) ||
                other.rewardCampaignName == rewardCampaignName) &&
            (identical(other.rewardType, rewardType) ||
                other.rewardType == rewardType));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    audienceCampaignId,
    earnOpportunityId,
    status,
    startedAt,
    completedAt,
    watchDurationSeconds,
    requiredDurationSeconds,
    const DeepCollectionEquality().hash(_answers),
    evidence,
    tokensEarned,
    failureReason,
    attemptNumber,
    createdAt,
    updatedAt,
    threadId,
    clientId,
    streakDayAtCompletion,
    multiplierApplied,
    adWatched,
    adTransactionId,
    adCompletedAt,
    rewardItemId,
    rewardCampaignName,
    rewardType,
  ]);

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementModelImplCopyWith<_$EngagementModelImpl> get copyWith =>
      __$$EngagementModelImplCopyWithImpl<_$EngagementModelImpl>(
        this,
        _$identity,
      );
}

abstract class _EngagementModel extends EngagementModel {
  const factory _EngagementModel({
    required final String id,
    required final String userId,
    final String? audienceCampaignId,
    required final String earnOpportunityId,
    required final String status,
    required final DateTime startedAt,
    final DateTime? completedAt,
    required final int watchDurationSeconds,
    required final int requiredDurationSeconds,
    required final List<SurveyResponseModel> answers,
    final EngagementEvidenceModel? evidence,
    final double? tokensEarned,
    final String? failureReason,
    required final int attemptNumber,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final String? threadId,
    final String? clientId,
    final int? streakDayAtCompletion,
    final double? multiplierApplied,
    final bool adWatched,
    final String? adTransactionId,
    final DateTime? adCompletedAt,
    final String? rewardItemId,
    final String? rewardCampaignName,
    final String? rewardType,
  }) = _$EngagementModelImpl;
  const _EngagementModel._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get audienceCampaignId;
  @override
  String get earnOpportunityId;
  @override
  String get status;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int get watchDurationSeconds;
  @override
  int get requiredDurationSeconds;
  @override
  List<SurveyResponseModel> get answers;
  @override
  EngagementEvidenceModel? get evidence;
  @override
  double? get tokensEarned;
  @override
  String? get failureReason;
  @override
  int get attemptNumber;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt; // Denormalized fields for targeting queries
  @override
  String? get threadId;
  @override
  String? get clientId; // Streak audit fields
  @override
  int? get streakDayAtCompletion;
  @override
  double? get multiplierApplied; // AdMob tracking fields
  @override
  bool get adWatched;
  @override
  String? get adTransactionId;
  @override
  DateTime? get adCompletedAt; // Reward escrow fields
  @override
  String? get rewardItemId;
  @override
  String? get rewardCampaignName;
  @override
  String? get rewardType;

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementModelImplCopyWith<_$EngagementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
