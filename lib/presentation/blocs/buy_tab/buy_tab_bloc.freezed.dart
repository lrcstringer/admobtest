// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_tab_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BuyTabEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyTabEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BuyTabEvent()';
}


}

/// @nodoc
class $BuyTabEventCopyWith<$Res>  {
$BuyTabEventCopyWith(BuyTabEvent _, $Res Function(BuyTabEvent) __);
}


/// Adds pattern-matching-related methods to [BuyTabEvent].
extension BuyTabEventPatterns on BuyTabEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadBuyTab value)?  loadBuyTab,TResult Function( _RefreshBuyTab value)?  refreshBuyTab,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadBuyTab() when loadBuyTab != null:
return loadBuyTab(_that);case _RefreshBuyTab() when refreshBuyTab != null:
return refreshBuyTab(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadBuyTab value)  loadBuyTab,required TResult Function( _RefreshBuyTab value)  refreshBuyTab,}){
final _that = this;
switch (_that) {
case _LoadBuyTab():
return loadBuyTab(_that);case _RefreshBuyTab():
return refreshBuyTab(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadBuyTab value)?  loadBuyTab,TResult? Function( _RefreshBuyTab value)?  refreshBuyTab,}){
final _that = this;
switch (_that) {
case _LoadBuyTab() when loadBuyTab != null:
return loadBuyTab(_that);case _RefreshBuyTab() when refreshBuyTab != null:
return refreshBuyTab(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadBuyTab,TResult Function()?  refreshBuyTab,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadBuyTab() when loadBuyTab != null:
return loadBuyTab();case _RefreshBuyTab() when refreshBuyTab != null:
return refreshBuyTab();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadBuyTab,required TResult Function()  refreshBuyTab,}) {final _that = this;
switch (_that) {
case _LoadBuyTab():
return loadBuyTab();case _RefreshBuyTab():
return refreshBuyTab();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadBuyTab,TResult? Function()?  refreshBuyTab,}) {final _that = this;
switch (_that) {
case _LoadBuyTab() when loadBuyTab != null:
return loadBuyTab();case _RefreshBuyTab() when refreshBuyTab != null:
return refreshBuyTab();case _:
  return null;

}
}

}

/// @nodoc


class _LoadBuyTab implements BuyTabEvent {
  const _LoadBuyTab();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadBuyTab);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BuyTabEvent.loadBuyTab()';
}


}




/// @nodoc


class _RefreshBuyTab implements BuyTabEvent {
  const _RefreshBuyTab();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshBuyTab);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BuyTabEvent.refreshBuyTab()';
}


}




