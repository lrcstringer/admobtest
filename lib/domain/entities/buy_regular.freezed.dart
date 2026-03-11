// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_regular.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BuyRegular {

 String get id; String get providerId; String get productId; String get providerName; String get productName; String get recipientNumber; String? get recipientLabel; bool get isPinned; int get usageCount; DateTime get lastUsedAt;/// Emoji from the category for display in the dock chip
 String? get categoryEmoji;/// Purchase category mapping for routing
 String? get purchaseCategoryMapping;
/// Create a copy of BuyRegular
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyRegularCopyWith<BuyRegular> get copyWith => _$BuyRegularCopyWithImpl<BuyRegular>(this as BuyRegular, _$identity);

  /// Serializes this BuyRegular to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyRegular&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.recipientNumber, recipientNumber) || other.recipientNumber == recipientNumber)&&(identical(other.recipientLabel, recipientLabel) || other.recipientLabel == recipientLabel)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.categoryEmoji, categoryEmoji) || other.categoryEmoji == categoryEmoji)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,providerId,productId,providerName,productName,recipientNumber,recipientLabel,isPinned,usageCount,lastUsedAt,categoryEmoji,purchaseCategoryMapping);

@override
String toString() {
  return 'BuyRegular(id: $id, providerId: $providerId, productId: $productId, providerName: $providerName, productName: $productName, recipientNumber: $recipientNumber, recipientLabel: $recipientLabel, isPinned: $isPinned, usageCount: $usageCount, lastUsedAt: $lastUsedAt, categoryEmoji: $categoryEmoji, purchaseCategoryMapping: $purchaseCategoryMapping)';
}


}

/// @nodoc
abstract mixin class $BuyRegularCopyWith<$Res>  {
  factory $BuyRegularCopyWith(BuyRegular value, $Res Function(BuyRegular) _then) = _$BuyRegularCopyWithImpl;
@useResult
$Res call({
 String id, String providerId, String productId, String providerName, String productName, String recipientNumber, String? recipientLabel, bool isPinned, int usageCount, DateTime lastUsedAt, String? categoryEmoji, String? purchaseCategoryMapping
});




}
/// @nodoc
class _$BuyRegularCopyWithImpl<$Res>
    implements $BuyRegularCopyWith<$Res> {
  _$BuyRegularCopyWithImpl(this._self, this._then);

  final BuyRegular _self;
  final $Res Function(BuyRegular) _then;

/// Create a copy of BuyRegular
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerId = null,Object? productId = null,Object? providerName = null,Object? productName = null,Object? recipientNumber = null,Object? recipientLabel = freezed,Object? isPinned = null,Object? usageCount = null,Object? lastUsedAt = null,Object? categoryEmoji = freezed,Object? purchaseCategoryMapping = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,recipientNumber: null == recipientNumber ? _self.recipientNumber : recipientNumber // ignore: cast_nullable_to_non_nullable
as String,recipientLabel: freezed == recipientLabel ? _self.recipientLabel : recipientLabel // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,lastUsedAt: null == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categoryEmoji: freezed == categoryEmoji ? _self.categoryEmoji : categoryEmoji // ignore: cast_nullable_to_non_nullable
as String?,purchaseCategoryMapping: freezed == purchaseCategoryMapping ? _self.purchaseCategoryMapping : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BuyRegular].
extension BuyRegularPatterns on BuyRegular {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuyRegular value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuyRegular() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuyRegular value)  $default,){
final _that = this;
switch (_that) {
case _BuyRegular():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuyRegular value)?  $default,){
final _that = this;
switch (_that) {
case _BuyRegular() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String providerId,  String productId,  String providerName,  String productName,  String recipientNumber,  String? recipientLabel,  bool isPinned,  int usageCount,  DateTime lastUsedAt,  String? categoryEmoji,  String? purchaseCategoryMapping)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyRegular() when $default != null:
return $default(_that.id,_that.providerId,_that.productId,_that.providerName,_that.productName,_that.recipientNumber,_that.recipientLabel,_that.isPinned,_that.usageCount,_that.lastUsedAt,_that.categoryEmoji,_that.purchaseCategoryMapping);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String providerId,  String productId,  String providerName,  String productName,  String recipientNumber,  String? recipientLabel,  bool isPinned,  int usageCount,  DateTime lastUsedAt,  String? categoryEmoji,  String? purchaseCategoryMapping)  $default,) {final _that = this;
switch (_that) {
case _BuyRegular():
return $default(_that.id,_that.providerId,_that.productId,_that.providerName,_that.productName,_that.recipientNumber,_that.recipientLabel,_that.isPinned,_that.usageCount,_that.lastUsedAt,_that.categoryEmoji,_that.purchaseCategoryMapping);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String providerId,  String productId,  String providerName,  String productName,  String recipientNumber,  String? recipientLabel,  bool isPinned,  int usageCount,  DateTime lastUsedAt,  String? categoryEmoji,  String? purchaseCategoryMapping)?  $default,) {final _that = this;
switch (_that) {
case _BuyRegular() when $default != null:
return $default(_that.id,_that.providerId,_that.productId,_that.providerName,_that.productName,_that.recipientNumber,_that.recipientLabel,_that.isPinned,_that.usageCount,_that.lastUsedAt,_that.categoryEmoji,_that.purchaseCategoryMapping);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuyRegular extends BuyRegular {
  const _BuyRegular({required this.id, required this.providerId, required this.productId, required this.providerName, required this.productName, required this.recipientNumber, this.recipientLabel, this.isPinned = false, this.usageCount = 0, required this.lastUsedAt, this.categoryEmoji, this.purchaseCategoryMapping}): super._();
  factory _BuyRegular.fromJson(Map<String, dynamic> json) => _$BuyRegularFromJson(json);

@override final  String id;
@override final  String providerId;
@override final  String productId;
@override final  String providerName;
@override final  String productName;
@override final  String recipientNumber;
@override final  String? recipientLabel;
@override@JsonKey() final  bool isPinned;
@override@JsonKey() final  int usageCount;
@override final  DateTime lastUsedAt;
/// Emoji from the category for display in the dock chip
@override final  String? categoryEmoji;
/// Purchase category mapping for routing
@override final  String? purchaseCategoryMapping;

/// Create a copy of BuyRegular
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyRegularCopyWith<_BuyRegular> get copyWith => __$BuyRegularCopyWithImpl<_BuyRegular>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuyRegularToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyRegular&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.recipientNumber, recipientNumber) || other.recipientNumber == recipientNumber)&&(identical(other.recipientLabel, recipientLabel) || other.recipientLabel == recipientLabel)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.categoryEmoji, categoryEmoji) || other.categoryEmoji == categoryEmoji)&&(identical(other.purchaseCategoryMapping, purchaseCategoryMapping) || other.purchaseCategoryMapping == purchaseCategoryMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,providerId,productId,providerName,productName,recipientNumber,recipientLabel,isPinned,usageCount,lastUsedAt,categoryEmoji,purchaseCategoryMapping);

