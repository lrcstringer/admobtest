// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RewardEvent()';
}


}

/// @nodoc
class $RewardEventCopyWith<$Res>  {
$RewardEventCopyWith(RewardEvent _, $Res Function(RewardEvent) __);
}


/// Adds pattern-matching-related methods to [RewardEvent].
extension RewardEventPatterns on RewardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadItems value)?  loadItems,TResult Function( _LoadItemDetail value)?  loadItemDetail,TResult Function( _RedeemItem value)?  redeemItem,TResult Function( _RefreshItems value)?  refreshItems,TResult Function( _ClearSelectedItem value)?  clearSelectedItem,TResult Function( _ClearMessages value)?  clearMessages,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadItems() when loadItems != null:
return loadItems(_that);case _LoadItemDetail() when loadItemDetail != null:
return loadItemDetail(_that);case _RedeemItem() when redeemItem != null:
return redeemItem(_that);case _RefreshItems() when refreshItems != null:
return refreshItems(_that);case _ClearSelectedItem() when clearSelectedItem != null:
return clearSelectedItem(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadItems value)  loadItems,required TResult Function( _LoadItemDetail value)  loadItemDetail,required TResult Function( _RedeemItem value)  redeemItem,required TResult Function( _RefreshItems value)  refreshItems,required TResult Function( _ClearSelectedItem value)  clearSelectedItem,required TResult Function( _ClearMessages value)  clearMessages,}){
final _that = this;
switch (_that) {
case _LoadItems():
return loadItems(_that);case _LoadItemDetail():
return loadItemDetail(_that);case _RedeemItem():
return redeemItem(_that);case _RefreshItems():
return refreshItems(_that);case _ClearSelectedItem():
return clearSelectedItem(_that);case _ClearMessages():
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadItems value)?  loadItems,TResult? Function( _LoadItemDetail value)?  loadItemDetail,TResult? Function( _RedeemItem value)?  redeemItem,TResult? Function( _RefreshItems value)?  refreshItems,TResult? Function( _ClearSelectedItem value)?  clearSelectedItem,TResult? Function( _ClearMessages value)?  clearMessages,}){
final _that = this;
switch (_that) {
case _LoadItems() when loadItems != null:
return loadItems(_that);case _LoadItemDetail() when loadItemDetail != null:
return loadItemDetail(_that);case _RedeemItem() when redeemItem != null:
return redeemItem(_that);case _RefreshItems() when refreshItems != null:
return refreshItems(_that);case _ClearSelectedItem() when clearSelectedItem != null:
return clearSelectedItem(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadItems,TResult Function( String itemId)?  loadItemDetail,TResult Function( String itemId,  String? location)?  redeemItem,TResult Function()?  refreshItems,TResult Function()?  clearSelectedItem,TResult Function()?  clearMessages,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadItems() when loadItems != null:
return loadItems();case _LoadItemDetail() when loadItemDetail != null:
return loadItemDetail(_that.itemId);case _RedeemItem() when redeemItem != null:
return redeemItem(_that.itemId,_that.location);case _RefreshItems() when refreshItems != null:
return refreshItems();case _ClearSelectedItem() when clearSelectedItem != null:
return clearSelectedItem();case _ClearMessages() when clearMessages != null:
return clearMessages();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadItems,required TResult Function( String itemId)  loadItemDetail,required TResult Function( String itemId,  String? location)  redeemItem,required TResult Function()  refreshItems,required TResult Function()  clearSelectedItem,required TResult Function()  clearMessages,}) {final _that = this;
switch (_that) {
case _LoadItems():
return loadItems();case _LoadItemDetail():
return loadItemDetail(_that.itemId);case _RedeemItem():
return redeemItem(_that.itemId,_that.location);case _RefreshItems():
return refreshItems();case _ClearSelectedItem():
return clearSelectedItem();case _ClearMessages():
return clearMessages();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadItems,TResult? Function( String itemId)?  loadItemDetail,TResult? Function( String itemId,  String? location)?  redeemItem,TResult? Function()?  refreshItems,TResult? Function()?  clearSelectedItem,TResult? Function()?  clearMessages,}) {final _that = this;
switch (_that) {
case _LoadItems() when loadItems != null:
return loadItems();case _LoadItemDetail() when loadItemDetail != null:
return loadItemDetail(_that.itemId);case _RedeemItem() when redeemItem != null:
return redeemItem(_that.itemId,_that.location);case _RefreshItems() when refreshItems != null:
return refreshItems();case _ClearSelectedItem() when clearSelectedItem != null:
return clearSelectedItem();case _ClearMessages() when clearMessages != null:
return clearMessages();case _:
  return null;

}
}

}

/// @nodoc


class _LoadItems implements RewardEvent {
  const _LoadItems();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadItems);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RewardEvent.loadItems()';
}


}




/// @nodoc


