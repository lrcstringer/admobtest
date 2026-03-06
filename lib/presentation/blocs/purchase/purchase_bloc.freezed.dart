// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PurchaseEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseEventCopyWith<$Res> {
  factory $PurchaseEventCopyWith(
    PurchaseEvent value,
    $Res Function(PurchaseEvent) then,
  ) = _$PurchaseEventCopyWithImpl<$Res, PurchaseEvent>;
}

/// @nodoc
class _$PurchaseEventCopyWithImpl<$Res, $Val extends PurchaseEvent>
    implements $PurchaseEventCopyWith<$Res> {
  _$PurchaseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadProvidersImplCopyWith<$Res> {
  factory _$$LoadProvidersImplCopyWith(
    _$LoadProvidersImpl value,
    $Res Function(_$LoadProvidersImpl) then,
  ) = __$$LoadProvidersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadProvidersImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$LoadProvidersImpl>
    implements _$$LoadProvidersImplCopyWith<$Res> {
  __$$LoadProvidersImplCopyWithImpl(
    _$LoadProvidersImpl _value,
    $Res Function(_$LoadProvidersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadProvidersImpl implements _LoadProviders {
  const _$LoadProvidersImpl();

  @override
  String toString() {
    return 'PurchaseEvent.loadProviders()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadProvidersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadProviders();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadProviders?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadProviders != null) {
      return loadProviders();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadProviders(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadProviders?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadProviders != null) {
      return loadProviders(this);
    }
    return orElse();
  }
}

abstract class _LoadProviders implements PurchaseEvent {
  const factory _LoadProviders() = _$LoadProvidersImpl;
}

/// @nodoc
abstract class _$$LoadProvidersByCategoryImplCopyWith<$Res> {
  factory _$$LoadProvidersByCategoryImplCopyWith(
    _$LoadProvidersByCategoryImpl value,
    $Res Function(_$LoadProvidersByCategoryImpl) then,
  ) = __$$LoadProvidersByCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PurchaseCategory category});
}

/// @nodoc
class __$$LoadProvidersByCategoryImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$LoadProvidersByCategoryImpl>
    implements _$$LoadProvidersByCategoryImplCopyWith<$Res> {
  __$$LoadProvidersByCategoryImplCopyWithImpl(
    _$LoadProvidersByCategoryImpl _value,
    $Res Function(_$LoadProvidersByCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = null}) {
    return _then(
      _$LoadProvidersByCategoryImpl(
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory,
      ),
    );
  }
}

/// @nodoc

class _$LoadProvidersByCategoryImpl implements _LoadProvidersByCategory {
  const _$LoadProvidersByCategoryImpl(this.category);

  @override
  final PurchaseCategory category;

  @override
  String toString() {
    return 'PurchaseEvent.loadProvidersByCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProvidersByCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProvidersByCategoryImplCopyWith<_$LoadProvidersByCategoryImpl>
  get copyWith =>
      __$$LoadProvidersByCategoryImplCopyWithImpl<
        _$LoadProvidersByCategoryImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadProvidersByCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadProvidersByCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadProvidersByCategory != null) {
      return loadProvidersByCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadProvidersByCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadProvidersByCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadProvidersByCategory != null) {
      return loadProvidersByCategory(this);
    }
    return orElse();
  }
}

abstract class _LoadProvidersByCategory implements PurchaseEvent {
  const factory _LoadProvidersByCategory(final PurchaseCategory category) =
      _$LoadProvidersByCategoryImpl;

  PurchaseCategory get category;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProvidersByCategoryImplCopyWith<_$LoadProvidersByCategoryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectCategoryImplCopyWith<$Res> {
  factory _$$SelectCategoryImplCopyWith(
    _$SelectCategoryImpl value,
    $Res Function(_$SelectCategoryImpl) then,
  ) = __$$SelectCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PurchaseCategory? category});
}

/// @nodoc
class __$$SelectCategoryImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$SelectCategoryImpl>
    implements _$$SelectCategoryImplCopyWith<$Res> {
  __$$SelectCategoryImplCopyWithImpl(
    _$SelectCategoryImpl _value,
    $Res Function(_$SelectCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = freezed}) {
    return _then(
      _$SelectCategoryImpl(
        freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory?,
      ),
    );
  }
}

/// @nodoc

class _$SelectCategoryImpl implements _SelectCategory {
  const _$SelectCategoryImpl(this.category);

  @override
  final PurchaseCategory? category;

  @override
  String toString() {
    return 'PurchaseEvent.selectCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCategoryImplCopyWith<_$SelectCategoryImpl> get copyWith =>
      __$$SelectCategoryImplCopyWithImpl<_$SelectCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return selectCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return selectCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectCategory != null) {
      return selectCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return selectCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return selectCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectCategory != null) {
      return selectCategory(this);
    }
    return orElse();
  }
}

abstract class _SelectCategory implements PurchaseEvent {
  const factory _SelectCategory(final PurchaseCategory? category) =
      _$SelectCategoryImpl;