@override
String toString() {
  return 'BuyRegular(id: $id, providerId: $providerId, productId: $productId, providerName: $providerName, productName: $productName, recipientNumber: $recipientNumber, recipientLabel: $recipientLabel, isPinned: $isPinned, usageCount: $usageCount, lastUsedAt: $lastUsedAt, categoryEmoji: $categoryEmoji, purchaseCategoryMapping: $purchaseCategoryMapping)';
}


}

/// @nodoc
abstract mixin class _$BuyRegularCopyWith<$Res> implements $BuyRegularCopyWith<$Res> {
  factory _$BuyRegularCopyWith(_BuyRegular value, $Res Function(_BuyRegular) _then) = __$BuyRegularCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerId, String productId, String providerName, String productName, String recipientNumber, String? recipientLabel, bool isPinned, int usageCount, DateTime lastUsedAt, String? categoryEmoji, String? purchaseCategoryMapping
});




}
/// @nodoc
class __$BuyRegularCopyWithImpl<$Res>
    implements _$BuyRegularCopyWith<$Res> {
  __$BuyRegularCopyWithImpl(this._self, this._then);

  final _BuyRegular _self;
  final $Res Function(_BuyRegular) _then;

/// Create a copy of BuyRegular
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerId = null,Object? productId = null,Object? providerName = null,Object? productName = null,Object? recipientNumber = null,Object? recipientLabel = freezed,Object? isPinned = null,Object? usageCount = null,Object? lastUsedAt = null,Object? categoryEmoji = freezed,Object? purchaseCategoryMapping = freezed,}) {
  return _then(_BuyRegular(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,recipientNumber: null == recipientNumber ? _self.recipientNumber : recipientNumber // ignore: cast_nullable_to_non_nullable
as String,recipientLabel: freezed == recipientLabel ? _self.recipientLabel : recipientLabel // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,lastUsedAt: null == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categoryEmoji: freezed == categoryEmoji ? _self.categoryEmoji : categoryEmoji // ignore: cast_nullable_to_non_nullable
as String?,purchaseCategoryMapping: freezed == purchaseCategoryMapping ? _self.purchaseCategoryMapping : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
