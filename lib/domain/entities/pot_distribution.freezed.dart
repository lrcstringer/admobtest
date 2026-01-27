// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot_distribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PotDistribution _$PotDistributionFromJson(Map<String, dynamic> json) {
  return _PotDistribution.fromJson(json);
}

/// @nodoc
mixin _$PotDistribution {
  String get id => throw _privateConstructorUsedError;
  String get potPoolId => throw _privateConstructorUsedError;
  PotType get potType => throw _privateConstructorUsedError;
  DateTime get drawDate => throw _privateConstructorUsedError;
  int get totalPrizePool => throw _privateConstructorUsedError;
  int get totalParticipants => throw _privateConstructorUsedError;
  int get totalEntries => throw _privateConstructorUsedError;
  List<PotWinnerAllocation> get winners => throw _privateConstructorUsedError;
  DistributionStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;
  String? get transactionBatchId => throw _privateConstructorUsedError;

  /// Serializes this PotDistribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PotDistribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PotDistributionCopyWith<PotDistribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PotDistributionCopyWith<$Res> {
  factory $PotDistributionCopyWith(
    PotDistribution value,
    $Res Function(PotDistribution) then,
  ) = _$PotDistributionCopyWithImpl<$Res, PotDistribution>;
  @useResult
  $Res call({
    String id,
    String potPoolId,
    PotType potType,
    DateTime drawDate,
    int totalPrizePool,
    int totalParticipants,
    int totalEntries,
    List<PotWinnerAllocation> winners,
    DistributionStatus status,
    DateTime createdAt,
    DateTime? processedAt,
    String? transactionBatchId,
  });
}

/// @nodoc
class _$PotDistributionCopyWithImpl<$Res, $Val extends PotDistribution>
    implements $PotDistributionCopyWith<$Res> {
  _$PotDistributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PotDistribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? potPoolId = null,
    Object? potType = null,
    Object? drawDate = null,
    Object? totalPrizePool = null,
    Object? totalParticipants = null,
    Object? totalEntries = null,
    Object? winners = null,
    Object? status = null,
    Object? createdAt = null,
    Object? processedAt = freezed,
    Object? transactionBatchId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            potPoolId: null == potPoolId
                ? _value.potPoolId
                : potPoolId // ignore: cast_nullable_to_non_nullable
                      as String,
            potType: null == potType
                ? _value.potType
                : potType // ignore: cast_nullable_to_non_nullable
                      as PotType,
            drawDate: null == drawDate
                ? _value.drawDate
                : drawDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalPrizePool: null == totalPrizePool
                ? _value.totalPrizePool
                : totalPrizePool // ignore: cast_nullable_to_non_nullable
                      as int,
            totalParticipants: null == totalParticipants
                ? _value.totalParticipants
                : totalParticipants // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEntries: null == totalEntries
                ? _value.totalEntries
                : totalEntries // ignore: cast_nullable_to_non_nullable
                      as int,
            winners: null == winners
                ? _value.winners
                : winners // ignore: cast_nullable_to_non_nullable
                      as List<PotWinnerAllocation>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DistributionStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            processedAt: freezed == processedAt
                ? _value.processedAt
                : processedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            transactionBatchId: freezed == transactionBatchId
                ? _value.transactionBatchId
                : transactionBatchId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PotDistributionImplCopyWith<$Res>
    implements $PotDistributionCopyWith<$Res> {
  factory _$$PotDistributionImplCopyWith(
    _$PotDistributionImpl value,
    $Res Function(_$PotDistributionImpl) then,
  ) = __$$PotDistributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String potPoolId,
    PotType potType,
    DateTime drawDate,
    int totalPrizePool,
    int totalParticipants,
    int totalEntries,
    List<PotWinnerAllocation> winners,
    DistributionStatus status,
    DateTime createdAt,
    DateTime? processedAt,
    String? transactionBatchId,
  });
}

