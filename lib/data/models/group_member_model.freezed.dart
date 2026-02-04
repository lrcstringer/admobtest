// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) {
  return _GroupMemberModel.fromJson(json);
}

/// @nodoc
mixin _$GroupMemberModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get contributionBalance => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  String get invitedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get invitedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupMemberModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupMemberModelCopyWith<GroupMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMemberModelCopyWith<$Res> {
  factory $GroupMemberModelCopyWith(
    GroupMemberModel value,
    $Res Function(GroupMemberModel) then,
  ) = _$GroupMemberModelCopyWithImpl<$Res, GroupMemberModel>;
  @useResult
  $Res call({
    String id,
    String groupId,
    String userId,
    String role,
    String displayName,
    String? avatarUrl,
    String status,
    int contributionBalance,
    @NullableTimestampConverter() DateTime? joinedAt,
    String invitedBy,
    @TimestampConverter() DateTime invitedAt,
  });
}

/// @nodoc
class _$GroupMemberModelCopyWithImpl<$Res, $Val extends GroupMemberModel>
    implements $GroupMemberModelCopyWith<$Res> {
  _$GroupMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? status = null,
    Object? contributionBalance = null,
    Object? joinedAt = freezed,
    Object? invitedBy = null,
    Object? invitedAt = null,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupMemberModelImplCopyWith<$Res>
    implements $GroupMemberModelCopyWith<$Res> {
  factory _$$GroupMemberModelImplCopyWith(
    _$GroupMemberModelImpl value,
    $Res Function(_$GroupMemberModelImpl) then,
  ) = __$$GroupMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String groupId,
    String userId,
    String role,
    String displayName,
    String? avatarUrl,
    String status,
    int contributionBalance,
    @NullableTimestampConverter() DateTime? joinedAt,
    String invitedBy,
    @TimestampConverter() DateTime invitedAt,
  });
}

/// @nodoc
class __$$GroupMemberModelImplCopyWithImpl<$Res>
    extends _$GroupMemberModelCopyWithImpl<$Res, _$GroupMemberModelImpl>
    implements _$$GroupMemberModelImplCopyWith<$Res> {
  __$$GroupMemberModelImplCopyWithImpl(
    _$GroupMemberModelImpl _value,
    $Res Function(_$GroupMemberModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? status = null,
    Object? contributionBalance = null,
    Object? joinedAt = freezed,
    Object? invitedBy = null,
    Object? invitedAt = null,
  }) {
    return _then(
      _$GroupMemberModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupMemberModelImpl extends _GroupMemberModel {
  const _$GroupMemberModelImpl({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.role,
    required this.displayName,
    this.avatarUrl,
    required this.status,
    required this.contributionBalance,
    @NullableTimestampConverter() this.joinedAt,
    required this.invitedBy,
    @TimestampConverter() required this.invitedAt,
  }) : super._();

  factory _$GroupMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupMemberModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String userId;
  @override
  final String role;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final String status;
  @override
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
  String toString() {
    return 'GroupMemberModel(id: $id, groupId: $groupId, userId: $userId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.contributionBalance, contributionBalance) ||
                other.contributionBalance == contributionBalance) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    groupId,
    userId,
    role,
    displayName,
    avatarUrl,
    status,
    contributionBalance,
    joinedAt,
    invitedBy,
    invitedAt,
  );

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMemberModelImplCopyWith<_$GroupMemberModelImpl> get copyWith =>
      __$$GroupMemberModelImplCopyWithImpl<_$GroupMemberModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupMemberModelImplToJson(this);
  }
}

abstract class _GroupMemberModel extends GroupMemberModel {
  const factory _GroupMemberModel({
    required final String id,
    required final String groupId,
    required final String userId,
    required final String role,
    required final String displayName,
    final String? avatarUrl,
    required final String status,
    required final int contributionBalance,
    @NullableTimestampConverter() final DateTime? joinedAt,
    required final String invitedBy,
    @TimestampConverter() required final DateTime invitedAt,
  }) = _$GroupMemberModelImpl;
  const _GroupMemberModel._() : super._();

  factory _GroupMemberModel.fromJson(Map<String, dynamic> json) =
      _$GroupMemberModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get userId;
  @override
  String get role;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
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

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupMemberModelImplCopyWith<_$GroupMemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
