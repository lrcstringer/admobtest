// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommunityTransaction _$CommunityTransactionFromJson(Map<String, dynamic> json) {
  return _CommunityTransaction.fromJson(json);
}

/// @nodoc
mixin _$CommunityTransaction {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String? get journalId => throw _privateConstructorUsedError;
  CommunityTransactionType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  CommunityTransactionStatus get status => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  String? get rejectedBy => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityTransactionCopyWith<CommunityTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityTransactionCopyWith<$Res> {
  factory $CommunityTransactionCopyWith(
    CommunityTransaction value,
    $Res Function(CommunityTransaction) then,
  ) = _$CommunityTransactionCopyWithImpl<$Res, CommunityTransaction>;
  @useResult
  $Res call({
    String id,
    String communityId,
    String? journalId,
    CommunityTransactionType type,
    int amount,
    String memberId,
    String memberName,
    String? description,
    CommunityTransactionStatus status,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    DateTime createdAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$CommunityTransactionCopyWithImpl<
  $Res,
  $Val extends CommunityTransaction
>
    implements $CommunityTransactionCopyWith<$Res> {
  _$CommunityTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityTransaction
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
                      as CommunityTransactionType,
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
                      as CommunityTransactionStatus,
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
abstract class _$$CommunityTransactionImplCopyWith<$Res>
    implements $CommunityTransactionCopyWith<$Res> {
  factory _$$CommunityTransactionImplCopyWith(
    _$CommunityTransactionImpl value,
    $Res Function(_$CommunityTransactionImpl) then,
  ) = __$$CommunityTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String communityId,
    String? journalId,
    CommunityTransactionType type,
    int amount,
    String memberId,
    String memberName,
    String? description,
    CommunityTransactionStatus status,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    DateTime createdAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$CommunityTransactionImplCopyWithImpl<$Res>
    extends _$CommunityTransactionCopyWithImpl<$Res, _$CommunityTransactionImpl>
    implements _$$CommunityTransactionImplCopyWith<$Res> {
  __$$CommunityTransactionImplCopyWithImpl(
    _$CommunityTransactionImpl _value,
    $Res Function(_$CommunityTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityTransaction
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
      _$CommunityTransactionImpl(
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
                  as CommunityTransactionType,
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
                  as CommunityTransactionStatus,
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
class _$CommunityTransactionImpl extends _CommunityTransaction {
  const _$CommunityTransactionImpl({
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
    required this.createdAt,
    this.completedAt,
  }) : super._();

  factory _$CommunityTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String communityId;
  @override
  final String? journalId;
  @override
  final CommunityTransactionType type;
  @override
  final int amount;
  @override
  final String memberId;
  @override
  final String memberName;
  @override
  final String? description;
  @override
  final CommunityTransactionStatus status;
  @override
  final String? approvedBy;
  @override
  final String? rejectedBy;
  @override
  final String? rejectionReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'CommunityTransaction(id: $id, communityId: $communityId, journalId: $journalId, type: $type, amount: $amount, memberId: $memberId, memberName: $memberName, description: $description, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, rejectionReason: $rejectionReason, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityTransactionImpl &&
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

  /// Create a copy of CommunityTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityTransactionImplCopyWith<_$CommunityTransactionImpl>
  get copyWith =>
      __$$CommunityTransactionImplCopyWithImpl<_$CommunityTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityTransactionImplToJson(this);
  }
}

abstract class _CommunityTransaction extends CommunityTransaction {
  const factory _CommunityTransaction({
    required final String id,
    required final String communityId,
    final String? journalId,
    required final CommunityTransactionType type,
    required final int amount,
    required final String memberId,
    required final String memberName,
    final String? description,
    required final CommunityTransactionStatus status,
    final String? approvedBy,
    final String? rejectedBy,
    final String? rejectionReason,
    required final DateTime createdAt,
    final DateTime? completedAt,
  }) = _$CommunityTransactionImpl;
  const _CommunityTransaction._() : super._();

  factory _CommunityTransaction.fromJson(Map<String, dynamic> json) =
      _$CommunityTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get communityId;
  @override
  String? get journalId;
  @override
  CommunityTransactionType get type;
  @override
  int get amount;
  @override
  String get memberId;
  @override
  String get memberName;
  @override
  String? get description;
  @override
  CommunityTransactionStatus get status;
  @override
  String? get approvedBy;
  @override
  String? get rejectedBy;
  @override
  String? get rejectionReason;
  @override
  DateTime get createdAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of CommunityTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityTransactionImplCopyWith<_$CommunityTransactionImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommunityApproval _$CommunityApprovalFromJson(Map<String, dynamic> json) {
  return _CommunityApproval.fromJson(json);
}

/// @nodoc
mixin _$CommunityApproval {
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
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityApproval to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityApproval
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityApprovalCopyWith<CommunityApproval> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityApprovalCopyWith<$Res> {
  factory $CommunityApprovalCopyWith(
    CommunityApproval value,
    $Res Function(CommunityApproval) then,
  ) = _$CommunityApprovalCopyWithImpl<$Res, CommunityApproval>;
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
    DateTime createdAt,
    DateTime expiresAt,
  });
}

/// @nodoc
class _$CommunityApprovalCopyWithImpl<$Res, $Val extends CommunityApproval>
    implements $CommunityApprovalCopyWith<$Res> {
  _$CommunityApprovalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityApproval
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
abstract class _$$CommunityApprovalImplCopyWith<$Res>
    implements $CommunityApprovalCopyWith<$Res> {
  factory _$$CommunityApprovalImplCopyWith(
    _$CommunityApprovalImpl value,
    $Res Function(_$CommunityApprovalImpl) then,
  ) = __$$CommunityApprovalImplCopyWithImpl<$Res>;
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
    DateTime createdAt,
    DateTime expiresAt,
  });
}

/// @nodoc
class __$$CommunityApprovalImplCopyWithImpl<$Res>
    extends _$CommunityApprovalCopyWithImpl<$Res, _$CommunityApprovalImpl>
    implements _$$CommunityApprovalImplCopyWith<$Res> {
  __$$CommunityApprovalImplCopyWithImpl(
    _$CommunityApprovalImpl _value,
    $Res Function(_$CommunityApprovalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityApproval
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
      _$CommunityApprovalImpl(
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
class _$CommunityApprovalImpl extends _CommunityApproval {
  const _$CommunityApprovalImpl({
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
    required this.createdAt,
    required this.expiresAt,
  }) : _approvers = approvers,
       super._();

  factory _$CommunityApprovalImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityApprovalImplFromJson(json);

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
  final DateTime createdAt;
  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'CommunityApproval(id: $id, communityId: $communityId, transactionId: $transactionId, requestedBy: $requestedBy, requestedByName: $requestedByName, amount: $amount, type: $type, description: $description, approvers: $approvers, requiredApprovals: $requiredApprovals, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityApprovalImpl &&
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

  /// Create a copy of CommunityApproval
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityApprovalImplCopyWith<_$CommunityApprovalImpl> get copyWith =>
      __$$CommunityApprovalImplCopyWithImpl<_$CommunityApprovalImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityApprovalImplToJson(this);
  }
}

abstract class _CommunityApproval extends CommunityApproval {
  const factory _CommunityApproval({
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
    required final DateTime createdAt,
    required final DateTime expiresAt,
  }) = _$CommunityApprovalImpl;
  const _CommunityApproval._() : super._();

  factory _CommunityApproval.fromJson(Map<String, dynamic> json) =
      _$CommunityApprovalImpl.fromJson;

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
  DateTime get createdAt;
  @override
  DateTime get expiresAt;

  /// Create a copy of CommunityApproval
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityApprovalImplCopyWith<_$CommunityApprovalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
