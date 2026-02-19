// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_spray.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SprayContribution _$SprayContributionFromJson(Map<String, dynamic> json) {
  return _SprayContribution.fromJson(json);
}

/// @nodoc
mixin _$SprayContribution {
  int get amount => throw _privateConstructorUsedError;
  DateTime get contributedAt => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SprayContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SprayContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SprayContributionCopyWith<SprayContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SprayContributionCopyWith<$Res> {
  factory $SprayContributionCopyWith(
    SprayContribution value,
    $Res Function(SprayContribution) then,
  ) = _$SprayContributionCopyWithImpl<$Res, SprayContribution>;
  @useResult
  $Res call({
    int amount,
    DateTime contributedAt,
    String displayName,
    String? message,
  });
}

/// @nodoc
class _$SprayContributionCopyWithImpl<$Res, $Val extends SprayContribution>
    implements $SprayContributionCopyWith<$Res> {
  _$SprayContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SprayContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? contributedAt = null,
    Object? displayName = null,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            contributedAt: null == contributedAt
                ? _value.contributedAt
                : contributedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SprayContributionImplCopyWith<$Res>
    implements $SprayContributionCopyWith<$Res> {
  factory _$$SprayContributionImplCopyWith(
    _$SprayContributionImpl value,
    $Res Function(_$SprayContributionImpl) then,
  ) = __$$SprayContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int amount,
    DateTime contributedAt,
    String displayName,
    String? message,
  });
}

