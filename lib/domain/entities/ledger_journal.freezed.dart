// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_journal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerEntry _$LedgerEntryFromJson(Map<String, dynamic> json) {
  return _LedgerEntry.fromJson(json);
}

/// @nodoc
mixin _$LedgerEntry {
  String get id => throw _privateConstructorUsedError;
  String get accountId => throw _privateConstructorUsedError;
  LedgerEntryType get entryType => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get balanceAfter => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this LedgerEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerEntryCopyWith<LedgerEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerEntryCopyWith<$Res> {
  factory $LedgerEntryCopyWith(
    LedgerEntry value,
    $Res Function(LedgerEntry) then,
  ) = _$LedgerEntryCopyWithImpl<$Res, LedgerEntry>;
  @useResult
  $Res call({
    String id,
    String accountId,
    LedgerEntryType entryType,
    int amount,
    int balanceAfter,
    String? description,
  });
}

/// @nodoc
class _$LedgerEntryCopyWithImpl<$Res, $Val extends LedgerEntry>
    implements $LedgerEntryCopyWith<$Res> {
  _$LedgerEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = null,
    Object? entryType = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            accountId: null == accountId
                ? _value.accountId
                : accountId // ignore: cast_nullable_to_non_nullable
                      as String,
            entryType: null == entryType
                ? _value.entryType
                : entryType // ignore: cast_nullable_to_non_nullable
                      as LedgerEntryType,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerEntryImplCopyWith<$Res>
    implements $LedgerEntryCopyWith<$Res> {
  factory _$$LedgerEntryImplCopyWith(
    _$LedgerEntryImpl value,
    $Res Function(_$LedgerEntryImpl) then,
  ) = __$$LedgerEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String accountId,
    LedgerEntryType entryType,
    int amount,
    int balanceAfter,
    String? description,
  });
}

