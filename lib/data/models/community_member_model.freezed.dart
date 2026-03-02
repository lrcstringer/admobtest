// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommunityMemberModel _$CommunityMemberModelFromJson(Map<String, dynamic> json) {
  return _CommunityMemberModel.fromJson(json);
}

/// @nodoc
mixin _$CommunityMemberModel {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get contributionBalance => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  String get invitedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get invitedAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get lastReadAt => throw _privateConstructorUsedError;
  String? get communityName => throw _privateConstructorUsedError;

  /// Serializes this CommunityMemberModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityMemberModelCopyWith<CommunityMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityMemberModelCopyWith<$Res> {
  factory $CommunityMemberModelCopyWith(
    CommunityMemberModel value,
    $Res Function(CommunityMemberModel) then,
  ) = _$CommunityMemberModelCopyWithImpl<$Res, CommunityMemberModel>;
  @useResult
  $Res call({
    String id,
    String communityId,
    String userId,
    String displayName,
    String? avatarUrl,
    String role,
    String status,
    int contributionBalance,
    @NullableTimestampConverter() DateTime? joinedAt,
    String invitedBy,
    @TimestampConverter() DateTime invitedAt,
    @NullableTimestampConverter() DateTime? lastReadAt,
    String? communityName,
  });
}

/// @nodoc
class _$CommunityMemberModelCopyWithImpl<
  $Res,
  $Val extends CommunityMemberModel
>
    implements $CommunityMemberModelCopyWith<$Res> {
  _$CommunityMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? role = null,
    Object? status = null,
    Object? contributionBalance = null,
    Object? joinedAt = freezed,
    Object? invitedBy = null,
    Object? invitedAt = null,
    Object? lastReadAt = freezed,
    Object? communityName = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            contributionBalance: null == contributionBalance
                ? _value.contributionBalance
                : contributionBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            joinedAt: freezed == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            invitedBy: null == invitedBy
                ? _value.invitedBy
                : invitedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            invitedAt: null == invitedAt
                ? _value.invitedAt
                : invitedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastReadAt: freezed == lastReadAt
                ? _value.lastReadAt
                : lastReadAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            communityName: freezed == communityName
                ? _value.communityName
                : communityName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityMemberModelImplCopyWith<$Res>
    implements $CommunityMemberModelCopyWith<$Res> {
  factory _$$CommunityMemberModelImplCopyWith(
    _$CommunityMemberModelImpl value,
    $Res Function(_$CommunityMemberModelImpl) then,
  ) = __$$CommunityMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String communityId,
    String userId,
    String displayName,
    String? avatarUrl,
    String role,
    String status,
    int contributionBalance,
    @NullableTimestampConverter() DateTime? joinedAt,
    String invitedBy,
    @TimestampConverter() DateTime invitedAt,
    @NullableTimestampConverter() DateTime? lastReadAt,
    String? communityName,
  });
}

/// @nodoc
class __$$CommunityMemberModelImplCopyWithImpl<$Res>
    extends _$CommunityMemberModelCopyWithImpl<$Res, _$CommunityMemberModelImpl>
    implements _$$CommunityMemberModelImplCopyWith<$Res> {
  __$$CommunityMemberModelImplCopyWithImpl(
    _$CommunityMemberModelImpl _value,
    $Res Function(_$CommunityMemberModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? communityId = null,
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? role = null,
    Object? status = null,
    Object? contributionBalance = null,
    Object? joinedAt = freezed,
    Object? invitedBy = null,
    Object? invitedAt = null,
    Object? lastReadAt = freezed,
    Object? communityName = freezed,
  }) {
    return _then(
      _$CommunityMemberModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        contributionBalance: null == contributionBalance
            ? _value.contributionBalance
            : contributionBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        joinedAt: freezed == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        invitedBy: null == invitedBy
            ? _value.invitedBy
            : invitedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        invitedAt: null == invitedAt
            ? _value.invitedAt
            : invitedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastReadAt: freezed == lastReadAt
            ? _value.lastReadAt
            : lastReadAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        communityName: freezed == communityName
            ? _value.communityName
            : communityName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityMemberModelImpl extends _CommunityMemberModel
    with DiagnosticableTreeMixin {
  const _$CommunityMemberModelImpl({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    required this.role,
    required this.status,
    this.contributionBalance = 0,
    @NullableTimestampConverter() this.joinedAt,
    required this.invitedBy,
    @TimestampConverter() required this.invitedAt,
    @NullableTimestampConverter() this.lastReadAt,
    this.communityName,
  }) : super._();

  factory _$CommunityMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityMemberModelImplFromJson(json);

  @override
  final String id;
  @override
  final String communityId;
  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final String role;
  @override
  final String status;
  @override
  @JsonKey()
  final int contributionBalance;
  @override
  @NullableTimestampConverter()
  final DateTime? joinedAt;
  @override
  final String invitedBy;
  @override
  @TimestampConverter()
  final DateTime invitedAt;
  @override
  @NullableTimestampConverter()
  final DateTime? lastReadAt;
  @override
  final String? communityName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommunityMemberModel(id: $id, communityId: $communityId, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt, lastReadAt: $lastReadAt, communityName: $communityName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommunityMemberModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('communityId', communityId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('contributionBalance', contributionBalance))
      ..add(DiagnosticsProperty('joinedAt', joinedAt))
      ..add(DiagnosticsProperty('invitedBy', invitedBy))
      ..add(DiagnosticsProperty('invitedAt', invitedAt))
      ..add(DiagnosticsProperty('lastReadAt', lastReadAt))
      ..add(DiagnosticsProperty('communityName', communityName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityMemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.contributionBalance, contributionBalance) ||
                other.contributionBalance == contributionBalance) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt) &&
            (identical(other.communityName, communityName) ||
                other.communityName == communityName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    communityId,
    userId,
    displayName,
    avatarUrl,
    role,
    status,
    contributionBalance,
    joinedAt,
    invitedBy,
    invitedAt,
    lastReadAt,
    communityName,
  );

  /// Create a copy of CommunityMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityMemberModelImplCopyWith<_$CommunityMemberModelImpl>
  get copyWith =>
      __$$CommunityMemberModelImplCopyWithImpl<_$CommunityMemberModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityMemberModelImplToJson(this);
  }
}

abstract class _CommunityMemberModel extends CommunityMemberModel {
  const factory _CommunityMemberModel({
    required final String id,
    required final String communityId,
    required final String userId,
    required final String displayName,
    final String? avatarUrl,
    required final String role,
    required final String status,
    final int contributionBalance,
    @NullableTimestampConverter() final DateTime? joinedAt,
    required final String invitedBy,
    @TimestampConverter() required final DateTime invitedAt,
    @NullableTimestampConverter() final DateTime? lastReadAt,
    final String? communityName,
  }) = _$CommunityMemberModelImpl;
  const _CommunityMemberModel._() : super._();

  factory _CommunityMemberModel.fromJson(Map<String, dynamic> json) =
      _$CommunityMemberModelImpl.fromJson;

  @override
  String get id;
  @override
  String get communityId;
  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override
  String get role;
  @override
  String get status;
  @override
  int get contributionBalance;
  @override
  @NullableTimestampConverter()
  DateTime? get joinedAt;
  @override
  String get invitedBy;
  @override
  @TimestampConverter()
  DateTime get invitedAt;
  @override
  @NullableTimestampConverter()
  DateTime? get lastReadAt;
  @override
  String? get communityName;

  /// Create a copy of CommunityMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityMemberModelImplCopyWith<_$CommunityMemberModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
