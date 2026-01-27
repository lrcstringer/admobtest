// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDashboard,
    required TResult Function() refreshDashboard,
    required TResult Function() watchWallet,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function() stopWatching,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDashboard,
    TResult? Function()? refreshDashboard,
    TResult? Function()? watchWallet,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function()? stopWatching,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDashboard,
    TResult Function()? refreshDashboard,
    TResult Function()? watchWallet,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function()? stopWatching,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboard value) loadDashboard,
    required TResult Function(_RefreshDashboard value) refreshDashboard,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_StopWatching value) stopWatching,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboard value)? loadDashboard,
    TResult? Function(_RefreshDashboard value)? refreshDashboard,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_StopWatching value)? stopWatching,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboard value)? loadDashboard,
    TResult Function(_RefreshDashboard value)? refreshDashboard,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_StopWatching value)? stopWatching,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res, HomeEvent>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<$Res, $Val extends HomeEvent>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadDashboardImplCopyWith<$Res> {
  factory _$$LoadDashboardImplCopyWith(
    _$LoadDashboardImpl value,
    $Res Function(_$LoadDashboardImpl) then,
  ) = __$$LoadDashboardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadDashboardImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$LoadDashboardImpl>
    implements _$$LoadDashboardImplCopyWith<$Res> {
  __$$LoadDashboardImplCopyWithImpl(
    _$LoadDashboardImpl _value,
    $Res Function(_$LoadDashboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadDashboardImpl implements _LoadDashboard {
  const _$LoadDashboardImpl();

  @override
  String toString() {
    return 'HomeEvent.loadDashboard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadDashboardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDashboard,
    required TResult Function() refreshDashboard,
    required TResult Function() watchWallet,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function() stopWatching,
  }) {
    return loadDashboard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDashboard,
    TResult? Function()? refreshDashboard,
    TResult? Function()? watchWallet,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function()? stopWatching,
  }) {
    return loadDashboard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDashboard,
    TResult Function()? refreshDashboard,
    TResult Function()? watchWallet,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function()? stopWatching,
    required TResult orElse(),
  }) {
    if (loadDashboard != null) {
      return loadDashboard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboard value) loadDashboard,
    required TResult Function(_RefreshDashboard value) refreshDashboard,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_StopWatching value) stopWatching,
  }) {
    return loadDashboard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboard value)? loadDashboard,
    TResult? Function(_RefreshDashboard value)? refreshDashboard,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_StopWatching value)? stopWatching,
  }) {
    return loadDashboard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboard value)? loadDashboard,
    TResult Function(_RefreshDashboard value)? refreshDashboard,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_StopWatching value)? stopWatching,
    required TResult orElse(),
  }) {
    if (loadDashboard != null) {
      return loadDashboard(this);
    }
    return orElse();
  }
}

abstract class _LoadDashboard implements HomeEvent {
  const factory _LoadDashboard() = _$LoadDashboardImpl;
}

/// @nodoc
abstract class _$$RefreshDashboardImplCopyWith<$Res> {
  factory _$$RefreshDashboardImplCopyWith(
    _$RefreshDashboardImpl value,
    $Res Function(_$RefreshDashboardImpl) then,
  ) = __$$RefreshDashboardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshDashboardImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$RefreshDashboardImpl>
    implements _$$RefreshDashboardImplCopyWith<$Res> {
  __$$RefreshDashboardImplCopyWithImpl(
    _$RefreshDashboardImpl _value,
    $Res Function(_$RefreshDashboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshDashboardImpl implements _RefreshDashboard {
  const _$RefreshDashboardImpl();

  @override
  String toString() {
    return 'HomeEvent.refreshDashboard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshDashboardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDashboard,
    required TResult Function() refreshDashboard,
    required TResult Function() watchWallet,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function() stopWatching,
  }) {
    return refreshDashboard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDashboard,
    TResult? Function()? refreshDashboard,
    TResult? Function()? watchWallet,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function()? stopWatching,
  }) {
    return refreshDashboard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDashboard,
    TResult Function()? refreshDashboard,
    TResult Function()? watchWallet,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function()? stopWatching,
    required TResult orElse(),
  }) {
    if (refreshDashboard != null) {
      return refreshDashboard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboard value) loadDashboard,
    required TResult Function(_RefreshDashboard value) refreshDashboard,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_StopWatching value) stopWatching,
  }) {
    return refreshDashboard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboard value)? loadDashboard,
    TResult? Function(_RefreshDashboard value)? refreshDashboard,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_StopWatching value)? stopWatching,
  }) {
    return refreshDashboard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboard value)? loadDashboard,
    TResult Function(_RefreshDashboard value)? refreshDashboard,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_StopWatching value)? stopWatching,
    required TResult orElse(),
  }) {
    if (refreshDashboard != null) {
      return refreshDashboard(this);
    }
    return orElse();
  }
}