/// @nodoc
class __$$SprayContributionImplCopyWithImpl<$Res>
    extends _$SprayContributionCopyWithImpl<$Res, _$SprayContributionImpl>
    implements _$$SprayContributionImplCopyWith<$Res> {
  __$$SprayContributionImplCopyWithImpl(
    _$SprayContributionImpl _value,
    $Res Function(_$SprayContributionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SprayContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? contributedAt = null,
    Object? displayName = null,
    Object? message = freezed,
  }) {
    return _then(
      _$SprayContributionImpl(
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        contributedAt: null == contributedAt
            ? _value.contributedAt
            : contributedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SprayContributionImpl implements _SprayContribution {
  const _$SprayContributionImpl({
    required this.amount,
    required this.contributedAt,
    required this.displayName,
    this.message,
  });

  factory _$SprayContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SprayContributionImplFromJson(json);

  @override
  final int amount;
  @override
  final DateTime contributedAt;
  @override
  final String displayName;
  @override
  final String? message;

  @override
  String toString() {
    return 'SprayContribution(amount: $amount, contributedAt: $contributedAt, displayName: $displayName, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SprayContributionImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.contributedAt, contributedAt) ||
                other.contributedAt == contributedAt) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, contributedAt, displayName, message);

  /// Create a copy of SprayContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SprayContributionImplCopyWith<_$SprayContributionImpl> get copyWith =>
      __$$SprayContributionImplCopyWithImpl<_$SprayContributionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SprayContributionImplToJson(this);
  }
}

abstract class _SprayContribution implements SprayContribution {
  const factory _SprayContribution({
    required final int amount,
    required final DateTime contributedAt,
    required final String displayName,
    final String? message,
  }) = _$SprayContributionImpl;

  factory _SprayContribution.fromJson(Map<String, dynamic> json) =
      _$SprayContributionImpl.fromJson;

  @override
  int get amount;
  @override
  DateTime get contributedAt;
  @override
  String get displayName;
  @override
  String? get message;

  /// Create a copy of SprayContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SprayContributionImplCopyWith<_$SprayContributionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SprayTopContributor _$SprayTopContributorFromJson(Map<String, dynamic> json) {
  return _SprayTopContributor.fromJson(json);
}

/// @nodoc
mixin _$SprayTopContributor {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;

  /// Serializes this SprayTopContributor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SprayTopContributor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SprayTopContributorCopyWith<SprayTopContributor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SprayTopContributorCopyWith<$Res> {
  factory $SprayTopContributorCopyWith(
    SprayTopContributor value,
    $Res Function(SprayTopContributor) then,
  ) = _$SprayTopContributorCopyWithImpl<$Res, SprayTopContributor>;
  @useResult
  $Res call({String userId, String displayName, int amount, int rank});
}

/// @nodoc
class _$SprayTopContributorCopyWithImpl<$Res, $Val extends SprayTopContributor>
    implements $SprayTopContributorCopyWith<$Res> {
  _$SprayTopContributorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SprayTopContributor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? amount = null,
    Object? rank = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SprayTopContributorImplCopyWith<$Res>
    implements $SprayTopContributorCopyWith<$Res> {
  factory _$$SprayTopContributorImplCopyWith(
    _$SprayTopContributorImpl value,
    $Res Function(_$SprayTopContributorImpl) then,
  ) = __$$SprayTopContributorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String displayName, int amount, int rank});
}

/// @nodoc
class __$$SprayTopContributorImplCopyWithImpl<$Res>
    extends _$SprayTopContributorCopyWithImpl<$Res, _$SprayTopContributorImpl>
    implements _$$SprayTopContributorImplCopyWith<$Res> {
  __$$SprayTopContributorImplCopyWithImpl(
    _$SprayTopContributorImpl _value,
    $Res Function(_$SprayTopContributorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SprayTopContributor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? amount = null,
    Object? rank = null,
  }) {
    return _then(
      _$SprayTopContributorImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SprayTopContributorImpl implements _SprayTopContributor {
  const _$SprayTopContributorImpl({
    required this.userId,
    required this.displayName,
    required this.amount,
    required this.rank,
  });

  factory _$SprayTopContributorImpl.fromJson(Map<String, dynamic> json) =>
      _$$SprayTopContributorImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final int amount;
  @override
  final int rank;

  @override
  String toString() {
    return 'SprayTopContributor(userId: $userId, displayName: $displayName, amount: $amount, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SprayTopContributorImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, amount, rank);

  /// Create a copy of SprayTopContributor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SprayTopContributorImplCopyWith<_$SprayTopContributorImpl> get copyWith =>
      __$$SprayTopContributorImplCopyWithImpl<_$SprayTopContributorImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SprayTopContributorImplToJson(this);
  }
}

abstract class _SprayTopContributor implements SprayTopContributor {
  const factory _SprayTopContributor({
    required final String userId,
    required final String displayName,
    required final int amount,
    required final int rank,
  }) = _$SprayTopContributorImpl;

  factory _SprayTopContributor.fromJson(Map<String, dynamic> json) =
      _$SprayTopContributorImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  int get amount;
  @override
  int get rank;

  /// Create a copy of SprayTopContributor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SprayTopContributorImplCopyWith<_$SprayTopContributorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenSpray _$TokenSprayFromJson(Map<String, dynamic> json) {
  return _TokenSpray.fromJson(json);
}

/// @nodoc
mixin _$TokenSpray {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String get communityName => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String get creatorName => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  SprayOccasion get occasion => throw _privateConstructorUsedError;
  String get occasionText => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int? get targetAmount => throw _privateConstructorUsedError;
  int get currentTotal => throw _privateConstructorUsedError;
  Map<String, SprayContribution> get contributions =>
      throw _privateConstructorUsedError;
  int get contributorCount => throw _privateConstructorUsedError;
  List<SprayTopContributor> get topContributors =>
      throw _privateConstructorUsedError;
  SprayStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  DateTime? get claimedAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this TokenSpray to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenSpray
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenSprayCopyWith<TokenSpray> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSprayCopyWith<$Res> {
  factory $TokenSprayCopyWith(
    TokenSpray value,
    $Res Function(TokenSpray) then,
  ) = _$TokenSprayCopyWithImpl<$Res, TokenSpray>;
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
    SprayOccasion occasion,
    String occasionText,
    String message,
    int? targetAmount,
    int currentTotal,
    Map<String, SprayContribution> contributions,
    int contributorCount,
    List<SprayTopContributor> topContributors,
    SprayStatus status,
    DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    DateTime expiresAt,
  });
}

/// @nodoc
class _$TokenSprayCopyWithImpl<$Res, $Val extends TokenSpray>
    implements $TokenSprayCopyWith<$Res> {
  _$TokenSprayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenSpray
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
                      as SprayOccasion,
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
                      as Map<String, SprayContribution>,
            contributorCount: null == contributorCount
                ? _value.contributorCount
                : contributorCount // ignore: cast_nullable_to_non_nullable
                      as int,
            topContributors: null == topContributors
                ? _value.topContributors
                : topContributors // ignore: cast_nullable_to_non_nullable
                      as List<SprayTopContributor>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SprayStatus,
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
abstract class _$$TokenSprayImplCopyWith<$Res>
    implements $TokenSprayCopyWith<$Res> {
  factory _$$TokenSprayImplCopyWith(
    _$TokenSprayImpl value,
    $Res Function(_$TokenSprayImpl) then,
  ) = __$$TokenSprayImplCopyWithImpl<$Res>;
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
    SprayOccasion occasion,
    String occasionText,
    String message,
    int? targetAmount,
    int currentTotal,
    Map<String, SprayContribution> contributions,
    int contributorCount,
    List<SprayTopContributor> topContributors,
    SprayStatus status,
    DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    DateTime expiresAt,
  });
}

/// @nodoc
class __$$TokenSprayImplCopyWithImpl<$Res>
    extends _$TokenSprayCopyWithImpl<$Res, _$TokenSprayImpl>
    implements _$$TokenSprayImplCopyWith<$Res> {
  __$$TokenSprayImplCopyWithImpl(
    _$TokenSprayImpl _value,
    $Res Function(_$TokenSprayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSpray
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
      _$TokenSprayImpl(
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
                  as SprayOccasion,
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
                  as Map<String, SprayContribution>,
        contributorCount: null == contributorCount
            ? _value.contributorCount
            : contributorCount // ignore: cast_nullable_to_non_nullable
                  as int,
        topContributors: null == topContributors
            ? _value._topContributors
            : topContributors // ignore: cast_nullable_to_non_nullable
                  as List<SprayTopContributor>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SprayStatus,
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
@JsonSerializable()
class _$TokenSprayImpl extends _TokenSpray {
  const _$TokenSprayImpl({
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
    required final Map<String, SprayContribution> contributions,
    required this.contributorCount,
    final List<SprayTopContributor> topContributors = const [],
    required this.status,
    required this.createdAt,
    this.closedAt,
    this.claimedAt,
    required this.expiresAt,
  }) : _contributions = contributions,
       _topContributors = topContributors,
       super._();

  factory _$TokenSprayImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenSprayImplFromJson(json);

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
  final SprayOccasion occasion;
  @override
  final String occasionText;
  @override
  final String message;
  @override
  final int? targetAmount;
  @override
  final int currentTotal;
  final Map<String, SprayContribution> _contributions;
  @override
  Map<String, SprayContribution> get contributions {
    if (_contributions is EqualUnmodifiableMapView) return _contributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_contributions);
  }

  @override
  final int contributorCount;
  final List<SprayTopContributor> _topContributors;
  @override
  @JsonKey()
  List<SprayTopContributor> get topContributors {
    if (_topContributors is EqualUnmodifiableListView) return _topContributors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topContributors);
  }

  @override
  final SprayStatus status;
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
    return 'TokenSpray(id: $id, communityId: $communityId, communityName: $communityName, messageId: $messageId, creatorId: $creatorId, creatorName: $creatorName, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, occasionText: $occasionText, message: $message, targetAmount: $targetAmount, currentTotal: $currentTotal, contributions: $contributions, contributorCount: $contributorCount, topContributors: $topContributors, status: $status, createdAt: $createdAt, closedAt: $closedAt, claimedAt: $claimedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenSprayImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TokenSpray
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenSprayImplCopyWith<_$TokenSprayImpl> get copyWith =>
      __$$TokenSprayImplCopyWithImpl<_$TokenSprayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenSprayImplToJson(this);
  }
}

abstract class _TokenSpray extends TokenSpray {
  const factory _TokenSpray({
    required final String id,
    required final String communityId,
    required final String communityName,
    required final String messageId,
    required final String creatorId,
    required final String creatorName,
    required final String recipientId,
    required final String recipientName,
    required final SprayOccasion occasion,
    required final String occasionText,
    required final String message,
    final int? targetAmount,
    required final int currentTotal,
    required final Map<String, SprayContribution> contributions,
    required final int contributorCount,
    final List<SprayTopContributor> topContributors,
    required final SprayStatus status,
    required final DateTime createdAt,
    final DateTime? closedAt,
    final DateTime? claimedAt,
    required final DateTime expiresAt,
  }) = _$TokenSprayImpl;
  const _TokenSpray._() : super._();

  factory _TokenSpray.fromJson(Map<String, dynamic> json) =
      _$TokenSprayImpl.fromJson;

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
  SprayOccasion get occasion;
  @override
  String get occasionText;
  @override
  String get message;
  @override
  int? get targetAmount;
  @override
  int get currentTotal;
  @override
  Map<String, SprayContribution> get contributions;
  @override
  int get contributorCount;
  @override
  List<SprayTopContributor> get topContributors;
  @override
  SprayStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get closedAt;
  @override
  DateTime? get claimedAt;
  @override
  DateTime get expiresAt;

  /// Create a copy of TokenSpray
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenSprayImplCopyWith<_$TokenSprayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
