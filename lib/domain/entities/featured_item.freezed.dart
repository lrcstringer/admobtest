// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeaturedItem {

 String get id; String get title; String? get subtitle; String? get imageUrl;/// Optional short looping video URL. When set, replaces the image on the card.
/// imageUrl still serves as poster/thumbnail while video loads.
 String? get videoUrl;/// Type: campaign, collectible, trending, promotion
 String get type;/// GoRouter deep link path (e.g. /buy/category/airtime)
 String? get deepLinkRoute; String? get brandId;/// Community IDs this item targets (empty = global)
 List<String> get communityIds; bool get isActive; int get sortOrder; DateTime? get scheduledStart; DateTime? get scheduledEnd;/// BrandGradient type name (e.g. goldOrange, cyanBlue)
 String get bgGradientType;/// Display name for the brand (e.g. "VODACOM")
 String? get brandName;/// CTA button label (e.g. "Claim with Sasaza")
 String? get ctaText;/// Custom bg color hex. Solid: '#FF6429'. Gradient: '#FFB82C,#FF6429'.
/// Only used when bgGradientType == 'custom'.
 String? get bgColorHex;/// Custom color intensity (0.0–1.0). Only when bgGradientType == 'custom'.
 double get colorIntensity;/// Image overlay opacity (0.0–1.0). Only when bgGradientType == 'custom'.
 double get imageOpacity;/// Image layout: 'full' (entire card) or 'right' (right half only).
 String get imageLayout;
/// Create a copy of FeaturedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedItemCopyWith<FeaturedItem> get copyWith => _$FeaturedItemCopyWithImpl<FeaturedItem>(this as FeaturedItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.deepLinkRoute, deepLinkRoute) || other.deepLinkRoute == deepLinkRoute)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&const DeepCollectionEquality().equals(other.communityIds, communityIds)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.scheduledStart, scheduledStart) || other.scheduledStart == scheduledStart)&&(identical(other.scheduledEnd, scheduledEnd) || other.scheduledEnd == scheduledEnd)&&(identical(other.bgGradientType, bgGradientType) || other.bgGradientType == bgGradientType)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.ctaText, ctaText) || other.ctaText == ctaText)&&(identical(other.bgColorHex, bgColorHex) || other.bgColorHex == bgColorHex)&&(identical(other.colorIntensity, colorIntensity) || other.colorIntensity == colorIntensity)&&(identical(other.imageOpacity, imageOpacity) || other.imageOpacity == imageOpacity)&&(identical(other.imageLayout, imageLayout) || other.imageLayout == imageLayout));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,subtitle,imageUrl,videoUrl,type,deepLinkRoute,brandId,const DeepCollectionEquality().hash(communityIds),isActive,sortOrder,scheduledStart,scheduledEnd,bgGradientType,brandName,ctaText,bgColorHex,colorIntensity,imageOpacity,imageLayout]);

@override
String toString() {
  return 'FeaturedItem(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, videoUrl: $videoUrl, type: $type, deepLinkRoute: $deepLinkRoute, brandId: $brandId, communityIds: $communityIds, isActive: $isActive, sortOrder: $sortOrder, scheduledStart: $scheduledStart, scheduledEnd: $scheduledEnd, bgGradientType: $bgGradientType, brandName: $brandName, ctaText: $ctaText, bgColorHex: $bgColorHex, colorIntensity: $colorIntensity, imageOpacity: $imageOpacity, imageLayout: $imageLayout)';
}


}

