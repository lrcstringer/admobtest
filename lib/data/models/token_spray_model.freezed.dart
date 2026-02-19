// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_spray_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TokenSprayModel {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String get communityName => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String get creatorName => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  String get occasion => throw _privateConstructorUsedError;
  String get occasionText => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int? get targetAmount => throw _privateConstructorUsedError;
  int get currentTotal => throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>> get contributions =>
      throw _privateConstructorUsedError;
  int get contributorCount => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get topContributors =>
      throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  DateTime? get claimedAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Create a copy of TokenSprayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenSprayModelCopyWith<TokenSprayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSprayModelCopyWith<$Res> {
  factory $TokenSprayModelCopyWith(
    TokenSprayModel value,
    $Res Function(TokenSprayModel) then,
  ) = _$TokenSprayModelCopyWithImpl<$Res, TokenSprayModel>;
  @useResult
  $Res call({
    String id,
    String communityId,
    String communityName,
    String messageId,
    String creatorId,
    String creatorName,
    String recipientId,
    String recipientName,
    String occasion,
    String occasionText,
    String message,
    int? targetAmount,
    int currentTotal,
    Map<String, Map<String, dynamic>> contributions,
    int contributorCount,
    List<Map<String, dynamic>> topContributors,
    String status,
    DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    DateTime expiresAt,
  });
}

/// @nodoc
class _$TokenSprayModelCopyWithImpl<$Res, $Val extends TokenSprayModel>
    implements $TokenSprayModelCopyWith<$Res> {
  _$TokenSprayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenSprayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? communityName = null,
    Object? messageId = null,
    Object? creatorId = null,
    Object? creatorName = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? occasion = null,
    Object? occasionText = null,
    Object? message = null,
    Object? targetAmount = freezed,
    Object? currentTotal = null,
    Object? contributions = null,
    Object? contributorCount = null,
    Object? topContributors = null,
    Object? status = null,
    Object? createdAt = null,
    Object? closedAt = freezed,
    Object? claimedAt = freezed,
    Object? expiresAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            communityId: null == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String,
            communityName: null == communityName
                ? _value.communityName
                : communityName // ignore: cast_nullable_to_non_nullable
                      as String,
            messageId: null == messageId
                ? _value.messageId
                : messageId // ignore: cast_nullable_to_non_nullable
                      as String,
            creatorId: null == creatorId
                ? _value.creatorId
                : creatorId // ignore: cast_nullable_to_non_nullable
                      as String,
            creatorName: null == creatorName
                ? _value.creatorName
                : creatorName // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientId: null == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientName: null == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                      as String,
            occasion: null == occasion
                ? _value.occasion
                : occasion // ignore: cast_nullable_to_non_nullable
                      as String,
            occasionText: null == occasionText
                ? _value.occasionText
                : occasionText // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            targetAmount: freezed == targetAmount
                ? _value.targetAmount
                : targetAmount // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentTotal: null == currentTotal
                ? _value.currentTotal
                : currentTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            contributions: null == contributions
                ? _value.contributions
                : contributions // ignore: cast_nullable_to_non_nullable
                      as Map<String, Map<String, dynamic>>,
            contributorCount: null == contributorCount
                ? _value.contributorCount
                : contributorCount // ignore: cast_nullable_to_non_nullable
                      as int,
            topContributors: null == topContributors
                ? _value.topContributors
                : topContributors // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            closedAt: freezed == closedAt
                ? _value.closedAt
                : closedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            claimedAt: freezed == claimedAt
                ? _value.claimedAt
                : claimedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenSprayModelImplCopyWith<$Res>
    implements $TokenSprayModelCopyWith<$Res> {
  factory _$$TokenSprayModelImplCopyWith(
    _$TokenSprayModelImpl value,
    $Res Function(_$TokenSprayModelImpl) then,
  ) = __$$TokenSprayModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String communityId,
    String communityName,
    String messageId,
    String creatorId,
    String creatorName,
    String recipientId,
    String recipientName,
    String occasion,
    String occasionText,
    String message,
    int? targetAmount,
    int currentTotal,
    Map<String, Map<String, dynamic>> contributions,
    int contributorCount,
    List<Map<String, dynamic>> topContributors,
    String status,
    DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    DateTime expiresAt,
  });
}

