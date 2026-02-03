// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Cashout _$CashoutFromJson(Map<String, dynamic> json) {
  return _Cashout.fromJson(json);
}

/// @nodoc
mixin _$Cashout {
  String get id => throw _privateConstructorUsedError;
  String get walletId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get tokenAmount => throw _privateConstructorUsedError;
  double get zarAmount => throw _privateConstructorUsedError;
  CashoutMethod get method => throw _privateConstructorUsedError;
  CashoutStatus get status => throw _privateConstructorUsedError;
  String get destinationDetails => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  String? get accountHolderName => throw _privateConstructorUsedError;
  String? get mobileNumber => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get failedAt => throw _privateConstructorUsedError;

  /// Serializes this Cashout to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Cashout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashoutCopyWith<Cashout> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashoutCopyWith<$Res> {
  factory $CashoutCopyWith(Cashout value, $Res Function(Cashout) then) =
      _$CashoutCopyWithImpl<$Res, Cashout>;
  @useResult
  $Res call({
    String id,
    String walletId,
    String userId,
    int tokenAmount,
    double zarAmount,
    CashoutMethod method,
    CashoutStatus status,
    String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
    String? reference,
    String? failureReason,
    DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
    DateTime? failedAt,
  });
}

/// @nodoc
class _$CashoutCopyWithImpl<$Res, $Val extends Cashout>
    implements $CashoutCopyWith<$Res> {
  _$CashoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cashout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? walletId = null,
    Object? userId = null,
    Object? tokenAmount = null,
    Object? zarAmount = null,
    Object? method = null,
    Object? status = null,
    Object? destinationDetails = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolderName = freezed,
    Object? mobileNumber = freezed,
    Object? reference = freezed,
    Object? failureReason = freezed,
    Object? createdAt = null,
    Object? processedAt = freezed,
    Object? completedAt = freezed,
    Object? failedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            walletId: null == walletId
                ? _value.walletId
                : walletId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenAmount: null == tokenAmount
                ? _value.tokenAmount
                : tokenAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            zarAmount: null == zarAmount
                ? _value.zarAmount
                : zarAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as CashoutMethod,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CashoutStatus,
            destinationDetails: null == destinationDetails
                ? _value.destinationDetails
                : destinationDetails // ignore: cast_nullable_to_non_nullable
                      as String,
            bankName: freezed == bankName
                ? _value.bankName
                : bankName // ignore: cast_nullable_to_non_nullable
                      as String?,
            accountNumber: freezed == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            accountHolderName: freezed == accountHolderName
                ? _value.accountHolderName
                : accountHolderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobileNumber: freezed == mobileNumber
                ? _value.mobileNumber
                : mobileNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            reference: freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String?,
            failureReason: freezed == failureReason
                ? _value.failureReason
                : failureReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            processedAt: freezed == processedAt
                ? _value.processedAt
                : processedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            failedAt: freezed == failedAt
                ? _value.failedAt
                : failedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CashoutImplCopyWith<$Res> implements $CashoutCopyWith<$Res> {
  factory _$$CashoutImplCopyWith(
    _$CashoutImpl value,
    $Res Function(_$CashoutImpl) then,
  ) = __$$CashoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String walletId,
    String userId,
    int tokenAmount,
    double zarAmount,
    CashoutMethod method,
    CashoutStatus status,
    String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
    String? reference,
    String? failureReason,
    DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
    DateTime? failedAt,
  });
}

