// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommunityMember _$CommunityMemberFromJson(Map<String, dynamic> json) {
  return _CommunityMember.fromJson(json);
}

/// @nodoc
mixin _$CommunityMember {
  String get id => throw _privateConstructorUsedError;
  String get communityId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  MemberRole get role => throw _privateConstructorUsedError;
  MemberStatus get status => throw _privateConstructorUsedError;
  int get contributionBalance => throw _privateConstructorUsedError;
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  String get invitedBy => throw _privateConstructorUsedError;
  DateTime get invitedAt => throw _privateConstructorUsedError;
  DateTime? get lastReadAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityMemberCopyWith<CommunityMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityMemberCopyWith<$Res> {
  factory $CommunityMemberCopyWith(
    CommunityMember value,
    $Res Function(CommunityMember) then,
  ) = _$CommunityMemberCopyWithImpl<$Res, CommunityMember>;
  @useResult
  $Res call({
    String id,
    String communityId,
    String userId,
    String displayName,
    String? avatarUrl,
    MemberRole role,
    MemberStatus status,
    int contributionBalance,
    DateTime? joinedAt,
    String invitedBy,
    DateTime invitedAt,
    DateTime? lastReadAt,
  });
}

/// @nodoc
class _$CommunityMemberCopyWithImpl<$Res, $Val extends CommunityMember>
    implements $CommunityMemberCopyWith<$Res> {
  _$CommunityMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityMember
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
                      as MemberRole,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MemberStatus,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityMemberImplCopyWith<$Res>
    implements $CommunityMemberCopyWith<$Res> {
  factory _$$CommunityMemberImplCopyWith(
    _$CommunityMemberImpl value,
    $Res Function(_$CommunityMemberImpl) then,
  ) = __$$CommunityMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String communityId,
    String userId,
    String displayName,
    String? avatarUrl,
    MemberRole role,
    MemberStatus status,
    int contributionBalance,
    DateTime? joinedAt,
    String invitedBy,
    DateTime invitedAt,
    DateTime? lastReadAt,
  });
}

/// @nodoc
class __$$CommunityMemberImplCopyWithImpl<$Res>
    extends _$CommunityMemberCopyWithImpl<$Res, _$CommunityMemberImpl>
    implements _$$CommunityMemberImplCopyWith<$Res> {
  __$$CommunityMemberImplCopyWithImpl(
    _$CommunityMemberImpl _value,
    $Res Function(_$CommunityMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMember
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
  }) {
    return _then(
      _$CommunityMemberImpl(
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
                  as MemberRole,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MemberStatus,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityMemberImpl extends _CommunityMember {
  const _$CommunityMemberImpl({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    required this.role,
    required this.status,
    this.contributionBalance = 0,
    this.joinedAt,
    required this.invitedBy,
    required this.invitedAt,
    this.lastReadAt,
  }) : super._();

  factory _$CommunityMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityMemberImplFromJson(json);

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
  final MemberRole role;
  @override
  final MemberStatus status;
  @override
  @JsonKey()
  final int contributionBalance;
  @override
  final DateTime? joinedAt;
  @override
  final String invitedBy;
  @override
  final DateTime invitedAt;
  @override
  final DateTime? lastReadAt;

  @override
  String toString() {
    return 'CommunityMember(id: $id, communityId: $communityId, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt, lastReadAt: $lastReadAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityMemberImpl &&
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
                other.lastReadAt == lastReadAt));
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
  );

  /// Create a copy of CommunityMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityMemberImplCopyWith<_$CommunityMemberImpl> get copyWith =>
      __$$CommunityMemberImplCopyWithImpl<_$CommunityMemberImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityMemberImplToJson(this);
  }
}

abstract class _CommunityMember extends CommunityMember {
  const factory _CommunityMember({
    required final String id,
    required final String communityId,
    required final String userId,
    required final String displayName,
    final String? avatarUrl,
    required final MemberRole role,
    required final MemberStatus status,
    final int contributionBalance,
    final DateTime? joinedAt,
    required final String invitedBy,
    required final DateTime invitedAt,
    final DateTime? lastReadAt,
  }) = _$CommunityMemberImpl;
  const _CommunityMember._() : super._();

  factory _CommunityMember.fromJson(Map<String, dynamic> json) =
      _$CommunityMemberImpl.fromJson;

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
  MemberRole get role;
  @override
  MemberStatus get status;
  @override
  int get contributionBalance;
  @override
  DateTime? get joinedAt;
  @override
  String get invitedBy;
  @override
  DateTime get invitedAt;
  @override
  DateTime? get lastReadAt;

  /// Create a copy of CommunityMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityMemberImplCopyWith<_$CommunityMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
