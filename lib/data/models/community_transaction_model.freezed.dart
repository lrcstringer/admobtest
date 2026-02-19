// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommunityTransactionModel _$CommunityTransactionModelFromJson(
  Map<String, dynamic> json,
) {
  return _CommunityTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$CommunityTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String? get journalId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  String? get rejectedBy => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityTransactionModelCopyWith<CommunityTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityTransactionModelCopyWith<$Res> {
  factory $CommunityTransactionModelCopyWith(
    CommunityTransactionModel value,
    $Res Function(CommunityTransactionModel) then,
  ) = _$CommunityTransactionModelCopyWithImpl<$Res, CommunityTransactionModel>;
  @useResult
  $Res call({
    String id,
    String communityId,
    String? journalId,
    String type,
    int amount,
    String memberId,
    String memberName,
    String? description,
    String status,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? completedAt,
  });
}

/// @nodoc
class _$CommunityTransactionModelCopyWithImpl<
  $Res,
  $Val extends CommunityTransactionModel
>
    implements $CommunityTransactionModelCopyWith<$Res> {
  _$CommunityTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? journalId = freezed,
    Object? type = null,
    Object? amount = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? description = freezed,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? rejectedBy = freezed,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
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
            memberId: null == memberId
                ? _value.memberId
                : memberId // ignore: cast_nullable_to_non_nullable
                      as String,
            memberName: null == memberName
                ? _value.memberName
                : memberName // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            approvedBy: freezed == approvedBy
                ? _value.approvedBy
                : approvedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            rejectedBy: freezed == rejectedBy
                ? _value.rejectedBy
                : rejectedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            rejectionReason: freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CommunityTransactionModelImplCopyWith<$Res>
    implements $CommunityTransactionModelCopyWith<$Res> {
  factory _$$CommunityTransactionModelImplCopyWith(
    _$CommunityTransactionModelImpl value,
    $Res Function(_$CommunityTransactionModelImpl) then,
  ) = __$$CommunityTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String communityId,
    String? journalId,
    String type,
    int amount,
    String memberId,
    String memberName,
    String? description,
    String status,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? completedAt,
  });
}

