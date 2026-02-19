// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommunitySettingsModel _$CommunitySettingsModelFromJson(
  Map<String, dynamic> json,
) {
  return _CommunitySettingsModel.fromJson(json);
}

/// @nodoc
mixin _$CommunitySettingsModel {
  int get maxMembers => throw _privateConstructorUsedError;
  bool get allowMemberInvites => throw _privateConstructorUsedError;
  bool get onlyAdminsPost => throw _privateConstructorUsedError;
  bool get membersCanShareMedia => throw _privateConstructorUsedError;
  bool get enableFinancials => throw _privateConstructorUsedError;
  int get requireApprovalAbove => throw _privateConstructorUsedError;
  bool get allowMemberWithdrawals => throw _privateConstructorUsedError;
  String get contributionCycle => throw _privateConstructorUsedError;
  int get contributionAmount => throw _privateConstructorUsedError;
  int get penaltyPercentage => throw _privateConstructorUsedError;

  /// Serializes this CommunitySettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunitySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunitySettingsModelCopyWith<CommunitySettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunitySettingsModelCopyWith<$Res> {
  factory $CommunitySettingsModelCopyWith(
    CommunitySettingsModel value,
    $Res Function(CommunitySettingsModel) then,
  ) = _$CommunitySettingsModelCopyWithImpl<$Res, CommunitySettingsModel>;
  @useResult
  $Res call({
    int maxMembers,
    bool allowMemberInvites,
    bool onlyAdminsPost,
    bool membersCanShareMedia,
    bool enableFinancials,
    int requireApprovalAbove,
    bool allowMemberWithdrawals,
    String contributionCycle,
    int contributionAmount,
    int penaltyPercentage,
  });
}

/// @nodoc
class _$CommunitySettingsModelCopyWithImpl<
  $Res,
  $Val extends CommunitySettingsModel
