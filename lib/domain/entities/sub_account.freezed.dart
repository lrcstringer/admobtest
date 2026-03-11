// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sub_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubAccount {

 String get id; String get userId;/// null = unrestricted default account
 String? get accountTypeId; String get name; int get balance; int get lifetimeCredits; int get lifetimeDebits; bool get isActive; bool get isDefault; DateTime get createdAt; DateTime get updatedAt;// Rule flags (populated by getSubAccounts Cloud Function)
 bool get allowP2pSend; bool get allowP2pReceive; bool get allowCashout; bool get p2pRestrictToSameAccountType; List<String> get allowedOfframps;// Expiry fields (populated by getSubAccounts Cloud Function)
 int? get expiryDays; DateTime? get lastCreditAt;
/// Create a copy of SubAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubAccountCopyWith<SubAccount> get copyWith => _$SubAccountCopyWithImpl<SubAccount>(this as SubAccount, _$identity);

  /// Serializes this SubAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountTypeId, accountTypeId) || other.accountTypeId == accountTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.lifetimeCredits, lifetimeCredits) || other.lifetimeCredits == lifetimeCredits)&&(identical(other.lifetimeDebits, lifetimeDebits) || other.lifetimeDebits == lifetimeDebits)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.allowP2pSend, allowP2pSend) || other.allowP2pSend == allowP2pSend)&&(identical(other.allowP2pReceive, allowP2pReceive) || other.allowP2pReceive == allowP2pReceive)&&(identical(other.allowCashout, allowCashout) || other.allowCashout == allowCashout)&&(identical(other.p2pRestrictToSameAccountType, p2pRestrictToSameAccountType) || other.p2pRestrictToSameAccountType == p2pRestrictToSameAccountType)&&const DeepCollectionEquality().equals(other.allowedOfframps, allowedOfframps)&&(identical(other.expiryDays, expiryDays) || other.expiryDays == expiryDays)&&(identical(other.lastCreditAt, lastCreditAt) || other.lastCreditAt == lastCreditAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountTypeId,name,balance,lifetimeCredits,lifetimeDebits,isActive,isDefault,createdAt,updatedAt,allowP2pSend,allowP2pReceive,allowCashout,p2pRestrictToSameAccountType,const DeepCollectionEquality().hash(allowedOfframps),expiryDays,lastCreditAt);

@override
String toString() {
  return 'SubAccount(id: $id, userId: $userId, accountTypeId: $accountTypeId, name: $name, balance: $balance, lifetimeCredits: $lifetimeCredits, lifetimeDebits: $lifetimeDebits, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt, allowP2pSend: $allowP2pSend, allowP2pReceive: $allowP2pReceive, allowCashout: $allowCashout, p2pRestrictToSameAccountType: $p2pRestrictToSameAccountType, allowedOfframps: $allowedOfframps, expiryDays: $expiryDays, lastCreditAt: $lastCreditAt)';
}


}

