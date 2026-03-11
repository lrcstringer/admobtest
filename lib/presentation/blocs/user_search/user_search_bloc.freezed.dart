// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSearchEvent()';
}


}

/// @nodoc
class $UserSearchEventCopyWith<$Res>  {
$UserSearchEventCopyWith(UserSearchEvent _, $Res Function(UserSearchEvent) __);
}


/// Adds pattern-matching-related methods to [UserSearchEvent].
extension UserSearchEventPatterns on UserSearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SearchUsers value)?  searchUsers,TResult Function( _ClearSearch value)?  clearSearch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SearchUsers value)  searchUsers,required TResult Function( _ClearSearch value)  clearSearch,}){
final _that = this;
switch (_that) {
case _SearchUsers():
return searchUsers(_that);case _ClearSearch():
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SearchUsers value)?  searchUsers,TResult? Function( _ClearSearch value)?  clearSearch,}){
final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query,  String? accountTypeId)?  searchUsers,TResult Function()?  clearSearch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that.query,_that.accountTypeId);case _ClearSearch() when clearSearch != null:
return clearSearch();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query,  String? accountTypeId)  searchUsers,required TResult Function()  clearSearch,}) {final _that = this;
switch (_that) {
case _SearchUsers():
return searchUsers(_that.query,_that.accountTypeId);case _ClearSearch():
return clearSearch();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query,  String? accountTypeId)?  searchUsers,TResult? Function()?  clearSearch,}) {final _that = this;
switch (_that) {
case _SearchUsers() when searchUsers != null:
return searchUsers(_that.query,_that.accountTypeId);case _ClearSearch() when clearSearch != null:
return clearSearch();case _:
  return null;

}
}

}

/// @nodoc


class _SearchUsers implements UserSearchEvent {
  const _SearchUsers(this.query, {this.accountTypeId});
  

 final  String query;
 final  String? accountTypeId;

/// Create a copy of UserSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchUsersCopyWith<_SearchUsers> get copyWith => __$SearchUsersCopyWithImpl<_SearchUsers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchUsers&&(identical(other.query, query) || other.query == query)&&(identical(other.accountTypeId, accountTypeId) || other.accountTypeId == accountTypeId));
}


@override
int get hashCode => Object.hash(runtimeType,query,accountTypeId);

@override
String toString() {
  return 'UserSearchEvent.searchUsers(query: $query, accountTypeId: $accountTypeId)';
}


}

/// @nodoc
abstract mixin class _$SearchUsersCopyWith<$Res> implements $UserSearchEventCopyWith<$Res> {
  factory _$SearchUsersCopyWith(_SearchUsers value, $Res Function(_SearchUsers) _then) = __$SearchUsersCopyWithImpl;
@useResult
$Res call({
 String query, String? accountTypeId
});




}
/// @nodoc
class __$SearchUsersCopyWithImpl<$Res>
    implements _$SearchUsersCopyWith<$Res> {
  __$SearchUsersCopyWithImpl(this._self, this._then);

  final _SearchUsers _self;
  final $Res Function(_SearchUsers) _then;

/// Create a copy of UserSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? accountTypeId = freezed,}) {
  return _then(_SearchUsers(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,accountTypeId: freezed == accountTypeId ? _self.accountTypeId : accountTypeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ClearSearch implements UserSearchEvent {
  const _ClearSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSearchEvent.clearSearch()';
}


}




/// @nodoc
mixin _$UserSearchState {

 List<UserSearchResult> get searchResults; bool get isSearching;
/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchStateCopyWith<UserSearchState> get copyWith => _$UserSearchStateCopyWithImpl<UserSearchState>(this as UserSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchState&&const DeepCollectionEquality().equals(other.searchResults, searchResults)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(searchResults),isSearching);

@override
String toString() {
  return 'UserSearchState(searchResults: $searchResults, isSearching: $isSearching)';
}


}

/// @nodoc
abstract mixin class $UserSearchStateCopyWith<$Res>  {
  factory $UserSearchStateCopyWith(UserSearchState value, $Res Function(UserSearchState) _then) = _$UserSearchStateCopyWithImpl;
@useResult
$Res call({
 List<UserSearchResult> searchResults, bool isSearching
});




}
/// @nodoc
class _$UserSearchStateCopyWithImpl<$Res>
    implements $UserSearchStateCopyWith<$Res> {
  _$UserSearchStateCopyWithImpl(this._self, this._then);

  final UserSearchState _self;
  final $Res Function(UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchResults = null,Object? isSearching = null,}) {
  return _then(_self.copyWith(
searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<UserSearchResult>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchState].
extension UserSearchStatePatterns on UserSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchState value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserSearchResult> searchResults,  bool isSearching)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.searchResults,_that.isSearching);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserSearchResult> searchResults,  bool isSearching)  $default,) {final _that = this;
switch (_that) {
case _UserSearchState():
return $default(_that.searchResults,_that.isSearching);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserSearchResult> searchResults,  bool isSearching)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.searchResults,_that.isSearching);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchState implements UserSearchState {
  const _UserSearchState({final  List<UserSearchResult> searchResults = const [], this.isSearching = false}): _searchResults = searchResults;
  

 final  List<UserSearchResult> _searchResults;
@override@JsonKey() List<UserSearchResult> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}

@override@JsonKey() final  bool isSearching;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchStateCopyWith<_UserSearchState> get copyWith => __$UserSearchStateCopyWithImpl<_UserSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchState&&const DeepCollectionEquality().equals(other._searchResults, _searchResults)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_searchResults),isSearching);

@override
String toString() {
  return 'UserSearchState(searchResults: $searchResults, isSearching: $isSearching)';
}


}

/// @nodoc
abstract mixin class _$UserSearchStateCopyWith<$Res> implements $UserSearchStateCopyWith<$Res> {
  factory _$UserSearchStateCopyWith(_UserSearchState value, $Res Function(_UserSearchState) _then) = __$UserSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<UserSearchResult> searchResults, bool isSearching
});




}
/// @nodoc
class __$UserSearchStateCopyWithImpl<$Res>
    implements _$UserSearchStateCopyWith<$Res> {
  __$UserSearchStateCopyWithImpl(this._self, this._then);

  final _UserSearchState _self;
  final $Res Function(_UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchResults = null,Object? isSearching = null,}) {
  return _then(_UserSearchState(
searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<UserSearchResult>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