/// @nodoc
mixin _$BuyTabState {

 bool get isLoading; bool get isRefreshing; List<BuyCategory> get categories; List<BuyRegular> get regulars; List<FeaturedItem> get featuredItems; List<BrandStorefront> get brandPartners; int get marketplaceListingCount; int get marketplaceSellerCount; List<String> get trendingThumbnails; bool get isOffline; DateTime? get lastSyncedAt; String? get errorMessage;
/// Create a copy of BuyTabState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyTabStateCopyWith<BuyTabState> get copyWith => _$BuyTabStateCopyWithImpl<BuyTabState>(this as BuyTabState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyTabState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.regulars, regulars)&&const DeepCollectionEquality().equals(other.featuredItems, featuredItems)&&const DeepCollectionEquality().equals(other.brandPartners, brandPartners)&&(identical(other.marketplaceListingCount, marketplaceListingCount) || other.marketplaceListingCount == marketplaceListingCount)&&(identical(other.marketplaceSellerCount, marketplaceSellerCount) || other.marketplaceSellerCount == marketplaceSellerCount)&&const DeepCollectionEquality().equals(other.trendingThumbnails, trendingThumbnails)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(regulars),const DeepCollectionEquality().hash(featuredItems),const DeepCollectionEquality().hash(brandPartners),marketplaceListingCount,marketplaceSellerCount,const DeepCollectionEquality().hash(trendingThumbnails),isOffline,lastSyncedAt,errorMessage);

@override
String toString() {
  return 'BuyTabState(isLoading: $isLoading, isRefreshing: $isRefreshing, categories: $categories, regulars: $regulars, featuredItems: $featuredItems, brandPartners: $brandPartners, marketplaceListingCount: $marketplaceListingCount, marketplaceSellerCount: $marketplaceSellerCount, trendingThumbnails: $trendingThumbnails, isOffline: $isOffline, lastSyncedAt: $lastSyncedAt, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BuyTabStateCopyWith<$Res>  {
  factory $BuyTabStateCopyWith(BuyTabState value, $Res Function(BuyTabState) _then) = _$BuyTabStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, List<BuyCategory> categories, List<BuyRegular> regulars, List<FeaturedItem> featuredItems, List<BrandStorefront> brandPartners, int marketplaceListingCount, int marketplaceSellerCount, List<String> trendingThumbnails, bool isOffline, DateTime? lastSyncedAt, String? errorMessage
});




}
/// @nodoc
class _$BuyTabStateCopyWithImpl<$Res>
    implements $BuyTabStateCopyWith<$Res> {
  _$BuyTabStateCopyWithImpl(this._self, this._then);

  final BuyTabState _self;
  final $Res Function(BuyTabState) _then;

/// Create a copy of BuyTabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? categories = null,Object? regulars = null,Object? featuredItems = null,Object? brandPartners = null,Object? marketplaceListingCount = null,Object? marketplaceSellerCount = null,Object? trendingThumbnails = null,Object? isOffline = null,Object? lastSyncedAt = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<BuyCategory>,regulars: null == regulars ? _self.regulars : regulars // ignore: cast_nullable_to_non_nullable
as List<BuyRegular>,featuredItems: null == featuredItems ? _self.featuredItems : featuredItems // ignore: cast_nullable_to_non_nullable
as List<FeaturedItem>,brandPartners: null == brandPartners ? _self.brandPartners : brandPartners // ignore: cast_nullable_to_non_nullable
as List<BrandStorefront>,marketplaceListingCount: null == marketplaceListingCount ? _self.marketplaceListingCount : marketplaceListingCount // ignore: cast_nullable_to_non_nullable
as int,marketplaceSellerCount: null == marketplaceSellerCount ? _self.marketplaceSellerCount : marketplaceSellerCount // ignore: cast_nullable_to_non_nullable
as int,trendingThumbnails: null == trendingThumbnails ? _self.trendingThumbnails : trendingThumbnails // ignore: cast_nullable_to_non_nullable
as List<String>,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BuyTabState].
extension BuyTabStatePatterns on BuyTabState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuyTabState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuyTabState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuyTabState value)  $default,){
final _that = this;
switch (_that) {
case _BuyTabState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuyTabState value)?  $default,){
final _that = this;
switch (_that) {
case _BuyTabState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  List<BuyCategory> categories,  List<BuyRegular> regulars,  List<FeaturedItem> featuredItems,  List<BrandStorefront> brandPartners,  int marketplaceListingCount,  int marketplaceSellerCount,  List<String> trendingThumbnails,  bool isOffline,  DateTime? lastSyncedAt,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyTabState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.categories,_that.regulars,_that.featuredItems,_that.brandPartners,_that.marketplaceListingCount,_that.marketplaceSellerCount,_that.trendingThumbnails,_that.isOffline,_that.lastSyncedAt,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  List<BuyCategory> categories,  List<BuyRegular> regulars,  List<FeaturedItem> featuredItems,  List<BrandStorefront> brandPartners,  int marketplaceListingCount,  int marketplaceSellerCount,  List<String> trendingThumbnails,  bool isOffline,  DateTime? lastSyncedAt,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BuyTabState():
return $default(_that.isLoading,_that.isRefreshing,_that.categories,_that.regulars,_that.featuredItems,_that.brandPartners,_that.marketplaceListingCount,_that.marketplaceSellerCount,_that.trendingThumbnails,_that.isOffline,_that.lastSyncedAt,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isRefreshing,  List<BuyCategory> categories,  List<BuyRegular> regulars,  List<FeaturedItem> featuredItems,  List<BrandStorefront> brandPartners,  int marketplaceListingCount,  int marketplaceSellerCount,  List<String> trendingThumbnails,  bool isOffline,  DateTime? lastSyncedAt,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BuyTabState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.categories,_that.regulars,_that.featuredItems,_that.brandPartners,_that.marketplaceListingCount,_that.marketplaceSellerCount,_that.trendingThumbnails,_that.isOffline,_that.lastSyncedAt,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BuyTabState implements BuyTabState {
  const _BuyTabState({this.isLoading = false, this.isRefreshing = false, final  List<BuyCategory> categories = const [], final  List<BuyRegular> regulars = const [], final  List<FeaturedItem> featuredItems = const [], final  List<BrandStorefront> brandPartners = const [], this.marketplaceListingCount = 0, this.marketplaceSellerCount = 0, final  List<String> trendingThumbnails = const [], this.isOffline = false, this.lastSyncedAt, this.errorMessage}): _categories = categories,_regulars = regulars,_featuredItems = featuredItems,_brandPartners = brandPartners,_trendingThumbnails = trendingThumbnails;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
 final  List<BuyCategory> _categories;
@override@JsonKey() List<BuyCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<BuyRegular> _regulars;
@override@JsonKey() List<BuyRegular> get regulars {
  if (_regulars is EqualUnmodifiableListView) return _regulars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regulars);
}

 final  List<FeaturedItem> _featuredItems;
@override@JsonKey() List<FeaturedItem> get featuredItems {
  if (_featuredItems is EqualUnmodifiableListView) return _featuredItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredItems);
}

 final  List<BrandStorefront> _brandPartners;
@override@JsonKey() List<BrandStorefront> get brandPartners {
  if (_brandPartners is EqualUnmodifiableListView) return _brandPartners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brandPartners);
}

@override@JsonKey() final  int marketplaceListingCount;
@override@JsonKey() final  int marketplaceSellerCount;
 final  List<String> _trendingThumbnails;
@override@JsonKey() List<String> get trendingThumbnails {
  if (_trendingThumbnails is EqualUnmodifiableListView) return _trendingThumbnails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trendingThumbnails);
}

