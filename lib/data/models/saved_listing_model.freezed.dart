// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedListingModel {

 String get listingId; DateTime get savedAt; String? get listingTitle; int? get listingPrice; String? get listingThumbnailUrl; String? get listingStatus; String? get sellerName;
/// Create a copy of SavedListingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedListingModelCopyWith<SavedListingModel> get copyWith => _$SavedListingModelCopyWithImpl<SavedListingModel>(this as SavedListingModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedListingModel&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.listingPrice, listingPrice) || other.listingPrice == listingPrice)&&(identical(other.listingThumbnailUrl, listingThumbnailUrl) || other.listingThumbnailUrl == listingThumbnailUrl)&&(identical(other.listingStatus, listingStatus) || other.listingStatus == listingStatus)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,savedAt,listingTitle,listingPrice,listingThumbnailUrl,listingStatus,sellerName);

@override
String toString() {
  return 'SavedListingModel(listingId: $listingId, savedAt: $savedAt, listingTitle: $listingTitle, listingPrice: $listingPrice, listingThumbnailUrl: $listingThumbnailUrl, listingStatus: $listingStatus, sellerName: $sellerName)';
}


}

/// @nodoc
abstract mixin class $SavedListingModelCopyWith<$Res>  {
  factory $SavedListingModelCopyWith(SavedListingModel value, $Res Function(SavedListingModel) _then) = _$SavedListingModelCopyWithImpl;
@useResult
$Res call({
 String listingId, DateTime savedAt, String? listingTitle, int? listingPrice, String? listingThumbnailUrl, String? listingStatus, String? sellerName
});




}
/// @nodoc
class _$SavedListingModelCopyWithImpl<$Res>
    implements $SavedListingModelCopyWith<$Res> {
  _$SavedListingModelCopyWithImpl(this._self, this._then);

  final SavedListingModel _self;
  final $Res Function(SavedListingModel) _then;

/// Create a copy of SavedListingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listingId = null,Object? savedAt = null,Object? listingTitle = freezed,Object? listingPrice = freezed,Object? listingThumbnailUrl = freezed,Object? listingStatus = freezed,Object? sellerName = freezed,}) {
  return _then(_self.copyWith(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,listingTitle: freezed == listingTitle ? _self.listingTitle : listingTitle // ignore: cast_nullable_to_non_nullable
as String?,listingPrice: freezed == listingPrice ? _self.listingPrice : listingPrice // ignore: cast_nullable_to_non_nullable
as int?,listingThumbnailUrl: freezed == listingThumbnailUrl ? _self.listingThumbnailUrl : listingThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,listingStatus: freezed == listingStatus ? _self.listingStatus : listingStatus // ignore: cast_nullable_to_non_nullable
as String?,sellerName: freezed == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedListingModel].
extension SavedListingModelPatterns on SavedListingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedListingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedListingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedListingModel value)  $default,){
final _that = this;
switch (_that) {
case _SavedListingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedListingModel value)?  $default,){
final _that = this;
switch (_that) {
case _SavedListingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String listingId,  DateTime savedAt,  String? listingTitle,  int? listingPrice,  String? listingThumbnailUrl,  String? listingStatus,  String? sellerName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedListingModel() when $default != null:
return $default(_that.listingId,_that.savedAt,_that.listingTitle,_that.listingPrice,_that.listingThumbnailUrl,_that.listingStatus,_that.sellerName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String listingId,  DateTime savedAt,  String? listingTitle,  int? listingPrice,  String? listingThumbnailUrl,  String? listingStatus,  String? sellerName)  $default,) {final _that = this;
switch (_that) {
case _SavedListingModel():
return $default(_that.listingId,_that.savedAt,_that.listingTitle,_that.listingPrice,_that.listingThumbnailUrl,_that.listingStatus,_that.sellerName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String listingId,  DateTime savedAt,  String? listingTitle,  int? listingPrice,  String? listingThumbnailUrl,  String? listingStatus,  String? sellerName)?  $default,) {final _that = this;
switch (_that) {
case _SavedListingModel() when $default != null:
return $default(_that.listingId,_that.savedAt,_that.listingTitle,_that.listingPrice,_that.listingThumbnailUrl,_that.listingStatus,_that.sellerName);case _:
  return null;

}
}

}

/// @nodoc


class _SavedListingModel extends SavedListingModel {
  const _SavedListingModel({required this.listingId, required this.savedAt, this.listingTitle, this.listingPrice, this.listingThumbnailUrl, this.listingStatus, this.sellerName}): super._();
  

@override final  String listingId;
@override final  DateTime savedAt;
@override final  String? listingTitle;
@override final  int? listingPrice;
@override final  String? listingThumbnailUrl;
@override final  String? listingStatus;
@override final  String? sellerName;

/// Create a copy of SavedListingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedListingModelCopyWith<_SavedListingModel> get copyWith => __$SavedListingModelCopyWithImpl<_SavedListingModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedListingModel&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.listingPrice, listingPrice) || other.listingPrice == listingPrice)&&(identical(other.listingThumbnailUrl, listingThumbnailUrl) || other.listingThumbnailUrl == listingThumbnailUrl)&&(identical(other.listingStatus, listingStatus) || other.listingStatus == listingStatus)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,savedAt,listingTitle,listingPrice,listingThumbnailUrl,listingStatus,sellerName);

@override
String toString() {
  return 'SavedListingModel(listingId: $listingId, savedAt: $savedAt, listingTitle: $listingTitle, listingPrice: $listingPrice, listingThumbnailUrl: $listingThumbnailUrl, listingStatus: $listingStatus, sellerName: $sellerName)';
}


}

/// @nodoc
abstract mixin class _$SavedListingModelCopyWith<$Res> implements $SavedListingModelCopyWith<$Res> {
  factory _$SavedListingModelCopyWith(_SavedListingModel value, $Res Function(_SavedListingModel) _then) = __$SavedListingModelCopyWithImpl;
@override @useResult
$Res call({
 String listingId, DateTime savedAt, String? listingTitle, int? listingPrice, String? listingThumbnailUrl, String? listingStatus, String? sellerName
});




}
/// @nodoc
class __$SavedListingModelCopyWithImpl<$Res>
    implements _$SavedListingModelCopyWith<$Res> {
  __$SavedListingModelCopyWithImpl(this._self, this._then);

  final _SavedListingModel _self;
  final $Res Function(_SavedListingModel) _then;

/// Create a copy of SavedListingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? savedAt = null,Object? listingTitle = freezed,Object? listingPrice = freezed,Object? listingThumbnailUrl = freezed,Object? listingStatus = freezed,Object? sellerName = freezed,}) {
  return _then(_SavedListingModel(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,listingTitle: freezed == listingTitle ? _self.listingTitle : listingTitle // ignore: cast_nullable_to_non_nullable
as String?,listingPrice: freezed == listingPrice ? _self.listingPrice : listingPrice // ignore: cast_nullable_to_non_nullable
as int?,listingThumbnailUrl: freezed == listingThumbnailUrl ? _self.listingThumbnailUrl : listingThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,listingStatus: freezed == listingStatus ? _self.listingStatus : listingStatus // ignore: cast_nullable_to_non_nullable
as String?,sellerName: freezed == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