/// @nodoc
abstract mixin class $FeaturedItemCopyWith<$Res>  {
  factory $FeaturedItemCopyWith(FeaturedItem value, $Res Function(FeaturedItem) _then) = _$FeaturedItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? subtitle, String? imageUrl, String? videoUrl, String type, String? deepLinkRoute, String? brandId, List<String> communityIds, bool isActive, int sortOrder, DateTime? scheduledStart, DateTime? scheduledEnd, String bgGradientType, String? brandName, String? ctaText, String? bgColorHex, double colorIntensity, double imageOpacity, String imageLayout
});




}
/// @nodoc
class _$FeaturedItemCopyWithImpl<$Res>
    implements $FeaturedItemCopyWith<$Res> {
  _$FeaturedItemCopyWithImpl(this._self, this._then);

  final FeaturedItem _self;
  final $Res Function(FeaturedItem) _then;

/// Create a copy of FeaturedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = freezed,Object? imageUrl = freezed,Object? videoUrl = freezed,Object? type = null,Object? deepLinkRoute = freezed,Object? brandId = freezed,Object? communityIds = null,Object? isActive = null,Object? sortOrder = null,Object? scheduledStart = freezed,Object? scheduledEnd = freezed,Object? bgGradientType = null,Object? brandName = freezed,Object? ctaText = freezed,Object? bgColorHex = freezed,Object? colorIntensity = null,Object? imageOpacity = null,Object? imageLayout = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,deepLinkRoute: freezed == deepLinkRoute ? _self.deepLinkRoute : deepLinkRoute // ignore: cast_nullable_to_non_nullable
as String?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String?,communityIds: null == communityIds ? _self.communityIds : communityIds // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,scheduledStart: freezed == scheduledStart ? _self.scheduledStart : scheduledStart // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledEnd: freezed == scheduledEnd ? _self.scheduledEnd : scheduledEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,bgGradientType: null == bgGradientType ? _self.bgGradientType : bgGradientType // ignore: cast_nullable_to_non_nullable
as String,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,ctaText: freezed == ctaText ? _self.ctaText : ctaText // ignore: cast_nullable_to_non_nullable
as String?,bgColorHex: freezed == bgColorHex ? _self.bgColorHex : bgColorHex // ignore: cast_nullable_to_non_nullable
as String?,colorIntensity: null == colorIntensity ? _self.colorIntensity : colorIntensity // ignore: cast_nullable_to_non_nullable
as double,imageOpacity: null == imageOpacity ? _self.imageOpacity : imageOpacity // ignore: cast_nullable_to_non_nullable
as double,imageLayout: null == imageLayout ? _self.imageLayout : imageLayout // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeaturedItem].
extension FeaturedItemPatterns on FeaturedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedItem value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedItem value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? subtitle,  String? imageUrl,  String? videoUrl,  String type,  String? deepLinkRoute,  String? brandId,  List<String> communityIds,  bool isActive,  int sortOrder,  DateTime? scheduledStart,  DateTime? scheduledEnd,  String bgGradientType,  String? brandName,  String? ctaText,  String? bgColorHex,  double colorIntensity,  double imageOpacity,  String imageLayout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedItem() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.videoUrl,_that.type,_that.deepLinkRoute,_that.brandId,_that.communityIds,_that.isActive,_that.sortOrder,_that.scheduledStart,_that.scheduledEnd,_that.bgGradientType,_that.brandName,_that.ctaText,_that.bgColorHex,_that.colorIntensity,_that.imageOpacity,_that.imageLayout);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? subtitle,  String? imageUrl,  String? videoUrl,  String type,  String? deepLinkRoute,  String? brandId,  List<String> communityIds,  bool isActive,  int sortOrder,  DateTime? scheduledStart,  DateTime? scheduledEnd,  String bgGradientType,  String? brandName,  String? ctaText,  String? bgColorHex,  double colorIntensity,  double imageOpacity,  String imageLayout)  $default,) {final _that = this;
switch (_that) {
case _FeaturedItem():
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.videoUrl,_that.type,_that.deepLinkRoute,_that.brandId,_that.communityIds,_that.isActive,_that.sortOrder,_that.scheduledStart,_that.scheduledEnd,_that.bgGradientType,_that.brandName,_that.ctaText,_that.bgColorHex,_that.colorIntensity,_that.imageOpacity,_that.imageLayout);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? subtitle,  String? imageUrl,  String? videoUrl,  String type,  String? deepLinkRoute,  String? brandId,  List<String> communityIds,  bool isActive,  int sortOrder,  DateTime? scheduledStart,  DateTime? scheduledEnd,  String bgGradientType,  String? brandName,  String? ctaText,  String? bgColorHex,  double colorIntensity,  double imageOpacity,  String imageLayout)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedItem() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.videoUrl,_that.type,_that.deepLinkRoute,_that.brandId,_that.communityIds,_that.isActive,_that.sortOrder,_that.scheduledStart,_that.scheduledEnd,_that.bgGradientType,_that.brandName,_that.ctaText,_that.bgColorHex,_that.colorIntensity,_that.imageOpacity,_that.imageLayout);case _:
  return null;

}
}

}

