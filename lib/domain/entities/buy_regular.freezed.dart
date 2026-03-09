// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_regular.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BuyRegular _$BuyRegularFromJson(Map<String, dynamic> json) {
  return _BuyRegular.fromJson(json);
}

/// @nodoc
mixin _$BuyRegular {
  String get id => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String get recipientNumber => throw _privateConstructorUsedError;
  String? get recipientLabel => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;
  DateTime get lastUsedAt => throw _privateConstructorUsedError;

  /// Emoji from the category for display in the dock chip
  String? get categoryEmoji => throw _privateConstructorUsedError;

  /// Purchase category mapping for routing
  String? get purchaseCategoryMapping => throw _privateConstructorUsedError;

  /// Serializes this BuyRegular to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuyRegular
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuyRegularCopyWith<BuyRegular> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyRegularCopyWith<$Res> {
  factory $BuyRegularCopyWith(
    BuyRegular value,
    $Res Function(BuyRegular) then,
  ) = _$BuyRegularCopyWithImpl<$Res, BuyRegular>;
  @useResult
  $Res call({
    String id,
    String providerId,
    String productId,
    String providerName,
    String productName,
    String recipientNumber,
    String? recipientLabel,
    bool isPinned,
    int usageCount,
    DateTime lastUsedAt,
    String? categoryEmoji,
    String? purchaseCategoryMapping,
  });
}

/// @nodoc
class _$BuyRegularCopyWithImpl<$Res, $Val extends BuyRegular>
    implements $BuyRegularCopyWith<$Res> {
  _$BuyRegularCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuyRegular
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? providerId = null,
    Object? productId = null,
    Object? providerName = null,
    Object? productName = null,
    Object? recipientNumber = null,
    Object? recipientLabel = freezed,
    Object? isPinned = null,
    Object? usageCount = null,
    Object? lastUsedAt = null,
    Object? categoryEmoji = freezed,
    Object? purchaseCategoryMapping = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            providerId: null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            providerName: null == providerName
                ? _value.providerName
                : providerName // ignore: cast_nullable_to_non_nullable
                      as String,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientNumber: null == recipientNumber
                ? _value.recipientNumber
                : recipientNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientLabel: freezed == recipientLabel
                ? _value.recipientLabel
                : recipientLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            usageCount: null == usageCount
                ? _value.usageCount
                : usageCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUsedAt: null == lastUsedAt
                ? _value.lastUsedAt
                : lastUsedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            categoryEmoji: freezed == categoryEmoji
                ? _value.categoryEmoji
                : categoryEmoji // ignore: cast_nullable_to_non_nullable
                      as String?,
            purchaseCategoryMapping: freezed == purchaseCategoryMapping
                ? _value.purchaseCategoryMapping
                : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuyRegularImplCopyWith<$Res>
    implements $BuyRegularCopyWith<$Res> {
  factory _$$BuyRegularImplCopyWith(
    _$BuyRegularImpl value,
    $Res Function(_$BuyRegularImpl) then,
  ) = __$$BuyRegularImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String providerId,
    String productId,
    String providerName,
    String productName,
    String recipientNumber,
    String? recipientLabel,
    bool isPinned,
    int usageCount,
    DateTime lastUsedAt,
    String? categoryEmoji,
    String? purchaseCategoryMapping,
  });
}