/// @nodoc
class __$$PotDistributionImplCopyWithImpl<$Res>
    extends _$PotDistributionCopyWithImpl<$Res, _$PotDistributionImpl>
    implements _$$PotDistributionImplCopyWith<$Res> {
  __$$PotDistributionImplCopyWithImpl(
    _$PotDistributionImpl _value,
    $Res Function(_$PotDistributionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PotDistribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? potPoolId = null,
    Object? potType = null,
    Object? drawDate = null,
    Object? totalPrizePool = null,
    Object? totalParticipants = null,
    Object? totalEntries = null,
    Object? winners = null,
    Object? status = null,
    Object? createdAt = null,
    Object? processedAt = freezed,
    Object? transactionBatchId = freezed,
  }) {
    return _then(
      _$PotDistributionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        potPoolId: null == potPoolId
            ? _value.potPoolId
            : potPoolId // ignore: cast_nullable_to_non_nullable
                  as String,
        potType: null == potType
            ? _value.potType
            : potType // ignore: cast_nullable_to_non_nullable
                  as PotType,
        drawDate: null == drawDate
            ? _value.drawDate
            : drawDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalPrizePool: null == totalPrizePool
            ? _value.totalPrizePool
            : totalPrizePool // ignore: cast_nullable_to_non_nullable
                  as int,
        totalParticipants: null == totalParticipants
            ? _value.totalParticipants
            : totalParticipants // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEntries: null == totalEntries
            ? _value.totalEntries
            : totalEntries // ignore: cast_nullable_to_non_nullable
                  as int,
        winners: null == winners
            ? _value._winners
            : winners // ignore: cast_nullable_to_non_nullable
                  as List<PotWinnerAllocation>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DistributionStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        processedAt: freezed == processedAt
            ? _value.processedAt
            : processedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        transactionBatchId: freezed == transactionBatchId
            ? _value.transactionBatchId
            : transactionBatchId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PotDistributionImpl implements _PotDistribution {
  const _$PotDistributionImpl({
    required this.id,
    required this.potPoolId,
    required this.potType,
    required this.drawDate,
    required this.totalPrizePool,
    required this.totalParticipants,
    required this.totalEntries,
    required final List<PotWinnerAllocation> winners,
    required this.status,
    required this.createdAt,
    this.processedAt,
    this.transactionBatchId,
  }) : _winners = winners;

  factory _$PotDistributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PotDistributionImplFromJson(json);

  @override
  final String id;
  @override
  final String potPoolId;
  @override
  final PotType potType;
  @override
  final DateTime drawDate;
  @override
  final int totalPrizePool;
  @override
  final int totalParticipants;
  @override
  final int totalEntries;
  final List<PotWinnerAllocation> _winners;
  @override
  List<PotWinnerAllocation> get winners {
    if (_winners is EqualUnmodifiableListView) return _winners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_winners);
  }

  @override
  final DistributionStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? processedAt;
  @override
  final String? transactionBatchId;

  @override
  String toString() {
    return 'PotDistribution(id: $id, potPoolId: $potPoolId, potType: $potType, drawDate: $drawDate, totalPrizePool: $totalPrizePool, totalParticipants: $totalParticipants, totalEntries: $totalEntries, winners: $winners, status: $status, createdAt: $createdAt, processedAt: $processedAt, transactionBatchId: $transactionBatchId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PotDistributionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.potPoolId, potPoolId) ||
                other.potPoolId == potPoolId) &&
            (identical(other.potType, potType) || other.potType == potType) &&
            (identical(other.drawDate, drawDate) ||
                other.drawDate == drawDate) &&
            (identical(other.totalPrizePool, totalPrizePool) ||
                other.totalPrizePool == totalPrizePool) &&
            (identical(other.totalParticipants, totalParticipants) ||
                other.totalParticipants == totalParticipants) &&
            (identical(other.totalEntries, totalEntries) ||
                other.totalEntries == totalEntries) &&
            const DeepCollectionEquality().equals(other._winners, _winners) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.transactionBatchId, transactionBatchId) ||
                other.transactionBatchId == transactionBatchId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    potPoolId,
    potType,
    drawDate,
    totalPrizePool,
    totalParticipants,
    totalEntries,
    const DeepCollectionEquality().hash(_winners),
    status,
    createdAt,
    processedAt,
    transactionBatchId,
  );

  /// Create a copy of PotDistribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PotDistributionImplCopyWith<_$PotDistributionImpl> get copyWith =>
      __$$PotDistributionImplCopyWithImpl<_$PotDistributionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PotDistributionImplToJson(this);
  }
}