/// @nodoc


class _FeaturedItem extends FeaturedItem {
  const _FeaturedItem({required this.id, required this.title, this.subtitle, this.imageUrl, this.videoUrl, this.type = 'campaign', this.deepLinkRoute, this.brandId, final  List<String> communityIds = const [], this.isActive = true, this.sortOrder = 0, this.scheduledStart, this.scheduledEnd, this.bgGradientType = 'goldOrange', this.brandName, this.ctaText, this.bgColorHex, this.colorIntensity = 0.4, this.imageOpacity = 0.3, this.imageLayout = 'right'}): _communityIds = communityIds,super._();
  

@override final  String id;
@override final  String title;
@override final  String? subtitle;
@override final  String? imageUrl;
/// Optional short looping video URL. When set, replaces the image on the card.
/// imageUrl still serves as poster/thumbnail while video loads.
@override final  String? videoUrl;
/// Type: campaign, collectible, trending, promotion
@override@JsonKey() final  String type;
/// GoRouter deep link path (e.g. /buy/category/airtime)
@override final  String? deepLinkRoute;
@override final  String? brandId;
/// Community IDs this item targets (empty = global)
 final  List<String> _communityIds;
/// Community IDs this item targets (empty = global)
@override@JsonKey() List<String> get communityIds {
  if (_communityIds is EqualUnmodifiableListView) return _communityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communityIds);
}

@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int sortOrder;
@override final  DateTime? scheduledStart;
@override final  DateTime? scheduledEnd;
/// BrandGradient type name (e.g. goldOrange, cyanBlue)
@override@JsonKey() final  String bgGradientType;
/// Display name for the brand (e.g. "VODACOM")
@override final  String? brandName;
/// CTA button label (e.g. "Claim with Sasaza")
@override final  String? ctaText;
/// Custom bg color hex. Solid: '#FF6429'. Gradient: '#FFB82C,#FF6429'.
/// Only used when bgGradientType == 'custom'.
@override final  String? bgColorHex;
/// Custom color intensity (0.0–1.0). Only when bgGradientType == 'custom'.
@override@JsonKey() final  double colorIntensity;
/// Image overlay opacity (0.0–1.0). Only when bgGradientType == 'custom'.
@override@JsonKey() final  double imageOpacity;
/// Image layout: 'full' (entire card) or 'right' (right half only).
@override@JsonKey() final  String imageLayout;

/// Create a copy of FeaturedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedItemCopyWith<_FeaturedItem> get copyWith => __$FeaturedItemCopyWithImpl<_FeaturedItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.deepLinkRoute, deepLinkRoute) || other.deepLinkRoute == deepLinkRoute)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&const DeepCollectionEquality().equals(other._communityIds, _communityIds)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.scheduledStart, scheduledStart) || other.scheduledStart == scheduledStart)&&(identical(other.scheduledEnd, scheduledEnd) || other.scheduledEnd == scheduledEnd)&&(identical(other.bgGradientType, bgGradientType) || other.bgGradientType == bgGradientType)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.ctaText, ctaText) || other.ctaText == ctaText)&&(identical(other.bgColorHex, bgColorHex) || other.bgColorHex == bgColorHex)&&(identical(other.colorIntensity, colorIntensity) || other.colorIntensity == colorIntensity)&&(identical(other.imageOpacity, imageOpacity) || other.imageOpacity == imageOpacity)&&(identical(other.imageLayout, imageLayout) || other.imageLayout == imageLayout));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,subtitle,imageUrl,videoUrl,type,deepLinkRoute,brandId,const DeepCollectionEquality().hash(_communityIds),isActive,sortOrder,scheduledStart,scheduledEnd,bgGradientType,brandName,ctaText,bgColorHex,colorIntensity,imageOpacity,imageLayout]);

