// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReferralModel {
  String get id => throw _privateConstructorUsedError;
  String get referrerUserId => throw _privateConstructorUsedError;
  String get refereeUserId => throw _privateConstructorUsedError;
  String? get refereeDisplayName => throw _privateConstructorUsedError;
  String? get refereeUsername => throw _privateConstructorUsedError;
  String? get refereeAvatarUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get referralCode => throw _privateConstructorUsedError;
  int? get referrerReward => throw _privateConstructorUsedError;
  int? get refereeReward => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get registeredAt => throw _privateConstructorUsedError;
  DateTime? get qualifiedAt => throw _privateConstructorUsedError;
  DateTime? get rewardedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Create a copy of ReferralModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferralModelCopyWith<ReferralModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralModelCopyWith<$Res> {
  factory $ReferralModelCopyWith(
    ReferralModel value,
    $Res Function(ReferralModel) then,
  ) = _$ReferralModelCopyWithImpl<$Res, ReferralModel>;
  @useResult
  $Res call({
    String id,
    String referrerUserId,
    String refereeUserId,
    String? refereeDisplayName,
    String? refereeUsername,
    String? refereeAvatarUrl,
    String status,
    String referralCode,
    int? referrerReward,
    int? refereeReward,
    DateTime createdAt,
    DateTime? registeredAt,
    DateTime? qualifiedAt,
    DateTime? rewardedAt,
    DateTime? expiresAt,
  });
}

/// @nodoc
class _$ReferralModelCopyWithImpl<$Res, $Val extends ReferralModel>
    implements $ReferralModelCopyWith<$Res> {
  _$ReferralModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReferralModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? referrerUserId = null,
    Object? refereeUserId = null,
    Object? refereeDisplayName = freezed,
    Object? refereeUsername = freezed,
    Object? refereeAvatarUrl = freezed,
    Object? status = null,
    Object? referralCode = null,
    Object? referrerReward = freezed,
    Object? refereeReward = freezed,
    Object? createdAt = null,
    Object? registeredAt = freezed,
    Object? qualifiedAt = freezed,
    Object? rewardedAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            referrerUserId: null == referrerUserId
                ? _value.referrerUserId
                : referrerUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            refereeUserId: null == refereeUserId
                ? _value.refereeUserId
                : refereeUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            refereeDisplayName: freezed == refereeDisplayName
                ? _value.refereeDisplayName
                : refereeDisplayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            refereeUsername: freezed == refereeUsername
                ? _value.refereeUsername
                : refereeUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            refereeAvatarUrl: freezed == refereeAvatarUrl
                ? _value.refereeAvatarUrl
                : refereeAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            referralCode: null == referralCode
                ? _value.referralCode
                : referralCode // ignore: cast_nullable_to_non_nullable
                      as String,
            referrerReward: freezed == referrerReward
                ? _value.referrerReward
                : referrerReward // ignore: cast_nullable_to_non_nullable
                      as int?,
            refereeReward: freezed == refereeReward
                ? _value.refereeReward
                : refereeReward // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            registeredAt: freezed == registeredAt
                ? _value.registeredAt
                : registeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            qualifiedAt: freezed == qualifiedAt
                ? _value.qualifiedAt
                : qualifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            rewardedAt: freezed == rewardedAt
                ? _value.rewardedAt
                : rewardedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReferralModelImplCopyWith<$Res>
    implements $ReferralModelCopyWith<$Res> {
  factory _$$ReferralModelImplCopyWith(
    _$ReferralModelImpl value,
    $Res Function(_$ReferralModelImpl) then,
  ) = __$$ReferralModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String referrerUserId,
    String refereeUserId,
    String? refereeDisplayName,
    String? refereeUsername,
    String? refereeAvatarUrl,
    String status,
    String referralCode,
    int? referrerReward,
    int? refereeReward,
    DateTime createdAt,
    DateTime? registeredAt,
    DateTime? qualifiedAt,
    DateTime? rewardedAt,
    DateTime? expiresAt,
  });
}

