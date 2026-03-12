// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiListEvent()';
}


}

/// @nodoc
class $GooiListEventCopyWith<$Res>  {
$GooiListEventCopyWith(GooiListEvent _, $Res Function(GooiListEvent) __);
}


/// Adds pattern-matching-related methods to [GooiListEvent].
extension GooiListEventPatterns on GooiListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadGroups value)?  loadGroups,TResult Function( _RefreshGroups value)?  refreshGroups,TResult Function( _FilterByStatus value)?  filterByStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadGroups() when loadGroups != null:
return loadGroups(_that);case _RefreshGroups() when refreshGroups != null:
return refreshGroups(_that);case _FilterByStatus() when filterByStatus != null:
return filterByStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadGroups value)  loadGroups,required TResult Function( _RefreshGroups value)  refreshGroups,required TResult Function( _FilterByStatus value)  filterByStatus,}){
final _that = this;
switch (_that) {
case _LoadGroups():
return loadGroups(_that);case _RefreshGroups():
return refreshGroups(_that);case _FilterByStatus():
return filterByStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadGroups value)?  loadGroups,TResult? Function( _RefreshGroups value)?  refreshGroups,TResult? Function( _FilterByStatus value)?  filterByStatus,}){
final _that = this;
switch (_that) {
case _LoadGroups() when loadGroups != null:
return loadGroups(_that);case _RefreshGroups() when refreshGroups != null:
return refreshGroups(_that);case _FilterByStatus() when filterByStatus != null:
return filterByStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadGroups,TResult Function()?  refreshGroups,TResult Function( GooiGroupStatus? status)?  filterByStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadGroups() when loadGroups != null:
return loadGroups();case _RefreshGroups() when refreshGroups != null:
return refreshGroups();case _FilterByStatus() when filterByStatus != null:
return filterByStatus(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadGroups,required TResult Function()  refreshGroups,required TResult Function( GooiGroupStatus? status)  filterByStatus,}) {final _that = this;
switch (_that) {
case _LoadGroups():
return loadGroups();case _RefreshGroups():
return refreshGroups();case _FilterByStatus():
return filterByStatus(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadGroups,TResult? Function()?  refreshGroups,TResult? Function( GooiGroupStatus? status)?  filterByStatus,}) {final _that = this;
switch (_that) {
case _LoadGroups() when loadGroups != null:
return loadGroups();case _RefreshGroups() when refreshGroups != null:
return refreshGroups();case _FilterByStatus() when filterByStatus != null:
return filterByStatus(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _LoadGroups implements GooiListEvent {
  const _LoadGroups();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadGroups);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiListEvent.loadGroups()';
}


}




/// @nodoc


class _RefreshGroups implements GooiListEvent {
  const _RefreshGroups();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshGroups);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiListEvent.refreshGroups()';
}


}




/// @nodoc


class _FilterByStatus implements GooiListEvent {
  const _FilterByStatus(this.status);
  

 final  GooiGroupStatus? status;

/// Create a copy of GooiListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterByStatusCopyWith<_FilterByStatus> get copyWith => __$FilterByStatusCopyWithImpl<_FilterByStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterByStatus&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'GooiListEvent.filterByStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class _$FilterByStatusCopyWith<$Res> implements $GooiListEventCopyWith<$Res> {
  factory _$FilterByStatusCopyWith(_FilterByStatus value, $Res Function(_FilterByStatus) _then) = __$FilterByStatusCopyWithImpl;
@useResult
$Res call({
 GooiGroupStatus? status
});




}
/// @nodoc
class __$FilterByStatusCopyWithImpl<$Res>
    implements _$FilterByStatusCopyWith<$Res> {
  __$FilterByStatusCopyWithImpl(this._self, this._then);

  final _FilterByStatus _self;
  final $Res Function(_FilterByStatus) _then;

/// Create a copy of GooiListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,}) {
  return _then(_FilterByStatus(
freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiGroupStatus?,
  ));
}


}

