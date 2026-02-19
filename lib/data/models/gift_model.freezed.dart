// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GiftModel {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get conversationId => throw _privateConstructorUsedError;
  String? get communityId => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get style => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get openedAt => throw _privateConstructorUsedError;
  DateTime? get claimedAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String? get debitTransactionId => throw _privateConstructorUsedError;
  String? get creditTransactionId => throw _privateConstructorUsedError;

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftModelCopyWith<GiftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftModelCopyWith<$Res> {
  factory $GiftModelCopyWith(GiftModel value, $Res Function(GiftModel) then) =
      _$GiftModelCopyWithImpl<$Res, GiftModel>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String recipientId,
    String recipientName,
    int amount,
    String? conversationId,
    String? communityId,
    String messageId,
    String message,
    String style,
    String status,
    DateTime createdAt,
    DateTime? openedAt,
    DateTime? claimedAt,
    DateTime expiresAt,
    String? debitTransactionId,
    String? creditTransactionId,
  });
}

/// @nodoc
class _$GiftModelCopyWithImpl<$Res, $Val extends GiftModel>
    implements $GiftModelCopyWith<$Res> {
  _$GiftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? amount = null,
    Object? conversationId = freezed,
    Object? communityId = freezed,
    Object? messageId = null,
    Object? message = null,
    Object? style = null,
    Object? status = null,
    Object? createdAt = null,
    Object? openedAt = freezed,
    Object? claimedAt = freezed,
    Object? expiresAt = null,
    Object? debitTransactionId = freezed,
    Object? creditTransactionId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientId: null == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientName: null == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            conversationId: freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            communityId: freezed == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            messageId: null == messageId
                ? _value.messageId
                : messageId // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            style: null == style
                ? _value.style
                : style // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            claimedAt: freezed == claimedAt
                ? _value.claimedAt
                : claimedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            debitTransactionId: freezed == debitTransactionId
                ? _value.debitTransactionId
                : debitTransactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            creditTransactionId: freezed == creditTransactionId
                ? _value.creditTransactionId
                : creditTransactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GiftModelImplCopyWith<$Res>
    implements $GiftModelCopyWith<$Res> {
  factory _$$GiftModelImplCopyWith(
    _$GiftModelImpl value,
    $Res Function(_$GiftModelImpl) then,
  ) = __$$GiftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String recipientId,
    String recipientName,
    int amount,
    String? conversationId,
    String? communityId,
    String messageId,
    String message,
    String style,
    String status,
    DateTime createdAt,
    DateTime? openedAt,
    DateTime? claimedAt,
    DateTime expiresAt,
    String? debitTransactionId,
    String? creditTransactionId,
  });
}