/// @nodoc
class __$$ReferralModelImplCopyWithImpl<$Res>
    extends _$ReferralModelCopyWithImpl<$Res, _$ReferralModelImpl>
    implements _$$ReferralModelImplCopyWith<$Res> {
  __$$ReferralModelImplCopyWithImpl(
    _$ReferralModelImpl _value,
    $Res Function(_$ReferralModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? referrerUserId = null,
    Object? refereeUserId = null,
    Object? refereeDisplayName = freezed,
    Object? refereeUsername = freezed,
    Object? refereeAvatarUrl = freezed,
    Object? status = null,
    Object? referralCode = null,
    Object? referrerReward = freezed,
    Object? refereeReward = freezed,
    Object? createdAt = null,
    Object? registeredAt = freezed,
    Object? qualifiedAt = freezed,
    Object? rewardedAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _$ReferralModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        referrerUserId: null == referrerUserId
            ? _value.referrerUserId
            : referrerUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        refereeUserId: null == refereeUserId
            ? _value.refereeUserId
            : refereeUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        refereeDisplayName: freezed == refereeDisplayName
            ? _value.refereeDisplayName
            : refereeDisplayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        refereeUsername: freezed == refereeUsername
            ? _value.refereeUsername
            : refereeUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        refereeAvatarUrl: freezed == refereeAvatarUrl
            ? _value.refereeAvatarUrl
            : refereeAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        referralCode: null == referralCode
            ? _value.referralCode
            : referralCode // ignore: cast_nullable_to_non_nullable
                  as String,
        referrerReward: freezed == referrerReward
            ? _value.referrerReward
            : referrerReward // ignore: cast_nullable_to_non_nullable
                  as int?,
        refereeReward: freezed == refereeReward
            ? _value.refereeReward
            : refereeReward // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        registeredAt: freezed == registeredAt
            ? _value.registeredAt
            : registeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        qualifiedAt: freezed == qualifiedAt
            ? _value.qualifiedAt
            : qualifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rewardedAt: freezed == rewardedAt
            ? _value.rewardedAt
            : rewardedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ReferralModelImpl extends _ReferralModel {
  const _$ReferralModelImpl({
    required this.id,
    required this.referrerUserId,
    required this.refereeUserId,
    this.refereeDisplayName,
    this.refereeUsername,
    this.refereeAvatarUrl,
    required this.status,
    required this.referralCode,
    this.referrerReward,
    this.refereeReward,
    required this.createdAt,
    this.registeredAt,
    this.qualifiedAt,
    this.rewardedAt,
    this.expiresAt,
  }) : super._();

  @override
  final String id;
  @override
  final String referrerUserId;
  @override
  final String refereeUserId;
  @override
  final String? refereeDisplayName;
  @override
  final String? refereeUsername;
  @override
  final String? refereeAvatarUrl;
  @override
  final String status;
  @override
  final String referralCode;
  @override
  final int? referrerReward;
  @override
  final int? refereeReward;
  @override
  final DateTime createdAt;
  @override
  final DateTime? registeredAt;
  @override
  final DateTime? qualifiedAt;
  @override
  final DateTime? rewardedAt;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'ReferralModel(id: $id, referrerUserId: $referrerUserId, refereeUserId: $refereeUserId, refereeDisplayName: $refereeDisplayName, refereeUsername: $refereeUsername, refereeAvatarUrl: $refereeAvatarUrl, status: $status, referralCode: $referralCode, referrerReward: $referrerReward, refereeReward: $refereeReward, createdAt: $createdAt, registeredAt: $registeredAt, qualifiedAt: $qualifiedAt, rewardedAt: $rewardedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.referrerUserId, referrerUserId) ||
                other.referrerUserId == referrerUserId) &&
            (identical(other.refereeUserId, refereeUserId) ||
                other.refereeUserId == refereeUserId) &&
            (identical(other.refereeDisplayName, refereeDisplayName) ||
                other.refereeDisplayName == refereeDisplayName) &&
            (identical(other.refereeUsername, refereeUsername) ||
                other.refereeUsername == refereeUsername) &&
            (identical(other.refereeAvatarUrl, refereeAvatarUrl) ||
                other.refereeAvatarUrl == refereeAvatarUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referrerReward, referrerReward) ||
                other.referrerReward == referrerReward) &&
            (identical(other.refereeReward, refereeReward) ||
                other.refereeReward == refereeReward) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.qualifiedAt, qualifiedAt) ||
                other.qualifiedAt == qualifiedAt) &&
            (identical(other.rewardedAt, rewardedAt) ||
                other.rewardedAt == rewardedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    referrerUserId,
    refereeUserId,
    refereeDisplayName,
    refereeUsername,
    refereeAvatarUrl,
    status,
    referralCode,
    referrerReward,
    refereeReward,
    createdAt,
    registeredAt,
    qualifiedAt,
    rewardedAt,
    expiresAt,
  );

  /// Create a copy of ReferralModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralModelImplCopyWith<_$ReferralModelImpl> get copyWith =>
      __$$ReferralModelImplCopyWithImpl<_$ReferralModelImpl>(this, _$identity);
}

