// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RiskEvent {
  String get eventId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  RiskEventType get type => throw _privateConstructorUsedError;
  RiskSeverity get severity => throw _privateConstructorUsedError;
  RiskEventStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Create a copy of RiskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskEventCopyWith<RiskEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskEventCopyWith<$Res> {
  factory $RiskEventCopyWith(RiskEvent value, $Res Function(RiskEvent) then) =
      _$RiskEventCopyWithImpl<$Res, RiskEvent>;
  @useResult
  $Res call({
    String eventId,
    String userId,
    RiskEventType type,
    RiskSeverity severity,
    RiskEventStatus status,
    DateTime createdAt,
    String? deviceId,
    String? details,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class _$RiskEventCopyWithImpl<$Res, $Val extends RiskEvent>
    implements $RiskEventCopyWith<$Res> {
  _$RiskEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? userId = null,
    Object? type = null,
    Object? severity = null,
    Object? status = null,
    Object? createdAt = null,
    Object? deviceId = freezed,
    Object? details = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            eventId: null == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RiskEventType,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as RiskSeverity,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RiskEventStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            deviceId: freezed == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as String?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RiskEventImplCopyWith<$Res>
    implements $RiskEventCopyWith<$Res> {
  factory _$$RiskEventImplCopyWith(
    _$RiskEventImpl value,
    $Res Function(_$RiskEventImpl) then,
  ) = __$$RiskEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String eventId,
    String userId,
    RiskEventType type,
    RiskSeverity severity,
    RiskEventStatus status,
    DateTime createdAt,
    String? deviceId,
    String? details,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$RiskEventImplCopyWithImpl<$Res>
    extends _$RiskEventCopyWithImpl<$Res, _$RiskEventImpl>
    implements _$$RiskEventImplCopyWith<$Res> {
  __$$RiskEventImplCopyWithImpl(
    _$RiskEventImpl _value,
    $Res Function(_$RiskEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RiskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? userId = null,
    Object? type = null,
    Object? severity = null,
    Object? status = null,
    Object? createdAt = null,
    Object? deviceId = freezed,
    Object? details = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$RiskEventImpl(
        eventId: null == eventId
            ? _value.eventId
            : eventId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RiskEventType,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as RiskSeverity,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RiskEventStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        deviceId: freezed == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$RiskEventImpl extends _RiskEvent {
  const _$RiskEventImpl({
    required this.eventId,
    required this.userId,
    required this.type,
    required this.severity,
    required this.status,
    required this.createdAt,
    this.deviceId,
    this.details,
    this.resolvedAt,
  }) : super._();

  @override
  final String eventId;
  @override
  final String userId;
  @override
  final RiskEventType type;
  @override
  final RiskSeverity severity;
  @override
  final RiskEventStatus status;
  @override
  final DateTime createdAt;
  @override
  final String? deviceId;
  @override
  final String? details;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'RiskEvent(eventId: $eventId, userId: $userId, type: $type, severity: $severity, status: $status, createdAt: $createdAt, deviceId: $deviceId, details: $details, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskEventImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    eventId,
    userId,
    type,
    severity,
    status,
    createdAt,
    deviceId,
    details,
    resolvedAt,
  );

  /// Create a copy of RiskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskEventImplCopyWith<_$RiskEventImpl> get copyWith =>
      __$$RiskEventImplCopyWithImpl<_$RiskEventImpl>(this, _$identity);
}

abstract class _RiskEvent extends RiskEvent {
  const factory _RiskEvent({
    required final String eventId,
    required final String userId,
    required final RiskEventType type,
    required final RiskSeverity severity,
    required final RiskEventStatus status,
    required final DateTime createdAt,
    final String? deviceId,
    final String? details,
    final DateTime? resolvedAt,
  }) = _$RiskEventImpl;
  const _RiskEvent._() : super._();

  @override
  String get eventId;
  @override
  String get userId;
  @override
  RiskEventType get type;
  @override
  RiskSeverity get severity;
  @override
  RiskEventStatus get status;
  @override
  DateTime get createdAt;
  @override
  String? get deviceId;
  @override
  String? get details;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of RiskEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskEventImplCopyWith<_$RiskEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
