// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PollOption _$PollOptionFromJson(Map<String, dynamic> json) {
  return _PollOption.fromJson(json);
}

/// @nodoc
mixin _$PollOption {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Serializes this PollOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollOptionCopyWith<PollOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollOptionCopyWith<$Res> {
  factory $PollOptionCopyWith(
    PollOption value,
    $Res Function(PollOption) then,
  ) = _$PollOptionCopyWithImpl<$Res, PollOption>;
  @useResult
  $Res call({String id, String text});
}

/// @nodoc
class _$PollOptionCopyWithImpl<$Res, $Val extends PollOption>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? text = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollOptionImplCopyWith<$Res>
    implements $PollOptionCopyWith<$Res> {
  factory _$$PollOptionImplCopyWith(
    _$PollOptionImpl value,
    $Res Function(_$PollOptionImpl) then,
  ) = __$$PollOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text});
}

/// @nodoc
class __$$PollOptionImplCopyWithImpl<$Res>
    extends _$PollOptionCopyWithImpl<$Res, _$PollOptionImpl>
    implements _$$PollOptionImplCopyWith<$Res> {
  __$$PollOptionImplCopyWithImpl(
    _$PollOptionImpl _value,
    $Res Function(_$PollOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? text = null}) {
    return _then(
      _$PollOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PollOptionImpl implements _PollOption {
  const _$PollOptionImpl({required this.id, required this.text});

  factory _$PollOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String text;

  @override
  String toString() {
    return 'PollOption(id: $id, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text);

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      __$$PollOptionImplCopyWithImpl<_$PollOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollOptionImplToJson(this);
  }
}

abstract class _PollOption implements PollOption {
  const factory _PollOption({
    required final String id,
    required final String text,
  }) = _$PollOptionImpl;

  factory _PollOption.fromJson(Map<String, dynamic> json) =
      _$PollOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Poll _$PollFromJson(Map<String, dynamic> json) {
  return _Poll.fromJson(json);
}

/// @nodoc
mixin _$Poll {
  String get id => throw _privateConstructorUsedError;
  String get opportunityId => throw _privateConstructorUsedError;
  String get threadId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<PollOption> get options => throw _privateConstructorUsedError;
  PollStatus get status => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  bool get showResultsAfterVote => throw _privateConstructorUsedError;
  bool get allowChangeVote => throw _privateConstructorUsedError;
  DateTime? get openedAt => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  int get totalRespondents => throw _privateConstructorUsedError;
  Map<String, int> get optionCounts => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this Poll to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollCopyWith<Poll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollCopyWith<$Res> {
  factory $PollCopyWith(Poll value, $Res Function(Poll) then) =
      _$PollCopyWithImpl<$Res, Poll>;
  @useResult
  $Res call({
    String id,
    String opportunityId,
    String threadId,
    String clientId,
    String question,
    List<PollOption> options,
    PollStatus status,
    bool isAnonymous,
    bool showResultsAfterVote,
    bool allowChangeVote,
    DateTime? openedAt,
    DateTime? closedAt,
    int totalRespondents,
    Map<String, int> optionCounts,
    DateTime createdAt,
    DateTime? updatedAt,
    String createdBy,
  });
}

/// @nodoc
class _$PollCopyWithImpl<$Res, $Val extends Poll>
    implements $PollCopyWith<$Res> {
  _$PollCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? opportunityId = null,
    Object? threadId = null,
    Object? clientId = null,
    Object? question = null,
    Object? options = null,
    Object? status = null,
    Object? isAnonymous = null,
    Object? showResultsAfterVote = null,
    Object? allowChangeVote = null,
    Object? openedAt = freezed,
    Object? closedAt = freezed,
    Object? totalRespondents = null,
    Object? optionCounts = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? createdBy = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            opportunityId: null == opportunityId
                ? _value.opportunityId
                : opportunityId // ignore: cast_nullable_to_non_nullable
                      as String,
            threadId: null == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<PollOption>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PollStatus,
            isAnonymous: null == isAnonymous
                ? _value.isAnonymous
                : isAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            showResultsAfterVote: null == showResultsAfterVote
                ? _value.showResultsAfterVote
                : showResultsAfterVote // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowChangeVote: null == allowChangeVote
                ? _value.allowChangeVote
                : allowChangeVote // ignore: cast_nullable_to_non_nullable
                      as bool,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            closedAt: freezed == closedAt
                ? _value.closedAt
                : closedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            totalRespondents: null == totalRespondents
                ? _value.totalRespondents
                : totalRespondents // ignore: cast_nullable_to_non_nullable
                      as int,
            optionCounts: null == optionCounts
                ? _value.optionCounts
                : optionCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollImplCopyWith<$Res> implements $PollCopyWith<$Res> {
  factory _$$PollImplCopyWith(
    _$PollImpl value,
    $Res Function(_$PollImpl) then,
  ) = __$$PollImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String opportunityId,
    String threadId,
    String clientId,
    String question,
    List<PollOption> options,
    PollStatus status,
    bool isAnonymous,
    bool showResultsAfterVote,
    bool allowChangeVote,
    DateTime? openedAt,
    DateTime? closedAt,
    int totalRespondents,
    Map<String, int> optionCounts,
    DateTime createdAt,
    DateTime? updatedAt,
    String createdBy,
  });
}

/// @nodoc
class __$$PollImplCopyWithImpl<$Res>
    extends _$PollCopyWithImpl<$Res, _$PollImpl>
    implements _$$PollImplCopyWith<$Res> {
  __$$PollImplCopyWithImpl(_$PollImpl _value, $Res Function(_$PollImpl) _then)
    : super(_value, _then);

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? opportunityId = null,
    Object? threadId = null,
    Object? clientId = null,
    Object? question = null,
    Object? options = null,
    Object? status = null,
    Object? isAnonymous = null,
    Object? showResultsAfterVote = null,
    Object? allowChangeVote = null,
    Object? openedAt = freezed,
    Object? closedAt = freezed,
    Object? totalRespondents = null,
    Object? optionCounts = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? createdBy = null,
  }) {
    return _then(
      _$PollImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        opportunityId: null == opportunityId
            ? _value.opportunityId
            : opportunityId // ignore: cast_nullable_to_non_nullable
                  as String,
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<PollOption>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PollStatus,
        isAnonymous: null == isAnonymous
            ? _value.isAnonymous
            : isAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        showResultsAfterVote: null == showResultsAfterVote
            ? _value.showResultsAfterVote
            : showResultsAfterVote // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowChangeVote: null == allowChangeVote
            ? _value.allowChangeVote
            : allowChangeVote // ignore: cast_nullable_to_non_nullable
                  as bool,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        closedAt: freezed == closedAt
            ? _value.closedAt
            : closedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalRespondents: null == totalRespondents
            ? _value.totalRespondents
            : totalRespondents // ignore: cast_nullable_to_non_nullable
                  as int,
        optionCounts: null == optionCounts
            ? _value._optionCounts
            : optionCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PollImpl extends _Poll {
  const _$PollImpl({
    required this.id,
    required this.opportunityId,
    required this.threadId,
    required this.clientId,
    required this.question,
    required final List<PollOption> options,
    required this.status,
    this.isAnonymous = false,
    this.showResultsAfterVote = true,
    this.allowChangeVote = true,
    this.openedAt,
    this.closedAt,
    this.totalRespondents = 0,
    final Map<String, int> optionCounts = const {},
    required this.createdAt,
    this.updatedAt,
    required this.createdBy,
  }) : _options = options,
       _optionCounts = optionCounts,
       super._();

  factory _$PollImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollImplFromJson(json);

  @override
  final String id;
  @override
  final String opportunityId;
  @override
  final String threadId;
  @override
  final String clientId;
  @override
  final String question;
  final List<PollOption> _options;
  @override
  List<PollOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final PollStatus status;
  @override
  @JsonKey()
  final bool isAnonymous;
  @override
  @JsonKey()
  final bool showResultsAfterVote;
  @override
  @JsonKey()
  final bool allowChangeVote;
  @override
  final DateTime? openedAt;
  @override
  final DateTime? closedAt;
  @override
  @JsonKey()
  final int totalRespondents;
  final Map<String, int> _optionCounts;
  @override
  @JsonKey()
  Map<String, int> get optionCounts {
    if (_optionCounts is EqualUnmodifiableMapView) return _optionCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_optionCounts);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String createdBy;

  @override
  String toString() {
    return 'Poll(id: $id, opportunityId: $opportunityId, threadId: $threadId, clientId: $clientId, question: $question, options: $options, status: $status, isAnonymous: $isAnonymous, showResultsAfterVote: $showResultsAfterVote, allowChangeVote: $allowChangeVote, openedAt: $openedAt, closedAt: $closedAt, totalRespondents: $totalRespondents, optionCounts: $optionCounts, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.opportunityId, opportunityId) ||
                other.opportunityId == opportunityId) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.showResultsAfterVote, showResultsAfterVote) ||
                other.showResultsAfterVote == showResultsAfterVote) &&
            (identical(other.allowChangeVote, allowChangeVote) ||
                other.allowChangeVote == allowChangeVote) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.totalRespondents, totalRespondents) ||
                other.totalRespondents == totalRespondents) &&
            const DeepCollectionEquality().equals(
              other._optionCounts,
              _optionCounts,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    opportunityId,
    threadId,
    clientId,
    question,
    const DeepCollectionEquality().hash(_options),
    status,
    isAnonymous,
    showResultsAfterVote,
    allowChangeVote,
    openedAt,
    closedAt,
    totalRespondents,
    const DeepCollectionEquality().hash(_optionCounts),
    createdAt,
    updatedAt,
    createdBy,
  );

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollImplCopyWith<_$PollImpl> get copyWith =>
      __$$PollImplCopyWithImpl<_$PollImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollImplToJson(this);
  }
}