/// @nodoc
class __$$CommunityTransactionModelImplCopyWithImpl<$Res>
    extends
        _$CommunityTransactionModelCopyWithImpl<
          $Res,
          _$CommunityTransactionModelImpl
        >
    implements _$$CommunityTransactionModelImplCopyWith<$Res> {
  __$$CommunityTransactionModelImplCopyWithImpl(
    _$CommunityTransactionModelImpl _value,
    $Res Function(_$CommunityTransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? journalId = freezed,
    Object? type = null,
    Object? amount = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? description = freezed,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? rejectedBy = freezed,
    Object? rejectionReason = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$CommunityTransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
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
        memberId: null == memberId
            ? _value.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberName: null == memberName
            ? _value.memberName
            : memberName // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        approvedBy: freezed == approvedBy
            ? _value.approvedBy
            : approvedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        rejectedBy: freezed == rejectedBy
            ? _value.rejectedBy
            : rejectedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$CommunityTransactionModelImpl extends _CommunityTransactionModel {
  const _$CommunityTransactionModelImpl({
    required this.id,
    required this.communityId,
    this.journalId,
    required this.type,
    required this.amount,
    required this.memberId,
    required this.memberName,
    this.description,
    required this.status,
    this.approvedBy,
    this.rejectedBy,
    this.rejectionReason,
    @TimestampConverter() required this.createdAt,
    @NullableTimestampConverter() this.completedAt,
  }) : super._();

  factory _$CommunityTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String communityId;
  @override
  final String? journalId;
  @override
  final String type;
  @override
  final int amount;
  @override
  final String memberId;
  @override
  final String memberName;
  @override
  final String? description;
  @override
  final String status;
  @override
  final String? approvedBy;
  @override
  final String? rejectedBy;
  @override
  final String? rejectionReason;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @NullableTimestampConverter()
  final DateTime? completedAt;

  @override
  String toString() {
    return 'CommunityTransactionModel(id: $id, communityId: $communityId, journalId: $journalId, type: $type, amount: $amount, memberId: $memberId, memberName: $memberName, description: $description, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, rejectionReason: $rejectionReason, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.journalId, journalId) ||
                other.journalId == journalId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
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
    communityId,
    journalId,
    type,
    amount,
    memberId,
    memberName,
    description,
    status,
    approvedBy,
    rejectedBy,
    rejectionReason,
    createdAt,
    completedAt,
  );

  /// Create a copy of CommunityTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityTransactionModelImplCopyWith<_$CommunityTransactionModelImpl>
  get copyWith =>
      __$$CommunityTransactionModelImplCopyWithImpl<
        _$CommunityTransactionModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityTransactionModelImplToJson(this);
  }
}

abstract class _CommunityTransactionModel extends CommunityTransactionModel {
  const factory _CommunityTransactionModel({
    required final String id,
    required final String communityId,
    final String? journalId,
    required final String type,
    required final int amount,
    required final String memberId,
    required final String memberName,
    final String? description,
    required final String status,
    final String? approvedBy,
    final String? rejectedBy,
    final String? rejectionReason,
    @TimestampConverter() required final DateTime createdAt,
    @NullableTimestampConverter() final DateTime? completedAt,
  }) = _$CommunityTransactionModelImpl;
  const _CommunityTransactionModel._() : super._();

  factory _CommunityTransactionModel.fromJson(Map<String, dynamic> json) =
      _$CommunityTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get communityId;
  @override
  String? get journalId;
  @override
  String get type;
  @override
  int get amount;
  @override
  String get memberId;
  @override
  String get memberName;
  @override
  String? get description;
  @override
  String get status;
  @override
  String? get approvedBy;
  @override
  String? get rejectedBy;
  @override
  String? get rejectionReason;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @NullableTimestampConverter()
  DateTime? get completedAt;

  /// Create a copy of CommunityTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityTransactionModelImplCopyWith<_$CommunityTransactionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommunityApprovalModel _$CommunityApprovalModelFromJson(
  Map<String, dynamic> json,
) {
  return _CommunityApprovalModel.fromJson(json);
}

/// @nodoc
mixin _$CommunityApprovalModel {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  String get requestedBy => throw _privateConstructorUsedError;
  String get requestedByName => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get approvers => throw _privateConstructorUsedError;
  int get requiredApprovals => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityApprovalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityApprovalModelCopyWith<CommunityApprovalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityApprovalModelCopyWith<$Res> {
  factory $CommunityApprovalModelCopyWith(
    CommunityApprovalModel value,
    $Res Function(CommunityApprovalModel) then,
  ) = _$CommunityApprovalModelCopyWithImpl<$Res, CommunityApprovalModel>;
  @useResult
  $Res call({
    String id,
    String communityId,
    String transactionId,
    String requestedBy,
    String requestedByName,
    int amount,
    String type,
    String? description,
    List<String> approvers,
    int requiredApprovals,
    String status,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime expiresAt,
  });
}

/// @nodoc
class _$CommunityApprovalModelCopyWithImpl<
  $Res,
  $Val extends CommunityApprovalModel
>
    implements $CommunityApprovalModelCopyWith<$Res> {
  _$CommunityApprovalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? transactionId = null,
    Object? requestedBy = null,
    Object? requestedByName = null,
    Object? amount = null,
    Object? type = null,
    Object? description = freezed,
    Object? approvers = null,
    Object? requiredApprovals = null,
    Object? status = null,
    Object? createdAt = null,
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
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            requestedBy: null == requestedBy
                ? _value.requestedBy
                : requestedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            requestedByName: null == requestedByName
                ? _value.requestedByName
                : requestedByName // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            approvers: null == approvers
                ? _value.approvers
                : approvers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            requiredApprovals: null == requiredApprovals
                ? _value.requiredApprovals
                : requiredApprovals // ignore: cast_nullable_to_non_nullable
                      as int,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityApprovalModelImplCopyWith<$Res>
    implements $CommunityApprovalModelCopyWith<$Res> {
  factory _$$CommunityApprovalModelImplCopyWith(
    _$CommunityApprovalModelImpl value,
    $Res Function(_$CommunityApprovalModelImpl) then,
  ) = __$$CommunityApprovalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String communityId,
    String transactionId,
    String requestedBy,
    String requestedByName,
    int amount,
    String type,
    String? description,
    List<String> approvers,
    int requiredApprovals,
    String status,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime expiresAt,
  });
}

/// @nodoc
class __$$CommunityApprovalModelImplCopyWithImpl<$Res>
    extends
        _$CommunityApprovalModelCopyWithImpl<$Res, _$CommunityApprovalModelImpl>
    implements _$$CommunityApprovalModelImplCopyWith<$Res> {
  __$$CommunityApprovalModelImplCopyWithImpl(
    _$CommunityApprovalModelImpl _value,
    $Res Function(_$CommunityApprovalModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? transactionId = null,
    Object? requestedBy = null,
    Object? requestedByName = null,
    Object? amount = null,
    Object? type = null,
    Object? description = freezed,
    Object? approvers = null,
    Object? requiredApprovals = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = null,
  }) {
    return _then(
      _$CommunityApprovalModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        requestedBy: null == requestedBy
            ? _value.requestedBy
            : requestedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        requestedByName: null == requestedByName
            ? _value.requestedByName
            : requestedByName // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        approvers: null == approvers
            ? _value._approvers
            : approvers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        requiredApprovals: null == requiredApprovals
            ? _value.requiredApprovals
            : requiredApprovals // ignore: cast_nullable_to_non_nullable
                  as int,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityApprovalModelImpl extends _CommunityApprovalModel {
  const _$CommunityApprovalModelImpl({
    required this.id,
    required this.communityId,
    required this.transactionId,
    required this.requestedBy,
    required this.requestedByName,
    required this.amount,
    required this.type,
    this.description,
    required final List<String> approvers,
    required this.requiredApprovals,
    required this.status,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.expiresAt,
  }) : _approvers = approvers,
       super._();

  factory _$CommunityApprovalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityApprovalModelImplFromJson(json);

  @override
  final String id;
  @override
  final String communityId;
  @override
  final String transactionId;
  @override
  final String requestedBy;
  @override
  final String requestedByName;
  @override
  final int amount;
  @override
  final String type;
  @override
  final String? description;
  final List<String> _approvers;
  @override
  List<String> get approvers {
    if (_approvers is EqualUnmodifiableListView) return _approvers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_approvers);
  }

  @override
  final int requiredApprovals;
  @override
  final String status;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime expiresAt;

  @override
  String toString() {
    return 'CommunityApprovalModel(id: $id, communityId: $communityId, transactionId: $transactionId, requestedBy: $requestedBy, requestedByName: $requestedByName, amount: $amount, type: $type, description: $description, approvers: $approvers, requiredApprovals: $requiredApprovals, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityApprovalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.requestedBy, requestedBy) ||
                other.requestedBy == requestedBy) &&
            (identical(other.requestedByName, requestedByName) ||
                other.requestedByName == requestedByName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._approvers,
              _approvers,
            ) &&
            (identical(other.requiredApprovals, requiredApprovals) ||
                other.requiredApprovals == requiredApprovals) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    communityId,
    transactionId,
    requestedBy,
    requestedByName,
    amount,
    type,
    description,
    const DeepCollectionEquality().hash(_approvers),
    requiredApprovals,
    status,
    createdAt,
    expiresAt,
  );

  /// Create a copy of CommunityApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityApprovalModelImplCopyWith<_$CommunityApprovalModelImpl>
  get copyWith =>
      __$$CommunityApprovalModelImplCopyWithImpl<_$CommunityApprovalModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityApprovalModelImplToJson(this);
  }
}

abstract class _CommunityApprovalModel extends CommunityApprovalModel {
  const factory _CommunityApprovalModel({
    required final String id,
    required final String communityId,
    required final String transactionId,
    required final String requestedBy,
    required final String requestedByName,
    required final int amount,
    required final String type,
    final String? description,
    required final List<String> approvers,
    required final int requiredApprovals,
    required final String status,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime expiresAt,
  }) = _$CommunityApprovalModelImpl;
  const _CommunityApprovalModel._() : super._();

  factory _CommunityApprovalModel.fromJson(Map<String, dynamic> json) =
      _$CommunityApprovalModelImpl.fromJson;

  @override
  String get id;
  @override
  String get communityId;
  @override
  String get transactionId;
  @override
  String get requestedBy;
  @override
  String get requestedByName;
  @override
  int get amount;
  @override
  String get type;
  @override
  String? get description;
  @override
  List<String> get approvers;
  @override
  int get requiredApprovals;
  @override
  String get status;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get expiresAt;

  /// Create a copy of CommunityApprovalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityApprovalModelImplCopyWith<_$CommunityApprovalModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
