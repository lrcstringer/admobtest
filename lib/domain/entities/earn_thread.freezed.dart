// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EarnThread _$EarnThreadFromJson(Map<String, dynamic> json) {
  return _EarnThread.fromJson(json);
}

/// @nodoc
mixin _$EarnThread {
  String get id =>
      throw _privateConstructorUsedError; // Client fields (renamed from brand)
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String? get clientAvatarImage => throw _privateConstructorUsedError;
  String? get clientAvatarColor =>
      throw _privateConstructorUsedError; // Thread display
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError; // Flags
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get budgetExhausted => throw _privateConstructorUsedError; // Scheduling
  DateTime? get activeFrom => throw _privateConstructorUsedError;
  DateTime? get activeTo =>
      throw _privateConstructorUsedError; // Token configuration
  String? get tokenSourceSubAccountId => throw _privateConstructorUsedError;
  String? get tokenDestAccountTypeId =>
      throw _privateConstructorUsedError; // Counts
  int get availableOpportunities => throw _privateConstructorUsedError;
  int get completedOpportunities => throw _privateConstructorUsedError;
  int get completedUniqueUsers =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt =>
      throw _privateConstructorUsedError; // Targeting
  TargetingCriteria? get targeting => throw _privateConstructorUsedError;

  /// Serializes this EarnThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnThreadCopyWith<EarnThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnThreadCopyWith<$Res> {
  factory $EarnThreadCopyWith(
    EarnThread value,
    $Res Function(EarnThread) then,
  ) = _$EarnThreadCopyWithImpl<$Res, EarnThread>;
  @useResult
  $Res call({
    String id,
    String clientId,
    String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String title,
    String? description,
    bool isPinned,
    bool isFeatured,
    bool isActive,
    bool budgetExhausted,
    DateTime? activeFrom,
    DateTime? activeTo,
    String? tokenSourceSubAccountId,
    String? tokenDestAccountTypeId,
    int availableOpportunities,
    int completedOpportunities,
    int completedUniqueUsers,
    DateTime createdAt,
    DateTime? lastActivityAt,
    TargetingCriteria? targeting,
  });

  $TargetingCriteriaCopyWith<$Res>? get targeting;
}

