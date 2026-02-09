// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_thread_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EarnThreadModel {
  String get id => throw _privateConstructorUsedError; // Client fields
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String? get clientAvatarImage => throw _privateConstructorUsedError;
  String? get clientAvatarColor => throw _privateConstructorUsedError;
  String? get threadImage =>
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
      throw _privateConstructorUsedError; // Targeting (stored as JSON map)
  Map<String, dynamic>? get targeting => throw _privateConstructorUsedError;

  /// Create a copy of EarnThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnThreadModelCopyWith<EarnThreadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnThreadModelCopyWith<$Res> {
  factory $EarnThreadModelCopyWith(
    EarnThreadModel value,
    $Res Function(EarnThreadModel) then,
  ) = _$EarnThreadModelCopyWithImpl<$Res, EarnThreadModel>;
  @useResult
  $Res call({
    String id,
    String clientId,
    String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String? threadImage,
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
    Map<String, dynamic>? targeting,
  });
}

/// @nodoc
class _$EarnThreadModelCopyWithImpl<$Res, $Val extends EarnThreadModel>
    implements $EarnThreadModelCopyWith<$Res> {
  _$EarnThreadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? threadImage = freezed,
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
            threadImage: freezed == threadImage
                ? _value.threadImage
                : threadImage // ignore: cast_nullable_to_non_nullable
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
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarnThreadModelImplCopyWith<$Res>
    implements $EarnThreadModelCopyWith<$Res> {
  factory _$$EarnThreadModelImplCopyWith(
    _$EarnThreadModelImpl value,
    $Res Function(_$EarnThreadModelImpl) then,
  ) = __$$EarnThreadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clientId,
    String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String? threadImage,
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
    Map<String, dynamic>? targeting,
  });
}

/// @nodoc
class __$$EarnThreadModelImplCopyWithImpl<$Res>
    extends _$EarnThreadModelCopyWithImpl<$Res, _$EarnThreadModelImpl>
    implements _$$EarnThreadModelImplCopyWith<$Res> {
  __$$EarnThreadModelImplCopyWithImpl(
    _$EarnThreadModelImpl _value,
    $Res Function(_$EarnThreadModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? threadImage = freezed,
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
      _$EarnThreadModelImpl(
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
        threadImage: freezed == threadImage
            ? _value.threadImage
            : threadImage // ignore: cast_nullable_to_non_nullable
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
            ? _value._targeting
            : targeting // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$EarnThreadModelImpl extends _EarnThreadModel {
  const _$EarnThreadModelImpl({
    required this.id,
    required this.clientId,
    required this.clientName,
    this.clientAvatarImage,
    this.clientAvatarColor,
    this.threadImage,
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
    final Map<String, dynamic>? targeting,
  }) : _targeting = targeting,
       super._();

  @override
  final String id;
  // Client fields
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String? clientAvatarImage;
  @override
  final String? clientAvatarColor;
  @override
  final String? threadImage;
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
  // Targeting (stored as JSON map)
  final Map<String, dynamic>? _targeting;
  // Targeting (stored as JSON map)
  @override
  Map<String, dynamic>? get targeting {
    final value = _targeting;
    if (value == null) return null;
    if (_targeting is EqualUnmodifiableMapView) return _targeting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EarnThreadModel(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, threadImage: $threadImage, title: $title, description: $description, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, budgetExhausted: $budgetExhausted, activeFrom: $activeFrom, activeTo: $activeTo, tokenSourceSubAccountId: $tokenSourceSubAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, completedUniqueUsers: $completedUniqueUsers, createdAt: $createdAt, lastActivityAt: $lastActivityAt, targeting: $targeting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnThreadModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAvatarImage, clientAvatarImage) ||
                other.clientAvatarImage == clientAvatarImage) &&
            (identical(other.clientAvatarColor, clientAvatarColor) ||
                other.clientAvatarColor == clientAvatarColor) &&
            (identical(other.threadImage, threadImage) ||
                other.threadImage == threadImage) &&
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
            const DeepCollectionEquality().equals(
              other._targeting,
              _targeting,
            ));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    clientId,
    clientName,
    clientAvatarImage,
    clientAvatarColor,
    threadImage,
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
    const DeepCollectionEquality().hash(_targeting),
  ]);

  /// Create a copy of EarnThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnThreadModelImplCopyWith<_$EarnThreadModelImpl> get copyWith =>
      __$$EarnThreadModelImplCopyWithImpl<_$EarnThreadModelImpl>(
        this,
        _$identity,
      );
}

abstract class _EarnThreadModel extends EarnThreadModel {
  const factory _EarnThreadModel({
    required final String id,
    required final String clientId,
    required final String clientName,
    final String? clientAvatarImage,
    final String? clientAvatarColor,
    final String? threadImage,
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
    final Map<String, dynamic>? targeting,
  }) = _$EarnThreadModelImpl;
  const _EarnThreadModel._() : super._();

  @override
  String get id; // Client fields
  @override
  String get clientId;
  @override
  String get clientName;
  @override
  String? get clientAvatarImage;
  @override
  String? get clientAvatarColor;
  @override
  String? get threadImage; // Thread display
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
  DateTime? get lastActivityAt; // Targeting (stored as JSON map)
  @override
  Map<String, dynamic>? get targeting;

  /// Create a copy of EarnThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnThreadModelImplCopyWith<_$EarnThreadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
