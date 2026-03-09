// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MarketplaceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketplaceEventCopyWith<$Res> {
  factory $MarketplaceEventCopyWith(
    MarketplaceEvent value,
    $Res Function(MarketplaceEvent) then,
  ) = _$MarketplaceEventCopyWithImpl<$Res, MarketplaceEvent>;
}

/// @nodoc
class _$MarketplaceEventCopyWithImpl<$Res, $Val extends MarketplaceEvent>
    implements $MarketplaceEventCopyWith<$Res> {
  _$MarketplaceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadListingsImplCopyWith<$Res> {
  factory _$$LoadListingsImplCopyWith(
    _$LoadListingsImpl value,
    $Res Function(_$LoadListingsImpl) then,
  ) = __$$LoadListingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? category, String? communityId});
}

/// @nodoc
class __$$LoadListingsImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$LoadListingsImpl>
    implements _$$LoadListingsImplCopyWith<$Res> {
  __$$LoadListingsImplCopyWithImpl(
    _$LoadListingsImpl _value,
    $Res Function(_$LoadListingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = freezed, Object? communityId = freezed}) {
    return _then(
      _$LoadListingsImpl(
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadListingsImpl implements _LoadListings {
  const _$LoadListingsImpl({this.category, this.communityId});

  @override
  final String? category;
  @override
  final String? communityId;

  @override
  String toString() {
    return 'MarketplaceEvent.loadListings(category: $category, communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadListingsImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category, communityId);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadListingsImplCopyWith<_$LoadListingsImpl> get copyWith =>
      __$$LoadListingsImplCopyWithImpl<_$LoadListingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return loadListings(category, communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return loadListings?.call(category, communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadListings != null) {
      return loadListings(category, communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadListings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadListings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadListings != null) {
      return loadListings(this);
    }
    return orElse();
  }
}

abstract class _LoadListings implements MarketplaceEvent {
  const factory _LoadListings({
    final String? category,
    final String? communityId,
  }) = _$LoadListingsImpl;

  String? get category;
  String? get communityId;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadListingsImplCopyWith<_$LoadListingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreImplCopyWith<$Res> {
  factory _$$LoadMoreImplCopyWith(
    _$LoadMoreImpl value,
    $Res Function(_$LoadMoreImpl) then,
  ) = __$$LoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
    _$LoadMoreImpl _value,
    $Res Function(_$LoadMoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreImpl implements _LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'MarketplaceEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _LoadMore implements MarketplaceEvent {
  const factory _LoadMore() = _$LoadMoreImpl;
}

/// @nodoc
abstract class _$$SearchListingsImplCopyWith<$Res> {
  factory _$$SearchListingsImplCopyWith(
    _$SearchListingsImpl value,
    $Res Function(_$SearchListingsImpl) then,
  ) = __$$SearchListingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchListingsImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$SearchListingsImpl>
    implements _$$SearchListingsImplCopyWith<$Res> {
  __$$SearchListingsImplCopyWithImpl(
    _$SearchListingsImpl _value,
    $Res Function(_$SearchListingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchListingsImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchListingsImpl implements _SearchListings {
  const _$SearchListingsImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'MarketplaceEvent.searchListings(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchListingsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchListingsImplCopyWith<_$SearchListingsImpl> get copyWith =>
      __$$SearchListingsImplCopyWithImpl<_$SearchListingsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return searchListings(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return searchListings?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (searchListings != null) {
      return searchListings(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return searchListings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return searchListings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (searchListings != null) {
      return searchListings(this);
    }
    return orElse();
  }
}

abstract class _SearchListings implements MarketplaceEvent {
  const factory _SearchListings(final String query) = _$SearchListingsImpl;

  String get query;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchListingsImplCopyWith<_$SearchListingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSearchImplCopyWith<$Res> {
  factory _$$ClearSearchImplCopyWith(
    _$ClearSearchImpl value,
    $Res Function(_$ClearSearchImpl) then,
  ) = __$$ClearSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$ClearSearchImpl>
    implements _$$ClearSearchImplCopyWith<$Res> {
  __$$ClearSearchImplCopyWithImpl(
    _$ClearSearchImpl _value,
    $Res Function(_$ClearSearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchImpl implements _ClearSearch {
  const _$ClearSearchImpl();

  @override
  String toString() {
    return 'MarketplaceEvent.clearSearch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return clearSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return clearSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch(this);
    }
    return orElse();
  }
}

abstract class _ClearSearch implements MarketplaceEvent {
  const factory _ClearSearch() = _$ClearSearchImpl;
}

/// @nodoc
abstract class _$$SelectListingImplCopyWith<$Res> {
  factory _$$SelectListingImplCopyWith(
    _$SelectListingImpl value,
    $Res Function(_$SelectListingImpl) then,
  ) = __$$SelectListingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$SelectListingImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$SelectListingImpl>
    implements _$$SelectListingImplCopyWith<$Res> {
  __$$SelectListingImplCopyWithImpl(
    _$SelectListingImpl _value,
    $Res Function(_$SelectListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$SelectListingImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectListingImpl implements _SelectListing {
  const _$SelectListingImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'MarketplaceEvent.selectListing(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectListingImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectListingImplCopyWith<_$SelectListingImpl> get copyWith =>
      __$$SelectListingImplCopyWithImpl<_$SelectListingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return selectListing(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return selectListing?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (selectListing != null) {
      return selectListing(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return selectListing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return selectListing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (selectListing != null) {
      return selectListing(this);
    }
    return orElse();
  }
}

abstract class _SelectListing implements MarketplaceEvent {
  const factory _SelectListing(final String id) = _$SelectListingImpl;

  String get id;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectListingImplCopyWith<_$SelectListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadProviderProfileImplCopyWith<$Res> {
  factory _$$LoadProviderProfileImplCopyWith(
    _$LoadProviderProfileImpl value,
    $Res Function(_$LoadProviderProfileImpl) then,
  ) = __$$LoadProviderProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerId});
}

/// @nodoc
class __$$LoadProviderProfileImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$LoadProviderProfileImpl>
    implements _$$LoadProviderProfileImplCopyWith<$Res> {
  __$$LoadProviderProfileImplCopyWithImpl(
    _$LoadProviderProfileImpl _value,
    $Res Function(_$LoadProviderProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? providerId = null}) {
    return _then(
      _$LoadProviderProfileImpl(
        null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadProviderProfileImpl implements _LoadProviderProfile {
  const _$LoadProviderProfileImpl(this.providerId);

  @override
  final String providerId;

  @override
  String toString() {
    return 'MarketplaceEvent.loadProviderProfile(providerId: $providerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProviderProfileImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProviderProfileImplCopyWith<_$LoadProviderProfileImpl> get copyWith =>
      __$$LoadProviderProfileImplCopyWithImpl<_$LoadProviderProfileImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return loadProviderProfile(providerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return loadProviderProfile?.call(providerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadProviderProfile != null) {
      return loadProviderProfile(providerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadProviderProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadProviderProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadProviderProfile != null) {
      return loadProviderProfile(this);
    }
    return orElse();
  }
}

abstract class _LoadProviderProfile implements MarketplaceEvent {
  const factory _LoadProviderProfile(final String providerId) =
      _$LoadProviderProfileImpl;

  String get providerId;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProviderProfileImplCopyWith<_$LoadProviderProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadProviderVouchesImplCopyWith<$Res> {
  factory _$$LoadProviderVouchesImplCopyWith(
    _$LoadProviderVouchesImpl value,
    $Res Function(_$LoadProviderVouchesImpl) then,
  ) = __$$LoadProviderVouchesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerId});
}

/// @nodoc
class __$$LoadProviderVouchesImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$LoadProviderVouchesImpl>
    implements _$$LoadProviderVouchesImplCopyWith<$Res> {
  __$$LoadProviderVouchesImplCopyWithImpl(
    _$LoadProviderVouchesImpl _value,
    $Res Function(_$LoadProviderVouchesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? providerId = null}) {
    return _then(
      _$LoadProviderVouchesImpl(
        null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadProviderVouchesImpl implements _LoadProviderVouches {
  const _$LoadProviderVouchesImpl(this.providerId);

  @override
  final String providerId;

  @override
  String toString() {
    return 'MarketplaceEvent.loadProviderVouches(providerId: $providerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProviderVouchesImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProviderVouchesImplCopyWith<_$LoadProviderVouchesImpl> get copyWith =>
      __$$LoadProviderVouchesImplCopyWithImpl<_$LoadProviderVouchesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return loadProviderVouches(providerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return loadProviderVouches?.call(providerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadProviderVouches != null) {
      return loadProviderVouches(providerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadProviderVouches(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadProviderVouches?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadProviderVouches != null) {
      return loadProviderVouches(this);
    }
    return orElse();
  }
}

abstract class _LoadProviderVouches implements MarketplaceEvent {
  const factory _LoadProviderVouches(final String providerId) =
      _$LoadProviderVouchesImpl;

  String get providerId;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProviderVouchesImplCopyWith<_$LoadProviderVouchesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReportListingImplCopyWith<$Res> {
  factory _$$ReportListingImplCopyWith(
    _$ReportListingImpl value,
    $Res Function(_$ReportListingImpl) then,
  ) = __$$ReportListingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String listingId, String reason, String? description});
}

/// @nodoc
class __$$ReportListingImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$ReportListingImpl>
    implements _$$ReportListingImplCopyWith<$Res> {
  __$$ReportListingImplCopyWithImpl(
    _$ReportListingImpl _value,
    $Res Function(_$ReportListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listingId = null,
    Object? reason = null,
    Object? description = freezed,
  }) {
    return _then(
      _$ReportListingImpl(
        listingId: null == listingId
            ? _value.listingId
            : listingId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReportListingImpl implements _ReportListing {
  const _$ReportListingImpl({
    required this.listingId,
    required this.reason,
    this.description,
  });

  @override
  final String listingId;
  @override
  final String reason;
  @override
  final String? description;

  @override
  String toString() {
    return 'MarketplaceEvent.reportListing(listingId: $listingId, reason: $reason, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportListingImpl &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listingId, reason, description);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportListingImplCopyWith<_$ReportListingImpl> get copyWith =>
      __$$ReportListingImplCopyWithImpl<_$ReportListingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return reportListing(listingId, reason, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return reportListing?.call(listingId, reason, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (reportListing != null) {
      return reportListing(listingId, reason, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return reportListing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return reportListing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (reportListing != null) {
      return reportListing(this);
    }
    return orElse();
  }
}

abstract class _ReportListing implements MarketplaceEvent {
  const factory _ReportListing({
    required final String listingId,
    required final String reason,
    final String? description,
  }) = _$ReportListingImpl;

  String get listingId;
  String get reason;
  String? get description;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportListingImplCopyWith<_$ReportListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReportProviderImplCopyWith<$Res> {
  factory _$$ReportProviderImplCopyWith(
    _$ReportProviderImpl value,
    $Res Function(_$ReportProviderImpl) then,
  ) = __$$ReportProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerId, String reason, String? description});
}

/// @nodoc
class __$$ReportProviderImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$ReportProviderImpl>
    implements _$$ReportProviderImplCopyWith<$Res> {
  __$$ReportProviderImplCopyWithImpl(
    _$ReportProviderImpl _value,
    $Res Function(_$ReportProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? reason = null,
    Object? description = freezed,
  }) {
    return _then(
      _$ReportProviderImpl(
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReportProviderImpl implements _ReportProvider {
  const _$ReportProviderImpl({
    required this.providerId,
    required this.reason,
    this.description,
  });

  @override
  final String providerId;
  @override
  final String reason;
  @override
  final String? description;

  @override
  String toString() {
    return 'MarketplaceEvent.reportProvider(providerId: $providerId, reason: $reason, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportProviderImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId, reason, description);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportProviderImplCopyWith<_$ReportProviderImpl> get copyWith =>
      __$$ReportProviderImplCopyWithImpl<_$ReportProviderImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return reportProvider(providerId, reason, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return reportProvider?.call(providerId, reason, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (reportProvider != null) {
      return reportProvider(providerId, reason, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return reportProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return reportProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (reportProvider != null) {
      return reportProvider(this);
    }
    return orElse();
  }
}

abstract class _ReportProvider implements MarketplaceEvent {
  const factory _ReportProvider({
    required final String providerId,
    required final String reason,
    final String? description,
  }) = _$ReportProviderImpl;

  String get providerId;
  String get reason;
  String? get description;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportProviderImplCopyWith<_$ReportProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateListingImplCopyWith<$Res> {
  factory _$$CreateListingImplCopyWith(
    _$CreateListingImpl value,
    $Res Function(_$CreateListingImpl) then,
  ) = __$$CreateListingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String title,
    String description,
    String category,
    String? subCategory,
    int priceTokens,
    List<String> imageUrls,
    String? location,
  });
}

/// @nodoc
class __$$CreateListingImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$CreateListingImpl>
    implements _$$CreateListingImplCopyWith<$Res> {
  __$$CreateListingImplCopyWithImpl(
    _$CreateListingImpl _value,
    $Res Function(_$CreateListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subCategory = freezed,
    Object? priceTokens = null,
    Object? imageUrls = null,
    Object? location = freezed,
  }) {
    return _then(
      _$CreateListingImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        subCategory: freezed == subCategory
            ? _value.subCategory
            : subCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceTokens: null == priceTokens
            ? _value.priceTokens
            : priceTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CreateListingImpl implements _CreateListing {
  const _$CreateListingImpl({
    required this.title,
    required this.description,
    required this.category,
    this.subCategory,
    required this.priceTokens,
    required final List<String> imageUrls,
    this.location,
  }) : _imageUrls = imageUrls;

  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
  @override
  final String? subCategory;
  @override
  final int priceTokens;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final String? location;

  @override
  String toString() {
    return 'MarketplaceEvent.createListing(title: $title, description: $description, category: $category, subCategory: $subCategory, priceTokens: $priceTokens, imageUrls: $imageUrls, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateListingImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.priceTokens, priceTokens) ||
                other.priceTokens == priceTokens) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    category,
    subCategory,
    priceTokens,
    const DeepCollectionEquality().hash(_imageUrls),
    location,
  );

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateListingImplCopyWith<_$CreateListingImpl> get copyWith =>
      __$$CreateListingImplCopyWithImpl<_$CreateListingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return createListing(
      title,
      description,
      category,
      subCategory,
      priceTokens,
      imageUrls,
      location,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return createListing?.call(
      title,
      description,
      category,
      subCategory,
      priceTokens,
      imageUrls,
      location,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (createListing != null) {
      return createListing(
        title,
        description,
        category,
        subCategory,
        priceTokens,
        imageUrls,
        location,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return createListing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return createListing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (createListing != null) {
      return createListing(this);
    }
    return orElse();
  }
}

abstract class _CreateListing implements MarketplaceEvent {
  const factory _CreateListing({
    required final String title,
    required final String description,
    required final String category,
    final String? subCategory,
    required final int priceTokens,
    required final List<String> imageUrls,
    final String? location,
  }) = _$CreateListingImpl;

  String get title;
  String get description;
  String get category;
  String? get subCategory;
  int get priceTokens;
  List<String> get imageUrls;
  String? get location;

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateListingImplCopyWith<_$CreateListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearMessagesImplCopyWith<$Res> {
  factory _$$ClearMessagesImplCopyWith(
    _$ClearMessagesImpl value,
    $Res Function(_$ClearMessagesImpl) then,
  ) = __$$ClearMessagesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearMessagesImplCopyWithImpl<$Res>
    extends _$MarketplaceEventCopyWithImpl<$Res, _$ClearMessagesImpl>
    implements _$$ClearMessagesImplCopyWith<$Res> {
  __$$ClearMessagesImplCopyWithImpl(
    _$ClearMessagesImpl _value,
    $Res Function(_$ClearMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessagesImpl implements _ClearMessages {
  const _$ClearMessagesImpl();

  @override
  String toString() {
    return 'MarketplaceEvent.clearMessages()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearMessagesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? category, String? communityId)
    loadListings,
    required TResult Function() loadMore,
    required TResult Function(String query) searchListings,
    required TResult Function() clearSearch,
    required TResult Function(String id) selectListing,
    required TResult Function(String providerId) loadProviderProfile,
    required TResult Function(String providerId) loadProviderVouches,
    required TResult Function(
      String listingId,
      String reason,
      String? description,
    )
    reportListing,
    required TResult Function(
      String providerId,
      String reason,
      String? description,
    )
    reportProvider,
    required TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )
    createListing,
    required TResult Function() clearMessages,
  }) {
    return clearMessages();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? category, String? communityId)? loadListings,
    TResult? Function()? loadMore,
    TResult? Function(String query)? searchListings,
    TResult? Function()? clearSearch,
    TResult? Function(String id)? selectListing,
    TResult? Function(String providerId)? loadProviderProfile,
    TResult? Function(String providerId)? loadProviderVouches,
    TResult? Function(String listingId, String reason, String? description)?
    reportListing,
    TResult? Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult? Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult? Function()? clearMessages,
  }) {
    return clearMessages?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? category, String? communityId)? loadListings,
    TResult Function()? loadMore,
    TResult Function(String query)? searchListings,
    TResult Function()? clearSearch,
    TResult Function(String id)? selectListing,
    TResult Function(String providerId)? loadProviderProfile,
    TResult Function(String providerId)? loadProviderVouches,
    TResult Function(String listingId, String reason, String? description)?
    reportListing,
    TResult Function(String providerId, String reason, String? description)?
    reportProvider,
    TResult Function(
      String title,
      String description,
      String category,
      String? subCategory,
      int priceTokens,
      List<String> imageUrls,
      String? location,
    )?
    createListing,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadListings value) loadListings,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_SearchListings value) searchListings,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_SelectListing value) selectListing,
    required TResult Function(_LoadProviderProfile value) loadProviderProfile,
    required TResult Function(_LoadProviderVouches value) loadProviderVouches,
    required TResult Function(_ReportListing value) reportListing,
    required TResult Function(_ReportProvider value) reportProvider,
    required TResult Function(_CreateListing value) createListing,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadListings value)? loadListings,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_SearchListings value)? searchListings,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_SelectListing value)? selectListing,
    TResult? Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult? Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult? Function(_ReportListing value)? reportListing,
    TResult? Function(_ReportProvider value)? reportProvider,
    TResult? Function(_CreateListing value)? createListing,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadListings value)? loadListings,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_SearchListings value)? searchListings,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_SelectListing value)? selectListing,
    TResult Function(_LoadProviderProfile value)? loadProviderProfile,
    TResult Function(_LoadProviderVouches value)? loadProviderVouches,
    TResult Function(_ReportListing value)? reportListing,
    TResult Function(_ReportProvider value)? reportProvider,
    TResult Function(_CreateListing value)? createListing,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages(this);
    }
    return orElse();
  }
}

abstract class _ClearMessages implements MarketplaceEvent {
  const factory _ClearMessages() = _$ClearMessagesImpl;
}

/// @nodoc
mixin _$MarketplaceState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get isLoadingDetail => throw _privateConstructorUsedError;
  bool get isLoadingProvider => throw _privateConstructorUsedError;
  List<MarketplaceListing> get listings => throw _privateConstructorUsedError;
  List<MarketplaceListing> get filteredListings =>
      throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  MarketplaceListing? get selectedListing => throw _privateConstructorUsedError;
  MarketplaceProvider? get selectedProvider =>
      throw _privateConstructorUsedError;
  List<Vouch> get providerVouches => throw _privateConstructorUsedError;
  bool get isSearching => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String? get activeCategory => throw _privateConstructorUsedError;
  String? get activeCommunityId => throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;
  bool get isReporting => throw _privateConstructorUsedError;
  String? get createSuccessId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get reportSuccessMessage => throw _privateConstructorUsedError;

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketplaceStateCopyWith<MarketplaceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketplaceStateCopyWith<$Res> {
  factory $MarketplaceStateCopyWith(
    MarketplaceState value,
    $Res Function(MarketplaceState) then,
  ) = _$MarketplaceStateCopyWithImpl<$Res, MarketplaceState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingMore,
    bool isLoadingDetail,
    bool isLoadingProvider,
    List<MarketplaceListing> listings,
    List<MarketplaceListing> filteredListings,
    bool hasMore,
    MarketplaceListing? selectedListing,
    MarketplaceProvider? selectedProvider,
    List<Vouch> providerVouches,
    bool isSearching,
    String searchQuery,
    String? activeCategory,
    String? activeCommunityId,
    bool isCreating,
    bool isReporting,
    String? createSuccessId,
    String? errorMessage,
    String? reportSuccessMessage,
  });

  $MarketplaceListingCopyWith<$Res>? get selectedListing;
  $MarketplaceProviderCopyWith<$Res>? get selectedProvider;
}

/// @nodoc
class _$MarketplaceStateCopyWithImpl<$Res, $Val extends MarketplaceState>
    implements $MarketplaceStateCopyWith<$Res> {
  _$MarketplaceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? isLoadingDetail = null,
    Object? isLoadingProvider = null,
    Object? listings = null,
    Object? filteredListings = null,
    Object? hasMore = null,
    Object? selectedListing = freezed,
    Object? selectedProvider = freezed,
    Object? providerVouches = null,
    Object? isSearching = null,
    Object? searchQuery = null,
    Object? activeCategory = freezed,
    Object? activeCommunityId = freezed,
    Object? isCreating = null,
    Object? isReporting = null,
    Object? createSuccessId = freezed,
    Object? errorMessage = freezed,
    Object? reportSuccessMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingDetail: null == isLoadingDetail
                ? _value.isLoadingDetail
                : isLoadingDetail // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingProvider: null == isLoadingProvider
                ? _value.isLoadingProvider
                : isLoadingProvider // ignore: cast_nullable_to_non_nullable
                      as bool,
            listings: null == listings
                ? _value.listings
                : listings // ignore: cast_nullable_to_non_nullable
                      as List<MarketplaceListing>,
            filteredListings: null == filteredListings
                ? _value.filteredListings
                : filteredListings // ignore: cast_nullable_to_non_nullable
                      as List<MarketplaceListing>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedListing: freezed == selectedListing
                ? _value.selectedListing
                : selectedListing // ignore: cast_nullable_to_non_nullable
                      as MarketplaceListing?,
            selectedProvider: freezed == selectedProvider
                ? _value.selectedProvider
                : selectedProvider // ignore: cast_nullable_to_non_nullable
                      as MarketplaceProvider?,
            providerVouches: null == providerVouches
                ? _value.providerVouches
                : providerVouches // ignore: cast_nullable_to_non_nullable
                      as List<Vouch>,
            isSearching: null == isSearching
                ? _value.isSearching
                : isSearching // ignore: cast_nullable_to_non_nullable
                      as bool,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            activeCategory: freezed == activeCategory
                ? _value.activeCategory
                : activeCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            activeCommunityId: freezed == activeCommunityId
                ? _value.activeCommunityId
                : activeCommunityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCreating: null == isCreating
                ? _value.isCreating
                : isCreating // ignore: cast_nullable_to_non_nullable
                      as bool,
            isReporting: null == isReporting
                ? _value.isReporting
                : isReporting // ignore: cast_nullable_to_non_nullable
                      as bool,
            createSuccessId: freezed == createSuccessId
                ? _value.createSuccessId
                : createSuccessId // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            reportSuccessMessage: freezed == reportSuccessMessage
                ? _value.reportSuccessMessage
                : reportSuccessMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MarketplaceListingCopyWith<$Res>? get selectedListing {
    if (_value.selectedListing == null) {
      return null;
    }

    return $MarketplaceListingCopyWith<$Res>(_value.selectedListing!, (value) {
      return _then(_value.copyWith(selectedListing: value) as $Val);
    });
  }

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MarketplaceProviderCopyWith<$Res>? get selectedProvider {
    if (_value.selectedProvider == null) {
      return null;
    }

    return $MarketplaceProviderCopyWith<$Res>(_value.selectedProvider!, (
      value,
    ) {
      return _then(_value.copyWith(selectedProvider: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MarketplaceStateImplCopyWith<$Res>
    implements $MarketplaceStateCopyWith<$Res> {
  factory _$$MarketplaceStateImplCopyWith(
    _$MarketplaceStateImpl value,
    $Res Function(_$MarketplaceStateImpl) then,
  ) = __$$MarketplaceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingMore,
    bool isLoadingDetail,
    bool isLoadingProvider,
    List<MarketplaceListing> listings,
    List<MarketplaceListing> filteredListings,
    bool hasMore,
    MarketplaceListing? selectedListing,
    MarketplaceProvider? selectedProvider,
    List<Vouch> providerVouches,
    bool isSearching,
    String searchQuery,
    String? activeCategory,
    String? activeCommunityId,
    bool isCreating,
    bool isReporting,
    String? createSuccessId,
    String? errorMessage,
    String? reportSuccessMessage,
  });

  @override
  $MarketplaceListingCopyWith<$Res>? get selectedListing;
  @override
  $MarketplaceProviderCopyWith<$Res>? get selectedProvider;
}

/// @nodoc
class __$$MarketplaceStateImplCopyWithImpl<$Res>
    extends _$MarketplaceStateCopyWithImpl<$Res, _$MarketplaceStateImpl>
    implements _$$MarketplaceStateImplCopyWith<$Res> {
  __$$MarketplaceStateImplCopyWithImpl(
    _$MarketplaceStateImpl _value,
    $Res Function(_$MarketplaceStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? isLoadingDetail = null,
    Object? isLoadingProvider = null,
    Object? listings = null,
    Object? filteredListings = null,
    Object? hasMore = null,
    Object? selectedListing = freezed,
    Object? selectedProvider = freezed,
    Object? providerVouches = null,
    Object? isSearching = null,
    Object? searchQuery = null,
    Object? activeCategory = freezed,
    Object? activeCommunityId = freezed,
    Object? isCreating = null,
    Object? isReporting = null,
    Object? createSuccessId = freezed,
    Object? errorMessage = freezed,
    Object? reportSuccessMessage = freezed,
  }) {
    return _then(
      _$MarketplaceStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingDetail: null == isLoadingDetail
            ? _value.isLoadingDetail
            : isLoadingDetail // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingProvider: null == isLoadingProvider
            ? _value.isLoadingProvider
            : isLoadingProvider // ignore: cast_nullable_to_non_nullable
                  as bool,
        listings: null == listings
            ? _value._listings
            : listings // ignore: cast_nullable_to_non_nullable
                  as List<MarketplaceListing>,
        filteredListings: null == filteredListings
            ? _value._filteredListings
            : filteredListings // ignore: cast_nullable_to_non_nullable
                  as List<MarketplaceListing>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedListing: freezed == selectedListing
            ? _value.selectedListing
            : selectedListing // ignore: cast_nullable_to_non_nullable
                  as MarketplaceListing?,
        selectedProvider: freezed == selectedProvider
            ? _value.selectedProvider
            : selectedProvider // ignore: cast_nullable_to_non_nullable
                  as MarketplaceProvider?,
        providerVouches: null == providerVouches
            ? _value._providerVouches
            : providerVouches // ignore: cast_nullable_to_non_nullable
                  as List<Vouch>,
        isSearching: null == isSearching
            ? _value.isSearching
            : isSearching // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        activeCategory: freezed == activeCategory
            ? _value.activeCategory
            : activeCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        activeCommunityId: freezed == activeCommunityId
            ? _value.activeCommunityId
            : activeCommunityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCreating: null == isCreating
            ? _value.isCreating
            : isCreating // ignore: cast_nullable_to_non_nullable
                  as bool,
        isReporting: null == isReporting
            ? _value.isReporting
            : isReporting // ignore: cast_nullable_to_non_nullable
                  as bool,
        createSuccessId: freezed == createSuccessId
            ? _value.createSuccessId
            : createSuccessId // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        reportSuccessMessage: freezed == reportSuccessMessage
            ? _value.reportSuccessMessage
            : reportSuccessMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MarketplaceStateImpl implements _MarketplaceState {
  const _$MarketplaceStateImpl({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isLoadingDetail = false,
    this.isLoadingProvider = false,
    final List<MarketplaceListing> listings = const [],
    final List<MarketplaceListing> filteredListings = const [],
    this.hasMore = true,
    this.selectedListing,
    this.selectedProvider,
    final List<Vouch> providerVouches = const [],
    this.isSearching = false,
    this.searchQuery = '',
    this.activeCategory,
    this.activeCommunityId,
    this.isCreating = false,
    this.isReporting = false,
    this.createSuccessId,
    this.errorMessage,
    this.reportSuccessMessage,
  }) : _listings = listings,
       _filteredListings = filteredListings,
       _providerVouches = providerVouches;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool isLoadingDetail;
  @override
  @JsonKey()
  final bool isLoadingProvider;
  final List<MarketplaceListing> _listings;
  @override
  @JsonKey()
  List<MarketplaceListing> get listings {
    if (_listings is EqualUnmodifiableListView) return _listings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listings);
  }

  final List<MarketplaceListing> _filteredListings;
  @override
  @JsonKey()
  List<MarketplaceListing> get filteredListings {
    if (_filteredListings is EqualUnmodifiableListView)
      return _filteredListings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredListings);
  }

  @override
  @JsonKey()
  final bool hasMore;
  @override
  final MarketplaceListing? selectedListing;
  @override
  final MarketplaceProvider? selectedProvider;
  final List<Vouch> _providerVouches;
  @override
  @JsonKey()
  List<Vouch> get providerVouches {
    if (_providerVouches is EqualUnmodifiableListView) return _providerVouches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_providerVouches);
  }

  @override
  @JsonKey()
  final bool isSearching;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  final String? activeCategory;
  @override
  final String? activeCommunityId;
  @override
  @JsonKey()
  final bool isCreating;
  @override
  @JsonKey()
  final bool isReporting;
  @override
  final String? createSuccessId;
  @override
  final String? errorMessage;
  @override
  final String? reportSuccessMessage;

  @override
  String toString() {
    return 'MarketplaceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isLoadingDetail: $isLoadingDetail, isLoadingProvider: $isLoadingProvider, listings: $listings, filteredListings: $filteredListings, hasMore: $hasMore, selectedListing: $selectedListing, selectedProvider: $selectedProvider, providerVouches: $providerVouches, isSearching: $isSearching, searchQuery: $searchQuery, activeCategory: $activeCategory, activeCommunityId: $activeCommunityId, isCreating: $isCreating, isReporting: $isReporting, createSuccessId: $createSuccessId, errorMessage: $errorMessage, reportSuccessMessage: $reportSuccessMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketplaceStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isLoadingDetail, isLoadingDetail) ||
                other.isLoadingDetail == isLoadingDetail) &&
            (identical(other.isLoadingProvider, isLoadingProvider) ||
                other.isLoadingProvider == isLoadingProvider) &&
            const DeepCollectionEquality().equals(other._listings, _listings) &&
            const DeepCollectionEquality().equals(
              other._filteredListings,
              _filteredListings,
            ) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.selectedListing, selectedListing) ||
                other.selectedListing == selectedListing) &&
            (identical(other.selectedProvider, selectedProvider) ||
                other.selectedProvider == selectedProvider) &&
            const DeepCollectionEquality().equals(
              other._providerVouches,
              _providerVouches,
            ) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.activeCategory, activeCategory) ||
                other.activeCategory == activeCategory) &&
            (identical(other.activeCommunityId, activeCommunityId) ||
                other.activeCommunityId == activeCommunityId) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
            (identical(other.isReporting, isReporting) ||
                other.isReporting == isReporting) &&
            (identical(other.createSuccessId, createSuccessId) ||
                other.createSuccessId == createSuccessId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.reportSuccessMessage, reportSuccessMessage) ||
                other.reportSuccessMessage == reportSuccessMessage));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    isLoading,
    isLoadingMore,
    isLoadingDetail,
    isLoadingProvider,
    const DeepCollectionEquality().hash(_listings),
    const DeepCollectionEquality().hash(_filteredListings),
    hasMore,
    selectedListing,
    selectedProvider,
    const DeepCollectionEquality().hash(_providerVouches),
    isSearching,
    searchQuery,
    activeCategory,
    activeCommunityId,
    isCreating,
    isReporting,
    createSuccessId,
    errorMessage,
    reportSuccessMessage,
  ]);

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketplaceStateImplCopyWith<_$MarketplaceStateImpl> get copyWith =>
      __$$MarketplaceStateImplCopyWithImpl<_$MarketplaceStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MarketplaceState implements MarketplaceState {
  const factory _MarketplaceState({
    final bool isLoading,
    final bool isLoadingMore,
    final bool isLoadingDetail,
    final bool isLoadingProvider,
    final List<MarketplaceListing> listings,
    final List<MarketplaceListing> filteredListings,
    final bool hasMore,
    final MarketplaceListing? selectedListing,
    final MarketplaceProvider? selectedProvider,
    final List<Vouch> providerVouches,
    final bool isSearching,
    final String searchQuery,
    final String? activeCategory,
    final String? activeCommunityId,
    final bool isCreating,
    final bool isReporting,
    final String? createSuccessId,
    final String? errorMessage,
    final String? reportSuccessMessage,
  }) = _$MarketplaceStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get isLoadingDetail;
  @override
  bool get isLoadingProvider;
  @override
  List<MarketplaceListing> get listings;
  @override
  List<MarketplaceListing> get filteredListings;
  @override
  bool get hasMore;
  @override
  MarketplaceListing? get selectedListing;
  @override
  MarketplaceProvider? get selectedProvider;
  @override
  List<Vouch> get providerVouches;
  @override
  bool get isSearching;
  @override
  String get searchQuery;
  @override
  String? get activeCategory;
  @override
  String? get activeCommunityId;
  @override
  bool get isCreating;
  @override
  bool get isReporting;
  @override
  String? get createSuccessId;
  @override
  String? get errorMessage;
  @override
  String? get reportSuccessMessage;

  /// Create a copy of MarketplaceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketplaceStateImplCopyWith<_$MarketplaceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