abstract class _Poll extends Poll {
  const factory _Poll({
    required final String id,
    required final String opportunityId,
    required final String threadId,
    required final String clientId,
    required final String question,
    required final List<PollOption> options,
    required final PollStatus status,
    final bool isAnonymous,
    final bool showResultsAfterVote,
    final bool allowChangeVote,
    final DateTime? openedAt,
    final DateTime? closedAt,
    final int totalRespondents,
    final Map<String, int> optionCounts,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    required final String createdBy,
  }) = _$PollImpl;
  const _Poll._() : super._();

  factory _Poll.fromJson(Map<String, dynamic> json) = _$PollImpl.fromJson;

  @override
  String get id;
  @override
  String get opportunityId;
  @override
  String get threadId;
  @override
  String get clientId;
  @override
  String get question;
  @override
  List<PollOption> get options;
  @override
  PollStatus get status;
  @override
  bool get isAnonymous;
  @override
  bool get showResultsAfterVote;
  @override
  bool get allowChangeVote;
  @override
  DateTime? get openedAt;
  @override
  DateTime? get closedAt;
  @override
  int get totalRespondents;
  @override
  Map<String, int> get optionCounts;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String get createdBy;

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollImplCopyWith<_$PollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollResponse _$PollResponseFromJson(Map<String, dynamic> json) {
  return _PollResponse.fromJson(json);
}

/// @nodoc
mixin _$PollResponse {
  String get userId => throw _privateConstructorUsedError;
  String get pollId => throw _privateConstructorUsedError;
  String get selectedOption => throw _privateConstructorUsedError;
  String? get previousOption => throw _privateConstructorUsedError;
  int get voteCount => throw _privateConstructorUsedError;
  DateTime get respondedAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get invalidatedAt => throw _privateConstructorUsedError;
  String? get invalidatedBy => throw _privateConstructorUsedError;
  String? get invalidationReason => throw _privateConstructorUsedError;
  String? get engagementId => throw _privateConstructorUsedError;
  bool get tokensAwarded => throw _privateConstructorUsedError;
  Map<String, String?>? get demographics => throw _privateConstructorUsedError;

  /// Serializes this PollResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollResponseCopyWith<PollResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollResponseCopyWith<$Res> {
  factory $PollResponseCopyWith(
    PollResponse value,
    $Res Function(PollResponse) then,
  ) = _$PollResponseCopyWithImpl<$Res, PollResponse>;
  @useResult
  $Res call({
    String userId,
    String pollId,
    String selectedOption,
    String? previousOption,
    int voteCount,
    DateTime respondedAt,
    DateTime? updatedAt,
    String status,
    DateTime? invalidatedAt,
    String? invalidatedBy,
    String? invalidationReason,
    String? engagementId,
    bool tokensAwarded,
    Map<String, String?>? demographics,
  });
}

/// @nodoc
class _$PollResponseCopyWithImpl<$Res, $Val extends PollResponse>
    implements $PollResponseCopyWith<$Res> {
  _$PollResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pollId = null,
    Object? selectedOption = null,
    Object? previousOption = freezed,
    Object? voteCount = null,
    Object? respondedAt = null,
    Object? updatedAt = freezed,
    Object? status = null,
    Object? invalidatedAt = freezed,
    Object? invalidatedBy = freezed,
    Object? invalidationReason = freezed,
    Object? engagementId = freezed,
    Object? tokensAwarded = null,
    Object? demographics = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            pollId: null == pollId
                ? _value.pollId
                : pollId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedOption: null == selectedOption
                ? _value.selectedOption
                : selectedOption // ignore: cast_nullable_to_non_nullable
                      as String,
            previousOption: freezed == previousOption
                ? _value.previousOption
                : previousOption // ignore: cast_nullable_to_non_nullable
                      as String?,
            voteCount: null == voteCount
                ? _value.voteCount
                : voteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            respondedAt: null == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            invalidatedAt: freezed == invalidatedAt
                ? _value.invalidatedAt
                : invalidatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            invalidatedBy: freezed == invalidatedBy
                ? _value.invalidatedBy
                : invalidatedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            invalidationReason: freezed == invalidationReason
                ? _value.invalidationReason
                : invalidationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            engagementId: freezed == engagementId
                ? _value.engagementId
                : engagementId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokensAwarded: null == tokensAwarded
                ? _value.tokensAwarded
                : tokensAwarded // ignore: cast_nullable_to_non_nullable
                      as bool,
            demographics: freezed == demographics
                ? _value.demographics
                : demographics // ignore: cast_nullable_to_non_nullable
                      as Map<String, String?>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollResponseImplCopyWith<$Res>
    implements $PollResponseCopyWith<$Res> {
  factory _$$PollResponseImplCopyWith(
    _$PollResponseImpl value,
    $Res Function(_$PollResponseImpl) then,
  ) = __$$PollResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String pollId,
    String selectedOption,
    String? previousOption,
    int voteCount,
    DateTime respondedAt,
    DateTime? updatedAt,
    String status,
    DateTime? invalidatedAt,
    String? invalidatedBy,
    String? invalidationReason,
    String? engagementId,
    bool tokensAwarded,
    Map<String, String?>? demographics,
  });
}

