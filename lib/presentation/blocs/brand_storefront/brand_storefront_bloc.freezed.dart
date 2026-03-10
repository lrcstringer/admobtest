// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BrandStorefrontEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
    required TResult Function(String brandId) loadProducts,
    required TResult Function(String brandId) loadReviews,
    required TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )
    submitReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
    TResult? Function(String brandId)? loadProducts,
    TResult? Function(String brandId)? loadReviews,
    TResult? Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    TResult Function(String brandId)? loadProducts,
    TResult Function(String brandId)? loadReviews,
    TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadReviews value) loadReviews,
    required TResult Function(_SubmitReview value) submitReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadReviews value)? loadReviews,
    TResult? Function(_SubmitReview value)? submitReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadReviews value)? loadReviews,
    TResult Function(_SubmitReview value)? submitReview,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStorefrontEventCopyWith<$Res> {
  factory $BrandStorefrontEventCopyWith(
    BrandStorefrontEvent value,
    $Res Function(BrandStorefrontEvent) then,
  ) = _$BrandStorefrontEventCopyWithImpl<$Res, BrandStorefrontEvent>;
}

/// @nodoc
class _$BrandStorefrontEventCopyWithImpl<
  $Res,
  $Val extends BrandStorefrontEvent
>
    implements $BrandStorefrontEventCopyWith<$Res> {
  _$BrandStorefrontEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadStorefrontImplCopyWith<$Res> {
  factory _$$LoadStorefrontImplCopyWith(
    _$LoadStorefrontImpl value,
    $Res Function(_$LoadStorefrontImpl) then,
  ) = __$$LoadStorefrontImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$LoadStorefrontImplCopyWithImpl<$Res>
    extends _$BrandStorefrontEventCopyWithImpl<$Res, _$LoadStorefrontImpl>
    implements _$$LoadStorefrontImplCopyWith<$Res> {
  __$$LoadStorefrontImplCopyWithImpl(
    _$LoadStorefrontImpl _value,
    $Res Function(_$LoadStorefrontImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$LoadStorefrontImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadStorefrontImpl implements _LoadStorefront {
  const _$LoadStorefrontImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'BrandStorefrontEvent.loadStorefront(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadStorefrontImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadStorefrontImplCopyWith<_$LoadStorefrontImpl> get copyWith =>
      __$$LoadStorefrontImplCopyWithImpl<_$LoadStorefrontImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
    required TResult Function(String brandId) loadProducts,
    required TResult Function(String brandId) loadReviews,
    required TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )
    submitReview,
  }) {
    return loadStorefront(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
    TResult? Function(String brandId)? loadProducts,
    TResult? Function(String brandId)? loadReviews,
    TResult? Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
  }) {
    return loadStorefront?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    TResult Function(String brandId)? loadProducts,
    TResult Function(String brandId)? loadReviews,
    TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
    required TResult orElse(),
  }) {
    if (loadStorefront != null) {
      return loadStorefront(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadReviews value) loadReviews,
    required TResult Function(_SubmitReview value) submitReview,
  }) {
    return loadStorefront(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadReviews value)? loadReviews,
    TResult? Function(_SubmitReview value)? submitReview,
  }) {
    return loadStorefront?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadReviews value)? loadReviews,
    TResult Function(_SubmitReview value)? submitReview,
    required TResult orElse(),
  }) {
    if (loadStorefront != null) {
      return loadStorefront(this);
    }
    return orElse();
  }
}

abstract class _LoadStorefront implements BrandStorefrontEvent {
  const factory _LoadStorefront(final String id) = _$LoadStorefrontImpl;

  String get id;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadStorefrontImplCopyWith<_$LoadStorefrontImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadProductsImplCopyWith<$Res> {
  factory _$$LoadProductsImplCopyWith(
    _$LoadProductsImpl value,
    $Res Function(_$LoadProductsImpl) then,
  ) = __$$LoadProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String brandId});
}