/// @nodoc
class __$$BuyRegularImplCopyWithImpl<$Res>
    extends _$BuyRegularCopyWithImpl<$Res, _$BuyRegularImpl>
    implements _$$BuyRegularImplCopyWith<$Res> {
  __$$BuyRegularImplCopyWithImpl(
    _$BuyRegularImpl _value,
    $Res Function(_$BuyRegularImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BuyRegular
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? providerId = null,
    Object? productId = null,
    Object? providerName = null,
    Object? productName = null,
    Object? recipientNumber = null,
    Object? recipientLabel = freezed,
    Object? isPinned = null,
    Object? usageCount = null,
    Object? lastUsedAt = null,
    Object? categoryEmoji = freezed,
    Object? purchaseCategoryMapping = freezed,
  }) {
    return _then(
      _$BuyRegularImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerName: null == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientNumber: null == recipientNumber
            ? _value.recipientNumber
            : recipientNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientLabel: freezed == recipientLabel
            ? _value.recipientLabel
            : recipientLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        usageCount: null == usageCount
            ? _value.usageCount
            : usageCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUsedAt: null == lastUsedAt
            ? _value.lastUsedAt
            : lastUsedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        categoryEmoji: freezed == categoryEmoji
            ? _value.categoryEmoji
            : categoryEmoji // ignore: cast_nullable_to_non_nullable
                  as String?,
        purchaseCategoryMapping: freezed == purchaseCategoryMapping
            ? _value.purchaseCategoryMapping
            : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BuyRegularImpl extends _BuyRegular {
  const _$BuyRegularImpl({
    required this.id,
    required this.providerId,
    required this.productId,
    required this.providerName,
    required this.productName,
    required this.recipientNumber,
    this.recipientLabel,
    this.isPinned = false,
    this.usageCount = 0,
    required this.lastUsedAt,
    this.categoryEmoji,
    this.purchaseCategoryMapping,
  }) : super._();

  factory _$BuyRegularImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuyRegularImplFromJson(json);

  @override
  final String id;
  @override
  final String providerId;
  @override
  final String productId;
  @override
  final String providerName;
  @override
  final String productName;
  @override
  final String recipientNumber;
  @override
  final String? recipientLabel;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final int usageCount;
  @override
  final DateTime lastUsedAt;

  /// Emoji from the category for display in the dock chip
  @override
  final String? categoryEmoji;

  /// Purchase category mapping for routing
  @override
  final String? purchaseCategoryMapping;

  @override
  String toString() {
    return 'BuyRegular(id: $id, providerId: $providerId, productId: $productId, providerName: $providerName, productName: $productName, recipientNumber: $recipientNumber, recipientLabel: $recipientLabel, isPinned: $isPinned, usageCount: $usageCount, lastUsedAt: $lastUsedAt, categoryEmoji: $categoryEmoji, purchaseCategoryMapping: $purchaseCategoryMapping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyRegularImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.recipientNumber, recipientNumber) ||
                other.recipientNumber == recipientNumber) &&
            (identical(other.recipientLabel, recipientLabel) ||
                other.recipientLabel == recipientLabel) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.categoryEmoji, categoryEmoji) ||
                other.categoryEmoji == categoryEmoji) &&
            (identical(
                  other.purchaseCategoryMapping,
                  purchaseCategoryMapping,
                ) ||
                other.purchaseCategoryMapping == purchaseCategoryMapping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    providerId,
    productId,
    providerName,
    productName,
    recipientNumber,
    recipientLabel,
    isPinned,
    usageCount,
    lastUsedAt,
    categoryEmoji,
    purchaseCategoryMapping,
  );

  /// Create a copy of BuyRegular
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyRegularImplCopyWith<_$BuyRegularImpl> get copyWith =>
      __$$BuyRegularImplCopyWithImpl<_$BuyRegularImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuyRegularImplToJson(this);
  }
}

abstract class _BuyRegular extends BuyRegular {
  const factory _BuyRegular({
    required final String id,
    required final String providerId,
    required final String productId,
    required final String providerName,
    required final String productName,
    required final String recipientNumber,
    final String? recipientLabel,
    final bool isPinned,
    final int usageCount,
    required final DateTime lastUsedAt,
    final String? categoryEmoji,
    final String? purchaseCategoryMapping,
  }) = _$BuyRegularImpl;
  const _BuyRegular._() : super._();

  factory _BuyRegular.fromJson(Map<String, dynamic> json) =
      _$BuyRegularImpl.fromJson;

  @override
  String get id;
  @override
  String get providerId;
  @override
  String get productId;
  @override
  String get providerName;
  @override
  String get productName;
  @override
  String get recipientNumber;
  @override
  String? get recipientLabel;
  @override
  bool get isPinned;
  @override
  int get usageCount;
  @override
  DateTime get lastUsedAt;

  /// Emoji from the category for display in the dock chip
  @override
  String? get categoryEmoji;

  /// Purchase category mapping for routing
  @override
  String? get purchaseCategoryMapping;

  /// Create a copy of BuyRegular
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyRegularImplCopyWith<_$BuyRegularImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
