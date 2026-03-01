// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GiftEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftEventCopyWith<$Res> {
  factory $GiftEventCopyWith(GiftEvent value, $Res Function(GiftEvent) then) =
      _$GiftEventCopyWithImpl<$Res, GiftEvent>;
}

/// @nodoc
class _$GiftEventCopyWithImpl<$Res, $Val extends GiftEvent>
    implements $GiftEventCopyWith<$Res> {
  _$GiftEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SendGiftImplCopyWith<$Res> {
  factory _$$SendGiftImplCopyWith(
    _$SendGiftImpl value,
    $Res Function(_$SendGiftImpl) then,
  ) = __$$SendGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String recipientId,
    int amount,
    String message,
    GiftStyle style,
    String? conversationId,
    String? communityId,
  });
}

/// @nodoc
class __$$SendGiftImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$SendGiftImpl>
    implements _$$SendGiftImplCopyWith<$Res> {
  __$$SendGiftImplCopyWithImpl(
    _$SendGiftImpl _value,
    $Res Function(_$SendGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientId = null,
    Object? amount = null,
    Object? message = null,
    Object? style = null,
    Object? conversationId = freezed,
    Object? communityId = freezed,
  }) {
    return _then(
      _$SendGiftImpl(
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as GiftStyle,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendGiftImpl implements _SendGift {
  const _$SendGiftImpl({
    required this.recipientId,
    required this.amount,
    required this.message,
    required this.style,
    this.conversationId,
    this.communityId,
  });

  @override
  final String recipientId;
  @override
  final int amount;
  @override
  final String message;
  @override
  final GiftStyle style;
  @override
  final String? conversationId;
  @override
  final String? communityId;

  @override
  String toString() {
    return 'GiftEvent.sendGift(recipientId: $recipientId, amount: $amount, message: $message, style: $style, conversationId: $conversationId, communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendGiftImpl &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    recipientId,
    amount,
    message,
    style,
    conversationId,
    communityId,
  );

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendGiftImplCopyWith<_$SendGiftImpl> get copyWith =>
      __$$SendGiftImplCopyWithImpl<_$SendGiftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return sendGift(
      recipientId,
      amount,
      message,
      style,
      conversationId,
      communityId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return sendGift?.call(
      recipientId,
      amount,
      message,
      style,
      conversationId,
      communityId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (sendGift != null) {
      return sendGift(
        recipientId,
        amount,
        message,
        style,
        conversationId,
        communityId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return sendGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return sendGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (sendGift != null) {
      return sendGift(this);
    }
    return orElse();
  }
}

abstract class _SendGift implements GiftEvent {
  const factory _SendGift({
    required final String recipientId,
    required final int amount,
    required final String message,
    required final GiftStyle style,
    final String? conversationId,
    final String? communityId,
  }) = _$SendGiftImpl;

  String get recipientId;
  int get amount;
  String get message;
  GiftStyle get style;
  String? get conversationId;
  String? get communityId;

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendGiftImplCopyWith<_$SendGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenGiftImplCopyWith<$Res> {
  factory _$$OpenGiftImplCopyWith(
    _$OpenGiftImpl value,
    $Res Function(_$OpenGiftImpl) then,
  ) = __$$OpenGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String giftId});
}

/// @nodoc
class __$$OpenGiftImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$OpenGiftImpl>
    implements _$$OpenGiftImplCopyWith<$Res> {
  __$$OpenGiftImplCopyWithImpl(
    _$OpenGiftImpl _value,
    $Res Function(_$OpenGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? giftId = null}) {
    return _then(
      _$OpenGiftImpl(
        null == giftId
            ? _value.giftId
            : giftId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OpenGiftImpl implements _OpenGift {
  const _$OpenGiftImpl(this.giftId);

  @override
  final String giftId;

  @override
  String toString() {
    return 'GiftEvent.openGift(giftId: $giftId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenGiftImpl &&
            (identical(other.giftId, giftId) || other.giftId == giftId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, giftId);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenGiftImplCopyWith<_$OpenGiftImpl> get copyWith =>
      __$$OpenGiftImplCopyWithImpl<_$OpenGiftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return openGift(giftId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return openGift?.call(giftId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (openGift != null) {
      return openGift(giftId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return openGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return openGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (openGift != null) {
      return openGift(this);
    }
    return orElse();
  }
}

abstract class _OpenGift implements GiftEvent {
  const factory _OpenGift(final String giftId) = _$OpenGiftImpl;

  String get giftId;

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenGiftImplCopyWith<_$OpenGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClaimGiftImplCopyWith<$Res> {
  factory _$$ClaimGiftImplCopyWith(
    _$ClaimGiftImpl value,
    $Res Function(_$ClaimGiftImpl) then,
  ) = __$$ClaimGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String giftId});
}

/// @nodoc
class __$$ClaimGiftImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$ClaimGiftImpl>
    implements _$$ClaimGiftImplCopyWith<$Res> {
  __$$ClaimGiftImplCopyWithImpl(
    _$ClaimGiftImpl _value,
    $Res Function(_$ClaimGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? giftId = null}) {
    return _then(
      _$ClaimGiftImpl(
        null == giftId
            ? _value.giftId
            : giftId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClaimGiftImpl implements _ClaimGift {
  const _$ClaimGiftImpl(this.giftId);

  @override
  final String giftId;

  @override
  String toString() {
    return 'GiftEvent.claimGift(giftId: $giftId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimGiftImpl &&
            (identical(other.giftId, giftId) || other.giftId == giftId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, giftId);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimGiftImplCopyWith<_$ClaimGiftImpl> get copyWith =>
      __$$ClaimGiftImplCopyWithImpl<_$ClaimGiftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return claimGift(giftId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return claimGift?.call(giftId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (claimGift != null) {
      return claimGift(giftId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return claimGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return claimGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (claimGift != null) {
      return claimGift(this);
    }
    return orElse();
  }
}

abstract class _ClaimGift implements GiftEvent {
  const factory _ClaimGift(final String giftId) = _$ClaimGiftImpl;

  String get giftId;

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimGiftImplCopyWith<_$ClaimGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSentGiftsImplCopyWith<$Res> {
  factory _$$LoadSentGiftsImplCopyWith(
    _$LoadSentGiftsImpl value,
    $Res Function(_$LoadSentGiftsImpl) then,
  ) = __$$LoadSentGiftsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSentGiftsImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$LoadSentGiftsImpl>
    implements _$$LoadSentGiftsImplCopyWith<$Res> {
  __$$LoadSentGiftsImplCopyWithImpl(
    _$LoadSentGiftsImpl _value,
    $Res Function(_$LoadSentGiftsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSentGiftsImpl implements _LoadSentGifts {
  const _$LoadSentGiftsImpl();

  @override
  String toString() {
    return 'GiftEvent.loadSentGifts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSentGiftsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return loadSentGifts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return loadSentGifts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadSentGifts != null) {
      return loadSentGifts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return loadSentGifts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return loadSentGifts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadSentGifts != null) {
      return loadSentGifts(this);
    }
    return orElse();
  }
}

abstract class _LoadSentGifts implements GiftEvent {
  const factory _LoadSentGifts() = _$LoadSentGiftsImpl;
}

/// @nodoc
abstract class _$$LoadReceivedGiftsImplCopyWith<$Res> {
  factory _$$LoadReceivedGiftsImplCopyWith(
    _$LoadReceivedGiftsImpl value,
    $Res Function(_$LoadReceivedGiftsImpl) then,
  ) = __$$LoadReceivedGiftsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadReceivedGiftsImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$LoadReceivedGiftsImpl>
    implements _$$LoadReceivedGiftsImplCopyWith<$Res> {
  __$$LoadReceivedGiftsImplCopyWithImpl(
    _$LoadReceivedGiftsImpl _value,
    $Res Function(_$LoadReceivedGiftsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadReceivedGiftsImpl implements _LoadReceivedGifts {
  const _$LoadReceivedGiftsImpl();

  @override
  String toString() {
    return 'GiftEvent.loadReceivedGifts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadReceivedGiftsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return loadReceivedGifts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return loadReceivedGifts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadReceivedGifts != null) {
      return loadReceivedGifts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return loadReceivedGifts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return loadReceivedGifts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadReceivedGifts != null) {
      return loadReceivedGifts(this);
    }
    return orElse();
  }
}

abstract class _LoadReceivedGifts implements GiftEvent {
  const factory _LoadReceivedGifts() = _$LoadReceivedGiftsImpl;
}

/// @nodoc
abstract class _$$WatchGiftImplCopyWith<$Res> {
  factory _$$WatchGiftImplCopyWith(
    _$WatchGiftImpl value,
    $Res Function(_$WatchGiftImpl) then,
  ) = __$$WatchGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String giftId});
}

/// @nodoc
class __$$WatchGiftImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$WatchGiftImpl>
    implements _$$WatchGiftImplCopyWith<$Res> {
  __$$WatchGiftImplCopyWithImpl(
    _$WatchGiftImpl _value,
    $Res Function(_$WatchGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? giftId = null}) {
    return _then(
      _$WatchGiftImpl(
        null == giftId
            ? _value.giftId
            : giftId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchGiftImpl implements _WatchGift {
  const _$WatchGiftImpl(this.giftId);

  @override
  final String giftId;

  @override
  String toString() {
    return 'GiftEvent.watchGift(giftId: $giftId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchGiftImpl &&
            (identical(other.giftId, giftId) || other.giftId == giftId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, giftId);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchGiftImplCopyWith<_$WatchGiftImpl> get copyWith =>
      __$$WatchGiftImplCopyWithImpl<_$WatchGiftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return watchGift(giftId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return watchGift?.call(giftId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (watchGift != null) {
      return watchGift(giftId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return watchGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return watchGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (watchGift != null) {
      return watchGift(this);
    }
    return orElse();
  }
}

abstract class _WatchGift implements GiftEvent {
  const factory _WatchGift(final String giftId) = _$WatchGiftImpl;

  String get giftId;

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchGiftImplCopyWith<_$WatchGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GiftUpdatedImplCopyWith<$Res> {
  factory _$$GiftUpdatedImplCopyWith(
    _$GiftUpdatedImpl value,
    $Res Function(_$GiftUpdatedImpl) then,
  ) = __$$GiftUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Gift gift});

  $GiftCopyWith<$Res> get gift;
}

/// @nodoc
class __$$GiftUpdatedImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$GiftUpdatedImpl>
    implements _$$GiftUpdatedImplCopyWith<$Res> {
  __$$GiftUpdatedImplCopyWithImpl(
    _$GiftUpdatedImpl _value,
    $Res Function(_$GiftUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gift = null}) {
    return _then(
      _$GiftUpdatedImpl(
        null == gift
            ? _value.gift
            : gift // ignore: cast_nullable_to_non_nullable
                  as Gift,
      ),
    );
  }

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftCopyWith<$Res> get gift {
    return $GiftCopyWith<$Res>(_value.gift, (value) {
      return _then(_value.copyWith(gift: value));
    });
  }
}

/// @nodoc

class _$GiftUpdatedImpl implements _GiftUpdated {
  const _$GiftUpdatedImpl(this.gift);

  @override
  final Gift gift;

  @override
  String toString() {
    return 'GiftEvent.giftUpdated(gift: $gift)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftUpdatedImpl &&
            (identical(other.gift, gift) || other.gift == gift));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gift);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftUpdatedImplCopyWith<_$GiftUpdatedImpl> get copyWith =>
      __$$GiftUpdatedImplCopyWithImpl<_$GiftUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return giftUpdated(gift);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return giftUpdated?.call(gift);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (giftUpdated != null) {
      return giftUpdated(gift);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return giftUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return giftUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (giftUpdated != null) {
      return giftUpdated(this);
    }
    return orElse();
  }
}

abstract class _GiftUpdated implements GiftEvent {
  const factory _GiftUpdated(final Gift gift) = _$GiftUpdatedImpl;

  Gift get gift;

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftUpdatedImplCopyWith<_$GiftUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadGiftStatsImplCopyWith<$Res> {
  factory _$$LoadGiftStatsImplCopyWith(
    _$LoadGiftStatsImpl value,
    $Res Function(_$LoadGiftStatsImpl) then,
  ) = __$$LoadGiftStatsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadGiftStatsImplCopyWithImpl<$Res>
    extends _$GiftEventCopyWithImpl<$Res, _$LoadGiftStatsImpl>
    implements _$$LoadGiftStatsImplCopyWith<$Res> {
  __$$LoadGiftStatsImplCopyWithImpl(
    _$LoadGiftStatsImpl _value,
    $Res Function(_$LoadGiftStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadGiftStatsImpl implements _LoadGiftStats {
  const _$LoadGiftStatsImpl();

  @override
  String toString() {
    return 'GiftEvent.loadGiftStats()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadGiftStatsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return loadGiftStats();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return loadGiftStats?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadGiftStats != null) {
      return loadGiftStats();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return loadGiftStats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return loadGiftStats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadGiftStats != null) {
      return loadGiftStats(this);
    }
    return orElse();
  }
}

abstract class _LoadGiftStats implements GiftEvent {
  const factory _LoadGiftStats() = _$LoadGiftStatsImpl;
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
    extends _$GiftEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'GiftEvent.clearError()';
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
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
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
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
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

abstract class _ClearError implements GiftEvent {
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
    extends _$GiftEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
    _$ResetImpl _value,
    $Res Function(_$ResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'GiftEvent.reset()';
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
    required TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )
    sendGift,
    required TResult Function(String giftId) openGift,
    required TResult Function(String giftId) claimGift,
    required TResult Function() loadSentGifts,
    required TResult Function() loadReceivedGifts,
    required TResult Function(String giftId) watchGift,
    required TResult Function(Gift gift) giftUpdated,
    required TResult Function() loadGiftStats,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult? Function(String giftId)? openGift,
    TResult? Function(String giftId)? claimGift,
    TResult? Function()? loadSentGifts,
    TResult? Function()? loadReceivedGifts,
    TResult? Function(String giftId)? watchGift,
    TResult? Function(Gift gift)? giftUpdated,
    TResult? Function()? loadGiftStats,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      int amount,
      String message,
      GiftStyle style,
      String? conversationId,
      String? communityId,
    )?
    sendGift,
    TResult Function(String giftId)? openGift,
    TResult Function(String giftId)? claimGift,
    TResult Function()? loadSentGifts,
    TResult Function()? loadReceivedGifts,
    TResult Function(String giftId)? watchGift,
    TResult Function(Gift gift)? giftUpdated,
    TResult Function()? loadGiftStats,
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
    required TResult Function(_SendGift value) sendGift,
    required TResult Function(_OpenGift value) openGift,
    required TResult Function(_ClaimGift value) claimGift,
    required TResult Function(_LoadSentGifts value) loadSentGifts,
    required TResult Function(_LoadReceivedGifts value) loadReceivedGifts,
    required TResult Function(_WatchGift value) watchGift,
    required TResult Function(_GiftUpdated value) giftUpdated,
    required TResult Function(_LoadGiftStats value) loadGiftStats,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendGift value)? sendGift,
    TResult? Function(_OpenGift value)? openGift,
    TResult? Function(_ClaimGift value)? claimGift,
    TResult? Function(_LoadSentGifts value)? loadSentGifts,
    TResult? Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult? Function(_WatchGift value)? watchGift,
    TResult? Function(_GiftUpdated value)? giftUpdated,
    TResult? Function(_LoadGiftStats value)? loadGiftStats,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendGift value)? sendGift,
    TResult Function(_OpenGift value)? openGift,
    TResult Function(_ClaimGift value)? claimGift,
    TResult Function(_LoadSentGifts value)? loadSentGifts,
    TResult Function(_LoadReceivedGifts value)? loadReceivedGifts,
    TResult Function(_WatchGift value)? watchGift,
    TResult Function(_GiftUpdated value)? giftUpdated,
    TResult Function(_LoadGiftStats value)? loadGiftStats,
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

abstract class _Reset implements GiftEvent {
  const factory _Reset() = _$ResetImpl;
}

/// @nodoc
mixin _$GiftState {
  List<Gift> get sentGifts => throw _privateConstructorUsedError;
  List<Gift> get receivedGifts => throw _privateConstructorUsedError;
  Gift? get activeGift => throw _privateConstructorUsedError;
  GiftStats? get stats => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get isClaiming => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftStateCopyWith<GiftState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftStateCopyWith<$Res> {
  factory $GiftStateCopyWith(GiftState value, $Res Function(GiftState) then) =
      _$GiftStateCopyWithImpl<$Res, GiftState>;
  @useResult
  $Res call({
    List<Gift> sentGifts,
    List<Gift> receivedGifts,
    Gift? activeGift,
    GiftStats? stats,
    bool isLoading,
    bool isSending,
    bool isClaiming,
    String? errorMessage,
  });

  $GiftCopyWith<$Res>? get activeGift;
  $GiftStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$GiftStateCopyWithImpl<$Res, $Val extends GiftState>
    implements $GiftStateCopyWith<$Res> {
  _$GiftStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentGifts = null,
    Object? receivedGifts = null,
    Object? activeGift = freezed,
    Object? stats = freezed,
    Object? isLoading = null,
    Object? isSending = null,
    Object? isClaiming = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            sentGifts: null == sentGifts
                ? _value.sentGifts
                : sentGifts // ignore: cast_nullable_to_non_nullable
                      as List<Gift>,
            receivedGifts: null == receivedGifts
                ? _value.receivedGifts
                : receivedGifts // ignore: cast_nullable_to_non_nullable
                      as List<Gift>,
            activeGift: freezed == activeGift
                ? _value.activeGift
                : activeGift // ignore: cast_nullable_to_non_nullable
                      as Gift?,
            stats: freezed == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as GiftStats?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            isClaiming: null == isClaiming
                ? _value.isClaiming
                : isClaiming // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftCopyWith<$Res>? get activeGift {
    if (_value.activeGift == null) {
      return null;
    }

    return $GiftCopyWith<$Res>(_value.activeGift!, (value) {
      return _then(_value.copyWith(activeGift: value) as $Val);
    });
  }

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $GiftStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GiftStateImplCopyWith<$Res>
    implements $GiftStateCopyWith<$Res> {
  factory _$$GiftStateImplCopyWith(
    _$GiftStateImpl value,
    $Res Function(_$GiftStateImpl) then,
  ) = __$$GiftStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Gift> sentGifts,
    List<Gift> receivedGifts,
    Gift? activeGift,
    GiftStats? stats,
    bool isLoading,
    bool isSending,
    bool isClaiming,
    String? errorMessage,
  });

  @override
  $GiftCopyWith<$Res>? get activeGift;
  @override
  $GiftStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$GiftStateImplCopyWithImpl<$Res>
    extends _$GiftStateCopyWithImpl<$Res, _$GiftStateImpl>
    implements _$$GiftStateImplCopyWith<$Res> {
  __$$GiftStateImplCopyWithImpl(
    _$GiftStateImpl _value,
    $Res Function(_$GiftStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentGifts = null,
    Object? receivedGifts = null,
    Object? activeGift = freezed,
    Object? stats = freezed,
    Object? isLoading = null,
    Object? isSending = null,
    Object? isClaiming = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$GiftStateImpl(
        sentGifts: null == sentGifts
            ? _value._sentGifts
            : sentGifts // ignore: cast_nullable_to_non_nullable
                  as List<Gift>,
        receivedGifts: null == receivedGifts
            ? _value._receivedGifts
            : receivedGifts // ignore: cast_nullable_to_non_nullable
                  as List<Gift>,
        activeGift: freezed == activeGift
            ? _value.activeGift
            : activeGift // ignore: cast_nullable_to_non_nullable
                  as Gift?,
        stats: freezed == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as GiftStats?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        isClaiming: null == isClaiming
            ? _value.isClaiming
            : isClaiming // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GiftStateImpl implements _GiftState {
  const _$GiftStateImpl({
    final List<Gift> sentGifts = const [],
    final List<Gift> receivedGifts = const [],
    this.activeGift,
    this.stats,
    this.isLoading = false,
    this.isSending = false,
    this.isClaiming = false,
    this.errorMessage,
  }) : _sentGifts = sentGifts,
       _receivedGifts = receivedGifts;

  final List<Gift> _sentGifts;
  @override
  @JsonKey()
  List<Gift> get sentGifts {
    if (_sentGifts is EqualUnmodifiableListView) return _sentGifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentGifts);
  }

  final List<Gift> _receivedGifts;
  @override
  @JsonKey()
  List<Gift> get receivedGifts {
    if (_receivedGifts is EqualUnmodifiableListView) return _receivedGifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receivedGifts);
  }

  @override
  final Gift? activeGift;
  @override
  final GiftStats? stats;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isClaiming;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'GiftState(sentGifts: $sentGifts, receivedGifts: $receivedGifts, activeGift: $activeGift, stats: $stats, isLoading: $isLoading, isSending: $isSending, isClaiming: $isClaiming, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftStateImpl &&
            const DeepCollectionEquality().equals(
              other._sentGifts,
              _sentGifts,
            ) &&
            const DeepCollectionEquality().equals(
              other._receivedGifts,
              _receivedGifts,
            ) &&
            (identical(other.activeGift, activeGift) ||
                other.activeGift == activeGift) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isClaiming, isClaiming) ||
                other.isClaiming == isClaiming) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sentGifts),
    const DeepCollectionEquality().hash(_receivedGifts),
    activeGift,
    stats,
    isLoading,
    isSending,
    isClaiming,
    errorMessage,
  );

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftStateImplCopyWith<_$GiftStateImpl> get copyWith =>
      __$$GiftStateImplCopyWithImpl<_$GiftStateImpl>(this, _$identity);
}

abstract class _GiftState implements GiftState {
  const factory _GiftState({
    final List<Gift> sentGifts,
    final List<Gift> receivedGifts,
    final Gift? activeGift,
    final GiftStats? stats,
    final bool isLoading,
    final bool isSending,
    final bool isClaiming,
    final String? errorMessage,
  }) = _$GiftStateImpl;

  @override
  List<Gift> get sentGifts;
  @override
  List<Gift> get receivedGifts;
  @override
  Gift? get activeGift;
  @override
  GiftStats? get stats;
  @override
  bool get isLoading;
  @override
  bool get isSending;
  @override
  bool get isClaiming;
  @override
  String? get errorMessage;

  /// Create a copy of GiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftStateImplCopyWith<_$GiftStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