  PurchaseCategory? get category;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectCategoryImplCopyWith<_$SelectCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectProviderImplCopyWith<$Res> {
  factory _$$SelectProviderImplCopyWith(
    _$SelectProviderImpl value,
    $Res Function(_$SelectProviderImpl) then,
  ) = __$$SelectProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ServiceProvider provider});

  $ServiceProviderCopyWith<$Res> get provider;
}

/// @nodoc
class __$$SelectProviderImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$SelectProviderImpl>
    implements _$$SelectProviderImplCopyWith<$Res> {
  __$$SelectProviderImplCopyWithImpl(
    _$SelectProviderImpl _value,
    $Res Function(_$SelectProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? provider = null}) {
    return _then(
      _$SelectProviderImpl(
        null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as ServiceProvider,
      ),
    );
  }

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceProviderCopyWith<$Res> get provider {
    return $ServiceProviderCopyWith<$Res>(_value.provider, (value) {
      return _then(_value.copyWith(provider: value));
    });
  }
}

/// @nodoc

class _$SelectProviderImpl implements _SelectProvider {
  const _$SelectProviderImpl(this.provider);

  @override
  final ServiceProvider provider;

  @override
  String toString() {
    return 'PurchaseEvent.selectProvider(provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectProviderImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectProviderImplCopyWith<_$SelectProviderImpl> get copyWith =>
      __$$SelectProviderImplCopyWithImpl<_$SelectProviderImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return selectProvider(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return selectProvider?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectProvider != null) {
      return selectProvider(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return selectProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return selectProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectProvider != null) {
      return selectProvider(this);
    }
    return orElse();
  }
}

abstract class _SelectProvider implements PurchaseEvent {
  const factory _SelectProvider(final ServiceProvider provider) =
      _$SelectProviderImpl;

  ServiceProvider get provider;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectProviderImplCopyWith<_$SelectProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadProductsImplCopyWith<$Res> {
  factory _$$LoadProductsImplCopyWith(
    _$LoadProductsImpl value,
    $Res Function(_$LoadProductsImpl) then,
  ) = __$$LoadProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerId});
}

