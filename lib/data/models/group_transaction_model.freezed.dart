// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupTransactionModel _$GroupTransactionModelFromJson(
  Map<String, dynamic> json,
) {
  return _GroupTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$GroupTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String? get journalId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get fromMemberId => throw _privateConstructorUsedError;
  String? get toMemberId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupTransactionModelCopyWith<GroupTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupTransactionModelCopyWith<$Res> {
  factory $GroupTransactionModelCopyWith(
    GroupTransactionModel value,
    $Res Function(GroupTransactionModel) then,
  ) = _$GroupTransactionModelCopyWithImpl<$Res, GroupTransactionModel>;
  @useResult
  $Res call({
    String id,
    String groupId,
    String? journalId,
    String type,
    int amount,
    String? fromMemberId,
    String? toMemberId,
    String description,
    String status,
    String? approvedBy,
    String createdBy,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? completedAt,
  });
}

/// @nodoc
class _$GroupTransactionModelCopyWithImpl<
  $Res,
  $Val extends GroupTransactionModel
>
    implements $GroupTransactionModelCopyWith<$Res> {
  _$GroupTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? journalId = freezed,
    Object? type = null,
    Object? amount = null,
    Object? fromMemberId = freezed,
    Object? toMemberId = freezed,
    Object? description = null,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            journalId: freezed == journalId
                ? _value.journalId
                : journalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            fromMemberId: freezed == fromMemberId
                ? _value.fromMemberId
                : fromMemberId // ignore: cast_nullable_to_non_nullable
                      as String?,
            toMemberId: freezed == toMemberId
                ? _value.toMemberId
                : toMemberId // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            approvedBy: freezed == approvedBy
                ? _value.approvedBy
                : approvedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupTransactionModelImplCopyWith<$Res>
    implements $GroupTransactionModelCopyWith<$Res> {
  factory _$$GroupTransactionModelImplCopyWith(
    _$GroupTransactionModelImpl value,
    $Res Function(_$GroupTransactionModelImpl) then,
  ) = __$$GroupTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String groupId,
    String? journalId,
    String type,
    int amount,
    String? fromMemberId,
    String? toMemberId,
    String description,
    String status,
    String? approvedBy,
    String createdBy,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? completedAt,
  });
}