abstract class _ReferralModel extends ReferralModel {
  const factory _ReferralModel({
    required final String id,
    required final String referrerUserId,
    required final String refereeUserId,
    final String? refereeDisplayName,
    final String? refereeUsername,
    final String? refereeAvatarUrl,
    required final String status,
    required final String referralCode,
    final int? referrerReward,
    final int? refereeReward,
    required final DateTime createdAt,
    final DateTime? registeredAt,
    final DateTime? qualifiedAt,
    final DateTime? rewardedAt,
    final DateTime? expiresAt,
  }) = _$ReferralModelImpl;
  const _ReferralModel._() : super._();

  @override
  String get id;
  @override
  String get referrerUserId;
  @override
  String get refereeUserId;
  @override
  String? get refereeDisplayName;
  @override
  String? get refereeUsername;
  @override
  String? get refereeAvatarUrl;
  @override
  String get status;
  @override
  String get referralCode;
  @override
  int? get referrerReward;
  @override
  int? get refereeReward;
  @override
  DateTime get createdAt;
  @override
  DateTime? get registeredAt;
  @override
  DateTime? get qualifiedAt;
  @override
  DateTime? get rewardedAt;
  @override
  DateTime? get expiresAt;

  /// Create a copy of ReferralModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferralModelImplCopyWith<_$ReferralModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReferralStatsModel {
  int get totalReferrals => throw _privateConstructorUsedError;
  int get pendingReferrals => throw _privateConstructorUsedError;
  int get completedReferrals => throw _privateConstructorUsedError;
  int get totalEarned => throw _privateConstructorUsedError;
  String get referralCode => throw _privateConstructorUsedError;
  String get referralLink => throw _privateConstructorUsedError;

  /// Create a copy of ReferralStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferralStatsModelCopyWith<ReferralStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralStatsModelCopyWith<$Res> {
  factory $ReferralStatsModelCopyWith(
    ReferralStatsModel value,
    $Res Function(ReferralStatsModel) then,
  ) = _$ReferralStatsModelCopyWithImpl<$Res, ReferralStatsModel>;
  @useResult
  $Res call({
    int totalReferrals,
    int pendingReferrals,
    int completedReferrals,
    int totalEarned,
    String referralCode,
    String referralLink,
  });
}