abstract class _PotDistribution implements PotDistribution {
  const factory _PotDistribution({
    required final String id,
    required final String potPoolId,
    required final PotType potType,
    required final DateTime drawDate,
    required final int totalPrizePool,
    required final int totalParticipants,
    required final int totalEntries,
    required final List<PotWinnerAllocation> winners,
    required final DistributionStatus status,
    required final DateTime createdAt,
    final DateTime? processedAt,
    final String? transactionBatchId,
  }) = _$PotDistributionImpl;

  factory _PotDistribution.fromJson(Map<String, dynamic> json) =
      _$PotDistributionImpl.fromJson;

  @override
  String get id;
  @override
  String get potPoolId;
  @override
  PotType get potType;
  @override
  DateTime get drawDate;
  @override
  int get totalPrizePool;
  @override
  int get totalParticipants;
  @override
  int get totalEntries;
  @override
  List<PotWinnerAllocation> get winners;
  @override
  DistributionStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get processedAt;
  @override
  String? get transactionBatchId;

  /// Create a copy of PotDistribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PotDistributionImplCopyWith<_$PotDistributionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PotWinnerAllocation _$PotWinnerAllocationFromJson(Map<String, dynamic> json) {
  return _PotWinnerAllocation.fromJson(json);
}

/// @nodoc
mixin _$PotWinnerAllocation {
  String get oddienceUserId => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int get prizeAmount => throw _privateConstructorUsedError;
  int get entryCount => throw _privateConstructorUsedError;
  double get winProbability => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  bool? get notificationSent => throw _privateConstructorUsedError;

  /// Serializes this PotWinnerAllocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PotWinnerAllocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PotWinnerAllocationCopyWith<PotWinnerAllocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PotWinnerAllocationCopyWith<$Res> {
  factory $PotWinnerAllocationCopyWith(
    PotWinnerAllocation value,
    $Res Function(PotWinnerAllocation) then,
  ) = _$PotWinnerAllocationCopyWithImpl<$Res, PotWinnerAllocation>;
  @useResult
  $Res call({
    String oddienceUserId,
    int rank,
    int prizeAmount,
    int entryCount,
    double winProbability,
    String? transactionId,
    bool? notificationSent,
  });
}

