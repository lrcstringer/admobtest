// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarnThread {

 String get id;// Client fields (renamed from brand)
 String get clientId; String get clientName; String? get clientAvatarImage; String? get clientAvatarColor; String? get threadImage;// Thread display
 String get title; String? get description;// Flags
 bool get isPinned; bool get isFeatured; bool get isActive; bool get budgetExhausted;// Scheduling
 DateTime? get activeFrom; DateTime? get activeTo;// Token configuration
 String? get tokenSourceAccountId; String? get tokenDestAccountTypeId;// Counts
 int get availableOpportunities; int get completedOpportunities; int get completedUniqueUsers;// Timestamps
 DateTime get createdAt; DateTime? get lastActivityAt;// Targeting
 TargetingCriteria? get targeting;
/// Create a copy of EarnThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnThreadCopyWith<EarnThread> get copyWith => _$EarnThreadCopyWithImpl<EarnThread>(this as EarnThread, _$identity);

  /// Serializes this EarnThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnThread&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.activeFrom, activeFrom) || other.activeFrom == activeFrom)&&(identical(other.activeTo, activeTo) || other.activeTo == activeTo)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.tokenDestAccountTypeId, tokenDestAccountTypeId) || other.tokenDestAccountTypeId == tokenDestAccountTypeId)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities)&&(identical(other.completedOpportunities, completedOpportunities) || other.completedOpportunities == completedOpportunities)&&(identical(other.completedUniqueUsers, completedUniqueUsers) || other.completedUniqueUsers == completedUniqueUsers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&(identical(other.targeting, targeting) || other.targeting == targeting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,clientName,clientAvatarImage,clientAvatarColor,threadImage,title,description,isPinned,isFeatured,isActive,budgetExhausted,activeFrom,activeTo,tokenSourceAccountId,tokenDestAccountTypeId,availableOpportunities,completedOpportunities,completedUniqueUsers,createdAt,lastActivityAt,targeting]);

@override
String toString() {
  return 'EarnThread(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, threadImage: $threadImage, title: $title, description: $description, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, budgetExhausted: $budgetExhausted, activeFrom: $activeFrom, activeTo: $activeTo, tokenSourceAccountId: $tokenSourceAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, completedUniqueUsers: $completedUniqueUsers, createdAt: $createdAt, lastActivityAt: $lastActivityAt, targeting: $targeting)';
}


}

/// @nodoc
abstract mixin class $EarnThreadCopyWith<$Res>  {
  factory $EarnThreadCopyWith(EarnThread value, $Res Function(EarnThread) _then) = _$EarnThreadCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, String? threadImage, String title, String? description, bool isPinned, bool isFeatured, bool isActive, bool budgetExhausted, DateTime? activeFrom, DateTime? activeTo, String? tokenSourceAccountId, String? tokenDestAccountTypeId, int availableOpportunities, int completedOpportunities, int completedUniqueUsers, DateTime createdAt, DateTime? lastActivityAt, TargetingCriteria? targeting
});