/// @nodoc
class _$ReferralStatsModelCopyWithImpl<$Res, $Val extends ReferralStatsModel>
    implements $ReferralStatsModelCopyWith<$Res> {
  _$ReferralStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReferralStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReferrals = null,
    Object? pendingReferrals = null,
    Object? completedReferrals = null,
    Object? totalEarned = null,
    Object? referralCode = null,
    Object? referralLink = null,
  }) {
    return _then(
      _value.copyWith(
            totalReferrals: null == totalReferrals
                ? _value.totalReferrals
                : totalReferrals // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingReferrals: null == pendingReferrals
                ? _value.pendingReferrals
                : pendingReferrals // ignore: cast_nullable_to_non_nullable
                      as int,
            completedReferrals: null == completedReferrals
                ? _value.completedReferrals
                : completedReferrals // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEarned: null == totalEarned
                ? _value.totalEarned
                : totalEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            referralCode: null == referralCode
                ? _value.referralCode
                : referralCode // ignore: cast_nullable_to_non_nullable
                      as String,
            referralLink: null == referralLink
                ? _value.referralLink
                : referralLink // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReferralStatsModelImplCopyWith<$Res>
    implements $ReferralStatsModelCopyWith<$Res> {
  factory _$$ReferralStatsModelImplCopyWith(
    _$ReferralStatsModelImpl value,
    $Res Function(_$ReferralStatsModelImpl) then,
  ) = __$$ReferralStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalReferrals,
    int pendingReferrals,
    int completedReferrals,
    int totalEarned,
    String referralCode,
    String referralLink,
  });
}

/// @nodoc
class __$$ReferralStatsModelImplCopyWithImpl<$Res>
    extends _$ReferralStatsModelCopyWithImpl<$Res, _$ReferralStatsModelImpl>
    implements _$$ReferralStatsModelImplCopyWith<$Res> {
  __$$ReferralStatsModelImplCopyWithImpl(
    _$ReferralStatsModelImpl _value,
    $Res Function(_$ReferralStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReferrals = null,
    Object? pendingReferrals = null,
    Object? completedReferrals = null,
    Object? totalEarned = null,
    Object? referralCode = null,
    Object? referralLink = null,
  }) {
    return _then(
      _$ReferralStatsModelImpl(
        totalReferrals: null == totalReferrals
            ? _value.totalReferrals
            : totalReferrals // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingReferrals: null == pendingReferrals
            ? _value.pendingReferrals
            : pendingReferrals // ignore: cast_nullable_to_non_nullable
                  as int,
        completedReferrals: null == completedReferrals
            ? _value.completedReferrals
            : completedReferrals // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEarned: null == totalEarned
            ? _value.totalEarned
            : totalEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        referralCode: null == referralCode
            ? _value.referralCode
            : referralCode // ignore: cast_nullable_to_non_nullable
                  as String,
        referralLink: null == referralLink
            ? _value.referralLink
            : referralLink // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ReferralStatsModelImpl extends _ReferralStatsModel {
  const _$ReferralStatsModelImpl({
    required this.totalReferrals,
    required this.pendingReferrals,
    required this.completedReferrals,
    required this.totalEarned,
    required this.referralCode,
    required this.referralLink,
  }) : super._();

  @override
  final int totalReferrals;
  @override
  final int pendingReferrals;
  @override
  final int completedReferrals;
  @override
  final int totalEarned;
  @override
  final String referralCode;
  @override
  final String referralLink;

  @override
  String toString() {
    return 'ReferralStatsModel(totalReferrals: $totalReferrals, pendingReferrals: $pendingReferrals, completedReferrals: $completedReferrals, totalEarned: $totalEarned, referralCode: $referralCode, referralLink: $referralLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralStatsModelImpl &&
            (identical(other.totalReferrals, totalReferrals) ||
                other.totalReferrals == totalReferrals) &&
            (identical(other.pendingReferrals, pendingReferrals) ||
                other.pendingReferrals == pendingReferrals) &&
            (identical(other.completedReferrals, completedReferrals) ||
                other.completedReferrals == completedReferrals) &&
            (identical(other.totalEarned, totalEarned) ||
                other.totalEarned == totalEarned) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referralLink, referralLink) ||
                other.referralLink == referralLink));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalReferrals,
    pendingReferrals,
    completedReferrals,
    totalEarned,
    referralCode,
    referralLink,
  );

  /// Create a copy of ReferralStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralStatsModelImplCopyWith<_$ReferralStatsModelImpl> get copyWith =>
      __$$ReferralStatsModelImplCopyWithImpl<_$ReferralStatsModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ReferralStatsModel extends ReferralStatsModel {
  const factory _ReferralStatsModel({
    required final int totalReferrals,
    required final int pendingReferrals,
    required final int completedReferrals,
    required final int totalEarned,
    required final String referralCode,
    required final String referralLink,
  }) = _$ReferralStatsModelImpl;
  const _ReferralStatsModel._() : super._();

  @override
  int get totalReferrals;
  @override
  int get pendingReferrals;
  @override
  int get completedReferrals;
  @override
  int get totalEarned;
  @override
  String get referralCode;
  @override
  String get referralLink;

  /// Create a copy of ReferralStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferralStatsModelImplCopyWith<_$ReferralStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
