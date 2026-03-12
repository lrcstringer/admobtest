// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_dispute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketplaceDispute {

 DisputeReason get reason; String get details; List<String> get photos; String? get sellerResponse; List<String> get sellerPhotos; String? get proposedResolution; DisputeResolution? get resolution; int? get resolutionAmount; String? get resolutionNote; DateTime? get openedAt; DateTime? get sellerRespondedAt; DateTime? get resolvedAt;
/// Create a copy of MarketplaceDispute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceDisputeCopyWith<MarketplaceDispute> get copyWith => _$MarketplaceDisputeCopyWithImpl<MarketplaceDispute>(this as MarketplaceDispute, _$identity);

  /// Serializes this MarketplaceDispute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceDispute&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.sellerResponse, sellerResponse) || other.sellerResponse == sellerResponse)&&const DeepCollectionEquality().equals(other.sellerPhotos, sellerPhotos)&&(identical(other.proposedResolution, proposedResolution) || other.proposedResolution == proposedResolution)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionAmount, resolutionAmount) || other.resolutionAmount == resolutionAmount)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,details,const DeepCollectionEquality().hash(photos),sellerResponse,const DeepCollectionEquality().hash(sellerPhotos),proposedResolution,resolution,resolutionAmount,resolutionNote,openedAt,sellerRespondedAt,resolvedAt);

