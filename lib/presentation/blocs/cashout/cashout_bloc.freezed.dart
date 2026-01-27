// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CashoutEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashoutEventCopyWith<$Res> {
  factory $CashoutEventCopyWith(
    CashoutEvent value,
    $Res Function(CashoutEvent) then,
  ) = _$CashoutEventCopyWithImpl<$Res, CashoutEvent>;
}

/// @nodoc
class _$CashoutEventCopyWithImpl<$Res, $Val extends CashoutEvent>
    implements $CashoutEventCopyWith<$Res> {
  _$CashoutEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadHistoryImplCopyWith<$Res> {
  factory _$$LoadHistoryImplCopyWith(
    _$LoadHistoryImpl value,
    $Res Function(_$LoadHistoryImpl) then,
  ) = __$$LoadHistoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? limit});
}

/// @nodoc
class __$$LoadHistoryImplCopyWithImpl<$Res>
    extends _$CashoutEventCopyWithImpl<$Res, _$LoadHistoryImpl>
    implements _$$LoadHistoryImplCopyWith<$Res> {
  __$$LoadHistoryImplCopyWithImpl(
    _$LoadHistoryImpl _value,
    $Res Function(_$LoadHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? limit = freezed}) {
    return _then(
      _$LoadHistoryImpl(
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadHistoryImpl implements _LoadHistory {
  const _$LoadHistoryImpl({this.limit});

  @override
  final int? limit;

  @override
  String toString() {
    return 'CashoutEvent.loadHistory(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadHistoryImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadHistoryImplCopyWith<_$LoadHistoryImpl> get copyWith =>
      __$$LoadHistoryImplCopyWithImpl<_$LoadHistoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return loadHistory(limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return loadHistory?.call(limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory(limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return loadHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return loadHistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory(this);
    }
    return orElse();
  }
}

abstract class _LoadHistory implements CashoutEvent {
  const factory _LoadHistory({final int? limit}) = _$LoadHistoryImpl;

  int? get limit;

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadHistoryImplCopyWith<_$LoadHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreHistoryImplCopyWith<$Res> {
  factory _$$LoadMoreHistoryImplCopyWith(
    _$LoadMoreHistoryImpl value,
    $Res Function(_$LoadMoreHistoryImpl) then,
  ) = __$$LoadMoreHistoryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreHistoryImplCopyWithImpl<$Res>
    extends _$CashoutEventCopyWithImpl<$Res, _$LoadMoreHistoryImpl>
    implements _$$LoadMoreHistoryImplCopyWith<$Res> {
  __$$LoadMoreHistoryImplCopyWithImpl(
    _$LoadMoreHistoryImpl _value,
    $Res Function(_$LoadMoreHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreHistoryImpl implements _LoadMoreHistory {
  const _$LoadMoreHistoryImpl();

  @override
  String toString() {
    return 'CashoutEvent.loadMoreHistory()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreHistoryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return loadMoreHistory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return loadMoreHistory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadMoreHistory != null) {
      return loadMoreHistory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return loadMoreHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return loadMoreHistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadMoreHistory != null) {
      return loadMoreHistory(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreHistory implements CashoutEvent {
  const factory _LoadMoreHistory() = _$LoadMoreHistoryImpl;
}

/// @nodoc
abstract class _$$RequestCashoutImplCopyWith<$Res> {
  factory _$$RequestCashoutImplCopyWith(
    _$RequestCashoutImpl value,
    $Res Function(_$RequestCashoutImpl) then,
  ) = __$$RequestCashoutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    int tokenAmount,
    CashoutMethod method,
    String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  });
}

/// @nodoc
class __$$RequestCashoutImplCopyWithImpl<$Res>
    extends _$CashoutEventCopyWithImpl<$Res, _$RequestCashoutImpl>
    implements _$$RequestCashoutImplCopyWith<$Res> {
  __$$RequestCashoutImplCopyWithImpl(
    _$RequestCashoutImpl _value,
    $Res Function(_$RequestCashoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAmount = null,
    Object? method = null,
    Object? destinationDetails = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolderName = freezed,
    Object? mobileNumber = freezed,
  }) {
    return _then(
      _$RequestCashoutImpl(
        tokenAmount: null == tokenAmount
            ? _value.tokenAmount
            : tokenAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as CashoutMethod,
        destinationDetails: null == destinationDetails
            ? _value.destinationDetails
            : destinationDetails // ignore: cast_nullable_to_non_nullable
                  as String,
        bankName: freezed == bankName
            ? _value.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountHolderName: freezed == accountHolderName
            ? _value.accountHolderName
            : accountHolderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobileNumber: freezed == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RequestCashoutImpl implements _RequestCashout {
  const _$RequestCashoutImpl({
    required this.tokenAmount,
    required this.method,
    required this.destinationDetails,
    this.bankName,
    this.accountNumber,
    this.accountHolderName,
    this.mobileNumber,
  });

  @override
  final int tokenAmount;
  @override
  final CashoutMethod method;
  @override
  final String destinationDetails;
  @override
  final String? bankName;
  @override
  final String? accountNumber;
  @override
  final String? accountHolderName;
  @override
  final String? mobileNumber;

  @override
  String toString() {
    return 'CashoutEvent.requestCashout(tokenAmount: $tokenAmount, method: $method, destinationDetails: $destinationDetails, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestCashoutImpl &&
            (identical(other.tokenAmount, tokenAmount) ||
                other.tokenAmount == tokenAmount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.destinationDetails, destinationDetails) ||
                other.destinationDetails == destinationDetails) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    tokenAmount,
    method,
    destinationDetails,
    bankName,
    accountNumber,
    accountHolderName,
    mobileNumber,
  );

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestCashoutImplCopyWith<_$RequestCashoutImpl> get copyWith =>
      __$$RequestCashoutImplCopyWithImpl<_$RequestCashoutImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return requestCashout(
      tokenAmount,
      method,
      destinationDetails,
      bankName,
      accountNumber,
      accountHolderName,
      mobileNumber,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return requestCashout?.call(
      tokenAmount,
      method,
      destinationDetails,
      bankName,
      accountNumber,
      accountHolderName,
      mobileNumber,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (requestCashout != null) {
      return requestCashout(
        tokenAmount,
        method,
        destinationDetails,
        bankName,
        accountNumber,
        accountHolderName,
        mobileNumber,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return requestCashout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return requestCashout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (requestCashout != null) {
      return requestCashout(this);
    }
    return orElse();
  }
}

abstract class _RequestCashout implements CashoutEvent {
  const factory _RequestCashout({
    required final int tokenAmount,
    required final CashoutMethod method,
    required final String destinationDetails,
    final String? bankName,
    final String? accountNumber,
    final String? accountHolderName,
    final String? mobileNumber,
  }) = _$RequestCashoutImpl;

  int get tokenAmount;
  CashoutMethod get method;
  String get destinationDetails;
  String? get bankName;
  String? get accountNumber;
  String? get accountHolderName;
  String? get mobileNumber;

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestCashoutImplCopyWith<_$RequestCashoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelCashoutImplCopyWith<$Res> {
  factory _$$CancelCashoutImplCopyWith(
    _$CancelCashoutImpl value,
    $Res Function(_$CancelCashoutImpl) then,
  ) = __$$CancelCashoutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cashoutId});
}

/// @nodoc
class __$$CancelCashoutImplCopyWithImpl<$Res>
    extends _$CashoutEventCopyWithImpl<$Res, _$CancelCashoutImpl>
    implements _$$CancelCashoutImplCopyWith<$Res> {
  __$$CancelCashoutImplCopyWithImpl(
    _$CancelCashoutImpl _value,
    $Res Function(_$CancelCashoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cashoutId = null}) {
    return _then(
      _$CancelCashoutImpl(
        null == cashoutId
            ? _value.cashoutId
            : cashoutId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CancelCashoutImpl implements _CancelCashout {
  const _$CancelCashoutImpl(this.cashoutId);

  @override
  final String cashoutId;

  @override
  String toString() {
    return 'CashoutEvent.cancelCashout(cashoutId: $cashoutId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelCashoutImpl &&
            (identical(other.cashoutId, cashoutId) ||
                other.cashoutId == cashoutId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cashoutId);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelCashoutImplCopyWith<_$CancelCashoutImpl> get copyWith =>
      __$$CancelCashoutImplCopyWithImpl<_$CancelCashoutImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return cancelCashout(cashoutId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return cancelCashout?.call(cashoutId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (cancelCashout != null) {
      return cancelCashout(cashoutId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return cancelCashout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return cancelCashout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (cancelCashout != null) {
      return cancelCashout(this);
    }
    return orElse();
  }
}

abstract class _CancelCashout implements CashoutEvent {
  const factory _CancelCashout(final String cashoutId) = _$CancelCashoutImpl;

  String get cashoutId;

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelCashoutImplCopyWith<_$CancelCashoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$CashoutEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'CashoutEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements CashoutEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
    _$ResetImpl value,
    $Res Function(_$ResetImpl) then,
  ) = __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$CashoutEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
    _$ResetImpl _value,
    $Res Function(_$ResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'CashoutEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadHistory,
    required TResult Function() loadMoreHistory,
    required TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )
    requestCashout,
    required TResult Function(String cashoutId) cancelCashout,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadHistory,
    TResult? Function()? loadMoreHistory,
    TResult? Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult? Function(String cashoutId)? cancelCashout,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadHistory,
    TResult Function()? loadMoreHistory,
    TResult Function(
      int tokenAmount,
      CashoutMethod method,
      String destinationDetails,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? mobileNumber,
    )?
    requestCashout,
    TResult Function(String cashoutId)? cancelCashout,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_LoadMoreHistory value) loadMoreHistory,
    required TResult Function(_RequestCashout value) requestCashout,
    required TResult Function(_CancelCashout value) cancelCashout,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult? Function(_RequestCashout value)? requestCashout,
    TResult? Function(_CancelCashout value)? cancelCashout,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_LoadMoreHistory value)? loadMoreHistory,
    TResult Function(_RequestCashout value)? requestCashout,
    TResult Function(_CancelCashout value)? cancelCashout,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements CashoutEvent {
  const factory _Reset() = _$ResetImpl;
}

/// @nodoc
mixin _$CashoutState {
  List<Cashout> get history => throw _privateConstructorUsedError;
  bool get isLoadingHistory => throw _privateConstructorUsedError;
  bool get hasMoreHistory => throw _privateConstructorUsedError;
  DateTime? get lastHistoryTimestamp => throw _privateConstructorUsedError;
  CashoutRequestStatus get requestStatus => throw _privateConstructorUsedError;
  Cashout? get lastCashout => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CashoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashoutStateCopyWith<CashoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashoutStateCopyWith<$Res> {
  factory $CashoutStateCopyWith(
    CashoutState value,
    $Res Function(CashoutState) then,
  ) = _$CashoutStateCopyWithImpl<$Res, CashoutState>;
  @useResult
  $Res call({
    List<Cashout> history,
    bool isLoadingHistory,
    bool hasMoreHistory,
    DateTime? lastHistoryTimestamp,
    CashoutRequestStatus requestStatus,
    Cashout? lastCashout,
    String? errorMessage,
  });

  $CashoutCopyWith<$Res>? get lastCashout;
}

/// @nodoc
class _$CashoutStateCopyWithImpl<$Res, $Val extends CashoutState>
    implements $CashoutStateCopyWith<$Res> {
  _$CashoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
    Object? isLoadingHistory = null,
    Object? hasMoreHistory = null,
    Object? lastHistoryTimestamp = freezed,
    Object? requestStatus = null,
    Object? lastCashout = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<Cashout>,
            isLoadingHistory: null == isLoadingHistory
                ? _value.isLoadingHistory
                : isLoadingHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreHistory: null == hasMoreHistory
                ? _value.hasMoreHistory
                : hasMoreHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastHistoryTimestamp: freezed == lastHistoryTimestamp
                ? _value.lastHistoryTimestamp
                : lastHistoryTimestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requestStatus: null == requestStatus
                ? _value.requestStatus
                : requestStatus // ignore: cast_nullable_to_non_nullable
                      as CashoutRequestStatus,
            lastCashout: freezed == lastCashout
                ? _value.lastCashout
                : lastCashout // ignore: cast_nullable_to_non_nullable
                      as Cashout?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CashoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CashoutCopyWith<$Res>? get lastCashout {
    if (_value.lastCashout == null) {
      return null;
    }

    return $CashoutCopyWith<$Res>(_value.lastCashout!, (value) {
      return _then(_value.copyWith(lastCashout: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CashoutStateImplCopyWith<$Res>
    implements $CashoutStateCopyWith<$Res> {
  factory _$$CashoutStateImplCopyWith(
    _$CashoutStateImpl value,
    $Res Function(_$CashoutStateImpl) then,
  ) = __$$CashoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Cashout> history,
    bool isLoadingHistory,
    bool hasMoreHistory,
    DateTime? lastHistoryTimestamp,
    CashoutRequestStatus requestStatus,
    Cashout? lastCashout,
    String? errorMessage,
  });

  @override
  $CashoutCopyWith<$Res>? get lastCashout;
}

/// @nodoc
class __$$CashoutStateImplCopyWithImpl<$Res>
    extends _$CashoutStateCopyWithImpl<$Res, _$CashoutStateImpl>
    implements _$$CashoutStateImplCopyWith<$Res> {
  __$$CashoutStateImplCopyWithImpl(
    _$CashoutStateImpl _value,
    $Res Function(_$CashoutStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CashoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
    Object? isLoadingHistory = null,
    Object? hasMoreHistory = null,
    Object? lastHistoryTimestamp = freezed,
    Object? requestStatus = null,
    Object? lastCashout = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CashoutStateImpl(
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<Cashout>,
        isLoadingHistory: null == isLoadingHistory
            ? _value.isLoadingHistory
            : isLoadingHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreHistory: null == hasMoreHistory
            ? _value.hasMoreHistory
            : hasMoreHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastHistoryTimestamp: freezed == lastHistoryTimestamp
            ? _value.lastHistoryTimestamp
            : lastHistoryTimestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requestStatus: null == requestStatus
            ? _value.requestStatus
            : requestStatus // ignore: cast_nullable_to_non_nullable
                  as CashoutRequestStatus,
        lastCashout: freezed == lastCashout
            ? _value.lastCashout
            : lastCashout // ignore: cast_nullable_to_non_nullable
                  as Cashout?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CashoutStateImpl extends _CashoutState {
  const _$CashoutStateImpl({
    final List<Cashout> history = const [],
    this.isLoadingHistory = false,
    this.hasMoreHistory = false,
    this.lastHistoryTimestamp,
    this.requestStatus = CashoutRequestStatus.initial,
    this.lastCashout,
    this.errorMessage,
  }) : _history = history,
       super._();

  final List<Cashout> _history;
  @override
  @JsonKey()
  List<Cashout> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final bool isLoadingHistory;
  @override
  @JsonKey()
  final bool hasMoreHistory;
  @override
  final DateTime? lastHistoryTimestamp;
  @override
  @JsonKey()
  final CashoutRequestStatus requestStatus;
  @override
  final Cashout? lastCashout;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CashoutState(history: $history, isLoadingHistory: $isLoadingHistory, hasMoreHistory: $hasMoreHistory, lastHistoryTimestamp: $lastHistoryTimestamp, requestStatus: $requestStatus, lastCashout: $lastCashout, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashoutStateImpl &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.isLoadingHistory, isLoadingHistory) ||
                other.isLoadingHistory == isLoadingHistory) &&
            (identical(other.hasMoreHistory, hasMoreHistory) ||
                other.hasMoreHistory == hasMoreHistory) &&
            (identical(other.lastHistoryTimestamp, lastHistoryTimestamp) ||
                other.lastHistoryTimestamp == lastHistoryTimestamp) &&
            (identical(other.requestStatus, requestStatus) ||
                other.requestStatus == requestStatus) &&
            (identical(other.lastCashout, lastCashout) ||
                other.lastCashout == lastCashout) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_history),
    isLoadingHistory,
    hasMoreHistory,
    lastHistoryTimestamp,
    requestStatus,
    lastCashout,
    errorMessage,
  );

  /// Create a copy of CashoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashoutStateImplCopyWith<_$CashoutStateImpl> get copyWith =>
      __$$CashoutStateImplCopyWithImpl<_$CashoutStateImpl>(this, _$identity);
}

abstract class _CashoutState extends CashoutState {
  const factory _CashoutState({
    final List<Cashout> history,
    final bool isLoadingHistory,
    final bool hasMoreHistory,
    final DateTime? lastHistoryTimestamp,
    final CashoutRequestStatus requestStatus,
    final Cashout? lastCashout,
    final String? errorMessage,
  }) = _$CashoutStateImpl;
  const _CashoutState._() : super._();

  @override
  List<Cashout> get history;
  @override
  bool get isLoadingHistory;
  @override
  bool get hasMoreHistory;
  @override
  DateTime? get lastHistoryTimestamp;
  @override
  CashoutRequestStatus get requestStatus;
  @override
  Cashout? get lastCashout;
  @override
  String? get errorMessage;

  /// Create a copy of CashoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashoutStateImplCopyWith<_$CashoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