/// @nodoc
class __$$LoadProductsImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$LoadProductsImpl>
    implements _$$LoadProductsImplCopyWith<$Res> {
  __$$LoadProductsImplCopyWithImpl(
    _$LoadProductsImpl _value,
    $Res Function(_$LoadProductsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? providerId = null}) {
    return _then(
      _$LoadProductsImpl(
        null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadProductsImpl implements _LoadProducts {
  const _$LoadProductsImpl(this.providerId);

  @override
  final String providerId;

  @override
  String toString() {
    return 'PurchaseEvent.loadProducts(providerId: $providerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProductsImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      __$$LoadProductsImplCopyWithImpl<_$LoadProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadProducts(providerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadProducts?.call(providerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(providerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadProducts implements PurchaseEvent {
  const factory _LoadProducts(final String providerId) = _$LoadProductsImpl;

  String get providerId;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectProductImplCopyWith<$Res> {
  factory _$$SelectProductImplCopyWith(
    _$SelectProductImpl value,
    $Res Function(_$SelectProductImpl) then,
  ) = __$$SelectProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ServiceProduct product});

  $ServiceProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$SelectProductImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$SelectProductImpl>
    implements _$$SelectProductImplCopyWith<$Res> {
  __$$SelectProductImplCopyWithImpl(
    _$SelectProductImpl _value,
    $Res Function(_$SelectProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? product = null}) {
    return _then(
      _$SelectProductImpl(
        null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as ServiceProduct,
      ),
    );
  }

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceProductCopyWith<$Res> get product {
    return $ServiceProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc

class _$SelectProductImpl implements _SelectProduct {
  const _$SelectProductImpl(this.product);

  @override
  final ServiceProduct product;

  @override
  String toString() {
    return 'PurchaseEvent.selectProduct(product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectProductImpl &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectProductImplCopyWith<_$SelectProductImpl> get copyWith =>
      __$$SelectProductImplCopyWithImpl<_$SelectProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return selectProduct(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return selectProduct?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectProduct != null) {
      return selectProduct(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return selectProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return selectProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectProduct != null) {
      return selectProduct(this);
    }
    return orElse();
  }
}

abstract class _SelectProduct implements PurchaseEvent {
  const factory _SelectProduct(final ServiceProduct product) =
      _$SelectProductImpl;

  ServiceProduct get product;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectProductImplCopyWith<_$SelectProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetRecipientNumberImplCopyWith<$Res> {
  factory _$$SetRecipientNumberImplCopyWith(
    _$SetRecipientNumberImpl value,
    $Res Function(_$SetRecipientNumberImpl) then,
  ) = __$$SetRecipientNumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String number});
}

/// @nodoc
class __$$SetRecipientNumberImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$SetRecipientNumberImpl>
    implements _$$SetRecipientNumberImplCopyWith<$Res> {
  __$$SetRecipientNumberImplCopyWithImpl(
    _$SetRecipientNumberImpl _value,
    $Res Function(_$SetRecipientNumberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? number = null}) {
    return _then(
      _$SetRecipientNumberImpl(
        null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SetRecipientNumberImpl implements _SetRecipientNumber {
  const _$SetRecipientNumberImpl(this.number);

  @override
  final String number;

  @override
  String toString() {
    return 'PurchaseEvent.setRecipientNumber(number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetRecipientNumberImpl &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetRecipientNumberImplCopyWith<_$SetRecipientNumberImpl> get copyWith =>
      __$$SetRecipientNumberImplCopyWithImpl<_$SetRecipientNumberImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return setRecipientNumber(number);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return setRecipientNumber?.call(number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (setRecipientNumber != null) {
      return setRecipientNumber(number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return setRecipientNumber(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return setRecipientNumber?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (setRecipientNumber != null) {
      return setRecipientNumber(this);
    }
    return orElse();
  }
}

abstract class _SetRecipientNumber implements PurchaseEvent {
  const factory _SetRecipientNumber(final String number) =
      _$SetRecipientNumberImpl;

  String get number;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetRecipientNumberImplCopyWith<_$SetRecipientNumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidateRecipientImplCopyWith<$Res> {
  factory _$$ValidateRecipientImplCopyWith(
    _$ValidateRecipientImpl value,
    $Res Function(_$ValidateRecipientImpl) then,
  ) = __$$ValidateRecipientImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ValidateRecipientImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$ValidateRecipientImpl>
    implements _$$ValidateRecipientImplCopyWith<$Res> {
  __$$ValidateRecipientImplCopyWithImpl(
    _$ValidateRecipientImpl _value,
    $Res Function(_$ValidateRecipientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ValidateRecipientImpl implements _ValidateRecipient {
  const _$ValidateRecipientImpl();

  @override
  String toString() {
    return 'PurchaseEvent.validateRecipient()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ValidateRecipientImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return validateRecipient();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return validateRecipient?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (validateRecipient != null) {
      return validateRecipient();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return validateRecipient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return validateRecipient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (validateRecipient != null) {
      return validateRecipient(this);
    }
    return orElse();
  }
}

abstract class _ValidateRecipient implements PurchaseEvent {
  const factory _ValidateRecipient() = _$ValidateRecipientImpl;
}

/// @nodoc
abstract class _$$MakePurchaseImplCopyWith<$Res> {
  factory _$$MakePurchaseImplCopyWith(
    _$MakePurchaseImpl value,
    $Res Function(_$MakePurchaseImpl) then,
  ) = __$$MakePurchaseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? subAccountId});
}

/// @nodoc
class __$$MakePurchaseImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$MakePurchaseImpl>
    implements _$$MakePurchaseImplCopyWith<$Res> {
  __$$MakePurchaseImplCopyWithImpl(
    _$MakePurchaseImpl _value,
    $Res Function(_$MakePurchaseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subAccountId = freezed}) {
    return _then(
      _$MakePurchaseImpl(
        subAccountId: freezed == subAccountId
            ? _value.subAccountId
            : subAccountId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MakePurchaseImpl implements _MakePurchase {
  const _$MakePurchaseImpl({this.subAccountId});

  @override
  final String? subAccountId;

  @override
  String toString() {
    return 'PurchaseEvent.makePurchase(subAccountId: $subAccountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MakePurchaseImpl &&
            (identical(other.subAccountId, subAccountId) ||
                other.subAccountId == subAccountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, subAccountId);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MakePurchaseImplCopyWith<_$MakePurchaseImpl> get copyWith =>
      __$$MakePurchaseImplCopyWithImpl<_$MakePurchaseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return makePurchase(subAccountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return makePurchase?.call(subAccountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (makePurchase != null) {
      return makePurchase(subAccountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return makePurchase(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return makePurchase?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (makePurchase != null) {
      return makePurchase(this);
    }
    return orElse();
  }
}

abstract class _MakePurchase implements PurchaseEvent {
  const factory _MakePurchase({final String? subAccountId}) =
      _$MakePurchaseImpl;

  String? get subAccountId;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MakePurchaseImplCopyWith<_$MakePurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadHistoryImplCopyWith<$Res> {
  factory _$$LoadHistoryImplCopyWith(
    _$LoadHistoryImpl value,
    $Res Function(_$LoadHistoryImpl) then,
  ) = __$$LoadHistoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PurchaseCategory? category, int? limit, DateTime? startAfter});
}

/// @nodoc
class __$$LoadHistoryImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$LoadHistoryImpl>
    implements _$$LoadHistoryImplCopyWith<$Res> {
  __$$LoadHistoryImplCopyWithImpl(
    _$LoadHistoryImpl _value,
    $Res Function(_$LoadHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? limit = freezed,
    Object? startAfter = freezed,
  }) {
    return _then(
      _$LoadHistoryImpl(
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory?,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
        startAfter: freezed == startAfter
            ? _value.startAfter
            : startAfter // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$LoadHistoryImpl implements _LoadHistory {
  const _$LoadHistoryImpl({this.category, this.limit, this.startAfter});

  @override
  final PurchaseCategory? category;
  @override
  final int? limit;
  @override
  final DateTime? startAfter;

  @override
  String toString() {
    return 'PurchaseEvent.loadHistory(category: $category, limit: $limit, startAfter: $startAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadHistoryImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.startAfter, startAfter) ||
                other.startAfter == startAfter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category, limit, startAfter);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadHistoryImplCopyWith<_$LoadHistoryImpl> get copyWith =>
      __$$LoadHistoryImplCopyWithImpl<_$LoadHistoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadHistory(category, limit, startAfter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadHistory?.call(category, limit, startAfter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory(category, limit, startAfter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadHistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory(this);
    }
    return orElse();
  }
}

abstract class _LoadHistory implements PurchaseEvent {
  const factory _LoadHistory({
    final PurchaseCategory? category,
    final int? limit,
    final DateTime? startAfter,
  }) = _$LoadHistoryImpl;

  PurchaseCategory? get category;
  int? get limit;
  DateTime? get startAfter;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadHistoryImplCopyWith<_$LoadHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadRecentRecipientsImplCopyWith<$Res> {
  factory _$$LoadRecentRecipientsImplCopyWith(
    _$LoadRecentRecipientsImpl value,
    $Res Function(_$LoadRecentRecipientsImpl) then,
  ) = __$$LoadRecentRecipientsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PurchaseCategory? category});
}

/// @nodoc
class __$$LoadRecentRecipientsImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$LoadRecentRecipientsImpl>
    implements _$$LoadRecentRecipientsImplCopyWith<$Res> {
  __$$LoadRecentRecipientsImplCopyWithImpl(
    _$LoadRecentRecipientsImpl _value,
    $Res Function(_$LoadRecentRecipientsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = freezed}) {
    return _then(
      _$LoadRecentRecipientsImpl(
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory?,
      ),
    );
  }
}

/// @nodoc

class _$LoadRecentRecipientsImpl implements _LoadRecentRecipients {
  const _$LoadRecentRecipientsImpl({this.category});

  @override
  final PurchaseCategory? category;

  @override
  String toString() {
    return 'PurchaseEvent.loadRecentRecipients(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadRecentRecipientsImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadRecentRecipientsImplCopyWith<_$LoadRecentRecipientsImpl>
  get copyWith =>
      __$$LoadRecentRecipientsImplCopyWithImpl<_$LoadRecentRecipientsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadRecentRecipients(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadRecentRecipients?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadRecentRecipients != null) {
      return loadRecentRecipients(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadRecentRecipients(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadRecentRecipients?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadRecentRecipients != null) {
      return loadRecentRecipients(this);
    }
    return orElse();
  }
}

abstract class _LoadRecentRecipients implements PurchaseEvent {
  const factory _LoadRecentRecipients({final PurchaseCategory? category}) =
      _$LoadRecentRecipientsImpl;

  PurchaseCategory? get category;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadRecentRecipientsImplCopyWith<_$LoadRecentRecipientsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectRecentRecipientImplCopyWith<$Res> {
  factory _$$SelectRecentRecipientImplCopyWith(
    _$SelectRecentRecipientImpl value,
    $Res Function(_$SelectRecentRecipientImpl) then,
  ) = __$$SelectRecentRecipientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String number});
}

/// @nodoc
class __$$SelectRecentRecipientImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$SelectRecentRecipientImpl>
    implements _$$SelectRecentRecipientImplCopyWith<$Res> {
  __$$SelectRecentRecipientImplCopyWithImpl(
    _$SelectRecentRecipientImpl _value,
    $Res Function(_$SelectRecentRecipientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? number = null}) {
    return _then(
      _$SelectRecentRecipientImpl(
        null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectRecentRecipientImpl implements _SelectRecentRecipient {
  const _$SelectRecentRecipientImpl(this.number);

  @override
  final String number;

  @override
  String toString() {
    return 'PurchaseEvent.selectRecentRecipient(number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectRecentRecipientImpl &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectRecentRecipientImplCopyWith<_$SelectRecentRecipientImpl>
  get copyWith =>
      __$$SelectRecentRecipientImplCopyWithImpl<_$SelectRecentRecipientImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return selectRecentRecipient(number);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return selectRecentRecipient?.call(number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectRecentRecipient != null) {
      return selectRecentRecipient(number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return selectRecentRecipient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return selectRecentRecipient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (selectRecentRecipient != null) {
      return selectRecentRecipient(this);
    }
    return orElse();
  }
}

abstract class _SelectRecentRecipient implements PurchaseEvent {
  const factory _SelectRecentRecipient(final String number) =
      _$SelectRecentRecipientImpl;

  String get number;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectRecentRecipientImplCopyWith<_$SelectRecentRecipientImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetSelectionImplCopyWith<$Res> {
  factory _$$ResetSelectionImplCopyWith(
    _$ResetSelectionImpl value,
    $Res Function(_$ResetSelectionImpl) then,
  ) = __$$ResetSelectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetSelectionImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$ResetSelectionImpl>
    implements _$$ResetSelectionImplCopyWith<$Res> {
  __$$ResetSelectionImplCopyWithImpl(
    _$ResetSelectionImpl _value,
    $Res Function(_$ResetSelectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetSelectionImpl implements _ResetSelection {
  const _$ResetSelectionImpl();

  @override
  String toString() {
    return 'PurchaseEvent.resetSelection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetSelectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return resetSelection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return resetSelection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (resetSelection != null) {
      return resetSelection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return resetSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return resetSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (resetSelection != null) {
      return resetSelection(this);
    }
    return orElse();
  }
}

abstract class _ResetSelection implements PurchaseEvent {
  const factory _ResetSelection() = _$ResetSelectionImpl;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'PurchaseEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements PurchaseEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
abstract class _$$ClearSuccessImplCopyWith<$Res> {
  factory _$$ClearSuccessImplCopyWith(
    _$ClearSuccessImpl value,
    $Res Function(_$ClearSuccessImpl) then,
  ) = __$$ClearSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSuccessImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$ClearSuccessImpl>
    implements _$$ClearSuccessImplCopyWith<$Res> {
  __$$ClearSuccessImplCopyWithImpl(
    _$ClearSuccessImpl _value,
    $Res Function(_$ClearSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSuccessImpl implements _ClearSuccess {
  const _$ClearSuccessImpl();

  @override
  String toString() {
    return 'PurchaseEvent.clearSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProviders,
    required TResult Function(PurchaseCategory category)
    loadProvidersByCategory,
    required TResult Function(PurchaseCategory? category) selectCategory,
    required TResult Function(ServiceProvider provider) selectProvider,
    required TResult Function(String providerId) loadProducts,
    required TResult Function(ServiceProduct product) selectProduct,
    required TResult Function(String number) setRecipientNumber,
    required TResult Function() validateRecipient,
    required TResult Function(String? subAccountId) makePurchase,
    required TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )
    loadHistory,
    required TResult Function(PurchaseCategory? category) loadRecentRecipients,
    required TResult Function(String number) selectRecentRecipient,
    required TResult Function() resetSelection,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return clearSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProviders,
    TResult? Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult? Function(PurchaseCategory? category)? selectCategory,
    TResult? Function(ServiceProvider provider)? selectProvider,
    TResult? Function(String providerId)? loadProducts,
    TResult? Function(ServiceProduct product)? selectProduct,
    TResult? Function(String number)? setRecipientNumber,
    TResult? Function()? validateRecipient,
    TResult? Function(String? subAccountId)? makePurchase,
    TResult? Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult? Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult? Function(String number)? selectRecentRecipient,
    TResult? Function()? resetSelection,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return clearSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProviders,
    TResult Function(PurchaseCategory category)? loadProvidersByCategory,
    TResult Function(PurchaseCategory? category)? selectCategory,
    TResult Function(ServiceProvider provider)? selectProvider,
    TResult Function(String providerId)? loadProducts,
    TResult Function(ServiceProduct product)? selectProduct,
    TResult Function(String number)? setRecipientNumber,
    TResult Function()? validateRecipient,
    TResult Function(String? subAccountId)? makePurchase,
    TResult Function(
      PurchaseCategory? category,
      int? limit,
      DateTime? startAfter,
    )?
    loadHistory,
    TResult Function(PurchaseCategory? category)? loadRecentRecipients,
    TResult Function(String number)? selectRecentRecipient,
    TResult Function()? resetSelection,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearSuccess != null) {
      return clearSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProviders value) loadProviders,
    required TResult Function(_LoadProvidersByCategory value)
    loadProvidersByCategory,
    required TResult Function(_SelectCategory value) selectCategory,
    required TResult Function(_SelectProvider value) selectProvider,
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_SelectProduct value) selectProduct,
    required TResult Function(_SetRecipientNumber value) setRecipientNumber,
    required TResult Function(_ValidateRecipient value) validateRecipient,
    required TResult Function(_MakePurchase value) makePurchase,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadRecentRecipients value) loadRecentRecipients,
    required TResult Function(_SelectRecentRecipient value)
    selectRecentRecipient,
    required TResult Function(_ResetSelection value) resetSelection,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return clearSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProviders value)? loadProviders,
    TResult? Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult? Function(_SelectCategory value)? selectCategory,
    TResult? Function(_SelectProvider value)? selectProvider,
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_SelectProduct value)? selectProduct,
    TResult? Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult? Function(_ValidateRecipient value)? validateRecipient,
    TResult? Function(_MakePurchase value)? makePurchase,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult? Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult? Function(_ResetSelection value)? resetSelection,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return clearSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProviders value)? loadProviders,
    TResult Function(_LoadProvidersByCategory value)? loadProvidersByCategory,
    TResult Function(_SelectCategory value)? selectCategory,
    TResult Function(_SelectProvider value)? selectProvider,
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_SelectProduct value)? selectProduct,
    TResult Function(_SetRecipientNumber value)? setRecipientNumber,
    TResult Function(_ValidateRecipient value)? validateRecipient,
    TResult Function(_MakePurchase value)? makePurchase,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadRecentRecipients value)? loadRecentRecipients,
    TResult Function(_SelectRecentRecipient value)? selectRecentRecipient,
    TResult Function(_ResetSelection value)? resetSelection,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearSuccess != null) {
      return clearSuccess(this);
    }
    return orElse();
  }
}

abstract class _ClearSuccess implements PurchaseEvent {
  const factory _ClearSuccess() = _$ClearSuccessImpl;
}

/// @nodoc
mixin _$PurchaseState {
  bool get isLoadingProviders => throw _privateConstructorUsedError;
  bool get isLoadingProducts => throw _privateConstructorUsedError;
  bool get isLoadingHistory => throw _privateConstructorUsedError;
  bool get isPurchasing => throw _privateConstructorUsedError;
  bool get isValidating => throw _privateConstructorUsedError;
  List<ServiceProvider> get providers => throw _privateConstructorUsedError;
  List<ServiceProduct> get products => throw _privateConstructorUsedError;
  List<Purchase> get history => throw _privateConstructorUsedError;
  List<String> get recentRecipients => throw _privateConstructorUsedError;
  PurchaseCategory? get selectedCategory => throw _privateConstructorUsedError;
  ServiceProvider? get selectedProvider => throw _privateConstructorUsedError;
  ServiceProduct? get selectedProduct => throw _privateConstructorUsedError;
  String? get recipientNumber => throw _privateConstructorUsedError;
  bool? get isRecipientValid => throw _privateConstructorUsedError;
  Purchase? get lastPurchase => throw _privateConstructorUsedError;
  bool get hasMoreHistory => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseStateCopyWith<PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseStateCopyWith<$Res> {
  factory $PurchaseStateCopyWith(
    PurchaseState value,
    $Res Function(PurchaseState) then,
  ) = _$PurchaseStateCopyWithImpl<$Res, PurchaseState>;
  @useResult
  $Res call({
    bool isLoadingProviders,
    bool isLoadingProducts,
    bool isLoadingHistory,
    bool isPurchasing,
    bool isValidating,
    List<ServiceProvider> providers,
    List<ServiceProduct> products,
    List<Purchase> history,
    List<String> recentRecipients,
    PurchaseCategory? selectedCategory,
    ServiceProvider? selectedProvider,
    ServiceProduct? selectedProduct,
    String? recipientNumber,
    bool? isRecipientValid,
    Purchase? lastPurchase,
    bool hasMoreHistory,
    String? errorMessage,
    String? successMessage,
  });

  $ServiceProviderCopyWith<$Res>? get selectedProvider;
  $ServiceProductCopyWith<$Res>? get selectedProduct;
  $PurchaseCopyWith<$Res>? get lastPurchase;
}

/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res, $Val extends PurchaseState>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingProviders = null,
    Object? isLoadingProducts = null,
    Object? isLoadingHistory = null,
    Object? isPurchasing = null,
    Object? isValidating = null,
    Object? providers = null,
    Object? products = null,
    Object? history = null,
    Object? recentRecipients = null,
    Object? selectedCategory = freezed,
    Object? selectedProvider = freezed,
    Object? selectedProduct = freezed,
    Object? recipientNumber = freezed,
    Object? isRecipientValid = freezed,
    Object? lastPurchase = freezed,
    Object? hasMoreHistory = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoadingProviders: null == isLoadingProviders
                ? _value.isLoadingProviders
                : isLoadingProviders // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingProducts: null == isLoadingProducts
                ? _value.isLoadingProducts
                : isLoadingProducts // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingHistory: null == isLoadingHistory
                ? _value.isLoadingHistory
                : isLoadingHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPurchasing: null == isPurchasing
                ? _value.isPurchasing
                : isPurchasing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isValidating: null == isValidating
                ? _value.isValidating
                : isValidating // ignore: cast_nullable_to_non_nullable
                      as bool,
            providers: null == providers
                ? _value.providers
                : providers // ignore: cast_nullable_to_non_nullable
                      as List<ServiceProvider>,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<ServiceProduct>,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<Purchase>,
            recentRecipients: null == recentRecipients
                ? _value.recentRecipients
                : recentRecipients // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            selectedCategory: freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as PurchaseCategory?,
            selectedProvider: freezed == selectedProvider
                ? _value.selectedProvider
                : selectedProvider // ignore: cast_nullable_to_non_nullable
                      as ServiceProvider?,
            selectedProduct: freezed == selectedProduct
                ? _value.selectedProduct
                : selectedProduct // ignore: cast_nullable_to_non_nullable
                      as ServiceProduct?,
            recipientNumber: freezed == recipientNumber
                ? _value.recipientNumber
                : recipientNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRecipientValid: freezed == isRecipientValid
                ? _value.isRecipientValid
                : isRecipientValid // ignore: cast_nullable_to_non_nullable
                      as bool?,
            lastPurchase: freezed == lastPurchase
                ? _value.lastPurchase
                : lastPurchase // ignore: cast_nullable_to_non_nullable
                      as Purchase?,
            hasMoreHistory: null == hasMoreHistory
                ? _value.hasMoreHistory
                : hasMoreHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceProviderCopyWith<$Res>? get selectedProvider {
    if (_value.selectedProvider == null) {
      return null;
    }

    return $ServiceProviderCopyWith<$Res>(_value.selectedProvider!, (value) {
      return _then(_value.copyWith(selectedProvider: value) as $Val);
    });
  }

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceProductCopyWith<$Res>? get selectedProduct {
    if (_value.selectedProduct == null) {
      return null;
    }

    return $ServiceProductCopyWith<$Res>(_value.selectedProduct!, (value) {
      return _then(_value.copyWith(selectedProduct: value) as $Val);
    });
  }

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PurchaseCopyWith<$Res>? get lastPurchase {
    if (_value.lastPurchase == null) {
      return null;
    }

    return $PurchaseCopyWith<$Res>(_value.lastPurchase!, (value) {
      return _then(_value.copyWith(lastPurchase: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PurchaseStateImplCopyWith<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  factory _$$PurchaseStateImplCopyWith(
    _$PurchaseStateImpl value,
    $Res Function(_$PurchaseStateImpl) then,
  ) = __$$PurchaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoadingProviders,
    bool isLoadingProducts,
    bool isLoadingHistory,
    bool isPurchasing,
    bool isValidating,
    List<ServiceProvider> providers,
    List<ServiceProduct> products,
    List<Purchase> history,
    List<String> recentRecipients,
    PurchaseCategory? selectedCategory,
    ServiceProvider? selectedProvider,
    ServiceProduct? selectedProduct,
    String? recipientNumber,
    bool? isRecipientValid,
    Purchase? lastPurchase,
    bool hasMoreHistory,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $ServiceProviderCopyWith<$Res>? get selectedProvider;
  @override
  $ServiceProductCopyWith<$Res>? get selectedProduct;
  @override
  $PurchaseCopyWith<$Res>? get lastPurchase;
}

/// @nodoc
class __$$PurchaseStateImplCopyWithImpl<$Res>
    extends _$PurchaseStateCopyWithImpl<$Res, _$PurchaseStateImpl>
    implements _$$PurchaseStateImplCopyWith<$Res> {
  __$$PurchaseStateImplCopyWithImpl(
    _$PurchaseStateImpl _value,
    $Res Function(_$PurchaseStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingProviders = null,
    Object? isLoadingProducts = null,
    Object? isLoadingHistory = null,
    Object? isPurchasing = null,
    Object? isValidating = null,
    Object? providers = null,
    Object? products = null,
    Object? history = null,
    Object? recentRecipients = null,
    Object? selectedCategory = freezed,
    Object? selectedProvider = freezed,
    Object? selectedProduct = freezed,
    Object? recipientNumber = freezed,
    Object? isRecipientValid = freezed,
    Object? lastPurchase = freezed,
    Object? hasMoreHistory = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$PurchaseStateImpl(
        isLoadingProviders: null == isLoadingProviders
            ? _value.isLoadingProviders
            : isLoadingProviders // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingProducts: null == isLoadingProducts
            ? _value.isLoadingProducts
            : isLoadingProducts // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingHistory: null == isLoadingHistory
            ? _value.isLoadingHistory
            : isLoadingHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPurchasing: null == isPurchasing
            ? _value.isPurchasing
            : isPurchasing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isValidating: null == isValidating
            ? _value.isValidating
            : isValidating // ignore: cast_nullable_to_non_nullable
                  as bool,
        providers: null == providers
            ? _value._providers
            : providers // ignore: cast_nullable_to_non_nullable
                  as List<ServiceProvider>,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<ServiceProduct>,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<Purchase>,
        recentRecipients: null == recentRecipients
            ? _value._recentRecipients
            : recentRecipients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory?,
        selectedProvider: freezed == selectedProvider
            ? _value.selectedProvider
            : selectedProvider // ignore: cast_nullable_to_non_nullable
                  as ServiceProvider?,
        selectedProduct: freezed == selectedProduct
            ? _value.selectedProduct
            : selectedProduct // ignore: cast_nullable_to_non_nullable
                  as ServiceProduct?,
        recipientNumber: freezed == recipientNumber
            ? _value.recipientNumber
            : recipientNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRecipientValid: freezed == isRecipientValid
            ? _value.isRecipientValid
            : isRecipientValid // ignore: cast_nullable_to_non_nullable
                  as bool?,
        lastPurchase: freezed == lastPurchase
            ? _value.lastPurchase
            : lastPurchase // ignore: cast_nullable_to_non_nullable
                  as Purchase?,
        hasMoreHistory: null == hasMoreHistory
            ? _value.hasMoreHistory
            : hasMoreHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PurchaseStateImpl implements _PurchaseState {
  const _$PurchaseStateImpl({
    this.isLoadingProviders = false,
    this.isLoadingProducts = false,
    this.isLoadingHistory = false,
    this.isPurchasing = false,
    this.isValidating = false,
    final List<ServiceProvider> providers = const [],
    final List<ServiceProduct> products = const [],
    final List<Purchase> history = const [],
    final List<String> recentRecipients = const [],
    this.selectedCategory,
    this.selectedProvider,
    this.selectedProduct,
    this.recipientNumber,
    this.isRecipientValid,
    this.lastPurchase,
    this.hasMoreHistory = false,
    this.errorMessage,
    this.successMessage,
  }) : _providers = providers,
       _products = products,
       _history = history,
       _recentRecipients = recentRecipients;

  @override
  @JsonKey()
  final bool isLoadingProviders;
  @override
  @JsonKey()
  final bool isLoadingProducts;
  @override
  @JsonKey()
  final bool isLoadingHistory;
  @override
  @JsonKey()
  final bool isPurchasing;
  @override
  @JsonKey()
  final bool isValidating;
  final List<ServiceProvider> _providers;
  @override
  @JsonKey()
  List<ServiceProvider> get providers {
    if (_providers is EqualUnmodifiableListView) return _providers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_providers);
  }

  final List<ServiceProduct> _products;
  @override
  @JsonKey()
  List<ServiceProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Purchase> _history;
  @override
  @JsonKey()
  List<Purchase> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  final List<String> _recentRecipients;
  @override
  @JsonKey()
  List<String> get recentRecipients {
    if (_recentRecipients is EqualUnmodifiableListView)
      return _recentRecipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentRecipients);
  }

  @override
  final PurchaseCategory? selectedCategory;
  @override
  final ServiceProvider? selectedProvider;
  @override
  final ServiceProduct? selectedProduct;
  @override
  final String? recipientNumber;
  @override
  final bool? isRecipientValid;
  @override
  final Purchase? lastPurchase;
  @override
  @JsonKey()
  final bool hasMoreHistory;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'PurchaseState(isLoadingProviders: $isLoadingProviders, isLoadingProducts: $isLoadingProducts, isLoadingHistory: $isLoadingHistory, isPurchasing: $isPurchasing, isValidating: $isValidating, providers: $providers, products: $products, history: $history, recentRecipients: $recentRecipients, selectedCategory: $selectedCategory, selectedProvider: $selectedProvider, selectedProduct: $selectedProduct, recipientNumber: $recipientNumber, isRecipientValid: $isRecipientValid, lastPurchase: $lastPurchase, hasMoreHistory: $hasMoreHistory, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseStateImpl &&
            (identical(other.isLoadingProviders, isLoadingProviders) ||
                other.isLoadingProviders == isLoadingProviders) &&
            (identical(other.isLoadingProducts, isLoadingProducts) ||
                other.isLoadingProducts == isLoadingProducts) &&
            (identical(other.isLoadingHistory, isLoadingHistory) ||
                other.isLoadingHistory == isLoadingHistory) &&
            (identical(other.isPurchasing, isPurchasing) ||
                other.isPurchasing == isPurchasing) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            const DeepCollectionEquality().equals(
              other._providers,
              _providers,
            ) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(
              other._recentRecipients,
              _recentRecipients,
            ) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedProvider, selectedProvider) ||
                other.selectedProvider == selectedProvider) &&
            (identical(other.selectedProduct, selectedProduct) ||
                other.selectedProduct == selectedProduct) &&
            (identical(other.recipientNumber, recipientNumber) ||
                other.recipientNumber == recipientNumber) &&
            (identical(other.isRecipientValid, isRecipientValid) ||
                other.isRecipientValid == isRecipientValid) &&
            (identical(other.lastPurchase, lastPurchase) ||
                other.lastPurchase == lastPurchase) &&
            (identical(other.hasMoreHistory, hasMoreHistory) ||
                other.hasMoreHistory == hasMoreHistory) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoadingProviders,
    isLoadingProducts,
    isLoadingHistory,
    isPurchasing,
    isValidating,
    const DeepCollectionEquality().hash(_providers),
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_history),
    const DeepCollectionEquality().hash(_recentRecipients),
    selectedCategory,
    selectedProvider,
    selectedProduct,
    recipientNumber,
    isRecipientValid,
    lastPurchase,
    hasMoreHistory,
    errorMessage,
    successMessage,
  );

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseStateImplCopyWith<_$PurchaseStateImpl> get copyWith =>
      __$$PurchaseStateImplCopyWithImpl<_$PurchaseStateImpl>(this, _$identity);
}

abstract class _PurchaseState implements PurchaseState {
  const factory _PurchaseState({
    final bool isLoadingProviders,
    final bool isLoadingProducts,
    final bool isLoadingHistory,
    final bool isPurchasing,
    final bool isValidating,
    final List<ServiceProvider> providers,
    final List<ServiceProduct> products,
    final List<Purchase> history,
    final List<String> recentRecipients,
    final PurchaseCategory? selectedCategory,
    final ServiceProvider? selectedProvider,
    final ServiceProduct? selectedProduct,
    final String? recipientNumber,
    final bool? isRecipientValid,
    final Purchase? lastPurchase,
    final bool hasMoreHistory,
    final String? errorMessage,
    final String? successMessage,
  }) = _$PurchaseStateImpl;

  @override
  bool get isLoadingProviders;
  @override
  bool get isLoadingProducts;
  @override
  bool get isLoadingHistory;
  @override
  bool get isPurchasing;
  @override
  bool get isValidating;
  @override
  List<ServiceProvider> get providers;
  @override
  List<ServiceProduct> get products;
  @override
  List<Purchase> get history;
  @override
  List<String> get recentRecipients;
  @override
  PurchaseCategory? get selectedCategory;
  @override
  ServiceProvider? get selectedProvider;
  @override
  ServiceProduct? get selectedProduct;
  @override
  String? get recipientNumber;
  @override
  bool? get isRecipientValid;
  @override
  Purchase? get lastPurchase;
  @override
  bool get hasMoreHistory;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseStateImplCopyWith<_$PurchaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