class _LoadItemDetail implements RewardEvent {
  const _LoadItemDetail(this.itemId);
  

 final  String itemId;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadItemDetailCopyWith<_LoadItemDetail> get copyWith => __$LoadItemDetailCopyWithImpl<_LoadItemDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadItemDetail&&(identical(other.itemId, itemId) || other.itemId == itemId));
}


@override
int get hashCode => Object.hash(runtimeType,itemId);

@override
String toString() {
  return 'RewardEvent.loadItemDetail(itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class _$LoadItemDetailCopyWith<$Res> implements $RewardEventCopyWith<$Res> {
  factory _$LoadItemDetailCopyWith(_LoadItemDetail value, $Res Function(_LoadItemDetail) _then) = __$LoadItemDetailCopyWithImpl;
@useResult
$Res call({
 String itemId
});




}
/// @nodoc
class __$LoadItemDetailCopyWithImpl<$Res>
    implements _$LoadItemDetailCopyWith<$Res> {
  __$LoadItemDetailCopyWithImpl(this._self, this._then);

  final _LoadItemDetail _self;
  final $Res Function(_LoadItemDetail) _then;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemId = null,}) {
  return _then(_LoadItemDetail(
null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RedeemItem implements RewardEvent {
  const _RedeemItem(this.itemId, {this.location});
  

 final  String itemId;
 final  String? location;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedeemItemCopyWith<_RedeemItem> get copyWith => __$RedeemItemCopyWithImpl<_RedeemItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedeemItem&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,location);

@override
String toString() {
  return 'RewardEvent.redeemItem(itemId: $itemId, location: $location)';
}


}

/// @nodoc
abstract mixin class _$RedeemItemCopyWith<$Res> implements $RewardEventCopyWith<$Res> {
  factory _$RedeemItemCopyWith(_RedeemItem value, $Res Function(_RedeemItem) _then) = __$RedeemItemCopyWithImpl;
@useResult
$Res call({
 String itemId, String? location
});




}
/// @nodoc
class __$RedeemItemCopyWithImpl<$Res>
    implements _$RedeemItemCopyWith<$Res> {
  __$RedeemItemCopyWithImpl(this._self, this._then);

  final _RedeemItem _self;
  final $Res Function(_RedeemItem) _then;

/// Create a copy of RewardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? location = freezed,}) {
  return _then(_RedeemItem(
null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshItems implements RewardEvent {
  const _RefreshItems();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshItems);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RewardEvent.refreshItems()';
}


}




/// @nodoc


class _ClearSelectedItem implements RewardEvent {
  const _ClearSelectedItem();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSelectedItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RewardEvent.clearSelectedItem()';
}


}




/// @nodoc


class _ClearMessages implements RewardEvent {
  const _ClearMessages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearMessages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RewardEvent.clearMessages()';
}


}




/// @nodoc
mixin _$RewardState {

 List<RewardItem> get items; RewardItem? get selectedItem; RewardLoadStatus get status; RewardLoadStatus get detailStatus; RewardLoadStatus get redeemStatus; String? get errorMessage; String? get successMessage;
/// Create a copy of RewardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardStateCopyWith<RewardState> get copyWith => _$RewardStateCopyWithImpl<RewardState>(this as RewardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.selectedItem, selectedItem) || other.selectedItem == selectedItem)&&(identical(other.status, status) || other.status == status)&&(identical(other.detailStatus, detailStatus) || other.detailStatus == detailStatus)&&(identical(other.redeemStatus, redeemStatus) || other.redeemStatus == redeemStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),selectedItem,status,detailStatus,redeemStatus,errorMessage,successMessage);

@override
String toString() {
  return 'RewardState(items: $items, selectedItem: $selectedItem, status: $status, detailStatus: $detailStatus, redeemStatus: $redeemStatus, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $RewardStateCopyWith<$Res>  {
  factory $RewardStateCopyWith(RewardState value, $Res Function(RewardState) _then) = _$RewardStateCopyWithImpl;
@useResult
$Res call({
 List<RewardItem> items, RewardItem? selectedItem, RewardLoadStatus status, RewardLoadStatus detailStatus, RewardLoadStatus redeemStatus, String? errorMessage, String? successMessage
});


$RewardItemCopyWith<$Res>? get selectedItem;

}
/// @nodoc
class _$RewardStateCopyWithImpl<$Res>
    implements $RewardStateCopyWith<$Res> {
  _$RewardStateCopyWithImpl(this._self, this._then);

  final RewardState _self;
  final $Res Function(RewardState) _then;

/// Create a copy of RewardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? selectedItem = freezed,Object? status = null,Object? detailStatus = null,Object? redeemStatus = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RewardItem>,selectedItem: freezed == selectedItem ? _self.selectedItem : selectedItem // ignore: cast_nullable_to_non_nullable
as RewardItem?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RewardLoadStatus,detailStatus: null == detailStatus ? _self.detailStatus : detailStatus // ignore: cast_nullable_to_non_nullable
as RewardLoadStatus,redeemStatus: null == redeemStatus ? _self.redeemStatus : redeemStatus // ignore: cast_nullable_to_non_nullable
as RewardLoadStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RewardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardItemCopyWith<$Res>? get selectedItem {
    if (_self.selectedItem == null) {
    return null;
  }

  return $RewardItemCopyWith<$Res>(_self.selectedItem!, (value) {
    return _then(_self.copyWith(selectedItem: value));
  });
}
}


/// Adds pattern-matching-related methods to [RewardState].
extension RewardStatePatterns on RewardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardState value)  $default,){
final _that = this;
switch (_that) {
case _RewardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardState value)?  $default,){
final _that = this;
switch (_that) {
case _RewardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RewardItem> items,  RewardItem? selectedItem,  RewardLoadStatus status,  RewardLoadStatus detailStatus,  RewardLoadStatus redeemStatus,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardState() when $default != null:
return $default(_that.items,_that.selectedItem,_that.status,_that.detailStatus,_that.redeemStatus,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RewardItem> items,  RewardItem? selectedItem,  RewardLoadStatus status,  RewardLoadStatus detailStatus,  RewardLoadStatus redeemStatus,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _RewardState():
return $default(_that.items,_that.selectedItem,_that.status,_that.detailStatus,_that.redeemStatus,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RewardItem> items,  RewardItem? selectedItem,  RewardLoadStatus status,  RewardLoadStatus detailStatus,  RewardLoadStatus redeemStatus,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _RewardState() when $default != null:
return $default(_that.items,_that.selectedItem,_that.status,_that.detailStatus,_that.redeemStatus,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _RewardState extends RewardState {
  const _RewardState({final  List<RewardItem> items = const [], this.selectedItem, this.status = RewardLoadStatus.initial, this.detailStatus = RewardLoadStatus.initial, this.redeemStatus = RewardLoadStatus.initial, this.errorMessage, this.successMessage}): _items = items,super._();
  

 final  List<RewardItem> _items;
@override@JsonKey() List<RewardItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  RewardItem? selectedItem;
@override@JsonKey() final  RewardLoadStatus status;
@override@JsonKey() final  RewardLoadStatus detailStatus;
@override@JsonKey() final  RewardLoadStatus redeemStatus;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of RewardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardStateCopyWith<_RewardState> get copyWith => __$RewardStateCopyWithImpl<_RewardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.selectedItem, selectedItem) || other.selectedItem == selectedItem)&&(identical(other.status, status) || other.status == status)&&(identical(other.detailStatus, detailStatus) || other.detailStatus == detailStatus)&&(identical(other.redeemStatus, redeemStatus) || other.redeemStatus == redeemStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),selectedItem,status,detailStatus,redeemStatus,errorMessage,successMessage);

@override
String toString() {
  return 'RewardState(items: $items, selectedItem: $selectedItem, status: $status, detailStatus: $detailStatus, redeemStatus: $redeemStatus, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$RewardStateCopyWith<$Res> implements $RewardStateCopyWith<$Res> {
  factory _$RewardStateCopyWith(_RewardState value, $Res Function(_RewardState) _then) = __$RewardStateCopyWithImpl;
@override @useResult
$Res call({
 List<RewardItem> items, RewardItem? selectedItem, RewardLoadStatus status, RewardLoadStatus detailStatus, RewardLoadStatus redeemStatus, String? errorMessage, String? successMessage
});


@override $RewardItemCopyWith<$Res>? get selectedItem;

}
/// @nodoc
class __$RewardStateCopyWithImpl<$Res>
    implements _$RewardStateCopyWith<$Res> {
  __$RewardStateCopyWithImpl(this._self, this._then);

  final _RewardState _self;
  final $Res Function(_RewardState) _then;

/// Create a copy of RewardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? selectedItem = freezed,Object? status = null,Object? detailStatus = null,Object? redeemStatus = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_RewardState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RewardItem>,selectedItem: freezed == selectedItem ? _self.selectedItem : selectedItem // ignore: cast_nullable_to_non_nullable
as RewardItem?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RewardLoadStatus,detailStatus: null == detailStatus ? _self.detailStatus : detailStatus // ignore: cast_nullable_to_non_nullable
as RewardLoadStatus,redeemStatus: null == redeemStatus ? _self.redeemStatus : redeemStatus // ignore: cast_nullable_to_non_nullable
as RewardLoadStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RewardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardItemCopyWith<$Res>? get selectedItem {
    if (_self.selectedItem == null) {
    return null;
  }

  return $RewardItemCopyWith<$Res>(_self.selectedItem!, (value) {
    return _then(_self.copyWith(selectedItem: value));
  });
}
}

// dart format on