/// @nodoc
class __$$GroupTransactionModelImplCopyWithImpl<$Res>
    extends
        _$GroupTransactionModelCopyWithImpl<$Res, _$GroupTransactionModelImpl>
    implements _$$GroupTransactionModelImplCopyWith<$Res> {
  __$$GroupTransactionModelImplCopyWithImpl(
    _$GroupTransactionModelImpl _value,
    $Res Function(_$GroupTransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? journalId = freezed,
    Object? type = null,
    Object? amount = null,
    Object? fromMemberId = freezed,
    Object? toMemberId = freezed,
    Object? description = null,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$GroupTransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        journalId: freezed == journalId
            ? _value.journalId
            : journalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        fromMemberId: freezed == fromMemberId
            ? _value.fromMemberId
            : fromMemberId // ignore: cast_nullable_to_non_nullable
                  as String?,
        toMemberId: freezed == toMemberId
            ? _value.toMemberId
            : toMemberId // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        approvedBy: freezed == approvedBy
            ? _value.approvedBy
            : approvedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupTransactionModelImpl extends _GroupTransactionModel {
  const _$GroupTransactionModelImpl({
    required this.id,
    required this.groupId,
    this.journalId,
    required this.type,
    required this.amount,
    this.fromMemberId,
    this.toMemberId,
    required this.description,
    required this.status,
    this.approvedBy,
    required this.createdBy,
    @TimestampConverter() required this.createdAt,
    @NullableTimestampConverter() this.completedAt,
  }) : super._();

  factory _$GroupTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String? journalId;
  @override
  final String type;
  @override
  final int amount;
  @override
  final String? fromMemberId;
  @override
  final String? toMemberId;
  @override
  final String description;
  @override
  final String status;
  @override
  final String? approvedBy;
  @override
  final String createdBy;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @NullableTimestampConverter()
  final DateTime? completedAt;

  @override
  String toString() {
    return 'GroupTransactionModel(id: $id, groupId: $groupId, journalId: $journalId, type: $type, amount: $amount, fromMemberId: $fromMemberId, toMemberId: $toMemberId, description: $description, status: $status, approvedBy: $approvedBy, createdBy: $createdBy, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.journalId, journalId) ||
                other.journalId == journalId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fromMemberId, fromMemberId) ||
                other.fromMemberId == fromMemberId) &&
            (identical(other.toMemberId, toMemberId) ||
                other.toMemberId == toMemberId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    groupId,
    journalId,
    type,
    amount,
    fromMemberId,
    toMemberId,
    description,
    status,
    approvedBy,
    createdBy,
    createdAt,
    completedAt,
  );

  /// Create a copy of GroupTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupTransactionModelImplCopyWith<_$GroupTransactionModelImpl>
  get copyWith =>
      __$$GroupTransactionModelImplCopyWithImpl<_$GroupTransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupTransactionModelImplToJson(this);
  }
}

abstract class _GroupTransactionModel extends GroupTransactionModel {
  const factory _GroupTransactionModel({
    required final String id,
    required final String groupId,
    final String? journalId,
    required final String type,
    required final int amount,
    final String? fromMemberId,
    final String? toMemberId,
    required final String description,
    required final String status,
    final String? approvedBy,
    required final String createdBy,
    @TimestampConverter() required final DateTime createdAt,
    @NullableTimestampConverter() final DateTime? completedAt,
  }) = _$GroupTransactionModelImpl;
  const _GroupTransactionModel._() : super._();

  factory _GroupTransactionModel.fromJson(Map<String, dynamic> json) =
      _$GroupTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String? get journalId;
  @override
  String get type;
  @override
  int get amount;
  @override
  String? get fromMemberId;
  @override
  String? get toMemberId;
  @override
  String get description;
  @override
  String get status;
  @override
  String? get approvedBy;
  @override
  String get createdBy;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @NullableTimestampConverter()
  DateTime? get completedAt;

  /// Create a copy of GroupTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupTransactionModelImplCopyWith<_$GroupTransactionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PendingApprovalModel _$PendingApprovalModelFromJson(Map<String, dynamic> json) {
  return _PendingApprovalModel.fromJson(json);
}

/// @nodoc
mixin _$PendingApprovalModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  List<String> get requiredApprovers => throw _privateConstructorUsedError;
  List<String> get approvers => throw _privateConstructorUsedError;
  String? get rejectedBy => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get expiresAt => throw _privateConstructorUsedError; // Transaction details (populated when fetching approvals)
  String? get transactionType => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;

  /// Serializes this PendingApprovalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingApprovalModelCopyWith<PendingApprovalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingApprovalModelCopyWith<$Res> {
  factory $PendingApprovalModelCopyWith(
    PendingApprovalModel value,
    $Res Function(PendingApprovalModel) then,
  ) = _$PendingApprovalModelCopyWithImpl<$Res, PendingApprovalModel>;
  @useResult
  $Res call({
    String id,
    String groupId,
    String transactionId,
    List<String> requiredApprovers,
    List<String> approvers,
    String? rejectedBy,
    String status,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime expiresAt,
    String? transactionType,
    int? amount,
    String? description,
    String? createdBy,
  });
}

/// @nodoc
class _$PendingApprovalModelCopyWithImpl<
  $Res,
  $Val extends PendingApprovalModel
>
    implements $PendingApprovalModelCopyWith<$Res> {
  _$PendingApprovalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? transactionId = null,
    Object? requiredApprovers = null,
    Object? approvers = null,
    Object? rejectedBy = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? transactionType = freezed,
    Object? amount = freezed,
    Object? description = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            requiredApprovers: null == requiredApprovers
                ? _value.requiredApprovers
                : requiredApprovers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            approvers: null == approvers
                ? _value.approvers
                : approvers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            rejectedBy: freezed == rejectedBy
                ? _value.rejectedBy
                : rejectedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            transactionType: freezed == transactionType
                ? _value.transactionType
                : transactionType // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PendingApprovalModelImplCopyWith<$Res>
    implements $PendingApprovalModelCopyWith<$Res> {
  factory _$$PendingApprovalModelImplCopyWith(
    _$PendingApprovalModelImpl value,
    $Res Function(_$PendingApprovalModelImpl) then,
  ) = __$$PendingApprovalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String groupId,
    String transactionId,
    List<String> requiredApprovers,
    List<String> approvers,
    String? rejectedBy,
    String status,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime expiresAt,
    String? transactionType,
    int? amount,
    String? description,
    String? createdBy,
  });
}

