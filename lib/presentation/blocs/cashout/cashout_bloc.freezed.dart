// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CashoutEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CashoutEvent()';
}


}

/// @nodoc
class $CashoutEventCopyWith<$Res>  {
$CashoutEventCopyWith(CashoutEvent _, $Res Function(CashoutEvent) __);
}


/// Adds pattern-matching-related methods to [CashoutEvent].
extension CashoutEventPatterns on CashoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadHistory value)?  loadHistory,TResult Function( _LoadMoreHistory value)?  loadMoreHistory,TResult Function( _RequestCashout value)?  requestCashout,TResult Function( _CancelCashout value)?  cancelCashout,TResult Function( _ClearError value)?  clearError,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory(_that);case _RequestCashout() when requestCashout != null:
return requestCashout(_that);case _CancelCashout() when cancelCashout != null:
return cancelCashout(_that);case _ClearError() when clearError != null:
return clearError(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadHistory value)  loadHistory,required TResult Function( _LoadMoreHistory value)  loadMoreHistory,required TResult Function( _RequestCashout value)  requestCashout,required TResult Function( _CancelCashout value)  cancelCashout,required TResult Function( _ClearError value)  clearError,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _LoadHistory():
return loadHistory(_that);case _LoadMoreHistory():
return loadMoreHistory(_that);case _RequestCashout():
return requestCashout(_that);case _CancelCashout():
return cancelCashout(_that);case _ClearError():
return clearError(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadHistory value)?  loadHistory,TResult? Function( _LoadMoreHistory value)?  loadMoreHistory,TResult? Function( _RequestCashout value)?  requestCashout,TResult? Function( _CancelCashout value)?  cancelCashout,TResult? Function( _ClearError value)?  clearError,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory(_that);case _RequestCashout() when requestCashout != null:
return requestCashout(_that);case _CancelCashout() when cancelCashout != null:
return cancelCashout(_that);case _ClearError() when clearError != null:
return clearError(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? limit)?  loadHistory,TResult Function()?  loadMoreHistory,TResult Function( int tokenAmount,  CashoutMethod method,  String destinationDetails,  String? bankName,  String? accountNumber,  String? accountHolderName,  String? mobileNumber)?  requestCashout,TResult Function( String cashoutId)?  cancelCashout,TResult Function()?  clearError,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadHistory() when loadHistory != null:
return loadHistory(_that.limit);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory();case _RequestCashout() when requestCashout != null:
return requestCashout(_that.tokenAmount,_that.method,_that.destinationDetails,_that.bankName,_that.accountNumber,_that.accountHolderName,_that.mobileNumber);case _CancelCashout() when cancelCashout != null:
return cancelCashout(_that.cashoutId);case _ClearError() when clearError != null:
return clearError();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? limit)  loadHistory,required TResult Function()  loadMoreHistory,required TResult Function( int tokenAmount,  CashoutMethod method,  String destinationDetails,  String? bankName,  String? accountNumber,  String? accountHolderName,  String? mobileNumber)  requestCashout,required TResult Function( String cashoutId)  cancelCashout,required TResult Function()  clearError,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _LoadHistory():
return loadHistory(_that.limit);case _LoadMoreHistory():
return loadMoreHistory();case _RequestCashout():
return requestCashout(_that.tokenAmount,_that.method,_that.destinationDetails,_that.bankName,_that.accountNumber,_that.accountHolderName,_that.mobileNumber);case _CancelCashout():
return cancelCashout(_that.cashoutId);case _ClearError():
return clearError();case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? limit)?  loadHistory,TResult? Function()?  loadMoreHistory,TResult? Function( int tokenAmount,  CashoutMethod method,  String destinationDetails,  String? bankName,  String? accountNumber,  String? accountHolderName,  String? mobileNumber)?  requestCashout,TResult? Function( String cashoutId)?  cancelCashout,TResult? Function()?  clearError,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _LoadHistory() when loadHistory != null:
return loadHistory(_that.limit);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory();case _RequestCashout() when requestCashout != null:
return requestCashout(_that.tokenAmount,_that.method,_that.destinationDetails,_that.bankName,_that.accountNumber,_that.accountHolderName,_that.mobileNumber);case _CancelCashout() when cancelCashout != null:
return cancelCashout(_that.cashoutId);case _ClearError() when clearError != null:
return clearError();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _LoadHistory implements CashoutEvent {
  const _LoadHistory({this.limit});
  

 final  int? limit;

/// Create a copy of CashoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadHistoryCopyWith<_LoadHistory> get copyWith => __$LoadHistoryCopyWithImpl<_LoadHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadHistory&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString() {
  return 'CashoutEvent.loadHistory(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadHistoryCopyWith<$Res> implements $CashoutEventCopyWith<$Res> {
  factory _$LoadHistoryCopyWith(_LoadHistory value, $Res Function(_LoadHistory) _then) = __$LoadHistoryCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$LoadHistoryCopyWithImpl<$Res>
    implements _$LoadHistoryCopyWith<$Res> {
  __$LoadHistoryCopyWithImpl(this._self, this._then);

  final _LoadHistory _self;
  final $Res Function(_LoadHistory) _then;

/// Create a copy of CashoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_LoadHistory(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LoadMoreHistory implements CashoutEvent {
  const _LoadMoreHistory();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreHistory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CashoutEvent.loadMoreHistory()';
}


}