/// @nodoc
class _$EarnThreadCopyWithImpl<$Res, $Val extends EarnThread>
    implements $EarnThreadCopyWith<$Res> {
  _$EarnThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? isActive = null,
    Object? budgetExhausted = null,
    Object? activeFrom = freezed,
    Object? activeTo = freezed,
    Object? tokenSourceSubAccountId = freezed,
    Object? tokenDestAccountTypeId = freezed,
    Object? availableOpportunities = null,
    Object? completedOpportunities = null,
    Object? completedUniqueUsers = null,
    Object? createdAt = null,
    Object? lastActivityAt = freezed,
    Object? targeting = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            clientName: null == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String,
            clientAvatarImage: freezed == clientAvatarImage
                ? _value.clientAvatarImage
                : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientAvatarColor: freezed == clientAvatarColor
                ? _value.clientAvatarColor
                : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            budgetExhausted: null == budgetExhausted
                ? _value.budgetExhausted
                : budgetExhausted // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeFrom: freezed == activeFrom
                ? _value.activeFrom
                : activeFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            activeTo: freezed == activeTo
                ? _value.activeTo
                : activeTo // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            tokenSourceSubAccountId: freezed == tokenSourceSubAccountId
                ? _value.tokenSourceSubAccountId
                : tokenSourceSubAccountId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokenDestAccountTypeId: freezed == tokenDestAccountTypeId
                ? _value.tokenDestAccountTypeId
                : tokenDestAccountTypeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            availableOpportunities: null == availableOpportunities
                ? _value.availableOpportunities
                : availableOpportunities // ignore: cast_nullable_to_non_nullable
                      as int,
            completedOpportunities: null == completedOpportunities
                ? _value.completedOpportunities
                : completedOpportunities // ignore: cast_nullable_to_non_nullable
                      as int,
            completedUniqueUsers: null == completedUniqueUsers
                ? _value.completedUniqueUsers
                : completedUniqueUsers // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastActivityAt: freezed == lastActivityAt
                ? _value.lastActivityAt
                : lastActivityAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            targeting: freezed == targeting
                ? _value.targeting
                : targeting // ignore: cast_nullable_to_non_nullable
                      as TargetingCriteria?,
          )
          as $Val,
    );
  }

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TargetingCriteriaCopyWith<$Res>? get targeting {
    if (_value.targeting == null) {
      return null;
    }

    return $TargetingCriteriaCopyWith<$Res>(_value.targeting!, (value) {
      return _then(_value.copyWith(targeting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarnThreadImplCopyWith<$Res>
    implements $EarnThreadCopyWith<$Res> {
  factory _$$EarnThreadImplCopyWith(
    _$EarnThreadImpl value,
    $Res Function(_$EarnThreadImpl) then,
  ) = __$$EarnThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clientId,
    String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String title,
    String? description,
    bool isPinned,
    bool isFeatured,
    bool isActive,
    bool budgetExhausted,
    DateTime? activeFrom,
    DateTime? activeTo,
    String? tokenSourceSubAccountId,
    String? tokenDestAccountTypeId,
    int availableOpportunities,
    int completedOpportunities,
    int completedUniqueUsers,
    DateTime createdAt,
    DateTime? lastActivityAt,
    TargetingCriteria? targeting,
  });

  @override
  $TargetingCriteriaCopyWith<$Res>? get targeting;
}

/// @nodoc
class __$$EarnThreadImplCopyWithImpl<$Res>
    extends _$EarnThreadCopyWithImpl<$Res, _$EarnThreadImpl>
    implements _$$EarnThreadImplCopyWith<$Res> {
  __$$EarnThreadImplCopyWithImpl(
    _$EarnThreadImpl _value,
    $Res Function(_$EarnThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? isActive = null,
    Object? budgetExhausted = null,
    Object? activeFrom = freezed,
    Object? activeTo = freezed,
    Object? tokenSourceSubAccountId = freezed,
    Object? tokenDestAccountTypeId = freezed,
    Object? availableOpportunities = null,
    Object? completedOpportunities = null,
    Object? completedUniqueUsers = null,
    Object? createdAt = null,
    Object? lastActivityAt = freezed,
    Object? targeting = freezed,
  }) {
    return _then(
      _$EarnThreadImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        clientName: null == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String,
        clientAvatarImage: freezed == clientAvatarImage
            ? _value.clientAvatarImage
            : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientAvatarColor: freezed == clientAvatarColor
            ? _value.clientAvatarColor
            : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        budgetExhausted: null == budgetExhausted
            ? _value.budgetExhausted
            : budgetExhausted // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeFrom: freezed == activeFrom
            ? _value.activeFrom
            : activeFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        activeTo: freezed == activeTo
            ? _value.activeTo
            : activeTo // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        tokenSourceSubAccountId: freezed == tokenSourceSubAccountId
            ? _value.tokenSourceSubAccountId
            : tokenSourceSubAccountId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenDestAccountTypeId: freezed == tokenDestAccountTypeId
            ? _value.tokenDestAccountTypeId
            : tokenDestAccountTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        availableOpportunities: null == availableOpportunities
            ? _value.availableOpportunities
            : availableOpportunities // ignore: cast_nullable_to_non_nullable
                  as int,
        completedOpportunities: null == completedOpportunities
            ? _value.completedOpportunities
            : completedOpportunities // ignore: cast_nullable_to_non_nullable
                  as int,
        completedUniqueUsers: null == completedUniqueUsers
            ? _value.completedUniqueUsers
            : completedUniqueUsers // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastActivityAt: freezed == lastActivityAt
            ? _value.lastActivityAt
            : lastActivityAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        targeting: freezed == targeting
            ? _value.targeting
            : targeting // ignore: cast_nullable_to_non_nullable
                  as TargetingCriteria?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarnThreadImpl extends _EarnThread {
  const _$EarnThreadImpl({
    required this.id,
    required this.clientId,
    required this.clientName,
    this.clientAvatarImage,
    this.clientAvatarColor,
    required this.title,
    this.description,
    required this.isPinned,
    required this.isFeatured,
    required this.isActive,
    this.budgetExhausted = false,
    this.activeFrom,
    this.activeTo,
    this.tokenSourceSubAccountId,
    this.tokenDestAccountTypeId,
    required this.availableOpportunities,
    required this.completedOpportunities,
    this.completedUniqueUsers = 0,
    required this.createdAt,
    this.lastActivityAt,
    this.targeting,
  }) : super._();

  factory _$EarnThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarnThreadImplFromJson(json);

  @override
  final String id;
  // Client fields (renamed from brand)
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String? clientAvatarImage;
  @override
  final String? clientAvatarColor;
  // Thread display
  @override
  final String title;
  @override
  final String? description;
  // Flags
  @override
  final bool isPinned;
  @override
  final bool isFeatured;
  @override
  final bool isActive;
  @override
  @JsonKey()
  final bool budgetExhausted;
  // Scheduling
  @override
  final DateTime? activeFrom;
  @override
  final DateTime? activeTo;
  // Token configuration
  @override
  final String? tokenSourceSubAccountId;
  @override
  final String? tokenDestAccountTypeId;
  // Counts
  @override
  final int availableOpportunities;
  @override
  final int completedOpportunities;
  @override
  @JsonKey()
  final int completedUniqueUsers;
  // Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastActivityAt;
  // Targeting
  @override
  final TargetingCriteria? targeting;

  @override
  String toString() {
    return 'EarnThread(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, title: $title, description: $description, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, budgetExhausted: $budgetExhausted, activeFrom: $activeFrom, activeTo: $activeTo, tokenSourceSubAccountId: $tokenSourceSubAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, completedUniqueUsers: $completedUniqueUsers, createdAt: $createdAt, lastActivityAt: $lastActivityAt, targeting: $targeting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAvatarImage, clientAvatarImage) ||
                other.clientAvatarImage == clientAvatarImage) &&
            (identical(other.clientAvatarColor, clientAvatarColor) ||
                other.clientAvatarColor == clientAvatarColor) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.budgetExhausted, budgetExhausted) ||
                other.budgetExhausted == budgetExhausted) &&
            (identical(other.activeFrom, activeFrom) ||
                other.activeFrom == activeFrom) &&
            (identical(other.activeTo, activeTo) ||
                other.activeTo == activeTo) &&
            (identical(
                  other.tokenSourceSubAccountId,
                  tokenSourceSubAccountId,
                ) ||
                other.tokenSourceSubAccountId == tokenSourceSubAccountId) &&
            (identical(other.tokenDestAccountTypeId, tokenDestAccountTypeId) ||
                other.tokenDestAccountTypeId == tokenDestAccountTypeId) &&
            (identical(other.availableOpportunities, availableOpportunities) ||
                other.availableOpportunities == availableOpportunities) &&
            (identical(other.completedOpportunities, completedOpportunities) ||
                other.completedOpportunities == completedOpportunities) &&
            (identical(other.completedUniqueUsers, completedUniqueUsers) ||
                other.completedUniqueUsers == completedUniqueUsers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt) &&
            (identical(other.targeting, targeting) ||
                other.targeting == targeting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    clientId,
    clientName,
    clientAvatarImage,
    clientAvatarColor,
    title,
    description,
    isPinned,
    isFeatured,
    isActive,
    budgetExhausted,
    activeFrom,
    activeTo,
    tokenSourceSubAccountId,
    tokenDestAccountTypeId,
    availableOpportunities,
    completedOpportunities,
    completedUniqueUsers,
    createdAt,
    lastActivityAt,
    targeting,
  ]);

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnThreadImplCopyWith<_$EarnThreadImpl> get copyWith =>
      __$$EarnThreadImplCopyWithImpl<_$EarnThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarnThreadImplToJson(this);
  }
}

abstract class _EarnThread extends EarnThread {
  const factory _EarnThread({
    required final String id,
    required final String clientId,
    required final String clientName,
    final String? clientAvatarImage,
    final String? clientAvatarColor,
    required final String title,
    final String? description,
    required final bool isPinned,
    required final bool isFeatured,
    required final bool isActive,
    final bool budgetExhausted,
    final DateTime? activeFrom,
    final DateTime? activeTo,
    final String? tokenSourceSubAccountId,
    final String? tokenDestAccountTypeId,
    required final int availableOpportunities,
    required final int completedOpportunities,
    final int completedUniqueUsers,
    required final DateTime createdAt,
    final DateTime? lastActivityAt,
    final TargetingCriteria? targeting,
  }) = _$EarnThreadImpl;
  const _EarnThread._() : super._();

  factory _EarnThread.fromJson(Map<String, dynamic> json) =
      _$EarnThreadImpl.fromJson;

  @override
  String get id; // Client fields (renamed from brand)
  @override
  String get clientId;
  @override
  String get clientName;
  @override
  String? get clientAvatarImage;
  @override
  String? get clientAvatarColor; // Thread display
  @override
  String get title;
  @override
  String? get description; // Flags
  @override
  bool get isPinned;
  @override
  bool get isFeatured;
  @override
  bool get isActive;
  @override
  bool get budgetExhausted; // Scheduling
  @override
  DateTime? get activeFrom;
  @override
  DateTime? get activeTo; // Token configuration
  @override
  String? get tokenSourceSubAccountId;
  @override
  String? get tokenDestAccountTypeId; // Counts
  @override
  int get availableOpportunities;
  @override
  int get completedOpportunities;
  @override
  int get completedUniqueUsers; // Timestamps
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastActivityAt; // Targeting
  @override
  TargetingCriteria? get targeting;

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnThreadImplCopyWith<_$EarnThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