/// @nodoc
class __$$PendingApprovalModelImplCopyWithImpl<$Res>
    extends _$PendingApprovalModelCopyWithImpl<$Res, _$PendingApprovalModelImpl>
    implements _$$PendingApprovalModelImplCopyWith<$Res> {
  __$$PendingApprovalModelImplCopyWithImpl(
    _$PendingApprovalModelImpl _value,
    $Res Function(_$PendingApprovalModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PendingApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? transactionId = null,
    Object? requiredApprovers = null,
    Object? approvers = null,
    Object? rejectedBy = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? transactionType = freezed,
    Object? amount = freezed,
    Object? description = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(
      _$PendingApprovalModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        requiredApprovers: null == requiredApprovers
            ? _value._requiredApprovers
            : requiredApprovers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        approvers: null == approvers
            ? _value._approvers
            : approvers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        rejectedBy: freezed == rejectedBy
            ? _value.rejectedBy
            : rejectedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        transactionType: freezed == transactionType
            ? _value.transactionType
            : transactionType // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingApprovalModelImpl extends _PendingApprovalModel {
  const _$PendingApprovalModelImpl({
    required this.id,
    required this.groupId,
    required this.transactionId,
    required final List<String> requiredApprovers,
    required final List<String> approvers,
    this.rejectedBy,
    required this.status,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.expiresAt,
    this.transactionType,
    this.amount,
    this.description,
    this.createdBy,
  }) : _requiredApprovers = requiredApprovers,
       _approvers = approvers,
       super._();

  factory _$PendingApprovalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingApprovalModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String transactionId;
  final List<String> _requiredApprovers;
  @override
  List<String> get requiredApprovers {
    if (_requiredApprovers is EqualUnmodifiableListView)
      return _requiredApprovers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredApprovers);
  }

  final List<String> _approvers;
  @override
  List<String> get approvers {
    if (_approvers is EqualUnmodifiableListView) return _approvers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_approvers);
  }

  @override
  final String? rejectedBy;
  @override
  final String status;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime expiresAt;
  // Transaction details (populated when fetching approvals)
  @override
  final String? transactionType;
  @override
  final int? amount;
  @override
  final String? description;
  @override
  final String? createdBy;

  @override
  String toString() {
    return 'PendingApprovalModel(id: $id, groupId: $groupId, transactionId: $transactionId, requiredApprovers: $requiredApprovers, approvers: $approvers, rejectedBy: $rejectedBy, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, transactionType: $transactionType, amount: $amount, description: $description, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingApprovalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            const DeepCollectionEquality().equals(
              other._requiredApprovers,
              _requiredApprovers,
            ) &&
            const DeepCollectionEquality().equals(
              other._approvers,
              _approvers,
            ) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    groupId,
    transactionId,
    const DeepCollectionEquality().hash(_requiredApprovers),
    const DeepCollectionEquality().hash(_approvers),
    rejectedBy,
    status,
    createdAt,
    expiresAt,
    transactionType,
    amount,
    description,
    createdBy,
  );

  /// Create a copy of PendingApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingApprovalModelImplCopyWith<_$PendingApprovalModelImpl>
  get copyWith =>
      __$$PendingApprovalModelImplCopyWithImpl<_$PendingApprovalModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingApprovalModelImplToJson(this);
  }
}

abstract class _PendingApprovalModel extends PendingApprovalModel {
  const factory _PendingApprovalModel({
    required final String id,
    required final String groupId,
    required final String transactionId,
    required final List<String> requiredApprovers,
    required final List<String> approvers,
    final String? rejectedBy,
    required final String status,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime expiresAt,
    final String? transactionType,
    final int? amount,
    final String? description,
    final String? createdBy,
  }) = _$PendingApprovalModelImpl;
  const _PendingApprovalModel._() : super._();

  factory _PendingApprovalModel.fromJson(Map<String, dynamic> json) =
      _$PendingApprovalModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get transactionId;
  @override
  List<String> get requiredApprovers;
  @override
  List<String> get approvers;
  @override
  String? get rejectedBy;
  @override
  String get status;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get expiresAt; // Transaction details (populated when fetching approvals)
  @override
  String? get transactionType;
  @override
  int? get amount;
  @override
  String? get description;
  @override
  String? get createdBy;

  /// Create a copy of PendingApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingApprovalModelImplCopyWith<_$PendingApprovalModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
