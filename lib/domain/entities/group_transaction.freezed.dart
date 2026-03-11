// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupTransaction {

 String get id; String get groupId; String? get journalId; GroupTransactionType get type; int get amount; String? get fromMemberId; String? get toMemberId; String get description; GroupTransactionStatus get status; String? get approvedBy; String get createdBy; DateTime get createdAt; DateTime? get completedAt;
/// Create a copy of GroupTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupTransactionCopyWith<GroupTransaction> get copyWith => _$GroupTransactionCopyWithImpl<GroupTransaction>(this as GroupTransaction, _$identity);

  /// Serializes this GroupTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fromMemberId, fromMemberId) || other.fromMemberId == fromMemberId)&&(identical(other.toMemberId, toMemberId) || other.toMemberId == toMemberId)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,journalId,type,amount,fromMemberId,toMemberId,description,status,approvedBy,createdBy,createdAt,completedAt);

@override
String toString() {
  return 'GroupTransaction(id: $id, groupId: $groupId, journalId: $journalId, type: $type, amount: $amount, fromMemberId: $fromMemberId, toMemberId: $toMemberId, description: $description, status: $status, approvedBy: $approvedBy, createdBy: $createdBy, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $GroupTransactionCopyWith<$Res>  {
  factory $GroupTransactionCopyWith(GroupTransaction value, $Res Function(GroupTransaction) _then) = _$GroupTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String? journalId, GroupTransactionType type, int amount, String? fromMemberId, String? toMemberId, String description, GroupTransactionStatus status, String? approvedBy, String createdBy, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class _$GroupTransactionCopyWithImpl<$Res>
    implements $GroupTransactionCopyWith<$Res> {
  _$GroupTransactionCopyWithImpl(this._self, this._then);

  final GroupTransaction _self;
  final $Res Function(GroupTransaction) _then;

/// Create a copy of GroupTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? fromMemberId = freezed,Object? toMemberId = freezed,Object? description = null,Object? status = null,Object? approvedBy = freezed,Object? createdBy = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GroupTransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,fromMemberId: freezed == fromMemberId ? _self.fromMemberId : fromMemberId // ignore: cast_nullable_to_non_nullable
as String?,toMemberId: freezed == toMemberId ? _self.toMemberId : toMemberId // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupTransactionStatus,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupTransaction].
extension GroupTransactionPatterns on GroupTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupTransaction value)  $default,){
final _that = this;
switch (_that) {
case _GroupTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _GroupTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String? journalId,  GroupTransactionType type,  int amount,  String? fromMemberId,  String? toMemberId,  String description,  GroupTransactionStatus status,  String? approvedBy,  String createdBy,  DateTime createdAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupTransaction() when $default != null:
return $default(_that.id,_that.groupId,_that.journalId,_that.type,_that.amount,_that.fromMemberId,_that.toMemberId,_that.description,_that.status,_that.approvedBy,_that.createdBy,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String? journalId,  GroupTransactionType type,  int amount,  String? fromMemberId,  String? toMemberId,  String description,  GroupTransactionStatus status,  String? approvedBy,  String createdBy,  DateTime createdAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupTransaction():
return $default(_that.id,_that.groupId,_that.journalId,_that.type,_that.amount,_that.fromMemberId,_that.toMemberId,_that.description,_that.status,_that.approvedBy,_that.createdBy,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String? journalId,  GroupTransactionType type,  int amount,  String? fromMemberId,  String? toMemberId,  String description,  GroupTransactionStatus status,  String? approvedBy,  String createdBy,  DateTime createdAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupTransaction() when $default != null:
return $default(_that.id,_that.groupId,_that.journalId,_that.type,_that.amount,_that.fromMemberId,_that.toMemberId,_that.description,_that.status,_that.approvedBy,_that.createdBy,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupTransaction extends GroupTransaction {
  const _GroupTransaction({required this.id, required this.groupId, this.journalId, required this.type, required this.amount, this.fromMemberId, this.toMemberId, required this.description, required this.status, this.approvedBy, required this.createdBy, required this.createdAt, this.completedAt}): super._();
  factory _GroupTransaction.fromJson(Map<String, dynamic> json) => _$GroupTransactionFromJson(json);

@override final  String id;
@override final  String groupId;
@override final  String? journalId;
@override final  GroupTransactionType type;
@override final  int amount;
@override final  String? fromMemberId;
@override final  String? toMemberId;
@override final  String description;
@override final  GroupTransactionStatus status;
@override final  String? approvedBy;
@override final  String createdBy;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;

/// Create a copy of GroupTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupTransactionCopyWith<_GroupTransaction> get copyWith => __$GroupTransactionCopyWithImpl<_GroupTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fromMemberId, fromMemberId) || other.fromMemberId == fromMemberId)&&(identical(other.toMemberId, toMemberId) || other.toMemberId == toMemberId)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,journalId,type,amount,fromMemberId,toMemberId,description,status,approvedBy,createdBy,createdAt,completedAt);

@override
String toString() {
  return 'GroupTransaction(id: $id, groupId: $groupId, journalId: $journalId, type: $type, amount: $amount, fromMemberId: $fromMemberId, toMemberId: $toMemberId, description: $description, status: $status, approvedBy: $approvedBy, createdBy: $createdBy, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupTransactionCopyWith<$Res> implements $GroupTransactionCopyWith<$Res> {
  factory _$GroupTransactionCopyWith(_GroupTransaction value, $Res Function(_GroupTransaction) _then) = __$GroupTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String? journalId, GroupTransactionType type, int amount, String? fromMemberId, String? toMemberId, String description, GroupTransactionStatus status, String? approvedBy, String createdBy, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class __$GroupTransactionCopyWithImpl<$Res>
    implements _$GroupTransactionCopyWith<$Res> {
  __$GroupTransactionCopyWithImpl(this._self, this._then);

  final _GroupTransaction _self;
  final $Res Function(_GroupTransaction) _then;

/// Create a copy of GroupTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? fromMemberId = freezed,Object? toMemberId = freezed,Object? description = null,Object? status = null,Object? approvedBy = freezed,Object? createdBy = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_GroupTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GroupTransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,fromMemberId: freezed == fromMemberId ? _self.fromMemberId : fromMemberId // ignore: cast_nullable_to_non_nullable
as String?,toMemberId: freezed == toMemberId ? _self.toMemberId : toMemberId // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupTransactionStatus,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PendingApproval {

 String get id; String get groupId; String get transactionId; List<String> get requiredApprovers; List<String> get approvers; String? get rejectedBy; String get status; DateTime get createdAt; DateTime get expiresAt;// Transaction details for display
 GroupTransactionType? get transactionType; int? get amount; String? get description; String? get createdBy;
/// Create a copy of PendingApproval
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingApprovalCopyWith<PendingApproval> get copyWith => _$PendingApprovalCopyWithImpl<PendingApproval>(this as PendingApproval, _$identity);

  /// Serializes this PendingApproval to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingApproval&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&const DeepCollectionEquality().equals(other.requiredApprovers, requiredApprovers)&&const DeepCollectionEquality().equals(other.approvers, approvers)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,transactionId,const DeepCollectionEquality().hash(requiredApprovers),const DeepCollectionEquality().hash(approvers),rejectedBy,status,createdAt,expiresAt,transactionType,amount,description,createdBy);

@override
String toString() {
  return 'PendingApproval(id: $id, groupId: $groupId, transactionId: $transactionId, requiredApprovers: $requiredApprovers, approvers: $approvers, rejectedBy: $rejectedBy, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, transactionType: $transactionType, amount: $amount, description: $description, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $PendingApprovalCopyWith<$Res>  {
  factory $PendingApprovalCopyWith(PendingApproval value, $Res Function(PendingApproval) _then) = _$PendingApprovalCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String transactionId, List<String> requiredApprovers, List<String> approvers, String? rejectedBy, String status, DateTime createdAt, DateTime expiresAt, GroupTransactionType? transactionType, int? amount, String? description, String? createdBy
});




}
/// @nodoc
class _$PendingApprovalCopyWithImpl<$Res>
    implements $PendingApprovalCopyWith<$Res> {
  _$PendingApprovalCopyWithImpl(this._self, this._then);

  final PendingApproval _self;
  final $Res Function(PendingApproval) _then;

/// Create a copy of PendingApproval
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? transactionId = null,Object? requiredApprovers = null,Object? approvers = null,Object? rejectedBy = freezed,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? transactionType = freezed,Object? amount = freezed,Object? description = freezed,Object? createdBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,requiredApprovers: null == requiredApprovers ? _self.requiredApprovers : requiredApprovers // ignore: cast_nullable_to_non_nullable
as List<String>,approvers: null == approvers ? _self.approvers : approvers // ignore: cast_nullable_to_non_nullable
as List<String>,rejectedBy: freezed == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,transactionType: freezed == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as GroupTransactionType?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingApproval].
extension PendingApprovalPatterns on PendingApproval {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingApproval value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingApproval() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingApproval value)  $default,){
final _that = this;
switch (_that) {
case _PendingApproval():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingApproval value)?  $default,){
final _that = this;
switch (_that) {
case _PendingApproval() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String transactionId,  List<String> requiredApprovers,  List<String> approvers,  String? rejectedBy,  String status,  DateTime createdAt,  DateTime expiresAt,  GroupTransactionType? transactionType,  int? amount,  String? description,  String? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingApproval() when $default != null:
return $default(_that.id,_that.groupId,_that.transactionId,_that.requiredApprovers,_that.approvers,_that.rejectedBy,_that.status,_that.createdAt,_that.expiresAt,_that.transactionType,_that.amount,_that.description,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String transactionId,  List<String> requiredApprovers,  List<String> approvers,  String? rejectedBy,  String status,  DateTime createdAt,  DateTime expiresAt,  GroupTransactionType? transactionType,  int? amount,  String? description,  String? createdBy)  $default,) {final _that = this;
switch (_that) {
case _PendingApproval():
return $default(_that.id,_that.groupId,_that.transactionId,_that.requiredApprovers,_that.approvers,_that.rejectedBy,_that.status,_that.createdAt,_that.expiresAt,_that.transactionType,_that.amount,_that.description,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String transactionId,  List<String> requiredApprovers,  List<String> approvers,  String? rejectedBy,  String status,  DateTime createdAt,  DateTime expiresAt,  GroupTransactionType? transactionType,  int? amount,  String? description,  String? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _PendingApproval() when $default != null:
return $default(_that.id,_that.groupId,_that.transactionId,_that.requiredApprovers,_that.approvers,_that.rejectedBy,_that.status,_that.createdAt,_that.expiresAt,_that.transactionType,_that.amount,_that.description,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingApproval extends PendingApproval {
  const _PendingApproval({required this.id, required this.groupId, required this.transactionId, required final  List<String> requiredApprovers, required final  List<String> approvers, this.rejectedBy, required this.status, required this.createdAt, required this.expiresAt, this.transactionType, this.amount, this.description, this.createdBy}): _requiredApprovers = requiredApprovers,_approvers = approvers,super._();
  factory _PendingApproval.fromJson(Map<String, dynamic> json) => _$PendingApprovalFromJson(json);

@override final  String id;
@override final  String groupId;
@override final  String transactionId;
 final  List<String> _requiredApprovers;
@override List<String> get requiredApprovers {
  if (_requiredApprovers is EqualUnmodifiableListView) return _requiredApprovers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredApprovers);
}

 final  List<String> _approvers;
@override List<String> get approvers {
  if (_approvers is EqualUnmodifiableListView) return _approvers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvers);
}

@override final  String? rejectedBy;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;
// Transaction details for display
@override final  GroupTransactionType? transactionType;
@override final  int? amount;
@override final  String? description;
@override final  String? createdBy;

/// Create a copy of PendingApproval
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingApprovalCopyWith<_PendingApproval> get copyWith => __$PendingApprovalCopyWithImpl<_PendingApproval>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingApprovalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingApproval&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&const DeepCollectionEquality().equals(other._requiredApprovers, _requiredApprovers)&&const DeepCollectionEquality().equals(other._approvers, _approvers)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,transactionId,const DeepCollectionEquality().hash(_requiredApprovers),const DeepCollectionEquality().hash(_approvers),rejectedBy,status,createdAt,expiresAt,transactionType,amount,description,createdBy);

@override
String toString() {
  return 'PendingApproval(id: $id, groupId: $groupId, transactionId: $transactionId, requiredApprovers: $requiredApprovers, approvers: $approvers, rejectedBy: $rejectedBy, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, transactionType: $transactionType, amount: $amount, description: $description, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PendingApprovalCopyWith<$Res> implements $PendingApprovalCopyWith<$Res> {
  factory _$PendingApprovalCopyWith(_PendingApproval value, $Res Function(_PendingApproval) _then) = __$PendingApprovalCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String transactionId, List<String> requiredApprovers, List<String> approvers, String? rejectedBy, String status, DateTime createdAt, DateTime expiresAt, GroupTransactionType? transactionType, int? amount, String? description, String? createdBy
});




}
/// @nodoc
class __$PendingApprovalCopyWithImpl<$Res>
    implements _$PendingApprovalCopyWith<$Res> {
  __$PendingApprovalCopyWithImpl(this._self, this._then);

  final _PendingApproval _self;
  final $Res Function(_PendingApproval) _then;

/// Create a copy of PendingApproval
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? transactionId = null,Object? requiredApprovers = null,Object? approvers = null,Object? rejectedBy = freezed,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? transactionType = freezed,Object? amount = freezed,Object? description = freezed,Object? createdBy = freezed,}) {
  return _then(_PendingApproval(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,requiredApprovers: null == requiredApprovers ? _self._requiredApprovers : requiredApprovers // ignore: cast_nullable_to_non_nullable
as List<String>,approvers: null == approvers ? _self._approvers : approvers // ignore: cast_nullable_to_non_nullable
as List<String>,rejectedBy: freezed == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,transactionType: freezed == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as GroupTransactionType?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