/// @nodoc
class __$$TokenSprayModelImplCopyWithImpl<$Res>
    extends _$TokenSprayModelCopyWithImpl<$Res, _$TokenSprayModelImpl>
    implements _$$TokenSprayModelImplCopyWith<$Res> {
  __$$TokenSprayModelImplCopyWithImpl(
    _$TokenSprayModelImpl _value,
    $Res Function(_$TokenSprayModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? communityName = null,
    Object? messageId = null,
    Object? creatorId = null,
    Object? creatorName = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? occasion = null,
    Object? occasionText = null,
    Object? message = null,
    Object? targetAmount = freezed,
    Object? currentTotal = null,
    Object? contributions = null,
    Object? contributorCount = null,
    Object? topContributors = null,
    Object? status = null,
    Object? createdAt = null,
    Object? closedAt = freezed,
    Object? claimedAt = freezed,
    Object? expiresAt = null,
  }) {
    return _then(
      _$TokenSprayModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        communityName: null == communityName
            ? _value.communityName
            : communityName // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        creatorId: null == creatorId
            ? _value.creatorId
            : creatorId // ignore: cast_nullable_to_non_nullable
                  as String,
        creatorName: null == creatorName
            ? _value.creatorName
            : creatorName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientName: null == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String,
        occasion: null == occasion
            ? _value.occasion
            : occasion // ignore: cast_nullable_to_non_nullable
                  as String,
        occasionText: null == occasionText
            ? _value.occasionText
            : occasionText // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        targetAmount: freezed == targetAmount
            ? _value.targetAmount
            : targetAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentTotal: null == currentTotal
            ? _value.currentTotal
            : currentTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        contributions: null == contributions
            ? _value._contributions
            : contributions // ignore: cast_nullable_to_non_nullable
                  as Map<String, Map<String, dynamic>>,
        contributorCount: null == contributorCount
            ? _value.contributorCount
            : contributorCount // ignore: cast_nullable_to_non_nullable
                  as int,
        topContributors: null == topContributors
            ? _value._topContributors
            : topContributors // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        closedAt: freezed == closedAt
            ? _value.closedAt
            : closedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        claimedAt: freezed == claimedAt
            ? _value.claimedAt
            : claimedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$TokenSprayModelImpl extends _TokenSprayModel {
  const _$TokenSprayModelImpl({
    required this.id,
    required this.communityId,
    required this.communityName,
    required this.messageId,
    required this.creatorId,
    required this.creatorName,
    required this.recipientId,
    required this.recipientName,
    required this.occasion,
    required this.occasionText,
    required this.message,
    this.targetAmount,
    required this.currentTotal,
    required final Map<String, Map<String, dynamic>> contributions,
    required this.contributorCount,
    final List<Map<String, dynamic>> topContributors = const [],
    required this.status,
    required this.createdAt,
    this.closedAt,
    this.claimedAt,
    required this.expiresAt,
  }) : _contributions = contributions,
       _topContributors = topContributors,
       super._();

  @override
  final String id;
  @override
  final String communityId;
  @override
  final String communityName;
  @override
  final String messageId;
  @override
  final String creatorId;
  @override
  final String creatorName;
  @override
  final String recipientId;
  @override
  final String recipientName;
  @override
  final String occasion;
  @override
  final String occasionText;
  @override
  final String message;
  @override
  final int? targetAmount;
  @override
  final int currentTotal;
  final Map<String, Map<String, dynamic>> _contributions;
  @override
  Map<String, Map<String, dynamic>> get contributions {
    if (_contributions is EqualUnmodifiableMapView) return _contributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_contributions);
  }

  @override
  final int contributorCount;
  final List<Map<String, dynamic>> _topContributors;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get topContributors {
    if (_topContributors is EqualUnmodifiableListView) return _topContributors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topContributors);
  }

  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? closedAt;
  @override
  final DateTime? claimedAt;
  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'TokenSprayModel(id: $id, communityId: $communityId, communityName: $communityName, messageId: $messageId, creatorId: $creatorId, creatorName: $creatorName, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, occasionText: $occasionText, message: $message, targetAmount: $targetAmount, currentTotal: $currentTotal, contributions: $contributions, contributorCount: $contributorCount, topContributors: $topContributors, status: $status, createdAt: $createdAt, closedAt: $closedAt, claimedAt: $claimedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenSprayModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.communityName, communityName) ||
                other.communityName == communityName) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.creatorName, creatorName) ||
                other.creatorName == creatorName) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.occasion, occasion) ||
                other.occasion == occasion) &&
            (identical(other.occasionText, occasionText) ||
                other.occasionText == occasionText) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.currentTotal, currentTotal) ||
                other.currentTotal == currentTotal) &&
            const DeepCollectionEquality().equals(
              other._contributions,
              _contributions,
            ) &&
            (identical(other.contributorCount, contributorCount) ||
                other.contributorCount == contributorCount) &&
            const DeepCollectionEquality().equals(
              other._topContributors,
              _topContributors,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.claimedAt, claimedAt) ||
                other.claimedAt == claimedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    communityId,
    communityName,
    messageId,
    creatorId,
    creatorName,
    recipientId,
    recipientName,
    occasion,
    occasionText,
    message,
    targetAmount,
    currentTotal,
    const DeepCollectionEquality().hash(_contributions),
    contributorCount,
    const DeepCollectionEquality().hash(_topContributors),
    status,
    createdAt,
    closedAt,
    claimedAt,
    expiresAt,
  ]);

  /// Create a copy of TokenSprayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenSprayModelImplCopyWith<_$TokenSprayModelImpl> get copyWith =>
      __$$TokenSprayModelImplCopyWithImpl<_$TokenSprayModelImpl>(
        this,
        _$identity,
      );
}

