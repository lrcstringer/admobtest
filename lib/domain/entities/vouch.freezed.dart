// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vouch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vouch _$VouchFromJson(Map<String, dynamic> json) {
  return _Vouch.fromJson(json);
}

/// @nodoc
mixin _$Vouch {
  String get id => throw _privateConstructorUsedError;
  String get voucherId => throw _privateConstructorUsedError;
  String get voucherName => throw _privateConstructorUsedError;
  String? get voucherPhotoUrl => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Vouch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vouch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VouchCopyWith<Vouch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VouchCopyWith<$Res> {
  factory $VouchCopyWith(Vouch value, $Res Function(Vouch) then) =
      _$VouchCopyWithImpl<$Res, Vouch>;
  @useResult
  $Res call({
    String id,
    String voucherId,
    String voucherName,
    String? voucherPhotoUrl,
    String providerId,
    String? orderId,
    int rating,
    String? comment,
    DateTime createdAt,
  });
}

/// @nodoc
class _$VouchCopyWithImpl<$Res, $Val extends Vouch>
    implements $VouchCopyWith<$Res> {
  _$VouchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vouch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? voucherId = null,
    Object? voucherName = null,
    Object? voucherPhotoUrl = freezed,
    Object? providerId = null,
    Object? orderId = freezed,
    Object? rating = null,
    Object? comment = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            voucherId: null == voucherId
                ? _value.voucherId
                : voucherId // ignore: cast_nullable_to_non_nullable
                      as String,
            voucherName: null == voucherName
                ? _value.voucherName
                : voucherName // ignore: cast_nullable_to_non_nullable
                      as String,
            voucherPhotoUrl: freezed == voucherPhotoUrl
                ? _value.voucherPhotoUrl
                : voucherPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerId: null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderId: freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VouchImplCopyWith<$Res> implements $VouchCopyWith<$Res> {
  factory _$$VouchImplCopyWith(
    _$VouchImpl value,
    $Res Function(_$VouchImpl) then,
  ) = __$$VouchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String voucherId,
    String voucherName,
    String? voucherPhotoUrl,
    String providerId,
    String? orderId,
    int rating,
    String? comment,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$VouchImplCopyWithImpl<$Res>
    extends _$VouchCopyWithImpl<$Res, _$VouchImpl>
    implements _$$VouchImplCopyWith<$Res> {
  __$$VouchImplCopyWithImpl(
    _$VouchImpl _value,
    $Res Function(_$VouchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vouch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? voucherId = null,
    Object? voucherName = null,
    Object? voucherPhotoUrl = freezed,
    Object? providerId = null,
    Object? orderId = freezed,
    Object? rating = null,
    Object? comment = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$VouchImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        voucherId: null == voucherId
            ? _value.voucherId
            : voucherId // ignore: cast_nullable_to_non_nullable
                  as String,
        voucherName: null == voucherName
            ? _value.voucherName
            : voucherName // ignore: cast_nullable_to_non_nullable
                  as String,
        voucherPhotoUrl: freezed == voucherPhotoUrl
            ? _value.voucherPhotoUrl
            : voucherPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: freezed == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VouchImpl extends _Vouch {
  const _$VouchImpl({
    required this.id,
    required this.voucherId,
    required this.voucherName,
    this.voucherPhotoUrl,
    required this.providerId,
    this.orderId,
    required this.rating,
    this.comment,
    required this.createdAt,
  }) : super._();

  factory _$VouchImpl.fromJson(Map<String, dynamic> json) =>
      _$$VouchImplFromJson(json);

  @override
  final String id;
  @override
  final String voucherId;
  @override
  final String voucherName;
  @override
  final String? voucherPhotoUrl;
  @override
  final String providerId;
  @override
  final String? orderId;
  @override
  final int rating;
  @override
  final String? comment;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Vouch(id: $id, voucherId: $voucherId, voucherName: $voucherName, voucherPhotoUrl: $voucherPhotoUrl, providerId: $providerId, orderId: $orderId, rating: $rating, comment: $comment, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VouchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.voucherId, voucherId) ||
                other.voucherId == voucherId) &&
            (identical(other.voucherName, voucherName) ||
                other.voucherName == voucherName) &&
            (identical(other.voucherPhotoUrl, voucherPhotoUrl) ||
                other.voucherPhotoUrl == voucherPhotoUrl) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    voucherId,
    voucherName,
    voucherPhotoUrl,
    providerId,
    orderId,
    rating,
    comment,
    createdAt,
  );

  /// Create a copy of Vouch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VouchImplCopyWith<_$VouchImpl> get copyWith =>
      __$$VouchImplCopyWithImpl<_$VouchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VouchImplToJson(this);
  }
}

abstract class _Vouch extends Vouch {
  const factory _Vouch({
    required final String id,
    required final String voucherId,
    required final String voucherName,
    final String? voucherPhotoUrl,
    required final String providerId,
    final String? orderId,
    required final int rating,
    final String? comment,
    required final DateTime createdAt,
  }) = _$VouchImpl;
  const _Vouch._() : super._();

  factory _Vouch.fromJson(Map<String, dynamic> json) = _$VouchImpl.fromJson;

  @override
  String get id;
  @override
  String get voucherId;
  @override
  String get voucherName;
  @override
  String? get voucherPhotoUrl;
  @override
  String get providerId;
  @override
  String? get orderId;
  @override
  int get rating;
  @override
  String? get comment;
  @override
  DateTime get createdAt;

  /// Create a copy of Vouch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VouchImplCopyWith<_$VouchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
