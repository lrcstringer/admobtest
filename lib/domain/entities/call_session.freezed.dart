// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CallSession {
  String get callId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get callerId => throw _privateConstructorUsedError;
  String get calleeId => throw _privateConstructorUsedError;
  String get callerName => throw _privateConstructorUsedError;
  String? get callerAvatarUrl => throw _privateConstructorUsedError;
  CallType get callType => throw _privateConstructorUsedError;
  CallStatus get status => throw _privateConstructorUsedError;

  /// SDP offer from the caller: {type, sdp}.
  Map<String, String>? get offer => throw _privateConstructorUsedError;

  /// SDP answer from the callee: {type, sdp}.
  Map<String, String>? get answer => throw _privateConstructorUsedError;

  /// Video upgrade request state: 'pending' | 'accepted' | 'declined'.
  String? get videoUpgradeRequest => throw _privateConstructorUsedError;
  String? get videoUpgradeRequesterId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get answeredAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  String? get endReason => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError;

  /// Create a copy of CallSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallSessionCopyWith<CallSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallSessionCopyWith<$Res> {
  factory $CallSessionCopyWith(
    CallSession value,
    $Res Function(CallSession) then,
  ) = _$CallSessionCopyWithImpl<$Res, CallSession>;
  @useResult
  $Res call({
    String callId,
    String conversationId,
    String callerId,
    String calleeId,
    String callerName,
    String? callerAvatarUrl,
    CallType callType,
    CallStatus status,
    Map<String, String>? offer,
    Map<String, String>? answer,
    String? videoUpgradeRequest,
    String? videoUpgradeRequesterId,
    DateTime? createdAt,
    DateTime? answeredAt,
    DateTime? endedAt,
    String? endReason,
    int? durationSeconds,
  });
}