@override
String toString() {
  return 'MarketplaceDispute(reason: $reason, details: $details, photos: $photos, sellerResponse: $sellerResponse, sellerPhotos: $sellerPhotos, proposedResolution: $proposedResolution, resolution: $resolution, resolutionAmount: $resolutionAmount, resolutionNote: $resolutionNote, openedAt: $openedAt, sellerRespondedAt: $sellerRespondedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $MarketplaceDisputeCopyWith<$Res>  {
  factory $MarketplaceDisputeCopyWith(MarketplaceDispute value, $Res Function(MarketplaceDispute) _then) = _$MarketplaceDisputeCopyWithImpl;
@useResult
$Res call({
 DisputeReason reason, String details, List<String> photos, String? sellerResponse, List<String> sellerPhotos, String? proposedResolution, DisputeResolution? resolution, int? resolutionAmount, String? resolutionNote, DateTime? openedAt, DateTime? sellerRespondedAt, DateTime? resolvedAt
});




}
/// @nodoc
class _$MarketplaceDisputeCopyWithImpl<$Res>
    implements $MarketplaceDisputeCopyWith<$Res> {
  _$MarketplaceDisputeCopyWithImpl(this._self, this._then);

  final MarketplaceDispute _self;
  final $Res Function(MarketplaceDispute) _then;

/// Create a copy of MarketplaceDispute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,Object? details = null,Object? photos = null,Object? sellerResponse = freezed,Object? sellerPhotos = null,Object? proposedResolution = freezed,Object? resolution = freezed,Object? resolutionAmount = freezed,Object? resolutionNote = freezed,Object? openedAt = freezed,Object? sellerRespondedAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as DisputeReason,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,sellerResponse: freezed == sellerResponse ? _self.sellerResponse : sellerResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerPhotos: null == sellerPhotos ? _self.sellerPhotos : sellerPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,proposedResolution: freezed == proposedResolution ? _self.proposedResolution : proposedResolution // ignore: cast_nullable_to_non_nullable
as String?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as DisputeResolution?,resolutionAmount: freezed == resolutionAmount ? _self.resolutionAmount : resolutionAmount // ignore: cast_nullable_to_non_nullable
as int?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketplaceDispute].
extension MarketplaceDisputePatterns on MarketplaceDispute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceDispute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceDispute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceDispute value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceDispute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceDispute value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceDispute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DisputeReason reason,  String details,  List<String> photos,  String? sellerResponse,  List<String> sellerPhotos,  String? proposedResolution,  DisputeResolution? resolution,  int? resolutionAmount,  String? resolutionNote,  DateTime? openedAt,  DateTime? sellerRespondedAt,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceDispute() when $default != null:
return $default(_that.reason,_that.details,_that.photos,_that.sellerResponse,_that.sellerPhotos,_that.proposedResolution,_that.resolution,_that.resolutionAmount,_that.resolutionNote,_that.openedAt,_that.sellerRespondedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DisputeReason reason,  String details,  List<String> photos,  String? sellerResponse,  List<String> sellerPhotos,  String? proposedResolution,  DisputeResolution? resolution,  int? resolutionAmount,  String? resolutionNote,  DateTime? openedAt,  DateTime? sellerRespondedAt,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceDispute():
return $default(_that.reason,_that.details,_that.photos,_that.sellerResponse,_that.sellerPhotos,_that.proposedResolution,_that.resolution,_that.resolutionAmount,_that.resolutionNote,_that.openedAt,_that.sellerRespondedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DisputeReason reason,  String details,  List<String> photos,  String? sellerResponse,  List<String> sellerPhotos,  String? proposedResolution,  DisputeResolution? resolution,  int? resolutionAmount,  String? resolutionNote,  DateTime? openedAt,  DateTime? sellerRespondedAt,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceDispute() when $default != null:
return $default(_that.reason,_that.details,_that.photos,_that.sellerResponse,_that.sellerPhotos,_that.proposedResolution,_that.resolution,_that.resolutionAmount,_that.resolutionNote,_that.openedAt,_that.sellerRespondedAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketplaceDispute extends MarketplaceDispute {
  const _MarketplaceDispute({required this.reason, required this.details, final  List<String> photos = const [], this.sellerResponse, final  List<String> sellerPhotos = const [], this.proposedResolution, this.resolution, this.resolutionAmount, this.resolutionNote, this.openedAt, this.sellerRespondedAt, this.resolvedAt}): _photos = photos,_sellerPhotos = sellerPhotos,super._();
  factory _MarketplaceDispute.fromJson(Map<String, dynamic> json) => _$MarketplaceDisputeFromJson(json);

@override final  DisputeReason reason;
@override final  String details;
 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  String? sellerResponse;
 final  List<String> _sellerPhotos;
@override@JsonKey() List<String> get sellerPhotos {
  if (_sellerPhotos is EqualUnmodifiableListView) return _sellerPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sellerPhotos);
}

@override final  String? proposedResolution;
@override final  DisputeResolution? resolution;
@override final  int? resolutionAmount;
@override final  String? resolutionNote;
@override final  DateTime? openedAt;
@override final  DateTime? sellerRespondedAt;
@override final  DateTime? resolvedAt;

/// Create a copy of MarketplaceDispute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceDisputeCopyWith<_MarketplaceDispute> get copyWith => __$MarketplaceDisputeCopyWithImpl<_MarketplaceDispute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketplaceDisputeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceDispute&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.sellerResponse, sellerResponse) || other.sellerResponse == sellerResponse)&&const DeepCollectionEquality().equals(other._sellerPhotos, _sellerPhotos)&&(identical(other.proposedResolution, proposedResolution) || other.proposedResolution == proposedResolution)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionAmount, resolutionAmount) || other.resolutionAmount == resolutionAmount)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,details,const DeepCollectionEquality().hash(_photos),sellerResponse,const DeepCollectionEquality().hash(_sellerPhotos),proposedResolution,resolution,resolutionAmount,resolutionNote,openedAt,sellerRespondedAt,resolvedAt);

@override
String toString() {
  return 'MarketplaceDispute(reason: $reason, details: $details, photos: $photos, sellerResponse: $sellerResponse, sellerPhotos: $sellerPhotos, proposedResolution: $proposedResolution, resolution: $resolution, resolutionAmount: $resolutionAmount, resolutionNote: $resolutionNote, openedAt: $openedAt, sellerRespondedAt: $sellerRespondedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceDisputeCopyWith<$Res> implements $MarketplaceDisputeCopyWith<$Res> {
  factory _$MarketplaceDisputeCopyWith(_MarketplaceDispute value, $Res Function(_MarketplaceDispute) _then) = __$MarketplaceDisputeCopyWithImpl;
@override @useResult
$Res call({
 DisputeReason reason, String details, List<String> photos, String? sellerResponse, List<String> sellerPhotos, String? proposedResolution, DisputeResolution? resolution, int? resolutionAmount, String? resolutionNote, DateTime? openedAt, DateTime? sellerRespondedAt, DateTime? resolvedAt
});




}
/// @nodoc
class __$MarketplaceDisputeCopyWithImpl<$Res>
    implements _$MarketplaceDisputeCopyWith<$Res> {
  __$MarketplaceDisputeCopyWithImpl(this._self, this._then);

  final _MarketplaceDispute _self;
  final $Res Function(_MarketplaceDispute) _then;

/// Create a copy of MarketplaceDispute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? details = null,Object? photos = null,Object? sellerResponse = freezed,Object? sellerPhotos = null,Object? proposedResolution = freezed,Object? resolution = freezed,Object? resolutionAmount = freezed,Object? resolutionNote = freezed,Object? openedAt = freezed,Object? sellerRespondedAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_MarketplaceDispute(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as DisputeReason,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,sellerResponse: freezed == sellerResponse ? _self.sellerResponse : sellerResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerPhotos: null == sellerPhotos ? _self._sellerPhotos : sellerPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,proposedResolution: freezed == proposedResolution ? _self.proposedResolution : proposedResolution // ignore: cast_nullable_to_non_nullable
as String?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as DisputeResolution?,resolutionAmount: freezed == resolutionAmount ? _self.resolutionAmount : resolutionAmount // ignore: cast_nullable_to_non_nullable
as int?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