/// @nodoc
class __$$PollResponseImplCopyWithImpl<$Res>
    extends _$PollResponseCopyWithImpl<$Res, _$PollResponseImpl>
    implements _$$PollResponseImplCopyWith<$Res> {
  __$$PollResponseImplCopyWithImpl(
    _$PollResponseImpl _value,
    $Res Function(_$PollResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PollResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pollId = null,
    Object? selectedOption = null,
    Object? previousOption = freezed,
    Object? voteCount = null,
    Object? respondedAt = null,
    Object? updatedAt = freezed,
    Object? status = null,
    Object? invalidatedAt = freezed,
    Object? invalidatedBy = freezed,
    Object? invalidationReason = freezed,
    Object? engagementId = freezed,
    Object? tokensAwarded = null,
    Object? demographics = freezed,
  }) {
    return _then(
      _$PollResponseImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        pollId: null == pollId
            ? _value.pollId
            : pollId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedOption: null == selectedOption
            ? _value.selectedOption
            : selectedOption // ignore: cast_nullable_to_non_nullable
                  as String,
        previousOption: freezed == previousOption
            ? _value.previousOption
            : previousOption // ignore: cast_nullable_to_non_nullable
                  as String?,
        voteCount: null == voteCount
            ? _value.voteCount
            : voteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        respondedAt: null == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        invalidatedAt: freezed == invalidatedAt
            ? _value.invalidatedAt
            : invalidatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        invalidatedBy: freezed == invalidatedBy
            ? _value.invalidatedBy
            : invalidatedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        invalidationReason: freezed == invalidationReason
            ? _value.invalidationReason
            : invalidationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        engagementId: freezed == engagementId
            ? _value.engagementId
            : engagementId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokensAwarded: null == tokensAwarded
            ? _value.tokensAwarded
            : tokensAwarded // ignore: cast_nullable_to_non_nullable
                  as bool,
        demographics: freezed == demographics
            ? _value._demographics
            : demographics // ignore: cast_nullable_to_non_nullable
                  as Map<String, String?>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PollResponseImpl extends _PollResponse {
  const _$PollResponseImpl({
    required this.userId,
    required this.pollId,
    required this.selectedOption,
    this.previousOption,
    this.voteCount = 1,
    required this.respondedAt,
    this.updatedAt,
    this.status = 'valid',
    this.invalidatedAt,
    this.invalidatedBy,
    this.invalidationReason,
    this.engagementId,
    this.tokensAwarded = false,
    final Map<String, String?>? demographics,
  }) : _demographics = demographics,
       super._();

  factory _$PollResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollResponseImplFromJson(json);

  @override
  final String userId;
  @override
  final String pollId;
  @override
  final String selectedOption;
  @override
  final String? previousOption;
  @override
  @JsonKey()
  final int voteCount;
  @override
  final DateTime respondedAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? invalidatedAt;
  @override
  final String? invalidatedBy;
  @override
  final String? invalidationReason;
  @override
  final String? engagementId;
  @override
  @JsonKey()
  final bool tokensAwarded;
  final Map<String, String?>? _demographics;
  @override
  Map<String, String?>? get demographics {
    final value = _demographics;
    if (value == null) return null;
    if (_demographics is EqualUnmodifiableMapView) return _demographics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PollResponse(userId: $userId, pollId: $pollId, selectedOption: $selectedOption, previousOption: $previousOption, voteCount: $voteCount, respondedAt: $respondedAt, updatedAt: $updatedAt, status: $status, invalidatedAt: $invalidatedAt, invalidatedBy: $invalidatedBy, invalidationReason: $invalidationReason, engagementId: $engagementId, tokensAwarded: $tokensAwarded, demographics: $demographics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollResponseImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pollId, pollId) || other.pollId == pollId) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption) &&
            (identical(other.previousOption, previousOption) ||
                other.previousOption == previousOption) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invalidatedAt, invalidatedAt) ||
                other.invalidatedAt == invalidatedAt) &&
            (identical(other.invalidatedBy, invalidatedBy) ||
                other.invalidatedBy == invalidatedBy) &&
            (identical(other.invalidationReason, invalidationReason) ||
                other.invalidationReason == invalidationReason) &&
            (identical(other.engagementId, engagementId) ||
                other.engagementId == engagementId) &&
            (identical(other.tokensAwarded, tokensAwarded) ||
                other.tokensAwarded == tokensAwarded) &&
            const DeepCollectionEquality().equals(
              other._demographics,
              _demographics,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    pollId,
    selectedOption,
    previousOption,
    voteCount,
    respondedAt,
    updatedAt,
    status,
    invalidatedAt,
    invalidatedBy,
    invalidationReason,
    engagementId,
    tokensAwarded,
    const DeepCollectionEquality().hash(_demographics),
  );

  /// Create a copy of PollResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollResponseImplCopyWith<_$PollResponseImpl> get copyWith =>
      __$$PollResponseImplCopyWithImpl<_$PollResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollResponseImplToJson(this);
  }
}

