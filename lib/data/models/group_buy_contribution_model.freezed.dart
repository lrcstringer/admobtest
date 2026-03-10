// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_contribution_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupBuyContributionModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get journalId => throw _privateConstructorUsedError;
  String? get deliveryAddress => throw _privateConstructorUsedError;
  DateTime get contributedAt => throw _privateConstructorUsedError;

  /// Create a copy of GroupBuyContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBuyContributionModelCopyWith<GroupBuyContributionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyContributionModelCopyWith<$Res> {
  factory $GroupBuyContributionModelCopyWith(
    GroupBuyContributionModel value,
    $Res Function(GroupBuyContributionModel) then,
  ) = _$GroupBuyContributionModelCopyWithImpl<$Res, GroupBuyContributionModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    int amount,
    String? journalId,
    String? deliveryAddress,
    DateTime contributedAt,
  });
}

/// @nodoc
class _$GroupBuyContributionModelCopyWithImpl<
  $Res,
  $Val extends GroupBuyContributionModel
>
    implements $GroupBuyContributionModelCopyWith<$Res> {
  _$GroupBuyContributionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuyContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? amount = null,
    Object? journalId = freezed,
    Object? deliveryAddress = freezed,
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
            deliveryAddress: freezed == deliveryAddress
                ? _value.deliveryAddress
                : deliveryAddress // ignore: cast_nullable_to_non_nullable
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
abstract class _$$GroupBuyContributionModelImplCopyWith<$Res>
    implements $GroupBuyContributionModelCopyWith<$Res> {
  factory _$$GroupBuyContributionModelImplCopyWith(
    _$GroupBuyContributionModelImpl value,
    $Res Function(_$GroupBuyContributionModelImpl) then,
  ) = __$$GroupBuyContributionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    int amount,
    String? journalId,
    String? deliveryAddress,
    DateTime contributedAt,
  });
}

/// @nodoc
class __$$GroupBuyContributionModelImplCopyWithImpl<$Res>
    extends
        _$GroupBuyContributionModelCopyWithImpl<
          $Res,
          _$GroupBuyContributionModelImpl
        >
    implements _$$GroupBuyContributionModelImplCopyWith<$Res> {
  __$$GroupBuyContributionModelImplCopyWithImpl(
    _$GroupBuyContributionModelImpl _value,
    $Res Function(_$GroupBuyContributionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? amount = null,
    Object? journalId = freezed,
    Object? deliveryAddress = freezed,
    Object? contributedAt = null,
  }) {
    return _then(
      _$GroupBuyContributionModelImpl(
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
        deliveryAddress: freezed == deliveryAddress
            ? _value.deliveryAddress
            : deliveryAddress // ignore: cast_nullable_to_non_nullable
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

class _$GroupBuyContributionModelImpl extends _GroupBuyContributionModel {
  const _$GroupBuyContributionModelImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required this.amount,
    this.journalId,
    this.deliveryAddress,
    required this.contributedAt,
  }) : super._();

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
  final String? deliveryAddress;
  @override
  final DateTime contributedAt;

  @override
  String toString() {
    return 'GroupBuyContributionModel(id: $id, userId: $userId, userName: $userName, amount: $amount, journalId: $journalId, deliveryAddress: $deliveryAddress, contributedAt: $contributedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBuyContributionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.journalId, journalId) ||
                other.journalId == journalId) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.contributedAt, contributedAt) ||
                other.contributedAt == contributedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    userName,
    amount,
    journalId,
    deliveryAddress,
    contributedAt,
  );

  /// Create a copy of GroupBuyContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBuyContributionModelImplCopyWith<_$GroupBuyContributionModelImpl>
  get copyWith =>
      __$$GroupBuyContributionModelImplCopyWithImpl<
        _$GroupBuyContributionModelImpl
      >(this, _$identity);
}

abstract class _GroupBuyContributionModel extends GroupBuyContributionModel {
  const factory _GroupBuyContributionModel({
    required final String id,
    required final String userId,
    required final String userName,
    required final int amount,
    final String? journalId,
    final String? deliveryAddress,
    required final DateTime contributedAt,
  }) = _$GroupBuyContributionModelImpl;
  const _GroupBuyContributionModel._() : super._();

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
  String? get deliveryAddress;
  @override
  DateTime get contributedAt;

  /// Create a copy of GroupBuyContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBuyContributionModelImplCopyWith<_$GroupBuyContributionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