abstract class _RefreshDashboard implements HomeEvent {
  const factory _RefreshDashboard() = _$RefreshDashboardImpl;
}

/// @nodoc
abstract class _$$WatchWalletImplCopyWith<$Res> {
  factory _$$WatchWalletImplCopyWith(
    _$WatchWalletImpl value,
    $Res Function(_$WatchWalletImpl) then,
  ) = __$$WatchWalletImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchWalletImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$WatchWalletImpl>
    implements _$$WatchWalletImplCopyWith<$Res> {
  __$$WatchWalletImplCopyWithImpl(
    _$WatchWalletImpl _value,
    $Res Function(_$WatchWalletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchWalletImpl implements _WatchWallet {
  const _$WatchWalletImpl();

  @override
  String toString() {
    return 'HomeEvent.watchWallet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchWalletImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDashboard,
    required TResult Function() refreshDashboard,
    required TResult Function() watchWallet,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function() stopWatching,
  }) {
    return watchWallet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDashboard,
    TResult? Function()? refreshDashboard,
    TResult? Function()? watchWallet,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function()? stopWatching,
  }) {
    return watchWallet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDashboard,
    TResult Function()? refreshDashboard,
    TResult Function()? watchWallet,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function()? stopWatching,
    required TResult orElse(),
  }) {
    if (watchWallet != null) {
      return watchWallet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboard value) loadDashboard,
    required TResult Function(_RefreshDashboard value) refreshDashboard,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_StopWatching value) stopWatching,
  }) {
    return watchWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboard value)? loadDashboard,
    TResult? Function(_RefreshDashboard value)? refreshDashboard,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_StopWatching value)? stopWatching,
  }) {
    return watchWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboard value)? loadDashboard,
    TResult Function(_RefreshDashboard value)? refreshDashboard,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_StopWatching value)? stopWatching,
    required TResult orElse(),
  }) {
    if (watchWallet != null) {
      return watchWallet(this);
    }
    return orElse();
  }
}

abstract class _WatchWallet implements HomeEvent {
  const factory _WatchWallet() = _$WatchWalletImpl;
}

/// @nodoc
abstract class _$$WalletUpdatedImplCopyWith<$Res> {
  factory _$$WalletUpdatedImplCopyWith(
    _$WalletUpdatedImpl value,
    $Res Function(_$WalletUpdatedImpl) then,
  ) = __$$WalletUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Wallet wallet});

  $WalletCopyWith<$Res> get wallet;
}

/// @nodoc
class __$$WalletUpdatedImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$WalletUpdatedImpl>
    implements _$$WalletUpdatedImplCopyWith<$Res> {
  __$$WalletUpdatedImplCopyWithImpl(
    _$WalletUpdatedImpl _value,
    $Res Function(_$WalletUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? wallet = null}) {
    return _then(
      _$WalletUpdatedImpl(
        null == wallet
            ? _value.wallet
            : wallet // ignore: cast_nullable_to_non_nullable
                  as Wallet,
      ),
    );
  }

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletCopyWith<$Res> get wallet {
    return $WalletCopyWith<$Res>(_value.wallet, (value) {
      return _then(_value.copyWith(wallet: value));
    });
  }
}

/// @nodoc

class _$WalletUpdatedImpl implements _WalletUpdated {
  const _$WalletUpdatedImpl(this.wallet);

  @override
  final Wallet wallet;

