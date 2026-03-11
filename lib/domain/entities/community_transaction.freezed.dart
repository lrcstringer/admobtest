// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityTransaction {

 String get id; String get communityId; String? get journalId; CommunityTransactionType get type; int get amount; String get memberId; String get memberName; String? get description; CommunityTransactionStatus get status; String? get approvedBy; String? get rejectedBy; String? get rejectionReason; DateTime get createdAt; DateTime? get completedAt;
/// Create a copy of CommunityTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityTransactionCopyWith<CommunityTransaction> get copyWith => _$CommunityTransactionCopyWithImpl<CommunityTransaction>(this as CommunityTransaction, _$identity);

  /// Serializes this CommunityTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,journalId,type,amount,memberId,memberName,description,status,approvedBy,rejectedBy,rejectionReason,createdAt,completedAt);

@override
String toString() {
  return 'CommunityTransaction(id: $id, communityId: $communityId, journalId: $journalId, type: $type, amount: $amount, memberId: $memberId, memberName: $memberName, description: $description, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, rejectionReason: $rejectionReason, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityTransactionCopyWith<$Res>  {
  factory $CommunityTransactionCopyWith(CommunityTransaction value, $Res Function(CommunityTransaction) _then) = _$CommunityTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String? journalId, CommunityTransactionType type, int amount, String memberId, String memberName, String? description, CommunityTransactionStatus status, String? approvedBy, String? rejectedBy, String? rejectionReason, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class _$CommunityTransactionCopyWithImpl<$Res>
    implements $CommunityTransactionCopyWith<$Res> {
  _$CommunityTransactionCopyWithImpl(this._self, this._then);

  final CommunityTransaction _self;
  final $Res Function(CommunityTransaction) _then;

/// Create a copy of CommunityTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? memberId = null,Object? memberName = null,Object? description = freezed,Object? status = null,Object? approvedBy = freezed,Object? rejectedBy = freezed,Object? rejectionReason = freezed,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommunityTransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommunityTransactionStatus,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectedBy: freezed == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityTransaction].
extension CommunityTransactionPatterns on CommunityTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityTransaction value)  $default,){
final _that = this;
switch (_that) {
case _CommunityTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String? journalId,  CommunityTransactionType type,  int amount,  String memberId,  String memberName,  String? description,  CommunityTransactionStatus status,  String? approvedBy,  String? rejectedBy,  String? rejectionReason,  DateTime createdAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityTransaction() when $default != null:
return $default(_that.id,_that.communityId,_that.journalId,_that.type,_that.amount,_that.memberId,_that.memberName,_that.description,_that.status,_that.approvedBy,_that.rejectedBy,_that.rejectionReason,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String? journalId,  CommunityTransactionType type,  int amount,  String memberId,  String memberName,  String? description,  CommunityTransactionStatus status,  String? approvedBy,  String? rejectedBy,  String? rejectionReason,  DateTime createdAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityTransaction():
return $default(_that.id,_that.communityId,_that.journalId,_that.type,_that.amount,_that.memberId,_that.memberName,_that.description,_that.status,_that.approvedBy,_that.rejectedBy,_that.rejectionReason,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String? journalId,  CommunityTransactionType type,  int amount,  String memberId,  String memberName,  String? description,  CommunityTransactionStatus status,  String? approvedBy,  String? rejectedBy,  String? rejectionReason,  DateTime createdAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityTransaction() when $default != null:
return $default(_that.id,_that.communityId,_that.journalId,_that.type,_that.amount,_that.memberId,_that.memberName,_that.description,_that.status,_that.approvedBy,_that.rejectedBy,_that.rejectionReason,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityTransaction extends CommunityTransaction {
  const _CommunityTransaction({required this.id, required this.communityId, this.journalId, required this.type, required this.amount, required this.memberId, required this.memberName, this.description, required this.status, this.approvedBy, this.rejectedBy, this.rejectionReason, required this.createdAt, this.completedAt}): super._();
  factory _CommunityTransaction.fromJson(Map<String, dynamic> json) => _$CommunityTransactionFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String? journalId;
@override final  CommunityTransactionType type;
@override final  int amount;
@override final  String memberId;
@override final  String memberName;
@override final  String? description;
@override final  CommunityTransactionStatus status;
@override final  String? approvedBy;
@override final  String? rejectedBy;
@override final  String? rejectionReason;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;

/// Create a copy of CommunityTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityTransactionCopyWith<_CommunityTransaction> get copyWith => __$CommunityTransactionCopyWithImpl<_CommunityTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,journalId,type,amount,memberId,memberName,description,status,approvedBy,rejectedBy,rejectionReason,createdAt,completedAt);

@override
String toString() {
  return 'CommunityTransaction(id: $id, communityId: $communityId, journalId: $journalId, type: $type, amount: $amount, memberId: $memberId, memberName: $memberName, description: $description, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, rejectionReason: $rejectionReason, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityTransactionCopyWith<$Res> implements $CommunityTransactionCopyWith<$Res> {
  factory _$CommunityTransactionCopyWith(_CommunityTransaction value, $Res Function(_CommunityTransaction) _then) = __$CommunityTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String? journalId, CommunityTransactionType type, int amount, String memberId, String memberName, String? description, CommunityTransactionStatus status, String? approvedBy, String? rejectedBy, String? rejectionReason, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class __$CommunityTransactionCopyWithImpl<$Res>
    implements _$CommunityTransactionCopyWith<$Res> {
  __$CommunityTransactionCopyWithImpl(this._self, this._then);

  final _CommunityTransaction _self;
  final $Res Function(_CommunityTransaction) _then;

/// Create a copy of CommunityTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? memberId = null,Object? memberName = null,Object? description = freezed,Object? status = null,Object? approvedBy = freezed,Object? rejectedBy = freezed,Object? rejectionReason = freezed,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_CommunityTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommunityTransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommunityTransactionStatus,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectedBy: freezed == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CommunityApproval {

 String get id; String get communityId; String get transactionId; String get requestedBy; String get requestedByName; int get amount; CommunityTransactionType get type; String? get description; List<String> get approvers; int get requiredApprovals; ApprovalStatus get status; DateTime get createdAt; DateTime get expiresAt;
/// Create a copy of CommunityApproval
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityApprovalCopyWith<CommunityApproval> get copyWith => _$CommunityApprovalCopyWithImpl<CommunityApproval>(this as CommunityApproval, _$identity);

  /// Serializes this CommunityApproval to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityApproval&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.requestedByName, requestedByName) || other.requestedByName == requestedByName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.approvers, approvers)&&(identical(other.requiredApprovals, requiredApprovals) || other.requiredApprovals == requiredApprovals)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,transactionId,requestedBy,requestedByName,amount,type,description,const DeepCollectionEquality().hash(approvers),requiredApprovals,status,createdAt,expiresAt);

@override
String toString() {
  return 'CommunityApproval(id: $id, communityId: $communityId, transactionId: $transactionId, requestedBy: $requestedBy, requestedByName: $requestedByName, amount: $amount, type: $type, description: $description, approvers: $approvers, requiredApprovals: $requiredApprovals, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CommunityApprovalCopyWith<$Res>  {
  factory $CommunityApprovalCopyWith(CommunityApproval value, $Res Function(CommunityApproval) _then) = _$CommunityApprovalCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String transactionId, String requestedBy, String requestedByName, int amount, CommunityTransactionType type, String? description, List<String> approvers, int requiredApprovals, ApprovalStatus status, DateTime createdAt, DateTime expiresAt
});




}
/// @nodoc
class _$CommunityApprovalCopyWithImpl<$Res>
    implements $CommunityApprovalCopyWith<$Res> {
  _$CommunityApprovalCopyWithImpl(this._self, this._then);

  final CommunityApproval _self;
  final $Res Function(CommunityApproval) _then;

/// Create a copy of CommunityApproval
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? transactionId = null,Object? requestedBy = null,Object? requestedByName = null,Object? amount = null,Object? type = null,Object? description = freezed,Object? approvers = null,Object? requiredApprovals = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,requestedByName: null == requestedByName ? _self.requestedByName : requestedByName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommunityTransactionType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,approvers: null == approvers ? _self.approvers : approvers // ignore: cast_nullable_to_non_nullable
as List<String>,requiredApprovals: null == requiredApprovals ? _self.requiredApprovals : requiredApprovals // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApprovalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityApproval].
extension CommunityApprovalPatterns on CommunityApproval {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityApproval value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityApproval() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityApproval value)  $default,){
final _that = this;
switch (_that) {
case _CommunityApproval():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityApproval value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityApproval() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String transactionId,  String requestedBy,  String requestedByName,  int amount,  CommunityTransactionType type,  String? description,  List<String> approvers,  int requiredApprovals,  ApprovalStatus status,  DateTime createdAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityApproval() when $default != null:
return $default(_that.id,_that.communityId,_that.transactionId,_that.requestedBy,_that.requestedByName,_that.amount,_that.type,_that.description,_that.approvers,_that.requiredApprovals,_that.status,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String transactionId,  String requestedBy,  String requestedByName,  int amount,  CommunityTransactionType type,  String? description,  List<String> approvers,  int requiredApprovals,  ApprovalStatus status,  DateTime createdAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityApproval():
return $default(_that.id,_that.communityId,_that.transactionId,_that.requestedBy,_that.requestedByName,_that.amount,_that.type,_that.description,_that.approvers,_that.requiredApprovals,_that.status,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String transactionId,  String requestedBy,  String requestedByName,  int amount,  CommunityTransactionType type,  String? description,  List<String> approvers,  int requiredApprovals,  ApprovalStatus status,  DateTime createdAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityApproval() when $default != null:
return $default(_that.id,_that.communityId,_that.transactionId,_that.requestedBy,_that.requestedByName,_that.amount,_that.type,_that.description,_that.approvers,_that.requiredApprovals,_that.status,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityApproval extends CommunityApproval {
  const _CommunityApproval({required this.id, required this.communityId, required this.transactionId, required this.requestedBy, required this.requestedByName, required this.amount, required this.type, this.description, required final  List<String> approvers, required this.requiredApprovals, required this.status, required this.createdAt, required this.expiresAt}): _approvers = approvers,super._();
  factory _CommunityApproval.fromJson(Map<String, dynamic> json) => _$CommunityApprovalFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String transactionId;
@override final  String requestedBy;
@override final  String requestedByName;
@override final  int amount;
@override final  CommunityTransactionType type;
@override final  String? description;
 final  List<String> _approvers;
@override List<String> get approvers {
  if (_approvers is EqualUnmodifiableListView) return _approvers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvers);
}

@override final  int requiredApprovals;
@override final  ApprovalStatus status;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;

/// Create a copy of CommunityApproval
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityApprovalCopyWith<_CommunityApproval> get copyWith => __$CommunityApprovalCopyWithImpl<_CommunityApproval>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityApprovalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityApproval&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.requestedByName, requestedByName) || other.requestedByName == requestedByName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._approvers, _approvers)&&(identical(other.requiredApprovals, requiredApprovals) || other.requiredApprovals == requiredApprovals)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,transactionId,requestedBy,requestedByName,amount,type,description,const DeepCollectionEquality().hash(_approvers),requiredApprovals,status,createdAt,expiresAt);

@override
String toString() {
  return 'CommunityApproval(id: $id, communityId: $communityId, transactionId: $transactionId, requestedBy: $requestedBy, requestedByName: $requestedByName, amount: $amount, type: $type, description: $description, approvers: $approvers, requiredApprovals: $requiredApprovals, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityApprovalCopyWith<$Res> implements $CommunityApprovalCopyWith<$Res> {
  factory _$CommunityApprovalCopyWith(_CommunityApproval value, $Res Function(_CommunityApproval) _then) = __$CommunityApprovalCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String transactionId, String requestedBy, String requestedByName, int amount, CommunityTransactionType type, String? description, List<String> approvers, int requiredApprovals, ApprovalStatus status, DateTime createdAt, DateTime expiresAt
});




}
/// @nodoc
class __$CommunityApprovalCopyWithImpl<$Res>
    implements _$CommunityApprovalCopyWith<$Res> {
  __$CommunityApprovalCopyWithImpl(this._self, this._then);

  final _CommunityApproval _self;
  final $Res Function(_CommunityApproval) _then;

/// Create a copy of CommunityApproval
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? transactionId = null,Object? requestedBy = null,Object? requestedByName = null,Object? amount = null,Object? type = null,Object? description = freezed,Object? approvers = null,Object? requiredApprovals = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_CommunityApproval(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,requestedByName: null == requestedByName ? _self.requestedByName : requestedByName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommunityTransactionType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,approvers: null == approvers ? _self._approvers : approvers // ignore: cast_nullable_to_non_nullable
as List<String>,requiredApprovals: null == requiredApprovals ? _self.requiredApprovals : requiredApprovals // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApprovalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