/// @nodoc
mixin _$GooiListState {

 bool get isLoading; bool get isRefreshing; List<GooiGroup> get groups; List<GooiGroup> get filteredGroups; GooiGroupStatus? get statusFilter; String? get errorMessage;
/// Create a copy of GooiListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiListStateCopyWith<GooiListState> get copyWith => _$GooiListStateCopyWithImpl<GooiListState>(this as GooiListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.filteredGroups, filteredGroups)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(filteredGroups),statusFilter,errorMessage);

@override
String toString() {
  return 'GooiListState(isLoading: $isLoading, isRefreshing: $isRefreshing, groups: $groups, filteredGroups: $filteredGroups, statusFilter: $statusFilter, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $GooiListStateCopyWith<$Res>  {
  factory $GooiListStateCopyWith(GooiListState value, $Res Function(GooiListState) _then) = _$GooiListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, List<GooiGroup> groups, List<GooiGroup> filteredGroups, GooiGroupStatus? statusFilter, String? errorMessage
});




}
/// @nodoc
class _$GooiListStateCopyWithImpl<$Res>
    implements $GooiListStateCopyWith<$Res> {
  _$GooiListStateCopyWithImpl(this._self, this._then);

  final GooiListState _self;
  final $Res Function(GooiListState) _then;

/// Create a copy of GooiListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? groups = null,Object? filteredGroups = null,Object? statusFilter = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<GooiGroup>,filteredGroups: null == filteredGroups ? _self.filteredGroups : filteredGroups // ignore: cast_nullable_to_non_nullable
as List<GooiGroup>,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as GooiGroupStatus?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiListState].
extension GooiListStatePatterns on GooiListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiListState value)  $default,){
final _that = this;
switch (_that) {
case _GooiListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiListState value)?  $default,){
final _that = this;
switch (_that) {
case _GooiListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  List<GooiGroup> groups,  List<GooiGroup> filteredGroups,  GooiGroupStatus? statusFilter,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiListState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.groups,_that.filteredGroups,_that.statusFilter,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  List<GooiGroup> groups,  List<GooiGroup> filteredGroups,  GooiGroupStatus? statusFilter,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GooiListState():
return $default(_that.isLoading,_that.isRefreshing,_that.groups,_that.filteredGroups,_that.statusFilter,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isRefreshing,  List<GooiGroup> groups,  List<GooiGroup> filteredGroups,  GooiGroupStatus? statusFilter,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GooiListState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.groups,_that.filteredGroups,_that.statusFilter,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GooiListState implements GooiListState {
  const _GooiListState({this.isLoading = false, this.isRefreshing = false, final  List<GooiGroup> groups = const [], final  List<GooiGroup> filteredGroups = const [], this.statusFilter, this.errorMessage}): _groups = groups,_filteredGroups = filteredGroups;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
 final  List<GooiGroup> _groups;
@override@JsonKey() List<GooiGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<GooiGroup> _filteredGroups;
@override@JsonKey() List<GooiGroup> get filteredGroups {
  if (_filteredGroups is EqualUnmodifiableListView) return _filteredGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredGroups);
}

@override final  GooiGroupStatus? statusFilter;
@override final  String? errorMessage;

/// Create a copy of GooiListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiListStateCopyWith<_GooiListState> get copyWith => __$GooiListStateCopyWithImpl<_GooiListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._filteredGroups, _filteredGroups)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_filteredGroups),statusFilter,errorMessage);

@override
String toString() {
  return 'GooiListState(isLoading: $isLoading, isRefreshing: $isRefreshing, groups: $groups, filteredGroups: $filteredGroups, statusFilter: $statusFilter, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GooiListStateCopyWith<$Res> implements $GooiListStateCopyWith<$Res> {
  factory _$GooiListStateCopyWith(_GooiListState value, $Res Function(_GooiListState) _then) = __$GooiListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, List<GooiGroup> groups, List<GooiGroup> filteredGroups, GooiGroupStatus? statusFilter, String? errorMessage
});




}
/// @nodoc
class __$GooiListStateCopyWithImpl<$Res>
    implements _$GooiListStateCopyWith<$Res> {
  __$GooiListStateCopyWithImpl(this._self, this._then);

  final _GooiListState _self;
  final $Res Function(_GooiListState) _then;

/// Create a copy of GooiListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? groups = null,Object? filteredGroups = null,Object? statusFilter = freezed,Object? errorMessage = freezed,}) {
  return _then(_GooiListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<GooiGroup>,filteredGroups: null == filteredGroups ? _self._filteredGroups : filteredGroups // ignore: cast_nullable_to_non_nullable
as List<GooiGroup>,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as GooiGroupStatus?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
