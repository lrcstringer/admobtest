// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityTransactionModel implements DiagnosticableTreeMixin {

 String get id; String get communityId; String? get journalId; String get type; int get amount; String get memberId; String get memberName; String? get description; String get status; String? get approvedBy; String? get rejectedBy; String? get rejectionReason;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get completedAt;
/// Create a copy of CommunityTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityTransactionModelCopyWith<CommunityTransactionModel> get copyWith => _$CommunityTransactionModelCopyWithImpl<CommunityTransactionModel>(this as CommunityTransactionModel, _$identity);

  /// Serializes this CommunityTransactionModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityTransactionModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('journalId', journalId))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('memberId', memberId))..add(DiagnosticsProperty('memberName', memberName))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('approvedBy', approvedBy))..add(DiagnosticsProperty('rejectedBy', rejectedBy))..add(DiagnosticsProperty('rejectionReason', rejectionReason))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('completedAt', completedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,journalId,type,amount,memberId,memberName,description,status,approvedBy,rejectedBy,rejectionReason,createdAt,completedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityTransactionModel(id: $id, communityId: $communityId, journalId: $journalId, type: $type, amount: $amount, memberId: $memberId, memberName: $memberName, description: $description, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, rejectionReason: $rejectionReason, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityTransactionModelCopyWith<$Res>  {
  factory $CommunityTransactionModelCopyWith(CommunityTransactionModel value, $Res Function(CommunityTransactionModel) _then) = _$CommunityTransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String? journalId, String type, int amount, String memberId, String memberName, String? description, String status, String? approvedBy, String? rejectedBy, String? rejectionReason,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? completedAt
});




}
/// @nodoc
class _$CommunityTransactionModelCopyWithImpl<$Res>
    implements $CommunityTransactionModelCopyWith<$Res> {
  _$CommunityTransactionModelCopyWithImpl(this._self, this._then);

  final CommunityTransactionModel _self;
  final $Res Function(CommunityTransactionModel) _then;

/// Create a copy of CommunityTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? memberId = null,Object? memberName = null,Object? description = freezed,Object? status = null,Object? approvedBy = freezed,Object? rejectedBy = freezed,Object? rejectionReason = freezed,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectedBy: freezed == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityTransactionModel].
extension CommunityTransactionModelPatterns on CommunityTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _CommunityTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String? journalId,  String type,  int amount,  String memberId,  String memberName,  String? description,  String status,  String? approvedBy,  String? rejectedBy,  String? rejectionReason, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityTransactionModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String? journalId,  String type,  int amount,  String memberId,  String memberName,  String? description,  String status,  String? approvedBy,  String? rejectedBy,  String? rejectionReason, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityTransactionModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String? journalId,  String type,  int amount,  String memberId,  String memberName,  String? description,  String status,  String? approvedBy,  String? rejectedBy,  String? rejectionReason, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityTransactionModel() when $default != null:
return $default(_that.id,_that.communityId,_that.journalId,_that.type,_that.amount,_that.memberId,_that.memberName,_that.description,_that.status,_that.approvedBy,_that.rejectedBy,_that.rejectionReason,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityTransactionModel extends CommunityTransactionModel with DiagnosticableTreeMixin {
  const _CommunityTransactionModel({required this.id, required this.communityId, this.journalId, required this.type, required this.amount, required this.memberId, required this.memberName, this.description, required this.status, this.approvedBy, this.rejectedBy, this.rejectionReason, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.completedAt}): super._();
  factory _CommunityTransactionModel.fromJson(Map<String, dynamic> json) => _$CommunityTransactionModelFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String? journalId;
@override final  String type;
@override final  int amount;
@override final  String memberId;
@override final  String memberName;
@override final  String? description;
@override final  String status;
@override final  String? approvedBy;
@override final  String? rejectedBy;
@override final  String? rejectionReason;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? completedAt;

/// Create a copy of CommunityTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityTransactionModelCopyWith<_CommunityTransactionModel> get copyWith => __$CommunityTransactionModelCopyWithImpl<_CommunityTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityTransactionModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityTransactionModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('journalId', journalId))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('memberId', memberId))..add(DiagnosticsProperty('memberName', memberName))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('approvedBy', approvedBy))..add(DiagnosticsProperty('rejectedBy', rejectedBy))..add(DiagnosticsProperty('rejectionReason', rejectionReason))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('completedAt', completedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,journalId,type,amount,memberId,memberName,description,status,approvedBy,rejectedBy,rejectionReason,createdAt,completedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityTransactionModel(id: $id, communityId: $communityId, journalId: $journalId, type: $type, amount: $amount, memberId: $memberId, memberName: $memberName, description: $description, status: $status, approvedBy: $approvedBy, rejectedBy: $rejectedBy, rejectionReason: $rejectionReason, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityTransactionModelCopyWith<$Res> implements $CommunityTransactionModelCopyWith<$Res> {
  factory _$CommunityTransactionModelCopyWith(_CommunityTransactionModel value, $Res Function(_CommunityTransactionModel) _then) = __$CommunityTransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String? journalId, String type, int amount, String memberId, String memberName, String? description, String status, String? approvedBy, String? rejectedBy, String? rejectionReason,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? completedAt
});




}
/// @nodoc
class __$CommunityTransactionModelCopyWithImpl<$Res>
    implements _$CommunityTransactionModelCopyWith<$Res> {
  __$CommunityTransactionModelCopyWithImpl(this._self, this._then);

  final _CommunityTransactionModel _self;
  final $Res Function(_CommunityTransactionModel) _then;

/// Create a copy of CommunityTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? journalId = freezed,Object? type = null,Object? amount = null,Object? memberId = null,Object? memberName = null,Object? description = freezed,Object? status = null,Object? approvedBy = freezed,Object? rejectedBy = freezed,Object? rejectionReason = freezed,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_CommunityTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectedBy: freezed == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CommunityApprovalModel implements DiagnosticableTreeMixin {

 String get id; String get communityId; String get transactionId; String get requestedBy; String get requestedByName; int get amount; String get type; String? get description; List<String> get approvers; int get requiredApprovals; String get status;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get expiresAt;
/// Create a copy of CommunityApprovalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityApprovalModelCopyWith<CommunityApprovalModel> get copyWith => _$CommunityApprovalModelCopyWithImpl<CommunityApprovalModel>(this as CommunityApprovalModel, _$identity);

  /// Serializes this CommunityApprovalModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityApprovalModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('transactionId', transactionId))..add(DiagnosticsProperty('requestedBy', requestedBy))..add(DiagnosticsProperty('requestedByName', requestedByName))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('approvers', approvers))..add(DiagnosticsProperty('requiredApprovals', requiredApprovals))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('expiresAt', expiresAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityApprovalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.requestedByName, requestedByName) || other.requestedByName == requestedByName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.approvers, approvers)&&(identical(other.requiredApprovals, requiredApprovals) || other.requiredApprovals == requiredApprovals)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,transactionId,requestedBy,requestedByName,amount,type,description,const DeepCollectionEquality().hash(approvers),requiredApprovals,status,createdAt,expiresAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityApprovalModel(id: $id, communityId: $communityId, transactionId: $transactionId, requestedBy: $requestedBy, requestedByName: $requestedByName, amount: $amount, type: $type, description: $description, approvers: $approvers, requiredApprovals: $requiredApprovals, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CommunityApprovalModelCopyWith<$Res>  {
  factory $CommunityApprovalModelCopyWith(CommunityApprovalModel value, $Res Function(CommunityApprovalModel) _then) = _$CommunityApprovalModelCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String transactionId, String requestedBy, String requestedByName, int amount, String type, String? description, List<String> approvers, int requiredApprovals, String status,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime expiresAt
});




}
/// @nodoc
class _$CommunityApprovalModelCopyWithImpl<$Res>
    implements $CommunityApprovalModelCopyWith<$Res> {
  _$CommunityApprovalModelCopyWithImpl(this._self, this._then);

  final CommunityApprovalModel _self;
  final $Res Function(CommunityApprovalModel) _then;

/// Create a copy of CommunityApprovalModel
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
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,approvers: null == approvers ? _self.approvers : approvers // ignore: cast_nullable_to_non_nullable
as List<String>,requiredApprovals: null == requiredApprovals ? _self.requiredApprovals : requiredApprovals // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityApprovalModel].
extension CommunityApprovalModelPatterns on CommunityApprovalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityApprovalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityApprovalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityApprovalModel value)  $default,){
final _that = this;
switch (_that) {
case _CommunityApprovalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityApprovalModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityApprovalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String transactionId,  String requestedBy,  String requestedByName,  int amount,  String type,  String? description,  List<String> approvers,  int requiredApprovals,  String status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityApprovalModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String transactionId,  String requestedBy,  String requestedByName,  int amount,  String type,  String? description,  List<String> approvers,  int requiredApprovals,  String status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityApprovalModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String transactionId,  String requestedBy,  String requestedByName,  int amount,  String type,  String? description,  List<String> approvers,  int requiredApprovals,  String status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityApprovalModel() when $default != null:
return $default(_that.id,_that.communityId,_that.transactionId,_that.requestedBy,_that.requestedByName,_that.amount,_that.type,_that.description,_that.approvers,_that.requiredApprovals,_that.status,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityApprovalModel extends CommunityApprovalModel with DiagnosticableTreeMixin {
  const _CommunityApprovalModel({required this.id, required this.communityId, required this.transactionId, required this.requestedBy, required this.requestedByName, required this.amount, required this.type, this.description, required final  List<String> approvers, required this.requiredApprovals, required this.status, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.expiresAt}): _approvers = approvers,super._();
  factory _CommunityApprovalModel.fromJson(Map<String, dynamic> json) => _$CommunityApprovalModelFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String transactionId;
@override final  String requestedBy;
@override final  String requestedByName;
@override final  int amount;
@override final  String type;
@override final  String? description;
 final  List<String> _approvers;
@override List<String> get approvers {
  if (_approvers is EqualUnmodifiableListView) return _approvers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvers);
}

@override final  int requiredApprovals;
@override final  String status;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime expiresAt;

/// Create a copy of CommunityApprovalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityApprovalModelCopyWith<_CommunityApprovalModel> get copyWith => __$CommunityApprovalModelCopyWithImpl<_CommunityApprovalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityApprovalModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityApprovalModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('transactionId', transactionId))..add(DiagnosticsProperty('requestedBy', requestedBy))..add(DiagnosticsProperty('requestedByName', requestedByName))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('approvers', approvers))..add(DiagnosticsProperty('requiredApprovals', requiredApprovals))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('expiresAt', expiresAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityApprovalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.requestedByName, requestedByName) || other.requestedByName == requestedByName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._approvers, _approvers)&&(identical(other.requiredApprovals, requiredApprovals) || other.requiredApprovals == requiredApprovals)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,transactionId,requestedBy,requestedByName,amount,type,description,const DeepCollectionEquality().hash(_approvers),requiredApprovals,status,createdAt,expiresAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityApprovalModel(id: $id, communityId: $communityId, transactionId: $transactionId, requestedBy: $requestedBy, requestedByName: $requestedByName, amount: $amount, type: $type, description: $description, approvers: $approvers, requiredApprovals: $requiredApprovals, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityApprovalModelCopyWith<$Res> implements $CommunityApprovalModelCopyWith<$Res> {
  factory _$CommunityApprovalModelCopyWith(_CommunityApprovalModel value, $Res Function(_CommunityApprovalModel) _then) = __$CommunityApprovalModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String transactionId, String requestedBy, String requestedByName, int amount, String type, String? description, List<String> approvers, int requiredApprovals, String status,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime expiresAt
});




}
/// @nodoc
class __$CommunityApprovalModelCopyWithImpl<$Res>
    implements _$CommunityApprovalModelCopyWith<$Res> {
  __$CommunityApprovalModelCopyWithImpl(this._self, this._then);

  final _CommunityApprovalModel _self;
  final $Res Function(_CommunityApprovalModel) _then;

/// Create a copy of CommunityApprovalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? transactionId = null,Object? requestedBy = null,Object? requestedByName = null,Object? amount = null,Object? type = null,Object? description = freezed,Object? approvers = null,Object? requiredApprovals = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_CommunityApprovalModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,requestedByName: null == requestedByName ? _self.requestedByName : requestedByName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,approvers: null == approvers ? _self._approvers : approvers // ignore: cast_nullable_to_non_nullable
as List<String>,requiredApprovals: null == requiredApprovals ? _self.requiredApprovals : requiredApprovals // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
