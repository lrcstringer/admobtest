// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupSettings _$GroupSettingsFromJson(Map<String, dynamic> json) {
  return _GroupSettings.fromJson(json);
}

/// @nodoc
mixin _$GroupSettings {
  int get requireApprovalAbove => throw _privateConstructorUsedError;
  bool get allowMemberWithdrawals => throw _privateConstructorUsedError;
  ContributionCycle get contributionCycle => throw _privateConstructorUsedError;
  int get contributionAmount => throw _privateConstructorUsedError;
  int get penaltyPercentage => throw _privateConstructorUsedError;

  /// Serializes this GroupSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupSettingsCopyWith<GroupSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupSettingsCopyWith<$Res> {
  factory $GroupSettingsCopyWith(
    GroupSettings value,
    $Res Function(GroupSettings) then,
  ) = _$GroupSettingsCopyWithImpl<$Res, GroupSettings>;
  @useResult
  $Res call({
    int requireApprovalAbove,
    bool allowMemberWithdrawals,
    ContributionCycle contributionCycle,
    int contributionAmount,
    int penaltyPercentage,
  });
}

/// @nodoc
class _$GroupSettingsCopyWithImpl<$Res, $Val extends GroupSettings>
    implements $GroupSettingsCopyWith<$Res> {
  _$GroupSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupSettings
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
                      as ContributionCycle,
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
abstract class _$$GroupSettingsImplCopyWith<$Res>
    implements $GroupSettingsCopyWith<$Res> {
  factory _$$GroupSettingsImplCopyWith(
    _$GroupSettingsImpl value,
    $Res Function(_$GroupSettingsImpl) then,
  ) = __$$GroupSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int requireApprovalAbove,
    bool allowMemberWithdrawals,
    ContributionCycle contributionCycle,
    int contributionAmount,
    int penaltyPercentage,
  });
}