/// @nodoc
class _$CallSessionCopyWithImpl<$Res, $Val extends CallSession>
    implements $CallSessionCopyWith<$Res> {
  _$CallSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? conversationId = null,
    Object? callerId = null,
    Object? calleeId = null,
    Object? callerName = null,
    Object? callerAvatarUrl = freezed,
    Object? callType = null,
    Object? status = null,
    Object? offer = freezed,
    Object? answer = freezed,
    Object? videoUpgradeRequest = freezed,
    Object? videoUpgradeRequesterId = freezed,
    Object? createdAt = freezed,
    Object? answeredAt = freezed,
    Object? endedAt = freezed,
    Object? endReason = freezed,
    Object? durationSeconds = freezed,
  }) {
    return _then(
      _value.copyWith(
            callId: null == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            callerId: null == callerId
                ? _value.callerId
                : callerId // ignore: cast_nullable_to_non_nullable
                      as String,
            calleeId: null == calleeId
                ? _value.calleeId
                : calleeId // ignore: cast_nullable_to_non_nullable
                      as String,
            callerName: null == callerName
                ? _value.callerName
                : callerName // ignore: cast_nullable_to_non_nullable
                      as String,
            callerAvatarUrl: freezed == callerAvatarUrl
                ? _value.callerAvatarUrl
                : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            callType: null == callType
                ? _value.callType
                : callType // ignore: cast_nullable_to_non_nullable
                      as CallType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CallStatus,
            offer: freezed == offer
                ? _value.offer
                : offer // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            answer: freezed == answer
                ? _value.answer
                : answer // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            videoUpgradeRequest: freezed == videoUpgradeRequest
                ? _value.videoUpgradeRequest
                : videoUpgradeRequest // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoUpgradeRequesterId: freezed == videoUpgradeRequesterId
                ? _value.videoUpgradeRequesterId
                : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            answeredAt: freezed == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endReason: freezed == endReason
                ? _value.endReason
                : endReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationSeconds: freezed == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallSessionImplCopyWith<$Res>
    implements $CallSessionCopyWith<$Res> {
  factory _$$CallSessionImplCopyWith(
    _$CallSessionImpl value,
    $Res Function(_$CallSessionImpl) then,
  ) = __$$CallSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String callId,
    String conversationId,
    String callerId,
    String calleeId,
    String callerName,
    String? callerAvatarUrl,
    CallType callType,
    CallStatus status,
    Map<String, String>? offer,
    Map<String, String>? answer,
    String? videoUpgradeRequest,
    String? videoUpgradeRequesterId,
    DateTime? createdAt,
    DateTime? answeredAt,
    DateTime? endedAt,
    String? endReason,
    int? durationSeconds,
  });
}

/// @nodoc
class __$$CallSessionImplCopyWithImpl<$Res>
    extends _$CallSessionCopyWithImpl<$Res, _$CallSessionImpl>
    implements _$$CallSessionImplCopyWith<$Res> {
  __$$CallSessionImplCopyWithImpl(
    _$CallSessionImpl _value,
    $Res Function(_$CallSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? conversationId = null,
    Object? callerId = null,
    Object? calleeId = null,
    Object? callerName = null,
    Object? callerAvatarUrl = freezed,
    Object? callType = null,
    Object? status = null,
    Object? offer = freezed,
    Object? answer = freezed,
    Object? videoUpgradeRequest = freezed,
    Object? videoUpgradeRequesterId = freezed,
    Object? createdAt = freezed,
    Object? answeredAt = freezed,
    Object? endedAt = freezed,
    Object? endReason = freezed,
    Object? durationSeconds = freezed,
  }) {
    return _then(
      _$CallSessionImpl(
        callId: null == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        callerId: null == callerId
            ? _value.callerId
            : callerId // ignore: cast_nullable_to_non_nullable
                  as String,
        calleeId: null == calleeId
            ? _value.calleeId
            : calleeId // ignore: cast_nullable_to_non_nullable
                  as String,
        callerName: null == callerName
            ? _value.callerName
            : callerName // ignore: cast_nullable_to_non_nullable
                  as String,
        callerAvatarUrl: freezed == callerAvatarUrl
            ? _value.callerAvatarUrl
            : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as CallType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CallStatus,
        offer: freezed == offer
            ? _value._offer
            : offer // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        answer: freezed == answer
            ? _value._answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        videoUpgradeRequest: freezed == videoUpgradeRequest
            ? _value.videoUpgradeRequest
            : videoUpgradeRequest // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoUpgradeRequesterId: freezed == videoUpgradeRequesterId
            ? _value.videoUpgradeRequesterId
            : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        answeredAt: freezed == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endReason: freezed == endReason
            ? _value.endReason
            : endReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$CallSessionImpl implements _CallSession {
  const _$CallSessionImpl({
    required this.callId,
    required this.conversationId,
    required this.callerId,
    required this.calleeId,
    required this.callerName,
    this.callerAvatarUrl,
    required this.callType,
    required this.status,
    final Map<String, String>? offer,
    final Map<String, String>? answer,
    this.videoUpgradeRequest,
    this.videoUpgradeRequesterId,
    this.createdAt,
    this.answeredAt,
    this.endedAt,
    this.endReason,
    this.durationSeconds,
  }) : _offer = offer,
       _answer = answer;

  @override
  final String callId;
  @override
  final String conversationId;
  @override
  final String callerId;
  @override
  final String calleeId;
  @override
  final String callerName;
  @override
  final String? callerAvatarUrl;
  @override
  final CallType callType;
  @override
  final CallStatus status;

  /// SDP offer from the caller: {type, sdp}.
  final Map<String, String>? _offer;

  /// SDP offer from the caller: {type, sdp}.
  @override
  Map<String, String>? get offer {
    final value = _offer;
    if (value == null) return null;
    if (_offer is EqualUnmodifiableMapView) return _offer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// SDP answer from the callee: {type, sdp}.
  final Map<String, String>? _answer;

  /// SDP answer from the callee: {type, sdp}.
  @override
  Map<String, String>? get answer {
    final value = _answer;
    if (value == null) return null;
    if (_answer is EqualUnmodifiableMapView) return _answer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Video upgrade request state: 'pending' | 'accepted' | 'declined'.
  @override
  final String? videoUpgradeRequest;
  @override
  final String? videoUpgradeRequesterId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? answeredAt;
  @override
  final DateTime? endedAt;
  @override
  final String? endReason;
  @override
  final int? durationSeconds;

  @override
  String toString() {
    return 'CallSession(callId: $callId, conversationId: $conversationId, callerId: $callerId, calleeId: $calleeId, callerName: $callerName, callerAvatarUrl: $callerAvatarUrl, callType: $callType, status: $status, offer: $offer, answer: $answer, videoUpgradeRequest: $videoUpgradeRequest, videoUpgradeRequesterId: $videoUpgradeRequesterId, createdAt: $createdAt, answeredAt: $answeredAt, endedAt: $endedAt, endReason: $endReason, durationSeconds: $durationSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSessionImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.calleeId, calleeId) ||
                other.calleeId == calleeId) &&
            (identical(other.callerName, callerName) ||
                other.callerName == callerName) &&
            (identical(other.callerAvatarUrl, callerAvatarUrl) ||
                other.callerAvatarUrl == callerAvatarUrl) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._offer, _offer) &&
            const DeepCollectionEquality().equals(other._answer, _answer) &&
            (identical(other.videoUpgradeRequest, videoUpgradeRequest) ||
                other.videoUpgradeRequest == videoUpgradeRequest) &&
            (identical(
                  other.videoUpgradeRequesterId,
                  videoUpgradeRequesterId,
                ) ||
                other.videoUpgradeRequesterId == videoUpgradeRequesterId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.endReason, endReason) ||
                other.endReason == endReason) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    callId,
    conversationId,
    callerId,
    calleeId,
    callerName,
    callerAvatarUrl,
    callType,
    status,
    const DeepCollectionEquality().hash(_offer),
    const DeepCollectionEquality().hash(_answer),
    videoUpgradeRequest,
    videoUpgradeRequesterId,
    createdAt,
    answeredAt,
    endedAt,
    endReason,
    durationSeconds,
  );

  /// Create a copy of CallSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallSessionImplCopyWith<_$CallSessionImpl> get copyWith =>
      __$$CallSessionImplCopyWithImpl<_$CallSessionImpl>(this, _$identity);
}

abstract class _CallSession implements CallSession {
  const factory _CallSession({
    required final String callId,
    required final String conversationId,
    required final String callerId,
    required final String calleeId,
    required final String callerName,
    final String? callerAvatarUrl,
    required final CallType callType,
    required final CallStatus status,
    final Map<String, String>? offer,
    final Map<String, String>? answer,
    final String? videoUpgradeRequest,
    final String? videoUpgradeRequesterId,
    final DateTime? createdAt,
    final DateTime? answeredAt,
    final DateTime? endedAt,
    final String? endReason,
    final int? durationSeconds,
  }) = _$CallSessionImpl;

  @override
  String get callId;
  @override
  String get conversationId;
  @override
  String get callerId;
  @override
  String get calleeId;
  @override
  String get callerName;
  @override
  String? get callerAvatarUrl;
  @override
  CallType get callType;
  @override
  CallStatus get status;

  /// SDP offer from the caller: {type, sdp}.
  @override
  Map<String, String>? get offer;

  /// SDP answer from the callee: {type, sdp}.
  @override
  Map<String, String>? get answer;

  /// Video upgrade request state: 'pending' | 'accepted' | 'declined'.
  @override
  String? get videoUpgradeRequest;
  @override
  String? get videoUpgradeRequesterId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get answeredAt;
  @override
  DateTime? get endedAt;
  @override
  String? get endReason;
  @override
  int? get durationSeconds;

  /// Create a copy of CallSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallSessionImplCopyWith<_$CallSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
