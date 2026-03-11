// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_journal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LedgerEntry {

 String get id; String get accountId; LedgerEntryType get entryType; int get amount; int get balanceAfter; String? get description;
/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerEntryCopyWith<LedgerEntry> get copyWith => _$LedgerEntryCopyWithImpl<LedgerEntry>(this as LedgerEntry, _$identity);

  /// Serializes this LedgerEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,entryType,amount,balanceAfter,description);

@override
String toString() {
  return 'LedgerEntry(id: $id, accountId: $accountId, entryType: $entryType, amount: $amount, balanceAfter: $balanceAfter, description: $description)';
}


}

/// @nodoc
abstract mixin class $LedgerEntryCopyWith<$Res>  {
  factory $LedgerEntryCopyWith(LedgerEntry value, $Res Function(LedgerEntry) _then) = _$LedgerEntryCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, LedgerEntryType entryType, int amount, int balanceAfter, String? description
});




}
/// @nodoc
class _$LedgerEntryCopyWithImpl<$Res>
    implements $LedgerEntryCopyWith<$Res> {
  _$LedgerEntryCopyWithImpl(this._self, this._then);

  final LedgerEntry _self;
  final $Res Function(LedgerEntry) _then;

/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? entryType = null,Object? amount = null,Object? balanceAfter = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,entryType: null == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as LedgerEntryType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,balanceAfter: null == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerEntry].
extension LedgerEntryPatterns on LedgerEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerEntry value)  $default,){
final _that = this;
switch (_that) {
case _LedgerEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  LedgerEntryType entryType,  int amount,  int balanceAfter,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
return $default(_that.id,_that.accountId,_that.entryType,_that.amount,_that.balanceAfter,_that.description);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  LedgerEntryType entryType,  int amount,  int balanceAfter,  String? description)  $default,) {final _that = this;
switch (_that) {
case _LedgerEntry():
return $default(_that.id,_that.accountId,_that.entryType,_that.amount,_that.balanceAfter,_that.description);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  LedgerEntryType entryType,  int amount,  int balanceAfter,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
return $default(_that.id,_that.accountId,_that.entryType,_that.amount,_that.balanceAfter,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LedgerEntry implements LedgerEntry {
  const _LedgerEntry({required this.id, required this.accountId, required this.entryType, required this.amount, required this.balanceAfter, this.description});
  factory _LedgerEntry.fromJson(Map<String, dynamic> json) => _$LedgerEntryFromJson(json);

@override final  String id;
@override final  String accountId;
@override final  LedgerEntryType entryType;
@override final  int amount;
@override final  int balanceAfter;
@override final  String? description;

/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerEntryCopyWith<_LedgerEntry> get copyWith => __$LedgerEntryCopyWithImpl<_LedgerEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LedgerEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,entryType,amount,balanceAfter,description);

@override
String toString() {
  return 'LedgerEntry(id: $id, accountId: $accountId, entryType: $entryType, amount: $amount, balanceAfter: $balanceAfter, description: $description)';
}


}

/// @nodoc
abstract mixin class _$LedgerEntryCopyWith<$Res> implements $LedgerEntryCopyWith<$Res> {
  factory _$LedgerEntryCopyWith(_LedgerEntry value, $Res Function(_LedgerEntry) _then) = __$LedgerEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, LedgerEntryType entryType, int amount, int balanceAfter, String? description
});




}
/// @nodoc
class __$LedgerEntryCopyWithImpl<$Res>
    implements _$LedgerEntryCopyWith<$Res> {
  __$LedgerEntryCopyWithImpl(this._self, this._then);

  final _LedgerEntry _self;
  final $Res Function(_LedgerEntry) _then;

/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? entryType = null,Object? amount = null,Object? balanceAfter = null,Object? description = freezed,}) {
  return _then(_LedgerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,entryType: null == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as LedgerEntryType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,balanceAfter: null == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LedgerJournal {

 String get id; String get idempotencyKey; LedgerJournalType get type; LedgerJournalStatus get status; String get description; List<LedgerEntry> get entries; int get totalDebits; int get totalCredits; LedgerReferenceType? get referenceType; String? get referenceId; String get initiatedBy; String? get approvedBy; DateTime get createdAt; DateTime? get postedAt; DateTime? get reversedAt; String? get reversedBy; String? get reversalJournalId; String? get originalJournalId; Map<String, dynamic> get metadata;
/// Create a copy of LedgerJournal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerJournalCopyWith<LedgerJournal> get copyWith => _$LedgerJournalCopyWithImpl<LedgerJournal>(this as LedgerJournal, _$identity);

  /// Serializes this LedgerJournal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerJournal&&(identical(other.id, id) || other.id == id)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.totalDebits, totalDebits) || other.totalDebits == totalDebits)&&(identical(other.totalCredits, totalCredits) || other.totalCredits == totalCredits)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.initiatedBy, initiatedBy) || other.initiatedBy == initiatedBy)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.reversedAt, reversedAt) || other.reversedAt == reversedAt)&&(identical(other.reversedBy, reversedBy) || other.reversedBy == reversedBy)&&(identical(other.reversalJournalId, reversalJournalId) || other.reversalJournalId == reversalJournalId)&&(identical(other.originalJournalId, originalJournalId) || other.originalJournalId == originalJournalId)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,idempotencyKey,type,status,description,const DeepCollectionEquality().hash(entries),totalDebits,totalCredits,referenceType,referenceId,initiatedBy,approvedBy,createdAt,postedAt,reversedAt,reversedBy,reversalJournalId,originalJournalId,const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'LedgerJournal(id: $id, idempotencyKey: $idempotencyKey, type: $type, status: $status, description: $description, entries: $entries, totalDebits: $totalDebits, totalCredits: $totalCredits, referenceType: $referenceType, referenceId: $referenceId, initiatedBy: $initiatedBy, approvedBy: $approvedBy, createdAt: $createdAt, postedAt: $postedAt, reversedAt: $reversedAt, reversedBy: $reversedBy, reversalJournalId: $reversalJournalId, originalJournalId: $originalJournalId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $LedgerJournalCopyWith<$Res>  {
  factory $LedgerJournalCopyWith(LedgerJournal value, $Res Function(LedgerJournal) _then) = _$LedgerJournalCopyWithImpl;
@useResult
$Res call({
 String id, String idempotencyKey, LedgerJournalType type, LedgerJournalStatus status, String description, List<LedgerEntry> entries, int totalDebits, int totalCredits, LedgerReferenceType? referenceType, String? referenceId, String initiatedBy, String? approvedBy, DateTime createdAt, DateTime? postedAt, DateTime? reversedAt, String? reversedBy, String? reversalJournalId, String? originalJournalId, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$LedgerJournalCopyWithImpl<$Res>
    implements $LedgerJournalCopyWith<$Res> {
  _$LedgerJournalCopyWithImpl(this._self, this._then);

  final LedgerJournal _self;
  final $Res Function(LedgerJournal) _then;

/// Create a copy of LedgerJournal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? idempotencyKey = null,Object? type = null,Object? status = null,Object? description = null,Object? entries = null,Object? totalDebits = null,Object? totalCredits = null,Object? referenceType = freezed,Object? referenceId = freezed,Object? initiatedBy = null,Object? approvedBy = freezed,Object? createdAt = null,Object? postedAt = freezed,Object? reversedAt = freezed,Object? reversedBy = freezed,Object? reversalJournalId = freezed,Object? originalJournalId = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerJournalType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LedgerJournalStatus,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,totalDebits: null == totalDebits ? _self.totalDebits : totalDebits // ignore: cast_nullable_to_non_nullable
as int,totalCredits: null == totalCredits ? _self.totalCredits : totalCredits // ignore: cast_nullable_to_non_nullable
as int,referenceType: freezed == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as LedgerReferenceType?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,initiatedBy: null == initiatedBy ? _self.initiatedBy : initiatedBy // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,postedAt: freezed == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reversedAt: freezed == reversedAt ? _self.reversedAt : reversedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reversedBy: freezed == reversedBy ? _self.reversedBy : reversedBy // ignore: cast_nullable_to_non_nullable
as String?,reversalJournalId: freezed == reversalJournalId ? _self.reversalJournalId : reversalJournalId // ignore: cast_nullable_to_non_nullable
as String?,originalJournalId: freezed == originalJournalId ? _self.originalJournalId : originalJournalId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerJournal].
extension LedgerJournalPatterns on LedgerJournal {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerJournal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerJournal() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerJournal value)  $default,){
final _that = this;
switch (_that) {
case _LedgerJournal():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerJournal value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerJournal() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String idempotencyKey,  LedgerJournalType type,  LedgerJournalStatus status,  String description,  List<LedgerEntry> entries,  int totalDebits,  int totalCredits,  LedgerReferenceType? referenceType,  String? referenceId,  String initiatedBy,  String? approvedBy,  DateTime createdAt,  DateTime? postedAt,  DateTime? reversedAt,  String? reversedBy,  String? reversalJournalId,  String? originalJournalId,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerJournal() when $default != null:
return $default(_that.id,_that.idempotencyKey,_that.type,_that.status,_that.description,_that.entries,_that.totalDebits,_that.totalCredits,_that.referenceType,_that.referenceId,_that.initiatedBy,_that.approvedBy,_that.createdAt,_that.postedAt,_that.reversedAt,_that.reversedBy,_that.reversalJournalId,_that.originalJournalId,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String idempotencyKey,  LedgerJournalType type,  LedgerJournalStatus status,  String description,  List<LedgerEntry> entries,  int totalDebits,  int totalCredits,  LedgerReferenceType? referenceType,  String? referenceId,  String initiatedBy,  String? approvedBy,  DateTime createdAt,  DateTime? postedAt,  DateTime? reversedAt,  String? reversedBy,  String? reversalJournalId,  String? originalJournalId,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _LedgerJournal():
return $default(_that.id,_that.idempotencyKey,_that.type,_that.status,_that.description,_that.entries,_that.totalDebits,_that.totalCredits,_that.referenceType,_that.referenceId,_that.initiatedBy,_that.approvedBy,_that.createdAt,_that.postedAt,_that.reversedAt,_that.reversedBy,_that.reversalJournalId,_that.originalJournalId,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String idempotencyKey,  LedgerJournalType type,  LedgerJournalStatus status,  String description,  List<LedgerEntry> entries,  int totalDebits,  int totalCredits,  LedgerReferenceType? referenceType,  String? referenceId,  String initiatedBy,  String? approvedBy,  DateTime createdAt,  DateTime? postedAt,  DateTime? reversedAt,  String? reversedBy,  String? reversalJournalId,  String? originalJournalId,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _LedgerJournal() when $default != null:
return $default(_that.id,_that.idempotencyKey,_that.type,_that.status,_that.description,_that.entries,_that.totalDebits,_that.totalCredits,_that.referenceType,_that.referenceId,_that.initiatedBy,_that.approvedBy,_that.createdAt,_that.postedAt,_that.reversedAt,_that.reversedBy,_that.reversalJournalId,_that.originalJournalId,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LedgerJournal extends LedgerJournal {
  const _LedgerJournal({required this.id, required this.idempotencyKey, required this.type, required this.status, required this.description, required final  List<LedgerEntry> entries, required this.totalDebits, required this.totalCredits, this.referenceType, this.referenceId, required this.initiatedBy, this.approvedBy, required this.createdAt, this.postedAt, this.reversedAt, this.reversedBy, this.reversalJournalId, this.originalJournalId, final  Map<String, dynamic> metadata = const {}}): _entries = entries,_metadata = metadata,super._();
  factory _LedgerJournal.fromJson(Map<String, dynamic> json) => _$LedgerJournalFromJson(json);

@override final  String id;
@override final  String idempotencyKey;
@override final  LedgerJournalType type;
@override final  LedgerJournalStatus status;
@override final  String description;
 final  List<LedgerEntry> _entries;
@override List<LedgerEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  int totalDebits;
@override final  int totalCredits;
@override final  LedgerReferenceType? referenceType;
@override final  String? referenceId;
@override final  String initiatedBy;
@override final  String? approvedBy;
@override final  DateTime createdAt;
@override final  DateTime? postedAt;
@override final  DateTime? reversedAt;
@override final  String? reversedBy;
@override final  String? reversalJournalId;
@override final  String? originalJournalId;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of LedgerJournal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerJournalCopyWith<_LedgerJournal> get copyWith => __$LedgerJournalCopyWithImpl<_LedgerJournal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LedgerJournalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerJournal&&(identical(other.id, id) || other.id == id)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.totalDebits, totalDebits) || other.totalDebits == totalDebits)&&(identical(other.totalCredits, totalCredits) || other.totalCredits == totalCredits)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.initiatedBy, initiatedBy) || other.initiatedBy == initiatedBy)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.reversedAt, reversedAt) || other.reversedAt == reversedAt)&&(identical(other.reversedBy, reversedBy) || other.reversedBy == reversedBy)&&(identical(other.reversalJournalId, reversalJournalId) || other.reversalJournalId == reversalJournalId)&&(identical(other.originalJournalId, originalJournalId) || other.originalJournalId == originalJournalId)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,idempotencyKey,type,status,description,const DeepCollectionEquality().hash(_entries),totalDebits,totalCredits,referenceType,referenceId,initiatedBy,approvedBy,createdAt,postedAt,reversedAt,reversedBy,reversalJournalId,originalJournalId,const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'LedgerJournal(id: $id, idempotencyKey: $idempotencyKey, type: $type, status: $status, description: $description, entries: $entries, totalDebits: $totalDebits, totalCredits: $totalCredits, referenceType: $referenceType, referenceId: $referenceId, initiatedBy: $initiatedBy, approvedBy: $approvedBy, createdAt: $createdAt, postedAt: $postedAt, reversedAt: $reversedAt, reversedBy: $reversedBy, reversalJournalId: $reversalJournalId, originalJournalId: $originalJournalId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$LedgerJournalCopyWith<$Res> implements $LedgerJournalCopyWith<$Res> {
  factory _$LedgerJournalCopyWith(_LedgerJournal value, $Res Function(_LedgerJournal) _then) = __$LedgerJournalCopyWithImpl;
@override @useResult
$Res call({
 String id, String idempotencyKey, LedgerJournalType type, LedgerJournalStatus status, String description, List<LedgerEntry> entries, int totalDebits, int totalCredits, LedgerReferenceType? referenceType, String? referenceId, String initiatedBy, String? approvedBy, DateTime createdAt, DateTime? postedAt, DateTime? reversedAt, String? reversedBy, String? reversalJournalId, String? originalJournalId, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$LedgerJournalCopyWithImpl<$Res>
    implements _$LedgerJournalCopyWith<$Res> {
  __$LedgerJournalCopyWithImpl(this._self, this._then);

  final _LedgerJournal _self;
  final $Res Function(_LedgerJournal) _then;

/// Create a copy of LedgerJournal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? idempotencyKey = null,Object? type = null,Object? status = null,Object? description = null,Object? entries = null,Object? totalDebits = null,Object? totalCredits = null,Object? referenceType = freezed,Object? referenceId = freezed,Object? initiatedBy = null,Object? approvedBy = freezed,Object? createdAt = null,Object? postedAt = freezed,Object? reversedAt = freezed,Object? reversedBy = freezed,Object? reversalJournalId = freezed,Object? originalJournalId = freezed,Object? metadata = null,}) {
  return _then(_LedgerJournal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerJournalType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LedgerJournalStatus,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<LedgerEntry>,totalDebits: null == totalDebits ? _self.totalDebits : totalDebits // ignore: cast_nullable_to_non_nullable
as int,totalCredits: null == totalCredits ? _self.totalCredits : totalCredits // ignore: cast_nullable_to_non_nullable
as int,referenceType: freezed == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as LedgerReferenceType?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,initiatedBy: null == initiatedBy ? _self.initiatedBy : initiatedBy // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,postedAt: freezed == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reversedAt: freezed == reversedAt ? _self.reversedAt : reversedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reversedBy: freezed == reversedBy ? _self.reversedBy : reversedBy // ignore: cast_nullable_to_non_nullable
as String?,reversalJournalId: freezed == reversalJournalId ? _self.reversalJournalId : reversalJournalId // ignore: cast_nullable_to_non_nullable
as String?,originalJournalId: freezed == originalJournalId ? _self.originalJournalId : originalJournalId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
