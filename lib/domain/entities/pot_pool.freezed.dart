// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PotPool _$PotPoolFromJson(Map<String, dynamic> json) {
  return _PotPool.fromJson(json);
}

/// @nodoc
mixin _$PotPool {
  String get id => throw _privateConstructorUsedError;
  PotType get type => throw _privateConstructorUsedError;
  int get totalTokens => throw _privateConstructorUsedError;
  int get participantCount => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isDistributed => throw _privateConstructorUsedError;
  DateTime? get distributedAt => throw _privateConstructorUsedError;
  List<PotWinner>? get winners => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PotPool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PotPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PotPoolCopyWith<PotPool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PotPoolCopyWith<$Res> {
  factory $PotPoolCopyWith(PotPool value, $Res Function(PotPool) then) =
      _$PotPoolCopyWithImpl<$Res, PotPool>;
  @useResult
  $Res call({
    String id,
    PotType type,
    int totalTokens,
    int participantCount,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
    bool isDistributed,
    DateTime? distributedAt,
    List<PotWinner>? winners,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$PotPoolCopyWithImpl<$Res, $Val extends PotPool>
    implements $PotPoolCopyWith<$Res> {
  _$PotPoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PotPool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? totalTokens = null,
    Object? participantCount = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? isActive = null,
    Object? isDistributed = null,
    Object? distributedAt = freezed,
    Object? winners = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PotType,
            totalTokens: null == totalTokens
                ? _value.totalTokens
                : totalTokens // ignore: cast_nullable_to_non_nullable
                      as int,
            participantCount: null == participantCount
                ? _value.participantCount
                : participantCount // ignore: cast_nullable_to_non_nullable
                      as int,
            periodStart: null == periodStart
                ? _value.periodStart
                : periodStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            periodEnd: null == periodEnd
                ? _value.periodEnd
                : periodEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDistributed: null == isDistributed
                ? _value.isDistributed
                : isDistributed // ignore: cast_nullable_to_non_nullable
                      as bool,
            distributedAt: freezed == distributedAt
                ? _value.distributedAt
                : distributedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            winners: freezed == winners
                ? _value.winners
                : winners // ignore: cast_nullable_to_non_nullable
                      as List<PotWinner>?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PotPoolImplCopyWith<$Res> implements $PotPoolCopyWith<$Res> {
  factory _$$PotPoolImplCopyWith(
    _$PotPoolImpl value,
    $Res Function(_$PotPoolImpl) then,
  ) = __$$PotPoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PotType type,
    int totalTokens,
    int participantCount,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
    bool isDistributed,
    DateTime? distributedAt,
    List<PotWinner>? winners,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$PotPoolImplCopyWithImpl<$Res>
    extends _$PotPoolCopyWithImpl<$Res, _$PotPoolImpl>
    implements _$$PotPoolImplCopyWith<$Res> {
  __$$PotPoolImplCopyWithImpl(
    _$PotPoolImpl _value,
    $Res Function(_$PotPoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PotPool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? totalTokens = null,
    Object? participantCount = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? isActive = null,
    Object? isDistributed = null,
    Object? distributedAt = freezed,
    Object? winners = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PotPoolImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PotType,
        totalTokens: null == totalTokens
            ? _value.totalTokens
            : totalTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        participantCount: null == participantCount
            ? _value.participantCount
            : participantCount // ignore: cast_nullable_to_non_nullable
                  as int,
        periodStart: null == periodStart
            ? _value.periodStart
            : periodStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        periodEnd: null == periodEnd
            ? _value.periodEnd
            : periodEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDistributed: null == isDistributed
            ? _value.isDistributed
            : isDistributed // ignore: cast_nullable_to_non_nullable
                  as bool,
        distributedAt: freezed == distributedAt
            ? _value.distributedAt
            : distributedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        winners: freezed == winners
            ? _value._winners
            : winners // ignore: cast_nullable_to_non_nullable
                  as List<PotWinner>?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PotPoolImpl extends _PotPool {
  const _$PotPoolImpl({
    required this.id,
    required this.type,
    required this.totalTokens,
    required this.participantCount,
    required this.periodStart,
    required this.periodEnd,
    required this.isActive,
    required this.isDistributed,
    this.distributedAt,
    final List<PotWinner>? winners,
    required this.createdAt,
    this.updatedAt,
  }) : _winners = winners,
       super._();

  factory _$PotPoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$PotPoolImplFromJson(json);

  @override
  final String id;
  @override
  final PotType type;
  @override
  final int totalTokens;
  @override
  final int participantCount;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final bool isActive;
  @override
  final bool isDistributed;
  @override
  final DateTime? distributedAt;
  final List<PotWinner>? _winners;
  @override
  List<PotWinner>? get winners {
    final value = _winners;
    if (value == null) return null;
    if (_winners is EqualUnmodifiableListView) return _winners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PotPool(id: $id, type: $type, totalTokens: $totalTokens, participantCount: $participantCount, periodStart: $periodStart, periodEnd: $periodEnd, isActive: $isActive, isDistributed: $isDistributed, distributedAt: $distributedAt, winners: $winners, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PotPoolImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.totalTokens, totalTokens) ||
                other.totalTokens == totalTokens) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isDistributed, isDistributed) ||
                other.isDistributed == isDistributed) &&
            (identical(other.distributedAt, distributedAt) ||
                other.distributedAt == distributedAt) &&
            const DeepCollectionEquality().equals(other._winners, _winners) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    totalTokens,
    participantCount,
    periodStart,
    periodEnd,
    isActive,
    isDistributed,
    distributedAt,
    const DeepCollectionEquality().hash(_winners),
    createdAt,
    updatedAt,
  );

  /// Create a copy of PotPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PotPoolImplCopyWith<_$PotPoolImpl> get copyWith =>
      __$$PotPoolImplCopyWithImpl<_$PotPoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PotPoolImplToJson(this);
  }
}

abstract class _PotPool extends PotPool {
  const factory _PotPool({
    required final String id,
    required final PotType type,
    required final int totalTokens,
    required final int participantCount,
    required final DateTime periodStart,
    required final DateTime periodEnd,
    required final bool isActive,
    required final bool isDistributed,
    final DateTime? distributedAt,
    final List<PotWinner>? winners,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$PotPoolImpl;
  const _PotPool._() : super._();

  factory _PotPool.fromJson(Map<String, dynamic> json) = _$PotPoolImpl.fromJson;

  @override
  String get id;
  @override
  PotType get type;
  @override
  int get totalTokens;
  @override
  int get participantCount;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  bool get isActive;
  @override
  bool get isDistributed;
  @override
  DateTime? get distributedAt;
  @override
  List<PotWinner>? get winners;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PotPool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PotPoolImplCopyWith<_$PotPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PotWinner _$PotWinnerFromJson(Map<String, dynamic> json) {
  return _PotWinner.fromJson(json);
}

/// @nodoc
mixin _$PotWinner {
  String get oddienceUserId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int get tokensWon => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this PotWinner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PotWinner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PotWinnerCopyWith<PotWinner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PotWinnerCopyWith<$Res> {
  factory $PotWinnerCopyWith(PotWinner value, $Res Function(PotWinner) then) =
      _$PotWinnerCopyWithImpl<$Res, PotWinner>;
  @useResult
  $Res call({
    String oddienceUserId,
    String displayName,
    String? username,
    int rank,
    int tokensWon,
    double percentage,
  });
}

/// @nodoc
class _$PotWinnerCopyWithImpl<$Res, $Val extends PotWinner>
    implements $PotWinnerCopyWith<$Res> {
  _$PotWinnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PotWinner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oddienceUserId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? rank = null,
    Object? tokensWon = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            oddienceUserId: null == oddienceUserId
                ? _value.oddienceUserId
                : oddienceUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            tokensWon: null == tokensWon
                ? _value.tokensWon
                : tokensWon // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PotWinnerImplCopyWith<$Res>
    implements $PotWinnerCopyWith<$Res> {
  factory _$$PotWinnerImplCopyWith(
    _$PotWinnerImpl value,
    $Res Function(_$PotWinnerImpl) then,
  ) = __$$PotWinnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String oddienceUserId,
    String displayName,
    String? username,
    int rank,
    int tokensWon,
    double percentage,
  });
}

/// @nodoc
class __$$PotWinnerImplCopyWithImpl<$Res>
    extends _$PotWinnerCopyWithImpl<$Res, _$PotWinnerImpl>
    implements _$$PotWinnerImplCopyWith<$Res> {
  __$$PotWinnerImplCopyWithImpl(
    _$PotWinnerImpl _value,
    $Res Function(_$PotWinnerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PotWinner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oddienceUserId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? rank = null,
    Object? tokensWon = null,
    Object? percentage = null,
  }) {
    return _then(
      _$PotWinnerImpl(
        oddienceUserId: null == oddienceUserId
            ? _value.oddienceUserId
            : oddienceUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        tokensWon: null == tokensWon
            ? _value.tokensWon
            : tokensWon // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PotWinnerImpl implements _PotWinner {
  const _$PotWinnerImpl({
    required this.oddienceUserId,
    required this.displayName,
    this.username,
    required this.rank,
    required this.tokensWon,
    required this.percentage,
  });

  factory _$PotWinnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PotWinnerImplFromJson(json);

  @override
  final String oddienceUserId;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final int rank;
  @override
  final int tokensWon;
  @override
  final double percentage;

  @override
  String toString() {
    return 'PotWinner(oddienceUserId: $oddienceUserId, displayName: $displayName, username: $username, rank: $rank, tokensWon: $tokensWon, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PotWinnerImpl &&
            (identical(other.oddienceUserId, oddienceUserId) ||
                other.oddienceUserId == oddienceUserId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.tokensWon, tokensWon) ||
                other.tokensWon == tokensWon) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    oddienceUserId,
    displayName,
    username,
    rank,
    tokensWon,
    percentage,
  );

  /// Create a copy of PotWinner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PotWinnerImplCopyWith<_$PotWinnerImpl> get copyWith =>
      __$$PotWinnerImplCopyWithImpl<_$PotWinnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PotWinnerImplToJson(this);
  }
}

abstract class _PotWinner implements PotWinner {
  const factory _PotWinner({
    required final String oddienceUserId,
    required final String displayName,
    final String? username,
    required final int rank,
    required final int tokensWon,
    required final double percentage,
  }) = _$PotWinnerImpl;

  factory _PotWinner.fromJson(Map<String, dynamic> json) =
      _$PotWinnerImpl.fromJson;

  @override
  String get oddienceUserId;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  int get rank;
  @override
  int get tokensWon;
  @override
  double get percentage;

  /// Create a copy of PotWinner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PotWinnerImplCopyWith<_$PotWinnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
