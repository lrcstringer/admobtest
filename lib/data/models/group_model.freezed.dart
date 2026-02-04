// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupSettingsModel _$GroupSettingsModelFromJson(Map<String, dynamic> json) {
  return _GroupSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$GroupSettingsModel {
  int get requireApprovalAbove => throw _privateConstructorUsedError;
  bool get allowMemberWithdrawals => throw _privateConstructorUsedError;
  String get contributionCycle => throw _privateConstructorUsedError;
  int get contributionAmount => throw _privateConstructorUsedError;
  int get penaltyPercentage => throw _privateConstructorUsedError;

  /// Serializes this GroupSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupSettingsModelCopyWith<GroupSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupSettingsModelCopyWith<$Res> {
  factory $GroupSettingsModelCopyWith(
    GroupSettingsModel value,
    $Res Function(GroupSettingsModel) then,
  ) = _$GroupSettingsModelCopyWithImpl<$Res, GroupSettingsModel>;
  @useResult
  $Res call({
    int requireApprovalAbove,
    bool allowMemberWithdrawals,
    String contributionCycle,
    int contributionAmount,
    int penaltyPercentage,
  });
}

/// @nodoc
class _$GroupSettingsModelCopyWithImpl<$Res, $Val extends GroupSettingsModel>
    implements $GroupSettingsModelCopyWith<$Res> {
  _$GroupSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requireApprovalAbove = null,
    Object? allowMemberWithdrawals = null,
    Object? contributionCycle = null,
    Object? contributionAmount = null,
    Object? penaltyPercentage = null,
  }) {
    return _then(
      _value.copyWith(
            requireApprovalAbove: null == requireApprovalAbove
                ? _value.requireApprovalAbove
                : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
                      as int,
            allowMemberWithdrawals: null == allowMemberWithdrawals
                ? _value.allowMemberWithdrawals
                : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
                      as bool,
            contributionCycle: null == contributionCycle
                ? _value.contributionCycle
                : contributionCycle // ignore: cast_nullable_to_non_nullable
                      as String,
            contributionAmount: null == contributionAmount
                ? _value.contributionAmount
                : contributionAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            penaltyPercentage: null == penaltyPercentage
                ? _value.penaltyPercentage
                : penaltyPercentage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupSettingsModelImplCopyWith<$Res>
    implements $GroupSettingsModelCopyWith<$Res> {
  factory _$$GroupSettingsModelImplCopyWith(
    _$GroupSettingsModelImpl value,
    $Res Function(_$GroupSettingsModelImpl) then,
  ) = __$$GroupSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int requireApprovalAbove,
    bool allowMemberWithdrawals,
    String contributionCycle,
    int contributionAmount,
    int penaltyPercentage,
  });
}

/// @nodoc
class __$$GroupSettingsModelImplCopyWithImpl<$Res>
    extends _$GroupSettingsModelCopyWithImpl<$Res, _$GroupSettingsModelImpl>
    implements _$$GroupSettingsModelImplCopyWith<$Res> {
  __$$GroupSettingsModelImplCopyWithImpl(
    _$GroupSettingsModelImpl _value,
    $Res Function(_$GroupSettingsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requireApprovalAbove = null,
    Object? allowMemberWithdrawals = null,
    Object? contributionCycle = null,
    Object? contributionAmount = null,
    Object? penaltyPercentage = null,
  }) {
    return _then(
      _$GroupSettingsModelImpl(
        requireApprovalAbove: null == requireApprovalAbove
            ? _value.requireApprovalAbove
            : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
                  as int,
        allowMemberWithdrawals: null == allowMemberWithdrawals
            ? _value.allowMemberWithdrawals
            : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
                  as bool,
        contributionCycle: null == contributionCycle
            ? _value.contributionCycle
            : contributionCycle // ignore: cast_nullable_to_non_nullable
                  as String,
        contributionAmount: null == contributionAmount
            ? _value.contributionAmount
            : contributionAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        penaltyPercentage: null == penaltyPercentage
            ? _value.penaltyPercentage
            : penaltyPercentage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupSettingsModelImpl extends _GroupSettingsModel {
  const _$GroupSettingsModelImpl({
    required this.requireApprovalAbove,
    required this.allowMemberWithdrawals,
    required this.contributionCycle,
    required this.contributionAmount,
    required this.penaltyPercentage,
  }) : super._();

  factory _$GroupSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupSettingsModelImplFromJson(json);

  @override
  final int requireApprovalAbove;
  @override
  final bool allowMemberWithdrawals;
  @override
  final String contributionCycle;
  @override
  final int contributionAmount;
  @override
  final int penaltyPercentage;

  @override
  String toString() {
    return 'GroupSettingsModel(requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupSettingsModelImpl &&
            (identical(other.requireApprovalAbove, requireApprovalAbove) ||
                other.requireApprovalAbove == requireApprovalAbove) &&
            (identical(other.allowMemberWithdrawals, allowMemberWithdrawals) ||
                other.allowMemberWithdrawals == allowMemberWithdrawals) &&
            (identical(other.contributionCycle, contributionCycle) ||
                other.contributionCycle == contributionCycle) &&
            (identical(other.contributionAmount, contributionAmount) ||
                other.contributionAmount == contributionAmount) &&
            (identical(other.penaltyPercentage, penaltyPercentage) ||
                other.penaltyPercentage == penaltyPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    requireApprovalAbove,
    allowMemberWithdrawals,
    contributionCycle,
    contributionAmount,
    penaltyPercentage,
  );

  /// Create a copy of GroupSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupSettingsModelImplCopyWith<_$GroupSettingsModelImpl> get copyWith =>
      __$$GroupSettingsModelImplCopyWithImpl<_$GroupSettingsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupSettingsModelImplToJson(this);
  }
}

abstract class _GroupSettingsModel extends GroupSettingsModel {
  const factory _GroupSettingsModel({
    required final int requireApprovalAbove,
    required final bool allowMemberWithdrawals,
    required final String contributionCycle,
    required final int contributionAmount,
    required final int penaltyPercentage,
  }) = _$GroupSettingsModelImpl;
  const _GroupSettingsModel._() : super._();

  factory _GroupSettingsModel.fromJson(Map<String, dynamic> json) =
      _$GroupSettingsModelImpl.fromJson;

  @override
  int get requireApprovalAbove;
  @override
  bool get allowMemberWithdrawals;
  @override
  String get contributionCycle;
  @override
  int get contributionAmount;
  @override
  int get penaltyPercentage;

  /// Create a copy of GroupSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupSettingsModelImplCopyWith<_$GroupSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StokvelSettingsModel _$StokvelSettingsModelFromJson(Map<String, dynamic> json) {
  return _StokvelSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$StokvelSettingsModel {
  String get payoutType => throw _privateConstructorUsedError;
  String get payoutSchedule => throw _privateConstructorUsedError;
  String? get currentPayoutRecipient => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get nextPayoutDate => throw _privateConstructorUsedError;
  List<String> get payoutOrder => throw _privateConstructorUsedError;

  /// Serializes this StokvelSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StokvelSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StokvelSettingsModelCopyWith<StokvelSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StokvelSettingsModelCopyWith<$Res> {
  factory $StokvelSettingsModelCopyWith(
    StokvelSettingsModel value,
    $Res Function(StokvelSettingsModel) then,
  ) = _$StokvelSettingsModelCopyWithImpl<$Res, StokvelSettingsModel>;
  @useResult
  $Res call({
    String payoutType,
    String payoutSchedule,
    String? currentPayoutRecipient,
    @NullableTimestampConverter() DateTime? nextPayoutDate,
    List<String> payoutOrder,
  });
}

/// @nodoc
class _$StokvelSettingsModelCopyWithImpl<
  $Res,
  $Val extends StokvelSettingsModel
>
    implements $StokvelSettingsModelCopyWith<$Res> {
  _$StokvelSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StokvelSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payoutType = null,
    Object? payoutSchedule = null,
    Object? currentPayoutRecipient = freezed,
    Object? nextPayoutDate = freezed,
    Object? payoutOrder = null,
  }) {
    return _then(
      _value.copyWith(
            payoutType: null == payoutType
                ? _value.payoutType
                : payoutType // ignore: cast_nullable_to_non_nullable
                      as String,
            payoutSchedule: null == payoutSchedule
                ? _value.payoutSchedule
                : payoutSchedule // ignore: cast_nullable_to_non_nullable
                      as String,
            currentPayoutRecipient: freezed == currentPayoutRecipient
                ? _value.currentPayoutRecipient
                : currentPayoutRecipient // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextPayoutDate: freezed == nextPayoutDate
                ? _value.nextPayoutDate
                : nextPayoutDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            payoutOrder: null == payoutOrder
                ? _value.payoutOrder
                : payoutOrder // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StokvelSettingsModelImplCopyWith<$Res>
    implements $StokvelSettingsModelCopyWith<$Res> {
  factory _$$StokvelSettingsModelImplCopyWith(
    _$StokvelSettingsModelImpl value,
    $Res Function(_$StokvelSettingsModelImpl) then,
  ) = __$$StokvelSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String payoutType,
    String payoutSchedule,
    String? currentPayoutRecipient,
    @NullableTimestampConverter() DateTime? nextPayoutDate,
    List<String> payoutOrder,
  });
}

/// @nodoc
class __$$StokvelSettingsModelImplCopyWithImpl<$Res>
    extends _$StokvelSettingsModelCopyWithImpl<$Res, _$StokvelSettingsModelImpl>
    implements _$$StokvelSettingsModelImplCopyWith<$Res> {
  __$$StokvelSettingsModelImplCopyWithImpl(
    _$StokvelSettingsModelImpl _value,
    $Res Function(_$StokvelSettingsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StokvelSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payoutType = null,
    Object? payoutSchedule = null,
    Object? currentPayoutRecipient = freezed,
    Object? nextPayoutDate = freezed,
    Object? payoutOrder = null,
  }) {
    return _then(
      _$StokvelSettingsModelImpl(
        payoutType: null == payoutType
            ? _value.payoutType
            : payoutType // ignore: cast_nullable_to_non_nullable
                  as String,
        payoutSchedule: null == payoutSchedule
            ? _value.payoutSchedule
            : payoutSchedule // ignore: cast_nullable_to_non_nullable
                  as String,
        currentPayoutRecipient: freezed == currentPayoutRecipient
            ? _value.currentPayoutRecipient
            : currentPayoutRecipient // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextPayoutDate: freezed == nextPayoutDate
            ? _value.nextPayoutDate
            : nextPayoutDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        payoutOrder: null == payoutOrder
            ? _value._payoutOrder
            : payoutOrder // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StokvelSettingsModelImpl extends _StokvelSettingsModel {
  const _$StokvelSettingsModelImpl({
    required this.payoutType,
    required this.payoutSchedule,
    this.currentPayoutRecipient,
    @NullableTimestampConverter() this.nextPayoutDate,
    required final List<String> payoutOrder,
  }) : _payoutOrder = payoutOrder,
       super._();

  factory _$StokvelSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StokvelSettingsModelImplFromJson(json);

  @override
  final String payoutType;
  @override
  final String payoutSchedule;
  @override
  final String? currentPayoutRecipient;
  @override
  @NullableTimestampConverter()
  final DateTime? nextPayoutDate;
  final List<String> _payoutOrder;
  @override
  List<String> get payoutOrder {
    if (_payoutOrder is EqualUnmodifiableListView) return _payoutOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payoutOrder);
  }

  @override
  String toString() {
    return 'StokvelSettingsModel(payoutType: $payoutType, payoutSchedule: $payoutSchedule, currentPayoutRecipient: $currentPayoutRecipient, nextPayoutDate: $nextPayoutDate, payoutOrder: $payoutOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StokvelSettingsModelImpl &&
            (identical(other.payoutType, payoutType) ||
                other.payoutType == payoutType) &&
            (identical(other.payoutSchedule, payoutSchedule) ||
                other.payoutSchedule == payoutSchedule) &&
            (identical(other.currentPayoutRecipient, currentPayoutRecipient) ||
                other.currentPayoutRecipient == currentPayoutRecipient) &&
            (identical(other.nextPayoutDate, nextPayoutDate) ||
                other.nextPayoutDate == nextPayoutDate) &&
            const DeepCollectionEquality().equals(
              other._payoutOrder,
              _payoutOrder,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    payoutType,
    payoutSchedule,
    currentPayoutRecipient,
    nextPayoutDate,
    const DeepCollectionEquality().hash(_payoutOrder),
  );

  /// Create a copy of StokvelSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StokvelSettingsModelImplCopyWith<_$StokvelSettingsModelImpl>
  get copyWith =>
      __$$StokvelSettingsModelImplCopyWithImpl<_$StokvelSettingsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StokvelSettingsModelImplToJson(this);
  }
}

abstract class _StokvelSettingsModel extends StokvelSettingsModel {
  const factory _StokvelSettingsModel({
    required final String payoutType,
    required final String payoutSchedule,
    final String? currentPayoutRecipient,
    @NullableTimestampConverter() final DateTime? nextPayoutDate,
    required final List<String> payoutOrder,
  }) = _$StokvelSettingsModelImpl;
  const _StokvelSettingsModel._() : super._();

  factory _StokvelSettingsModel.fromJson(Map<String, dynamic> json) =
      _$StokvelSettingsModelImpl.fromJson;

  @override
  String get payoutType;
  @override
  String get payoutSchedule;
  @override
  String? get currentPayoutRecipient;
  @override
  @NullableTimestampConverter()
  DateTime? get nextPayoutDate;
  @override
  List<String> get payoutOrder;

  /// Create a copy of StokvelSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StokvelSettingsModelImplCopyWith<_$StokvelSettingsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  int get totalBalance => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  GroupSettingsModel get settings => throw _privateConstructorUsedError;
  StokvelSettingsModel? get stokvelSettings =>
      throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
    GroupModel value,
    $Res Function(GroupModel) then,
  ) = _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call({
    String id,
    String type,
    String name,
    String description,
    String? avatarUrl,
    String ownerId,
    List<String> memberIds,
    int memberCount,
    int totalBalance,
    String status,
    GroupSettingsModel settings,
    StokvelSettingsModel? stokvelSettings,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });

  $GroupSettingsModelCopyWith<$Res> get settings;
  $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? avatarUrl = freezed,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? memberCount = null,
    Object? totalBalance = null,
    Object? status = null,
    Object? settings = null,
    Object? stokvelSettings = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            memberIds: null == memberIds
                ? _value.memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            memberCount: null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalBalance: null == totalBalance
                ? _value.totalBalance
                : totalBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as GroupSettingsModel,
            stokvelSettings: freezed == stokvelSettings
                ? _value.stokvelSettings
                : stokvelSettings // ignore: cast_nullable_to_non_nullable
                      as StokvelSettingsModel?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupSettingsModelCopyWith<$Res> get settings {
    return $GroupSettingsModelCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings {
    if (_value.stokvelSettings == null) {
      return null;
    }

    return $StokvelSettingsModelCopyWith<$Res>(_value.stokvelSettings!, (
      value,
    ) {
      return _then(_value.copyWith(stokvelSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
    _$GroupModelImpl value,
    $Res Function(_$GroupModelImpl) then,
  ) = __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String name,
    String description,
    String? avatarUrl,
    String ownerId,
    List<String> memberIds,
    int memberCount,
    int totalBalance,
    String status,
    GroupSettingsModel settings,
    StokvelSettingsModel? stokvelSettings,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });

  @override
  $GroupSettingsModelCopyWith<$Res> get settings;
  @override
  $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
    _$GroupModelImpl _value,
    $Res Function(_$GroupModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? avatarUrl = freezed,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? memberCount = null,
    Object? totalBalance = null,
    Object? status = null,
    Object? settings = null,
    Object? stokvelSettings = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$GroupModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberIds: null == memberIds
            ? _value._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        memberCount: null == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalBalance: null == totalBalance
            ? _value.totalBalance
            : totalBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as GroupSettingsModel,
        stokvelSettings: freezed == stokvelSettings
            ? _value.stokvelSettings
            : stokvelSettings // ignore: cast_nullable_to_non_nullable
                  as StokvelSettingsModel?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupModelImpl extends _GroupModel {
  const _$GroupModelImpl({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.avatarUrl,
    required this.ownerId,
    required final List<String> memberIds,
    required this.memberCount,
    required this.totalBalance,
    required this.status,
    required this.settings,
    this.stokvelSettings,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  }) : _memberIds = memberIds,
       super._();

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? avatarUrl;
  @override
  final String ownerId;
  final List<String> _memberIds;
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  @override
  final int memberCount;
  @override
  final int totalBalance;
  @override
  final String status;
  @override
  final GroupSettingsModel settings;
  @override
  final StokvelSettingsModel? stokvelSettings;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'GroupModel(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.stokvelSettings, stokvelSettings) ||
                other.stokvelSettings == stokvelSettings) &&
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
    name,
    description,
    avatarUrl,
    ownerId,
    const DeepCollectionEquality().hash(_memberIds),
    memberCount,
    totalBalance,
    status,
    settings,
    stokvelSettings,
    createdAt,
    updatedAt,
  );

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(this);
  }
}

abstract class _GroupModel extends GroupModel {
  const factory _GroupModel({
    required final String id,
    required final String type,
    required final String name,
    required final String description,
    final String? avatarUrl,
    required final String ownerId,
    required final List<String> memberIds,
    required final int memberCount,
    required final int totalBalance,
    required final String status,
    required final GroupSettingsModel settings,
    final StokvelSettingsModel? stokvelSettings,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$GroupModelImpl;
  const _GroupModel._() : super._();

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get avatarUrl;
  @override
  String get ownerId;
  @override
  List<String> get memberIds;
  @override
  int get memberCount;
  @override
  int get totalBalance;
  @override
  String get status;
  @override
  GroupSettingsModel get settings;
  @override
  StokvelSettingsModel? get stokvelSettings;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