  @override
  String toString() {
    return 'HomeEvent.walletUpdated(wallet: $wallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletUpdatedImpl &&
            (identical(other.wallet, wallet) || other.wallet == wallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wallet);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletUpdatedImplCopyWith<_$WalletUpdatedImpl> get copyWith =>
      __$$WalletUpdatedImplCopyWithImpl<_$WalletUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDashboard,
    required TResult Function() refreshDashboard,
    required TResult Function() watchWallet,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function() stopWatching,
  }) {
    return walletUpdated(wallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDashboard,
    TResult? Function()? refreshDashboard,
    TResult? Function()? watchWallet,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function()? stopWatching,
  }) {
    return walletUpdated?.call(wallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDashboard,
    TResult Function()? refreshDashboard,
    TResult Function()? watchWallet,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function()? stopWatching,
    required TResult orElse(),
  }) {
    if (walletUpdated != null) {
      return walletUpdated(wallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboard value) loadDashboard,
    required TResult Function(_RefreshDashboard value) refreshDashboard,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_StopWatching value) stopWatching,
  }) {
    return walletUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboard value)? loadDashboard,
    TResult? Function(_RefreshDashboard value)? refreshDashboard,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_StopWatching value)? stopWatching,
  }) {
    return walletUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboard value)? loadDashboard,
    TResult Function(_RefreshDashboard value)? refreshDashboard,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_StopWatching value)? stopWatching,
    required TResult orElse(),
  }) {
    if (walletUpdated != null) {
      return walletUpdated(this);
    }
    return orElse();
  }
}

abstract class _WalletUpdated implements HomeEvent {
  const factory _WalletUpdated(final Wallet wallet) = _$WalletUpdatedImpl;

  Wallet get wallet;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletUpdatedImplCopyWith<_$WalletUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StopWatchingImplCopyWith<$Res> {
  factory _$$StopWatchingImplCopyWith(
    _$StopWatchingImpl value,
    $Res Function(_$StopWatchingImpl) then,
  ) = __$$StopWatchingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopWatchingImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$StopWatchingImpl>
    implements _$$StopWatchingImplCopyWith<$Res> {
  __$$StopWatchingImplCopyWithImpl(
    _$StopWatchingImpl _value,
    $Res Function(_$StopWatchingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopWatchingImpl implements _StopWatching {
  const _$StopWatchingImpl();

  @override
  String toString() {
    return 'HomeEvent.stopWatching()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopWatchingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadDashboard,
    required TResult Function() refreshDashboard,
    required TResult Function() watchWallet,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function() stopWatching,
  }) {
    return stopWatching();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadDashboard,
    TResult? Function()? refreshDashboard,
    TResult? Function()? watchWallet,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function()? stopWatching,
  }) {
    return stopWatching?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadDashboard,
    TResult Function()? refreshDashboard,
    TResult Function()? watchWallet,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function()? stopWatching,
    required TResult orElse(),
  }) {
    if (stopWatching != null) {
      return stopWatching();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboard value) loadDashboard,
    required TResult Function(_RefreshDashboard value) refreshDashboard,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_StopWatching value) stopWatching,
  }) {
    return stopWatching(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboard value)? loadDashboard,
    TResult? Function(_RefreshDashboard value)? refreshDashboard,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_StopWatching value)? stopWatching,
  }) {
    return stopWatching?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboard value)? loadDashboard,
    TResult Function(_RefreshDashboard value)? refreshDashboard,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_StopWatching value)? stopWatching,
    required TResult orElse(),
  }) {
    if (stopWatching != null) {
      return stopWatching(this);
    }
    return orElse();
  }
}

abstract class _StopWatching implements HomeEvent {
  const factory _StopWatching() = _$StopWatchingImpl;
}