/// @nodoc
class __$$LoadProductsImplCopyWithImpl<$Res>
    extends _$BrandStorefrontEventCopyWithImpl<$Res, _$LoadProductsImpl>
    implements _$$LoadProductsImplCopyWith<$Res> {
  __$$LoadProductsImplCopyWithImpl(
    _$LoadProductsImpl _value,
    $Res Function(_$LoadProductsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? brandId = null}) {
    return _then(
      _$LoadProductsImpl(
        null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadProductsImpl implements _LoadProducts {
  const _$LoadProductsImpl(this.brandId);

  @override
  final String brandId;

  @override
  String toString() {
    return 'BrandStorefrontEvent.loadProducts(brandId: $brandId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProductsImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brandId);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      __$$LoadProductsImplCopyWithImpl<_$LoadProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
    required TResult Function(String brandId) loadProducts,
    required TResult Function(String brandId) loadReviews,
    required TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )
    submitReview,
  }) {
    return loadProducts(brandId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
    TResult? Function(String brandId)? loadProducts,
    TResult? Function(String brandId)? loadReviews,
    TResult? Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
  }) {
    return loadProducts?.call(brandId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    TResult Function(String brandId)? loadProducts,
    TResult Function(String brandId)? loadReviews,
    TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(brandId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadReviews value) loadReviews,
    required TResult Function(_SubmitReview value) submitReview,
  }) {
    return loadProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadReviews value)? loadReviews,
    TResult? Function(_SubmitReview value)? submitReview,
  }) {
    return loadProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadReviews value)? loadReviews,
    TResult Function(_SubmitReview value)? submitReview,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadProducts implements BrandStorefrontEvent {
  const factory _LoadProducts(final String brandId) = _$LoadProductsImpl;

  String get brandId;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadReviewsImplCopyWith<$Res> {
  factory _$$LoadReviewsImplCopyWith(
    _$LoadReviewsImpl value,
    $Res Function(_$LoadReviewsImpl) then,
  ) = __$$LoadReviewsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String brandId});
}

/// @nodoc
class __$$LoadReviewsImplCopyWithImpl<$Res>
    extends _$BrandStorefrontEventCopyWithImpl<$Res, _$LoadReviewsImpl>
    implements _$$LoadReviewsImplCopyWith<$Res> {
  __$$LoadReviewsImplCopyWithImpl(
    _$LoadReviewsImpl _value,
    $Res Function(_$LoadReviewsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? brandId = null}) {
    return _then(
      _$LoadReviewsImpl(
        null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadReviewsImpl implements _LoadReviews {
  const _$LoadReviewsImpl(this.brandId);

  @override
  final String brandId;

  @override
  String toString() {
    return 'BrandStorefrontEvent.loadReviews(brandId: $brandId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadReviewsImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brandId);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadReviewsImplCopyWith<_$LoadReviewsImpl> get copyWith =>
      __$$LoadReviewsImplCopyWithImpl<_$LoadReviewsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
    required TResult Function(String brandId) loadProducts,
    required TResult Function(String brandId) loadReviews,
    required TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )
    submitReview,
  }) {
    return loadReviews(brandId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
    TResult? Function(String brandId)? loadProducts,
    TResult? Function(String brandId)? loadReviews,
    TResult? Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
  }) {
    return loadReviews?.call(brandId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    TResult Function(String brandId)? loadProducts,
    TResult Function(String brandId)? loadReviews,
    TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
    required TResult orElse(),
  }) {
    if (loadReviews != null) {
      return loadReviews(brandId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadReviews value) loadReviews,
    required TResult Function(_SubmitReview value) submitReview,
  }) {
    return loadReviews(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadReviews value)? loadReviews,
    TResult? Function(_SubmitReview value)? submitReview,
  }) {
    return loadReviews?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadReviews value)? loadReviews,
    TResult Function(_SubmitReview value)? submitReview,
    required TResult orElse(),
  }) {
    if (loadReviews != null) {
      return loadReviews(this);
    }
    return orElse();
  }
}

abstract class _LoadReviews implements BrandStorefrontEvent {
  const factory _LoadReviews(final String brandId) = _$LoadReviewsImpl;

