// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_thread_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarnThreadModel {

 String get id;// Client fields
 String get clientId; String get clientName; String? get clientAvatarImage; String? get clientAvatarColor; String? get threadImage;// Thread display
 String get title; String? get description;// Flags
 bool get isPinned; bool get isFeatured; bool get isActive; bool get budgetExhausted;// Scheduling
 DateTime? get activeFrom; DateTime? get activeTo;// Token configuration
 String? get tokenSourceAccountId; String? get tokenDestAccountTypeId;// Counts
 int get availableOpportunities; int get completedOpportunities; int get completedUniqueUsers;// Timestamps
 DateTime get createdAt; DateTime? get lastActivityAt;// Targeting (stored as JSON map)
 Map<String, dynamic>? get targeting;
/// Create a copy of EarnThreadModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnThreadModelCopyWith<EarnThreadModel> get copyWith => _$EarnThreadModelCopyWithImpl<EarnThreadModel>(this as EarnThreadModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnThreadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.activeFrom, activeFrom) || other.activeFrom == activeFrom)&&(identical(other.activeTo, activeTo) || other.activeTo == activeTo)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.tokenDestAccountTypeId, tokenDestAccountTypeId) || other.tokenDestAccountTypeId == tokenDestAccountTypeId)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities)&&(identical(other.completedOpportunities, completedOpportunities) || other.completedOpportunities == completedOpportunities)&&(identical(other.completedUniqueUsers, completedUniqueUsers) || other.completedUniqueUsers == completedUniqueUsers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&const DeepCollectionEquality().equals(other.targeting, targeting));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,clientName,clientAvatarImage,clientAvatarColor,threadImage,title,description,isPinned,isFeatured,isActive,budgetExhausted,activeFrom,activeTo,tokenSourceAccountId,tokenDestAccountTypeId,availableOpportunities,completedOpportunities,completedUniqueUsers,createdAt,lastActivityAt,const DeepCollectionEquality().hash(targeting)]);

@override
String toString() {
  return 'EarnThreadModel(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, threadImage: $threadImage, title: $title, description: $description, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, budgetExhausted: $budgetExhausted, activeFrom: $activeFrom, activeTo: $activeTo, tokenSourceAccountId: $tokenSourceAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, completedUniqueUsers: $completedUniqueUsers, createdAt: $createdAt, lastActivityAt: $lastActivityAt, targeting: $targeting)';
}


}

/// @nodoc
abstract mixin class $EarnThreadModelCopyWith<$Res>  {
  factory $EarnThreadModelCopyWith(EarnThreadModel value, $Res Function(EarnThreadModel) _then) = _$EarnThreadModelCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, String? threadImage, String title, String? description, bool isPinned, bool isFeatured, bool isActive, bool budgetExhausted, DateTime? activeFrom, DateTime? activeTo, String? tokenSourceAccountId, String? tokenDestAccountTypeId, int availableOpportunities, int completedOpportunities, int completedUniqueUsers, DateTime createdAt, DateTime? lastActivityAt, Map<String, dynamic>? targeting
});




}
/// @nodoc
class _$EarnThreadModelCopyWithImpl<$Res>
    implements $EarnThreadModelCopyWith<$Res> {
  _$EarnThreadModelCopyWithImpl(this._self, this._then);

  final EarnThreadModel _self;
  final $Res Function(EarnThreadModel) _then;

/// Create a copy of EarnThreadModel
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
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnThreadModel].
extension EarnThreadModelPatterns on EarnThreadModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnThreadModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnThreadModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnThreadModel value)  $default,){
final _that = this;
switch (_that) {
case _EarnThreadModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnThreadModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarnThreadModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  String title,  String? description,  bool isPinned,  bool isFeatured,  bool isActive,  bool budgetExhausted,  DateTime? activeFrom,  DateTime? activeTo,  String? tokenSourceAccountId,  String? tokenDestAccountTypeId,  int availableOpportunities,  int completedOpportunities,  int completedUniqueUsers,  DateTime createdAt,  DateTime? lastActivityAt,  Map<String, dynamic>? targeting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnThreadModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  String title,  String? description,  bool isPinned,  bool isFeatured,  bool isActive,  bool budgetExhausted,  DateTime? activeFrom,  DateTime? activeTo,  String? tokenSourceAccountId,  String? tokenDestAccountTypeId,  int availableOpportunities,  int completedOpportunities,  int completedUniqueUsers,  DateTime createdAt,  DateTime? lastActivityAt,  Map<String, dynamic>? targeting)  $default,) {final _that = this;
switch (_that) {
case _EarnThreadModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  String title,  String? description,  bool isPinned,  bool isFeatured,  bool isActive,  bool budgetExhausted,  DateTime? activeFrom,  DateTime? activeTo,  String? tokenSourceAccountId,  String? tokenDestAccountTypeId,  int availableOpportunities,  int completedOpportunities,  int completedUniqueUsers,  DateTime createdAt,  DateTime? lastActivityAt,  Map<String, dynamic>? targeting)?  $default,) {final _that = this;
switch (_that) {
case _EarnThreadModel() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.title,_that.description,_that.isPinned,_that.isFeatured,_that.isActive,_that.budgetExhausted,_that.activeFrom,_that.activeTo,_that.tokenSourceAccountId,_that.tokenDestAccountTypeId,_that.availableOpportunities,_that.completedOpportunities,_that.completedUniqueUsers,_that.createdAt,_that.lastActivityAt,_that.targeting);case _:
  return null;

}
}

}