/// @nodoc
mixin _$HomeState {
  HomeStatus get status => throw _privateConstructorUsedError;
  Wallet? get wallet => throw _privateConstructorUsedError;
  List<EarnThread> get earnOpportunities => throw _privateConstructorUsedError;
  List<PotPool> get activePots => throw _privateConstructorUsedError;
  bool get isRefreshing => throw _privateConstructorUsedError;
  DateTime? get lastRefresh => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({
    HomeStatus status,
    Wallet? wallet,
    List<EarnThread> earnOpportunities,
    List<PotPool> activePots,
    bool isRefreshing,
    DateTime? lastRefresh,
    String? errorMessage,
  });

  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? wallet = freezed,
    Object? earnOpportunities = null,
    Object? activePots = null,
    Object? isRefreshing = null,
    Object? lastRefresh = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as HomeStatus,
            wallet: freezed == wallet
                ? _value.wallet
                : wallet // ignore: cast_nullable_to_non_nullable
                      as Wallet?,
            earnOpportunities: null == earnOpportunities
                ? _value.earnOpportunities
                : earnOpportunities // ignore: cast_nullable_to_non_nullable
                      as List<EarnThread>,
            activePots: null == activePots
                ? _value.activePots
                : activePots // ignore: cast_nullable_to_non_nullable
                      as List<PotPool>,
            isRefreshing: null == isRefreshing
                ? _value.isRefreshing
                : isRefreshing // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastRefresh: freezed == lastRefresh
                ? _value.lastRefresh
                : lastRefresh // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletCopyWith<$Res>? get wallet {
    if (_value.wallet == null) {
      return null;
    }

    return $WalletCopyWith<$Res>(_value.wallet!, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
    _$HomeStateImpl value,
    $Res Function(_$HomeStateImpl) then,
  ) = __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    HomeStatus status,
    Wallet? wallet,
    List<EarnThread> earnOpportunities,
    List<PotPool> activePots,
    bool isRefreshing,
    DateTime? lastRefresh,
    String? errorMessage,
  });

  @override
  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
    _$HomeStateImpl _value,
    $Res Function(_$HomeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? wallet = freezed,
    Object? earnOpportunities = null,
    Object? activePots = null,
    Object? isRefreshing = null,
    Object? lastRefresh = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$HomeStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as HomeStatus,
        wallet: freezed == wallet
            ? _value.wallet
            : wallet // ignore: cast_nullable_to_non_nullable
                  as Wallet?,
        earnOpportunities: null == earnOpportunities
            ? _value._earnOpportunities
            : earnOpportunities // ignore: cast_nullable_to_non_nullable
                  as List<EarnThread>,
        activePots: null == activePots
            ? _value._activePots
            : activePots // ignore: cast_nullable_to_non_nullable
                  as List<PotPool>,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastRefresh: freezed == lastRefresh
            ? _value.lastRefresh
            : lastRefresh // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl({
    this.status = HomeStatus.initial,
    this.wallet,
    final List<EarnThread> earnOpportunities = const [],
    final List<PotPool> activePots = const [],
    this.isRefreshing = false,
    this.lastRefresh,
    this.errorMessage,
  }) : _earnOpportunities = earnOpportunities,
       _activePots = activePots;

  @override
  @JsonKey()
  final HomeStatus status;
  @override
  final Wallet? wallet;
  final List<EarnThread> _earnOpportunities;
  @override
  @JsonKey()
  List<EarnThread> get earnOpportunities {
    if (_earnOpportunities is EqualUnmodifiableListView)
      return _earnOpportunities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earnOpportunities);
  }

  final List<PotPool> _activePots;
  @override
  @JsonKey()
  List<PotPool> get activePots {
    if (_activePots is EqualUnmodifiableListView) return _activePots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activePots);
  }

  @override
  @JsonKey()
  final bool isRefreshing;
  @override
  final DateTime? lastRefresh;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeState(status: $status, wallet: $wallet, earnOpportunities: $earnOpportunities, activePots: $activePots, isRefreshing: $isRefreshing, lastRefresh: $lastRefresh, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            const DeepCollectionEquality().equals(
              other._earnOpportunities,
              _earnOpportunities,
            ) &&
            const DeepCollectionEquality().equals(
              other._activePots,
              _activePots,
            ) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.lastRefresh, lastRefresh) ||
                other.lastRefresh == lastRefresh) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    wallet,
    const DeepCollectionEquality().hash(_earnOpportunities),
    const DeepCollectionEquality().hash(_activePots),
    isRefreshing,
    lastRefresh,
    errorMessage,
  );

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({
    final HomeStatus status,
    final Wallet? wallet,
    final List<EarnThread> earnOpportunities,
    final List<PotPool> activePots,
    final bool isRefreshing,
    final DateTime? lastRefresh,
    final String? errorMessage,
  }) = _$HomeStateImpl;

  @override
  HomeStatus get status;
  @override
  Wallet? get wallet;
  @override
  List<EarnThread> get earnOpportunities;
  @override
  List<PotPool> get activePots;
  @override
  bool get isRefreshing;
  @override
  DateTime? get lastRefresh;
  @override
  String? get errorMessage;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