  String get brandId;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadReviewsImplCopyWith<_$LoadReviewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitReviewImplCopyWith<$Res> {
  factory _$$SubmitReviewImplCopyWith(
    _$SubmitReviewImpl value,
    $Res Function(_$SubmitReviewImpl) then,
  ) = __$$SubmitReviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String brandId,
    int qualityRating,
    int valueRating,
    int serviceRating,
    String? comment,
  });
}

/// @nodoc
class __$$SubmitReviewImplCopyWithImpl<$Res>
    extends _$BrandStorefrontEventCopyWithImpl<$Res, _$SubmitReviewImpl>
    implements _$$SubmitReviewImplCopyWith<$Res> {
  __$$SubmitReviewImplCopyWithImpl(
    _$SubmitReviewImpl _value,
    $Res Function(_$SubmitReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? qualityRating = null,
    Object? valueRating = null,
    Object? serviceRating = null,
    Object? comment = freezed,
  }) {
    return _then(
      _$SubmitReviewImpl(
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        qualityRating: null == qualityRating
            ? _value.qualityRating
            : qualityRating // ignore: cast_nullable_to_non_nullable
                  as int,
        valueRating: null == valueRating
            ? _value.valueRating
            : valueRating // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceRating: null == serviceRating
            ? _value.serviceRating
            : serviceRating // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SubmitReviewImpl implements _SubmitReview {
  const _$SubmitReviewImpl({
    required this.brandId,
    required this.qualityRating,
    required this.valueRating,
    required this.serviceRating,
    this.comment,
  });

  @override
  final String brandId;
  @override
  final int qualityRating;
  @override
  final int valueRating;
  @override
  final int serviceRating;
  @override
  final String? comment;

  @override
  String toString() {
    return 'BrandStorefrontEvent.submitReview(brandId: $brandId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitReviewImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.valueRating, valueRating) ||
                other.valueRating == valueRating) &&
            (identical(other.serviceRating, serviceRating) ||
                other.serviceRating == serviceRating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    brandId,
    qualityRating,
    valueRating,
    serviceRating,
    comment,
  );

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitReviewImplCopyWith<_$SubmitReviewImpl> get copyWith =>
      __$$SubmitReviewImplCopyWithImpl<_$SubmitReviewImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
    required TResult Function(String brandId) loadProducts,
    required TResult Function(String brandId) loadReviews,
    required TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )
    submitReview,
  }) {
    return submitReview(
      brandId,
      qualityRating,
      valueRating,
      serviceRating,
      comment,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
    TResult? Function(String brandId)? loadProducts,
    TResult? Function(String brandId)? loadReviews,
    TResult? Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
  }) {
    return submitReview?.call(
      brandId,
      qualityRating,
      valueRating,
      serviceRating,
      comment,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    TResult Function(String brandId)? loadProducts,
    TResult Function(String brandId)? loadReviews,
    TResult Function(
      String brandId,
      int qualityRating,
      int valueRating,
      int serviceRating,
      String? comment,
    )?
    submitReview,
    required TResult orElse(),
  }) {
    if (submitReview != null) {
      return submitReview(
        brandId,
        qualityRating,
        valueRating,
        serviceRating,
        comment,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadReviews value) loadReviews,
    required TResult Function(_SubmitReview value) submitReview,
  }) {
    return submitReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadReviews value)? loadReviews,
    TResult? Function(_SubmitReview value)? submitReview,
  }) {
    return submitReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadReviews value)? loadReviews,
    TResult Function(_SubmitReview value)? submitReview,
    required TResult orElse(),
  }) {
    if (submitReview != null) {
      return submitReview(this);
    }
    return orElse();
  }
}

abstract class _SubmitReview implements BrandStorefrontEvent {
  const factory _SubmitReview({
    required final String brandId,
    required final int qualityRating,
    required final int valueRating,
    required final int serviceRating,
    final String? comment,
  }) = _$SubmitReviewImpl;

