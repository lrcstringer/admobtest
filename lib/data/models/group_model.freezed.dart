// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupSettingsModel {

 int get requireApprovalAbove; bool get allowMemberWithdrawals; String get contributionCycle; int get contributionAmount; int get penaltyPercentage;
/// Create a copy of GroupSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupSettingsModelCopyWith<GroupSettingsModel> get copyWith => _$GroupSettingsModelCopyWithImpl<GroupSettingsModel>(this as GroupSettingsModel, _$identity);

  /// Serializes this GroupSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupSettingsModel&&(identical(other.requireApprovalAbove, requireApprovalAbove) || other.requireApprovalAbove == requireApprovalAbove)&&(identical(other.allowMemberWithdrawals, allowMemberWithdrawals) || other.allowMemberWithdrawals == allowMemberWithdrawals)&&(identical(other.contributionCycle, contributionCycle) || other.contributionCycle == contributionCycle)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.penaltyPercentage, penaltyPercentage) || other.penaltyPercentage == penaltyPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requireApprovalAbove,allowMemberWithdrawals,contributionCycle,contributionAmount,penaltyPercentage);

@override
String toString() {
  return 'GroupSettingsModel(requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
}


}

/// @nodoc
abstract mixin class $GroupSettingsModelCopyWith<$Res>  {
  factory $GroupSettingsModelCopyWith(GroupSettingsModel value, $Res Function(GroupSettingsModel) _then) = _$GroupSettingsModelCopyWithImpl;
@useResult
$Res call({
 int requireApprovalAbove, bool allowMemberWithdrawals, String contributionCycle, int contributionAmount, int penaltyPercentage
});




}
/// @nodoc
class _$GroupSettingsModelCopyWithImpl<$Res>
    implements $GroupSettingsModelCopyWith<$Res> {
  _$GroupSettingsModelCopyWithImpl(this._self, this._then);

  final GroupSettingsModel _self;
  final $Res Function(GroupSettingsModel) _then;

/// Create a copy of GroupSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requireApprovalAbove = null,Object? allowMemberWithdrawals = null,Object? contributionCycle = null,Object? contributionAmount = null,Object? penaltyPercentage = null,}) {
  return _then(_self.copyWith(
requireApprovalAbove: null == requireApprovalAbove ? _self.requireApprovalAbove : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
as int,allowMemberWithdrawals: null == allowMemberWithdrawals ? _self.allowMemberWithdrawals : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
as bool,contributionCycle: null == contributionCycle ? _self.contributionCycle : contributionCycle // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,penaltyPercentage: null == penaltyPercentage ? _self.penaltyPercentage : penaltyPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupSettingsModel].
extension GroupSettingsModelPatterns on GroupSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int requireApprovalAbove,  bool allowMemberWithdrawals,  String contributionCycle,  int contributionAmount,  int penaltyPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupSettingsModel() when $default != null:
return $default(_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int requireApprovalAbove,  bool allowMemberWithdrawals,  String contributionCycle,  int contributionAmount,  int penaltyPercentage)  $default,) {final _that = this;
switch (_that) {
case _GroupSettingsModel():
return $default(_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int requireApprovalAbove,  bool allowMemberWithdrawals,  String contributionCycle,  int contributionAmount,  int penaltyPercentage)?  $default,) {final _that = this;
switch (_that) {
case _GroupSettingsModel() when $default != null:
return $default(_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupSettingsModel extends GroupSettingsModel {
  const _GroupSettingsModel({required this.requireApprovalAbove, required this.allowMemberWithdrawals, required this.contributionCycle, required this.contributionAmount, required this.penaltyPercentage}): super._();
  factory _GroupSettingsModel.fromJson(Map<String, dynamic> json) => _$GroupSettingsModelFromJson(json);

@override final  int requireApprovalAbove;
@override final  bool allowMemberWithdrawals;
@override final  String contributionCycle;
@override final  int contributionAmount;
@override final  int penaltyPercentage;

/// Create a copy of GroupSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupSettingsModelCopyWith<_GroupSettingsModel> get copyWith => __$GroupSettingsModelCopyWithImpl<_GroupSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupSettingsModel&&(identical(other.requireApprovalAbove, requireApprovalAbove) || other.requireApprovalAbove == requireApprovalAbove)&&(identical(other.allowMemberWithdrawals, allowMemberWithdrawals) || other.allowMemberWithdrawals == allowMemberWithdrawals)&&(identical(other.contributionCycle, contributionCycle) || other.contributionCycle == contributionCycle)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.penaltyPercentage, penaltyPercentage) || other.penaltyPercentage == penaltyPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requireApprovalAbove,allowMemberWithdrawals,contributionCycle,contributionAmount,penaltyPercentage);

@override
String toString() {
  return 'GroupSettingsModel(requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
}


}

/// @nodoc
abstract mixin class _$GroupSettingsModelCopyWith<$Res> implements $GroupSettingsModelCopyWith<$Res> {
  factory _$GroupSettingsModelCopyWith(_GroupSettingsModel value, $Res Function(_GroupSettingsModel) _then) = __$GroupSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 int requireApprovalAbove, bool allowMemberWithdrawals, String contributionCycle, int contributionAmount, int penaltyPercentage
});




}
/// @nodoc
class __$GroupSettingsModelCopyWithImpl<$Res>
    implements _$GroupSettingsModelCopyWith<$Res> {
  __$GroupSettingsModelCopyWithImpl(this._self, this._then);

  final _GroupSettingsModel _self;
  final $Res Function(_GroupSettingsModel) _then;

/// Create a copy of GroupSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requireApprovalAbove = null,Object? allowMemberWithdrawals = null,Object? contributionCycle = null,Object? contributionAmount = null,Object? penaltyPercentage = null,}) {
  return _then(_GroupSettingsModel(
requireApprovalAbove: null == requireApprovalAbove ? _self.requireApprovalAbove : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
as int,allowMemberWithdrawals: null == allowMemberWithdrawals ? _self.allowMemberWithdrawals : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
as bool,contributionCycle: null == contributionCycle ? _self.contributionCycle : contributionCycle // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,penaltyPercentage: null == penaltyPercentage ? _self.penaltyPercentage : penaltyPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StokvelSettingsModel {

 String get payoutType; String get payoutSchedule; String? get currentPayoutRecipient;@NullableTimestampConverter() DateTime? get nextPayoutDate; List<String> get payoutOrder;
/// Create a copy of StokvelSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StokvelSettingsModelCopyWith<StokvelSettingsModel> get copyWith => _$StokvelSettingsModelCopyWithImpl<StokvelSettingsModel>(this as StokvelSettingsModel, _$identity);

  /// Serializes this StokvelSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StokvelSettingsModel&&(identical(other.payoutType, payoutType) || other.payoutType == payoutType)&&(identical(other.payoutSchedule, payoutSchedule) || other.payoutSchedule == payoutSchedule)&&(identical(other.currentPayoutRecipient, currentPayoutRecipient) || other.currentPayoutRecipient == currentPayoutRecipient)&&(identical(other.nextPayoutDate, nextPayoutDate) || other.nextPayoutDate == nextPayoutDate)&&const DeepCollectionEquality().equals(other.payoutOrder, payoutOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payoutType,payoutSchedule,currentPayoutRecipient,nextPayoutDate,const DeepCollectionEquality().hash(payoutOrder));

@override
String toString() {
  return 'StokvelSettingsModel(payoutType: $payoutType, payoutSchedule: $payoutSchedule, currentPayoutRecipient: $currentPayoutRecipient, nextPayoutDate: $nextPayoutDate, payoutOrder: $payoutOrder)';
}


}

/// @nodoc
abstract mixin class $StokvelSettingsModelCopyWith<$Res>  {
  factory $StokvelSettingsModelCopyWith(StokvelSettingsModel value, $Res Function(StokvelSettingsModel) _then) = _$StokvelSettingsModelCopyWithImpl;
@useResult
$Res call({
 String payoutType, String payoutSchedule, String? currentPayoutRecipient,@NullableTimestampConverter() DateTime? nextPayoutDate, List<String> payoutOrder
});




}
/// @nodoc
class _$StokvelSettingsModelCopyWithImpl<$Res>
    implements $StokvelSettingsModelCopyWith<$Res> {
  _$StokvelSettingsModelCopyWithImpl(this._self, this._then);

  final StokvelSettingsModel _self;
  final $Res Function(StokvelSettingsModel) _then;

/// Create a copy of StokvelSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payoutType = null,Object? payoutSchedule = null,Object? currentPayoutRecipient = freezed,Object? nextPayoutDate = freezed,Object? payoutOrder = null,}) {
  return _then(_self.copyWith(
payoutType: null == payoutType ? _self.payoutType : payoutType // ignore: cast_nullable_to_non_nullable
as String,payoutSchedule: null == payoutSchedule ? _self.payoutSchedule : payoutSchedule // ignore: cast_nullable_to_non_nullable
as String,currentPayoutRecipient: freezed == currentPayoutRecipient ? _self.currentPayoutRecipient : currentPayoutRecipient // ignore: cast_nullable_to_non_nullable
as String?,nextPayoutDate: freezed == nextPayoutDate ? _self.nextPayoutDate : nextPayoutDate // ignore: cast_nullable_to_non_nullable
as DateTime?,payoutOrder: null == payoutOrder ? _self.payoutOrder : payoutOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StokvelSettingsModel].
extension StokvelSettingsModelPatterns on StokvelSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StokvelSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StokvelSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StokvelSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _StokvelSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StokvelSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _StokvelSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String payoutType,  String payoutSchedule,  String? currentPayoutRecipient, @NullableTimestampConverter()  DateTime? nextPayoutDate,  List<String> payoutOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StokvelSettingsModel() when $default != null:
return $default(_that.payoutType,_that.payoutSchedule,_that.currentPayoutRecipient,_that.nextPayoutDate,_that.payoutOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String payoutType,  String payoutSchedule,  String? currentPayoutRecipient, @NullableTimestampConverter()  DateTime? nextPayoutDate,  List<String> payoutOrder)  $default,) {final _that = this;
switch (_that) {
case _StokvelSettingsModel():
return $default(_that.payoutType,_that.payoutSchedule,_that.currentPayoutRecipient,_that.nextPayoutDate,_that.payoutOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String payoutType,  String payoutSchedule,  String? currentPayoutRecipient, @NullableTimestampConverter()  DateTime? nextPayoutDate,  List<String> payoutOrder)?  $default,) {final _that = this;
switch (_that) {
case _StokvelSettingsModel() when $default != null:
return $default(_that.payoutType,_that.payoutSchedule,_that.currentPayoutRecipient,_that.nextPayoutDate,_that.payoutOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StokvelSettingsModel extends StokvelSettingsModel {
  const _StokvelSettingsModel({required this.payoutType, required this.payoutSchedule, this.currentPayoutRecipient, @NullableTimestampConverter() this.nextPayoutDate, required final  List<String> payoutOrder}): _payoutOrder = payoutOrder,super._();
  factory _StokvelSettingsModel.fromJson(Map<String, dynamic> json) => _$StokvelSettingsModelFromJson(json);

@override final  String payoutType;
@override final  String payoutSchedule;
@override final  String? currentPayoutRecipient;
@override@NullableTimestampConverter() final  DateTime? nextPayoutDate;
 final  List<String> _payoutOrder;
@override List<String> get payoutOrder {
  if (_payoutOrder is EqualUnmodifiableListView) return _payoutOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payoutOrder);
}


/// Create a copy of StokvelSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StokvelSettingsModelCopyWith<_StokvelSettingsModel> get copyWith => __$StokvelSettingsModelCopyWithImpl<_StokvelSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StokvelSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StokvelSettingsModel&&(identical(other.payoutType, payoutType) || other.payoutType == payoutType)&&(identical(other.payoutSchedule, payoutSchedule) || other.payoutSchedule == payoutSchedule)&&(identical(other.currentPayoutRecipient, currentPayoutRecipient) || other.currentPayoutRecipient == currentPayoutRecipient)&&(identical(other.nextPayoutDate, nextPayoutDate) || other.nextPayoutDate == nextPayoutDate)&&const DeepCollectionEquality().equals(other._payoutOrder, _payoutOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payoutType,payoutSchedule,currentPayoutRecipient,nextPayoutDate,const DeepCollectionEquality().hash(_payoutOrder));

@override
String toString() {
  return 'StokvelSettingsModel(payoutType: $payoutType, payoutSchedule: $payoutSchedule, currentPayoutRecipient: $currentPayoutRecipient, nextPayoutDate: $nextPayoutDate, payoutOrder: $payoutOrder)';
}


}

/// @nodoc
abstract mixin class _$StokvelSettingsModelCopyWith<$Res> implements $StokvelSettingsModelCopyWith<$Res> {
  factory _$StokvelSettingsModelCopyWith(_StokvelSettingsModel value, $Res Function(_StokvelSettingsModel) _then) = __$StokvelSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 String payoutType, String payoutSchedule, String? currentPayoutRecipient,@NullableTimestampConverter() DateTime? nextPayoutDate, List<String> payoutOrder
});




}
/// @nodoc
class __$StokvelSettingsModelCopyWithImpl<$Res>
    implements _$StokvelSettingsModelCopyWith<$Res> {
  __$StokvelSettingsModelCopyWithImpl(this._self, this._then);

  final _StokvelSettingsModel _self;
  final $Res Function(_StokvelSettingsModel) _then;

/// Create a copy of StokvelSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payoutType = null,Object? payoutSchedule = null,Object? currentPayoutRecipient = freezed,Object? nextPayoutDate = freezed,Object? payoutOrder = null,}) {
  return _then(_StokvelSettingsModel(
payoutType: null == payoutType ? _self.payoutType : payoutType // ignore: cast_nullable_to_non_nullable
as String,payoutSchedule: null == payoutSchedule ? _self.payoutSchedule : payoutSchedule // ignore: cast_nullable_to_non_nullable
as String,currentPayoutRecipient: freezed == currentPayoutRecipient ? _self.currentPayoutRecipient : currentPayoutRecipient // ignore: cast_nullable_to_non_nullable
as String?,nextPayoutDate: freezed == nextPayoutDate ? _self.nextPayoutDate : nextPayoutDate // ignore: cast_nullable_to_non_nullable
as DateTime?,payoutOrder: null == payoutOrder ? _self._payoutOrder : payoutOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$GroupModel {

 String get id; String get type; String get name; String get description; String? get avatarUrl; String get ownerId; List<String> get memberIds; int get memberCount; int get totalBalance; String get status; GroupSettingsModel get settings; StokvelSettingsModel? get stokvelSettings;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupModelCopyWith<GroupModel> get copyWith => _$GroupModelCopyWithImpl<GroupModel>(this as GroupModel, _$identity);

  /// Serializes this GroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stokvelSettings, stokvelSettings) || other.stokvelSettings == stokvelSettings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,description,avatarUrl,ownerId,const DeepCollectionEquality().hash(memberIds),memberCount,totalBalance,status,settings,stokvelSettings,createdAt,updatedAt);

@override
String toString() {
  return 'GroupModel(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GroupModelCopyWith<$Res>  {
  factory $GroupModelCopyWith(GroupModel value, $Res Function(GroupModel) _then) = _$GroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String name, String description, String? avatarUrl, String ownerId, List<String> memberIds, int memberCount, int totalBalance, String status, GroupSettingsModel settings, StokvelSettingsModel? stokvelSettings,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});


$GroupSettingsModelCopyWith<$Res> get settings;$StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;

}
/// @nodoc
class _$GroupModelCopyWithImpl<$Res>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._self, this._then);

  final GroupModel _self;
  final $Res Function(GroupModel) _then;

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = null,Object? description = null,Object? avatarUrl = freezed,Object? ownerId = null,Object? memberIds = null,Object? memberCount = null,Object? totalBalance = null,Object? status = null,Object? settings = null,Object? stokvelSettings = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as GroupSettingsModel,stokvelSettings: freezed == stokvelSettings ? _self.stokvelSettings : stokvelSettings // ignore: cast_nullable_to_non_nullable
as StokvelSettingsModel?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupSettingsModelCopyWith<$Res> get settings {
  
  return $GroupSettingsModelCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StokvelSettingsModelCopyWith<$Res>? get stokvelSettings {
    if (_self.stokvelSettings == null) {
    return null;
  }

  return $StokvelSettingsModelCopyWith<$Res>(_self.stokvelSettings!, (value) {
    return _then(_self.copyWith(stokvelSettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupModel].
extension GroupModelPatterns on GroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String name,  String description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  int memberCount,  int totalBalance,  String status,  GroupSettingsModel settings,  StokvelSettingsModel? stokvelSettings, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String name,  String description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  int memberCount,  int totalBalance,  String status,  GroupSettingsModel settings,  StokvelSettingsModel? stokvelSettings, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupModel():
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String name,  String description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  int memberCount,  int totalBalance,  String status,  GroupSettingsModel settings,  StokvelSettingsModel? stokvelSettings, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupModel extends GroupModel {
  const _GroupModel({required this.id, required this.type, required this.name, required this.description, this.avatarUrl, required this.ownerId, required final  List<String> memberIds, required this.memberCount, required this.totalBalance, required this.status, required this.settings, this.stokvelSettings, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt}): _memberIds = memberIds,super._();
  factory _GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

@override final  String id;
@override final  String type;
@override final  String name;
@override final  String description;
@override final  String? avatarUrl;
@override final  String ownerId;
 final  List<String> _memberIds;
@override List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

@override final  int memberCount;
@override final  int totalBalance;
@override final  String status;
@override final  GroupSettingsModel settings;
@override final  StokvelSettingsModel? stokvelSettings;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupModelCopyWith<_GroupModel> get copyWith => __$GroupModelCopyWithImpl<_GroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stokvelSettings, stokvelSettings) || other.stokvelSettings == stokvelSettings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,description,avatarUrl,ownerId,const DeepCollectionEquality().hash(_memberIds),memberCount,totalBalance,status,settings,stokvelSettings,createdAt,updatedAt);

@override
String toString() {
  return 'GroupModel(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupModelCopyWith<$Res> implements $GroupModelCopyWith<$Res> {
  factory _$GroupModelCopyWith(_GroupModel value, $Res Function(_GroupModel) _then) = __$GroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String name, String description, String? avatarUrl, String ownerId, List<String> memberIds, int memberCount, int totalBalance, String status, GroupSettingsModel settings, StokvelSettingsModel? stokvelSettings,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});


@override $GroupSettingsModelCopyWith<$Res> get settings;@override $StokvelSettingsModelCopyWith<$Res>? get stokvelSettings;

}
/// @nodoc
class __$GroupModelCopyWithImpl<$Res>
    implements _$GroupModelCopyWith<$Res> {
  __$GroupModelCopyWithImpl(this._self, this._then);

  final _GroupModel _self;
  final $Res Function(_GroupModel) _then;

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? name = null,Object? description = null,Object? avatarUrl = freezed,Object? ownerId = null,Object? memberIds = null,Object? memberCount = null,Object? totalBalance = null,Object? status = null,Object? settings = null,Object? stokvelSettings = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_GroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as GroupSettingsModel,stokvelSettings: freezed == stokvelSettings ? _self.stokvelSettings : stokvelSettings // ignore: cast_nullable_to_non_nullable
as StokvelSettingsModel?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupSettingsModelCopyWith<$Res> get settings {
  
  return $GroupSettingsModelCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StokvelSettingsModelCopyWith<$Res>? get stokvelSettings {
    if (_self.stokvelSettings == null) {
    return null;
  }

  return $StokvelSettingsModelCopyWith<$Res>(_self.stokvelSettings!, (value) {
    return _then(_self.copyWith(stokvelSettings: value));
  });
}
}

// dart format on
