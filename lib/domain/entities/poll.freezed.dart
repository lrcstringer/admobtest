// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollOption {

 String get id; String get text;
/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionCopyWith<PollOption> get copyWith => _$PollOptionCopyWithImpl<PollOption>(this as PollOption, _$identity);

  /// Serializes this PollOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text);

@override
String toString() {
  return 'PollOption(id: $id, text: $text)';
}


}

/// @nodoc
abstract mixin class $PollOptionCopyWith<$Res>  {
  factory $PollOptionCopyWith(PollOption value, $Res Function(PollOption) _then) = _$PollOptionCopyWithImpl;
@useResult
$Res call({
 String id, String text
});




}
/// @nodoc
class _$PollOptionCopyWithImpl<$Res>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._self, this._then);

  final PollOption _self;
  final $Res Function(PollOption) _then;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PollOption].
extension PollOptionPatterns on PollOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOption value)  $default,){
final _that = this;
switch (_that) {
case _PollOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOption value)?  $default,){
final _that = this;
switch (_that) {
case _PollOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollOption() when $default != null:
return $default(_that.id,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text)  $default,) {final _that = this;
switch (_that) {
case _PollOption():
return $default(_that.id,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text)?  $default,) {final _that = this;
switch (_that) {
case _PollOption() when $default != null:
return $default(_that.id,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollOption implements PollOption {
  const _PollOption({required this.id, required this.text});
  factory _PollOption.fromJson(Map<String, dynamic> json) => _$PollOptionFromJson(json);

@override final  String id;
@override final  String text;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionCopyWith<_PollOption> get copyWith => __$PollOptionCopyWithImpl<_PollOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text);

@override
String toString() {
  return 'PollOption(id: $id, text: $text)';
}


}

/// @nodoc
abstract mixin class _$PollOptionCopyWith<$Res> implements $PollOptionCopyWith<$Res> {
  factory _$PollOptionCopyWith(_PollOption value, $Res Function(_PollOption) _then) = __$PollOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text
});




}
/// @nodoc
class __$PollOptionCopyWithImpl<$Res>
    implements _$PollOptionCopyWith<$Res> {
  __$PollOptionCopyWithImpl(this._self, this._then);

  final _PollOption _self;
  final $Res Function(_PollOption) _then;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,}) {
  return _then(_PollOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Poll {

 String get id; String get opportunityId; String get threadId; String get clientId; String get question; List<PollOption> get options; PollStatus get status; bool get isAnonymous; bool get showResultsAfterVote; bool get allowChangeVote; DateTime? get openedAt; DateTime? get closedAt; int get totalRespondents; Map<String, int> get optionCounts; DateTime get createdAt; DateTime? get updatedAt; String get createdBy;
/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollCopyWith<Poll> get copyWith => _$PollCopyWithImpl<Poll>(this as Poll, _$identity);

  /// Serializes this Poll to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Poll&&(identical(other.id, id) || other.id == id)&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.status, status) || other.status == status)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.showResultsAfterVote, showResultsAfterVote) || other.showResultsAfterVote == showResultsAfterVote)&&(identical(other.allowChangeVote, allowChangeVote) || other.allowChangeVote == allowChangeVote)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other.optionCounts, optionCounts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,opportunityId,threadId,clientId,question,const DeepCollectionEquality().hash(options),status,isAnonymous,showResultsAfterVote,allowChangeVote,openedAt,closedAt,totalRespondents,const DeepCollectionEquality().hash(optionCounts),createdAt,updatedAt,createdBy);

@override
String toString() {
  return 'Poll(id: $id, opportunityId: $opportunityId, threadId: $threadId, clientId: $clientId, question: $question, options: $options, status: $status, isAnonymous: $isAnonymous, showResultsAfterVote: $showResultsAfterVote, allowChangeVote: $allowChangeVote, openedAt: $openedAt, closedAt: $closedAt, totalRespondents: $totalRespondents, optionCounts: $optionCounts, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $PollCopyWith<$Res>  {
  factory $PollCopyWith(Poll value, $Res Function(Poll) _then) = _$PollCopyWithImpl;
@useResult
$Res call({
 String id, String opportunityId, String threadId, String clientId, String question, List<PollOption> options, PollStatus status, bool isAnonymous, bool showResultsAfterVote, bool allowChangeVote, DateTime? openedAt, DateTime? closedAt, int totalRespondents, Map<String, int> optionCounts, DateTime createdAt, DateTime? updatedAt, String createdBy
});




}
/// @nodoc
class _$PollCopyWithImpl<$Res>
    implements $PollCopyWith<$Res> {
  _$PollCopyWithImpl(this._self, this._then);

  final Poll _self;
  final $Res Function(Poll) _then;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? opportunityId = null,Object? threadId = null,Object? clientId = null,Object? question = null,Object? options = null,Object? status = null,Object? isAnonymous = null,Object? showResultsAfterVote = null,Object? allowChangeVote = null,Object? openedAt = freezed,Object? closedAt = freezed,Object? totalRespondents = null,Object? optionCounts = null,Object? createdAt = null,Object? updatedAt = freezed,Object? createdBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOption>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PollStatus,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,showResultsAfterVote: null == showResultsAfterVote ? _self.showResultsAfterVote : showResultsAfterVote // ignore: cast_nullable_to_non_nullable
as bool,allowChangeVote: null == allowChangeVote ? _self.allowChangeVote : allowChangeVote // ignore: cast_nullable_to_non_nullable
as bool,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self.optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Poll].
extension PollPatterns on Poll {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Poll value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Poll value)  $default,){
final _that = this;
switch (_that) {
case _Poll():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Poll value)?  $default,){
final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String opportunityId,  String threadId,  String clientId,  String question,  List<PollOption> options,  PollStatus status,  bool isAnonymous,  bool showResultsAfterVote,  bool allowChangeVote,  DateTime? openedAt,  DateTime? closedAt,  int totalRespondents,  Map<String, int> optionCounts,  DateTime createdAt,  DateTime? updatedAt,  String createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Poll() when $default != null:
return $default(_that.id,_that.opportunityId,_that.threadId,_that.clientId,_that.question,_that.options,_that.status,_that.isAnonymous,_that.showResultsAfterVote,_that.allowChangeVote,_that.openedAt,_that.closedAt,_that.totalRespondents,_that.optionCounts,_that.createdAt,_that.updatedAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String opportunityId,  String threadId,  String clientId,  String question,  List<PollOption> options,  PollStatus status,  bool isAnonymous,  bool showResultsAfterVote,  bool allowChangeVote,  DateTime? openedAt,  DateTime? closedAt,  int totalRespondents,  Map<String, int> optionCounts,  DateTime createdAt,  DateTime? updatedAt,  String createdBy)  $default,) {final _that = this;
switch (_that) {
case _Poll():
return $default(_that.id,_that.opportunityId,_that.threadId,_that.clientId,_that.question,_that.options,_that.status,_that.isAnonymous,_that.showResultsAfterVote,_that.allowChangeVote,_that.openedAt,_that.closedAt,_that.totalRespondents,_that.optionCounts,_that.createdAt,_that.updatedAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String opportunityId,  String threadId,  String clientId,  String question,  List<PollOption> options,  PollStatus status,  bool isAnonymous,  bool showResultsAfterVote,  bool allowChangeVote,  DateTime? openedAt,  DateTime? closedAt,  int totalRespondents,  Map<String, int> optionCounts,  DateTime createdAt,  DateTime? updatedAt,  String createdBy)?  $default,) {final _that = this;
switch (_that) {
case _Poll() when $default != null:
return $default(_that.id,_that.opportunityId,_that.threadId,_that.clientId,_that.question,_that.options,_that.status,_that.isAnonymous,_that.showResultsAfterVote,_that.allowChangeVote,_that.openedAt,_that.closedAt,_that.totalRespondents,_that.optionCounts,_that.createdAt,_that.updatedAt,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Poll extends Poll {
  const _Poll({required this.id, required this.opportunityId, required this.threadId, required this.clientId, required this.question, required final  List<PollOption> options, required this.status, this.isAnonymous = false, this.showResultsAfterVote = true, this.allowChangeVote = true, this.openedAt, this.closedAt, this.totalRespondents = 0, final  Map<String, int> optionCounts = const {}, required this.createdAt, this.updatedAt, required this.createdBy}): _options = options,_optionCounts = optionCounts,super._();
  factory _Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

@override final  String id;
@override final  String opportunityId;
@override final  String threadId;
@override final  String clientId;
@override final  String question;
 final  List<PollOption> _options;
@override List<PollOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  PollStatus status;
@override@JsonKey() final  bool isAnonymous;
@override@JsonKey() final  bool showResultsAfterVote;
@override@JsonKey() final  bool allowChangeVote;
@override final  DateTime? openedAt;
@override final  DateTime? closedAt;
@override@JsonKey() final  int totalRespondents;
 final  Map<String, int> _optionCounts;
@override@JsonKey() Map<String, int> get optionCounts {
  if (_optionCounts is EqualUnmodifiableMapView) return _optionCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionCounts);
}

@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  String createdBy;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollCopyWith<_Poll> get copyWith => __$PollCopyWithImpl<_Poll>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Poll&&(identical(other.id, id) || other.id == id)&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.status, status) || other.status == status)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.showResultsAfterVote, showResultsAfterVote) || other.showResultsAfterVote == showResultsAfterVote)&&(identical(other.allowChangeVote, allowChangeVote) || other.allowChangeVote == allowChangeVote)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other._optionCounts, _optionCounts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,opportunityId,threadId,clientId,question,const DeepCollectionEquality().hash(_options),status,isAnonymous,showResultsAfterVote,allowChangeVote,openedAt,closedAt,totalRespondents,const DeepCollectionEquality().hash(_optionCounts),createdAt,updatedAt,createdBy);

@override
String toString() {
  return 'Poll(id: $id, opportunityId: $opportunityId, threadId: $threadId, clientId: $clientId, question: $question, options: $options, status: $status, isAnonymous: $isAnonymous, showResultsAfterVote: $showResultsAfterVote, allowChangeVote: $allowChangeVote, openedAt: $openedAt, closedAt: $closedAt, totalRespondents: $totalRespondents, optionCounts: $optionCounts, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PollCopyWith<$Res> implements $PollCopyWith<$Res> {
  factory _$PollCopyWith(_Poll value, $Res Function(_Poll) _then) = __$PollCopyWithImpl;
@override @useResult
$Res call({
 String id, String opportunityId, String threadId, String clientId, String question, List<PollOption> options, PollStatus status, bool isAnonymous, bool showResultsAfterVote, bool allowChangeVote, DateTime? openedAt, DateTime? closedAt, int totalRespondents, Map<String, int> optionCounts, DateTime createdAt, DateTime? updatedAt, String createdBy
});




}
/// @nodoc
class __$PollCopyWithImpl<$Res>
    implements _$PollCopyWith<$Res> {
  __$PollCopyWithImpl(this._self, this._then);

  final _Poll _self;
  final $Res Function(_Poll) _then;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? opportunityId = null,Object? threadId = null,Object? clientId = null,Object? question = null,Object? options = null,Object? status = null,Object? isAnonymous = null,Object? showResultsAfterVote = null,Object? allowChangeVote = null,Object? openedAt = freezed,Object? closedAt = freezed,Object? totalRespondents = null,Object? optionCounts = null,Object? createdAt = null,Object? updatedAt = freezed,Object? createdBy = null,}) {
  return _then(_Poll(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOption>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PollStatus,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,showResultsAfterVote: null == showResultsAfterVote ? _self.showResultsAfterVote : showResultsAfterVote // ignore: cast_nullable_to_non_nullable
as bool,allowChangeVote: null == allowChangeVote ? _self.allowChangeVote : allowChangeVote // ignore: cast_nullable_to_non_nullable
as bool,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self._optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PollResponse {

 String get userId; String get pollId; String get selectedOption; String? get previousOption; int get voteCount; DateTime get respondedAt; DateTime? get updatedAt; String get status; DateTime? get invalidatedAt; String? get invalidatedBy; String? get invalidationReason; String? get engagementId; bool get tokensAwarded; Map<String, String?>? get demographics;
/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollResponseCopyWith<PollResponse> get copyWith => _$PollResponseCopyWithImpl<PollResponse>(this as PollResponse, _$identity);

  /// Serializes this PollResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollResponse&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&(identical(other.previousOption, previousOption) || other.previousOption == previousOption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.invalidatedAt, invalidatedAt) || other.invalidatedAt == invalidatedAt)&&(identical(other.invalidatedBy, invalidatedBy) || other.invalidatedBy == invalidatedBy)&&(identical(other.invalidationReason, invalidationReason) || other.invalidationReason == invalidationReason)&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&(identical(other.tokensAwarded, tokensAwarded) || other.tokensAwarded == tokensAwarded)&&const DeepCollectionEquality().equals(other.demographics, demographics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,pollId,selectedOption,previousOption,voteCount,respondedAt,updatedAt,status,invalidatedAt,invalidatedBy,invalidationReason,engagementId,tokensAwarded,const DeepCollectionEquality().hash(demographics));

@override
String toString() {
  return 'PollResponse(userId: $userId, pollId: $pollId, selectedOption: $selectedOption, previousOption: $previousOption, voteCount: $voteCount, respondedAt: $respondedAt, updatedAt: $updatedAt, status: $status, invalidatedAt: $invalidatedAt, invalidatedBy: $invalidatedBy, invalidationReason: $invalidationReason, engagementId: $engagementId, tokensAwarded: $tokensAwarded, demographics: $demographics)';
}


}

/// @nodoc
abstract mixin class $PollResponseCopyWith<$Res>  {
  factory $PollResponseCopyWith(PollResponse value, $Res Function(PollResponse) _then) = _$PollResponseCopyWithImpl;
@useResult
$Res call({
 String userId, String pollId, String selectedOption, String? previousOption, int voteCount, DateTime respondedAt, DateTime? updatedAt, String status, DateTime? invalidatedAt, String? invalidatedBy, String? invalidationReason, String? engagementId, bool tokensAwarded, Map<String, String?>? demographics
});




}
/// @nodoc
class _$PollResponseCopyWithImpl<$Res>
    implements $PollResponseCopyWith<$Res> {
  _$PollResponseCopyWithImpl(this._self, this._then);

  final PollResponse _self;
  final $Res Function(PollResponse) _then;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? pollId = null,Object? selectedOption = null,Object? previousOption = freezed,Object? voteCount = null,Object? respondedAt = null,Object? updatedAt = freezed,Object? status = null,Object? invalidatedAt = freezed,Object? invalidatedBy = freezed,Object? invalidationReason = freezed,Object? engagementId = freezed,Object? tokensAwarded = null,Object? demographics = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pollId: null == pollId ? _self.pollId : pollId // ignore: cast_nullable_to_non_nullable
as String,selectedOption: null == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String,previousOption: freezed == previousOption ? _self.previousOption : previousOption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,respondedAt: null == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,invalidatedAt: freezed == invalidatedAt ? _self.invalidatedAt : invalidatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invalidatedBy: freezed == invalidatedBy ? _self.invalidatedBy : invalidatedBy // ignore: cast_nullable_to_non_nullable
as String?,invalidationReason: freezed == invalidationReason ? _self.invalidationReason : invalidationReason // ignore: cast_nullable_to_non_nullable
as String?,engagementId: freezed == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String?,tokensAwarded: null == tokensAwarded ? _self.tokensAwarded : tokensAwarded // ignore: cast_nullable_to_non_nullable
as bool,demographics: freezed == demographics ? _self.demographics : demographics // ignore: cast_nullable_to_non_nullable
as Map<String, String?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PollResponse].
extension PollResponsePatterns on PollResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollResponse value)  $default,){
final _that = this;
switch (_that) {
case _PollResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String pollId,  String selectedOption,  String? previousOption,  int voteCount,  DateTime respondedAt,  DateTime? updatedAt,  String status,  DateTime? invalidatedAt,  String? invalidatedBy,  String? invalidationReason,  String? engagementId,  bool tokensAwarded,  Map<String, String?>? demographics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
return $default(_that.userId,_that.pollId,_that.selectedOption,_that.previousOption,_that.voteCount,_that.respondedAt,_that.updatedAt,_that.status,_that.invalidatedAt,_that.invalidatedBy,_that.invalidationReason,_that.engagementId,_that.tokensAwarded,_that.demographics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String pollId,  String selectedOption,  String? previousOption,  int voteCount,  DateTime respondedAt,  DateTime? updatedAt,  String status,  DateTime? invalidatedAt,  String? invalidatedBy,  String? invalidationReason,  String? engagementId,  bool tokensAwarded,  Map<String, String?>? demographics)  $default,) {final _that = this;
switch (_that) {
case _PollResponse():
return $default(_that.userId,_that.pollId,_that.selectedOption,_that.previousOption,_that.voteCount,_that.respondedAt,_that.updatedAt,_that.status,_that.invalidatedAt,_that.invalidatedBy,_that.invalidationReason,_that.engagementId,_that.tokensAwarded,_that.demographics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String pollId,  String selectedOption,  String? previousOption,  int voteCount,  DateTime respondedAt,  DateTime? updatedAt,  String status,  DateTime? invalidatedAt,  String? invalidatedBy,  String? invalidationReason,  String? engagementId,  bool tokensAwarded,  Map<String, String?>? demographics)?  $default,) {final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
return $default(_that.userId,_that.pollId,_that.selectedOption,_that.previousOption,_that.voteCount,_that.respondedAt,_that.updatedAt,_that.status,_that.invalidatedAt,_that.invalidatedBy,_that.invalidationReason,_that.engagementId,_that.tokensAwarded,_that.demographics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollResponse extends PollResponse {
  const _PollResponse({required this.userId, required this.pollId, required this.selectedOption, this.previousOption, this.voteCount = 1, required this.respondedAt, this.updatedAt, this.status = 'valid', this.invalidatedAt, this.invalidatedBy, this.invalidationReason, this.engagementId, this.tokensAwarded = false, final  Map<String, String?>? demographics}): _demographics = demographics,super._();
  factory _PollResponse.fromJson(Map<String, dynamic> json) => _$PollResponseFromJson(json);

@override final  String userId;
@override final  String pollId;
@override final  String selectedOption;
@override final  String? previousOption;
@override@JsonKey() final  int voteCount;
@override final  DateTime respondedAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  String status;
@override final  DateTime? invalidatedAt;
@override final  String? invalidatedBy;
@override final  String? invalidationReason;
@override final  String? engagementId;
@override@JsonKey() final  bool tokensAwarded;
 final  Map<String, String?>? _demographics;
@override Map<String, String?>? get demographics {
  final value = _demographics;
  if (value == null) return null;
  if (_demographics is EqualUnmodifiableMapView) return _demographics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollResponseCopyWith<_PollResponse> get copyWith => __$PollResponseCopyWithImpl<_PollResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollResponse&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pollId, pollId) || other.pollId == pollId)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&(identical(other.previousOption, previousOption) || other.previousOption == previousOption)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.invalidatedAt, invalidatedAt) || other.invalidatedAt == invalidatedAt)&&(identical(other.invalidatedBy, invalidatedBy) || other.invalidatedBy == invalidatedBy)&&(identical(other.invalidationReason, invalidationReason) || other.invalidationReason == invalidationReason)&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&(identical(other.tokensAwarded, tokensAwarded) || other.tokensAwarded == tokensAwarded)&&const DeepCollectionEquality().equals(other._demographics, _demographics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,pollId,selectedOption,previousOption,voteCount,respondedAt,updatedAt,status,invalidatedAt,invalidatedBy,invalidationReason,engagementId,tokensAwarded,const DeepCollectionEquality().hash(_demographics));

@override
String toString() {
  return 'PollResponse(userId: $userId, pollId: $pollId, selectedOption: $selectedOption, previousOption: $previousOption, voteCount: $voteCount, respondedAt: $respondedAt, updatedAt: $updatedAt, status: $status, invalidatedAt: $invalidatedAt, invalidatedBy: $invalidatedBy, invalidationReason: $invalidationReason, engagementId: $engagementId, tokensAwarded: $tokensAwarded, demographics: $demographics)';
}


}

/// @nodoc
abstract mixin class _$PollResponseCopyWith<$Res> implements $PollResponseCopyWith<$Res> {
  factory _$PollResponseCopyWith(_PollResponse value, $Res Function(_PollResponse) _then) = __$PollResponseCopyWithImpl;
@override @useResult
$Res call({
 String userId, String pollId, String selectedOption, String? previousOption, int voteCount, DateTime respondedAt, DateTime? updatedAt, String status, DateTime? invalidatedAt, String? invalidatedBy, String? invalidationReason, String? engagementId, bool tokensAwarded, Map<String, String?>? demographics
});




}
/// @nodoc
class __$PollResponseCopyWithImpl<$Res>
    implements _$PollResponseCopyWith<$Res> {
  __$PollResponseCopyWithImpl(this._self, this._then);

  final _PollResponse _self;
  final $Res Function(_PollResponse) _then;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? pollId = null,Object? selectedOption = null,Object? previousOption = freezed,Object? voteCount = null,Object? respondedAt = null,Object? updatedAt = freezed,Object? status = null,Object? invalidatedAt = freezed,Object? invalidatedBy = freezed,Object? invalidationReason = freezed,Object? engagementId = freezed,Object? tokensAwarded = null,Object? demographics = freezed,}) {
  return _then(_PollResponse(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pollId: null == pollId ? _self.pollId : pollId // ignore: cast_nullable_to_non_nullable
as String,selectedOption: null == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String,previousOption: freezed == previousOption ? _self.previousOption : previousOption // ignore: cast_nullable_to_non_nullable
as String?,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,respondedAt: null == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,invalidatedAt: freezed == invalidatedAt ? _self.invalidatedAt : invalidatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invalidatedBy: freezed == invalidatedBy ? _self.invalidatedBy : invalidatedBy // ignore: cast_nullable_to_non_nullable
as String?,invalidationReason: freezed == invalidationReason ? _self.invalidationReason : invalidationReason // ignore: cast_nullable_to_non_nullable
as String?,engagementId: freezed == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String?,tokensAwarded: null == tokensAwarded ? _self.tokensAwarded : tokensAwarded // ignore: cast_nullable_to_non_nullable
as bool,demographics: freezed == demographics ? _self._demographics : demographics // ignore: cast_nullable_to_non_nullable
as Map<String, String?>?,
  ));
}


}


/// @nodoc
mixin _$PollResults {

 int get totalRespondents; Map<String, int> get optionCounts; Map<String, double> get percentages;
/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollResultsCopyWith<PollResults> get copyWith => _$PollResultsCopyWithImpl<PollResults>(this as PollResults, _$identity);

  /// Serializes this PollResults to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollResults&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other.optionCounts, optionCounts)&&const DeepCollectionEquality().equals(other.percentages, percentages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRespondents,const DeepCollectionEquality().hash(optionCounts),const DeepCollectionEquality().hash(percentages));

@override
String toString() {
  return 'PollResults(totalRespondents: $totalRespondents, optionCounts: $optionCounts, percentages: $percentages)';
}


}

/// @nodoc
abstract mixin class $PollResultsCopyWith<$Res>  {
  factory $PollResultsCopyWith(PollResults value, $Res Function(PollResults) _then) = _$PollResultsCopyWithImpl;
@useResult
$Res call({
 int totalRespondents, Map<String, int> optionCounts, Map<String, double> percentages
});




}
/// @nodoc
class _$PollResultsCopyWithImpl<$Res>
    implements $PollResultsCopyWith<$Res> {
  _$PollResultsCopyWithImpl(this._self, this._then);

  final PollResults _self;
  final $Res Function(PollResults) _then;

/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRespondents = null,Object? optionCounts = null,Object? percentages = null,}) {
  return _then(_self.copyWith(
totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self.optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,percentages: null == percentages ? _self.percentages : percentages // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [PollResults].
extension PollResultsPatterns on PollResults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollResults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollResults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollResults value)  $default,){
final _that = this;
switch (_that) {
case _PollResults():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollResults value)?  $default,){
final _that = this;
switch (_that) {
case _PollResults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalRespondents,  Map<String, int> optionCounts,  Map<String, double> percentages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollResults() when $default != null:
return $default(_that.totalRespondents,_that.optionCounts,_that.percentages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalRespondents,  Map<String, int> optionCounts,  Map<String, double> percentages)  $default,) {final _that = this;
switch (_that) {
case _PollResults():
return $default(_that.totalRespondents,_that.optionCounts,_that.percentages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalRespondents,  Map<String, int> optionCounts,  Map<String, double> percentages)?  $default,) {final _that = this;
switch (_that) {
case _PollResults() when $default != null:
return $default(_that.totalRespondents,_that.optionCounts,_that.percentages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollResults implements PollResults {
  const _PollResults({required this.totalRespondents, required final  Map<String, int> optionCounts, required final  Map<String, double> percentages}): _optionCounts = optionCounts,_percentages = percentages;
  factory _PollResults.fromJson(Map<String, dynamic> json) => _$PollResultsFromJson(json);

@override final  int totalRespondents;
 final  Map<String, int> _optionCounts;
@override Map<String, int> get optionCounts {
  if (_optionCounts is EqualUnmodifiableMapView) return _optionCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionCounts);
}

 final  Map<String, double> _percentages;
@override Map<String, double> get percentages {
  if (_percentages is EqualUnmodifiableMapView) return _percentages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_percentages);
}


/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollResultsCopyWith<_PollResults> get copyWith => __$PollResultsCopyWithImpl<_PollResults>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollResultsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollResults&&(identical(other.totalRespondents, totalRespondents) || other.totalRespondents == totalRespondents)&&const DeepCollectionEquality().equals(other._optionCounts, _optionCounts)&&const DeepCollectionEquality().equals(other._percentages, _percentages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRespondents,const DeepCollectionEquality().hash(_optionCounts),const DeepCollectionEquality().hash(_percentages));

@override
String toString() {
  return 'PollResults(totalRespondents: $totalRespondents, optionCounts: $optionCounts, percentages: $percentages)';
}


}

/// @nodoc
abstract mixin class _$PollResultsCopyWith<$Res> implements $PollResultsCopyWith<$Res> {
  factory _$PollResultsCopyWith(_PollResults value, $Res Function(_PollResults) _then) = __$PollResultsCopyWithImpl;
@override @useResult
$Res call({
 int totalRespondents, Map<String, int> optionCounts, Map<String, double> percentages
});




}
/// @nodoc
class __$PollResultsCopyWithImpl<$Res>
    implements _$PollResultsCopyWith<$Res> {
  __$PollResultsCopyWithImpl(this._self, this._then);

  final _PollResults _self;
  final $Res Function(_PollResults) _then;

/// Create a copy of PollResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRespondents = null,Object? optionCounts = null,Object? percentages = null,}) {
  return _then(_PollResults(
totalRespondents: null == totalRespondents ? _self.totalRespondents : totalRespondents // ignore: cast_nullable_to_non_nullable
as int,optionCounts: null == optionCounts ? _self._optionCounts : optionCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,percentages: null == percentages ? _self._percentages : percentages // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