  String get brandId;
  int get qualityRating;
  int get valueRating;
  int get serviceRating;
  String? get comment;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitReviewImplCopyWith<_$SubmitReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrandStorefrontState {
  bool get isLoading => throw _privateConstructorUsedError;
  BrandStorefront? get storefront => throw _privateConstructorUsedError;
  List<BrandProduct> get products => throw _privateConstructorUsedError;
  List<BrandReview> get reviews => throw _privateConstructorUsedError;
  bool get isLoadingProducts => throw _privateConstructorUsedError;
  bool get isLoadingReviews => throw _privateConstructorUsedError;
  bool get isSubmittingReview => throw _privateConstructorUsedError;
  bool get reviewSubmitSuccess => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandStorefrontStateCopyWith<BrandStorefrontState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStorefrontStateCopyWith<$Res> {
  factory $BrandStorefrontStateCopyWith(
    BrandStorefrontState value,
    $Res Function(BrandStorefrontState) then,
  ) = _$BrandStorefrontStateCopyWithImpl<$Res, BrandStorefrontState>;
  @useResult
  $Res call({
    bool isLoading,
    BrandStorefront? storefront,
    List<BrandProduct> products,
    List<BrandReview> reviews,
    bool isLoadingProducts,
    bool isLoadingReviews,
    bool isSubmittingReview,
    bool reviewSubmitSuccess,
    String? errorMessage,
  });

  $BrandStorefrontCopyWith<$Res>? get storefront;
}

/// @nodoc
class _$BrandStorefrontStateCopyWithImpl<
  $Res,
  $Val extends BrandStorefrontState
>
    implements $BrandStorefrontStateCopyWith<$Res> {
  _$BrandStorefrontStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? storefront = freezed,
    Object? products = null,
    Object? reviews = null,
    Object? isLoadingProducts = null,
    Object? isLoadingReviews = null,
    Object? isSubmittingReview = null,
    Object? reviewSubmitSuccess = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            storefront: freezed == storefront
                ? _value.storefront
                : storefront // ignore: cast_nullable_to_non_nullable
                      as BrandStorefront?,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<BrandProduct>,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as List<BrandReview>,
            isLoadingProducts: null == isLoadingProducts
                ? _value.isLoadingProducts
                : isLoadingProducts // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingReviews: null == isLoadingReviews
                ? _value.isLoadingReviews
                : isLoadingReviews // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmittingReview: null == isSubmittingReview
                ? _value.isSubmittingReview
                : isSubmittingReview // ignore: cast_nullable_to_non_nullable
                      as bool,
            reviewSubmitSuccess: null == reviewSubmitSuccess
                ? _value.reviewSubmitSuccess
                : reviewSubmitSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandStorefrontCopyWith<$Res>? get storefront {
    if (_value.storefront == null) {
      return null;
    }

    return $BrandStorefrontCopyWith<$Res>(_value.storefront!, (value) {
      return _then(_value.copyWith(storefront: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BrandStorefrontStateImplCopyWith<$Res>
    implements $BrandStorefrontStateCopyWith<$Res> {
  factory _$$BrandStorefrontStateImplCopyWith(
    _$BrandStorefrontStateImpl value,
    $Res Function(_$BrandStorefrontStateImpl) then,
  ) = __$$BrandStorefrontStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    BrandStorefront? storefront,
    List<BrandProduct> products,
    List<BrandReview> reviews,
    bool isLoadingProducts,
    bool isLoadingReviews,
    bool isSubmittingReview,
    bool reviewSubmitSuccess,
    String? errorMessage,
  });

  @override
  $BrandStorefrontCopyWith<$Res>? get storefront;
}

/// @nodoc
class __$$BrandStorefrontStateImplCopyWithImpl<$Res>
    extends _$BrandStorefrontStateCopyWithImpl<$Res, _$BrandStorefrontStateImpl>
    implements _$$BrandStorefrontStateImplCopyWith<$Res> {
  __$$BrandStorefrontStateImplCopyWithImpl(
    _$BrandStorefrontStateImpl _value,
    $Res Function(_$BrandStorefrontStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? storefront = freezed,
    Object? products = null,
    Object? reviews = null,
    Object? isLoadingProducts = null,
    Object? isLoadingReviews = null,
    Object? isSubmittingReview = null,
    Object? reviewSubmitSuccess = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$BrandStorefrontStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        storefront: freezed == storefront
            ? _value.storefront
            : storefront // ignore: cast_nullable_to_non_nullable
                  as BrandStorefront?,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<BrandProduct>,
        reviews: null == reviews
            ? _value._reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as List<BrandReview>,
        isLoadingProducts: null == isLoadingProducts
            ? _value.isLoadingProducts
            : isLoadingProducts // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingReviews: null == isLoadingReviews
            ? _value.isLoadingReviews
            : isLoadingReviews // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmittingReview: null == isSubmittingReview
            ? _value.isSubmittingReview
            : isSubmittingReview // ignore: cast_nullable_to_non_nullable
                  as bool,
        reviewSubmitSuccess: null == reviewSubmitSuccess
            ? _value.reviewSubmitSuccess
            : reviewSubmitSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$BrandStorefrontStateImpl implements _BrandStorefrontState {
  const _$BrandStorefrontStateImpl({
    this.isLoading = false,
    this.storefront,
    final List<BrandProduct> products = const [],
    final List<BrandReview> reviews = const [],
    this.isLoadingProducts = false,
    this.isLoadingReviews = false,
    this.isSubmittingReview = false,
    this.reviewSubmitSuccess = false,
    this.errorMessage,
  }) : _products = products,
       _reviews = reviews;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final BrandStorefront? storefront;
  final List<BrandProduct> _products;
  @override
  @JsonKey()
  List<BrandProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<BrandReview> _reviews;
  @override
  @JsonKey()
  List<BrandReview> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  @JsonKey()
  final bool isLoadingProducts;
  @override
  @JsonKey()
  final bool isLoadingReviews;
  @override
  @JsonKey()
  final bool isSubmittingReview;
  @override
  @JsonKey()
  final bool reviewSubmitSuccess;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'BrandStorefrontState(isLoading: $isLoading, storefront: $storefront, products: $products, reviews: $reviews, isLoadingProducts: $isLoadingProducts, isLoadingReviews: $isLoadingReviews, isSubmittingReview: $isSubmittingReview, reviewSubmitSuccess: $reviewSubmitSuccess, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandStorefrontStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.storefront, storefront) ||
                other.storefront == storefront) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            (identical(other.isLoadingProducts, isLoadingProducts) ||
                other.isLoadingProducts == isLoadingProducts) &&
            (identical(other.isLoadingReviews, isLoadingReviews) ||
                other.isLoadingReviews == isLoadingReviews) &&
            (identical(other.isSubmittingReview, isSubmittingReview) ||
                other.isSubmittingReview == isSubmittingReview) &&
            (identical(other.reviewSubmitSuccess, reviewSubmitSuccess) ||
                other.reviewSubmitSuccess == reviewSubmitSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    storefront,
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_reviews),
    isLoadingProducts,
    isLoadingReviews,
    isSubmittingReview,
    reviewSubmitSuccess,
    errorMessage,
  );

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandStorefrontStateImplCopyWith<_$BrandStorefrontStateImpl>
  get copyWith =>
      __$$BrandStorefrontStateImplCopyWithImpl<_$BrandStorefrontStateImpl>(
        this,
        _$identity,
      );
}

abstract class _BrandStorefrontState implements BrandStorefrontState {
  const factory _BrandStorefrontState({
    final bool isLoading,
    final BrandStorefront? storefront,
    final List<BrandProduct> products,
    final List<BrandReview> reviews,
    final bool isLoadingProducts,
    final bool isLoadingReviews,
    final bool isSubmittingReview,
    final bool reviewSubmitSuccess,
    final String? errorMessage,
  }) = _$BrandStorefrontStateImpl;

  @override
  bool get isLoading;
  @override
  BrandStorefront? get storefront;
  @override
  List<BrandProduct> get products;
  @override
  List<BrandReview> get reviews;
  @override
  bool get isLoadingProducts;
  @override
  bool get isLoadingReviews;
  @override
  bool get isSubmittingReview;
  @override
  bool get reviewSubmitSuccess;
  @override
  String? get errorMessage;

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandStorefrontStateImplCopyWith<_$BrandStorefrontStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
