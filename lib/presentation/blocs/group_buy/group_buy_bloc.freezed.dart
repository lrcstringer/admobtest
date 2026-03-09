// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupBuyEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyEventCopyWith<$Res> {
  factory $GroupBuyEventCopyWith(
    GroupBuyEvent value,
    $Res Function(GroupBuyEvent) then,
  ) = _$GroupBuyEventCopyWithImpl<$Res, GroupBuyEvent>;
}

/// @nodoc
class _$GroupBuyEventCopyWithImpl<$Res, $Val extends GroupBuyEvent>
    implements $GroupBuyEventCopyWith<$Res> {
  _$GroupBuyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadActiveGroupBuysImplCopyWith<$Res> {
  factory _$$LoadActiveGroupBuysImplCopyWith(
    _$LoadActiveGroupBuysImpl value,
    $Res Function(_$LoadActiveGroupBuysImpl) then,
  ) = __$$LoadActiveGroupBuysImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? communityId});
}

/// @nodoc
class __$$LoadActiveGroupBuysImplCopyWithImpl<$Res>
    extends _$GroupBuyEventCopyWithImpl<$Res, _$LoadActiveGroupBuysImpl>
    implements _$$LoadActiveGroupBuysImplCopyWith<$Res> {
  __$$LoadActiveGroupBuysImplCopyWithImpl(
    _$LoadActiveGroupBuysImpl _value,
    $Res Function(_$LoadActiveGroupBuysImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = freezed}) {
    return _then(
      _$LoadActiveGroupBuysImpl(
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadActiveGroupBuysImpl implements _LoadActiveGroupBuys {
  const _$LoadActiveGroupBuysImpl({this.communityId});

  @override
  final String? communityId;

  @override
  String toString() {
    return 'GroupBuyEvent.loadActiveGroupBuys(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadActiveGroupBuysImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadActiveGroupBuysImplCopyWith<_$LoadActiveGroupBuysImpl> get copyWith =>
      __$$LoadActiveGroupBuysImplCopyWithImpl<_$LoadActiveGroupBuysImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) {
    return loadActiveGroupBuys(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) {
    return loadActiveGroupBuys?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadActiveGroupBuys != null) {
      return loadActiveGroupBuys(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadActiveGroupBuys(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadActiveGroupBuys?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadActiveGroupBuys != null) {
      return loadActiveGroupBuys(this);
    }
    return orElse();
  }
}

abstract class _LoadActiveGroupBuys implements GroupBuyEvent {
  const factory _LoadActiveGroupBuys({final String? communityId}) =
      _$LoadActiveGroupBuysImpl;

  String? get communityId;

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadActiveGroupBuysImplCopyWith<_$LoadActiveGroupBuysImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadGroupBuyImplCopyWith<$Res> {
  factory _$$LoadGroupBuyImplCopyWith(
    _$LoadGroupBuyImpl value,
    $Res Function(_$LoadGroupBuyImpl) then,
  ) = __$$LoadGroupBuyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$LoadGroupBuyImplCopyWithImpl<$Res>
    extends _$GroupBuyEventCopyWithImpl<$Res, _$LoadGroupBuyImpl>
    implements _$$LoadGroupBuyImplCopyWith<$Res> {
  __$$LoadGroupBuyImplCopyWithImpl(
    _$LoadGroupBuyImpl _value,
    $Res Function(_$LoadGroupBuyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$LoadGroupBuyImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadGroupBuyImpl implements _LoadGroupBuy {
  const _$LoadGroupBuyImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'GroupBuyEvent.loadGroupBuy(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadGroupBuyImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadGroupBuyImplCopyWith<_$LoadGroupBuyImpl> get copyWith =>
      __$$LoadGroupBuyImplCopyWithImpl<_$LoadGroupBuyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) {
    return loadGroupBuy(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) {
    return loadGroupBuy?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadGroupBuy != null) {
      return loadGroupBuy(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadGroupBuy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadGroupBuy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadGroupBuy != null) {
      return loadGroupBuy(this);
    }
    return orElse();
  }
}

abstract class _LoadGroupBuy implements GroupBuyEvent {
  const factory _LoadGroupBuy(final String id) = _$LoadGroupBuyImpl;

  String get id;

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadGroupBuyImplCopyWith<_$LoadGroupBuyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMyGroupBuysImplCopyWith<$Res> {
  factory _$$LoadMyGroupBuysImplCopyWith(
    _$LoadMyGroupBuysImpl value,
    $Res Function(_$LoadMyGroupBuysImpl) then,
  ) = __$$LoadMyGroupBuysImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMyGroupBuysImplCopyWithImpl<$Res>
    extends _$GroupBuyEventCopyWithImpl<$Res, _$LoadMyGroupBuysImpl>
    implements _$$LoadMyGroupBuysImplCopyWith<$Res> {
  __$$LoadMyGroupBuysImplCopyWithImpl(
    _$LoadMyGroupBuysImpl _value,
    $Res Function(_$LoadMyGroupBuysImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMyGroupBuysImpl implements _LoadMyGroupBuys {
  const _$LoadMyGroupBuysImpl();

  @override
  String toString() {
    return 'GroupBuyEvent.loadMyGroupBuys()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMyGroupBuysImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) {
    return loadMyGroupBuys();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) {
    return loadMyGroupBuys?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadMyGroupBuys != null) {
      return loadMyGroupBuys();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadMyGroupBuys(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadMyGroupBuys?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadMyGroupBuys != null) {
      return loadMyGroupBuys(this);
    }
    return orElse();
  }
}

abstract class _LoadMyGroupBuys implements GroupBuyEvent {
  const factory _LoadMyGroupBuys() = _$LoadMyGroupBuysImpl;
}

/// @nodoc
abstract class _$$CreateGroupBuyImplCopyWith<$Res> {
  factory _$$CreateGroupBuyImplCopyWith(
    _$CreateGroupBuyImpl value,
    $Res Function(_$CreateGroupBuyImpl) then,
  ) = __$$CreateGroupBuyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String title,
    String description,
    int targetAmount,
    DateTime deadline,
    String? linkedListingId,
    int minParticipants,
    int? maxParticipants,
  });
}

/// @nodoc
class __$$CreateGroupBuyImplCopyWithImpl<$Res>
    extends _$GroupBuyEventCopyWithImpl<$Res, _$CreateGroupBuyImpl>
    implements _$$CreateGroupBuyImplCopyWith<$Res> {
  __$$CreateGroupBuyImplCopyWithImpl(
    _$CreateGroupBuyImpl _value,
    $Res Function(_$CreateGroupBuyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? targetAmount = null,
    Object? deadline = null,
    Object? linkedListingId = freezed,
    Object? minParticipants = null,
    Object? maxParticipants = freezed,
  }) {
    return _then(
      _$CreateGroupBuyImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        targetAmount: null == targetAmount
            ? _value.targetAmount
            : targetAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        deadline: null == deadline
            ? _value.deadline
            : deadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        linkedListingId: freezed == linkedListingId
            ? _value.linkedListingId
            : linkedListingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        minParticipants: null == minParticipants
            ? _value.minParticipants
            : minParticipants // ignore: cast_nullable_to_non_nullable
                  as int,
        maxParticipants: freezed == maxParticipants
            ? _value.maxParticipants
            : maxParticipants // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$CreateGroupBuyImpl implements _CreateGroupBuy {
  const _$CreateGroupBuyImpl({
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.deadline,
    this.linkedListingId,
    this.minParticipants = 2,
    this.maxParticipants,
  });

  @override
  final String title;
  @override
  final String description;
  @override
  final int targetAmount;
  @override
  final DateTime deadline;
  @override
  final String? linkedListingId;
  @override
  @JsonKey()
  final int minParticipants;
  @override
  final int? maxParticipants;

  @override
  String toString() {
    return 'GroupBuyEvent.createGroupBuy(title: $title, description: $description, targetAmount: $targetAmount, deadline: $deadline, linkedListingId: $linkedListingId, minParticipants: $minParticipants, maxParticipants: $maxParticipants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateGroupBuyImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.linkedListingId, linkedListingId) ||
                other.linkedListingId == linkedListingId) &&
            (identical(other.minParticipants, minParticipants) ||
                other.minParticipants == minParticipants) &&
            (identical(other.maxParticipants, maxParticipants) ||
                other.maxParticipants == maxParticipants));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    targetAmount,
    deadline,
    linkedListingId,
    minParticipants,
    maxParticipants,
  );

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateGroupBuyImplCopyWith<_$CreateGroupBuyImpl> get copyWith =>
      __$$CreateGroupBuyImplCopyWithImpl<_$CreateGroupBuyImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) {
    return createGroupBuy(
      title,
      description,
      targetAmount,
      deadline,
      linkedListingId,
      minParticipants,
      maxParticipants,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) {
    return createGroupBuy?.call(
      title,
      description,
      targetAmount,
      deadline,
      linkedListingId,
      minParticipants,
      maxParticipants,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (createGroupBuy != null) {
      return createGroupBuy(
        title,
        description,
        targetAmount,
        deadline,
        linkedListingId,
        minParticipants,
        maxParticipants,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return createGroupBuy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return createGroupBuy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (createGroupBuy != null) {
      return createGroupBuy(this);
    }
    return orElse();
  }
}

abstract class _CreateGroupBuy implements GroupBuyEvent {
  const factory _CreateGroupBuy({
    required final String title,
    required final String description,
    required final int targetAmount,
    required final DateTime deadline,
    final String? linkedListingId,
    final int minParticipants,
    final int? maxParticipants,
  }) = _$CreateGroupBuyImpl;

  String get title;
  String get description;
  int get targetAmount;
  DateTime get deadline;
  String? get linkedListingId;
  int get minParticipants;
  int? get maxParticipants;

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateGroupBuyImplCopyWith<_$CreateGroupBuyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JoinGroupBuyImplCopyWith<$Res> {
  factory _$$JoinGroupBuyImplCopyWith(
    _$JoinGroupBuyImpl value,
    $Res Function(_$JoinGroupBuyImpl) then,
  ) = __$$JoinGroupBuyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupBuyId, int amount, String walletId});
}

/// @nodoc
class __$$JoinGroupBuyImplCopyWithImpl<$Res>
    extends _$GroupBuyEventCopyWithImpl<$Res, _$JoinGroupBuyImpl>
    implements _$$JoinGroupBuyImplCopyWith<$Res> {
  __$$JoinGroupBuyImplCopyWithImpl(
    _$JoinGroupBuyImpl _value,
    $Res Function(_$JoinGroupBuyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupBuyId = null,
    Object? amount = null,
    Object? walletId = null,
  }) {
    return _then(
      _$JoinGroupBuyImpl(
        groupBuyId: null == groupBuyId
            ? _value.groupBuyId
            : groupBuyId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$JoinGroupBuyImpl implements _JoinGroupBuy {
  const _$JoinGroupBuyImpl({
    required this.groupBuyId,
    required this.amount,
    required this.walletId,
  });

  @override
  final String groupBuyId;
  @override
  final int amount;
  @override
  final String walletId;

  @override
  String toString() {
    return 'GroupBuyEvent.joinGroupBuy(groupBuyId: $groupBuyId, amount: $amount, walletId: $walletId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinGroupBuyImpl &&
            (identical(other.groupBuyId, groupBuyId) ||
                other.groupBuyId == groupBuyId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupBuyId, amount, walletId);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinGroupBuyImplCopyWith<_$JoinGroupBuyImpl> get copyWith =>
      __$$JoinGroupBuyImplCopyWithImpl<_$JoinGroupBuyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) {
    return joinGroupBuy(groupBuyId, amount, walletId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) {
    return joinGroupBuy?.call(groupBuyId, amount, walletId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (joinGroupBuy != null) {
      return joinGroupBuy(groupBuyId, amount, walletId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return joinGroupBuy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return joinGroupBuy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (joinGroupBuy != null) {
      return joinGroupBuy(this);
    }
    return orElse();
  }
}

abstract class _JoinGroupBuy implements GroupBuyEvent {
  const factory _JoinGroupBuy({
    required final String groupBuyId,
    required final int amount,
    required final String walletId,
  }) = _$JoinGroupBuyImpl;

  String get groupBuyId;
  int get amount;
  String get walletId;

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinGroupBuyImplCopyWith<_$JoinGroupBuyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearMessagesImplCopyWith<$Res> {
  factory _$$ClearMessagesImplCopyWith(
    _$ClearMessagesImpl value,
    $Res Function(_$ClearMessagesImpl) then,
  ) = __$$ClearMessagesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearMessagesImplCopyWithImpl<$Res>
    extends _$GroupBuyEventCopyWithImpl<$Res, _$ClearMessagesImpl>
    implements _$$ClearMessagesImplCopyWith<$Res> {
  __$$ClearMessagesImplCopyWithImpl(
    _$ClearMessagesImpl _value,
    $Res Function(_$ClearMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessagesImpl implements _ClearMessages {
  const _$ClearMessagesImpl();

  @override
  String toString() {
    return 'GroupBuyEvent.clearMessages()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearMessagesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? communityId) loadActiveGroupBuys,
    required TResult Function(String id) loadGroupBuy,
    required TResult Function() loadMyGroupBuys,
    required TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )
    createGroupBuy,
    required TResult Function(String groupBuyId, int amount, String walletId)
    joinGroupBuy,
    required TResult Function() clearMessages,
  }) {
    return clearMessages();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? communityId)? loadActiveGroupBuys,
    TResult? Function(String id)? loadGroupBuy,
    TResult? Function()? loadMyGroupBuys,
    TResult? Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult? Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult? Function()? clearMessages,
  }) {
    return clearMessages?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? communityId)? loadActiveGroupBuys,
    TResult Function(String id)? loadGroupBuy,
    TResult Function()? loadMyGroupBuys,
    TResult Function(
      String title,
      String description,
      int targetAmount,
      DateTime deadline,
      String? linkedListingId,
      int minParticipants,
      int? maxParticipants,
    )?
    createGroupBuy,
    TResult Function(String groupBuyId, int amount, String walletId)?
    joinGroupBuy,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadActiveGroupBuys value) loadActiveGroupBuys,
    required TResult Function(_LoadGroupBuy value) loadGroupBuy,
    required TResult Function(_LoadMyGroupBuys value) loadMyGroupBuys,
    required TResult Function(_CreateGroupBuy value) createGroupBuy,
    required TResult Function(_JoinGroupBuy value) joinGroupBuy,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult? Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult? Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult? Function(_CreateGroupBuy value)? createGroupBuy,
    TResult? Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadActiveGroupBuys value)? loadActiveGroupBuys,
    TResult Function(_LoadGroupBuy value)? loadGroupBuy,
    TResult Function(_LoadMyGroupBuys value)? loadMyGroupBuys,
    TResult Function(_CreateGroupBuy value)? createGroupBuy,
    TResult Function(_JoinGroupBuy value)? joinGroupBuy,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages(this);
    }
    return orElse();
  }
}

abstract class _ClearMessages implements GroupBuyEvent {
  const factory _ClearMessages() = _$ClearMessagesImpl;
}

/// @nodoc
mixin _$GroupBuyState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<GroupBuy> get activeGroupBuys => throw _privateConstructorUsedError;
  List<GroupBuy> get myGroupBuys => throw _privateConstructorUsedError;
  GroupBuy? get selectedGroupBuy => throw _privateConstructorUsedError;
  List<GroupBuyContribution> get contributions =>
      throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;
  bool get isJoining => throw _privateConstructorUsedError;
  String? get createSuccessId => throw _privateConstructorUsedError;
  String? get joinSuccessMessage => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of GroupBuyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBuyStateCopyWith<GroupBuyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyStateCopyWith<$Res> {
  factory $GroupBuyStateCopyWith(
    GroupBuyState value,
    $Res Function(GroupBuyState) then,
  ) = _$GroupBuyStateCopyWithImpl<$Res, GroupBuyState>;
  @useResult
  $Res call({
    bool isLoading,
    List<GroupBuy> activeGroupBuys,
    List<GroupBuy> myGroupBuys,
    GroupBuy? selectedGroupBuy,
    List<GroupBuyContribution> contributions,
    bool isCreating,
    bool isJoining,
    String? createSuccessId,
    String? joinSuccessMessage,
    String? errorMessage,
  });

  $GroupBuyCopyWith<$Res>? get selectedGroupBuy;
}

/// @nodoc
class _$GroupBuyStateCopyWithImpl<$Res, $Val extends GroupBuyState>
    implements $GroupBuyStateCopyWith<$Res> {
  _$GroupBuyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? activeGroupBuys = null,
    Object? myGroupBuys = null,
    Object? selectedGroupBuy = freezed,
    Object? contributions = null,
    Object? isCreating = null,
    Object? isJoining = null,
    Object? createSuccessId = freezed,
    Object? joinSuccessMessage = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeGroupBuys: null == activeGroupBuys
                ? _value.activeGroupBuys
                : activeGroupBuys // ignore: cast_nullable_to_non_nullable
                      as List<GroupBuy>,
            myGroupBuys: null == myGroupBuys
                ? _value.myGroupBuys
                : myGroupBuys // ignore: cast_nullable_to_non_nullable
                      as List<GroupBuy>,
            selectedGroupBuy: freezed == selectedGroupBuy
                ? _value.selectedGroupBuy
                : selectedGroupBuy // ignore: cast_nullable_to_non_nullable
                      as GroupBuy?,
            contributions: null == contributions
                ? _value.contributions
                : contributions // ignore: cast_nullable_to_non_nullable
                      as List<GroupBuyContribution>,
            isCreating: null == isCreating
                ? _value.isCreating
                : isCreating // ignore: cast_nullable_to_non_nullable
                      as bool,
            isJoining: null == isJoining
                ? _value.isJoining
                : isJoining // ignore: cast_nullable_to_non_nullable
                      as bool,
            createSuccessId: freezed == createSuccessId
                ? _value.createSuccessId
                : createSuccessId // ignore: cast_nullable_to_non_nullable
                      as String?,
            joinSuccessMessage: freezed == joinSuccessMessage
                ? _value.joinSuccessMessage
                : joinSuccessMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupBuyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupBuyCopyWith<$Res>? get selectedGroupBuy {
    if (_value.selectedGroupBuy == null) {
      return null;
    }

    return $GroupBuyCopyWith<$Res>(_value.selectedGroupBuy!, (value) {
      return _then(_value.copyWith(selectedGroupBuy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupBuyStateImplCopyWith<$Res>
    implements $GroupBuyStateCopyWith<$Res> {
  factory _$$GroupBuyStateImplCopyWith(
    _$GroupBuyStateImpl value,
    $Res Function(_$GroupBuyStateImpl) then,
  ) = __$$GroupBuyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    List<GroupBuy> activeGroupBuys,
    List<GroupBuy> myGroupBuys,
    GroupBuy? selectedGroupBuy,
    List<GroupBuyContribution> contributions,
    bool isCreating,
    bool isJoining,
    String? createSuccessId,
    String? joinSuccessMessage,
    String? errorMessage,
  });

  @override
  $GroupBuyCopyWith<$Res>? get selectedGroupBuy;
}

/// @nodoc
class __$$GroupBuyStateImplCopyWithImpl<$Res>
    extends _$GroupBuyStateCopyWithImpl<$Res, _$GroupBuyStateImpl>
    implements _$$GroupBuyStateImplCopyWith<$Res> {
  __$$GroupBuyStateImplCopyWithImpl(
    _$GroupBuyStateImpl _value,
    $Res Function(_$GroupBuyStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? activeGroupBuys = null,
    Object? myGroupBuys = null,
    Object? selectedGroupBuy = freezed,
    Object? contributions = null,
    Object? isCreating = null,
    Object? isJoining = null,
    Object? createSuccessId = freezed,
    Object? joinSuccessMessage = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$GroupBuyStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeGroupBuys: null == activeGroupBuys
            ? _value._activeGroupBuys
            : activeGroupBuys // ignore: cast_nullable_to_non_nullable
                  as List<GroupBuy>,
        myGroupBuys: null == myGroupBuys
            ? _value._myGroupBuys
            : myGroupBuys // ignore: cast_nullable_to_non_nullable
                  as List<GroupBuy>,
        selectedGroupBuy: freezed == selectedGroupBuy
            ? _value.selectedGroupBuy
            : selectedGroupBuy // ignore: cast_nullable_to_non_nullable
                  as GroupBuy?,
        contributions: null == contributions
            ? _value._contributions
            : contributions // ignore: cast_nullable_to_non_nullable
                  as List<GroupBuyContribution>,
        isCreating: null == isCreating
            ? _value.isCreating
            : isCreating // ignore: cast_nullable_to_non_nullable
                  as bool,
        isJoining: null == isJoining
            ? _value.isJoining
            : isJoining // ignore: cast_nullable_to_non_nullable
                  as bool,
        createSuccessId: freezed == createSuccessId
            ? _value.createSuccessId
            : createSuccessId // ignore: cast_nullable_to_non_nullable
                  as String?,
        joinSuccessMessage: freezed == joinSuccessMessage
            ? _value.joinSuccessMessage
            : joinSuccessMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GroupBuyStateImpl implements _GroupBuyState {
  const _$GroupBuyStateImpl({
    this.isLoading = false,
    final List<GroupBuy> activeGroupBuys = const [],
    final List<GroupBuy> myGroupBuys = const [],
    this.selectedGroupBuy,
    final List<GroupBuyContribution> contributions = const [],
    this.isCreating = false,
    this.isJoining = false,
    this.createSuccessId,
    this.joinSuccessMessage,
    this.errorMessage,
  }) : _activeGroupBuys = activeGroupBuys,
       _myGroupBuys = myGroupBuys,
       _contributions = contributions;

  @override
  @JsonKey()
  final bool isLoading;
  final List<GroupBuy> _activeGroupBuys;
  @override
  @JsonKey()
  List<GroupBuy> get activeGroupBuys {
    if (_activeGroupBuys is EqualUnmodifiableListView) return _activeGroupBuys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeGroupBuys);
  }

  final List<GroupBuy> _myGroupBuys;
  @override
  @JsonKey()
  List<GroupBuy> get myGroupBuys {
    if (_myGroupBuys is EqualUnmodifiableListView) return _myGroupBuys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myGroupBuys);
  }

  @override
  final GroupBuy? selectedGroupBuy;
  final List<GroupBuyContribution> _contributions;
  @override
  @JsonKey()
  List<GroupBuyContribution> get contributions {
    if (_contributions is EqualUnmodifiableListView) return _contributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributions);
  }

  @override
  @JsonKey()
  final bool isCreating;
  @override
  @JsonKey()
  final bool isJoining;
  @override
  final String? createSuccessId;
  @override
  final String? joinSuccessMessage;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'GroupBuyState(isLoading: $isLoading, activeGroupBuys: $activeGroupBuys, myGroupBuys: $myGroupBuys, selectedGroupBuy: $selectedGroupBuy, contributions: $contributions, isCreating: $isCreating, isJoining: $isJoining, createSuccessId: $createSuccessId, joinSuccessMessage: $joinSuccessMessage, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBuyStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(
              other._activeGroupBuys,
              _activeGroupBuys,
            ) &&
            const DeepCollectionEquality().equals(
              other._myGroupBuys,
              _myGroupBuys,
            ) &&
            (identical(other.selectedGroupBuy, selectedGroupBuy) ||
                other.selectedGroupBuy == selectedGroupBuy) &&
            const DeepCollectionEquality().equals(
              other._contributions,
              _contributions,
            ) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
            (identical(other.isJoining, isJoining) ||
                other.isJoining == isJoining) &&
            (identical(other.createSuccessId, createSuccessId) ||
                other.createSuccessId == createSuccessId) &&
            (identical(other.joinSuccessMessage, joinSuccessMessage) ||
                other.joinSuccessMessage == joinSuccessMessage) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_activeGroupBuys),
    const DeepCollectionEquality().hash(_myGroupBuys),
    selectedGroupBuy,
    const DeepCollectionEquality().hash(_contributions),
    isCreating,
    isJoining,
    createSuccessId,
    joinSuccessMessage,
    errorMessage,
  );

  /// Create a copy of GroupBuyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBuyStateImplCopyWith<_$GroupBuyStateImpl> get copyWith =>
      __$$GroupBuyStateImplCopyWithImpl<_$GroupBuyStateImpl>(this, _$identity);
}

abstract class _GroupBuyState implements GroupBuyState {
  const factory _GroupBuyState({
    final bool isLoading,
    final List<GroupBuy> activeGroupBuys,
    final List<GroupBuy> myGroupBuys,
    final GroupBuy? selectedGroupBuy,
    final List<GroupBuyContribution> contributions,
    final bool isCreating,
    final bool isJoining,
    final String? createSuccessId,
    final String? joinSuccessMessage,
    final String? errorMessage,
  }) = _$GroupBuyStateImpl;

  @override
  bool get isLoading;
  @override
  List<GroupBuy> get activeGroupBuys;
  @override
  List<GroupBuy> get myGroupBuys;
  @override
  GroupBuy? get selectedGroupBuy;
  @override
  List<GroupBuyContribution> get contributions;
  @override
  bool get isCreating;
  @override
  bool get isJoining;
  @override
  String? get createSuccessId;
  @override
  String? get joinSuccessMessage;
  @override
  String? get errorMessage;

  /// Create a copy of GroupBuyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBuyStateImplCopyWith<_$GroupBuyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