@override@JsonKey() final  bool isOffline;
@override final  DateTime? lastSyncedAt;
@override final  String? errorMessage;

/// Create a copy of BuyTabState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyTabStateCopyWith<_BuyTabState> get copyWith => __$BuyTabStateCopyWithImpl<_BuyTabState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyTabState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._regulars, _regulars)&&const DeepCollectionEquality().equals(other._featuredItems, _featuredItems)&&const DeepCollectionEquality().equals(other._brandPartners, _brandPartners)&&(identical(other.marketplaceListingCount, marketplaceListingCount) || other.marketplaceListingCount == marketplaceListingCount)&&(identical(other.marketplaceSellerCount, marketplaceSellerCount) || other.marketplaceSellerCount == marketplaceSellerCount)&&const DeepCollectionEquality().equals(other._trendingThumbnails, _trendingThumbnails)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_regulars),const DeepCollectionEquality().hash(_featuredItems),const DeepCollectionEquality().hash(_brandPartners),marketplaceListingCount,marketplaceSellerCount,const DeepCollectionEquality().hash(_trendingThumbnails),isOffline,lastSyncedAt,errorMessage);

@override
String toString() {
  return 'BuyTabState(isLoading: $isLoading, isRefreshing: $isRefreshing, categories: $categories, regulars: $regulars, featuredItems: $featuredItems, brandPartners: $brandPartners, marketplaceListingCount: $marketplaceListingCount, marketplaceSellerCount: $marketplaceSellerCount, trendingThumbnails: $trendingThumbnails, isOffline: $isOffline, lastSyncedAt: $lastSyncedAt, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BuyTabStateCopyWith<$Res> implements $BuyTabStateCopyWith<$Res> {
  factory _$BuyTabStateCopyWith(_BuyTabState value, $Res Function(_BuyTabState) _then) = __$BuyTabStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, List<BuyCategory> categories, List<BuyRegular> regulars, List<FeaturedItem> featuredItems, List<BrandStorefront> brandPartners, int marketplaceListingCount, int marketplaceSellerCount, List<String> trendingThumbnails, bool isOffline, DateTime? lastSyncedAt, String? errorMessage
});




}
/// @nodoc
class __$BuyTabStateCopyWithImpl<$Res>
    implements _$BuyTabStateCopyWith<$Res> {
  __$BuyTabStateCopyWithImpl(this._self, this._then);

  final _BuyTabState _self;
  final $Res Function(_BuyTabState) _then;

/// Create a copy of BuyTabState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? categories = null,Object? regulars = null,Object? featuredItems = null,Object? brandPartners = null,Object? marketplaceListingCount = null,Object? marketplaceSellerCount = null,Object? trendingThumbnails = null,Object? isOffline = null,Object? lastSyncedAt = freezed,Object? errorMessage = freezed,}) {
  return _then(_BuyTabState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<BuyCategory>,regulars: null == regulars ? _self._regulars : regulars // ignore: cast_nullable_to_non_nullable
as List<BuyRegular>,featuredItems: null == featuredItems ? _self._featuredItems : featuredItems // ignore: cast_nullable_to_non_nullable
as List<FeaturedItem>,brandPartners: null == brandPartners ? _self._brandPartners : brandPartners // ignore: cast_nullable_to_non_nullable
as List<BrandStorefront>,marketplaceListingCount: null == marketplaceListingCount ? _self.marketplaceListingCount : marketplaceListingCount // ignore: cast_nullable_to_non_nullable
as int,marketplaceSellerCount: null == marketplaceSellerCount ? _self.marketplaceSellerCount : marketplaceSellerCount // ignore: cast_nullable_to_non_nullable
as int,trendingThumbnails: null == trendingThumbnails ? _self._trendingThumbnails : trendingThumbnails // ignore: cast_nullable_to_non_nullable
as List<String>,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
