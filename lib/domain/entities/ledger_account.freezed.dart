// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LedgerAccount {

 String get id; LedgerAccountType get type; String get name; String? get ownerId; int get balance; int get allocatedBalance; String get currency; LedgerAccountStatus get status; Map<String, dynamic> get metadata; DateTime get createdAt; DateTime get updatedAt; int get version;
/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<LedgerAccount> get copyWith => _$LedgerAccountCopyWithImpl<LedgerAccount>(this as LedgerAccount, _$identity);

  /// Serializes this LedgerAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.allocatedBalance, allocatedBalance) || other.allocatedBalance == allocatedBalance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,ownerId,balance,allocatedBalance,currency,status,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt,version);

@override
String toString() {
  return 'LedgerAccount(id: $id, type: $type, name: $name, ownerId: $ownerId, balance: $balance, allocatedBalance: $allocatedBalance, currency: $currency, status: $status, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $LedgerAccountCopyWith<$Res>  {
  factory $LedgerAccountCopyWith(LedgerAccount value, $Res Function(LedgerAccount) _then) = _$LedgerAccountCopyWithImpl;
@useResult
$Res call({
 String id, LedgerAccountType type, String name, String? ownerId, int balance, int allocatedBalance, String currency, LedgerAccountStatus status, Map<String, dynamic> metadata, DateTime createdAt, DateTime updatedAt, int version
});




}
/// @nodoc
class _$LedgerAccountCopyWithImpl<$Res>
    implements $LedgerAccountCopyWith<$Res> {
  _$LedgerAccountCopyWithImpl(this._self, this._then);

  final LedgerAccount _self;
  final $Res Function(LedgerAccount) _then;

/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = null,Object? ownerId = freezed,Object? balance = null,Object? allocatedBalance = null,Object? currency = null,Object? status = null,Object? metadata = null,Object? createdAt = null,Object? updatedAt = null,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerAccountType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,allocatedBalance: null == allocatedBalance ? _self.allocatedBalance : allocatedBalance // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LedgerAccountStatus,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerAccount].
extension LedgerAccountPatterns on LedgerAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerAccount value)  $default,){
final _that = this;
switch (_that) {
case _LedgerAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerAccount value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LedgerAccountType type,  String name,  String? ownerId,  int balance,  int allocatedBalance,  String currency,  LedgerAccountStatus status,  Map<String, dynamic> metadata,  DateTime createdAt,  DateTime updatedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.ownerId,_that.balance,_that.allocatedBalance,_that.currency,_that.status,_that.metadata,_that.createdAt,_that.updatedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LedgerAccountType type,  String name,  String? ownerId,  int balance,  int allocatedBalance,  String currency,  LedgerAccountStatus status,  Map<String, dynamic> metadata,  DateTime createdAt,  DateTime updatedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _LedgerAccount():
return $default(_that.id,_that.type,_that.name,_that.ownerId,_that.balance,_that.allocatedBalance,_that.currency,_that.status,_that.metadata,_that.createdAt,_that.updatedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LedgerAccountType type,  String name,  String? ownerId,  int balance,  int allocatedBalance,  String currency,  LedgerAccountStatus status,  Map<String, dynamic> metadata,  DateTime createdAt,  DateTime updatedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.ownerId,_that.balance,_that.allocatedBalance,_that.currency,_that.status,_that.metadata,_that.createdAt,_that.updatedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LedgerAccount extends LedgerAccount {
  const _LedgerAccount({required this.id, required this.type, required this.name, this.ownerId, required this.balance, this.allocatedBalance = 0, this.currency = 'TOKEN', required this.status, final  Map<String, dynamic> metadata = const {}, required this.createdAt, required this.updatedAt, this.version = 1}): _metadata = metadata,super._();
  factory _LedgerAccount.fromJson(Map<String, dynamic> json) => _$LedgerAccountFromJson(json);

@override final  String id;
@override final  LedgerAccountType type;
@override final  String name;
@override final  String? ownerId;
@override final  int balance;
@override@JsonKey() final  int allocatedBalance;
@override@JsonKey() final  String currency;
@override final  LedgerAccountStatus status;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int version;

/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerAccountCopyWith<_LedgerAccount> get copyWith => __$LedgerAccountCopyWithImpl<_LedgerAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LedgerAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.allocatedBalance, allocatedBalance) || other.allocatedBalance == allocatedBalance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,ownerId,balance,allocatedBalance,currency,status,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt,version);

@override
String toString() {
  return 'LedgerAccount(id: $id, type: $type, name: $name, ownerId: $ownerId, balance: $balance, allocatedBalance: $allocatedBalance, currency: $currency, status: $status, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$LedgerAccountCopyWith<$Res> implements $LedgerAccountCopyWith<$Res> {
  factory _$LedgerAccountCopyWith(_LedgerAccount value, $Res Function(_LedgerAccount) _then) = __$LedgerAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, LedgerAccountType type, String name, String? ownerId, int balance, int allocatedBalance, String currency, LedgerAccountStatus status, Map<String, dynamic> metadata, DateTime createdAt, DateTime updatedAt, int version
});




}
/// @nodoc
class __$LedgerAccountCopyWithImpl<$Res>
    implements _$LedgerAccountCopyWith<$Res> {
  __$LedgerAccountCopyWithImpl(this._self, this._then);

  final _LedgerAccount _self;
  final $Res Function(_LedgerAccount) _then;

/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? name = null,Object? ownerId = freezed,Object? balance = null,Object? allocatedBalance = null,Object? currency = null,Object? status = null,Object? metadata = null,Object? createdAt = null,Object? updatedAt = null,Object? version = null,}) {
  return _then(_LedgerAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerAccountType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,allocatedBalance: null == allocatedBalance ? _self.allocatedBalance : allocatedBalance // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LedgerAccountStatus,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