/// @nodoc
class __$$GroupSettingsImplCopyWithImpl<$Res>
    extends _$GroupSettingsCopyWithImpl<$Res, _$GroupSettingsImpl>
    implements _$$GroupSettingsImplCopyWith<$Res> {
  __$$GroupSettingsImplCopyWithImpl(
    _$GroupSettingsImpl _value,
    $Res Function(_$GroupSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupSettings
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
      _$GroupSettingsImpl(
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
                  as ContributionCycle,
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
class _$GroupSettingsImpl extends _GroupSettings {
  const _$GroupSettingsImpl({
    required this.requireApprovalAbove,
    required this.allowMemberWithdrawals,
    required this.contributionCycle,
    required this.contributionAmount,
    required this.penaltyPercentage,
  }) : super._();

  factory _$GroupSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupSettingsImplFromJson(json);

  @override
  final int requireApprovalAbove;
  @override
  final bool allowMemberWithdrawals;
  @override
  final ContributionCycle contributionCycle;
  @override
  final int contributionAmount;
  @override
  final int penaltyPercentage;

  @override
  String toString() {
    return 'GroupSettings(requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupSettingsImpl &&
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

  /// Create a copy of GroupSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupSettingsImplCopyWith<_$GroupSettingsImpl> get copyWith =>
      __$$GroupSettingsImplCopyWithImpl<_$GroupSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupSettingsImplToJson(this);
  }
}

abstract class _GroupSettings extends GroupSettings {
  const factory _GroupSettings({
    required final int requireApprovalAbove,
    required final bool allowMemberWithdrawals,
    required final ContributionCycle contributionCycle,
    required final int contributionAmount,
    required final int penaltyPercentage,
  }) = _$GroupSettingsImpl;
  const _GroupSettings._() : super._();

  factory _GroupSettings.fromJson(Map<String, dynamic> json) =
      _$GroupSettingsImpl.fromJson;

  @override
  int get requireApprovalAbove;
  @override
  bool get allowMemberWithdrawals;
  @override
  ContributionCycle get contributionCycle;
  @override
  int get contributionAmount;
  @override
  int get penaltyPercentage;

  /// Create a copy of GroupSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupSettingsImplCopyWith<_$GroupSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StokvelSettings _$StokvelSettingsFromJson(Map<String, dynamic> json) {
  return _StokvelSettings.fromJson(json);
}

/// @nodoc
mixin _$StokvelSettings {
  PayoutType get payoutType => throw _privateConstructorUsedError;
  String get payoutSchedule => throw _privateConstructorUsedError;
  String? get currentPayoutRecipient => throw _privateConstructorUsedError;
  DateTime? get nextPayoutDate => throw _privateConstructorUsedError;
  List<String> get payoutOrder => throw _privateConstructorUsedError;

  /// Serializes this StokvelSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StokvelSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StokvelSettingsCopyWith<StokvelSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StokvelSettingsCopyWith<$Res> {
  factory $StokvelSettingsCopyWith(
    StokvelSettings value,
    $Res Function(StokvelSettings) then,
  ) = _$StokvelSettingsCopyWithImpl<$Res, StokvelSettings>;
  @useResult
  $Res call({
    PayoutType payoutType,
    String payoutSchedule,
    String? currentPayoutRecipient,
    DateTime? nextPayoutDate,
    List<String> payoutOrder,
  });
}

/// @nodoc
class _$StokvelSettingsCopyWithImpl<$Res, $Val extends StokvelSettings>
    implements $StokvelSettingsCopyWith<$Res> {
  _$StokvelSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StokvelSettings
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
                      as PayoutType,
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
abstract class _$$StokvelSettingsImplCopyWith<$Res>
    implements $StokvelSettingsCopyWith<$Res> {
  factory _$$StokvelSettingsImplCopyWith(
    _$StokvelSettingsImpl value,
    $Res Function(_$StokvelSettingsImpl) then,
  ) = __$$StokvelSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PayoutType payoutType,
    String payoutSchedule,
    String? currentPayoutRecipient,
    DateTime? nextPayoutDate,
    List<String> payoutOrder,
  });
}

/// @nodoc
class __$$StokvelSettingsImplCopyWithImpl<$Res>
    extends _$StokvelSettingsCopyWithImpl<$Res, _$StokvelSettingsImpl>
    implements _$$StokvelSettingsImplCopyWith<$Res> {
  __$$StokvelSettingsImplCopyWithImpl(
    _$StokvelSettingsImpl _value,
    $Res Function(_$StokvelSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StokvelSettings
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
      _$StokvelSettingsImpl(
        payoutType: null == payoutType
            ? _value.payoutType
            : payoutType // ignore: cast_nullable_to_non_nullable
                  as PayoutType,
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
class _$StokvelSettingsImpl extends _StokvelSettings {
  const _$StokvelSettingsImpl({
    required this.payoutType,
    required this.payoutSchedule,
    this.currentPayoutRecipient,
    this.nextPayoutDate,
    required final List<String> payoutOrder,
  }) : _payoutOrder = payoutOrder,
       super._();

  factory _$StokvelSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StokvelSettingsImplFromJson(json);

  @override
  final PayoutType payoutType;
  @override
  final String payoutSchedule;
  @override
  final String? currentPayoutRecipient;
  @override
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
    return 'StokvelSettings(payoutType: $payoutType, payoutSchedule: $payoutSchedule, currentPayoutRecipient: $currentPayoutRecipient, nextPayoutDate: $nextPayoutDate, payoutOrder: $payoutOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StokvelSettingsImpl &&
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

  /// Create a copy of StokvelSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StokvelSettingsImplCopyWith<_$StokvelSettingsImpl> get copyWith =>
      __$$StokvelSettingsImplCopyWithImpl<_$StokvelSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StokvelSettingsImplToJson(this);
  }
}

abstract class _StokvelSettings extends StokvelSettings {
  const factory _StokvelSettings({
    required final PayoutType payoutType,
    required final String payoutSchedule,
    final String? currentPayoutRecipient,
    final DateTime? nextPayoutDate,
    required final List<String> payoutOrder,
  }) = _$StokvelSettingsImpl;
  const _StokvelSettings._() : super._();

  factory _StokvelSettings.fromJson(Map<String, dynamic> json) =
      _$StokvelSettingsImpl.fromJson;

  @override
  PayoutType get payoutType;
  @override
  String get payoutSchedule;
  @override
  String? get currentPayoutRecipient;
  @override
  DateTime? get nextPayoutDate;
  @override
  List<String> get payoutOrder;

  /// Create a copy of StokvelSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StokvelSettingsImplCopyWith<_$StokvelSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String get id => throw _privateConstructorUsedError;
  GroupType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  int get totalBalance => throw _privateConstructorUsedError;
  GroupStatus get status => throw _privateConstructorUsedError;
  GroupSettings get settings => throw _privateConstructorUsedError;
  StokvelSettings? get stokvelSettings => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call({
    String id,
    GroupType type,
    String name,
    String description,
    String? avatarUrl,
    String ownerId,
    List<String> memberIds,
    int memberCount,
    int totalBalance,
    GroupStatus status,
    GroupSettings settings,
    StokvelSettings? stokvelSettings,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $GroupSettingsCopyWith<$Res> get settings;
  $StokvelSettingsCopyWith<$Res>? get stokvelSettings;
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Group
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
                      as GroupType,
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
                      as GroupStatus,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as GroupSettings,
            stokvelSettings: freezed == stokvelSettings
                ? _value.stokvelSettings
                : stokvelSettings // ignore: cast_nullable_to_non_nullable
                      as StokvelSettings?,
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

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupSettingsCopyWith<$Res> get settings {
    return $GroupSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StokvelSettingsCopyWith<$Res>? get stokvelSettings {
    if (_value.stokvelSettings == null) {
      return null;
    }

    return $StokvelSettingsCopyWith<$Res>(_value.stokvelSettings!, (value) {
      return _then(_value.copyWith(stokvelSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
    _$GroupImpl value,
    $Res Function(_$GroupImpl) then,
  ) = __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    GroupType type,
    String name,
    String description,
    String? avatarUrl,
    String ownerId,
    List<String> memberIds,
    int memberCount,
    int totalBalance,
    GroupStatus status,
    GroupSettings settings,
    StokvelSettings? stokvelSettings,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $GroupSettingsCopyWith<$Res> get settings;
  @override
  $StokvelSettingsCopyWith<$Res>? get stokvelSettings;
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
    _$GroupImpl _value,
    $Res Function(_$GroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Group
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
      _$GroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as GroupType,
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
                  as GroupStatus,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as GroupSettings,
        stokvelSettings: freezed == stokvelSettings
            ? _value.stokvelSettings
            : stokvelSettings // ignore: cast_nullable_to_non_nullable
                  as StokvelSettings?,
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
class _$GroupImpl extends _Group {
  const _$GroupImpl({
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
    required this.createdAt,
    required this.updatedAt,
  }) : _memberIds = memberIds,
       super._();

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  @override
  final String id;
  @override
  final GroupType type;
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
  final GroupStatus status;
  @override
  final GroupSettings settings;
  @override
  final StokvelSettings? stokvelSettings;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Group(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
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

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(this);
  }
}

abstract class _Group extends Group {
  const factory _Group({
    required final String id,
    required final GroupType type,
    required final String name,
    required final String description,
    final String? avatarUrl,
    required final String ownerId,
    required final List<String> memberIds,
    required final int memberCount,
    required final int totalBalance,
    required final GroupStatus status,
    required final GroupSettings settings,
    final StokvelSettings? stokvelSettings,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$GroupImpl;
  const _Group._() : super._();

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String get id;
  @override
  GroupType get type;
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
  GroupStatus get status;
  @override
  GroupSettings get settings;
  @override
  StokvelSettings? get stokvelSettings;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
