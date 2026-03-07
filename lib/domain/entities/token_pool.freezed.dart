// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PoolContribution _$PoolContributionFromJson(Map<String, dynamic> json) {
  return _PoolContribution.fromJson(json);
}

/// @nodoc
mixin _$PoolContribution {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;
  int get contributionCount => throw _privateConstructorUsedError;
  bool get anonymous => throw _privateConstructorUsedError;
  DateTime get lastContributedAt => throw _privateConstructorUsedError;

  /// Serializes this PoolContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoolContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoolContributionCopyWith<PoolContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolContributionCopyWith<$Res> {
  factory $PoolContributionCopyWith(
    PoolContribution value,
    $Res Function(PoolContribution) then,
  ) = _$PoolContributionCopyWithImpl<$Res, PoolContribution>;
  @useResult
  $Res call({
    String userId,
    String displayName,
    int totalAmount,
    int contributionCount,
    bool anonymous,
    DateTime lastContributedAt,
  });
}

/// @nodoc
class _$PoolContributionCopyWithImpl<$Res, $Val extends PoolContribution>
    implements $PoolContributionCopyWith<$Res> {
  _$PoolContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoolContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? totalAmount = null,
    Object? contributionCount = null,
    Object? anonymous = null,
    Object? lastContributedAt = null,
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
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            contributionCount: null == contributionCount
                ? _value.contributionCount
                : contributionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            anonymous: null == anonymous
                ? _value.anonymous
                : anonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastContributedAt: null == lastContributedAt
                ? _value.lastContributedAt
                : lastContributedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PoolContributionImplCopyWith<$Res>
    implements $PoolContributionCopyWith<$Res> {
  factory _$$PoolContributionImplCopyWith(
    _$PoolContributionImpl value,
    $Res Function(_$PoolContributionImpl) then,
  ) = __$$PoolContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String displayName,
    int totalAmount,
    int contributionCount,
    bool anonymous,
    DateTime lastContributedAt,
  });
}

