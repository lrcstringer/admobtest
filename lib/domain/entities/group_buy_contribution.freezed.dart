// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_contribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupBuyContribution _$GroupBuyContributionFromJson(Map<String, dynamic> json) {
  return _GroupBuyContribution.fromJson(json);
}

/// @nodoc
mixin _$GroupBuyContribution {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get journalId => throw _privateConstructorUsedError;
  DateTime get contributedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupBuyContribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupBuyContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBuyContributionCopyWith<GroupBuyContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyContributionCopyWith<$Res> {
  factory $GroupBuyContributionCopyWith(
    GroupBuyContribution value,
    $Res Function(GroupBuyContribution) then,
  ) = _$GroupBuyContributionCopyWithImpl<$Res, GroupBuyContribution>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    int amount,
    String? journalId,
    DateTime contributedAt,
  });
}

/// @nodoc
class _$GroupBuyContributionCopyWithImpl<
  $Res,
  $Val extends GroupBuyContribution
>
    implements $GroupBuyContributionCopyWith<$Res> {
  _$GroupBuyContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuyContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? amount = null,
    Object? journalId = freezed,
    Object? contributedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            journalId: freezed == journalId
                ? _value.journalId
                : journalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            contributedAt: null == contributedAt
                ? _value.contributedAt
                : contributedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupBuyContributionImplCopyWith<$Res>
    implements $GroupBuyContributionCopyWith<$Res> {
  factory _$$GroupBuyContributionImplCopyWith(
    _$GroupBuyContributionImpl value,
    $Res Function(_$GroupBuyContributionImpl) then,
  ) = __$$GroupBuyContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    int amount,
    String? journalId,
    DateTime contributedAt,
  });
}

/// @nodoc
class __$$GroupBuyContributionImplCopyWithImpl<$Res>
    extends _$GroupBuyContributionCopyWithImpl<$Res, _$GroupBuyContributionImpl>
    implements _$$GroupBuyContributionImplCopyWith<$Res> {
  __$$GroupBuyContributionImplCopyWithImpl(
    _$GroupBuyContributionImpl _value,
    $Res Function(_$GroupBuyContributionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyContribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? amount = null,
    Object? journalId = freezed,
    Object? contributedAt = null,
  }) {
    return _then(
      _$GroupBuyContributionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        journalId: freezed == journalId
            ? _value.journalId
            : journalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        contributedAt: null == contributedAt
            ? _value.contributedAt
            : contributedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupBuyContributionImpl implements _GroupBuyContribution {
  const _$GroupBuyContributionImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required this.amount,
    this.journalId,
    required this.contributedAt,
  });

  factory _$GroupBuyContributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupBuyContributionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final int amount;
  @override
  final String? journalId;
  @override
  final DateTime contributedAt;

  @override
  String toString() {
    return 'GroupBuyContribution(id: $id, userId: $userId, userName: $userName, amount: $amount, journalId: $journalId, contributedAt: $contributedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBuyContributionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.journalId, journalId) ||
                other.journalId == journalId) &&
            (identical(other.contributedAt, contributedAt) ||
                other.contributedAt == contributedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    userName,
    amount,
    journalId,
    contributedAt,
  );

  /// Create a copy of GroupBuyContribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBuyContributionImplCopyWith<_$GroupBuyContributionImpl>
  get copyWith =>
      __$$GroupBuyContributionImplCopyWithImpl<_$GroupBuyContributionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupBuyContributionImplToJson(this);
  }
}

abstract class _GroupBuyContribution implements GroupBuyContribution {
  const factory _GroupBuyContribution({
    required final String id,
    required final String userId,
    required final String userName,
    required final int amount,
    final String? journalId,
    required final DateTime contributedAt,
  }) = _$GroupBuyContributionImpl;

  factory _GroupBuyContribution.fromJson(Map<String, dynamic> json) =
      _$GroupBuyContributionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  int get amount;
  @override
  String? get journalId;
  @override
  DateTime get contributedAt;

  /// Create a copy of GroupBuyContribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBuyContributionImplCopyWith<_$GroupBuyContributionImpl>
  get copyWith => throw _privateConstructorUsedError;
}