/// @nodoc


class _RequestCashout implements CashoutEvent {
  const _RequestCashout({required this.tokenAmount, required this.method, required this.destinationDetails, this.bankName, this.accountNumber, this.accountHolderName, this.mobileNumber});
  

 final  int tokenAmount;
 final  CashoutMethod method;
 final  String destinationDetails;
 final  String? bankName;
 final  String? accountNumber;
 final  String? accountHolderName;
 final  String? mobileNumber;

/// Create a copy of CashoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestCashoutCopyWith<_RequestCashout> get copyWith => __$RequestCashoutCopyWithImpl<_RequestCashout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestCashout&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.method, method) || other.method == method)&&(identical(other.destinationDetails, destinationDetails) || other.destinationDetails == destinationDetails)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber));
}


@override
int get hashCode => Object.hash(runtimeType,tokenAmount,method,destinationDetails,bankName,accountNumber,accountHolderName,mobileNumber);

@override
String toString() {
  return 'CashoutEvent.requestCashout(tokenAmount: $tokenAmount, method: $method, destinationDetails: $destinationDetails, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, mobileNumber: $mobileNumber)';
}


}

/// @nodoc
abstract mixin class _$RequestCashoutCopyWith<$Res> implements $CashoutEventCopyWith<$Res> {
  factory _$RequestCashoutCopyWith(_RequestCashout value, $Res Function(_RequestCashout) _then) = __$RequestCashoutCopyWithImpl;
@useResult
$Res call({
 int tokenAmount, CashoutMethod method, String destinationDetails, String? bankName, String? accountNumber, String? accountHolderName, String? mobileNumber
});




}
/// @nodoc
class __$RequestCashoutCopyWithImpl<$Res>
    implements _$RequestCashoutCopyWith<$Res> {
  __$RequestCashoutCopyWithImpl(this._self, this._then);

  final _RequestCashout _self;
  final $Res Function(_RequestCashout) _then;

/// Create a copy of CashoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tokenAmount = null,Object? method = null,Object? destinationDetails = null,Object? bankName = freezed,Object? accountNumber = freezed,Object? accountHolderName = freezed,Object? mobileNumber = freezed,}) {
  return _then(_RequestCashout(
tokenAmount: null == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CashoutMethod,destinationDetails: null == destinationDetails ? _self.destinationDetails : destinationDetails // ignore: cast_nullable_to_non_nullable
as String,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountHolderName: freezed == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CancelCashout implements CashoutEvent {
  const _CancelCashout(this.cashoutId);
  

 final  String cashoutId;

/// Create a copy of CashoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelCashoutCopyWith<_CancelCashout> get copyWith => __$CancelCashoutCopyWithImpl<_CancelCashout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelCashout&&(identical(other.cashoutId, cashoutId) || other.cashoutId == cashoutId));
}


@override
int get hashCode => Object.hash(runtimeType,cashoutId);

@override
String toString() {
  return 'CashoutEvent.cancelCashout(cashoutId: $cashoutId)';
}


}

/// @nodoc
abstract mixin class _$CancelCashoutCopyWith<$Res> implements $CashoutEventCopyWith<$Res> {
  factory _$CancelCashoutCopyWith(_CancelCashout value, $Res Function(_CancelCashout) _then) = __$CancelCashoutCopyWithImpl;
@useResult
$Res call({
 String cashoutId
});




}
/// @nodoc
class __$CancelCashoutCopyWithImpl<$Res>
    implements _$CancelCashoutCopyWith<$Res> {
  __$CancelCashoutCopyWithImpl(this._self, this._then);

  final _CancelCashout _self;
  final $Res Function(_CancelCashout) _then;

/// Create a copy of CashoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cashoutId = null,}) {
  return _then(_CancelCashout(
null == cashoutId ? _self.cashoutId : cashoutId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearError implements CashoutEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CashoutEvent.clearError()';
}


}




/// @nodoc


class _Reset implements CashoutEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CashoutEvent.reset()';
}


}




/// @nodoc
mixin _$CashoutState {

 List<Cashout> get history; bool get isLoadingHistory; bool get hasMoreHistory; DateTime? get lastHistoryTimestamp; CashoutRequestStatus get requestStatus; Cashout? get lastCashout; String? get errorMessage;
/// Create a copy of CashoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashoutStateCopyWith<CashoutState> get copyWith => _$CashoutStateCopyWithImpl<CashoutState>(this as CashoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashoutState&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasMoreHistory, hasMoreHistory) || other.hasMoreHistory == hasMoreHistory)&&(identical(other.lastHistoryTimestamp, lastHistoryTimestamp) || other.lastHistoryTimestamp == lastHistoryTimestamp)&&(identical(other.requestStatus, requestStatus) || other.requestStatus == requestStatus)&&(identical(other.lastCashout, lastCashout) || other.lastCashout == lastCashout)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(history),isLoadingHistory,hasMoreHistory,lastHistoryTimestamp,requestStatus,lastCashout,errorMessage);

@override
String toString() {
  return 'CashoutState(history: $history, isLoadingHistory: $isLoadingHistory, hasMoreHistory: $hasMoreHistory, lastHistoryTimestamp: $lastHistoryTimestamp, requestStatus: $requestStatus, lastCashout: $lastCashout, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CashoutStateCopyWith<$Res>  {
  factory $CashoutStateCopyWith(CashoutState value, $Res Function(CashoutState) _then) = _$CashoutStateCopyWithImpl;
@useResult
$Res call({
 List<Cashout> history, bool isLoadingHistory, bool hasMoreHistory, DateTime? lastHistoryTimestamp, CashoutRequestStatus requestStatus, Cashout? lastCashout, String? errorMessage
});


$CashoutCopyWith<$Res>? get lastCashout;

}
/// @nodoc
class _$CashoutStateCopyWithImpl<$Res>
    implements $CashoutStateCopyWith<$Res> {
  _$CashoutStateCopyWithImpl(this._self, this._then);

  final CashoutState _self;
  final $Res Function(CashoutState) _then;

/// Create a copy of CashoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? history = null,Object? isLoadingHistory = null,Object? hasMoreHistory = null,Object? lastHistoryTimestamp = freezed,Object? requestStatus = null,Object? lastCashout = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<Cashout>,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasMoreHistory: null == hasMoreHistory ? _self.hasMoreHistory : hasMoreHistory // ignore: cast_nullable_to_non_nullable
as bool,lastHistoryTimestamp: freezed == lastHistoryTimestamp ? _self.lastHistoryTimestamp : lastHistoryTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,requestStatus: null == requestStatus ? _self.requestStatus : requestStatus // ignore: cast_nullable_to_non_nullable
as CashoutRequestStatus,lastCashout: freezed == lastCashout ? _self.lastCashout : lastCashout // ignore: cast_nullable_to_non_nullable
as Cashout?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CashoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashoutCopyWith<$Res>? get lastCashout {
    if (_self.lastCashout == null) {
    return null;
  }

  return $CashoutCopyWith<$Res>(_self.lastCashout!, (value) {
    return _then(_self.copyWith(lastCashout: value));
  });
}
}


/// Adds pattern-matching-related methods to [CashoutState].
extension CashoutStatePatterns on CashoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashoutState value)  $default,){
final _that = this;
switch (_that) {
case _CashoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashoutState value)?  $default,){
final _that = this;
switch (_that) {
case _CashoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Cashout> history,  bool isLoadingHistory,  bool hasMoreHistory,  DateTime? lastHistoryTimestamp,  CashoutRequestStatus requestStatus,  Cashout? lastCashout,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashoutState() when $default != null:
return $default(_that.history,_that.isLoadingHistory,_that.hasMoreHistory,_that.lastHistoryTimestamp,_that.requestStatus,_that.lastCashout,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Cashout> history,  bool isLoadingHistory,  bool hasMoreHistory,  DateTime? lastHistoryTimestamp,  CashoutRequestStatus requestStatus,  Cashout? lastCashout,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CashoutState():
return $default(_that.history,_that.isLoadingHistory,_that.hasMoreHistory,_that.lastHistoryTimestamp,_that.requestStatus,_that.lastCashout,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Cashout> history,  bool isLoadingHistory,  bool hasMoreHistory,  DateTime? lastHistoryTimestamp,  CashoutRequestStatus requestStatus,  Cashout? lastCashout,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CashoutState() when $default != null:
return $default(_that.history,_that.isLoadingHistory,_that.hasMoreHistory,_that.lastHistoryTimestamp,_that.requestStatus,_that.lastCashout,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CashoutState extends CashoutState {
  const _CashoutState({final  List<Cashout> history = const [], this.isLoadingHistory = false, this.hasMoreHistory = false, this.lastHistoryTimestamp, this.requestStatus = CashoutRequestStatus.initial, this.lastCashout, this.errorMessage}): _history = history,super._();
  

 final  List<Cashout> _history;
@override@JsonKey() List<Cashout> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool hasMoreHistory;
@override final  DateTime? lastHistoryTimestamp;
@override@JsonKey() final  CashoutRequestStatus requestStatus;
@override final  Cashout? lastCashout;
@override final  String? errorMessage;

/// Create a copy of CashoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashoutStateCopyWith<_CashoutState> get copyWith => __$CashoutStateCopyWithImpl<_CashoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashoutState&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasMoreHistory, hasMoreHistory) || other.hasMoreHistory == hasMoreHistory)&&(identical(other.lastHistoryTimestamp, lastHistoryTimestamp) || other.lastHistoryTimestamp == lastHistoryTimestamp)&&(identical(other.requestStatus, requestStatus) || other.requestStatus == requestStatus)&&(identical(other.lastCashout, lastCashout) || other.lastCashout == lastCashout)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history),isLoadingHistory,hasMoreHistory,lastHistoryTimestamp,requestStatus,lastCashout,errorMessage);

@override
String toString() {
  return 'CashoutState(history: $history, isLoadingHistory: $isLoadingHistory, hasMoreHistory: $hasMoreHistory, lastHistoryTimestamp: $lastHistoryTimestamp, requestStatus: $requestStatus, lastCashout: $lastCashout, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CashoutStateCopyWith<$Res> implements $CashoutStateCopyWith<$Res> {
  factory _$CashoutStateCopyWith(_CashoutState value, $Res Function(_CashoutState) _then) = __$CashoutStateCopyWithImpl;
@override @useResult
$Res call({
 List<Cashout> history, bool isLoadingHistory, bool hasMoreHistory, DateTime? lastHistoryTimestamp, CashoutRequestStatus requestStatus, Cashout? lastCashout, String? errorMessage
});


@override $CashoutCopyWith<$Res>? get lastCashout;

}
/// @nodoc
class __$CashoutStateCopyWithImpl<$Res>
    implements _$CashoutStateCopyWith<$Res> {
  __$CashoutStateCopyWithImpl(this._self, this._then);

  final _CashoutState _self;
  final $Res Function(_CashoutState) _then;

/// Create a copy of CashoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? history = null,Object? isLoadingHistory = null,Object? hasMoreHistory = null,Object? lastHistoryTimestamp = freezed,Object? requestStatus = null,Object? lastCashout = freezed,Object? errorMessage = freezed,}) {
  return _then(_CashoutState(
history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<Cashout>,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasMoreHistory: null == hasMoreHistory ? _self.hasMoreHistory : hasMoreHistory // ignore: cast_nullable_to_non_nullable
as bool,lastHistoryTimestamp: freezed == lastHistoryTimestamp ? _self.lastHistoryTimestamp : lastHistoryTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,requestStatus: null == requestStatus ? _self.requestStatus : requestStatus // ignore: cast_nullable_to_non_nullable
as CashoutRequestStatus,lastCashout: freezed == lastCashout ? _self.lastCashout : lastCashout // ignore: cast_nullable_to_non_nullable
as Cashout?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CashoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashoutCopyWith<$Res>? get lastCashout {
    if (_self.lastCashout == null) {
    return null;
  }

  return $CashoutCopyWith<$Res>(_self.lastCashout!, (value) {
    return _then(_self.copyWith(lastCashout: value));
  });
}
}

// dart format on
