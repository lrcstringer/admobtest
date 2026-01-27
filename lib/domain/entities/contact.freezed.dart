// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return _Contact.fromJson(json);
}

/// @nodoc
mixin _$Contact {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get contactUserId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  ContactStatus get status => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastInteractionAt => throw _privateConstructorUsedError;

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res, Contact>;
  @useResult
  $Res call({
    String id,
    String userId,
    String contactUserId,
    String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String? phoneNumber,
    ContactStatus status,
    bool isFavorite,
    String? nickname,
    String? notes,
    DateTime createdAt,
    DateTime? lastInteractionAt,
  });
}

/// @nodoc
class _$ContactCopyWithImpl<$Res, $Val extends Contact>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? contactUserId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? phoneNumber = freezed,
    Object? status = null,
    Object? isFavorite = null,
    Object? nickname = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? lastInteractionAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            contactUserId: null == contactUserId
                ? _value.contactUserId
                : contactUserId // ignore: cast_nullable_to_non_nullable
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
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ContactStatus,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastInteractionAt: freezed == lastInteractionAt
                ? _value.lastInteractionAt
                : lastInteractionAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactImplCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$$ContactImplCopyWith(
    _$ContactImpl value,
    $Res Function(_$ContactImpl) then,
  ) = __$$ContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String contactUserId,
    String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    String? phoneNumber,
    ContactStatus status,
    bool isFavorite,
    String? nickname,
    String? notes,
    DateTime createdAt,
    DateTime? lastInteractionAt,
  });
}

/// @nodoc
class __$$ContactImplCopyWithImpl<$Res>
    extends _$ContactCopyWithImpl<$Res, _$ContactImpl>
    implements _$$ContactImplCopyWith<$Res> {
  __$$ContactImplCopyWithImpl(
    _$ContactImpl _value,
    $Res Function(_$ContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? contactUserId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? phoneNumber = freezed,
    Object? status = null,
    Object? isFavorite = null,
    Object? nickname = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? lastInteractionAt = freezed,
  }) {
    return _then(
      _$ContactImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        contactUserId: null == contactUserId
            ? _value.contactUserId
            : contactUserId // ignore: cast_nullable_to_non_nullable
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
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ContactStatus,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastInteractionAt: freezed == lastInteractionAt
            ? _value.lastInteractionAt
            : lastInteractionAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactImpl extends _Contact {
  const _$ContactImpl({
    required this.id,
    required this.userId,
    required this.contactUserId,
    required this.displayName,
    this.username,
    this.avatarUrl,
    this.avatarColor,
    this.phoneNumber,
    required this.status,
    required this.isFavorite,
    this.nickname,
    this.notes,
    required this.createdAt,
    this.lastInteractionAt,
  }) : super._();

  factory _$ContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String contactUserId;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final String? avatarUrl;
  @override
  final String? avatarColor;
  @override
  final String? phoneNumber;
  @override
  final ContactStatus status;
  @override
  final bool isFavorite;
  @override
  final String? nickname;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastInteractionAt;

  @override
  String toString() {
    return 'Contact(id: $id, userId: $userId, contactUserId: $contactUserId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, phoneNumber: $phoneNumber, status: $status, isFavorite: $isFavorite, nickname: $nickname, notes: $notes, createdAt: $createdAt, lastInteractionAt: $lastInteractionAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.contactUserId, contactUserId) ||
                other.contactUserId == contactUserId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastInteractionAt, lastInteractionAt) ||
                other.lastInteractionAt == lastInteractionAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    contactUserId,
    displayName,
    username,
    avatarUrl,
    avatarColor,
    phoneNumber,
    status,
    isFavorite,
    nickname,
    notes,
    createdAt,
    lastInteractionAt,
  );

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      __$$ContactImplCopyWithImpl<_$ContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactImplToJson(this);
  }
}

abstract class _Contact extends Contact {
  const factory _Contact({
    required final String id,
    required final String userId,
    required final String contactUserId,
    required final String displayName,
    final String? username,
    final String? avatarUrl,
    final String? avatarColor,
    final String? phoneNumber,
    required final ContactStatus status,
    required final bool isFavorite,
    final String? nickname,
    final String? notes,
    required final DateTime createdAt,
    final DateTime? lastInteractionAt,
  }) = _$ContactImpl;
  const _Contact._() : super._();

  factory _Contact.fromJson(Map<String, dynamic> json) = _$ContactImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get contactUserId;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  String? get avatarUrl;
  @override
  String? get avatarColor;
  @override
  String? get phoneNumber;
  @override
  ContactStatus get status;
  @override
  bool get isFavorite;
  @override
  String? get nickname;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastInteractionAt;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