$TargetingCriteriaCopyWith<$Res>? get targeting;

}
/// @nodoc
class _$EarnThreadCopyWithImpl<$Res>
    implements $EarnThreadCopyWith<$Res> {
  _$EarnThreadCopyWithImpl(this._self, this._then);

  final EarnThread _self;
  final $Res Function(EarnThread) _then;

/// Create a copy of EarnThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? threadImage = freezed,Object? title = null,Object? description = freezed,Object? isPinned = null,Object? isFeatured = null,Object? isActive = null,Object? budgetExhausted = null,Object? activeFrom = freezed,Object? activeTo = freezed,Object? tokenSourceAccountId = freezed,Object? tokenDestAccountTypeId = freezed,Object? availableOpportunities = null,Object? completedOpportunities = null,Object? completedUniqueUsers = null,Object? createdAt = null,Object? lastActivityAt = freezed,Object? targeting = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,budgetExhausted: null == budgetExhausted ? _self.budgetExhausted : budgetExhausted // ignore: cast_nullable_to_non_nullable
as bool,activeFrom: freezed == activeFrom ? _self.activeFrom : activeFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,activeTo: freezed == activeTo ? _self.activeTo : activeTo // ignore: cast_nullable_to_non_nullable
as DateTime?,tokenSourceAccountId: freezed == tokenSourceAccountId ? _self.tokenSourceAccountId : tokenSourceAccountId // ignore: cast_nullable_to_non_nullable
as String?,tokenDestAccountTypeId: freezed == tokenDestAccountTypeId ? _self.tokenDestAccountTypeId : tokenDestAccountTypeId // ignore: cast_nullable_to_non_nullable
as String?,availableOpportunities: null == availableOpportunities ? _self.availableOpportunities : availableOpportunities // ignore: cast_nullable_to_non_nullable
as int,completedOpportunities: null == completedOpportunities ? _self.completedOpportunities : completedOpportunities // ignore: cast_nullable_to_non_nullable
as int,completedUniqueUsers: null == completedUniqueUsers ? _self.completedUniqueUsers : completedUniqueUsers // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastActivityAt: freezed == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime?,targeting: freezed == targeting ? _self.targeting : targeting // ignore: cast_nullable_to_non_nullable
as TargetingCriteria?,
  ));
}
/// Create a copy of EarnThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetingCriteriaCopyWith<$Res>? get targeting {
    if (_self.targeting == null) {
    return null;
  }

  return $TargetingCriteriaCopyWith<$Res>(_self.targeting!, (value) {
    return _then(_self.copyWith(targeting: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarnThread].
extension EarnThreadPatterns on EarnThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnThread value)  $default,){
final _that = this;
switch (_that) {
case _EarnThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnThread value)?  $default,){
final _that = this;
switch (_that) {
case _EarnThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  String title,  String? description,  bool isPinned,  bool isFeatured,  bool isActive,  bool budgetExhausted,  DateTime? activeFrom,  DateTime? activeTo,  String? tokenSourceAccountId,  String? tokenDestAccountTypeId,  int availableOpportunities,  int completedOpportunities,  int completedUniqueUsers,  DateTime createdAt,  DateTime? lastActivityAt,  TargetingCriteria? targeting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnThread() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.title,_that.description,_that.isPinned,_that.isFeatured,_that.isActive,_that.budgetExhausted,_that.activeFrom,_that.activeTo,_that.tokenSourceAccountId,_that.tokenDestAccountTypeId,_that.availableOpportunities,_that.completedOpportunities,_that.completedUniqueUsers,_that.createdAt,_that.lastActivityAt,_that.targeting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  String title,  String? description,  bool isPinned,  bool isFeatured,  bool isActive,  bool budgetExhausted,  DateTime? activeFrom,  DateTime? activeTo,  String? tokenSourceAccountId,  String? tokenDestAccountTypeId,  int availableOpportunities,  int completedOpportunities,  int completedUniqueUsers,  DateTime createdAt,  DateTime? lastActivityAt,  TargetingCriteria? targeting)  $default,) {final _that = this;
switch (_that) {
case _EarnThread():
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.title,_that.description,_that.isPinned,_that.isFeatured,_that.isActive,_that.budgetExhausted,_that.activeFrom,_that.activeTo,_that.tokenSourceAccountId,_that.tokenDestAccountTypeId,_that.availableOpportunities,_that.completedOpportunities,_that.completedUniqueUsers,_that.createdAt,_that.lastActivityAt,_that.targeting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  String title,  String? description,  bool isPinned,  bool isFeatured,  bool isActive,  bool budgetExhausted,  DateTime? activeFrom,  DateTime? activeTo,  String? tokenSourceAccountId,  String? tokenDestAccountTypeId,  int availableOpportunities,  int completedOpportunities,  int completedUniqueUsers,  DateTime createdAt,  DateTime? lastActivityAt,  TargetingCriteria? targeting)?  $default,) {final _that = this;
switch (_that) {
case _EarnThread() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.title,_that.description,_that.isPinned,_that.isFeatured,_that.isActive,_that.budgetExhausted,_that.activeFrom,_that.activeTo,_that.tokenSourceAccountId,_that.tokenDestAccountTypeId,_that.availableOpportunities,_that.completedOpportunities,_that.completedUniqueUsers,_that.createdAt,_that.lastActivityAt,_that.targeting);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarnThread extends EarnThread {
  const _EarnThread({required this.id, required this.clientId, required this.clientName, this.clientAvatarImage, this.clientAvatarColor, this.threadImage, required this.title, this.description, required this.isPinned, required this.isFeatured, required this.isActive, this.budgetExhausted = false, this.activeFrom, this.activeTo, this.tokenSourceAccountId, this.tokenDestAccountTypeId, required this.availableOpportunities, required this.completedOpportunities, this.completedUniqueUsers = 0, required this.createdAt, this.lastActivityAt, this.targeting}): super._();
  factory _EarnThread.fromJson(Map<String, dynamic> json) => _$EarnThreadFromJson(json);

@override final  String id;
// Client fields (renamed from brand)
@override final  String clientId;
@override final  String clientName;
@override final  String? clientAvatarImage;
@override final  String? clientAvatarColor;
@override final  String? threadImage;
// Thread display
@override final  String title;
@override final  String? description;
// Flags
@override final  bool isPinned;
@override final  bool isFeatured;
@override final  bool isActive;
@override@JsonKey() final  bool budgetExhausted;
// Scheduling
@override final  DateTime? activeFrom;
@override final  DateTime? activeTo;
// Token configuration
@override final  String? tokenSourceAccountId;
@override final  String? tokenDestAccountTypeId;
// Counts
@override final  int availableOpportunities;
@override final  int completedOpportunities;
@override@JsonKey() final  int completedUniqueUsers;
// Timestamps
@override final  DateTime createdAt;
@override final  DateTime? lastActivityAt;
// Targeting
@override final  TargetingCriteria? targeting;

/// Create a copy of EarnThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnThreadCopyWith<_EarnThread> get copyWith => __$EarnThreadCopyWithImpl<_EarnThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarnThreadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnThread&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.activeFrom, activeFrom) || other.activeFrom == activeFrom)&&(identical(other.activeTo, activeTo) || other.activeTo == activeTo)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.tokenDestAccountTypeId, tokenDestAccountTypeId) || other.tokenDestAccountTypeId == tokenDestAccountTypeId)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities)&&(identical(other.completedOpportunities, completedOpportunities) || other.completedOpportunities == completedOpportunities)&&(identical(other.completedUniqueUsers, completedUniqueUsers) || other.completedUniqueUsers == completedUniqueUsers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&(identical(other.targeting, targeting) || other.targeting == targeting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,clientName,clientAvatarImage,clientAvatarColor,threadImage,title,description,isPinned,isFeatured,isActive,budgetExhausted,activeFrom,activeTo,tokenSourceAccountId,tokenDestAccountTypeId,availableOpportunities,completedOpportunities,completedUniqueUsers,createdAt,lastActivityAt,targeting]);

@override
String toString() {
  return 'EarnThread(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, threadImage: $threadImage, title: $title, description: $description, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, budgetExhausted: $budgetExhausted, activeFrom: $activeFrom, activeTo: $activeTo, tokenSourceAccountId: $tokenSourceAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, completedUniqueUsers: $completedUniqueUsers, createdAt: $createdAt, lastActivityAt: $lastActivityAt, targeting: $targeting)';
}


}

/// @nodoc
abstract mixin class _$EarnThreadCopyWith<$Res> implements $EarnThreadCopyWith<$Res> {
  factory _$EarnThreadCopyWith(_EarnThread value, $Res Function(_EarnThread) _then) = __$EarnThreadCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, String? threadImage, String title, String? description, bool isPinned, bool isFeatured, bool isActive, bool budgetExhausted, DateTime? activeFrom, DateTime? activeTo, String? tokenSourceAccountId, String? tokenDestAccountTypeId, int availableOpportunities, int completedOpportunities, int completedUniqueUsers, DateTime createdAt, DateTime? lastActivityAt, TargetingCriteria? targeting
});


@override $TargetingCriteriaCopyWith<$Res>? get targeting;

}
/// @nodoc
class __$EarnThreadCopyWithImpl<$Res>
    implements _$EarnThreadCopyWith<$Res> {
  __$EarnThreadCopyWithImpl(this._self, this._then);

  final _EarnThread _self;
  final $Res Function(_EarnThread) _then;

/// Create a copy of EarnThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? threadImage = freezed,Object? title = null,Object? description = freezed,Object? isPinned = null,Object? isFeatured = null,Object? isActive = null,Object? budgetExhausted = null,Object? activeFrom = freezed,Object? activeTo = freezed,Object? tokenSourceAccountId = freezed,Object? tokenDestAccountTypeId = freezed,Object? availableOpportunities = null,Object? completedOpportunities = null,Object? completedUniqueUsers = null,Object? createdAt = null,Object? lastActivityAt = freezed,Object? targeting = freezed,}) {
  return _then(_EarnThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,budgetExhausted: null == budgetExhausted ? _self.budgetExhausted : budgetExhausted // ignore: cast_nullable_to_non_nullable
as bool,activeFrom: freezed == activeFrom ? _self.activeFrom : activeFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,activeTo: freezed == activeTo ? _self.activeTo : activeTo // ignore: cast_nullable_to_non_nullable
as DateTime?,tokenSourceAccountId: freezed == tokenSourceAccountId ? _self.tokenSourceAccountId : tokenSourceAccountId // ignore: cast_nullable_to_non_nullable
as String?,tokenDestAccountTypeId: freezed == tokenDestAccountTypeId ? _self.tokenDestAccountTypeId : tokenDestAccountTypeId // ignore: cast_nullable_to_non_nullable
as String?,availableOpportunities: null == availableOpportunities ? _self.availableOpportunities : availableOpportunities // ignore: cast_nullable_to_non_nullable
as int,completedOpportunities: null == completedOpportunities ? _self.completedOpportunities : completedOpportunities // ignore: cast_nullable_to_non_nullable
as int,completedUniqueUsers: null == completedUniqueUsers ? _self.completedUniqueUsers : completedUniqueUsers // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastActivityAt: freezed == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime?,targeting: freezed == targeting ? _self.targeting : targeting // ignore: cast_nullable_to_non_nullable
as TargetingCriteria?,
  ));
}

/// Create a copy of EarnThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetingCriteriaCopyWith<$Res>? get targeting {
    if (_self.targeting == null) {
    return null;
  }

  return $TargetingCriteriaCopyWith<$Res>(_self.targeting!, (value) {
    return _then(_self.copyWith(targeting: value));
  });
}
}

// dart format on