/// @nodoc
class __$$PoolContributionImplCopyWithImpl<$Res>
    extends _$PoolContributionCopyWithImpl<$Res, _$PoolContributionImpl>
    implements _$$PoolContributionImplCopyWith<$Res> {
  __$$PoolContributionImplCopyWithImpl(
    _$PoolContributionImpl _value,
    $Res Function(_$PoolContributionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PoolContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? totalAmount = null,
    Object? contributionCount = null,
    Object? anonymous = null,
    Object? lastContributedAt = null,
  }) {
    return _then(
      _$PoolContributionImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        contributionCount: null == contributionCount
            ? _value.contributionCount
            : contributionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        anonymous: null == anonymous
            ? _value.anonymous
            : anonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastContributedAt: null == lastContributedAt
            ? _value.lastContributedAt
            : lastContributedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PoolContributionImpl implements _PoolContribution {
  const _$PoolContributionImpl({
    required this.userId,
    required this.displayName,
    required this.totalAmount,
    required this.contributionCount,
    required this.anonymous,
    required this.lastContributedAt,
  });

  factory _$PoolContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoolContributionImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final int totalAmount;
  @override
  final int contributionCount;
  @override
  final bool anonymous;
  @override
  final DateTime lastContributedAt;

  @override
  String toString() {
    return 'PoolContribution(userId: $userId, displayName: $displayName, totalAmount: $totalAmount, contributionCount: $contributionCount, anonymous: $anonymous, lastContributedAt: $lastContributedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolContributionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.contributionCount, contributionCount) ||
                other.contributionCount == contributionCount) &&
            (identical(other.anonymous, anonymous) ||
                other.anonymous == anonymous) &&
            (identical(other.lastContributedAt, lastContributedAt) ||
                other.lastContributedAt == lastContributedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    displayName,
    totalAmount,
    contributionCount,
    anonymous,
    lastContributedAt,
  );

  /// Create a copy of PoolContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolContributionImplCopyWith<_$PoolContributionImpl> get copyWith =>
      __$$PoolContributionImplCopyWithImpl<_$PoolContributionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PoolContributionImplToJson(this);
  }
}

abstract class _PoolContribution implements PoolContribution {
  const factory _PoolContribution({
    required final String userId,
    required final String displayName,
    required final int totalAmount,
    required final int contributionCount,
    required final bool anonymous,
    required final DateTime lastContributedAt,
  }) = _$PoolContributionImpl;

  factory _PoolContribution.fromJson(Map<String, dynamic> json) =
      _$PoolContributionImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  int get totalAmount;
  @override
  int get contributionCount;
  @override
  bool get anonymous;
  @override
  DateTime get lastContributedAt;

  /// Create a copy of PoolContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoolContributionImplCopyWith<_$PoolContributionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PoolPayout _$PoolPayoutFromJson(Map<String, dynamic> json) {
  return _PoolPayout.fromJson(json);
}

/// @nodoc
mixin _$PoolPayout {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  /// Serializes this PoolPayout to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoolPayout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoolPayoutCopyWith<PoolPayout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolPayoutCopyWith<$Res> {
  factory $PoolPayoutCopyWith(
    PoolPayout value,
    $Res Function(PoolPayout) then,
  ) = _$PoolPayoutCopyWithImpl<$Res, PoolPayout>;
  @useResult
  $Res call({String userId, String displayName, int amount});
}

/// @nodoc
class _$PoolPayoutCopyWithImpl<$Res, $Val extends PoolPayout>
    implements $PoolPayoutCopyWith<$Res> {
  _$PoolPayoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoolPayout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? amount = null,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PoolPayoutImplCopyWith<$Res>
    implements $PoolPayoutCopyWith<$Res> {
  factory _$$PoolPayoutImplCopyWith(
    _$PoolPayoutImpl value,
    $Res Function(_$PoolPayoutImpl) then,
  ) = __$$PoolPayoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String displayName, int amount});
}

/// @nodoc
class __$$PoolPayoutImplCopyWithImpl<$Res>
    extends _$PoolPayoutCopyWithImpl<$Res, _$PoolPayoutImpl>
    implements _$$PoolPayoutImplCopyWith<$Res> {
  __$$PoolPayoutImplCopyWithImpl(
    _$PoolPayoutImpl _value,
    $Res Function(_$PoolPayoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PoolPayout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? amount = null,
  }) {
    return _then(
      _$PoolPayoutImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PoolPayoutImpl implements _PoolPayout {
  const _$PoolPayoutImpl({
    required this.userId,
    required this.displayName,
    required this.amount,
  });

  factory _$PoolPayoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoolPayoutImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final int amount;

  @override
  String toString() {
    return 'PoolPayout(userId: $userId, displayName: $displayName, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolPayoutImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, displayName, amount);

  /// Create a copy of PoolPayout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolPayoutImplCopyWith<_$PoolPayoutImpl> get copyWith =>
      __$$PoolPayoutImplCopyWithImpl<_$PoolPayoutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoolPayoutImplToJson(this);
  }
}

abstract class _PoolPayout implements PoolPayout {
  const factory _PoolPayout({
    required final String userId,
    required final String displayName,
    required final int amount,
  }) = _$PoolPayoutImpl;

  factory _PoolPayout.fromJson(Map<String, dynamic> json) =
      _$PoolPayoutImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  int get amount;

  /// Create a copy of PoolPayout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoolPayoutImplCopyWith<_$PoolPayoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenPool _$TokenPoolFromJson(Map<String, dynamic> json) {
  return _TokenPool.fromJson(json);
}

/// @nodoc
mixin _$TokenPool {
  String get id => throw _privateConstructorUsedError;
  PoolMode get mode => throw _privateConstructorUsedError;
  PoolStatus get status => throw _privateConstructorUsedError; // Organizer
  String get organizerId => throw _privateConstructorUsedError;
  String get organizerName =>
      throw _privateConstructorUsedError; // Recipient (sasaza mode only)
  String? get recipientId => throw _privateConstructorUsedError;
  String? get recipientName =>
      throw _privateConstructorUsedError; // Conversation link
  String get conversationId =>
      throw _privateConstructorUsedError; // Pool content
  String get title => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  GiftStyle get style =>
      throw _privateConstructorUsedError; // Financial summary
  int get totalAmount => throw _privateConstructorUsedError;
  int get totalDistributed => throw _privateConstructorUsedError;
  int get contributionCount => throw _privateConstructorUsedError;
  int get contributorCount =>
      throw _privateConstructorUsedError; // Per-user contributions
  Map<String, PoolContribution> get contributions =>
      throw _privateConstructorUsedError; // Payout records (populated on distribute)
  List<PoolPayout> get payouts =>
      throw _privateConstructorUsedError; // Gift delivery references (sasaza mode, after send)
  String? get giftMessageId => throw _privateConstructorUsedError;
  String? get giftConversationId =>
      throw _privateConstructorUsedError; // Invitees
  List<String> get inviteeIds => throw _privateConstructorUsedError; // Expiry
  DateTime? get expiresAt => throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get openedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt =>
      throw _privateConstructorUsedError; // Ledger reference
  String get groupAccountId =>
      throw _privateConstructorUsedError; // Notification state
  bool get reminderSent => throw _privateConstructorUsedError;

  /// Serializes this TokenPool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenPoolCopyWith<TokenPool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPoolCopyWith<$Res> {
  factory $TokenPoolCopyWith(TokenPool value, $Res Function(TokenPool) then) =
      _$TokenPoolCopyWithImpl<$Res, TokenPool>;
  @useResult
  $Res call({
    String id,
    PoolMode mode,
    PoolStatus status,
    String organizerId,
    String organizerName,
    String? recipientId,
    String? recipientName,
    String conversationId,
    String title,
    String purpose,
    String message,
    GiftStyle style,
    int totalAmount,
    int totalDistributed,
    int contributionCount,
    int contributorCount,
    Map<String, PoolContribution> contributions,
    List<PoolPayout> payouts,
    String? giftMessageId,
    String? giftConversationId,
    List<String> inviteeIds,
    DateTime? expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? sentAt,
    DateTime? openedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String groupAccountId,
    bool reminderSent,
  });
}

/// @nodoc
class _$TokenPoolCopyWithImpl<$Res, $Val extends TokenPool>
    implements $TokenPoolCopyWith<$Res> {
  _$TokenPoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mode = null,
    Object? status = null,
    Object? organizerId = null,
    Object? organizerName = null,
    Object? recipientId = freezed,
    Object? recipientName = freezed,
    Object? conversationId = null,
    Object? title = null,
    Object? purpose = null,
    Object? message = null,
    Object? style = null,
    Object? totalAmount = null,
    Object? totalDistributed = null,
    Object? contributionCount = null,
    Object? contributorCount = null,
    Object? contributions = null,
    Object? payouts = null,
    Object? giftMessageId = freezed,
    Object? giftConversationId = freezed,
    Object? inviteeIds = null,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sentAt = freezed,
    Object? openedAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? groupAccountId = null,
    Object? reminderSent = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as PoolMode,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PoolStatus,
            organizerId: null == organizerId
                ? _value.organizerId
                : organizerId // ignore: cast_nullable_to_non_nullable
                      as String,
            organizerName: null == organizerName
                ? _value.organizerName
                : organizerName // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientId: freezed == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            recipientName: freezed == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            style: null == style
                ? _value.style
                : style // ignore: cast_nullable_to_non_nullable
                      as GiftStyle,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDistributed: null == totalDistributed
                ? _value.totalDistributed
                : totalDistributed // ignore: cast_nullable_to_non_nullable
                      as int,
            contributionCount: null == contributionCount
                ? _value.contributionCount
                : contributionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            contributorCount: null == contributorCount
                ? _value.contributorCount
                : contributorCount // ignore: cast_nullable_to_non_nullable
                      as int,
            contributions: null == contributions
                ? _value.contributions
                : contributions // ignore: cast_nullable_to_non_nullable
                      as Map<String, PoolContribution>,
            payouts: null == payouts
                ? _value.payouts
                : payouts // ignore: cast_nullable_to_non_nullable
                      as List<PoolPayout>,
            giftMessageId: freezed == giftMessageId
                ? _value.giftMessageId
                : giftMessageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            giftConversationId: freezed == giftConversationId
                ? _value.giftConversationId
                : giftConversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviteeIds: null == inviteeIds
                ? _value.inviteeIds
                : inviteeIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            sentAt: freezed == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            groupAccountId: null == groupAccountId
                ? _value.groupAccountId
                : groupAccountId // ignore: cast_nullable_to_non_nullable
                      as String,
            reminderSent: null == reminderSent
                ? _value.reminderSent
                : reminderSent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenPoolImplCopyWith<$Res>
    implements $TokenPoolCopyWith<$Res> {
  factory _$$TokenPoolImplCopyWith(
    _$TokenPoolImpl value,
    $Res Function(_$TokenPoolImpl) then,
  ) = __$$TokenPoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PoolMode mode,
    PoolStatus status,
    String organizerId,
    String organizerName,
    String? recipientId,
    String? recipientName,
    String conversationId,
    String title,
    String purpose,
    String message,
    GiftStyle style,
    int totalAmount,
    int totalDistributed,
    int contributionCount,
    int contributorCount,
    Map<String, PoolContribution> contributions,
    List<PoolPayout> payouts,
    String? giftMessageId,
    String? giftConversationId,
    List<String> inviteeIds,
    DateTime? expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? sentAt,
    DateTime? openedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String groupAccountId,
    bool reminderSent,
  });
}

/// @nodoc
class __$$TokenPoolImplCopyWithImpl<$Res>
    extends _$TokenPoolCopyWithImpl<$Res, _$TokenPoolImpl>
    implements _$$TokenPoolImplCopyWith<$Res> {
  __$$TokenPoolImplCopyWithImpl(
    _$TokenPoolImpl _value,
    $Res Function(_$TokenPoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mode = null,
    Object? status = null,
    Object? organizerId = null,
    Object? organizerName = null,
    Object? recipientId = freezed,
    Object? recipientName = freezed,
    Object? conversationId = null,
    Object? title = null,
    Object? purpose = null,
    Object? message = null,
    Object? style = null,
    Object? totalAmount = null,
    Object? totalDistributed = null,
    Object? contributionCount = null,
    Object? contributorCount = null,
    Object? contributions = null,
    Object? payouts = null,
    Object? giftMessageId = freezed,
    Object? giftConversationId = freezed,
    Object? inviteeIds = null,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sentAt = freezed,
    Object? openedAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? groupAccountId = null,
    Object? reminderSent = null,
  }) {
    return _then(
      _$TokenPoolImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as PoolMode,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PoolStatus,
        organizerId: null == organizerId
            ? _value.organizerId
            : organizerId // ignore: cast_nullable_to_non_nullable
                  as String,
        organizerName: null == organizerName
            ? _value.organizerName
            : organizerName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recipientName: freezed == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as GiftStyle,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDistributed: null == totalDistributed
            ? _value.totalDistributed
            : totalDistributed // ignore: cast_nullable_to_non_nullable
                  as int,
        contributionCount: null == contributionCount
            ? _value.contributionCount
            : contributionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        contributorCount: null == contributorCount
            ? _value.contributorCount
            : contributorCount // ignore: cast_nullable_to_non_nullable
                  as int,
        contributions: null == contributions
            ? _value._contributions
            : contributions // ignore: cast_nullable_to_non_nullable
                  as Map<String, PoolContribution>,
        payouts: null == payouts
            ? _value._payouts
            : payouts // ignore: cast_nullable_to_non_nullable
                  as List<PoolPayout>,
        giftMessageId: freezed == giftMessageId
            ? _value.giftMessageId
            : giftMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        giftConversationId: freezed == giftConversationId
            ? _value.giftConversationId
            : giftConversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteeIds: null == inviteeIds
            ? _value._inviteeIds
            : inviteeIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        sentAt: freezed == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        groupAccountId: null == groupAccountId
            ? _value.groupAccountId
            : groupAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        reminderSent: null == reminderSent
            ? _value.reminderSent
            : reminderSent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenPoolImpl extends _TokenPool {
  const _$TokenPoolImpl({
    required this.id,
    required this.mode,
    required this.status,
    required this.organizerId,
    required this.organizerName,
    this.recipientId,
    this.recipientName,
    required this.conversationId,
    required this.title,
    this.purpose = '',
    this.message = '',
    required this.style,
    this.totalAmount = 0,
    this.totalDistributed = 0,
    this.contributionCount = 0,
    this.contributorCount = 0,
    final Map<String, PoolContribution> contributions = const {},
    final List<PoolPayout> payouts = const [],
    this.giftMessageId,
    this.giftConversationId,
    final List<String> inviteeIds = const [],
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.sentAt,
    this.openedAt,
    this.completedAt,
    this.cancelledAt,
    required this.groupAccountId,
    this.reminderSent = false,
  }) : _contributions = contributions,
       _payouts = payouts,
       _inviteeIds = inviteeIds,
       super._();

  factory _$TokenPoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenPoolImplFromJson(json);

  @override
  final String id;
  @override
  final PoolMode mode;
  @override
  final PoolStatus status;
  // Organizer
  @override
  final String organizerId;
  @override
  final String organizerName;
  // Recipient (sasaza mode only)
  @override
  final String? recipientId;
  @override
  final String? recipientName;
  // Conversation link
  @override
  final String conversationId;
  // Pool content
  @override
  final String title;
  @override
  @JsonKey()
  final String purpose;
  @override
  @JsonKey()
  final String message;
  @override
  final GiftStyle style;
  // Financial summary
  @override
  @JsonKey()
  final int totalAmount;
  @override
  @JsonKey()
  final int totalDistributed;
  @override
  @JsonKey()
  final int contributionCount;
  @override
  @JsonKey()
  final int contributorCount;
  // Per-user contributions
  final Map<String, PoolContribution> _contributions;
  // Per-user contributions
  @override
  @JsonKey()
  Map<String, PoolContribution> get contributions {
    if (_contributions is EqualUnmodifiableMapView) return _contributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_contributions);
  }

  // Payout records (populated on distribute)
  final List<PoolPayout> _payouts;
  // Payout records (populated on distribute)
  @override
  @JsonKey()
  List<PoolPayout> get payouts {
    if (_payouts is EqualUnmodifiableListView) return _payouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payouts);
  }

  // Gift delivery references (sasaza mode, after send)
  @override
  final String? giftMessageId;
  @override
  final String? giftConversationId;
  // Invitees
  final List<String> _inviteeIds;
  // Invitees
  @override
  @JsonKey()
  List<String> get inviteeIds {
    if (_inviteeIds is EqualUnmodifiableListView) return _inviteeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inviteeIds);
  }

  // Expiry
  @override
  final DateTime? expiresAt;
  // Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? openedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? cancelledAt;
  // Ledger reference
  @override
  final String groupAccountId;
  // Notification state
  @override
  @JsonKey()
  final bool reminderSent;

  @override
  String toString() {
    return 'TokenPool(id: $id, mode: $mode, status: $status, organizerId: $organizerId, organizerName: $organizerName, recipientId: $recipientId, recipientName: $recipientName, conversationId: $conversationId, title: $title, purpose: $purpose, message: $message, style: $style, totalAmount: $totalAmount, totalDistributed: $totalDistributed, contributionCount: $contributionCount, contributorCount: $contributorCount, contributions: $contributions, payouts: $payouts, giftMessageId: $giftMessageId, giftConversationId: $giftConversationId, inviteeIds: $inviteeIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, sentAt: $sentAt, openedAt: $openedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, groupAccountId: $groupAccountId, reminderSent: $reminderSent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPoolImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.organizerName, organizerName) ||
                other.organizerName == organizerName) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.totalDistributed, totalDistributed) ||
                other.totalDistributed == totalDistributed) &&
            (identical(other.contributionCount, contributionCount) ||
                other.contributionCount == contributionCount) &&
            (identical(other.contributorCount, contributorCount) ||
                other.contributorCount == contributorCount) &&
            const DeepCollectionEquality().equals(
              other._contributions,
              _contributions,
            ) &&
            const DeepCollectionEquality().equals(other._payouts, _payouts) &&
            (identical(other.giftMessageId, giftMessageId) ||
                other.giftMessageId == giftMessageId) &&
            (identical(other.giftConversationId, giftConversationId) ||
                other.giftConversationId == giftConversationId) &&
            const DeepCollectionEquality().equals(
              other._inviteeIds,
              _inviteeIds,
            ) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.groupAccountId, groupAccountId) ||
                other.groupAccountId == groupAccountId) &&
            (identical(other.reminderSent, reminderSent) ||
                other.reminderSent == reminderSent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    mode,
    status,
    organizerId,
    organizerName,
    recipientId,
    recipientName,
    conversationId,
    title,
    purpose,
    message,
    style,
    totalAmount,
    totalDistributed,
    contributionCount,
    contributorCount,
    const DeepCollectionEquality().hash(_contributions),
    const DeepCollectionEquality().hash(_payouts),
    giftMessageId,
    giftConversationId,
    const DeepCollectionEquality().hash(_inviteeIds),
    expiresAt,
    createdAt,
    updatedAt,
    sentAt,
    openedAt,
    completedAt,
    cancelledAt,
    groupAccountId,
    reminderSent,
  ]);

  /// Create a copy of TokenPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPoolImplCopyWith<_$TokenPoolImpl> get copyWith =>
      __$$TokenPoolImplCopyWithImpl<_$TokenPoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenPoolImplToJson(this);
  }
}

