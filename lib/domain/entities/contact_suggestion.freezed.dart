// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContactSuggestion _$ContactSuggestionFromJson(Map<String, dynamic> json) {
  return _ContactSuggestion.fromJson(json);
}

/// @nodoc
mixin _$ContactSuggestion {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  SuggestionSource get source => throw _privateConstructorUsedError;

  /// Serializes this ContactSuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactSuggestionCopyWith<ContactSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSuggestionCopyWith<$Res> {
  factory $ContactSuggestionCopyWith(
    ContactSuggestion value,
    $Res Function(ContactSuggestion) then,
  ) = _$ContactSuggestionCopyWithImpl<$Res, ContactSuggestion>;
  @useResult
  $Res call({
    String userId,
    String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String reason,
    SuggestionSource source,
  });
}

/// @nodoc
class _$ContactSuggestionCopyWithImpl<$Res, $Val extends ContactSuggestion>
    implements $ContactSuggestionCopyWith<$Res> {
  _$ContactSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? reason = null,
    Object? source = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as SuggestionSource,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactSuggestionImplCopyWith<$Res>
    implements $ContactSuggestionCopyWith<$Res> {
  factory _$$ContactSuggestionImplCopyWith(
    _$ContactSuggestionImpl value,
    $Res Function(_$ContactSuggestionImpl) then,
  ) = __$$ContactSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String reason,
    SuggestionSource source,
  });
}

/// @nodoc
class __$$ContactSuggestionImplCopyWithImpl<$Res>
    extends _$ContactSuggestionCopyWithImpl<$Res, _$ContactSuggestionImpl>
    implements _$$ContactSuggestionImplCopyWith<$Res> {
  __$$ContactSuggestionImplCopyWithImpl(
    _$ContactSuggestionImpl _value,
    $Res Function(_$ContactSuggestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? reason = null,
    Object? source = null,
  }) {
    return _then(
      _$ContactSuggestionImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as SuggestionSource,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactSuggestionImpl implements _ContactSuggestion {
  const _$ContactSuggestionImpl({
    required this.userId,
    required this.displayName,
    this.username,
    this.avatarUrl,
    this.avatarColor,
    required this.reason,
    required this.source,
  });

  factory _$ContactSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactSuggestionImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final String? avatarUrl;
  @override
  final String? avatarColor;
  @override
  final String reason;
  @override
  final SuggestionSource source;

  @override
  String toString() {
    return 'ContactSuggestion(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, reason: $reason, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactSuggestionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    displayName,
    username,
    avatarUrl,
    avatarColor,
    reason,
    source,
  );

  /// Create a copy of ContactSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactSuggestionImplCopyWith<_$ContactSuggestionImpl> get copyWith =>
      __$$ContactSuggestionImplCopyWithImpl<_$ContactSuggestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactSuggestionImplToJson(this);
  }
}

abstract class _ContactSuggestion implements ContactSuggestion {
  const factory _ContactSuggestion({
    required final String userId,
    required final String displayName,
    final String? username,
    final String? avatarUrl,
    final String? avatarColor,
    required final String reason,
    required final SuggestionSource source,
  }) = _$ContactSuggestionImpl;

  factory _ContactSuggestion.fromJson(Map<String, dynamic> json) =
      _$ContactSuggestionImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  String? get avatarUrl;
  @override
  String? get avatarColor;
  @override
  String get reason;
  @override
  SuggestionSource get source;

  /// Create a copy of ContactSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactSuggestionImplCopyWith<_$ContactSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