>
    implements $CommunitySettingsModelCopyWith<$Res> {
  _$CommunitySettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunitySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxMembers = null,
    Object? allowMemberInvites = null,
    Object? onlyAdminsPost = null,
    Object? membersCanShareMedia = null,
    Object? enableFinancials = null,
    Object? requireApprovalAbove = null,
    Object? allowMemberWithdrawals = null,
    Object? contributionCycle = null,
    Object? contributionAmount = null,
    Object? penaltyPercentage = null,
  }) {
    return _then(
      _value.copyWith(
            maxMembers: null == maxMembers
                ? _value.maxMembers
                : maxMembers // ignore: cast_nullable_to_non_nullable
                      as int,
            allowMemberInvites: null == allowMemberInvites
                ? _value.allowMemberInvites
                : allowMemberInvites // ignore: cast_nullable_to_non_nullable
                      as bool,
            onlyAdminsPost: null == onlyAdminsPost
                ? _value.onlyAdminsPost
                : onlyAdminsPost // ignore: cast_nullable_to_non_nullable
                      as bool,
            membersCanShareMedia: null == membersCanShareMedia
                ? _value.membersCanShareMedia
                : membersCanShareMedia // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableFinancials: null == enableFinancials
                ? _value.enableFinancials
                : enableFinancials // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$CommunitySettingsModelImplCopyWith<$Res>
    implements $CommunitySettingsModelCopyWith<$Res> {
  factory _$$CommunitySettingsModelImplCopyWith(
    _$CommunitySettingsModelImpl value,
    $Res Function(_$CommunitySettingsModelImpl) then,
  ) = __$$CommunitySettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int maxMembers,
    bool allowMemberInvites,
    bool onlyAdminsPost,
    bool membersCanShareMedia,
    bool enableFinancials,
    int requireApprovalAbove,
    bool allowMemberWithdrawals,
    String contributionCycle,
    int contributionAmount,
    int penaltyPercentage,
  });
}

/// @nodoc
class __$$CommunitySettingsModelImplCopyWithImpl<$Res>
    extends
        _$CommunitySettingsModelCopyWithImpl<$Res, _$CommunitySettingsModelImpl>
    implements _$$CommunitySettingsModelImplCopyWith<$Res> {
  __$$CommunitySettingsModelImplCopyWithImpl(
    _$CommunitySettingsModelImpl _value,
    $Res Function(_$CommunitySettingsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunitySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxMembers = null,
    Object? allowMemberInvites = null,
    Object? onlyAdminsPost = null,
    Object? membersCanShareMedia = null,
    Object? enableFinancials = null,
    Object? requireApprovalAbove = null,
    Object? allowMemberWithdrawals = null,
    Object? contributionCycle = null,
    Object? contributionAmount = null,
    Object? penaltyPercentage = null,
  }) {
    return _then(
      _$CommunitySettingsModelImpl(
        maxMembers: null == maxMembers
            ? _value.maxMembers
            : maxMembers // ignore: cast_nullable_to_non_nullable
                  as int,
        allowMemberInvites: null == allowMemberInvites
            ? _value.allowMemberInvites
            : allowMemberInvites // ignore: cast_nullable_to_non_nullable
                  as bool,
        onlyAdminsPost: null == onlyAdminsPost
            ? _value.onlyAdminsPost
            : onlyAdminsPost // ignore: cast_nullable_to_non_nullable
                  as bool,
        membersCanShareMedia: null == membersCanShareMedia
            ? _value.membersCanShareMedia
            : membersCanShareMedia // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableFinancials: null == enableFinancials
            ? _value.enableFinancials
            : enableFinancials // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$CommunitySettingsModelImpl extends _CommunitySettingsModel {
  const _$CommunitySettingsModelImpl({
    this.maxMembers = 100,
    this.allowMemberInvites = true,
    this.onlyAdminsPost = false,
    this.membersCanShareMedia = true,
    this.enableFinancials = false,
    this.requireApprovalAbove = 5000,
    this.allowMemberWithdrawals = false,
    this.contributionCycle = 'none',
    this.contributionAmount = 0,
    this.penaltyPercentage = 0,
  }) : super._();

  factory _$CommunitySettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunitySettingsModelImplFromJson(json);

  @override
  @JsonKey()
  final int maxMembers;
  @override
  @JsonKey()
  final bool allowMemberInvites;
  @override
  @JsonKey()
  final bool onlyAdminsPost;
  @override
  @JsonKey()
  final bool membersCanShareMedia;
  @override
  @JsonKey()
  final bool enableFinancials;
  @override
  @JsonKey()
  final int requireApprovalAbove;
  @override
  @JsonKey()
  final bool allowMemberWithdrawals;
  @override
  @JsonKey()
  final String contributionCycle;
  @override
  @JsonKey()
  final int contributionAmount;
  @override
  @JsonKey()
  final int penaltyPercentage;

  @override
  String toString() {
    return 'CommunitySettingsModel(maxMembers: $maxMembers, allowMemberInvites: $allowMemberInvites, onlyAdminsPost: $onlyAdminsPost, membersCanShareMedia: $membersCanShareMedia, enableFinancials: $enableFinancials, requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunitySettingsModelImpl &&
            (identical(other.maxMembers, maxMembers) ||
                other.maxMembers == maxMembers) &&
            (identical(other.allowMemberInvites, allowMemberInvites) ||
                other.allowMemberInvites == allowMemberInvites) &&
            (identical(other.onlyAdminsPost, onlyAdminsPost) ||
                other.onlyAdminsPost == onlyAdminsPost) &&
            (identical(other.membersCanShareMedia, membersCanShareMedia) ||
                other.membersCanShareMedia == membersCanShareMedia) &&
            (identical(other.enableFinancials, enableFinancials) ||
                other.enableFinancials == enableFinancials) &&
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
    maxMembers,
    allowMemberInvites,
    onlyAdminsPost,
    membersCanShareMedia,
    enableFinancials,
    requireApprovalAbove,
    allowMemberWithdrawals,
    contributionCycle,
    contributionAmount,
    penaltyPercentage,
  );

  /// Create a copy of CommunitySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunitySettingsModelImplCopyWith<_$CommunitySettingsModelImpl>
  get copyWith =>
      __$$CommunitySettingsModelImplCopyWithImpl<_$CommunitySettingsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunitySettingsModelImplToJson(this);
  }
}

abstract class _CommunitySettingsModel extends CommunitySettingsModel {
  const factory _CommunitySettingsModel({
    final int maxMembers,
    final bool allowMemberInvites,
    final bool onlyAdminsPost,
    final bool membersCanShareMedia,
    final bool enableFinancials,
    final int requireApprovalAbove,
    final bool allowMemberWithdrawals,
    final String contributionCycle,
    final int contributionAmount,
    final int penaltyPercentage,
  }) = _$CommunitySettingsModelImpl;
  const _CommunitySettingsModel._() : super._();

  factory _CommunitySettingsModel.fromJson(Map<String, dynamic> json) =
      _$CommunitySettingsModelImpl.fromJson;

  @override
  int get maxMembers;
  @override
  bool get allowMemberInvites;
  @override
  bool get onlyAdminsPost;
  @override
  bool get membersCanShareMedia;
  @override
  bool get enableFinancials;
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

  /// Create a copy of CommunitySettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunitySettingsModelImplCopyWith<_$CommunitySettingsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) {
  return _CommunityModel.fromJson(json);
}

/// @nodoc
mixin _$CommunityModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  List<String> get adminIds => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  int get totalBalance => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  CommunitySettingsModel get settings => throw _privateConstructorUsedError;
  StokvelSettingsModel? get stokvelSettings =>
      throw _privateConstructorUsedError; // Last message preview (flat fields — mapped from nested Firestore lastMessage)
  String? get lastMessageText => throw _privateConstructorUsedError;
  String? get lastMessageSenderId => throw _privateConstructorUsedError;
  String? get lastMessageSenderName => throw _privateConstructorUsedError;
  String? get lastMessageType => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get lastMessageAt => throw _privateConstructorUsedError; // Per-user state
  Map<String, int> get unreadCounts => throw _privateConstructorUsedError;
  Map<String, bool> get muted =>
      throw _privateConstructorUsedError; // E2EE: per-user encrypted last message previews
  Map<String, String> get lastMessageEncryptedPreviews =>
      throw _privateConstructorUsedError; // Timestamps
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityModelCopyWith<CommunityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityModelCopyWith<$Res> {
  factory $CommunityModelCopyWith(
    CommunityModel value,
    $Res Function(CommunityModel) then,
  ) = _$CommunityModelCopyWithImpl<$Res, CommunityModel>;
  @useResult
  $Res call({
    String id,
    String type,
    String name,
    String? description,
    String? avatarUrl,
    String ownerId,
    List<String> memberIds,
    List<String> adminIds,
    int memberCount,
    int totalBalance,
    String status,
    CommunitySettingsModel settings,
    StokvelSettingsModel? stokvelSettings,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    @NullableTimestampConverter() DateTime? lastMessageAt,
    Map<String, int> unreadCounts,
    Map<String, bool> muted,
    Map<String, String> lastMessageEncryptedPreviews,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  });

  $CommunitySettingsModelCopyWith<$Res> get settings;
  $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;
}

/// @nodoc
class _$CommunityModelCopyWithImpl<$Res, $Val extends CommunityModel>
    implements $CommunityModelCopyWith<$Res> {
  _$CommunityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? adminIds = null,
    Object? memberCount = null,
    Object? totalBalance = null,
    Object? status = null,
    Object? settings = null,
    Object? stokvelSettings = freezed,
    Object? lastMessageText = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSenderName = freezed,
    Object? lastMessageType = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = null,
    Object? muted = null,
    Object? lastMessageEncryptedPreviews = null,
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
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            adminIds: null == adminIds
                ? _value.adminIds
                : adminIds // ignore: cast_nullable_to_non_nullable
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
                      as CommunitySettingsModel,
            stokvelSettings: freezed == stokvelSettings
                ? _value.stokvelSettings
                : stokvelSettings // ignore: cast_nullable_to_non_nullable
                      as StokvelSettingsModel?,
            lastMessageText: freezed == lastMessageText
                ? _value.lastMessageText
                : lastMessageText // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageSenderId: freezed == lastMessageSenderId
                ? _value.lastMessageSenderId
                : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageSenderName: freezed == lastMessageSenderName
                ? _value.lastMessageSenderName
                : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageType: freezed == lastMessageType
                ? _value.lastMessageType
                : lastMessageType // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: freezed == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            unreadCounts: null == unreadCounts
                ? _value.unreadCounts
                : unreadCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            muted: null == muted
                ? _value.muted
                : muted // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews
                ? _value.lastMessageEncryptedPreviews
                : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
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

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommunitySettingsModelCopyWith<$Res> get settings {
    return $CommunitySettingsModelCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of CommunityModel
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
abstract class _$$CommunityModelImplCopyWith<$Res>
    implements $CommunityModelCopyWith<$Res> {
  factory _$$CommunityModelImplCopyWith(
    _$CommunityModelImpl value,
    $Res Function(_$CommunityModelImpl) then,
  ) = __$$CommunityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String name,
    String? description,
    String? avatarUrl,
    String ownerId,
    List<String> memberIds,
    List<String> adminIds,
    int memberCount,
    int totalBalance,
    String status,
    CommunitySettingsModel settings,
    StokvelSettingsModel? stokvelSettings,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    @NullableTimestampConverter() DateTime? lastMessageAt,
    Map<String, int> unreadCounts,
    Map<String, bool> muted,
    Map<String, String> lastMessageEncryptedPreviews,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  });

  @override
  $CommunitySettingsModelCopyWith<$Res> get settings;
  @override
  $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;
}

/// @nodoc
class __$$CommunityModelImplCopyWithImpl<$Res>
    extends _$CommunityModelCopyWithImpl<$Res, _$CommunityModelImpl>
    implements _$$CommunityModelImplCopyWith<$Res> {
  __$$CommunityModelImplCopyWithImpl(
    _$CommunityModelImpl _value,
    $Res Function(_$CommunityModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? adminIds = null,
    Object? memberCount = null,
    Object? totalBalance = null,
    Object? status = null,
    Object? settings = null,
    Object? stokvelSettings = freezed,
    Object? lastMessageText = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSenderName = freezed,
    Object? lastMessageType = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = null,
    Object? muted = null,
    Object? lastMessageEncryptedPreviews = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CommunityModelImpl(
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
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        adminIds: null == adminIds
            ? _value._adminIds
            : adminIds // ignore: cast_nullable_to_non_nullable
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
                  as CommunitySettingsModel,
        stokvelSettings: freezed == stokvelSettings
            ? _value.stokvelSettings
            : stokvelSettings // ignore: cast_nullable_to_non_nullable
                  as StokvelSettingsModel?,
        lastMessageText: freezed == lastMessageText
            ? _value.lastMessageText
            : lastMessageText // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageSenderId: freezed == lastMessageSenderId
            ? _value.lastMessageSenderId
            : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageSenderName: freezed == lastMessageSenderName
            ? _value.lastMessageSenderName
            : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageType: freezed == lastMessageType
            ? _value.lastMessageType
            : lastMessageType // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: freezed == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unreadCounts: null == unreadCounts
            ? _value._unreadCounts
            : unreadCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        muted: null == muted
            ? _value._muted
            : muted // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews
            ? _value._lastMessageEncryptedPreviews
            : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
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
class _$CommunityModelImpl extends _CommunityModel {
  const _$CommunityModelImpl({
    required this.id,
    required this.type,
    required this.name,
    this.description,
    this.avatarUrl,
    required this.ownerId,
    required final List<String> memberIds,
    required final List<String> adminIds,
    required this.memberCount,
    this.totalBalance = 0,
    required this.status,
    required this.settings,
    this.stokvelSettings,
    this.lastMessageText,
    this.lastMessageSenderId,
    this.lastMessageSenderName,
    this.lastMessageType,
    @NullableTimestampConverter() this.lastMessageAt,
    final Map<String, int> unreadCounts = const {},
    final Map<String, bool> muted = const {},
    final Map<String, String> lastMessageEncryptedPreviews = const {},
    @TimestampConverter() required this.createdAt,
    @NullableTimestampConverter() this.updatedAt,
  }) : _memberIds = memberIds,
       _adminIds = adminIds,
       _unreadCounts = unreadCounts,
       _muted = muted,
       _lastMessageEncryptedPreviews = lastMessageEncryptedPreviews,
       super._();

  factory _$CommunityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String name;
  @override
  final String? description;
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

  final List<String> _adminIds;
  @override
  List<String> get adminIds {
    if (_adminIds is EqualUnmodifiableListView) return _adminIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminIds);
  }

  @override
  final int memberCount;
  @override
  @JsonKey()
  final int totalBalance;
  @override
  final String status;
  @override
  final CommunitySettingsModel settings;
  @override
  final StokvelSettingsModel? stokvelSettings;
  // Last message preview (flat fields — mapped from nested Firestore lastMessage)
  @override
  final String? lastMessageText;
  @override
  final String? lastMessageSenderId;
  @override
  final String? lastMessageSenderName;
  @override
  final String? lastMessageType;
  @override
  @NullableTimestampConverter()
  final DateTime? lastMessageAt;
  // Per-user state
  final Map<String, int> _unreadCounts;
  // Per-user state
  @override
  @JsonKey()
  Map<String, int> get unreadCounts {
    if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unreadCounts);
  }

  final Map<String, bool> _muted;
  @override
  @JsonKey()
  Map<String, bool> get muted {
    if (_muted is EqualUnmodifiableMapView) return _muted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_muted);
  }

  // E2EE: per-user encrypted last message previews
  final Map<String, String> _lastMessageEncryptedPreviews;
  // E2EE: per-user encrypted last message previews
  @override
  @JsonKey()
  Map<String, String> get lastMessageEncryptedPreviews {
    if (_lastMessageEncryptedPreviews is EqualUnmodifiableMapView)
      return _lastMessageEncryptedPreviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastMessageEncryptedPreviews);
  }

  // Timestamps
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @NullableTimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CommunityModel(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, adminIds: $adminIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityModelImpl &&
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
            const DeepCollectionEquality().equals(other._adminIds, _adminIds) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.stokvelSettings, stokvelSettings) ||
                other.stokvelSettings == stokvelSettings) &&
            (identical(other.lastMessageText, lastMessageText) ||
                other.lastMessageText == lastMessageText) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(other.lastMessageSenderName, lastMessageSenderName) ||
                other.lastMessageSenderName == lastMessageSenderName) &&
            (identical(other.lastMessageType, lastMessageType) ||
                other.lastMessageType == lastMessageType) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            const DeepCollectionEquality().equals(
              other._unreadCounts,
              _unreadCounts,
            ) &&
            const DeepCollectionEquality().equals(other._muted, _muted) &&
            const DeepCollectionEquality().equals(
              other._lastMessageEncryptedPreviews,
              _lastMessageEncryptedPreviews,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    type,
    name,
    description,
    avatarUrl,
    ownerId,
    const DeepCollectionEquality().hash(_memberIds),
    const DeepCollectionEquality().hash(_adminIds),
    memberCount,
    totalBalance,
    status,
    settings,
    stokvelSettings,
    lastMessageText,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageType,
    lastMessageAt,
    const DeepCollectionEquality().hash(_unreadCounts),
    const DeepCollectionEquality().hash(_muted),
    const DeepCollectionEquality().hash(_lastMessageEncryptedPreviews),
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityModelImplCopyWith<_$CommunityModelImpl> get copyWith =>
      __$$CommunityModelImplCopyWithImpl<_$CommunityModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityModelImplToJson(this);
  }
}

abstract class _CommunityModel extends CommunityModel {
  const factory _CommunityModel({
    required final String id,
    required final String type,
    required final String name,
    final String? description,
    final String? avatarUrl,
    required final String ownerId,
    required final List<String> memberIds,
    required final List<String> adminIds,
    required final int memberCount,
    final int totalBalance,
    required final String status,
    required final CommunitySettingsModel settings,
    final StokvelSettingsModel? stokvelSettings,
    final String? lastMessageText,
    final String? lastMessageSenderId,
    final String? lastMessageSenderName,
    final String? lastMessageType,
    @NullableTimestampConverter() final DateTime? lastMessageAt,
    final Map<String, int> unreadCounts,
    final Map<String, bool> muted,
    final Map<String, String> lastMessageEncryptedPreviews,
    @TimestampConverter() required final DateTime createdAt,
    @NullableTimestampConverter() final DateTime? updatedAt,
  }) = _$CommunityModelImpl;
  const _CommunityModel._() : super._();

  factory _CommunityModel.fromJson(Map<String, dynamic> json) =
      _$CommunityModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get avatarUrl;
  @override
  String get ownerId;
  @override
  List<String> get memberIds;
  @override
  List<String> get adminIds;
  @override
  int get memberCount;
  @override
  int get totalBalance;
  @override
  String get status;
  @override
  CommunitySettingsModel get settings;
  @override
  StokvelSettingsModel? get stokvelSettings; // Last message preview (flat fields — mapped from nested Firestore lastMessage)
  @override
  String? get lastMessageText;
  @override
  String? get lastMessageSenderId;
  @override
  String? get lastMessageSenderName;
  @override
  String? get lastMessageType;
  @override
  @NullableTimestampConverter()
  DateTime? get lastMessageAt; // Per-user state
  @override
  Map<String, int> get unreadCounts;
  @override
  Map<String, bool> get muted; // E2EE: per-user encrypted last message previews
  @override
  Map<String, String> get lastMessageEncryptedPreviews; // Timestamps
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @NullableTimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of CommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityModelImplCopyWith<_$CommunityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
