// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupSettings {

 int get requireApprovalAbove; bool get allowMemberWithdrawals; ContributionCycle get contributionCycle; int get contributionAmount; int get penaltyPercentage;
/// Create a copy of GroupSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupSettingsCopyWith<GroupSettings> get copyWith => _$GroupSettingsCopyWithImpl<GroupSettings>(this as GroupSettings, _$identity);

  /// Serializes this GroupSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupSettings&&(identical(other.requireApprovalAbove, requireApprovalAbove) || other.requireApprovalAbove == requireApprovalAbove)&&(identical(other.allowMemberWithdrawals, allowMemberWithdrawals) || other.allowMemberWithdrawals == allowMemberWithdrawals)&&(identical(other.contributionCycle, contributionCycle) || other.contributionCycle == contributionCycle)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.penaltyPercentage, penaltyPercentage) || other.penaltyPercentage == penaltyPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requireApprovalAbove,allowMemberWithdrawals,contributionCycle,contributionAmount,penaltyPercentage);

@override
String toString() {
  return 'GroupSettings(requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
}


}

/// @nodoc
abstract mixin class $GroupSettingsCopyWith<$Res>  {
  factory $GroupSettingsCopyWith(GroupSettings value, $Res Function(GroupSettings) _then) = _$GroupSettingsCopyWithImpl;
@useResult
$Res call({
 int requireApprovalAbove, bool allowMemberWithdrawals, ContributionCycle contributionCycle, int contributionAmount, int penaltyPercentage
});




}
/// @nodoc
class _$GroupSettingsCopyWithImpl<$Res>
    implements $GroupSettingsCopyWith<$Res> {
  _$GroupSettingsCopyWithImpl(this._self, this._then);

  final GroupSettings _self;
  final $Res Function(GroupSettings) _then;

/// Create a copy of GroupSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requireApprovalAbove = null,Object? allowMemberWithdrawals = null,Object? contributionCycle = null,Object? contributionAmount = null,Object? penaltyPercentage = null,}) {
  return _then(_self.copyWith(
requireApprovalAbove: null == requireApprovalAbove ? _self.requireApprovalAbove : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
as int,allowMemberWithdrawals: null == allowMemberWithdrawals ? _self.allowMemberWithdrawals : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
as bool,contributionCycle: null == contributionCycle ? _self.contributionCycle : contributionCycle // ignore: cast_nullable_to_non_nullable
as ContributionCycle,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,penaltyPercentage: null == penaltyPercentage ? _self.penaltyPercentage : penaltyPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupSettings].
extension GroupSettingsPatterns on GroupSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupSettings value)  $default,){
final _that = this;
switch (_that) {
case _GroupSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupSettings value)?  $default,){
final _that = this;
switch (_that) {
case _GroupSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int requireApprovalAbove,  bool allowMemberWithdrawals,  ContributionCycle contributionCycle,  int contributionAmount,  int penaltyPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int requireApprovalAbove,  bool allowMemberWithdrawals,  ContributionCycle contributionCycle,  int contributionAmount,  int penaltyPercentage)  $default,) {final _that = this;
switch (_that) {
case _GroupSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int requireApprovalAbove,  bool allowMemberWithdrawals,  ContributionCycle contributionCycle,  int contributionAmount,  int penaltyPercentage)?  $default,) {final _that = this;
switch (_that) {
case _GroupSettings() when $default != null:
return $default(_that.requireApprovalAbove,_that.allowMemberWithdrawals,_that.contributionCycle,_that.contributionAmount,_that.penaltyPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupSettings extends GroupSettings {
  const _GroupSettings({required this.requireApprovalAbove, required this.allowMemberWithdrawals, required this.contributionCycle, required this.contributionAmount, required this.penaltyPercentage}): super._();
  factory _GroupSettings.fromJson(Map<String, dynamic> json) => _$GroupSettingsFromJson(json);

@override final  int requireApprovalAbove;
@override final  bool allowMemberWithdrawals;
@override final  ContributionCycle contributionCycle;
@override final  int contributionAmount;
@override final  int penaltyPercentage;

/// Create a copy of GroupSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupSettingsCopyWith<_GroupSettings> get copyWith => __$GroupSettingsCopyWithImpl<_GroupSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupSettings&&(identical(other.requireApprovalAbove, requireApprovalAbove) || other.requireApprovalAbove == requireApprovalAbove)&&(identical(other.allowMemberWithdrawals, allowMemberWithdrawals) || other.allowMemberWithdrawals == allowMemberWithdrawals)&&(identical(other.contributionCycle, contributionCycle) || other.contributionCycle == contributionCycle)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.penaltyPercentage, penaltyPercentage) || other.penaltyPercentage == penaltyPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requireApprovalAbove,allowMemberWithdrawals,contributionCycle,contributionAmount,penaltyPercentage);

@override
String toString() {
  return 'GroupSettings(requireApprovalAbove: $requireApprovalAbove, allowMemberWithdrawals: $allowMemberWithdrawals, contributionCycle: $contributionCycle, contributionAmount: $contributionAmount, penaltyPercentage: $penaltyPercentage)';
}


}

/// @nodoc
abstract mixin class _$GroupSettingsCopyWith<$Res> implements $GroupSettingsCopyWith<$Res> {
  factory _$GroupSettingsCopyWith(_GroupSettings value, $Res Function(_GroupSettings) _then) = __$GroupSettingsCopyWithImpl;
@override @useResult
$Res call({
 int requireApprovalAbove, bool allowMemberWithdrawals, ContributionCycle contributionCycle, int contributionAmount, int penaltyPercentage
});




}
/// @nodoc
class __$GroupSettingsCopyWithImpl<$Res>
    implements _$GroupSettingsCopyWith<$Res> {
  __$GroupSettingsCopyWithImpl(this._self, this._then);

  final _GroupSettings _self;
  final $Res Function(_GroupSettings) _then;

/// Create a copy of GroupSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requireApprovalAbove = null,Object? allowMemberWithdrawals = null,Object? contributionCycle = null,Object? contributionAmount = null,Object? penaltyPercentage = null,}) {
  return _then(_GroupSettings(
requireApprovalAbove: null == requireApprovalAbove ? _self.requireApprovalAbove : requireApprovalAbove // ignore: cast_nullable_to_non_nullable
as int,allowMemberWithdrawals: null == allowMemberWithdrawals ? _self.allowMemberWithdrawals : allowMemberWithdrawals // ignore: cast_nullable_to_non_nullable
as bool,contributionCycle: null == contributionCycle ? _self.contributionCycle : contributionCycle // ignore: cast_nullable_to_non_nullable
as ContributionCycle,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,penaltyPercentage: null == penaltyPercentage ? _self.penaltyPercentage : penaltyPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StokvelSettings {

 PayoutType get payoutType; String get payoutSchedule; String? get currentPayoutRecipient; DateTime? get nextPayoutDate; List<String> get payoutOrder;
/// Create a copy of StokvelSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StokvelSettingsCopyWith<StokvelSettings> get copyWith => _$StokvelSettingsCopyWithImpl<StokvelSettings>(this as StokvelSettings, _$identity);

  /// Serializes this StokvelSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StokvelSettings&&(identical(other.payoutType, payoutType) || other.payoutType == payoutType)&&(identical(other.payoutSchedule, payoutSchedule) || other.payoutSchedule == payoutSchedule)&&(identical(other.currentPayoutRecipient, currentPayoutRecipient) || other.currentPayoutRecipient == currentPayoutRecipient)&&(identical(other.nextPayoutDate, nextPayoutDate) || other.nextPayoutDate == nextPayoutDate)&&const DeepCollectionEquality().equals(other.payoutOrder, payoutOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payoutType,payoutSchedule,currentPayoutRecipient,nextPayoutDate,const DeepCollectionEquality().hash(payoutOrder));

@override
String toString() {
  return 'StokvelSettings(payoutType: $payoutType, payoutSchedule: $payoutSchedule, currentPayoutRecipient: $currentPayoutRecipient, nextPayoutDate: $nextPayoutDate, payoutOrder: $payoutOrder)';
}


}

/// @nodoc
abstract mixin class $StokvelSettingsCopyWith<$Res>  {
  factory $StokvelSettingsCopyWith(StokvelSettings value, $Res Function(StokvelSettings) _then) = _$StokvelSettingsCopyWithImpl;
@useResult
$Res call({
 PayoutType payoutType, String payoutSchedule, String? currentPayoutRecipient, DateTime? nextPayoutDate, List<String> payoutOrder
});




}
/// @nodoc
class _$StokvelSettingsCopyWithImpl<$Res>
    implements $StokvelSettingsCopyWith<$Res> {
  _$StokvelSettingsCopyWithImpl(this._self, this._then);

  final StokvelSettings _self;
  final $Res Function(StokvelSettings) _then;

/// Create a copy of StokvelSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payoutType = null,Object? payoutSchedule = null,Object? currentPayoutRecipient = freezed,Object? nextPayoutDate = freezed,Object? payoutOrder = null,}) {
  return _then(_self.copyWith(
payoutType: null == payoutType ? _self.payoutType : payoutType // ignore: cast_nullable_to_non_nullable
as PayoutType,payoutSchedule: null == payoutSchedule ? _self.payoutSchedule : payoutSchedule // ignore: cast_nullable_to_non_nullable
as String,currentPayoutRecipient: freezed == currentPayoutRecipient ? _self.currentPayoutRecipient : currentPayoutRecipient // ignore: cast_nullable_to_non_nullable
as String?,nextPayoutDate: freezed == nextPayoutDate ? _self.nextPayoutDate : nextPayoutDate // ignore: cast_nullable_to_non_nullable
as DateTime?,payoutOrder: null == payoutOrder ? _self.payoutOrder : payoutOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StokvelSettings].
extension StokvelSettingsPatterns on StokvelSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StokvelSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StokvelSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StokvelSettings value)  $default,){
final _that = this;
switch (_that) {
case _StokvelSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StokvelSettings value)?  $default,){
final _that = this;
switch (_that) {
case _StokvelSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PayoutType payoutType,  String payoutSchedule,  String? currentPayoutRecipient,  DateTime? nextPayoutDate,  List<String> payoutOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StokvelSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PayoutType payoutType,  String payoutSchedule,  String? currentPayoutRecipient,  DateTime? nextPayoutDate,  List<String> payoutOrder)  $default,) {final _that = this;
switch (_that) {
case _StokvelSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PayoutType payoutType,  String payoutSchedule,  String? currentPayoutRecipient,  DateTime? nextPayoutDate,  List<String> payoutOrder)?  $default,) {final _that = this;
switch (_that) {
case _StokvelSettings() when $default != null:
return $default(_that.payoutType,_that.payoutSchedule,_that.currentPayoutRecipient,_that.nextPayoutDate,_that.payoutOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StokvelSettings extends StokvelSettings {
  const _StokvelSettings({required this.payoutType, required this.payoutSchedule, this.currentPayoutRecipient, this.nextPayoutDate, required final  List<String> payoutOrder}): _payoutOrder = payoutOrder,super._();
  factory _StokvelSettings.fromJson(Map<String, dynamic> json) => _$StokvelSettingsFromJson(json);

@override final  PayoutType payoutType;
@override final  String payoutSchedule;
@override final  String? currentPayoutRecipient;
@override final  DateTime? nextPayoutDate;
 final  List<String> _payoutOrder;
@override List<String> get payoutOrder {
  if (_payoutOrder is EqualUnmodifiableListView) return _payoutOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payoutOrder);
}


/// Create a copy of StokvelSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StokvelSettingsCopyWith<_StokvelSettings> get copyWith => __$StokvelSettingsCopyWithImpl<_StokvelSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StokvelSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StokvelSettings&&(identical(other.payoutType, payoutType) || other.payoutType == payoutType)&&(identical(other.payoutSchedule, payoutSchedule) || other.payoutSchedule == payoutSchedule)&&(identical(other.currentPayoutRecipient, currentPayoutRecipient) || other.currentPayoutRecipient == currentPayoutRecipient)&&(identical(other.nextPayoutDate, nextPayoutDate) || other.nextPayoutDate == nextPayoutDate)&&const DeepCollectionEquality().equals(other._payoutOrder, _payoutOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payoutType,payoutSchedule,currentPayoutRecipient,nextPayoutDate,const DeepCollectionEquality().hash(_payoutOrder));

@override
String toString() {
  return 'StokvelSettings(payoutType: $payoutType, payoutSchedule: $payoutSchedule, currentPayoutRecipient: $currentPayoutRecipient, nextPayoutDate: $nextPayoutDate, payoutOrder: $payoutOrder)';
}


}

/// @nodoc
abstract mixin class _$StokvelSettingsCopyWith<$Res> implements $StokvelSettingsCopyWith<$Res> {
  factory _$StokvelSettingsCopyWith(_StokvelSettings value, $Res Function(_StokvelSettings) _then) = __$StokvelSettingsCopyWithImpl;
@override @useResult
$Res call({
 PayoutType payoutType, String payoutSchedule, String? currentPayoutRecipient, DateTime? nextPayoutDate, List<String> payoutOrder
});




}
/// @nodoc
class __$StokvelSettingsCopyWithImpl<$Res>
    implements _$StokvelSettingsCopyWith<$Res> {
  __$StokvelSettingsCopyWithImpl(this._self, this._then);

  final _StokvelSettings _self;
  final $Res Function(_StokvelSettings) _then;

/// Create a copy of StokvelSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payoutType = null,Object? payoutSchedule = null,Object? currentPayoutRecipient = freezed,Object? nextPayoutDate = freezed,Object? payoutOrder = null,}) {
  return _then(_StokvelSettings(
payoutType: null == payoutType ? _self.payoutType : payoutType // ignore: cast_nullable_to_non_nullable
as PayoutType,payoutSchedule: null == payoutSchedule ? _self.payoutSchedule : payoutSchedule // ignore: cast_nullable_to_non_nullable
as String,currentPayoutRecipient: freezed == currentPayoutRecipient ? _self.currentPayoutRecipient : currentPayoutRecipient // ignore: cast_nullable_to_non_nullable
as String?,nextPayoutDate: freezed == nextPayoutDate ? _self.nextPayoutDate : nextPayoutDate // ignore: cast_nullable_to_non_nullable
as DateTime?,payoutOrder: null == payoutOrder ? _self._payoutOrder : payoutOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$Group {

 String get id; GroupType get type; String get name; String get description; String? get avatarUrl; String get ownerId; List<String> get memberIds; int get memberCount; int get totalBalance; GroupStatus get status; GroupSettings get settings; StokvelSettings? get stokvelSettings; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this as Group, _$identity);

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stokvelSettings, stokvelSettings) || other.stokvelSettings == stokvelSettings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,description,avatarUrl,ownerId,const DeepCollectionEquality().hash(memberIds),memberCount,totalBalance,status,settings,stokvelSettings,createdAt,updatedAt);

@override
String toString() {
  return 'Group(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res>  {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@useResult
$Res call({
 String id, GroupType type, String name, String description, String? avatarUrl, String ownerId, List<String> memberIds, int memberCount, int totalBalance, GroupStatus status, GroupSettings settings, StokvelSettings? stokvelSettings, DateTime createdAt, DateTime updatedAt
});


$GroupSettingsCopyWith<$Res> get settings;$StokvelSettingsCopyWith<$Res>? get stokvelSettings;

}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = null,Object? description = null,Object? avatarUrl = freezed,Object? ownerId = null,Object? memberIds = null,Object? memberCount = null,Object? totalBalance = null,Object? status = null,Object? settings = null,Object? stokvelSettings = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GroupType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupStatus,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as GroupSettings,stokvelSettings: freezed == stokvelSettings ? _self.stokvelSettings : stokvelSettings // ignore: cast_nullable_to_non_nullable
as StokvelSettings?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupSettingsCopyWith<$Res> get settings {
  
  return $GroupSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StokvelSettingsCopyWith<$Res>? get stokvelSettings {
    if (_self.stokvelSettings == null) {
    return null;
  }

  return $StokvelSettingsCopyWith<$Res>(_self.stokvelSettings!, (value) {
    return _then(_self.copyWith(stokvelSettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [Group].
extension GroupPatterns on Group {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Group value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Group value)  $default,){
final _that = this;
switch (_that) {
case _Group():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Group value)?  $default,){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  GroupType type,  String name,  String description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  int memberCount,  int totalBalance,  GroupStatus status,  GroupSettings settings,  StokvelSettings? stokvelSettings,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  GroupType type,  String name,  String description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  int memberCount,  int totalBalance,  GroupStatus status,  GroupSettings settings,  StokvelSettings? stokvelSettings,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Group():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  GroupType type,  String name,  String description,  String? avatarUrl,  String ownerId,  List<String> memberIds,  int memberCount,  int totalBalance,  GroupStatus status,  GroupSettings settings,  StokvelSettings? stokvelSettings,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.description,_that.avatarUrl,_that.ownerId,_that.memberIds,_that.memberCount,_that.totalBalance,_that.status,_that.settings,_that.stokvelSettings,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Group extends Group {
  const _Group({required this.id, required this.type, required this.name, required this.description, this.avatarUrl, required this.ownerId, required final  List<String> memberIds, required this.memberCount, required this.totalBalance, required this.status, required this.settings, this.stokvelSettings, required this.createdAt, required this.updatedAt}): _memberIds = memberIds,super._();
  factory _Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

@override final  String id;
@override final  GroupType type;
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
@override final  GroupStatus status;
@override final  GroupSettings settings;
@override final  StokvelSettings? stokvelSettings;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupCopyWith<_Group> get copyWith => __$GroupCopyWithImpl<_Group>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Group&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stokvelSettings, stokvelSettings) || other.stokvelSettings == stokvelSettings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,description,avatarUrl,ownerId,const DeepCollectionEquality().hash(_memberIds),memberCount,totalBalance,status,settings,stokvelSettings,createdAt,updatedAt);

@override
String toString() {
  return 'Group(id: $id, type: $type, name: $name, description: $description, avatarUrl: $avatarUrl, ownerId: $ownerId, memberIds: $memberIds, memberCount: $memberCount, totalBalance: $totalBalance, status: $status, settings: $settings, stokvelSettings: $stokvelSettings, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) = __$GroupCopyWithImpl;
@override @useResult
$Res call({
 String id, GroupType type, String name, String description, String? avatarUrl, String ownerId, List<String> memberIds, int memberCount, int totalBalance, GroupStatus status, GroupSettings settings, StokvelSettings? stokvelSettings, DateTime createdAt, DateTime updatedAt
});


@override $GroupSettingsCopyWith<$Res> get settings;@override $StokvelSettingsCopyWith<$Res>? get stokvelSettings;

}
/// @nodoc
class __$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? name = null,Object? description = null,Object? avatarUrl = freezed,Object? ownerId = null,Object? memberIds = null,Object? memberCount = null,Object? totalBalance = null,Object? status = null,Object? settings = null,Object? stokvelSettings = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Group(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GroupType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupStatus,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as GroupSettings,stokvelSettings: freezed == stokvelSettings ? _self.stokvelSettings : stokvelSettings // ignore: cast_nullable_to_non_nullable
as StokvelSettings?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupSettingsCopyWith<$Res> get settings {
  
  return $GroupSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StokvelSettingsCopyWith<$Res>? get stokvelSettings {
    if (_self.stokvelSettings == null) {
    return null;
  }

  return $StokvelSettingsCopyWith<$Res>(_self.stokvelSettings!, (value) {
    return _then(_self.copyWith(stokvelSettings: value));
  });
}
}

// dart format on
