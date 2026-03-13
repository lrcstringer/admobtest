// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellerDashboard {

 int get totalListings; int get activeListings; int get totalOrders; int get pendingOrders; int get completedOrders; double get totalRevenue; double get averageRating; int get totalVouches; int get totalViews;
/// Create a copy of SellerDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerDashboardCopyWith<SellerDashboard> get copyWith => _$SellerDashboardCopyWithImpl<SellerDashboard>(this as SellerDashboard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDashboard&&(identical(other.totalListings, totalListings) || other.totalListings == totalListings)&&(identical(other.activeListings, activeListings) || other.activeListings == activeListings)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.pendingOrders, pendingOrders) || other.pendingOrders == pendingOrders)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalVouches, totalVouches) || other.totalVouches == totalVouches)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}


@override
int get hashCode => Object.hash(runtimeType,totalListings,activeListings,totalOrders,pendingOrders,completedOrders,totalRevenue,averageRating,totalVouches,totalViews);

@override
String toString() {
  return 'SellerDashboard(totalListings: $totalListings, activeListings: $activeListings, totalOrders: $totalOrders, pendingOrders: $pendingOrders, completedOrders: $completedOrders, totalRevenue: $totalRevenue, averageRating: $averageRating, totalVouches: $totalVouches, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class $SellerDashboardCopyWith<$Res>  {
  factory $SellerDashboardCopyWith(SellerDashboard value, $Res Function(SellerDashboard) _then) = _$SellerDashboardCopyWithImpl;
@useResult
$Res call({
 int totalListings, int activeListings, int totalOrders, int pendingOrders, int completedOrders, double totalRevenue, double averageRating, int totalVouches, int totalViews
});




}
/// @nodoc
class _$SellerDashboardCopyWithImpl<$Res>
    implements $SellerDashboardCopyWith<$Res> {
  _$SellerDashboardCopyWithImpl(this._self, this._then);

  final SellerDashboard _self;
  final $Res Function(SellerDashboard) _then;

/// Create a copy of SellerDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalListings = null,Object? activeListings = null,Object? totalOrders = null,Object? pendingOrders = null,Object? completedOrders = null,Object? totalRevenue = null,Object? averageRating = null,Object? totalVouches = null,Object? totalViews = null,}) {
  return _then(_self.copyWith(
totalListings: null == totalListings ? _self.totalListings : totalListings // ignore: cast_nullable_to_non_nullable
as int,activeListings: null == activeListings ? _self.activeListings : activeListings // ignore: cast_nullable_to_non_nullable
as int,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,pendingOrders: null == pendingOrders ? _self.pendingOrders : pendingOrders // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalVouches: null == totalVouches ? _self.totalVouches : totalVouches // ignore: cast_nullable_to_non_nullable
as int,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SellerDashboard].
extension SellerDashboardPatterns on SellerDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SellerDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SellerDashboard value)  $default,){
final _that = this;
switch (_that) {
case _SellerDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SellerDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _SellerDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalListings,  int activeListings,  int totalOrders,  int pendingOrders,  int completedOrders,  double totalRevenue,  double averageRating,  int totalVouches,  int totalViews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerDashboard() when $default != null:
return $default(_that.totalListings,_that.activeListings,_that.totalOrders,_that.pendingOrders,_that.completedOrders,_that.totalRevenue,_that.averageRating,_that.totalVouches,_that.totalViews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalListings,  int activeListings,  int totalOrders,  int pendingOrders,  int completedOrders,  double totalRevenue,  double averageRating,  int totalVouches,  int totalViews)  $default,) {final _that = this;
switch (_that) {
case _SellerDashboard():
return $default(_that.totalListings,_that.activeListings,_that.totalOrders,_that.pendingOrders,_that.completedOrders,_that.totalRevenue,_that.averageRating,_that.totalVouches,_that.totalViews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalListings,  int activeListings,  int totalOrders,  int pendingOrders,  int completedOrders,  double totalRevenue,  double averageRating,  int totalVouches,  int totalViews)?  $default,) {final _that = this;
switch (_that) {
case _SellerDashboard() when $default != null:
return $default(_that.totalListings,_that.activeListings,_that.totalOrders,_that.pendingOrders,_that.completedOrders,_that.totalRevenue,_that.averageRating,_that.totalVouches,_that.totalViews);case _:
  return null;

}
}

}

/// @nodoc


class _SellerDashboard implements SellerDashboard {
  const _SellerDashboard({this.totalListings = 0, this.activeListings = 0, this.totalOrders = 0, this.pendingOrders = 0, this.completedOrders = 0, this.totalRevenue = 0.0, this.averageRating = 0.0, this.totalVouches = 0, this.totalViews = 0});
  

@override@JsonKey() final  int totalListings;
@override@JsonKey() final  int activeListings;
@override@JsonKey() final  int totalOrders;
@override@JsonKey() final  int pendingOrders;
@override@JsonKey() final  int completedOrders;
@override@JsonKey() final  double totalRevenue;
@override@JsonKey() final  double averageRating;
@override@JsonKey() final  int totalVouches;
@override@JsonKey() final  int totalViews;

/// Create a copy of SellerDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerDashboardCopyWith<_SellerDashboard> get copyWith => __$SellerDashboardCopyWithImpl<_SellerDashboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerDashboard&&(identical(other.totalListings, totalListings) || other.totalListings == totalListings)&&(identical(other.activeListings, activeListings) || other.activeListings == activeListings)&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.pendingOrders, pendingOrders) || other.pendingOrders == pendingOrders)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalVouches, totalVouches) || other.totalVouches == totalVouches)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}


@override
int get hashCode => Object.hash(runtimeType,totalListings,activeListings,totalOrders,pendingOrders,completedOrders,totalRevenue,averageRating,totalVouches,totalViews);

@override
String toString() {
  return 'SellerDashboard(totalListings: $totalListings, activeListings: $activeListings, totalOrders: $totalOrders, pendingOrders: $pendingOrders, completedOrders: $completedOrders, totalRevenue: $totalRevenue, averageRating: $averageRating, totalVouches: $totalVouches, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class _$SellerDashboardCopyWith<$Res> implements $SellerDashboardCopyWith<$Res> {
  factory _$SellerDashboardCopyWith(_SellerDashboard value, $Res Function(_SellerDashboard) _then) = __$SellerDashboardCopyWithImpl;
@override @useResult
$Res call({
 int totalListings, int activeListings, int totalOrders, int pendingOrders, int completedOrders, double totalRevenue, double averageRating, int totalVouches, int totalViews
});




}
/// @nodoc
class __$SellerDashboardCopyWithImpl<$Res>
    implements _$SellerDashboardCopyWith<$Res> {
  __$SellerDashboardCopyWithImpl(this._self, this._then);

  final _SellerDashboard _self;
  final $Res Function(_SellerDashboard) _then;

/// Create a copy of SellerDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalListings = null,Object? activeListings = null,Object? totalOrders = null,Object? pendingOrders = null,Object? completedOrders = null,Object? totalRevenue = null,Object? averageRating = null,Object? totalVouches = null,Object? totalViews = null,}) {
  return _then(_SellerDashboard(
totalListings: null == totalListings ? _self.totalListings : totalListings // ignore: cast_nullable_to_non_nullable
as int,activeListings: null == activeListings ? _self.activeListings : activeListings // ignore: cast_nullable_to_non_nullable
as int,totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,pendingOrders: null == pendingOrders ? _self.pendingOrders : pendingOrders // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalVouches: null == totalVouches ? _self.totalVouches : totalVouches // ignore: cast_nullable_to_non_nullable
as int,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