/// @nodoc
class __$$CashoutImplCopyWithImpl<$Res>
    extends _$CashoutCopyWithImpl<$Res, _$CashoutImpl>
    implements _$$CashoutImplCopyWith<$Res> {
  __$$CashoutImplCopyWithImpl(
    _$CashoutImpl _value,
    $Res Function(_$CashoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Cashout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? walletId = null,
    Object? userId = null,
    Object? tokenAmount = null,
    Object? zarAmount = null,
    Object? method = null,
    Object? status = null,
    Object? destinationDetails = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolderName = freezed,
    Object? mobileNumber = freezed,
    Object? reference = freezed,
    Object? failureReason = freezed,
    Object? createdAt = null,
    Object? processedAt = freezed,
    Object? completedAt = freezed,
    Object? failedAt = freezed,
  }) {
    return _then(
      _$CashoutImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenAmount: null == tokenAmount
            ? _value.tokenAmount
            : tokenAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        zarAmount: null == zarAmount
            ? _value.zarAmount
            : zarAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as CashoutMethod,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CashoutStatus,
        destinationDetails: null == destinationDetails
            ? _value.destinationDetails
            : destinationDetails // ignore: cast_nullable_to_non_nullable
                  as String,
        bankName: freezed == bankName
            ? _value.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountHolderName: freezed == accountHolderName
            ? _value.accountHolderName
            : accountHolderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobileNumber: freezed == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        reference: freezed == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String?,
        failureReason: freezed == failureReason
            ? _value.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        processedAt: freezed == processedAt
            ? _value.processedAt
            : processedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        failedAt: freezed == failedAt
            ? _value.failedAt
            : failedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CashoutImpl extends _Cashout {
  const _$CashoutImpl({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.tokenAmount,
    required this.zarAmount,
    required this.method,
    required this.status,
    required this.destinationDetails,
    this.bankName,
    this.accountNumber,
    this.accountHolderName,
    this.mobileNumber,
    this.reference,
    this.failureReason,
    required this.createdAt,
    this.processedAt,
    this.completedAt,
    this.failedAt,
  }) : super._();

  factory _$CashoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashoutImplFromJson(json);

  @override
  final String id;
  @override
  final String walletId;
  @override
  final String userId;
  @override
  final int tokenAmount;
  @override
  final double zarAmount;
  @override
  final CashoutMethod method;
  @override
  final CashoutStatus status;
  @override
  final String destinationDetails;
  @override
  final String? bankName;
  @override
  final String? accountNumber;
  @override
  final String? accountHolderName;
  @override
  final String? mobileNumber;
  @override
  final String? reference;
  @override
  final String? failureReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime? processedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? failedAt;

  @override
  String toString() {
    return 'Cashout(id: $id, walletId: $walletId, userId: $userId, tokenAmount: $tokenAmount, zarAmount: $zarAmount, method: $method, status: $status, destinationDetails: $destinationDetails, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, mobileNumber: $mobileNumber, reference: $reference, failureReason: $failureReason, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt, failedAt: $failedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashoutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tokenAmount, tokenAmount) ||
                other.tokenAmount == tokenAmount) &&
            (identical(other.zarAmount, zarAmount) ||
                other.zarAmount == zarAmount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.destinationDetails, destinationDetails) ||
                other.destinationDetails == destinationDetails) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.failedAt, failedAt) ||
                other.failedAt == failedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    walletId,
    userId,
    tokenAmount,
    zarAmount,
    method,
    status,
    destinationDetails,
    bankName,
    accountNumber,
    accountHolderName,
    mobileNumber,
    reference,
    failureReason,
    createdAt,
    processedAt,
    completedAt,
    failedAt,
  );

  /// Create a copy of Cashout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashoutImplCopyWith<_$CashoutImpl> get copyWith =>
      __$$CashoutImplCopyWithImpl<_$CashoutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashoutImplToJson(this);
  }
}

abstract class _Cashout extends Cashout {
  const factory _Cashout({
    required final String id,
    required final String walletId,
    required final String userId,
    required final int tokenAmount,
    required final double zarAmount,
    required final CashoutMethod method,
    required final CashoutStatus status,
    required final String destinationDetails,
    final String? bankName,
    final String? accountNumber,
    final String? accountHolderName,
    final String? mobileNumber,
    final String? reference,
    final String? failureReason,
    required final DateTime createdAt,
    final DateTime? processedAt,
    final DateTime? completedAt,
    final DateTime? failedAt,
  }) = _$CashoutImpl;
  const _Cashout._() : super._();

  factory _Cashout.fromJson(Map<String, dynamic> json) = _$CashoutImpl.fromJson;

  @override
  String get id;
  @override
  String get walletId;
  @override
  String get userId;
  @override
  int get tokenAmount;
  @override
  double get zarAmount;
  @override
  CashoutMethod get method;
  @override
  CashoutStatus get status;
  @override
  String get destinationDetails;
  @override
  String? get bankName;
  @override
  String? get accountNumber;
  @override
  String? get accountHolderName;
  @override
  String? get mobileNumber;
  @override
  String? get reference;
  @override
  String? get failureReason;
  @override
  DateTime get createdAt;
  @override
  DateTime? get processedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get failedAt;

  /// Create a copy of Cashout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashoutImplCopyWith<_$CashoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