abstract class _TokenPool extends TokenPool {
  const factory _TokenPool({
    required final String id,
    required final PoolMode mode,
    required final PoolStatus status,
    required final String organizerId,
    required final String organizerName,
    final String? recipientId,
    final String? recipientName,
    required final String conversationId,
    required final String title,
    final String purpose,
    final String message,
    required final GiftStyle style,
    final int totalAmount,
    final int totalDistributed,
    final int contributionCount,
    final int contributorCount,
    final Map<String, PoolContribution> contributions,
    final List<PoolPayout> payouts,
    final String? giftMessageId,
    final String? giftConversationId,
    final List<String> inviteeIds,
    final DateTime? expiresAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? sentAt,
    final DateTime? openedAt,
    final DateTime? completedAt,
    final DateTime? cancelledAt,
    required final String groupAccountId,
    final bool reminderSent,
  }) = _$TokenPoolImpl;
  const _TokenPool._() : super._();

  factory _TokenPool.fromJson(Map<String, dynamic> json) =
      _$TokenPoolImpl.fromJson;

  @override
  String get id;
  @override
  PoolMode get mode;
  @override
  PoolStatus get status; // Organizer
  @override
  String get organizerId;
  @override
  String get organizerName; // Recipient (sasaza mode only)
  @override
  String? get recipientId;
  @override
  String? get recipientName; // Conversation link
  @override
  String get conversationId; // Pool content
  @override
  String get title;
  @override
  String get purpose;
  @override
  String get message;
  @override
  GiftStyle get style; // Financial summary
  @override
  int get totalAmount;
  @override
  int get totalDistributed;
  @override
  int get contributionCount;
  @override
  int get contributorCount; // Per-user contributions
  @override
  Map<String, PoolContribution> get contributions; // Payout records (populated on distribute)
  @override
  List<PoolPayout> get payouts; // Gift delivery references (sasaza mode, after send)
  @override
  String? get giftMessageId;
  @override
  String? get giftConversationId; // Invitees
  @override
  List<String> get inviteeIds; // Expiry
  @override
  DateTime? get expiresAt; // Timestamps
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get openedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get cancelledAt; // Ledger reference
  @override
  String get groupAccountId; // Notification state
  @override
  bool get reminderSent;

  /// Create a copy of TokenPool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenPoolImplCopyWith<_$TokenPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