abstract class _PollResponse extends PollResponse {
  const factory _PollResponse({
    required final String userId,
    required final String pollId,
    required final String selectedOption,
    final String? previousOption,
    final int voteCount,
    required final DateTime respondedAt,
    final DateTime? updatedAt,
    final String status,
    final DateTime? invalidatedAt,
    final String? invalidatedBy,
    final String? invalidationReason,
    final String? engagementId,
    final bool tokensAwarded,
    final Map<String, String?>? demographics,
  }) = _$PollResponseImpl;
  const _PollResponse._() : super._();

  factory _PollResponse.fromJson(Map<String, dynamic> json) =
      _$PollResponseImpl.fromJson;

  @override
  String get userId;
  @override
  String get pollId;
  @override
  String get selectedOption;
  @override
  String? get previousOption;
  @override
  int get voteCount;
  @override
  DateTime get respondedAt;
  @override
  DateTime? get updatedAt;
  @override
  String get status;
  @override
  DateTime? get invalidatedAt;
  @override
  String? get invalidatedBy;
  @override
  String? get invalidationReason;
  @override
  String? get engagementId;
  @override
  bool get tokensAwarded;
  @override
  Map<String, String?>? get demographics;

  /// Create a copy of PollResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollResponseImplCopyWith<_$PollResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollResults _$PollResultsFromJson(Map<String, dynamic> json) {
  return _PollResults.fromJson(json);
}