/// @nodoc
abstract mixin class $SubAccountCopyWith<$Res>  {
  factory $SubAccountCopyWith(SubAccount value, $Res Function(SubAccount) _then) = _$SubAccountCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String? accountTypeId, String name, int balance, int lifetimeCredits, int lifetimeDebits, bool isActive, bool isDefault, DateTime createdAt, DateTime updatedAt, bool allowP2pSend, bool allowP2pReceive, bool allowCashout, bool p2pRestrictToSameAccountType, List<String> allowedOfframps, int? expiryDays, DateTime? lastCreditAt
});




}
/// @nodoc
class _$SubAccountCopyWithImpl<$Res>
    implements $SubAccountCopyWith<$Res> {
  _$SubAccountCopyWithImpl(this._self, this._then);

  final SubAccount _self;
  final $Res Function(SubAccount) _then;

/// Create a copy of SubAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? accountTypeId = freezed,Object? name = null,Object? balance = null,Object? lifetimeCredits = null,Object? lifetimeDebits = null,Object? isActive = null,Object? isDefault = null,Object? createdAt = null,Object? updatedAt = null,Object? allowP2pSend = null,Object? allowP2pReceive = null,Object? allowCashout = null,Object? p2pRestrictToSameAccountType = null,Object? allowedOfframps = null,Object? expiryDays = freezed,Object? lastCreditAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountTypeId: freezed == accountTypeId ? _self.accountTypeId : accountTypeId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,lifetimeCredits: null == lifetimeCredits ? _self.lifetimeCredits : lifetimeCredits // ignore: cast_nullable_to_non_nullable
as int,lifetimeDebits: null == lifetimeDebits ? _self.lifetimeDebits : lifetimeDebits // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,allowP2pSend: null == allowP2pSend ? _self.allowP2pSend : allowP2pSend // ignore: cast_nullable_to_non_nullable
as bool,allowP2pReceive: null == allowP2pReceive ? _self.allowP2pReceive : allowP2pReceive // ignore: cast_nullable_to_non_nullable
as bool,allowCashout: null == allowCashout ? _self.allowCashout : allowCashout // ignore: cast_nullable_to_non_nullable
as bool,p2pRestrictToSameAccountType: null == p2pRestrictToSameAccountType ? _self.p2pRestrictToSameAccountType : p2pRestrictToSameAccountType // ignore: cast_nullable_to_non_nullable
as bool,allowedOfframps: null == allowedOfframps ? _self.allowedOfframps : allowedOfframps // ignore: cast_nullable_to_non_nullable
as List<String>,expiryDays: freezed == expiryDays ? _self.expiryDays : expiryDays // ignore: cast_nullable_to_non_nullable
as int?,lastCreditAt: freezed == lastCreditAt ? _self.lastCreditAt : lastCreditAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubAccount].
extension SubAccountPatterns on SubAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubAccount value)  $default,){
final _that = this;
switch (_that) {
case _SubAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubAccount value)?  $default,){
final _that = this;
switch (_that) {
case _SubAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String? accountTypeId,  String name,  int balance,  int lifetimeCredits,  int lifetimeDebits,  bool isActive,  bool isDefault,  DateTime createdAt,  DateTime updatedAt,  bool allowP2pSend,  bool allowP2pReceive,  bool allowCashout,  bool p2pRestrictToSameAccountType,  List<String> allowedOfframps,  int? expiryDays,  DateTime? lastCreditAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubAccount() when $default != null:
return $default(_that.id,_that.userId,_that.accountTypeId,_that.name,_that.balance,_that.lifetimeCredits,_that.lifetimeDebits,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt,_that.allowP2pSend,_that.allowP2pReceive,_that.allowCashout,_that.p2pRestrictToSameAccountType,_that.allowedOfframps,_that.expiryDays,_that.lastCreditAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String? accountTypeId,  String name,  int balance,  int lifetimeCredits,  int lifetimeDebits,  bool isActive,  bool isDefault,  DateTime createdAt,  DateTime updatedAt,  bool allowP2pSend,  bool allowP2pReceive,  bool allowCashout,  bool p2pRestrictToSameAccountType,  List<String> allowedOfframps,  int? expiryDays,  DateTime? lastCreditAt)  $default,) {final _that = this;
switch (_that) {
case _SubAccount():
return $default(_that.id,_that.userId,_that.accountTypeId,_that.name,_that.balance,_that.lifetimeCredits,_that.lifetimeDebits,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt,_that.allowP2pSend,_that.allowP2pReceive,_that.allowCashout,_that.p2pRestrictToSameAccountType,_that.allowedOfframps,_that.expiryDays,_that.lastCreditAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String? accountTypeId,  String name,  int balance,  int lifetimeCredits,  int lifetimeDebits,  bool isActive,  bool isDefault,  DateTime createdAt,  DateTime updatedAt,  bool allowP2pSend,  bool allowP2pReceive,  bool allowCashout,  bool p2pRestrictToSameAccountType,  List<String> allowedOfframps,  int? expiryDays,  DateTime? lastCreditAt)?  $default,) {final _that = this;
switch (_that) {
case _SubAccount() when $default != null:
return $default(_that.id,_that.userId,_that.accountTypeId,_that.name,_that.balance,_that.lifetimeCredits,_that.lifetimeDebits,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt,_that.allowP2pSend,_that.allowP2pReceive,_that.allowCashout,_that.p2pRestrictToSameAccountType,_that.allowedOfframps,_that.expiryDays,_that.lastCreditAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubAccount extends SubAccount {
  const _SubAccount({required this.id, required this.userId, this.accountTypeId, required this.name, required this.balance, required this.lifetimeCredits, required this.lifetimeDebits, required this.isActive, required this.isDefault, required this.createdAt, required this.updatedAt, this.allowP2pSend = true, this.allowP2pReceive = true, this.allowCashout = true, this.p2pRestrictToSameAccountType = false, final  List<String> allowedOfframps = const ["*"], this.expiryDays, this.lastCreditAt}): _allowedOfframps = allowedOfframps,super._();
  factory _SubAccount.fromJson(Map<String, dynamic> json) => _$SubAccountFromJson(json);

@override final  String id;
@override final  String userId;
/// null = unrestricted default account
@override final  String? accountTypeId;
@override final  String name;
@override final  int balance;
@override final  int lifetimeCredits;
@override final  int lifetimeDebits;
@override final  bool isActive;
@override final  bool isDefault;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
// Rule flags (populated by getSubAccounts Cloud Function)
@override@JsonKey() final  bool allowP2pSend;
@override@JsonKey() final  bool allowP2pReceive;
@override@JsonKey() final  bool allowCashout;
@override@JsonKey() final  bool p2pRestrictToSameAccountType;
 final  List<String> _allowedOfframps;
@override@JsonKey() List<String> get allowedOfframps {
  if (_allowedOfframps is EqualUnmodifiableListView) return _allowedOfframps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedOfframps);
}

// Expiry fields (populated by getSubAccounts Cloud Function)
@override final  int? expiryDays;
@override final  DateTime? lastCreditAt;

/// Create a copy of SubAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubAccountCopyWith<_SubAccount> get copyWith => __$SubAccountCopyWithImpl<_SubAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountTypeId, accountTypeId) || other.accountTypeId == accountTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.lifetimeCredits, lifetimeCredits) || other.lifetimeCredits == lifetimeCredits)&&(identical(other.lifetimeDebits, lifetimeDebits) || other.lifetimeDebits == lifetimeDebits)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.allowP2pSend, allowP2pSend) || other.allowP2pSend == allowP2pSend)&&(identical(other.allowP2pReceive, allowP2pReceive) || other.allowP2pReceive == allowP2pReceive)&&(identical(other.allowCashout, allowCashout) || other.allowCashout == allowCashout)&&(identical(other.p2pRestrictToSameAccountType, p2pRestrictToSameAccountType) || other.p2pRestrictToSameAccountType == p2pRestrictToSameAccountType)&&const DeepCollectionEquality().equals(other._allowedOfframps, _allowedOfframps)&&(identical(other.expiryDays, expiryDays) || other.expiryDays == expiryDays)&&(identical(other.lastCreditAt, lastCreditAt) || other.lastCreditAt == lastCreditAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountTypeId,name,balance,lifetimeCredits,lifetimeDebits,isActive,isDefault,createdAt,updatedAt,allowP2pSend,allowP2pReceive,allowCashout,p2pRestrictToSameAccountType,const DeepCollectionEquality().hash(_allowedOfframps),expiryDays,lastCreditAt);

@override
String toString() {
  return 'SubAccount(id: $id, userId: $userId, accountTypeId: $accountTypeId, name: $name, balance: $balance, lifetimeCredits: $lifetimeCredits, lifetimeDebits: $lifetimeDebits, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt, allowP2pSend: $allowP2pSend, allowP2pReceive: $allowP2pReceive, allowCashout: $allowCashout, p2pRestrictToSameAccountType: $p2pRestrictToSameAccountType, allowedOfframps: $allowedOfframps, expiryDays: $expiryDays, lastCreditAt: $lastCreditAt)';
}


}

/// @nodoc
abstract mixin class _$SubAccountCopyWith<$Res> implements $SubAccountCopyWith<$Res> {
  factory _$SubAccountCopyWith(_SubAccount value, $Res Function(_SubAccount) _then) = __$SubAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String? accountTypeId, String name, int balance, int lifetimeCredits, int lifetimeDebits, bool isActive, bool isDefault, DateTime createdAt, DateTime updatedAt, bool allowP2pSend, bool allowP2pReceive, bool allowCashout, bool p2pRestrictToSameAccountType, List<String> allowedOfframps, int? expiryDays, DateTime? lastCreditAt
});




}
/// @nodoc
class __$SubAccountCopyWithImpl<$Res>
    implements _$SubAccountCopyWith<$Res> {
  __$SubAccountCopyWithImpl(this._self, this._then);

  final _SubAccount _self;
  final $Res Function(_SubAccount) _then;

/// Create a copy of SubAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accountTypeId = freezed,Object? name = null,Object? balance = null,Object? lifetimeCredits = null,Object? lifetimeDebits = null,Object? isActive = null,Object? isDefault = null,Object? createdAt = null,Object? updatedAt = null,Object? allowP2pSend = null,Object? allowP2pReceive = null,Object? allowCashout = null,Object? p2pRestrictToSameAccountType = null,Object? allowedOfframps = null,Object? expiryDays = freezed,Object? lastCreditAt = freezed,}) {
  return _then(_SubAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountTypeId: freezed == accountTypeId ? _self.accountTypeId : accountTypeId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,lifetimeCredits: null == lifetimeCredits ? _self.lifetimeCredits : lifetimeCredits // ignore: cast_nullable_to_non_nullable
as int,lifetimeDebits: null == lifetimeDebits ? _self.lifetimeDebits : lifetimeDebits // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,allowP2pSend: null == allowP2pSend ? _self.allowP2pSend : allowP2pSend // ignore: cast_nullable_to_non_nullable
as bool,allowP2pReceive: null == allowP2pReceive ? _self.allowP2pReceive : allowP2pReceive // ignore: cast_nullable_to_non_nullable
as bool,allowCashout: null == allowCashout ? _self.allowCashout : allowCashout // ignore: cast_nullable_to_non_nullable
as bool,p2pRestrictToSameAccountType: null == p2pRestrictToSameAccountType ? _self.p2pRestrictToSameAccountType : p2pRestrictToSameAccountType // ignore: cast_nullable_to_non_nullable
as bool,allowedOfframps: null == allowedOfframps ? _self._allowedOfframps : allowedOfframps // ignore: cast_nullable_to_non_nullable
as List<String>,expiryDays: freezed == expiryDays ? _self.expiryDays : expiryDays // ignore: cast_nullable_to_non_nullable
as int?,lastCreditAt: freezed == lastCreditAt ? _self.lastCreditAt : lastCreditAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
