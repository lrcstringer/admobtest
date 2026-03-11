// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupTransactionModel {

 String get id; String get groupId; String? get journalId; String get type; int get amount; String? get fromMemberId; String? get toMemberId; String get description; String get status; String? get approvedBy; String get createdBy;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get completedAt;
/// Create a copy of GroupTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupTransactionModelCopyWith<GroupTransactionModel> get copyWith => _$GroupTransactionModelCopyWithImpl<GroupTransactionModel>(this as GroupTransactionModel, _$identity);

  /// Serializes this GroupTransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fromMemberId, fromMemberId) || other.fromMemberId == fromMemberId)&&(identical(other.toMemberId, toMemberId) || other.toMemberId == toMemberId)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,journalId,type,amount,fromMemberId,toMemberId,description,status,approvedBy,createdBy,createdAt,completedAt);

@override
String toString() {
  return 'GroupTransactionModel(id: $id, groupId: $groupId, journalId: $journalId, type: $type, amount: $amount, fromMemberId: $fromMemberId, toMemberId: $toMemberId, description: $description, status: $status, approvedBy: $approvedBy, createdBy: $createdBy, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $GroupTransactionModelCopyWith<$Res>  {
  factory $GroupTransactionModelCopyWith(GroupTransactionModel value, $Res Function(GroupTransactionModel) _then) = _$GroupTransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String? journalId, String type, int amount, String? fromMemberId, String? toMemberId, String description, String status, String? approvedBy, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? completedAt
});




}
/// @nodoc
class _$GroupTransactionModelCopyWithImpl<$Res>
    implements $GroupTransactionModelCopyWith<$Res> {
  _$GroupTransactionModelCopyWithImpl(this._self, this._then);

  final GroupTransactionModel _self;
  final $Res Function(GroupTransactionModel) _then;

/// Create a copy of GroupTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? fromMemberId = freezed,Object? toMemberId = freezed,Object? description = null,Object? status = null,Object? approvedBy = freezed,Object? createdBy = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,fromMemberId: freezed == fromMemberId ? _self.fromMemberId : fromMemberId // ignore: cast_nullable_to_non_nullable
as String?,toMemberId: freezed == toMemberId ? _self.toMemberId : toMemberId // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupTransactionModel].
extension GroupTransactionModelPatterns on GroupTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String? journalId,  String type,  int amount,  String? fromMemberId,  String? toMemberId,  String description,  String status,  String? approvedBy,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupTransactionModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String? journalId,  String type,  int amount,  String? fromMemberId,  String? toMemberId,  String description,  String status,  String? approvedBy,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupTransactionModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String? journalId,  String type,  int amount,  String? fromMemberId,  String? toMemberId,  String description,  String status,  String? approvedBy,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupTransactionModel() when $default != null:
return $default(_that.id,_that.groupId,_that.journalId,_that.type,_that.amount,_that.fromMemberId,_that.toMemberId,_that.description,_that.status,_that.approvedBy,_that.createdBy,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupTransactionModel extends GroupTransactionModel {
  const _GroupTransactionModel({required this.id, required this.groupId, this.journalId, required this.type, required this.amount, this.fromMemberId, this.toMemberId, required this.description, required this.status, this.approvedBy, required this.createdBy, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.completedAt}): super._();
  factory _GroupTransactionModel.fromJson(Map<String, dynamic> json) => _$GroupTransactionModelFromJson(json);

@override final  String id;
@override final  String groupId;
@override final  String? journalId;
@override final  String type;
@override final  int amount;
@override final  String? fromMemberId;
@override final  String? toMemberId;
@override final  String description;
@override final  String status;
@override final  String? approvedBy;
@override final  String createdBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? completedAt;

/// Create a copy of GroupTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupTransactionModelCopyWith<_GroupTransactionModel> get copyWith => __$GroupTransactionModelCopyWithImpl<_GroupTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupTransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fromMemberId, fromMemberId) || other.fromMemberId == fromMemberId)&&(identical(other.toMemberId, toMemberId) || other.toMemberId == toMemberId)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,journalId,type,amount,fromMemberId,toMemberId,description,status,approvedBy,createdBy,createdAt,completedAt);

@override
String toString() {
  return 'GroupTransactionModel(id: $id, groupId: $groupId, journalId: $journalId, type: $type, amount: $amount, fromMemberId: $fromMemberId, toMemberId: $toMemberId, description: $description, status: $status, approvedBy: $approvedBy, createdBy: $createdBy, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupTransactionModelCopyWith<$Res> implements $GroupTransactionModelCopyWith<$Res> {
  factory _$GroupTransactionModelCopyWith(_GroupTransactionModel value, $Res Function(_GroupTransactionModel) _then) = __$GroupTransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String? journalId, String type, int amount, String? fromMemberId, String? toMemberId, String description, String status, String? approvedBy, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? completedAt
});




}
/// @nodoc
class __$GroupTransactionModelCopyWithImpl<$Res>
    implements _$GroupTransactionModelCopyWith<$Res> {
  __$GroupTransactionModelCopyWithImpl(this._self, this._then);

  final _GroupTransactionModel _self;
  final $Res Function(_GroupTransactionModel) _then;

/// Create a copy of GroupTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? fromMemberId = freezed,Object? toMemberId = freezed,Object? description = null,Object? status = null,Object? approvedBy = freezed,Object? createdBy = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_GroupTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,fromMemberId: freezed == fromMemberId ? _self.fromMemberId : fromMemberId // ignore: cast_nullable_to_non_nullable
as String?,toMemberId: freezed == toMemberId ? _self.toMemberId : toMemberId // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PendingApprovalModel {

 String get id; String get groupId; String get transactionId; List<String> get requiredApprovers; List<String> get approvers; String? get rejectedBy; String get status;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get expiresAt;// Transaction details (populated when fetching approvals)
 String? get transactionType; int? get amount; String? get description; String? get createdBy;
/// Create a copy of PendingApprovalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingApprovalModelCopyWith<PendingApprovalModel> get copyWith => _$PendingApprovalModelCopyWithImpl<PendingApprovalModel>(this as PendingApprovalModel, _$identity);

  /// Serializes this PendingApprovalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingApprovalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&const DeepCollectionEquality().equals(other.requiredApprovers, requiredApprovers)&&const DeepCollectionEquality().equals(other.approvers, approvers)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,transactionId,const DeepCollectionEquality().hash(requiredApprovers),const DeepCollectionEquality().hash(approvers),rejectedBy,status,createdAt,expiresAt,transactionType,amount,description,createdBy);

@override
String toString() {
  return 'PendingApprovalModel(id: $id, groupId: $groupId, transactionId: $transactionId, requiredApprovers: $requiredApprovers, approvers: $approvers, rejectedBy: $rejectedBy, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, transactionType: $transactionType, amount: $amount, description: $description, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $PendingApprovalModelCopyWith<$Res>  {
  factory $PendingApprovalModelCopyWith(PendingApprovalModel value, $Res Function(PendingApprovalModel) _then) = _$PendingApprovalModelCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String transactionId, List<String> requiredApprovers, List<String> approvers, String? rejectedBy, String status,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime expiresAt, String? transactionType, int? amount, String? description, String? createdBy
});




}
/// @nodoc
class _$PendingApprovalModelCopyWithImpl<$Res>
    implements $PendingApprovalModelCopyWith<$Res> {
  _$PendingApprovalModelCopyWithImpl(this._self, this._then);

  final PendingApprovalModel _self;
  final $Res Function(PendingApprovalModel) _then;

/// Create a copy of PendingApprovalModel
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
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingApprovalModel].
extension PendingApprovalModelPatterns on PendingApprovalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingApprovalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingApprovalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingApprovalModel value)  $default,){
final _that = this;
switch (_that) {
case _PendingApprovalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingApprovalModel value)?  $default,){
final _that = this;
switch (_that) {
case _PendingApprovalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String transactionId,  List<String> requiredApprovers,  List<String> approvers,  String? rejectedBy,  String status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime expiresAt,  String? transactionType,  int? amount,  String? description,  String? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingApprovalModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String transactionId,  List<String> requiredApprovers,  List<String> approvers,  String? rejectedBy,  String status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime expiresAt,  String? transactionType,  int? amount,  String? description,  String? createdBy)  $default,) {final _that = this;
switch (_that) {
case _PendingApprovalModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String transactionId,  List<String> requiredApprovers,  List<String> approvers,  String? rejectedBy,  String status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime expiresAt,  String? transactionType,  int? amount,  String? description,  String? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _PendingApprovalModel() when $default != null:
return $default(_that.id,_that.groupId,_that.transactionId,_that.requiredApprovers,_that.approvers,_that.rejectedBy,_that.status,_that.createdAt,_that.expiresAt,_that.transactionType,_that.amount,_that.description,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingApprovalModel extends PendingApprovalModel {
  const _PendingApprovalModel({required this.id, required this.groupId, required this.transactionId, required final  List<String> requiredApprovers, required final  List<String> approvers, this.rejectedBy, required this.status, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.expiresAt, this.transactionType, this.amount, this.description, this.createdBy}): _requiredApprovers = requiredApprovers,_approvers = approvers,super._();
  factory _PendingApprovalModel.fromJson(Map<String, dynamic> json) => _$PendingApprovalModelFromJson(json);

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
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime expiresAt;
// Transaction details (populated when fetching approvals)
@override final  String? transactionType;
@override final  int? amount;
@override final  String? description;
@override final  String? createdBy;

/// Create a copy of PendingApprovalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingApprovalModelCopyWith<_PendingApprovalModel> get copyWith => __$PendingApprovalModelCopyWithImpl<_PendingApprovalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingApprovalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingApprovalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&const DeepCollectionEquality().equals(other._requiredApprovers, _requiredApprovers)&&const DeepCollectionEquality().equals(other._approvers, _approvers)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,transactionId,const DeepCollectionEquality().hash(_requiredApprovers),const DeepCollectionEquality().hash(_approvers),rejectedBy,status,createdAt,expiresAt,transactionType,amount,description,createdBy);

@override
String toString() {
  return 'PendingApprovalModel(id: $id, groupId: $groupId, transactionId: $transactionId, requiredApprovers: $requiredApprovers, approvers: $approvers, rejectedBy: $rejectedBy, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, transactionType: $transactionType, amount: $amount, description: $description, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PendingApprovalModelCopyWith<$Res> implements $PendingApprovalModelCopyWith<$Res> {
  factory _$PendingApprovalModelCopyWith(_PendingApprovalModel value, $Res Function(_PendingApprovalModel) _then) = __$PendingApprovalModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String transactionId, List<String> requiredApprovers, List<String> approvers, String? rejectedBy, String status,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime expiresAt, String? transactionType, int? amount, String? description, String? createdBy
});




}
/// @nodoc
class __$PendingApprovalModelCopyWithImpl<$Res>
    implements _$PendingApprovalModelCopyWith<$Res> {
  __$PendingApprovalModelCopyWithImpl(this._self, this._then);

  final _PendingApprovalModel _self;
  final $Res Function(_PendingApprovalModel) _then;

/// Create a copy of PendingApprovalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? transactionId = null,Object? requiredApprovers = null,Object? approvers = null,Object? rejectedBy = freezed,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? transactionType = freezed,Object? amount = freezed,Object? description = freezed,Object? createdBy = freezed,}) {
  return _then(_PendingApprovalModel(
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
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