@override
String toString() {
  return 'FeaturedItem(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, videoUrl: $videoUrl, type: $type, deepLinkRoute: $deepLinkRoute, brandId: $brandId, communityIds: $communityIds, isActive: $isActive, sortOrder: $sortOrder, scheduledStart: $scheduledStart, scheduledEnd: $scheduledEnd, bgGradientType: $bgGradientType, brandName: $brandName, ctaText: $ctaText, bgColorHex: $bgColorHex, colorIntensity: $colorIntensity, imageOpacity: $imageOpacity, imageLayout: $imageLayout)';
}


}

/// @nodoc
abstract mixin class _$FeaturedItemCopyWith<$Res> implements $FeaturedItemCopyWith<$Res> {
  factory _$FeaturedItemCopyWith(_FeaturedItem value, $Res Function(_FeaturedItem) _then) = __$FeaturedItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? subtitle, String? imageUrl, String? videoUrl, String type, String? deepLinkRoute, String? brandId, List<String> communityIds, bool isActive, int sortOrder, DateTime? scheduledStart, DateTime? scheduledEnd, String bgGradientType, String? brandName, String? ctaText, String? bgColorHex, double colorIntensity, double imageOpacity, String imageLayout
});




}
/// @nodoc
class __$FeaturedItemCopyWithImpl<$Res>
    implements _$FeaturedItemCopyWith<$Res> {
  __$FeaturedItemCopyWithImpl(this._self, this._then);

  final _FeaturedItem _self;
  final $Res Function(_FeaturedItem) _then;

/// Create a copy of FeaturedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = freezed,Object? imageUrl = freezed,Object? videoUrl = freezed,Object? type = null,Object? deepLinkRoute = freezed,Object? brandId = freezed,Object? communityIds = null,Object? isActive = null,Object? sortOrder = null,Object? scheduledStart = freezed,Object? scheduledEnd = freezed,Object? bgGradientType = null,Object? brandName = freezed,Object? ctaText = freezed,Object? bgColorHex = freezed,Object? colorIntensity = null,Object? imageOpacity = null,Object? imageLayout = null,}) {
  return _then(_FeaturedItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,deepLinkRoute: freezed == deepLinkRoute ? _self.deepLinkRoute : deepLinkRoute // ignore: cast_nullable_to_non_nullable
as String?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String?,communityIds: null == communityIds ? _self._communityIds : communityIds // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,scheduledStart: freezed == scheduledStart ? _self.scheduledStart : scheduledStart // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledEnd: freezed == scheduledEnd ? _self.scheduledEnd : scheduledEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,bgGradientType: null == bgGradientType ? _self.bgGradientType : bgGradientType // ignore: cast_nullable_to_non_nullable
as String,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,ctaText: freezed == ctaText ? _self.ctaText : ctaText // ignore: cast_nullable_to_non_nullable
as String?,bgColorHex: freezed == bgColorHex ? _self.bgColorHex : bgColorHex // ignore: cast_nullable_to_non_nullable
as String?,colorIntensity: null == colorIntensity ? _self.colorIntensity : colorIntensity // ignore: cast_nullable_to_non_nullable
as double,imageOpacity: null == imageOpacity ? _self.imageOpacity : imageOpacity // ignore: cast_nullable_to_non_nullable
as double,imageLayout: null == imageLayout ? _self.imageLayout : imageLayout // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