/// @nodoc
class _$PotWinnerAllocationCopyWithImpl<$Res, $Val extends PotWinnerAllocation>
    implements $PotWinnerAllocationCopyWith<$Res> {
  _$PotWinnerAllocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PotWinnerAllocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oddienceUserId = null,
    Object? rank = null,
    Object? prizeAmount = null,
    Object? entryCount = null,
    Object? winProbability = null,
    Object? transactionId = freezed,
    Object? notificationSent = freezed,
  }) {
    return _then(
      _value.copyWith(
            oddienceUserId: null == oddienceUserId
                ? _value.oddienceUserId
                : oddienceUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            prizeAmount: null == prizeAmount
                ? _value.prizeAmount
                : prizeAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            entryCount: null == entryCount
                ? _value.entryCount
                : entryCount // ignore: cast_nullable_to_non_nullable
                      as int,
            winProbability: null == winProbability
                ? _value.winProbability
                : winProbability // ignore: cast_nullable_to_non_nullable
                      as double,
            transactionId: freezed == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            notificationSent: freezed == notificationSent
                ? _value.notificationSent
                : notificationSent // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PotWinnerAllocationImplCopyWith<$Res>
    implements $PotWinnerAllocationCopyWith<$Res> {
  factory _$$PotWinnerAllocationImplCopyWith(
    _$PotWinnerAllocationImpl value,
    $Res Function(_$PotWinnerAllocationImpl) then,
  ) = __$$PotWinnerAllocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String oddienceUserId,
    int rank,
    int prizeAmount,
    int entryCount,
    double winProbability,
    String? transactionId,
    bool? notificationSent,
  });
}

/// @nodoc
class __$$PotWinnerAllocationImplCopyWithImpl<$Res>
    extends _$PotWinnerAllocationCopyWithImpl<$Res, _$PotWinnerAllocationImpl>
    implements _$$PotWinnerAllocationImplCopyWith<$Res> {
  __$$PotWinnerAllocationImplCopyWithImpl(
    _$PotWinnerAllocationImpl _value,
    $Res Function(_$PotWinnerAllocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PotWinnerAllocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oddienceUserId = null,
    Object? rank = null,
    Object? prizeAmount = null,
    Object? entryCount = null,
    Object? winProbability = null,
    Object? transactionId = freezed,
    Object? notificationSent = freezed,
  }) {
    return _then(
      _$PotWinnerAllocationImpl(
        oddienceUserId: null == oddienceUserId
            ? _value.oddienceUserId
            : oddienceUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        prizeAmount: null == prizeAmount
            ? _value.prizeAmount
            : prizeAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        entryCount: null == entryCount
            ? _value.entryCount
            : entryCount // ignore: cast_nullable_to_non_nullable
                  as int,
        winProbability: null == winProbability
            ? _value.winProbability
            : winProbability // ignore: cast_nullable_to_non_nullable
                  as double,
        transactionId: freezed == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        notificationSent: freezed == notificationSent
            ? _value.notificationSent
            : notificationSent // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PotWinnerAllocationImpl implements _PotWinnerAllocation {
  const _$PotWinnerAllocationImpl({
    required this.oddienceUserId,
    required this.rank,
    required this.prizeAmount,
    required this.entryCount,
    required this.winProbability,
    this.transactionId,
    this.notificationSent,
  });

  factory _$PotWinnerAllocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PotWinnerAllocationImplFromJson(json);

  @override
  final String oddienceUserId;
  @override
  final int rank;
  @override
  final int prizeAmount;
  @override
  final int entryCount;
  @override
  final double winProbability;
  @override
  final String? transactionId;
  @override
  final bool? notificationSent;

  @override
  String toString() {
    return 'PotWinnerAllocation(oddienceUserId: $oddienceUserId, rank: $rank, prizeAmount: $prizeAmount, entryCount: $entryCount, winProbability: $winProbability, transactionId: $transactionId, notificationSent: $notificationSent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PotWinnerAllocationImpl &&
            (identical(other.oddienceUserId, oddienceUserId) ||
                other.oddienceUserId == oddienceUserId) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.prizeAmount, prizeAmount) ||
                other.prizeAmount == prizeAmount) &&
            (identical(other.entryCount, entryCount) ||
                other.entryCount == entryCount) &&
            (identical(other.winProbability, winProbability) ||
                other.winProbability == winProbability) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.notificationSent, notificationSent) ||
                other.notificationSent == notificationSent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    oddienceUserId,
    rank,
    prizeAmount,
    entryCount,
    winProbability,
    transactionId,
    notificationSent,
  );

  /// Create a copy of PotWinnerAllocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PotWinnerAllocationImplCopyWith<_$PotWinnerAllocationImpl> get copyWith =>
      __$$PotWinnerAllocationImplCopyWithImpl<_$PotWinnerAllocationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PotWinnerAllocationImplToJson(this);
  }
}

abstract class _PotWinnerAllocation implements PotWinnerAllocation {
  const factory _PotWinnerAllocation({
    required final String oddienceUserId,
    required final int rank,
    required final int prizeAmount,
    required final int entryCount,
    required final double winProbability,
    final String? transactionId,
    final bool? notificationSent,
  }) = _$PotWinnerAllocationImpl;

  factory _PotWinnerAllocation.fromJson(Map<String, dynamic> json) =
      _$PotWinnerAllocationImpl.fromJson;

  @override
  String get oddienceUserId;
  @override
  int get rank;
  @override
  int get prizeAmount;
  @override
  int get entryCount;
  @override
  double get winProbability;
  @override
  String? get transactionId;
  @override
  bool? get notificationSent;

  /// Create a copy of PotWinnerAllocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PotWinnerAllocationImplCopyWith<_$PotWinnerAllocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
