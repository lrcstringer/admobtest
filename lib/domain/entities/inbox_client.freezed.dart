// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InboxClient _$InboxClientFromJson(Map<String, dynamic> json) {
  return _InboxClient.fromJson(json);
}

/// @nodoc
mixin _$InboxClient {
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String? get clientAvatarImage => throw _privateConstructorUsedError;
  String? get clientAvatarColor => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  int get activeThreadCount => throw _privateConstructorUsedError;
  List<InboxThread> get threads => throw _privateConstructorUsedError;

  /// Serializes this InboxClient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxClientCopyWith<InboxClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxClientCopyWith<$Res> {
  factory $InboxClientCopyWith(
    InboxClient value,
    $Res Function(InboxClient) then,
  ) = _$InboxClientCopyWithImpl<$Res, InboxClient>;
  @useResult
  $Res call({
    String clientId,
    String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    bool isPinned,
    bool isFeatured,
    int activeThreadCount,
    List<InboxThread> threads,
  });
}

/// @nodoc
class _$InboxClientCopyWithImpl<$Res, $Val extends InboxClient>
    implements $InboxClientCopyWith<$Res> {
  _$InboxClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? activeThreadCount = null,
    Object? threads = null,
  }) {
    return _then(
      _value.copyWith(
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            clientName: null == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String,
            clientAvatarImage: freezed == clientAvatarImage
                ? _value.clientAvatarImage
                : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientAvatarColor: freezed == clientAvatarColor
                ? _value.clientAvatarColor
                : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeThreadCount: null == activeThreadCount
                ? _value.activeThreadCount
                : activeThreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            threads: null == threads
                ? _value.threads
                : threads // ignore: cast_nullable_to_non_nullable
                      as List<InboxThread>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InboxClientImplCopyWith<$Res>
    implements $InboxClientCopyWith<$Res> {
  factory _$$InboxClientImplCopyWith(
    _$InboxClientImpl value,
    $Res Function(_$InboxClientImpl) then,
  ) = __$$InboxClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String clientId,
    String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    bool isPinned,
    bool isFeatured,
    int activeThreadCount,
    List<InboxThread> threads,
  });
}

/// @nodoc
class __$$InboxClientImplCopyWithImpl<$Res>
    extends _$InboxClientCopyWithImpl<$Res, _$InboxClientImpl>
    implements _$$InboxClientImplCopyWith<$Res> {
  __$$InboxClientImplCopyWithImpl(
    _$InboxClientImpl _value,
    $Res Function(_$InboxClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InboxClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? activeThreadCount = null,
    Object? threads = null,
  }) {
    return _then(
      _$InboxClientImpl(
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        clientName: null == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String,
        clientAvatarImage: freezed == clientAvatarImage
            ? _value.clientAvatarImage
            : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientAvatarColor: freezed == clientAvatarColor
            ? _value.clientAvatarColor
            : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeThreadCount: null == activeThreadCount
            ? _value.activeThreadCount
            : activeThreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        threads: null == threads
            ? _value._threads
            : threads // ignore: cast_nullable_to_non_nullable
                  as List<InboxThread>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxClientImpl extends _InboxClient {
  const _$InboxClientImpl({
    required this.clientId,
    required this.clientName,
    this.clientAvatarImage,
    this.clientAvatarColor,
    required this.isPinned,
    required this.isFeatured,
    required this.activeThreadCount,
    required final List<InboxThread> threads,
  }) : _threads = threads,
       super._();

  factory _$InboxClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxClientImplFromJson(json);

  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String? clientAvatarImage;
  @override
  final String? clientAvatarColor;
  @override
  final bool isPinned;
  @override
  final bool isFeatured;
  @override
  final int activeThreadCount;
  final List<InboxThread> _threads;
  @override
  List<InboxThread> get threads {
    if (_threads is EqualUnmodifiableListView) return _threads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threads);
  }

  @override
  String toString() {
    return 'InboxClient(clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, isPinned: $isPinned, isFeatured: $isFeatured, activeThreadCount: $activeThreadCount, threads: $threads)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxClientImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAvatarImage, clientAvatarImage) ||
                other.clientAvatarImage == clientAvatarImage) &&
            (identical(other.clientAvatarColor, clientAvatarColor) ||
                other.clientAvatarColor == clientAvatarColor) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.activeThreadCount, activeThreadCount) ||
                other.activeThreadCount == activeThreadCount) &&
            const DeepCollectionEquality().equals(other._threads, _threads));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    clientId,
    clientName,
    clientAvatarImage,
    clientAvatarColor,
    isPinned,
    isFeatured,
    activeThreadCount,
    const DeepCollectionEquality().hash(_threads),
  );

  /// Create a copy of InboxClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxClientImplCopyWith<_$InboxClientImpl> get copyWith =>
      __$$InboxClientImplCopyWithImpl<_$InboxClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxClientImplToJson(this);
  }
}

abstract class _InboxClient extends InboxClient {
  const factory _InboxClient({
    required final String clientId,
    required final String clientName,
    final String? clientAvatarImage,
    final String? clientAvatarColor,
    required final bool isPinned,
    required final bool isFeatured,
    required final int activeThreadCount,
    required final List<InboxThread> threads,
  }) = _$InboxClientImpl;
  const _InboxClient._() : super._();

  factory _InboxClient.fromJson(Map<String, dynamic> json) =
      _$InboxClientImpl.fromJson;

  @override
  String get clientId;
  @override
  String get clientName;
  @override
  String? get clientAvatarImage;
  @override
  String? get clientAvatarColor;
  @override
  bool get isPinned;
  @override
  bool get isFeatured;
  @override
  int get activeThreadCount;
  @override
  List<InboxThread> get threads;

  /// Create a copy of InboxClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxClientImplCopyWith<_$InboxClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