/// @nodoc
class __$$LedgerEntryImplCopyWithImpl<$Res>
    extends _$LedgerEntryCopyWithImpl<$Res, _$LedgerEntryImpl>
    implements _$$LedgerEntryImplCopyWith<$Res> {
  __$$LedgerEntryImplCopyWithImpl(
    _$LedgerEntryImpl _value,
    $Res Function(_$LedgerEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = null,
    Object? entryType = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? description = freezed,
  }) {
    return _then(
      _$LedgerEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        accountId: null == accountId
            ? _value.accountId
            : accountId // ignore: cast_nullable_to_non_nullable
                  as String,
        entryType: null == entryType
            ? _value.entryType
            : entryType // ignore: cast_nullable_to_non_nullable
                  as LedgerEntryType,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerEntryImpl implements _LedgerEntry {
  const _$LedgerEntryImpl({
    required this.id,
    required this.accountId,
    required this.entryType,
    required this.amount,
    required this.balanceAfter,
    this.description,
  });

  factory _$LedgerEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String accountId;
  @override
  final LedgerEntryType entryType;
  @override
  final int amount;
  @override
  final int balanceAfter;
  @override
  final String? description;

  @override
  String toString() {
    return 'LedgerEntry(id: $id, accountId: $accountId, entryType: $entryType, amount: $amount, balanceAfter: $balanceAfter, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.entryType, entryType) ||
                other.entryType == entryType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accountId,
    entryType,
    amount,
    balanceAfter,
    description,
  );

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerEntryImplCopyWith<_$LedgerEntryImpl> get copyWith =>
      __$$LedgerEntryImplCopyWithImpl<_$LedgerEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerEntryImplToJson(this);
  }
}

abstract class _LedgerEntry implements LedgerEntry {
  const factory _LedgerEntry({
    required final String id,
    required final String accountId,
    required final LedgerEntryType entryType,
    required final int amount,
    required final int balanceAfter,
    final String? description,
  }) = _$LedgerEntryImpl;

  factory _LedgerEntry.fromJson(Map<String, dynamic> json) =
      _$LedgerEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get accountId;
  @override
  LedgerEntryType get entryType;
  @override
  int get amount;
  @override
  int get balanceAfter;
  @override
  String? get description;

  /// Create a copy of LedgerEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerEntryImplCopyWith<_$LedgerEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LedgerJournal _$LedgerJournalFromJson(Map<String, dynamic> json) {
  return _LedgerJournal.fromJson(json);
}

/// @nodoc
mixin _$LedgerJournal {
  String get id => throw _privateConstructorUsedError;
  String get idempotencyKey => throw _privateConstructorUsedError;
  LedgerJournalType get type => throw _privateConstructorUsedError;
  LedgerJournalStatus get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<LedgerEntry> get entries => throw _privateConstructorUsedError;
  int get totalDebits => throw _privateConstructorUsedError;
  int get totalCredits => throw _privateConstructorUsedError;
  LedgerReferenceType? get referenceType => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String get initiatedBy => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get postedAt => throw _privateConstructorUsedError;
  DateTime? get reversedAt => throw _privateConstructorUsedError;
  String? get reversedBy => throw _privateConstructorUsedError;
  String? get reversalJournalId => throw _privateConstructorUsedError;
  String? get originalJournalId => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this LedgerJournal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerJournal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerJournalCopyWith<LedgerJournal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerJournalCopyWith<$Res> {
  factory $LedgerJournalCopyWith(
    LedgerJournal value,
    $Res Function(LedgerJournal) then,
  ) = _$LedgerJournalCopyWithImpl<$Res, LedgerJournal>;
  @useResult
  $Res call({
    String id,
    String idempotencyKey,
    LedgerJournalType type,
    LedgerJournalStatus status,
    String description,
    List<LedgerEntry> entries,
    int totalDebits,
    int totalCredits,
    LedgerReferenceType? referenceType,
    String? referenceId,
    String initiatedBy,
    String? approvedBy,
    DateTime createdAt,
    DateTime? postedAt,
    DateTime? reversedAt,
    String? reversedBy,
    String? reversalJournalId,
    String? originalJournalId,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$LedgerJournalCopyWithImpl<$Res, $Val extends LedgerJournal>
    implements $LedgerJournalCopyWith<$Res> {
  _$LedgerJournalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerJournal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idempotencyKey = null,
    Object? type = null,
    Object? status = null,
    Object? description = null,
    Object? entries = null,
    Object? totalDebits = null,
    Object? totalCredits = null,
    Object? referenceType = freezed,
    Object? referenceId = freezed,
    Object? initiatedBy = null,
    Object? approvedBy = freezed,
    Object? createdAt = null,
    Object? postedAt = freezed,
    Object? reversedAt = freezed,
    Object? reversedBy = freezed,
    Object? reversalJournalId = freezed,
    Object? originalJournalId = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            idempotencyKey: null == idempotencyKey
                ? _value.idempotencyKey
                : idempotencyKey // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LedgerJournalType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as LedgerJournalStatus,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<LedgerEntry>,
            totalDebits: null == totalDebits
                ? _value.totalDebits
                : totalDebits // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCredits: null == totalCredits
                ? _value.totalCredits
                : totalCredits // ignore: cast_nullable_to_non_nullable
                      as int,
            referenceType: freezed == referenceType
                ? _value.referenceType
                : referenceType // ignore: cast_nullable_to_non_nullable
                      as LedgerReferenceType?,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            initiatedBy: null == initiatedBy
                ? _value.initiatedBy
                : initiatedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            approvedBy: freezed == approvedBy
                ? _value.approvedBy
                : approvedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            postedAt: freezed == postedAt
                ? _value.postedAt
                : postedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            reversedAt: freezed == reversedAt
                ? _value.reversedAt
                : reversedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            reversedBy: freezed == reversedBy
                ? _value.reversedBy
                : reversedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            reversalJournalId: freezed == reversalJournalId
                ? _value.reversalJournalId
                : reversalJournalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalJournalId: freezed == originalJournalId
                ? _value.originalJournalId
                : originalJournalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerJournalImplCopyWith<$Res>
    implements $LedgerJournalCopyWith<$Res> {
  factory _$$LedgerJournalImplCopyWith(
    _$LedgerJournalImpl value,
    $Res Function(_$LedgerJournalImpl) then,
  ) = __$$LedgerJournalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String idempotencyKey,
    LedgerJournalType type,
    LedgerJournalStatus status,
    String description,
    List<LedgerEntry> entries,
    int totalDebits,
    int totalCredits,
    LedgerReferenceType? referenceType,
    String? referenceId,
    String initiatedBy,
    String? approvedBy,
    DateTime createdAt,
    DateTime? postedAt,
    DateTime? reversedAt,
    String? reversedBy,
    String? reversalJournalId,
    String? originalJournalId,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$LedgerJournalImplCopyWithImpl<$Res>
    extends _$LedgerJournalCopyWithImpl<$Res, _$LedgerJournalImpl>
    implements _$$LedgerJournalImplCopyWith<$Res> {
  __$$LedgerJournalImplCopyWithImpl(
    _$LedgerJournalImpl _value,
    $Res Function(_$LedgerJournalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerJournal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idempotencyKey = null,
    Object? type = null,
    Object? status = null,
    Object? description = null,
    Object? entries = null,
    Object? totalDebits = null,
    Object? totalCredits = null,
    Object? referenceType = freezed,
    Object? referenceId = freezed,
    Object? initiatedBy = null,
    Object? approvedBy = freezed,
    Object? createdAt = null,
    Object? postedAt = freezed,
    Object? reversedAt = freezed,
    Object? reversedBy = freezed,
    Object? reversalJournalId = freezed,
    Object? originalJournalId = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$LedgerJournalImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        idempotencyKey: null == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LedgerJournalType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as LedgerJournalStatus,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<LedgerEntry>,
        totalDebits: null == totalDebits
            ? _value.totalDebits
            : totalDebits // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCredits: null == totalCredits
            ? _value.totalCredits
            : totalCredits // ignore: cast_nullable_to_non_nullable
                  as int,
        referenceType: freezed == referenceType
            ? _value.referenceType
            : referenceType // ignore: cast_nullable_to_non_nullable
                  as LedgerReferenceType?,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        initiatedBy: null == initiatedBy
            ? _value.initiatedBy
            : initiatedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        approvedBy: freezed == approvedBy
            ? _value.approvedBy
            : approvedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        postedAt: freezed == postedAt
            ? _value.postedAt
            : postedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        reversedAt: freezed == reversedAt
            ? _value.reversedAt
            : reversedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        reversedBy: freezed == reversedBy
            ? _value.reversedBy
            : reversedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        reversalJournalId: freezed == reversalJournalId
            ? _value.reversalJournalId
            : reversalJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalJournalId: freezed == originalJournalId
            ? _value.originalJournalId
            : originalJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerJournalImpl extends _LedgerJournal {
  const _$LedgerJournalImpl({
    required this.id,
    required this.idempotencyKey,
    required this.type,
    required this.status,
    required this.description,
    required final List<LedgerEntry> entries,
    required this.totalDebits,
    required this.totalCredits,
    this.referenceType,
    this.referenceId,
    required this.initiatedBy,
    this.approvedBy,
    required this.createdAt,
    this.postedAt,
    this.reversedAt,
    this.reversedBy,
    this.reversalJournalId,
    this.originalJournalId,
    final Map<String, dynamic> metadata = const {},
  }) : _entries = entries,
       _metadata = metadata,
       super._();

  factory _$LedgerJournalImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerJournalImplFromJson(json);

  @override
  final String id;
  @override
  final String idempotencyKey;
  @override
  final LedgerJournalType type;
  @override
  final LedgerJournalStatus status;
  @override
  final String description;
  final List<LedgerEntry> _entries;
  @override
  List<LedgerEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final int totalDebits;
  @override
  final int totalCredits;
  @override
  final LedgerReferenceType? referenceType;
  @override
  final String? referenceId;
  @override
  final String initiatedBy;
  @override
  final String? approvedBy;
  @override
  final DateTime createdAt;
  @override
  final DateTime? postedAt;
  @override
  final DateTime? reversedAt;
  @override
  final String? reversedBy;
  @override
  final String? reversalJournalId;
  @override
  final String? originalJournalId;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'LedgerJournal(id: $id, idempotencyKey: $idempotencyKey, type: $type, status: $status, description: $description, entries: $entries, totalDebits: $totalDebits, totalCredits: $totalCredits, referenceType: $referenceType, referenceId: $referenceId, initiatedBy: $initiatedBy, approvedBy: $approvedBy, createdAt: $createdAt, postedAt: $postedAt, reversedAt: $reversedAt, reversedBy: $reversedBy, reversalJournalId: $reversalJournalId, originalJournalId: $originalJournalId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerJournalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.totalDebits, totalDebits) ||
                other.totalDebits == totalDebits) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.initiatedBy, initiatedBy) ||
                other.initiatedBy == initiatedBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            (identical(other.reversedAt, reversedAt) ||
                other.reversedAt == reversedAt) &&
            (identical(other.reversedBy, reversedBy) ||
                other.reversedBy == reversedBy) &&
            (identical(other.reversalJournalId, reversalJournalId) ||
                other.reversalJournalId == reversalJournalId) &&
            (identical(other.originalJournalId, originalJournalId) ||
                other.originalJournalId == originalJournalId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    idempotencyKey,
    type,
    status,
    description,
    const DeepCollectionEquality().hash(_entries),
    totalDebits,
    totalCredits,
    referenceType,
    referenceId,
    initiatedBy,
    approvedBy,
    createdAt,
    postedAt,
    reversedAt,
    reversedBy,
    reversalJournalId,
    originalJournalId,
    const DeepCollectionEquality().hash(_metadata),
  ]);

  /// Create a copy of LedgerJournal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerJournalImplCopyWith<_$LedgerJournalImpl> get copyWith =>
      __$$LedgerJournalImplCopyWithImpl<_$LedgerJournalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerJournalImplToJson(this);
  }
}

abstract class _LedgerJournal extends LedgerJournal {
  const factory _LedgerJournal({
    required final String id,
    required final String idempotencyKey,
    required final LedgerJournalType type,
    required final LedgerJournalStatus status,
    required final String description,
    required final List<LedgerEntry> entries,
    required final int totalDebits,
    required final int totalCredits,
    final LedgerReferenceType? referenceType,
    final String? referenceId,
    required final String initiatedBy,
    final String? approvedBy,
    required final DateTime createdAt,
    final DateTime? postedAt,
    final DateTime? reversedAt,
    final String? reversedBy,
    final String? reversalJournalId,
    final String? originalJournalId,
    final Map<String, dynamic> metadata,
  }) = _$LedgerJournalImpl;
  const _LedgerJournal._() : super._();

  factory _LedgerJournal.fromJson(Map<String, dynamic> json) =
      _$LedgerJournalImpl.fromJson;

  @override
  String get id;
  @override
  String get idempotencyKey;
  @override
  LedgerJournalType get type;
  @override
  LedgerJournalStatus get status;
  @override
  String get description;
  @override
  List<LedgerEntry> get entries;
  @override
  int get totalDebits;
  @override
  int get totalCredits;
  @override
  LedgerReferenceType? get referenceType;
  @override
  String? get referenceId;
  @override
  String get initiatedBy;
  @override
  String? get approvedBy;
  @override
  DateTime get createdAt;
  @override
  DateTime? get postedAt;
  @override
  DateTime? get reversedAt;
  @override
  String? get reversedBy;
  @override
  String? get reversalJournalId;
  @override
  String? get originalJournalId;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of LedgerJournal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerJournalImplCopyWith<_$LedgerJournalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
