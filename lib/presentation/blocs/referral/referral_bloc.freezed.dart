// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReferralEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralEventCopyWith<$Res> {
  factory $ReferralEventCopyWith(
    ReferralEvent value,
    $Res Function(ReferralEvent) then,
  ) = _$ReferralEventCopyWithImpl<$Res, ReferralEvent>;
}

/// @nodoc
class _$ReferralEventCopyWithImpl<$Res, $Val extends ReferralEvent>
    implements $ReferralEventCopyWith<$Res> {
  _$ReferralEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadStatsImplCopyWith<$Res> {
  factory _$$LoadStatsImplCopyWith(
    _$LoadStatsImpl value,
    $Res Function(_$LoadStatsImpl) then,
  ) = __$$LoadStatsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadStatsImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$LoadStatsImpl>
    implements _$$LoadStatsImplCopyWith<$Res> {
  __$$LoadStatsImplCopyWithImpl(
    _$LoadStatsImpl _value,
    $Res Function(_$LoadStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadStatsImpl implements _LoadStats {
  const _$LoadStatsImpl();

  @override
  String toString() {
    return 'ReferralEvent.loadStats()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadStatsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadStats();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadStats?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadStats != null) {
      return loadStats();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadStats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadStats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadStats != null) {
      return loadStats(this);
    }
    return orElse();
  }
}

abstract class _LoadStats implements ReferralEvent {
  const factory _LoadStats() = _$LoadStatsImpl;
}

/// @nodoc
abstract class _$$LoadReferralsImplCopyWith<$Res> {
  factory _$$LoadReferralsImplCopyWith(
    _$LoadReferralsImpl value,
    $Res Function(_$LoadReferralsImpl) then,
  ) = __$$LoadReferralsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ReferralStatus? status, int? limit, DateTime? startAfter});
}

/// @nodoc
class __$$LoadReferralsImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$LoadReferralsImpl>
    implements _$$LoadReferralsImplCopyWith<$Res> {
  __$$LoadReferralsImplCopyWithImpl(
    _$LoadReferralsImpl _value,
    $Res Function(_$LoadReferralsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? limit = freezed,
    Object? startAfter = freezed,
  }) {
    return _then(
      _$LoadReferralsImpl(
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReferralStatus?,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
        startAfter: freezed == startAfter
            ? _value.startAfter
            : startAfter // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$LoadReferralsImpl implements _LoadReferrals {
  const _$LoadReferralsImpl({this.status, this.limit, this.startAfter});

  @override
  final ReferralStatus? status;
  @override
  final int? limit;
  @override
  final DateTime? startAfter;

  @override
  String toString() {
    return 'ReferralEvent.loadReferrals(status: $status, limit: $limit, startAfter: $startAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadReferralsImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.startAfter, startAfter) ||
                other.startAfter == startAfter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, limit, startAfter);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadReferralsImplCopyWith<_$LoadReferralsImpl> get copyWith =>
      __$$LoadReferralsImplCopyWithImpl<_$LoadReferralsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadReferrals(status, limit, startAfter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadReferrals?.call(status, limit, startAfter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadReferrals != null) {
      return loadReferrals(status, limit, startAfter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadReferrals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadReferrals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadReferrals != null) {
      return loadReferrals(this);
    }
    return orElse();
  }
}

abstract class _LoadReferrals implements ReferralEvent {
  const factory _LoadReferrals({
    final ReferralStatus? status,
    final int? limit,
    final DateTime? startAfter,
  }) = _$LoadReferralsImpl;

  ReferralStatus? get status;
  int? get limit;
  DateTime? get startAfter;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadReferralsImplCopyWith<_$LoadReferralsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchReferralsImplCopyWith<$Res> {
  factory _$$WatchReferralsImplCopyWith(
    _$WatchReferralsImpl value,
    $Res Function(_$WatchReferralsImpl) then,
  ) = __$$WatchReferralsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchReferralsImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$WatchReferralsImpl>
    implements _$$WatchReferralsImplCopyWith<$Res> {
  __$$WatchReferralsImplCopyWithImpl(
    _$WatchReferralsImpl _value,
    $Res Function(_$WatchReferralsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchReferralsImpl implements _WatchReferrals {
  const _$WatchReferralsImpl();

  @override
  String toString() {
    return 'ReferralEvent.watchReferrals()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchReferralsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return watchReferrals();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return watchReferrals?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (watchReferrals != null) {
      return watchReferrals();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return watchReferrals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return watchReferrals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (watchReferrals != null) {
      return watchReferrals(this);
    }
    return orElse();
  }
}

abstract class _WatchReferrals implements ReferralEvent {
  const factory _WatchReferrals() = _$WatchReferralsImpl;
}

/// @nodoc
abstract class _$$ReferralsUpdatedImplCopyWith<$Res> {
  factory _$$ReferralsUpdatedImplCopyWith(
    _$ReferralsUpdatedImpl value,
    $Res Function(_$ReferralsUpdatedImpl) then,
  ) = __$$ReferralsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Referral> referrals});
}

/// @nodoc
class __$$ReferralsUpdatedImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$ReferralsUpdatedImpl>
    implements _$$ReferralsUpdatedImplCopyWith<$Res> {
  __$$ReferralsUpdatedImplCopyWithImpl(
    _$ReferralsUpdatedImpl _value,
    $Res Function(_$ReferralsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? referrals = null}) {
    return _then(
      _$ReferralsUpdatedImpl(
        null == referrals
            ? _value._referrals
            : referrals // ignore: cast_nullable_to_non_nullable
                  as List<Referral>,
      ),
    );
  }
}

/// @nodoc

class _$ReferralsUpdatedImpl implements _ReferralsUpdated {
  const _$ReferralsUpdatedImpl(final List<Referral> referrals)
    : _referrals = referrals;

  final List<Referral> _referrals;
  @override
  List<Referral> get referrals {
    if (_referrals is EqualUnmodifiableListView) return _referrals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_referrals);
  }

  @override
  String toString() {
    return 'ReferralEvent.referralsUpdated(referrals: $referrals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralsUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._referrals,
              _referrals,
            ));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_referrals));

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralsUpdatedImplCopyWith<_$ReferralsUpdatedImpl> get copyWith =>
      __$$ReferralsUpdatedImplCopyWithImpl<_$ReferralsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return referralsUpdated(referrals);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return referralsUpdated?.call(referrals);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (referralsUpdated != null) {
      return referralsUpdated(referrals);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return referralsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return referralsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (referralsUpdated != null) {
      return referralsUpdated(this);
    }
    return orElse();
  }
}

abstract class _ReferralsUpdated implements ReferralEvent {
  const factory _ReferralsUpdated(final List<Referral> referrals) =
      _$ReferralsUpdatedImpl;

  List<Referral> get referrals;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferralsUpdatedImplCopyWith<_$ReferralsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApplyCodeImplCopyWith<$Res> {
  factory _$$ApplyCodeImplCopyWith(
    _$ApplyCodeImpl value,
    $Res Function(_$ApplyCodeImpl) then,
  ) = __$$ApplyCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$ApplyCodeImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$ApplyCodeImpl>
    implements _$$ApplyCodeImplCopyWith<$Res> {
  __$$ApplyCodeImplCopyWithImpl(
    _$ApplyCodeImpl _value,
    $Res Function(_$ApplyCodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null}) {
    return _then(
      _$ApplyCodeImpl(
        null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ApplyCodeImpl implements _ApplyCode {
  const _$ApplyCodeImpl(this.code);

  @override
  final String code;

  @override
  String toString() {
    return 'ReferralEvent.applyCode(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyCodeImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyCodeImplCopyWith<_$ApplyCodeImpl> get copyWith =>
      __$$ApplyCodeImplCopyWithImpl<_$ApplyCodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return applyCode(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return applyCode?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (applyCode != null) {
      return applyCode(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return applyCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return applyCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (applyCode != null) {
      return applyCode(this);
    }
    return orElse();
  }
}

abstract class _ApplyCode implements ReferralEvent {
  const factory _ApplyCode(final String code) = _$ApplyCodeImpl;

  String get code;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplyCodeImplCopyWith<_$ApplyCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShareReferralImplCopyWith<$Res> {
  factory _$$ShareReferralImplCopyWith(
    _$ShareReferralImpl value,
    $Res Function(_$ShareReferralImpl) then,
  ) = __$$ShareReferralImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String platform, String? customMessage});
}

/// @nodoc
class __$$ShareReferralImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$ShareReferralImpl>
    implements _$$ShareReferralImplCopyWith<$Res> {
  __$$ShareReferralImplCopyWithImpl(
    _$ShareReferralImpl _value,
    $Res Function(_$ShareReferralImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? platform = null, Object? customMessage = freezed}) {
    return _then(
      _$ShareReferralImpl(
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
        customMessage: freezed == customMessage
            ? _value.customMessage
            : customMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ShareReferralImpl implements _ShareReferral {
  const _$ShareReferralImpl({required this.platform, this.customMessage});

  @override
  final String platform;
  @override
  final String? customMessage;

  @override
  String toString() {
    return 'ReferralEvent.shareReferral(platform: $platform, customMessage: $customMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareReferralImpl &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.customMessage, customMessage) ||
                other.customMessage == customMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, platform, customMessage);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareReferralImplCopyWith<_$ShareReferralImpl> get copyWith =>
      __$$ShareReferralImplCopyWithImpl<_$ShareReferralImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return shareReferral(platform, customMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return shareReferral?.call(platform, customMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (shareReferral != null) {
      return shareReferral(platform, customMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return shareReferral(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return shareReferral?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (shareReferral != null) {
      return shareReferral(this);
    }
    return orElse();
  }
}

abstract class _ShareReferral implements ReferralEvent {
  const factory _ShareReferral({
    required final String platform,
    final String? customMessage,
  }) = _$ShareReferralImpl;

  String get platform;
  String? get customMessage;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShareReferralImplCopyWith<_$ShareReferralImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CopyCodeImplCopyWith<$Res> {
  factory _$$CopyCodeImplCopyWith(
    _$CopyCodeImpl value,
    $Res Function(_$CopyCodeImpl) then,
  ) = __$$CopyCodeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CopyCodeImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$CopyCodeImpl>
    implements _$$CopyCodeImplCopyWith<$Res> {
  __$$CopyCodeImplCopyWithImpl(
    _$CopyCodeImpl _value,
    $Res Function(_$CopyCodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CopyCodeImpl implements _CopyCode {
  const _$CopyCodeImpl();

  @override
  String toString() {
    return 'ReferralEvent.copyCode()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CopyCodeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return copyCode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return copyCode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (copyCode != null) {
      return copyCode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return copyCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return copyCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (copyCode != null) {
      return copyCode(this);
    }
    return orElse();
  }
}

abstract class _CopyCode implements ReferralEvent {
  const factory _CopyCode() = _$CopyCodeImpl;
}

/// @nodoc
abstract class _$$ValidateCodeImplCopyWith<$Res> {
  factory _$$ValidateCodeImplCopyWith(
    _$ValidateCodeImpl value,
    $Res Function(_$ValidateCodeImpl) then,
  ) = __$$ValidateCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$ValidateCodeImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$ValidateCodeImpl>
    implements _$$ValidateCodeImplCopyWith<$Res> {
  __$$ValidateCodeImplCopyWithImpl(
    _$ValidateCodeImpl _value,
    $Res Function(_$ValidateCodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null}) {
    return _then(
      _$ValidateCodeImpl(
        null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ValidateCodeImpl implements _ValidateCode {
  const _$ValidateCodeImpl(this.code);

  @override
  final String code;

  @override
  String toString() {
    return 'ReferralEvent.validateCode(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateCodeImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidateCodeImplCopyWith<_$ValidateCodeImpl> get copyWith =>
      __$$ValidateCodeImplCopyWithImpl<_$ValidateCodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return validateCode(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return validateCode?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (validateCode != null) {
      return validateCode(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return validateCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return validateCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (validateCode != null) {
      return validateCode(this);
    }
    return orElse();
  }
}

abstract class _ValidateCode implements ReferralEvent {
  const factory _ValidateCode(final String code) = _$ValidateCodeImpl;

  String get code;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidateCodeImplCopyWith<_$ValidateCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadLeaderboardImplCopyWith<$Res> {
  factory _$$LoadLeaderboardImplCopyWith(
    _$LoadLeaderboardImpl value,
    $Res Function(_$LoadLeaderboardImpl) then,
  ) = __$$LoadLeaderboardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? limit});
}

/// @nodoc
class __$$LoadLeaderboardImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$LoadLeaderboardImpl>
    implements _$$LoadLeaderboardImplCopyWith<$Res> {
  __$$LoadLeaderboardImplCopyWithImpl(
    _$LoadLeaderboardImpl _value,
    $Res Function(_$LoadLeaderboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? limit = freezed}) {
    return _then(
      _$LoadLeaderboardImpl(
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadLeaderboardImpl implements _LoadLeaderboard {
  const _$LoadLeaderboardImpl({this.limit});

  @override
  final int? limit;

  @override
  String toString() {
    return 'ReferralEvent.loadLeaderboard(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadLeaderboardImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadLeaderboardImplCopyWith<_$LoadLeaderboardImpl> get copyWith =>
      __$$LoadLeaderboardImplCopyWithImpl<_$LoadLeaderboardImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return loadLeaderboard(limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return loadLeaderboard?.call(limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadLeaderboard != null) {
      return loadLeaderboard(limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return loadLeaderboard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return loadLeaderboard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (loadLeaderboard != null) {
      return loadLeaderboard(this);
    }
    return orElse();
  }
}

abstract class _LoadLeaderboard implements ReferralEvent {
  const factory _LoadLeaderboard({final int? limit}) = _$LoadLeaderboardImpl;

  int? get limit;

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadLeaderboardImplCopyWith<_$LoadLeaderboardImpl> get copyWith =>
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
    extends _$ReferralEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'ReferralEvent.clearError()';
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
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
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
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements ReferralEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
abstract class _$$ClearSuccessImplCopyWith<$Res> {
  factory _$$ClearSuccessImplCopyWith(
    _$ClearSuccessImpl value,
    $Res Function(_$ClearSuccessImpl) then,
  ) = __$$ClearSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSuccessImplCopyWithImpl<$Res>
    extends _$ReferralEventCopyWithImpl<$Res, _$ClearSuccessImpl>
    implements _$$ClearSuccessImplCopyWith<$Res> {
  __$$ClearSuccessImplCopyWithImpl(
    _$ClearSuccessImpl _value,
    $Res Function(_$ClearSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSuccessImpl implements _ClearSuccess {
  const _$ClearSuccessImpl();

  @override
  String toString() {
    return 'ReferralEvent.clearSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStats,
    required TResult Function(
      ReferralStatus? status,
      int? limit,
      DateTime? startAfter,
    )
    loadReferrals,
    required TResult Function() watchReferrals,
    required TResult Function(List<Referral> referrals) referralsUpdated,
    required TResult Function(String code) applyCode,
    required TResult Function(String platform, String? customMessage)
    shareReferral,
    required TResult Function() copyCode,
    required TResult Function(String code) validateCode,
    required TResult Function(int? limit) loadLeaderboard,
    required TResult Function() clearError,
    required TResult Function() clearSuccess,
  }) {
    return clearSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStats,
    TResult? Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult? Function()? watchReferrals,
    TResult? Function(List<Referral> referrals)? referralsUpdated,
    TResult? Function(String code)? applyCode,
    TResult? Function(String platform, String? customMessage)? shareReferral,
    TResult? Function()? copyCode,
    TResult? Function(String code)? validateCode,
    TResult? Function(int? limit)? loadLeaderboard,
    TResult? Function()? clearError,
    TResult? Function()? clearSuccess,
  }) {
    return clearSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStats,
    TResult Function(ReferralStatus? status, int? limit, DateTime? startAfter)?
    loadReferrals,
    TResult Function()? watchReferrals,
    TResult Function(List<Referral> referrals)? referralsUpdated,
    TResult Function(String code)? applyCode,
    TResult Function(String platform, String? customMessage)? shareReferral,
    TResult Function()? copyCode,
    TResult Function(String code)? validateCode,
    TResult Function(int? limit)? loadLeaderboard,
    TResult Function()? clearError,
    TResult Function()? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearSuccess != null) {
      return clearSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStats value) loadStats,
    required TResult Function(_LoadReferrals value) loadReferrals,
    required TResult Function(_WatchReferrals value) watchReferrals,
    required TResult Function(_ReferralsUpdated value) referralsUpdated,
    required TResult Function(_ApplyCode value) applyCode,
    required TResult Function(_ShareReferral value) shareReferral,
    required TResult Function(_CopyCode value) copyCode,
    required TResult Function(_ValidateCode value) validateCode,
    required TResult Function(_LoadLeaderboard value) loadLeaderboard,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_ClearSuccess value) clearSuccess,
  }) {
    return clearSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStats value)? loadStats,
    TResult? Function(_LoadReferrals value)? loadReferrals,
    TResult? Function(_WatchReferrals value)? watchReferrals,
    TResult? Function(_ReferralsUpdated value)? referralsUpdated,
    TResult? Function(_ApplyCode value)? applyCode,
    TResult? Function(_ShareReferral value)? shareReferral,
    TResult? Function(_CopyCode value)? copyCode,
    TResult? Function(_ValidateCode value)? validateCode,
    TResult? Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_ClearSuccess value)? clearSuccess,
  }) {
    return clearSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStats value)? loadStats,
    TResult Function(_LoadReferrals value)? loadReferrals,
    TResult Function(_WatchReferrals value)? watchReferrals,
    TResult Function(_ReferralsUpdated value)? referralsUpdated,
    TResult Function(_ApplyCode value)? applyCode,
    TResult Function(_ShareReferral value)? shareReferral,
    TResult Function(_CopyCode value)? copyCode,
    TResult Function(_ValidateCode value)? validateCode,
    TResult Function(_LoadLeaderboard value)? loadLeaderboard,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_ClearSuccess value)? clearSuccess,
    required TResult orElse(),
  }) {
    if (clearSuccess != null) {
      return clearSuccess(this);
    }
    return orElse();
  }
}

abstract class _ClearSuccess implements ReferralEvent {
  const factory _ClearSuccess() = _$ClearSuccessImpl;
}

/// @nodoc
mixin _$ReferralState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingReferrals => throw _privateConstructorUsedError;
  bool get isLoadingLeaderboard => throw _privateConstructorUsedError;
  bool get isApplying => throw _privateConstructorUsedError;
  bool get isSharing => throw _privateConstructorUsedError;
  bool get isValidating => throw _privateConstructorUsedError;
  ReferralStats? get stats => throw _privateConstructorUsedError;
  List<Referral> get referrals => throw _privateConstructorUsedError;
  List<ReferralStats> get leaderboard => throw _privateConstructorUsedError;
  bool get hasMoreReferrals => throw _privateConstructorUsedError;
  Referral? get appliedReferral => throw _privateConstructorUsedError;
  bool? get isCodeValid => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferralStateCopyWith<ReferralState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralStateCopyWith<$Res> {
  factory $ReferralStateCopyWith(
    ReferralState value,
    $Res Function(ReferralState) then,
  ) = _$ReferralStateCopyWithImpl<$Res, ReferralState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingReferrals,
    bool isLoadingLeaderboard,
    bool isApplying,
    bool isSharing,
    bool isValidating,
    ReferralStats? stats,
    List<Referral> referrals,
    List<ReferralStats> leaderboard,
    bool hasMoreReferrals,
    Referral? appliedReferral,
    bool? isCodeValid,
    String? errorMessage,
    String? successMessage,
  });

  $ReferralStatsCopyWith<$Res>? get stats;
  $ReferralCopyWith<$Res>? get appliedReferral;
}

/// @nodoc
class _$ReferralStateCopyWithImpl<$Res, $Val extends ReferralState>
    implements $ReferralStateCopyWith<$Res> {
  _$ReferralStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingReferrals = null,
    Object? isLoadingLeaderboard = null,
    Object? isApplying = null,
    Object? isSharing = null,
    Object? isValidating = null,
    Object? stats = freezed,
    Object? referrals = null,
    Object? leaderboard = null,
    Object? hasMoreReferrals = null,
    Object? appliedReferral = freezed,
    Object? isCodeValid = freezed,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingReferrals: null == isLoadingReferrals
                ? _value.isLoadingReferrals
                : isLoadingReferrals // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingLeaderboard: null == isLoadingLeaderboard
                ? _value.isLoadingLeaderboard
                : isLoadingLeaderboard // ignore: cast_nullable_to_non_nullable
                      as bool,
            isApplying: null == isApplying
                ? _value.isApplying
                : isApplying // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSharing: null == isSharing
                ? _value.isSharing
                : isSharing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isValidating: null == isValidating
                ? _value.isValidating
                : isValidating // ignore: cast_nullable_to_non_nullable
                      as bool,
            stats: freezed == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as ReferralStats?,
            referrals: null == referrals
                ? _value.referrals
                : referrals // ignore: cast_nullable_to_non_nullable
                      as List<Referral>,
            leaderboard: null == leaderboard
                ? _value.leaderboard
                : leaderboard // ignore: cast_nullable_to_non_nullable
                      as List<ReferralStats>,
            hasMoreReferrals: null == hasMoreReferrals
                ? _value.hasMoreReferrals
                : hasMoreReferrals // ignore: cast_nullable_to_non_nullable
                      as bool,
            appliedReferral: freezed == appliedReferral
                ? _value.appliedReferral
                : appliedReferral // ignore: cast_nullable_to_non_nullable
                      as Referral?,
            isCodeValid: freezed == isCodeValid
                ? _value.isCodeValid
                : isCodeValid // ignore: cast_nullable_to_non_nullable
                      as bool?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferralStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $ReferralStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferralCopyWith<$Res>? get appliedReferral {
    if (_value.appliedReferral == null) {
      return null;
    }

    return $ReferralCopyWith<$Res>(_value.appliedReferral!, (value) {
      return _then(_value.copyWith(appliedReferral: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReferralStateImplCopyWith<$Res>
    implements $ReferralStateCopyWith<$Res> {
  factory _$$ReferralStateImplCopyWith(
    _$ReferralStateImpl value,
    $Res Function(_$ReferralStateImpl) then,
  ) = __$$ReferralStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingReferrals,
    bool isLoadingLeaderboard,
    bool isApplying,
    bool isSharing,
    bool isValidating,
    ReferralStats? stats,
    List<Referral> referrals,
    List<ReferralStats> leaderboard,
    bool hasMoreReferrals,
    Referral? appliedReferral,
    bool? isCodeValid,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $ReferralStatsCopyWith<$Res>? get stats;
  @override
  $ReferralCopyWith<$Res>? get appliedReferral;
}

/// @nodoc
class __$$ReferralStateImplCopyWithImpl<$Res>
    extends _$ReferralStateCopyWithImpl<$Res, _$ReferralStateImpl>
    implements _$$ReferralStateImplCopyWith<$Res> {
  __$$ReferralStateImplCopyWithImpl(
    _$ReferralStateImpl _value,
    $Res Function(_$ReferralStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingReferrals = null,
    Object? isLoadingLeaderboard = null,
    Object? isApplying = null,
    Object? isSharing = null,
    Object? isValidating = null,
    Object? stats = freezed,
    Object? referrals = null,
    Object? leaderboard = null,
    Object? hasMoreReferrals = null,
    Object? appliedReferral = freezed,
    Object? isCodeValid = freezed,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$ReferralStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingReferrals: null == isLoadingReferrals
            ? _value.isLoadingReferrals
            : isLoadingReferrals // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingLeaderboard: null == isLoadingLeaderboard
            ? _value.isLoadingLeaderboard
            : isLoadingLeaderboard // ignore: cast_nullable_to_non_nullable
                  as bool,
        isApplying: null == isApplying
            ? _value.isApplying
            : isApplying // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSharing: null == isSharing
            ? _value.isSharing
            : isSharing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isValidating: null == isValidating
            ? _value.isValidating
            : isValidating // ignore: cast_nullable_to_non_nullable
                  as bool,
        stats: freezed == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as ReferralStats?,
        referrals: null == referrals
            ? _value._referrals
            : referrals // ignore: cast_nullable_to_non_nullable
                  as List<Referral>,
        leaderboard: null == leaderboard
            ? _value._leaderboard
            : leaderboard // ignore: cast_nullable_to_non_nullable
                  as List<ReferralStats>,
        hasMoreReferrals: null == hasMoreReferrals
            ? _value.hasMoreReferrals
            : hasMoreReferrals // ignore: cast_nullable_to_non_nullable
                  as bool,
        appliedReferral: freezed == appliedReferral
            ? _value.appliedReferral
            : appliedReferral // ignore: cast_nullable_to_non_nullable
                  as Referral?,
        isCodeValid: freezed == isCodeValid
            ? _value.isCodeValid
            : isCodeValid // ignore: cast_nullable_to_non_nullable
                  as bool?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReferralStateImpl implements _ReferralState {
  const _$ReferralStateImpl({
    this.isLoading = false,
    this.isLoadingReferrals = false,
    this.isLoadingLeaderboard = false,
    this.isApplying = false,
    this.isSharing = false,
    this.isValidating = false,
    this.stats,
    final List<Referral> referrals = const [],
    final List<ReferralStats> leaderboard = const [],
    this.hasMoreReferrals = false,
    this.appliedReferral,
    this.isCodeValid,
    this.errorMessage,
    this.successMessage,
  }) : _referrals = referrals,
       _leaderboard = leaderboard;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingReferrals;
  @override
  @JsonKey()
  final bool isLoadingLeaderboard;
  @override
  @JsonKey()
  final bool isApplying;
  @override
  @JsonKey()
  final bool isSharing;
  @override
  @JsonKey()
  final bool isValidating;
  @override
  final ReferralStats? stats;
  final List<Referral> _referrals;
  @override
  @JsonKey()
  List<Referral> get referrals {
    if (_referrals is EqualUnmodifiableListView) return _referrals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_referrals);
  }

  final List<ReferralStats> _leaderboard;
  @override
  @JsonKey()
  List<ReferralStats> get leaderboard {
    if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leaderboard);
  }

  @override
  @JsonKey()
  final bool hasMoreReferrals;
  @override
  final Referral? appliedReferral;
  @override
  final bool? isCodeValid;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'ReferralState(isLoading: $isLoading, isLoadingReferrals: $isLoadingReferrals, isLoadingLeaderboard: $isLoadingLeaderboard, isApplying: $isApplying, isSharing: $isSharing, isValidating: $isValidating, stats: $stats, referrals: $referrals, leaderboard: $leaderboard, hasMoreReferrals: $hasMoreReferrals, appliedReferral: $appliedReferral, isCodeValid: $isCodeValid, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingReferrals, isLoadingReferrals) ||
                other.isLoadingReferrals == isLoadingReferrals) &&
            (identical(other.isLoadingLeaderboard, isLoadingLeaderboard) ||
                other.isLoadingLeaderboard == isLoadingLeaderboard) &&
            (identical(other.isApplying, isApplying) ||
                other.isApplying == isApplying) &&
            (identical(other.isSharing, isSharing) ||
                other.isSharing == isSharing) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            const DeepCollectionEquality().equals(
              other._referrals,
              _referrals,
            ) &&
            const DeepCollectionEquality().equals(
              other._leaderboard,
              _leaderboard,
            ) &&
            (identical(other.hasMoreReferrals, hasMoreReferrals) ||
                other.hasMoreReferrals == hasMoreReferrals) &&
            (identical(other.appliedReferral, appliedReferral) ||
                other.appliedReferral == appliedReferral) &&
            (identical(other.isCodeValid, isCodeValid) ||
                other.isCodeValid == isCodeValid) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isLoadingReferrals,
    isLoadingLeaderboard,
    isApplying,
    isSharing,
    isValidating,
    stats,
    const DeepCollectionEquality().hash(_referrals),
    const DeepCollectionEquality().hash(_leaderboard),
    hasMoreReferrals,
    appliedReferral,
    isCodeValid,
    errorMessage,
    successMessage,
  );

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralStateImplCopyWith<_$ReferralStateImpl> get copyWith =>
      __$$ReferralStateImplCopyWithImpl<_$ReferralStateImpl>(this, _$identity);
}

abstract class _ReferralState implements ReferralState {
  const factory _ReferralState({
    final bool isLoading,
    final bool isLoadingReferrals,
    final bool isLoadingLeaderboard,
    final bool isApplying,
    final bool isSharing,
    final bool isValidating,
    final ReferralStats? stats,
    final List<Referral> referrals,
    final List<ReferralStats> leaderboard,
    final bool hasMoreReferrals,
    final Referral? appliedReferral,
    final bool? isCodeValid,
    final String? errorMessage,
    final String? successMessage,
  }) = _$ReferralStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingReferrals;
  @override
  bool get isLoadingLeaderboard;
  @override
  bool get isApplying;
  @override
  bool get isSharing;
  @override
  bool get isValidating;
  @override
  ReferralStats? get stats;
  @override
  List<Referral> get referrals;
  @override
  List<ReferralStats> get leaderboard;
  @override
  bool get hasMoreReferrals;
  @override
  Referral? get appliedReferral;
  @override
  bool? get isCodeValid;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of ReferralState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferralStateImplCopyWith<_$ReferralStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