/// @nodoc
mixin _$PollResults {
  int get totalRespondents => throw _privateConstructorUsedError;
  Map<String, int> get optionCounts => throw _privateConstructorUsedError;
  Map<String, double> get percentages => throw _privateConstructorUsedError;

  /// Serializes this PollResults to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollResultsCopyWith<PollResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollResultsCopyWith<$Res> {
  factory $PollResultsCopyWith(
    PollResults value,
    $Res Function(PollResults) then,
  ) = _$PollResultsCopyWithImpl<$Res, PollResults>;
  @useResult
  $Res call({
    int totalRespondents,
    Map<String, int> optionCounts,
    Map<String, double> percentages,
  });
}

/// @nodoc
class _$PollResultsCopyWithImpl<$Res, $Val extends PollResults>
    implements $PollResultsCopyWith<$Res> {
  _$PollResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRespondents = null,
    Object? optionCounts = null,
    Object? percentages = null,
  }) {
    return _then(
      _value.copyWith(
            totalRespondents: null == totalRespondents
                ? _value.totalRespondents
                : totalRespondents // ignore: cast_nullable_to_non_nullable
                      as int,
            optionCounts: null == optionCounts
                ? _value.optionCounts
                : optionCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            percentages: null == percentages
                ? _value.percentages
                : percentages // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollResultsImplCopyWith<$Res>
    implements $PollResultsCopyWith<$Res> {
  factory _$$PollResultsImplCopyWith(
    _$PollResultsImpl value,
    $Res Function(_$PollResultsImpl) then,
  ) = __$$PollResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalRespondents,
    Map<String, int> optionCounts,
    Map<String, double> percentages,
  });
}

/// @nodoc
class __$$PollResultsImplCopyWithImpl<$Res>
    extends _$PollResultsCopyWithImpl<$Res, _$PollResultsImpl>
    implements _$$PollResultsImplCopyWith<$Res> {
  __$$PollResultsImplCopyWithImpl(
    _$PollResultsImpl _value,
    $Res Function(_$PollResultsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PollResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRespondents = null,
    Object? optionCounts = null,
    Object? percentages = null,
  }) {
    return _then(
      _$PollResultsImpl(
        totalRespondents: null == totalRespondents
            ? _value.totalRespondents
            : totalRespondents // ignore: cast_nullable_to_non_nullable
                  as int,
        optionCounts: null == optionCounts
            ? _value._optionCounts
            : optionCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        percentages: null == percentages
            ? _value._percentages
            : percentages // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PollResultsImpl implements _PollResults {
  const _$PollResultsImpl({
    required this.totalRespondents,
    required final Map<String, int> optionCounts,
    required final Map<String, double> percentages,
  }) : _optionCounts = optionCounts,
       _percentages = percentages;

  factory _$PollResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollResultsImplFromJson(json);

  @override
  final int totalRespondents;
  final Map<String, int> _optionCounts;
  @override
  Map<String, int> get optionCounts {
    if (_optionCounts is EqualUnmodifiableMapView) return _optionCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_optionCounts);
  }

  final Map<String, double> _percentages;
  @override
  Map<String, double> get percentages {
    if (_percentages is EqualUnmodifiableMapView) return _percentages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_percentages);
  }

  @override
  String toString() {
    return 'PollResults(totalRespondents: $totalRespondents, optionCounts: $optionCounts, percentages: $percentages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollResultsImpl &&
            (identical(other.totalRespondents, totalRespondents) ||
                other.totalRespondents == totalRespondents) &&
            const DeepCollectionEquality().equals(
              other._optionCounts,
              _optionCounts,
            ) &&
            const DeepCollectionEquality().equals(
              other._percentages,
              _percentages,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalRespondents,
    const DeepCollectionEquality().hash(_optionCounts),
    const DeepCollectionEquality().hash(_percentages),
  );

  /// Create a copy of PollResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollResultsImplCopyWith<_$PollResultsImpl> get copyWith =>
      __$$PollResultsImplCopyWithImpl<_$PollResultsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollResultsImplToJson(this);
  }
}

abstract class _PollResults implements PollResults {
  const factory _PollResults({
    required final int totalRespondents,
    required final Map<String, int> optionCounts,
    required final Map<String, double> percentages,
  }) = _$PollResultsImpl;

  factory _PollResults.fromJson(Map<String, dynamic> json) =
      _$PollResultsImpl.fromJson;

  @override
  int get totalRespondents;
  @override
  Map<String, int> get optionCounts;
  @override
  Map<String, double> get percentages;

  /// Create a copy of PollResults
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollResultsImplCopyWith<_$PollResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