abstract class _TokenSprayModel extends TokenSprayModel {
  const factory _TokenSprayModel({
    required final String id,
    required final String communityId,
    required final String communityName,
    required final String messageId,
    required final String creatorId,
    required final String creatorName,
    required final String recipientId,
    required final String recipientName,
    required final String occasion,
    required final String occasionText,
    required final String message,
    final int? targetAmount,
    required final int currentTotal,
    required final Map<String, Map<String, dynamic>> contributions,
    required final int contributorCount,
    final List<Map<String, dynamic>> topContributors,
    required final String status,
    required final DateTime createdAt,
    final DateTime? closedAt,
    final DateTime? claimedAt,
    required final DateTime expiresAt,
  }) = _$TokenSprayModelImpl;
  const _TokenSprayModel._() : super._();

  @override
  String get id;
  @override
  String get communityId;
  @override
  String get communityName;
  @override
  String get messageId;
  @override
  String get creatorId;
  @override
  String get creatorName;
  @override
  String get recipientId;
  @override
  String get recipientName;
  @override
  String get occasion;
  @override
  String get occasionText;
  @override
  String get message;
  @override
  int? get targetAmount;
  @override
  int get currentTotal;
  @override
  Map<String, Map<String, dynamic>> get contributions;
  @override
  int get contributorCount;
  @override
  List<Map<String, dynamic>> get topContributors;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get closedAt;
  @override
  DateTime? get claimedAt;
  @override
  DateTime get expiresAt;

  /// Create a copy of TokenSprayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenSprayModelImplCopyWith<_$TokenSprayModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