/// @nodoc


class _EarnThreadModel extends EarnThreadModel {
  const _EarnThreadModel({required this.id, required this.clientId, required this.clientName, this.clientAvatarImage, this.clientAvatarColor, this.threadImage, required this.title, this.description, required this.isPinned, required this.isFeatured, required this.isActive, this.budgetExhausted = false, this.activeFrom, this.activeTo, this.tokenSourceAccountId, this.tokenDestAccountTypeId, required this.availableOpportunities, required this.completedOpportunities, this.completedUniqueUsers = 0, required this.createdAt, this.lastActivityAt, final  Map<String, dynamic>? targeting}): _targeting = targeting,super._();
  

@override final  String id;
// Client fields
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
// Targeting (stored as JSON map)
 final  Map<String, dynamic>? _targeting;
// Targeting (stored as JSON map)
@override Map<String, dynamic>? get targeting {
  final value = _targeting;
  if (value == null) return null;
  if (_targeting is EqualUnmodifiableMapView) return _targeting;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of EarnThreadModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnThreadModelCopyWith<_EarnThreadModel> get copyWith => __$EarnThreadModelCopyWithImpl<_EarnThreadModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnThreadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.budgetExhausted, budgetExhausted) || other.budgetExhausted == budgetExhausted)&&(identical(other.activeFrom, activeFrom) || other.activeFrom == activeFrom)&&(identical(other.activeTo, activeTo) || other.activeTo == activeTo)&&(identical(other.tokenSourceAccountId, tokenSourceAccountId) || other.tokenSourceAccountId == tokenSourceAccountId)&&(identical(other.tokenDestAccountTypeId, tokenDestAccountTypeId) || other.tokenDestAccountTypeId == tokenDestAccountTypeId)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities)&&(identical(other.completedOpportunities, completedOpportunities) || other.completedOpportunities == completedOpportunities)&&(identical(other.completedUniqueUsers, completedUniqueUsers) || other.completedUniqueUsers == completedUniqueUsers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&const DeepCollectionEquality().equals(other._targeting, _targeting));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,clientName,clientAvatarImage,clientAvatarColor,threadImage,title,description,isPinned,isFeatured,isActive,budgetExhausted,activeFrom,activeTo,tokenSourceAccountId,tokenDestAccountTypeId,availableOpportunities,completedOpportunities,completedUniqueUsers,createdAt,lastActivityAt,const DeepCollectionEquality().hash(_targeting)]);

@override
String toString() {
  return 'EarnThreadModel(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, threadImage: $threadImage, title: $title, description: $description, isPinned: $isPinned, isFeatured: $isFeatured, isActive: $isActive, budgetExhausted: $budgetExhausted, activeFrom: $activeFrom, activeTo: $activeTo, tokenSourceAccountId: $tokenSourceAccountId, tokenDestAccountTypeId: $tokenDestAccountTypeId, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, completedUniqueUsers: $completedUniqueUsers, createdAt: $createdAt, lastActivityAt: $lastActivityAt, targeting: $targeting)';
}


}

/// @nodoc
abstract mixin class _$EarnThreadModelCopyWith<$Res> implements $EarnThreadModelCopyWith<$Res> {
  factory _$EarnThreadModelCopyWith(_EarnThreadModel value, $Res Function(_EarnThreadModel) _then) = __$EarnThreadModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, String? threadImage, String title, String? description, bool isPinned, bool isFeatured, bool isActive, bool budgetExhausted, DateTime? activeFrom, DateTime? activeTo, String? tokenSourceAccountId, String? tokenDestAccountTypeId, int availableOpportunities, int completedOpportunities, int completedUniqueUsers, DateTime createdAt, DateTime? lastActivityAt, Map<String, dynamic>? targeting
});




}
/// @nodoc
class __$EarnThreadModelCopyWithImpl<$Res>
    implements _$EarnThreadModelCopyWith<$Res> {
  __$EarnThreadModelCopyWithImpl(this._self, this._then);

  final _EarnThreadModel _self;
  final $Res Function(_EarnThreadModel) _then;

/// Create a copy of EarnThreadModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? threadImage = freezed,Object? title = null,Object? description = freezed,Object? isPinned = null,Object? isFeatured = null,Object? isActive = null,Object? budgetExhausted = null,Object? activeFrom = freezed,Object? activeTo = freezed,Object? tokenSourceAccountId = freezed,Object? tokenDestAccountTypeId = freezed,Object? availableOpportunities = null,Object? completedOpportunities = null,Object? completedUniqueUsers = null,Object? createdAt = null,Object? lastActivityAt = freezed,Object? targeting = freezed,}) {
  return _then(_EarnThreadModel(
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
as DateTime?,targeting: freezed == targeting ? _self._targeting : targeting // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