/// @nodoc
class __$$GiftModelImplCopyWithImpl<$Res>
    extends _$GiftModelCopyWithImpl<$Res, _$GiftModelImpl>
    implements _$$GiftModelImplCopyWith<$Res> {
  __$$GiftModelImplCopyWithImpl(
    _$GiftModelImpl _value,
    $Res Function(_$GiftModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? amount = null,
    Object? conversationId = freezed,
    Object? communityId = freezed,
    Object? messageId = null,
    Object? message = null,
    Object? style = null,
    Object? status = null,
    Object? createdAt = null,
    Object? openedAt = freezed,
    Object? claimedAt = freezed,
    Object? expiresAt = null,
    Object? debitTransactionId = freezed,
    Object? creditTransactionId = freezed,
  }) {
    return _then(
      _$GiftModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientName: null == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        claimedAt: freezed == claimedAt
            ? _value.claimedAt
            : claimedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        debitTransactionId: freezed == debitTransactionId
            ? _value.debitTransactionId
            : debitTransactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        creditTransactionId: freezed == creditTransactionId
            ? _value.creditTransactionId
            : creditTransactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GiftModelImpl extends _GiftModel {
  const _$GiftModelImpl({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.recipientId,
    required this.recipientName,
    required this.amount,
    this.conversationId,
    this.communityId,
    required this.messageId,
    required this.message,
    required this.style,
    required this.status,
    required this.createdAt,
    this.openedAt,
    this.claimedAt,
    required this.expiresAt,
    this.debitTransactionId,
    this.creditTransactionId,
  }) : super._();

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String recipientId;
  @override
  final String recipientName;
  @override
  final int amount;
  @override
  final String? conversationId;
  @override
  final String? communityId;
  @override
  final String messageId;
  @override
  final String message;
  @override
  final String style;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? openedAt;
  @override
  final DateTime? claimedAt;
  @override
  final DateTime expiresAt;
  @override
  final String? debitTransactionId;
  @override
  final String? creditTransactionId;

  @override
  String toString() {
    return 'GiftModel(id: $id, senderId: $senderId, senderName: $senderName, recipientId: $recipientId, recipientName: $recipientName, amount: $amount, conversationId: $conversationId, communityId: $communityId, messageId: $messageId, message: $message, style: $style, status: $status, createdAt: $createdAt, openedAt: $openedAt, claimedAt: $claimedAt, expiresAt: $expiresAt, debitTransactionId: $debitTransactionId, creditTransactionId: $creditTransactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.claimedAt, claimedAt) ||
                other.claimedAt == claimedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.debitTransactionId, debitTransactionId) ||
                other.debitTransactionId == debitTransactionId) &&
            (identical(other.creditTransactionId, creditTransactionId) ||
                other.creditTransactionId == creditTransactionId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    senderName,
    recipientId,
    recipientName,
    amount,
    conversationId,
    communityId,
    messageId,
    message,
    style,
    status,
    createdAt,
    openedAt,
    claimedAt,
    expiresAt,
    debitTransactionId,
    creditTransactionId,
  );

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftModelImplCopyWith<_$GiftModelImpl> get copyWith =>
      __$$GiftModelImplCopyWithImpl<_$GiftModelImpl>(this, _$identity);
}

abstract class _GiftModel extends GiftModel {
  const factory _GiftModel({
    required final String id,
    required final String senderId,
    required final String senderName,
    required final String recipientId,
    required final String recipientName,
    required final int amount,
    final String? conversationId,
    final String? communityId,
    required final String messageId,
    required final String message,
    required final String style,
    required final String status,
    required final DateTime createdAt,
    final DateTime? openedAt,
    final DateTime? claimedAt,
    required final DateTime expiresAt,
    final String? debitTransactionId,
    final String? creditTransactionId,
  }) = _$GiftModelImpl;
  const _GiftModel._() : super._();

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String get recipientId;
  @override
  String get recipientName;
  @override
  int get amount;
  @override
  String? get conversationId;
  @override
  String? get communityId;
  @override
  String get messageId;
  @override
  String get message;
  @override
  String get style;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get openedAt;
  @override
  DateTime? get claimedAt;
  @override
  DateTime get expiresAt;
  @override
  String? get debitTransactionId;
  @override
  String? get creditTransactionId;

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftModelImplCopyWith<_$GiftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GiftStatsModel {
  int get totalSent => throw _privateConstructorUsedError;
  int get totalReceived => throw _privateConstructorUsedError;
  int get totalAmountSent => throw _privateConstructorUsedError;
  int get totalAmountReceived => throw _privateConstructorUsedError;

  /// Create a copy of GiftStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftStatsModelCopyWith<GiftStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftStatsModelCopyWith<$Res> {
  factory $GiftStatsModelCopyWith(
    GiftStatsModel value,
    $Res Function(GiftStatsModel) then,
  ) = _$GiftStatsModelCopyWithImpl<$Res, GiftStatsModel>;
  @useResult
  $Res call({
    int totalSent,
    int totalReceived,
    int totalAmountSent,
    int totalAmountReceived,
  });
}

/// @nodoc
class _$GiftStatsModelCopyWithImpl<$Res, $Val extends GiftStatsModel>
    implements $GiftStatsModelCopyWith<$Res> {
  _$GiftStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSent = null,
    Object? totalReceived = null,
    Object? totalAmountSent = null,
    Object? totalAmountReceived = null,
  }) {
    return _then(
      _value.copyWith(
            totalSent: null == totalSent
                ? _value.totalSent
                : totalSent // ignore: cast_nullable_to_non_nullable
                      as int,
            totalReceived: null == totalReceived
                ? _value.totalReceived
                : totalReceived // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAmountSent: null == totalAmountSent
                ? _value.totalAmountSent
                : totalAmountSent // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAmountReceived: null == totalAmountReceived
                ? _value.totalAmountReceived
                : totalAmountReceived // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GiftStatsModelImplCopyWith<$Res>
    implements $GiftStatsModelCopyWith<$Res> {
  factory _$$GiftStatsModelImplCopyWith(
    _$GiftStatsModelImpl value,
    $Res Function(_$GiftStatsModelImpl) then,
  ) = __$$GiftStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalSent,
    int totalReceived,
    int totalAmountSent,
    int totalAmountReceived,
  });
}

/// @nodoc
class __$$GiftStatsModelImplCopyWithImpl<$Res>
    extends _$GiftStatsModelCopyWithImpl<$Res, _$GiftStatsModelImpl>
    implements _$$GiftStatsModelImplCopyWith<$Res> {
  __$$GiftStatsModelImplCopyWithImpl(
    _$GiftStatsModelImpl _value,
    $Res Function(_$GiftStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSent = null,
    Object? totalReceived = null,
    Object? totalAmountSent = null,
    Object? totalAmountReceived = null,
  }) {
    return _then(
      _$GiftStatsModelImpl(
        totalSent: null == totalSent
            ? _value.totalSent
            : totalSent // ignore: cast_nullable_to_non_nullable
                  as int,
        totalReceived: null == totalReceived
            ? _value.totalReceived
            : totalReceived // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAmountSent: null == totalAmountSent
            ? _value.totalAmountSent
            : totalAmountSent // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAmountReceived: null == totalAmountReceived
            ? _value.totalAmountReceived
            : totalAmountReceived // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$GiftStatsModelImpl extends _GiftStatsModel {
  const _$GiftStatsModelImpl({
    this.totalSent = 0,
    this.totalReceived = 0,
    this.totalAmountSent = 0,
    this.totalAmountReceived = 0,
  }) : super._();

  @override
  @JsonKey()
  final int totalSent;
  @override
  @JsonKey()
  final int totalReceived;
  @override
  @JsonKey()
  final int totalAmountSent;
  @override
  @JsonKey()
  final int totalAmountReceived;

  @override
  String toString() {
    return 'GiftStatsModel(totalSent: $totalSent, totalReceived: $totalReceived, totalAmountSent: $totalAmountSent, totalAmountReceived: $totalAmountReceived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftStatsModelImpl &&
            (identical(other.totalSent, totalSent) ||
                other.totalSent == totalSent) &&
            (identical(other.totalReceived, totalReceived) ||
                other.totalReceived == totalReceived) &&
            (identical(other.totalAmountSent, totalAmountSent) ||
                other.totalAmountSent == totalAmountSent) &&
            (identical(other.totalAmountReceived, totalAmountReceived) ||
                other.totalAmountReceived == totalAmountReceived));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalSent,
    totalReceived,
    totalAmountSent,
    totalAmountReceived,
  );

  /// Create a copy of GiftStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftStatsModelImplCopyWith<_$GiftStatsModelImpl> get copyWith =>
      __$$GiftStatsModelImplCopyWithImpl<_$GiftStatsModelImpl>(
        this,
        _$identity,
      );
}

abstract class _GiftStatsModel extends GiftStatsModel {
  const factory _GiftStatsModel({
    final int totalSent,
    final int totalReceived,
    final int totalAmountSent,
    final int totalAmountReceived,
  }) = _$GiftStatsModelImpl;
  const _GiftStatsModel._() : super._();

  @override
  int get totalSent;
  @override
  int get totalReceived;
  @override
  int get totalAmountSent;
  @override
  int get totalAmountReceived;

  /// Create a copy of GiftStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftStatsModelImplCopyWith<_$GiftStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
